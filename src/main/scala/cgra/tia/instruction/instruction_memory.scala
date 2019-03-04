package cgra.tia.instruction

import cgra.common.mmio.mmio_if
import chisel3._
import chisel3.iotesters.PeekPokeTester
import chisel3.util._
import cgra.tia.control._
import cgra.tia.mmio._
import cgra.tia.parameters.derived_parameters._

class instruction_memory extends Module
  with inst_util{
  val io = IO(new Bundle{
    val enable = Input(Bool())
    val host_interface = new mmio_if
    val triggers = Vec(TIA_MAX_NUM_INSTRUCTIONS,Output(new trigger_t))
    val triggered_instruction_valid = Input(Bool())
    val triggered_instruction_index = Input(UInt(TIA_INSTRUCTION_INDEX_WIDTH.W))
    val triggered_datapath_instruction = Output(new datapath_instruction_t)
  })

  val mm_instruction = VecInit(Seq.fill(TIA_MAX_NUM_INSTRUCTIONS){Module(new mm_instruction).io })

  val instruction_write_index = Wire(UInt(TIA_INSTRUCTION_INDEX_WIDTH.W))
  val word_write_index = Wire(UInt(log2Ceil(TIA_MM_INSTRUCTION_WIDTH / TIA_MMIO_DATA_WIDTH).W))

  for (i <- 0 until TIA_MAX_NUM_INSTRUCTIONS){
    io.triggers(i).vi := mm_instruction(i).read.vi
    io.triggers(i).ptm := mm_instruction(i).read.ptm
    io.triggers(i).ici := mm_instruction(i).read.ici
    io.triggers(i).ictb := mm_instruction(i).read.ictb
    io.triggers(i).ictv := mm_instruction(i).read.ictv
    io.triggers(i).oci := mm_instruction(i).read.oci
  }

  // high bits are instruction's index
  instruction_write_index :=
    io.host_interface.write_index >> log2Ceil(TIA_MM_INSTRUCTION_WIDTH / TIA_MMIO_DATA_WIDTH)
  // low bits are word's index
  word_write_index :=
    io.host_interface.write_index(log2Ceil(TIA_MM_INSTRUCTION_WIDTH / TIA_MMIO_DATA_WIDTH)-1,0)

  // write only, read from instruction memory is not allowed
  io.host_interface.read_data := 0.U
  io.host_interface.read_ack := io.host_interface.read_req

  // write request can be satisfied immediately
  io.host_interface.write_ack := io.host_interface.write_req

  // default
  io.triggered_datapath_instruction := Module(new zero_mm_instruction).io
  // trigger one instruction
  when(io.triggered_instruction_valid){
    io.triggered_datapath_instruction := mm_instruction(io.triggered_instruction_index).read
  }

  // read instruction from mm_instruction
  val read_instruction = Wire(UInt(TIA_MM_INSTRUCTION_WIDTH.W))
  read_instruction := 0.U // default

  // break instruction into words and update with the incoming data from host interface
  val instruction_words = Wire(Vec(log2Ceil(TIA_MM_INSTRUCTION_WIDTH / TIA_MMIO_DATA_WIDTH),UInt(TIA_MMIO_DATA_WIDTH.W)))
  for (i <- 0 until log2Ceil(TIA_MM_INSTRUCTION_WIDTH / TIA_MMIO_DATA_WIDTH)){
    instruction_words(i) := 0.U // default
  }
  val updated_instruction = Wire(UInt(TIA_MM_INSTRUCTION_WIDTH.W))
  updated_instruction := instruction_words.reduceLeft(Cat(_,_))

  // connect enable
  for (i <- 0 until TIA_MAX_NUM_INSTRUCTIONS){
    mm_instruction(i).enable := io.enable && io.host_interface.write_req && i.U === instruction_write_index
  }

  // connect when enable
  when(io.enable && io.host_interface.write_req){
    read_instruction := cat_inst_asOne(mm_instruction(instruction_write_index).read)
    for (index_w <- 0 until log2Ceil(TIA_MM_INSTRUCTION_WIDTH / TIA_MMIO_DATA_WIDTH)){
      // Here we update the instruction words with the incomming word from interface
      instruction_words(index_w) := Mux(index_w.U === word_write_index,
        io.host_interface.write_data,
        read_instruction(TIA_MMIO_DATA_WIDTH * (index_w+1)-1,TIA_MMIO_DATA_WIDTH * index_w))
    }
    for (index_i <- 0 until TIA_MAX_NUM_INSTRUCTIONS){
      mm_instruction(index_i).write := Mux(index_i.U === instruction_write_index,
        updated_instruction,
        0.U)
    }
  }.otherwise{
    for (index_i <- 0 until TIA_MAX_NUM_INSTRUCTIONS){
      mm_instruction(index_i).write := 0.U
    }
  }
}

object instM_Driver extends App {
  chisel3.Driver.execute(args, () => new instruction_memory)
}