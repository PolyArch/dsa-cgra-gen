module VectorPort_Hw(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_0_config,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_0_config,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_2_config
);
  reg [1:0] distribute_counter; // @[VectorPort_Hw.scala 25:35]
  reg [31:0] _RAND_0;
  reg  vector_registers_0_valid; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_1;
  reg [63:0] vector_registers_0_bits; // @[VectorPort_Hw.scala 26:29]
  reg [63:0] _RAND_2;
  reg  vector_registers_0_ready; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_3;
  reg  vector_registers_0_config; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_4;
  reg  vector_registers_1_valid; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_5;
  reg [63:0] vector_registers_1_bits; // @[VectorPort_Hw.scala 26:29]
  reg [63:0] _RAND_6;
  reg  vector_registers_1_ready; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_7;
  reg  vector_registers_2_valid; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_8;
  reg [63:0] vector_registers_2_bits; // @[VectorPort_Hw.scala 26:29]
  reg [63:0] _RAND_9;
  reg  vector_registers_2_ready; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_10;
  reg  vector_registers_2_config; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_11;
  wire  _GEN_9; // @[VectorPort_Hw.scala 32:42]
  wire [1:0] _T_1; // @[VectorPort_Hw.scala 40:44]
  assign _GEN_9 = 2'h1 == distribute_counter ? vector_registers_1_ready : vector_registers_0_ready; // @[VectorPort_Hw.scala 32:42]
  assign _T_1 = distribute_counter + 2'h1; // @[VectorPort_Hw.scala 40:44]
  assign io_in_0_ready = 2'h2 == distribute_counter ? vector_registers_2_ready : _GEN_9; // @[VectorPort_Hw.scala 32:42]
  assign io_out_0_valid = vector_registers_0_valid; // @[VectorPort_Hw.scala 31:17]
  assign io_out_0_bits = vector_registers_0_bits; // @[VectorPort_Hw.scala 31:17]
  assign io_out_0_config = vector_registers_0_config; // @[VectorPort_Hw.scala 31:17]
  assign io_out_1_valid = vector_registers_1_valid; // @[VectorPort_Hw.scala 31:17]
  assign io_out_1_bits = vector_registers_1_bits; // @[VectorPort_Hw.scala 31:17]
  assign io_out_2_valid = vector_registers_2_valid; // @[VectorPort_Hw.scala 31:17]
  assign io_out_2_bits = vector_registers_2_bits; // @[VectorPort_Hw.scala 31:17]
  assign io_out_2_config = vector_registers_2_config; // @[VectorPort_Hw.scala 31:17]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  distribute_counter = _RAND_0[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  vector_registers_0_valid = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {2{`RANDOM}};
  vector_registers_0_bits = _RAND_2[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  vector_registers_0_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  vector_registers_0_config = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  vector_registers_1_valid = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {2{`RANDOM}};
  vector_registers_1_bits = _RAND_6[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  vector_registers_1_ready = _RAND_7[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  vector_registers_2_valid = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {2{`RANDOM}};
  vector_registers_2_bits = _RAND_9[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  vector_registers_2_ready = _RAND_10[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  vector_registers_2_config = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (reset) begin
      distribute_counter <= 2'h0;
    end else begin
      distribute_counter <= _T_1;
    end
    if (2'h0 == distribute_counter) begin
      vector_registers_0_valid <= io_in_0_valid;
    end
    if (2'h0 == distribute_counter) begin
      vector_registers_0_bits <= io_in_0_bits;
    end
    vector_registers_0_ready <= io_out_0_ready;
    if (2'h0 == distribute_counter) begin
      vector_registers_0_config <= io_in_0_config;
    end
    if (2'h1 == distribute_counter) begin
      vector_registers_1_valid <= io_in_0_valid;
    end
    if (2'h1 == distribute_counter) begin
      vector_registers_1_bits <= io_in_0_bits;
    end
    vector_registers_1_ready <= io_out_1_ready;
    if (2'h2 == distribute_counter) begin
      vector_registers_2_valid <= io_in_0_valid;
    end
    if (2'h2 == distribute_counter) begin
      vector_registers_2_bits <= io_in_0_bits;
    end
    vector_registers_2_ready <= io_out_2_ready;
    if (2'h2 == distribute_counter) begin
      vector_registers_2_config <= io_in_0_config;
    end
  end
endmodule
module VectorPort_Hw_2(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready
);
  reg [1:0] distribute_counter; // @[VectorPort_Hw.scala 25:35]
  reg [31:0] _RAND_0;
  reg  vector_registers_0_valid; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_1;
  reg [63:0] vector_registers_0_bits; // @[VectorPort_Hw.scala 26:29]
  reg [63:0] _RAND_2;
  reg  vector_registers_0_ready; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_3;
  reg  vector_registers_1_valid; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_4;
  reg [63:0] vector_registers_1_bits; // @[VectorPort_Hw.scala 26:29]
  reg [63:0] _RAND_5;
  reg  vector_registers_1_ready; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_6;
  reg  vector_registers_2_valid; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_7;
  reg [63:0] vector_registers_2_bits; // @[VectorPort_Hw.scala 26:29]
  reg [63:0] _RAND_8;
  reg  vector_registers_2_ready; // @[VectorPort_Hw.scala 26:29]
  reg [31:0] _RAND_9;
  wire  _GEN_4; // @[VectorPort_Hw.scala 37:17]
  wire [63:0] _GEN_5; // @[VectorPort_Hw.scala 37:17]
  wire [1:0] _T_1; // @[VectorPort_Hw.scala 40:44]
  assign _GEN_4 = 2'h1 == distribute_counter ? vector_registers_1_valid : vector_registers_0_valid; // @[VectorPort_Hw.scala 37:17]
  assign _GEN_5 = 2'h1 == distribute_counter ? vector_registers_1_bits : vector_registers_0_bits; // @[VectorPort_Hw.scala 37:17]
  assign _T_1 = distribute_counter + 2'h1; // @[VectorPort_Hw.scala 40:44]
  assign io_in_0_ready = vector_registers_0_ready; // @[VectorPort_Hw.scala 36:27]
  assign io_in_1_ready = vector_registers_1_ready; // @[VectorPort_Hw.scala 36:27]
  assign io_in_2_ready = vector_registers_2_ready; // @[VectorPort_Hw.scala 36:27]
  assign io_out_0_valid = 2'h2 == distribute_counter ? vector_registers_2_valid : _GEN_4; // @[VectorPort_Hw.scala 37:17]
  assign io_out_0_bits = 2'h2 == distribute_counter ? vector_registers_2_bits : _GEN_5; // @[VectorPort_Hw.scala 37:17]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  distribute_counter = _RAND_0[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  vector_registers_0_valid = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {2{`RANDOM}};
  vector_registers_0_bits = _RAND_2[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  vector_registers_0_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  vector_registers_1_valid = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {2{`RANDOM}};
  vector_registers_1_bits = _RAND_5[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  vector_registers_1_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  vector_registers_2_valid = _RAND_7[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {2{`RANDOM}};
  vector_registers_2_bits = _RAND_8[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  vector_registers_2_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (reset) begin
      distribute_counter <= 2'h0;
    end else begin
      distribute_counter <= _T_1;
    end
    vector_registers_0_valid <= io_in_0_valid;
    vector_registers_0_bits <= io_in_0_bits;
    if (2'h0 == distribute_counter) begin
      vector_registers_0_ready <= io_out_0_ready;
    end
    vector_registers_1_valid <= io_in_1_valid;
    vector_registers_1_bits <= io_in_1_bits;
    if (2'h1 == distribute_counter) begin
      vector_registers_1_ready <= io_out_0_ready;
    end
    vector_registers_2_valid <= io_in_2_valid;
    vector_registers_2_bits <= io_in_2_bits;
    if (2'h2 == distribute_counter) begin
      vector_registers_2_ready <= io_out_0_ready;
    end
  end
endmodule
module Router_Hw(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  input         io_in_3_config,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready,
  output        io_out_4_valid,
  output [63:0] io_out_4_bits,
  input         io_out_4_ready,
  output        io_out_4_config
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_5; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_6; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_8; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_9; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [63:0] _T_11; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_7;
  reg  _T_12; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_8;
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_9;
  reg [63:0] _T_14; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_10;
  reg  _T_15; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_11;
  reg  decomposed_output_ports_0_4_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_12;
  reg [63:0] _T_17; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_13;
  reg  _T_18; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_14;
  reg [9:0] config_register_file_0; // @[Router_Hw.scala 140:37]
  reg [31:0] _RAND_15;
  wire [1:0] _T_166; // @[Router_Hw.scala 113:22]
  wire  _T_167; // @[Router_Hw.scala 113:53]
  wire  _T_168; // @[Router_Hw.scala 113:10]
  wire [1:0] _T_169; // @[Router_Hw.scala 113:22]
  wire  _T_170; // @[Router_Hw.scala 113:53]
  wire  _T_171; // @[Router_Hw.scala 113:10]
  wire  _T_181; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_172; // @[Router_Hw.scala 113:22]
  wire  _T_173; // @[Router_Hw.scala 113:53]
  wire  _T_174; // @[Router_Hw.scala 113:10]
  wire  _T_182; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_175; // @[Router_Hw.scala 113:22]
  wire  _T_176; // @[Router_Hw.scala 113:53]
  wire  _T_177; // @[Router_Hw.scala 113:10]
  wire  _T_183; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_178; // @[Router_Hw.scala 113:22]
  wire  _T_179; // @[Router_Hw.scala 113:53]
  wire  _T_180; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_3_ready; // @[Router_Hw.scala 116:99]
  wire  _T_20; // @[Mux.scala 69:19]
  wire  _T_22; // @[Mux.scala 69:19]
  wire  _T_24; // @[Mux.scala 69:19]
  wire  _T_26; // @[Mux.scala 69:19]
  wire  _T_38; // @[Mux.scala 69:19]
  wire  _T_40; // @[Mux.scala 69:19]
  wire  _T_42; // @[Mux.scala 69:19]
  wire  _T_44; // @[Mux.scala 69:19]
  wire  _T_56; // @[Mux.scala 69:19]
  wire  _T_58; // @[Mux.scala 69:19]
  wire  _T_60; // @[Mux.scala 69:19]
  wire  _T_62; // @[Mux.scala 69:19]
  wire  _T_74; // @[Mux.scala 69:19]
  wire  _T_76; // @[Mux.scala 69:19]
  wire  _T_78; // @[Mux.scala 69:19]
  wire  _T_80; // @[Mux.scala 69:19]
  wire  _T_92; // @[Mux.scala 69:19]
  wire  _T_94; // @[Mux.scala 69:19]
  wire  _T_96; // @[Mux.scala 69:19]
  wire  _T_98; // @[Mux.scala 69:19]
  wire  _T_110; // @[Router_Hw.scala 113:53]
  wire  _T_111; // @[Router_Hw.scala 113:10]
  wire  _T_113; // @[Router_Hw.scala 113:53]
  wire  _T_114; // @[Router_Hw.scala 113:10]
  wire  _T_116; // @[Router_Hw.scala 113:53]
  wire  _T_117; // @[Router_Hw.scala 113:10]
  wire  _T_119; // @[Router_Hw.scala 113:53]
  wire  _T_120; // @[Router_Hw.scala 113:10]
  wire  _T_122; // @[Router_Hw.scala 113:53]
  wire  _T_123; // @[Router_Hw.scala 113:10]
  wire  _T_124; // @[Router_Hw.scala 116:99]
  wire  _T_125; // @[Router_Hw.scala 116:99]
  wire  _T_126; // @[Router_Hw.scala 116:99]
  wire  _T_129; // @[Router_Hw.scala 113:53]
  wire  _T_130; // @[Router_Hw.scala 113:10]
  wire  _T_132; // @[Router_Hw.scala 113:53]
  wire  _T_133; // @[Router_Hw.scala 113:10]
  wire  _T_135; // @[Router_Hw.scala 113:53]
  wire  _T_136; // @[Router_Hw.scala 113:10]
  wire  _T_138; // @[Router_Hw.scala 113:53]
  wire  _T_139; // @[Router_Hw.scala 113:10]
  wire  _T_141; // @[Router_Hw.scala 113:53]
  wire  _T_142; // @[Router_Hw.scala 113:10]
  wire  _T_143; // @[Router_Hw.scala 116:99]
  wire  _T_144; // @[Router_Hw.scala 116:99]
  wire  _T_145; // @[Router_Hw.scala 116:99]
  wire  _T_148; // @[Router_Hw.scala 113:53]
  wire  _T_149; // @[Router_Hw.scala 113:10]
  wire  _T_151; // @[Router_Hw.scala 113:53]
  wire  _T_152; // @[Router_Hw.scala 113:10]
  wire  _T_154; // @[Router_Hw.scala 113:53]
  wire  _T_155; // @[Router_Hw.scala 113:10]
  wire  _T_157; // @[Router_Hw.scala 113:53]
  wire  _T_158; // @[Router_Hw.scala 113:10]
  wire  _T_160; // @[Router_Hw.scala 113:53]
  wire  _T_161; // @[Router_Hw.scala 113:10]
  wire  _T_162; // @[Router_Hw.scala 116:99]
  wire  _T_163; // @[Router_Hw.scala 116:99]
  wire  _T_164; // @[Router_Hw.scala 116:99]
  wire [4:0] config_module_id; // @[Router_Hw.scala 148:44]
  wire  module_id_match; // @[Router_Hw.scala 149:49]
  wire [9:0] config_data; // @[Router_Hw.scala 151:39]
  wire  _T_187; // @[Router_Hw.scala 152:22]
  assign _T_166 = config_register_file_0[1:0]; // @[Router_Hw.scala 113:22]
  assign _T_167 = _T_166 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_168 = _T_167 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_169 = config_register_file_0[3:2]; // @[Router_Hw.scala 113:22]
  assign _T_170 = _T_169 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_171 = _T_170 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_181 = _T_168 & _T_171; // @[Router_Hw.scala 116:99]
  assign _T_172 = config_register_file_0[5:4]; // @[Router_Hw.scala 113:22]
  assign _T_173 = _T_172 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_174 = _T_173 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_182 = _T_181 & _T_174; // @[Router_Hw.scala 116:99]
  assign _T_175 = config_register_file_0[7:6]; // @[Router_Hw.scala 113:22]
  assign _T_176 = _T_175 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_177 = _T_176 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_183 = _T_182 & _T_177; // @[Router_Hw.scala 116:99]
  assign _T_178 = config_register_file_0[9:8]; // @[Router_Hw.scala 113:22]
  assign _T_179 = _T_178 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_180 = _T_179 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_3_ready = _T_183 & _T_180; // @[Router_Hw.scala 116:99]
  assign _T_20 = 2'h3 == _T_166; // @[Mux.scala 69:19]
  assign _T_22 = 2'h2 == _T_166; // @[Mux.scala 69:19]
  assign _T_24 = 2'h1 == _T_166; // @[Mux.scala 69:19]
  assign _T_26 = 2'h0 == _T_166; // @[Mux.scala 69:19]
  assign _T_38 = 2'h3 == _T_169; // @[Mux.scala 69:19]
  assign _T_40 = 2'h2 == _T_169; // @[Mux.scala 69:19]
  assign _T_42 = 2'h1 == _T_169; // @[Mux.scala 69:19]
  assign _T_44 = 2'h0 == _T_169; // @[Mux.scala 69:19]
  assign _T_56 = 2'h3 == _T_172; // @[Mux.scala 69:19]
  assign _T_58 = 2'h2 == _T_172; // @[Mux.scala 69:19]
  assign _T_60 = 2'h1 == _T_172; // @[Mux.scala 69:19]
  assign _T_62 = 2'h0 == _T_172; // @[Mux.scala 69:19]
  assign _T_74 = 2'h3 == _T_175; // @[Mux.scala 69:19]
  assign _T_76 = 2'h2 == _T_175; // @[Mux.scala 69:19]
  assign _T_78 = 2'h1 == _T_175; // @[Mux.scala 69:19]
  assign _T_80 = 2'h0 == _T_175; // @[Mux.scala 69:19]
  assign _T_92 = 2'h3 == _T_178; // @[Mux.scala 69:19]
  assign _T_94 = 2'h2 == _T_178; // @[Mux.scala 69:19]
  assign _T_96 = 2'h1 == _T_178; // @[Mux.scala 69:19]
  assign _T_98 = 2'h0 == _T_178; // @[Mux.scala 69:19]
  assign _T_110 = _T_166 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_111 = _T_110 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_113 = _T_169 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_114 = _T_113 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_116 = _T_172 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_117 = _T_116 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_119 = _T_175 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_120 = _T_119 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_122 = _T_178 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_123 = _T_122 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_124 = _T_111 & _T_114; // @[Router_Hw.scala 116:99]
  assign _T_125 = _T_124 & _T_117; // @[Router_Hw.scala 116:99]
  assign _T_126 = _T_125 & _T_120; // @[Router_Hw.scala 116:99]
  assign _T_129 = _T_166 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_130 = _T_129 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_132 = _T_169 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_133 = _T_132 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_135 = _T_172 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_136 = _T_135 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_138 = _T_175 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_139 = _T_138 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_141 = _T_178 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_142 = _T_141 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_143 = _T_130 & _T_133; // @[Router_Hw.scala 116:99]
  assign _T_144 = _T_143 & _T_136; // @[Router_Hw.scala 116:99]
  assign _T_145 = _T_144 & _T_139; // @[Router_Hw.scala 116:99]
  assign _T_148 = _T_166 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_149 = _T_148 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_151 = _T_169 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_152 = _T_151 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_154 = _T_172 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_155 = _T_154 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_157 = _T_175 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_158 = _T_157 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_160 = _T_178 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_161 = _T_160 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_162 = _T_149 & _T_152; // @[Router_Hw.scala 116:99]
  assign _T_163 = _T_162 & _T_155; // @[Router_Hw.scala 116:99]
  assign _T_164 = _T_163 & _T_158; // @[Router_Hw.scala 116:99]
  assign config_module_id = io_in_3_bits[63:59]; // @[Router_Hw.scala 148:44]
  assign module_id_match = config_module_id == 5'hb; // @[Router_Hw.scala 149:49]
  assign config_data = io_in_3_bits[9:0]; // @[Router_Hw.scala 151:39]
  assign _T_187 = io_in_3_config & module_id_match; // @[Router_Hw.scala 152:22]
  assign io_in_0_ready = _T_126 & _T_123; // @[Router_Hw.scala 178:33]
  assign io_in_1_ready = _T_145 & _T_142; // @[Router_Hw.scala 178:33]
  assign io_in_2_ready = _T_164 & _T_161; // @[Router_Hw.scala 178:33]
  assign io_in_3_ready = io_in_3_config ? io_out_4_ready : decomposed_input_ports_0_3_ready; // @[Router_Hw.scala 178:33 Router_Hw.scala 198:31]
  assign io_out_0_valid = _T_6; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_5; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = _T_9; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_8; // @[Router_Hw.scala 212:34]
  assign io_out_2_valid = _T_12; // @[Router_Hw.scala 213:35]
  assign io_out_2_bits = _T_11; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = _T_15; // @[Router_Hw.scala 213:35]
  assign io_out_3_bits = _T_14; // @[Router_Hw.scala 212:34]
  assign io_out_4_valid = io_in_3_config ? io_in_3_valid : _T_18; // @[Router_Hw.scala 198:31 Router_Hw.scala 204:37]
  assign io_out_4_bits = io_in_3_config ? io_in_3_bits : _T_17; // @[Router_Hw.scala 198:31 Router_Hw.scala 203:36]
  assign io_out_4_config = io_in_3_config; // @[Router_Hw.scala 198:31 Router_Hw.scala 205:38]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_5 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_6 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_8 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_9 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_11 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_12 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {2{`RANDOM}};
  _T_14 = _RAND_10[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  _T_15 = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  decomposed_output_ports_0_4_ready = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {2{`RANDOM}};
  _T_17 = _RAND_13[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  _T_18 = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  config_register_file_0 = _RAND_15[9:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (_T_26) begin
      _T_5 <= io_in_0_bits;
    end else begin
      if (_T_24) begin
        _T_5 <= io_in_1_bits;
      end else begin
        if (_T_22) begin
          _T_5 <= io_in_2_bits;
        end else begin
          if (_T_20) begin
            _T_5 <= io_in_3_bits;
          end else begin
            _T_5 <= 64'h0;
          end
        end
      end
    end
    if (_T_26) begin
      _T_6 <= io_in_0_valid;
    end else begin
      if (_T_24) begin
        _T_6 <= io_in_1_valid;
      end else begin
        if (_T_22) begin
          _T_6 <= io_in_2_valid;
        end else begin
          if (_T_20) begin
            _T_6 <= io_in_3_valid;
          end else begin
            _T_6 <= 1'h0;
          end
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (_T_44) begin
      _T_8 <= io_in_0_bits;
    end else begin
      if (_T_42) begin
        _T_8 <= io_in_1_bits;
      end else begin
        if (_T_40) begin
          _T_8 <= io_in_2_bits;
        end else begin
          if (_T_38) begin
            _T_8 <= io_in_3_bits;
          end else begin
            _T_8 <= 64'h0;
          end
        end
      end
    end
    if (_T_44) begin
      _T_9 <= io_in_0_valid;
    end else begin
      if (_T_42) begin
        _T_9 <= io_in_1_valid;
      end else begin
        if (_T_40) begin
          _T_9 <= io_in_2_valid;
        end else begin
          if (_T_38) begin
            _T_9 <= io_in_3_valid;
          end else begin
            _T_9 <= 1'h0;
          end
        end
      end
    end
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    if (_T_62) begin
      _T_11 <= io_in_0_bits;
    end else begin
      if (_T_60) begin
        _T_11 <= io_in_1_bits;
      end else begin
        if (_T_58) begin
          _T_11 <= io_in_2_bits;
        end else begin
          if (_T_56) begin
            _T_11 <= io_in_3_bits;
          end else begin
            _T_11 <= 64'h0;
          end
        end
      end
    end
    if (_T_62) begin
      _T_12 <= io_in_0_valid;
    end else begin
      if (_T_60) begin
        _T_12 <= io_in_1_valid;
      end else begin
        if (_T_58) begin
          _T_12 <= io_in_2_valid;
        end else begin
          if (_T_56) begin
            _T_12 <= io_in_3_valid;
          end else begin
            _T_12 <= 1'h0;
          end
        end
      end
    end
    decomposed_output_ports_0_3_ready <= io_out_3_ready;
    if (_T_80) begin
      _T_14 <= io_in_0_bits;
    end else begin
      if (_T_78) begin
        _T_14 <= io_in_1_bits;
      end else begin
        if (_T_76) begin
          _T_14 <= io_in_2_bits;
        end else begin
          if (_T_74) begin
            _T_14 <= io_in_3_bits;
          end else begin
            _T_14 <= 64'h0;
          end
        end
      end
    end
    if (_T_80) begin
      _T_15 <= io_in_0_valid;
    end else begin
      if (_T_78) begin
        _T_15 <= io_in_1_valid;
      end else begin
        if (_T_76) begin
          _T_15 <= io_in_2_valid;
        end else begin
          if (_T_74) begin
            _T_15 <= io_in_3_valid;
          end else begin
            _T_15 <= 1'h0;
          end
        end
      end
    end
    if (io_in_3_config) begin
      decomposed_output_ports_0_4_ready <= 1'h0;
    end else begin
      decomposed_output_ports_0_4_ready <= io_out_4_ready;
    end
    if (_T_98) begin
      _T_17 <= io_in_0_bits;
    end else begin
      if (_T_96) begin
        _T_17 <= io_in_1_bits;
      end else begin
        if (_T_94) begin
          _T_17 <= io_in_2_bits;
        end else begin
          if (_T_92) begin
            _T_17 <= io_in_3_bits;
          end else begin
            _T_17 <= 64'h0;
          end
        end
      end
    end
    if (_T_98) begin
      _T_18 <= io_in_0_valid;
    end else begin
      if (_T_96) begin
        _T_18 <= io_in_1_valid;
      end else begin
        if (_T_94) begin
          _T_18 <= io_in_2_valid;
        end else begin
          if (_T_92) begin
            _T_18 <= io_in_3_valid;
          end else begin
            _T_18 <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 10'h0;
    end else begin
      if (_T_187) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Router_Hw_1(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  input         io_in_4_valid,
  input  [63:0] io_in_4_bits,
  output        io_in_4_ready,
  input         io_in_4_config,
  input         io_in_5_valid,
  input  [63:0] io_in_5_bits,
  output        io_in_5_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready,
  output        io_out_3_config,
  output        io_out_4_valid,
  output [63:0] io_out_4_bits,
  input         io_out_4_ready,
  output        io_out_5_valid,
  output [63:0] io_out_5_bits,
  input         io_out_5_ready,
  output        io_out_6_valid,
  output [63:0] io_out_6_bits,
  input         io_out_6_ready,
  output        io_out_7_valid,
  output [63:0] io_out_7_bits,
  input         io_out_7_ready
);
  wire [31:0] decomposed_input_ports_0_0_bits; // @[Router_Hw.scala 174:35]
  wire [31:0] decomposed_input_ports_1_0_bits; // @[Router_Hw.scala 174:35]
  reg [53:0] config_register_file_0; // @[Router_Hw.scala 140:37]
  reg [63:0] _RAND_0;
  wire [2:0] _T_542; // @[Router_Hw.scala 113:22]
  wire  _T_543; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_1;
  wire  _T_544; // @[Router_Hw.scala 113:10]
  wire [2:0] _T_545; // @[Router_Hw.scala 113:22]
  wire  _T_546; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_2;
  wire  _T_547; // @[Router_Hw.scala 113:10]
  wire  _T_569; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_548; // @[Router_Hw.scala 113:22]
  wire  _T_549; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  wire  _T_550; // @[Router_Hw.scala 113:10]
  wire  _T_570; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_551; // @[Router_Hw.scala 113:22]
  wire  _T_552; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_4;
  wire  _T_553; // @[Router_Hw.scala 113:10]
  wire  _T_571; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_554; // @[Router_Hw.scala 113:22]
  wire  _T_555; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_4_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_5;
  wire  _T_556; // @[Router_Hw.scala 113:10]
  wire  _T_572; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_557; // @[Router_Hw.scala 113:22]
  wire  _T_558; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_5_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  wire  _T_559; // @[Router_Hw.scala 113:10]
  wire  _T_573; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_560; // @[Router_Hw.scala 113:22]
  wire  _T_561; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_6_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_7;
  wire  _T_562; // @[Router_Hw.scala 113:10]
  wire  _T_574; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_563; // @[Router_Hw.scala 113:22]
  wire  _T_564; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_7_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_8;
  wire  _T_565; // @[Router_Hw.scala 113:10]
  wire  _T_575; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_566; // @[Router_Hw.scala 113:22]
  wire  _T_567; // @[Router_Hw.scala 113:53]
  wire  _T_568; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_0_ready; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_760; // @[Router_Hw.scala 113:22]
  wire  _T_761; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_1_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_9;
  wire  _T_762; // @[Router_Hw.scala 113:10]
  wire [2:0] _T_763; // @[Router_Hw.scala 113:22]
  wire  _T_764; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_1_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_10;
  wire  _T_765; // @[Router_Hw.scala 113:10]
  wire  _T_787; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_766; // @[Router_Hw.scala 113:22]
  wire  _T_767; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_1_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_11;
  wire  _T_768; // @[Router_Hw.scala 113:10]
  wire  _T_788; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_769; // @[Router_Hw.scala 113:22]
  wire  _T_770; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_1_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_12;
  wire  _T_771; // @[Router_Hw.scala 113:10]
  wire  _T_789; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_772; // @[Router_Hw.scala 113:22]
  wire  _T_773; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_1_4_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_13;
  wire  _T_774; // @[Router_Hw.scala 113:10]
  wire  _T_790; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_775; // @[Router_Hw.scala 113:22]
  wire  _T_776; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_1_5_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_14;
  wire  _T_777; // @[Router_Hw.scala 113:10]
  wire  _T_791; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_778; // @[Router_Hw.scala 113:22]
  wire  _T_779; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_1_6_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_15;
  wire  _T_780; // @[Router_Hw.scala 113:10]
  wire  _T_792; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_781; // @[Router_Hw.scala 113:22]
  wire  _T_782; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_1_7_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_16;
  wire  _T_783; // @[Router_Hw.scala 113:10]
  wire  _T_793; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_784; // @[Router_Hw.scala 113:22]
  wire  _T_785; // @[Router_Hw.scala 113:53]
  wire  _T_786; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_1_0_ready; // @[Router_Hw.scala 116:99]
  wire [31:0] decomposed_input_ports_0_1_bits; // @[Router_Hw.scala 174:35]
  wire [31:0] decomposed_input_ports_1_1_bits; // @[Router_Hw.scala 174:35]
  wire  _T_578; // @[Router_Hw.scala 113:53]
  wire  _T_579; // @[Router_Hw.scala 113:10]
  wire  _T_581; // @[Router_Hw.scala 113:53]
  wire  _T_582; // @[Router_Hw.scala 113:10]
  wire  _T_604; // @[Router_Hw.scala 116:99]
  wire  _T_584; // @[Router_Hw.scala 113:53]
  wire  _T_585; // @[Router_Hw.scala 113:10]
  wire  _T_605; // @[Router_Hw.scala 116:99]
  wire  _T_587; // @[Router_Hw.scala 113:53]
  wire  _T_588; // @[Router_Hw.scala 113:10]
  wire  _T_606; // @[Router_Hw.scala 116:99]
  wire  _T_590; // @[Router_Hw.scala 113:53]
  wire  _T_591; // @[Router_Hw.scala 113:10]
  wire  _T_607; // @[Router_Hw.scala 116:99]
  wire  _T_593; // @[Router_Hw.scala 113:53]
  wire  _T_594; // @[Router_Hw.scala 113:10]
  wire  _T_608; // @[Router_Hw.scala 116:99]
  wire  _T_596; // @[Router_Hw.scala 113:53]
  wire  _T_597; // @[Router_Hw.scala 113:10]
  wire  _T_609; // @[Router_Hw.scala 116:99]
  wire  _T_599; // @[Router_Hw.scala 113:53]
  wire  _T_600; // @[Router_Hw.scala 113:10]
  wire  _T_610; // @[Router_Hw.scala 116:99]
  wire  _T_602; // @[Router_Hw.scala 113:53]
  wire  _T_603; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_1_ready; // @[Router_Hw.scala 116:99]
  wire  _T_979; // @[Router_Hw.scala 113:53]
  wire  _T_980; // @[Router_Hw.scala 113:10]
  wire  _T_982; // @[Router_Hw.scala 113:53]
  wire  _T_983; // @[Router_Hw.scala 113:10]
  wire  _T_1011; // @[Router_Hw.scala 116:99]
  wire  _T_985; // @[Router_Hw.scala 113:53]
  wire  _T_986; // @[Router_Hw.scala 113:10]
  wire  _T_1012; // @[Router_Hw.scala 116:99]
  wire  _T_988; // @[Router_Hw.scala 113:53]
  wire  _T_989; // @[Router_Hw.scala 113:10]
  wire  _T_1013; // @[Router_Hw.scala 116:99]
  wire  _T_991; // @[Router_Hw.scala 113:53]
  wire  _T_992; // @[Router_Hw.scala 113:10]
  wire  _T_1014; // @[Router_Hw.scala 116:99]
  wire  _T_994; // @[Router_Hw.scala 113:53]
  wire  _T_995; // @[Router_Hw.scala 113:10]
  wire  _T_1015; // @[Router_Hw.scala 116:99]
  wire  _T_997; // @[Router_Hw.scala 113:53]
  wire  _T_998; // @[Router_Hw.scala 113:10]
  wire  _T_1016; // @[Router_Hw.scala 116:99]
  wire  _T_1000; // @[Router_Hw.scala 113:53]
  wire  _T_1001; // @[Router_Hw.scala 113:10]
  wire  _T_1017; // @[Router_Hw.scala 116:99]
  wire  _T_1003; // @[Router_Hw.scala 113:53]
  wire  _T_1004; // @[Router_Hw.scala 113:10]
  wire  _T_1018; // @[Router_Hw.scala 116:99]
  wire  _T_1006; // @[Router_Hw.scala 113:53]
  wire  _T_1007; // @[Router_Hw.scala 113:10]
  wire  _T_1019; // @[Router_Hw.scala 116:99]
  wire  _T_1009; // @[Router_Hw.scala 113:53]
  wire  _T_1010; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_1_1_ready; // @[Router_Hw.scala 116:99]
  wire [31:0] decomposed_input_ports_0_2_bits; // @[Router_Hw.scala 174:35]
  wire [31:0] decomposed_input_ports_1_2_bits; // @[Router_Hw.scala 174:35]
  wire  _T_613; // @[Router_Hw.scala 113:53]
  wire  _T_614; // @[Router_Hw.scala 113:10]
  wire  _T_616; // @[Router_Hw.scala 113:53]
  wire  _T_617; // @[Router_Hw.scala 113:10]
  wire  _T_639; // @[Router_Hw.scala 116:99]
  wire  _T_619; // @[Router_Hw.scala 113:53]
  wire  _T_620; // @[Router_Hw.scala 113:10]
  wire  _T_640; // @[Router_Hw.scala 116:99]
  wire  _T_622; // @[Router_Hw.scala 113:53]
  wire  _T_623; // @[Router_Hw.scala 113:10]
  wire  _T_641; // @[Router_Hw.scala 116:99]
  wire  _T_625; // @[Router_Hw.scala 113:53]
  wire  _T_626; // @[Router_Hw.scala 113:10]
  wire  _T_642; // @[Router_Hw.scala 116:99]
  wire  _T_628; // @[Router_Hw.scala 113:53]
  wire  _T_629; // @[Router_Hw.scala 113:10]
  wire  _T_643; // @[Router_Hw.scala 116:99]
  wire  _T_631; // @[Router_Hw.scala 113:53]
  wire  _T_632; // @[Router_Hw.scala 113:10]
  wire  _T_644; // @[Router_Hw.scala 116:99]
  wire  _T_634; // @[Router_Hw.scala 113:53]
  wire  _T_635; // @[Router_Hw.scala 113:10]
  wire  _T_645; // @[Router_Hw.scala 116:99]
  wire  _T_637; // @[Router_Hw.scala 113:53]
  wire  _T_638; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_2_ready; // @[Router_Hw.scala 116:99]
  wire  _T_839; // @[Router_Hw.scala 113:53]
  wire  _T_840; // @[Router_Hw.scala 113:10]
  wire  _T_842; // @[Router_Hw.scala 113:53]
  wire  _T_843; // @[Router_Hw.scala 113:10]
  wire  _T_865; // @[Router_Hw.scala 116:99]
  wire  _T_845; // @[Router_Hw.scala 113:53]
  wire  _T_846; // @[Router_Hw.scala 113:10]
  wire  _T_866; // @[Router_Hw.scala 116:99]
  wire  _T_848; // @[Router_Hw.scala 113:53]
  wire  _T_849; // @[Router_Hw.scala 113:10]
  wire  _T_867; // @[Router_Hw.scala 116:99]
  wire  _T_851; // @[Router_Hw.scala 113:53]
  wire  _T_852; // @[Router_Hw.scala 113:10]
  wire  _T_868; // @[Router_Hw.scala 116:99]
  wire  _T_854; // @[Router_Hw.scala 113:53]
  wire  _T_855; // @[Router_Hw.scala 113:10]
  wire  _T_869; // @[Router_Hw.scala 116:99]
  wire  _T_857; // @[Router_Hw.scala 113:53]
  wire  _T_858; // @[Router_Hw.scala 113:10]
  wire  _T_870; // @[Router_Hw.scala 116:99]
  wire  _T_860; // @[Router_Hw.scala 113:53]
  wire  _T_861; // @[Router_Hw.scala 113:10]
  wire  _T_871; // @[Router_Hw.scala 116:99]
  wire  _T_863; // @[Router_Hw.scala 113:53]
  wire  _T_864; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_1_2_ready; // @[Router_Hw.scala 116:99]
  wire [31:0] decomposed_input_ports_0_3_bits; // @[Router_Hw.scala 174:35]
  wire [31:0] decomposed_input_ports_1_3_bits; // @[Router_Hw.scala 174:35]
  wire  _T_648; // @[Router_Hw.scala 113:53]
  wire  _T_649; // @[Router_Hw.scala 113:10]
  wire  _T_651; // @[Router_Hw.scala 113:53]
  wire  _T_652; // @[Router_Hw.scala 113:10]
  wire  _T_674; // @[Router_Hw.scala 116:99]
  wire  _T_654; // @[Router_Hw.scala 113:53]
  wire  _T_655; // @[Router_Hw.scala 113:10]
  wire  _T_675; // @[Router_Hw.scala 116:99]
  wire  _T_657; // @[Router_Hw.scala 113:53]
  wire  _T_658; // @[Router_Hw.scala 113:10]
  wire  _T_676; // @[Router_Hw.scala 116:99]
  wire  _T_660; // @[Router_Hw.scala 113:53]
  wire  _T_661; // @[Router_Hw.scala 113:10]
  wire  _T_677; // @[Router_Hw.scala 116:99]
  wire  _T_663; // @[Router_Hw.scala 113:53]
  wire  _T_664; // @[Router_Hw.scala 113:10]
  wire  _T_678; // @[Router_Hw.scala 116:99]
  wire  _T_666; // @[Router_Hw.scala 113:53]
  wire  _T_667; // @[Router_Hw.scala 113:10]
  wire  _T_679; // @[Router_Hw.scala 116:99]
  wire  _T_669; // @[Router_Hw.scala 113:53]
  wire  _T_670; // @[Router_Hw.scala 113:10]
  wire  _T_680; // @[Router_Hw.scala 116:99]
  wire  _T_672; // @[Router_Hw.scala 113:53]
  wire  _T_673; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_3_ready; // @[Router_Hw.scala 116:99]
  wire  _T_874; // @[Router_Hw.scala 113:53]
  wire  _T_875; // @[Router_Hw.scala 113:10]
  wire  _T_877; // @[Router_Hw.scala 113:53]
  wire  _T_878; // @[Router_Hw.scala 113:10]
  wire  _T_900; // @[Router_Hw.scala 116:99]
  wire  _T_880; // @[Router_Hw.scala 113:53]
  wire  _T_881; // @[Router_Hw.scala 113:10]
  wire  _T_901; // @[Router_Hw.scala 116:99]
  wire  _T_883; // @[Router_Hw.scala 113:53]
  wire  _T_884; // @[Router_Hw.scala 113:10]
  wire  _T_902; // @[Router_Hw.scala 116:99]
  wire  _T_886; // @[Router_Hw.scala 113:53]
  wire  _T_887; // @[Router_Hw.scala 113:10]
  wire  _T_903; // @[Router_Hw.scala 116:99]
  wire  _T_889; // @[Router_Hw.scala 113:53]
  wire  _T_890; // @[Router_Hw.scala 113:10]
  wire  _T_904; // @[Router_Hw.scala 116:99]
  wire  _T_892; // @[Router_Hw.scala 113:53]
  wire  _T_893; // @[Router_Hw.scala 113:10]
  wire  _T_905; // @[Router_Hw.scala 116:99]
  wire  _T_895; // @[Router_Hw.scala 113:53]
  wire  _T_896; // @[Router_Hw.scala 113:10]
  wire  _T_906; // @[Router_Hw.scala 116:99]
  wire  _T_898; // @[Router_Hw.scala 113:53]
  wire  _T_899; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_1_3_ready; // @[Router_Hw.scala 116:99]
  wire [31:0] decomposed_input_ports_0_4_bits; // @[Router_Hw.scala 174:35]
  wire [31:0] decomposed_input_ports_1_4_bits; // @[Router_Hw.scala 174:35]
  wire  _T_683; // @[Router_Hw.scala 113:53]
  wire  _T_684; // @[Router_Hw.scala 113:10]
  wire  _T_686; // @[Router_Hw.scala 113:53]
  wire  _T_687; // @[Router_Hw.scala 113:10]
  wire  _T_709; // @[Router_Hw.scala 116:99]
  wire  _T_689; // @[Router_Hw.scala 113:53]
  wire  _T_690; // @[Router_Hw.scala 113:10]
  wire  _T_710; // @[Router_Hw.scala 116:99]
  wire  _T_692; // @[Router_Hw.scala 113:53]
  wire  _T_693; // @[Router_Hw.scala 113:10]
  wire  _T_711; // @[Router_Hw.scala 116:99]
  wire  _T_695; // @[Router_Hw.scala 113:53]
  wire  _T_696; // @[Router_Hw.scala 113:10]
  wire  _T_712; // @[Router_Hw.scala 116:99]
  wire  _T_698; // @[Router_Hw.scala 113:53]
  wire  _T_699; // @[Router_Hw.scala 113:10]
  wire  _T_713; // @[Router_Hw.scala 116:99]
  wire  _T_701; // @[Router_Hw.scala 113:53]
  wire  _T_702; // @[Router_Hw.scala 113:10]
  wire  _T_714; // @[Router_Hw.scala 116:99]
  wire  _T_704; // @[Router_Hw.scala 113:53]
  wire  _T_705; // @[Router_Hw.scala 113:10]
  wire  _T_715; // @[Router_Hw.scala 116:99]
  wire  _T_707; // @[Router_Hw.scala 113:53]
  wire  _T_708; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_4_ready; // @[Router_Hw.scala 116:99]
  wire  _T_909; // @[Router_Hw.scala 113:53]
  wire  _T_910; // @[Router_Hw.scala 113:10]
  wire  _T_912; // @[Router_Hw.scala 113:53]
  wire  _T_913; // @[Router_Hw.scala 113:10]
  wire  _T_935; // @[Router_Hw.scala 116:99]
  wire  _T_915; // @[Router_Hw.scala 113:53]
  wire  _T_916; // @[Router_Hw.scala 113:10]
  wire  _T_936; // @[Router_Hw.scala 116:99]
  wire  _T_918; // @[Router_Hw.scala 113:53]
  wire  _T_919; // @[Router_Hw.scala 113:10]
  wire  _T_937; // @[Router_Hw.scala 116:99]
  wire  _T_921; // @[Router_Hw.scala 113:53]
  wire  _T_922; // @[Router_Hw.scala 113:10]
  wire  _T_938; // @[Router_Hw.scala 116:99]
  wire  _T_924; // @[Router_Hw.scala 113:53]
  wire  _T_925; // @[Router_Hw.scala 113:10]
  wire  _T_939; // @[Router_Hw.scala 116:99]
  wire  _T_927; // @[Router_Hw.scala 113:53]
  wire  _T_928; // @[Router_Hw.scala 113:10]
  wire  _T_940; // @[Router_Hw.scala 116:99]
  wire  _T_930; // @[Router_Hw.scala 113:53]
  wire  _T_931; // @[Router_Hw.scala 113:10]
  wire  _T_941; // @[Router_Hw.scala 116:99]
  wire  _T_933; // @[Router_Hw.scala 113:53]
  wire  _T_934; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_1_4_ready; // @[Router_Hw.scala 116:99]
  wire  _T_14; // @[Router_Hw.scala 178:90]
  wire [31:0] decomposed_input_ports_0_5_bits; // @[Router_Hw.scala 174:35]
  wire [31:0] decomposed_input_ports_1_5_bits; // @[Router_Hw.scala 174:35]
  wire  _T_1022; // @[Router_Hw.scala 113:53]
  wire  _T_1023; // @[Router_Hw.scala 113:10]
  wire  _T_1025; // @[Router_Hw.scala 113:53]
  wire  _T_1026; // @[Router_Hw.scala 113:10]
  wire  _T_1054; // @[Router_Hw.scala 116:99]
  wire  _T_1028; // @[Router_Hw.scala 113:53]
  wire  _T_1029; // @[Router_Hw.scala 113:10]
  wire  _T_1055; // @[Router_Hw.scala 116:99]
  wire  _T_1031; // @[Router_Hw.scala 113:53]
  wire  _T_1032; // @[Router_Hw.scala 113:10]
  wire  _T_1056; // @[Router_Hw.scala 116:99]
  wire  _T_1034; // @[Router_Hw.scala 113:53]
  wire  _T_1035; // @[Router_Hw.scala 113:10]
  wire  _T_1057; // @[Router_Hw.scala 116:99]
  wire  _T_1037; // @[Router_Hw.scala 113:53]
  wire  _T_1038; // @[Router_Hw.scala 113:10]
  wire  _T_1058; // @[Router_Hw.scala 116:99]
  wire  _T_1040; // @[Router_Hw.scala 113:53]
  wire  _T_1041; // @[Router_Hw.scala 113:10]
  wire  _T_1059; // @[Router_Hw.scala 116:99]
  wire  _T_1043; // @[Router_Hw.scala 113:53]
  wire  _T_1044; // @[Router_Hw.scala 113:10]
  wire  _T_1060; // @[Router_Hw.scala 116:99]
  wire  _T_1046; // @[Router_Hw.scala 113:53]
  wire  _T_1047; // @[Router_Hw.scala 113:10]
  wire  _T_1061; // @[Router_Hw.scala 116:99]
  wire  _T_1049; // @[Router_Hw.scala 113:53]
  wire  _T_1050; // @[Router_Hw.scala 113:10]
  wire  _T_1062; // @[Router_Hw.scala 116:99]
  wire  _T_1052; // @[Router_Hw.scala 113:53]
  wire  _T_1053; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_5_ready; // @[Router_Hw.scala 116:99]
  wire  _T_944; // @[Router_Hw.scala 113:53]
  wire  _T_945; // @[Router_Hw.scala 113:10]
  wire  _T_947; // @[Router_Hw.scala 113:53]
  wire  _T_948; // @[Router_Hw.scala 113:10]
  wire  _T_970; // @[Router_Hw.scala 116:99]
  wire  _T_950; // @[Router_Hw.scala 113:53]
  wire  _T_951; // @[Router_Hw.scala 113:10]
  wire  _T_971; // @[Router_Hw.scala 116:99]
  wire  _T_953; // @[Router_Hw.scala 113:53]
  wire  _T_954; // @[Router_Hw.scala 113:10]
  wire  _T_972; // @[Router_Hw.scala 116:99]
  wire  _T_956; // @[Router_Hw.scala 113:53]
  wire  _T_957; // @[Router_Hw.scala 113:10]
  wire  _T_973; // @[Router_Hw.scala 116:99]
  wire  _T_959; // @[Router_Hw.scala 113:53]
  wire  _T_960; // @[Router_Hw.scala 113:10]
  wire  _T_974; // @[Router_Hw.scala 116:99]
  wire  _T_962; // @[Router_Hw.scala 113:53]
  wire  _T_963; // @[Router_Hw.scala 113:10]
  wire  _T_975; // @[Router_Hw.scala 116:99]
  wire  _T_965; // @[Router_Hw.scala 113:53]
  wire  _T_966; // @[Router_Hw.scala 113:10]
  wire  _T_976; // @[Router_Hw.scala 116:99]
  wire  _T_968; // @[Router_Hw.scala 113:53]
  wire  _T_969; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_1_5_ready; // @[Router_Hw.scala 116:99]
  reg [63:0] _T_19; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_17;
  wire  _T_495; // @[Mux.scala 69:19]
  wire  _T_493; // @[Mux.scala 69:19]
  wire  _T_491; // @[Mux.scala 69:19]
  wire  _T_489; // @[Mux.scala 69:19]
  wire  _T_487; // @[Mux.scala 69:19]
  wire  _T_485; // @[Mux.scala 69:19]
  wire  _T_483; // @[Mux.scala 69:19]
  wire [31:0] _T_484; // @[Mux.scala 69:16]
  wire [31:0] _T_486; // @[Mux.scala 69:16]
  wire [31:0] _T_488; // @[Mux.scala 69:16]
  wire [31:0] _T_490; // @[Mux.scala 69:16]
  wire [31:0] _T_492; // @[Mux.scala 69:16]
  wire [31:0] _T_494; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_0_0_bits; // @[Mux.scala 69:16]
  wire  _T_281; // @[Mux.scala 69:19]
  wire  _T_279; // @[Mux.scala 69:19]
  wire  _T_277; // @[Mux.scala 69:19]
  wire  _T_275; // @[Mux.scala 69:19]
  wire  _T_273; // @[Mux.scala 69:19]
  wire  _T_271; // @[Mux.scala 69:19]
  wire [31:0] _T_272; // @[Mux.scala 69:16]
  wire [31:0] _T_274; // @[Mux.scala 69:16]
  wire [31:0] _T_276; // @[Mux.scala 69:16]
  wire [31:0] _T_278; // @[Mux.scala 69:16]
  wire [31:0] _T_280; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_1_0_bits; // @[Mux.scala 69:16]
  reg  _T_21; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_18;
  wire  _T_499; // @[Mux.scala 69:16]
  wire  _T_501; // @[Mux.scala 69:16]
  wire  _T_503; // @[Mux.scala 69:16]
  wire  _T_505; // @[Mux.scala 69:16]
  wire  _T_507; // @[Mux.scala 69:16]
  wire  _T_509; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_0_0_valid; // @[Mux.scala 69:16]
  wire  _T_285; // @[Mux.scala 69:16]
  wire  _T_287; // @[Mux.scala 69:16]
  wire  _T_289; // @[Mux.scala 69:16]
  wire  _T_291; // @[Mux.scala 69:16]
  wire  _T_293; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_1_0_valid; // @[Mux.scala 69:16]
  reg [63:0] _T_24; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_19;
  wire  _T_99; // @[Mux.scala 69:19]
  wire  _T_97; // @[Mux.scala 69:19]
  wire  _T_95; // @[Mux.scala 69:19]
  wire  _T_93; // @[Mux.scala 69:19]
  wire  _T_91; // @[Mux.scala 69:19]
  wire  _T_89; // @[Mux.scala 69:19]
  wire [31:0] _T_90; // @[Mux.scala 69:16]
  wire [31:0] _T_92; // @[Mux.scala 69:16]
  wire [31:0] _T_94; // @[Mux.scala 69:16]
  wire [31:0] _T_96; // @[Mux.scala 69:16]
  wire [31:0] _T_98; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_0_1_bits; // @[Mux.scala 69:16]
  wire  _T_307; // @[Mux.scala 69:19]
  wire  _T_305; // @[Mux.scala 69:19]
  wire  _T_303; // @[Mux.scala 69:19]
  wire  _T_301; // @[Mux.scala 69:19]
  wire  _T_299; // @[Mux.scala 69:19]
  wire  _T_297; // @[Mux.scala 69:19]
  wire [31:0] _T_298; // @[Mux.scala 69:16]
  wire [31:0] _T_300; // @[Mux.scala 69:16]
  wire [31:0] _T_302; // @[Mux.scala 69:16]
  wire [31:0] _T_304; // @[Mux.scala 69:16]
  wire [31:0] _T_306; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_1_1_bits; // @[Mux.scala 69:16]
  reg  _T_26; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_20;
  wire  _T_103; // @[Mux.scala 69:16]
  wire  _T_105; // @[Mux.scala 69:16]
  wire  _T_107; // @[Mux.scala 69:16]
  wire  _T_109; // @[Mux.scala 69:16]
  wire  _T_111; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_0_1_valid; // @[Mux.scala 69:16]
  wire  _T_311; // @[Mux.scala 69:16]
  wire  _T_313; // @[Mux.scala 69:16]
  wire  _T_315; // @[Mux.scala 69:16]
  wire  _T_317; // @[Mux.scala 69:16]
  wire  _T_319; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_1_1_valid; // @[Mux.scala 69:16]
  reg [63:0] _T_29; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_21;
  wire  _T_125; // @[Mux.scala 69:19]
  wire  _T_123; // @[Mux.scala 69:19]
  wire  _T_121; // @[Mux.scala 69:19]
  wire  _T_119; // @[Mux.scala 69:19]
  wire  _T_117; // @[Mux.scala 69:19]
  wire  _T_115; // @[Mux.scala 69:19]
  wire [31:0] _T_116; // @[Mux.scala 69:16]
  wire [31:0] _T_118; // @[Mux.scala 69:16]
  wire [31:0] _T_120; // @[Mux.scala 69:16]
  wire [31:0] _T_122; // @[Mux.scala 69:16]
  wire [31:0] _T_124; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_0_2_bits; // @[Mux.scala 69:16]
  wire  _T_525; // @[Mux.scala 69:19]
  wire  _T_523; // @[Mux.scala 69:19]
  wire  _T_521; // @[Mux.scala 69:19]
  wire  _T_519; // @[Mux.scala 69:19]
  wire  _T_517; // @[Mux.scala 69:19]
  wire  _T_515; // @[Mux.scala 69:19]
  wire  _T_513; // @[Mux.scala 69:19]
  wire [31:0] _T_514; // @[Mux.scala 69:16]
  wire [31:0] _T_516; // @[Mux.scala 69:16]
  wire [31:0] _T_518; // @[Mux.scala 69:16]
  wire [31:0] _T_520; // @[Mux.scala 69:16]
  wire [31:0] _T_522; // @[Mux.scala 69:16]
  wire [31:0] _T_524; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_1_2_bits; // @[Mux.scala 69:16]
  reg  _T_31; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_22;
  wire  _T_129; // @[Mux.scala 69:16]
  wire  _T_131; // @[Mux.scala 69:16]
  wire  _T_133; // @[Mux.scala 69:16]
  wire  _T_135; // @[Mux.scala 69:16]
  wire  _T_137; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_0_2_valid; // @[Mux.scala 69:16]
  wire  _T_529; // @[Mux.scala 69:16]
  wire  _T_531; // @[Mux.scala 69:16]
  wire  _T_533; // @[Mux.scala 69:16]
  wire  _T_535; // @[Mux.scala 69:16]
  wire  _T_537; // @[Mux.scala 69:16]
  wire  _T_539; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_1_2_valid; // @[Mux.scala 69:16]
  reg [63:0] _T_34; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_23;
  wire  _T_151; // @[Mux.scala 69:19]
  wire  _T_149; // @[Mux.scala 69:19]
  wire  _T_147; // @[Mux.scala 69:19]
  wire  _T_145; // @[Mux.scala 69:19]
  wire  _T_143; // @[Mux.scala 69:19]
  wire  _T_141; // @[Mux.scala 69:19]
  wire [31:0] _T_142; // @[Mux.scala 69:16]
  wire [31:0] _T_144; // @[Mux.scala 69:16]
  wire [31:0] _T_146; // @[Mux.scala 69:16]
  wire [31:0] _T_148; // @[Mux.scala 69:16]
  wire [31:0] _T_150; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_0_3_bits; // @[Mux.scala 69:16]
  wire  _T_363; // @[Mux.scala 69:19]
  wire  _T_361; // @[Mux.scala 69:19]
  wire  _T_359; // @[Mux.scala 69:19]
  wire  _T_357; // @[Mux.scala 69:19]
  wire  _T_355; // @[Mux.scala 69:19]
  wire  _T_353; // @[Mux.scala 69:19]
  wire [31:0] _T_354; // @[Mux.scala 69:16]
  wire [31:0] _T_356; // @[Mux.scala 69:16]
  wire [31:0] _T_358; // @[Mux.scala 69:16]
  wire [31:0] _T_360; // @[Mux.scala 69:16]
  wire [31:0] _T_362; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_1_3_bits; // @[Mux.scala 69:16]
  reg  _T_36; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_24;
  wire  _T_155; // @[Mux.scala 69:16]
  wire  _T_157; // @[Mux.scala 69:16]
  wire  _T_159; // @[Mux.scala 69:16]
  wire  _T_161; // @[Mux.scala 69:16]
  wire  _T_163; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_0_3_valid; // @[Mux.scala 69:16]
  wire  _T_367; // @[Mux.scala 69:16]
  wire  _T_369; // @[Mux.scala 69:16]
  wire  _T_371; // @[Mux.scala 69:16]
  wire  _T_373; // @[Mux.scala 69:16]
  wire  _T_375; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_1_3_valid; // @[Mux.scala 69:16]
  reg [63:0] _T_39; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_25;
  wire  _T_177; // @[Mux.scala 69:19]
  wire  _T_175; // @[Mux.scala 69:19]
  wire  _T_173; // @[Mux.scala 69:19]
  wire  _T_171; // @[Mux.scala 69:19]
  wire  _T_169; // @[Mux.scala 69:19]
  wire  _T_167; // @[Mux.scala 69:19]
  wire [31:0] _T_168; // @[Mux.scala 69:16]
  wire [31:0] _T_170; // @[Mux.scala 69:16]
  wire [31:0] _T_172; // @[Mux.scala 69:16]
  wire [31:0] _T_174; // @[Mux.scala 69:16]
  wire [31:0] _T_176; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_0_4_bits; // @[Mux.scala 69:16]
  wire  _T_389; // @[Mux.scala 69:19]
  wire  _T_387; // @[Mux.scala 69:19]
  wire  _T_385; // @[Mux.scala 69:19]
  wire  _T_383; // @[Mux.scala 69:19]
  wire  _T_381; // @[Mux.scala 69:19]
  wire  _T_379; // @[Mux.scala 69:19]
  wire [31:0] _T_380; // @[Mux.scala 69:16]
  wire [31:0] _T_382; // @[Mux.scala 69:16]
  wire [31:0] _T_384; // @[Mux.scala 69:16]
  wire [31:0] _T_386; // @[Mux.scala 69:16]
  wire [31:0] _T_388; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_1_4_bits; // @[Mux.scala 69:16]
  reg  _T_41; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_26;
  wire  _T_181; // @[Mux.scala 69:16]
  wire  _T_183; // @[Mux.scala 69:16]
  wire  _T_185; // @[Mux.scala 69:16]
  wire  _T_187; // @[Mux.scala 69:16]
  wire  _T_189; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_0_4_valid; // @[Mux.scala 69:16]
  wire  _T_393; // @[Mux.scala 69:16]
  wire  _T_395; // @[Mux.scala 69:16]
  wire  _T_397; // @[Mux.scala 69:16]
  wire  _T_399; // @[Mux.scala 69:16]
  wire  _T_401; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_1_4_valid; // @[Mux.scala 69:16]
  reg [63:0] _T_44; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_27;
  wire  _T_203; // @[Mux.scala 69:19]
  wire  _T_201; // @[Mux.scala 69:19]
  wire  _T_199; // @[Mux.scala 69:19]
  wire  _T_197; // @[Mux.scala 69:19]
  wire  _T_195; // @[Mux.scala 69:19]
  wire  _T_193; // @[Mux.scala 69:19]
  wire [31:0] _T_194; // @[Mux.scala 69:16]
  wire [31:0] _T_196; // @[Mux.scala 69:16]
  wire [31:0] _T_198; // @[Mux.scala 69:16]
  wire [31:0] _T_200; // @[Mux.scala 69:16]
  wire [31:0] _T_202; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_0_5_bits; // @[Mux.scala 69:16]
  wire  _T_415; // @[Mux.scala 69:19]
  wire  _T_413; // @[Mux.scala 69:19]
  wire  _T_411; // @[Mux.scala 69:19]
  wire  _T_409; // @[Mux.scala 69:19]
  wire  _T_407; // @[Mux.scala 69:19]
  wire  _T_405; // @[Mux.scala 69:19]
  wire [31:0] _T_406; // @[Mux.scala 69:16]
  wire [31:0] _T_408; // @[Mux.scala 69:16]
  wire [31:0] _T_410; // @[Mux.scala 69:16]
  wire [31:0] _T_412; // @[Mux.scala 69:16]
  wire [31:0] _T_414; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_1_5_bits; // @[Mux.scala 69:16]
  reg  _T_46; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_28;
  wire  _T_207; // @[Mux.scala 69:16]
  wire  _T_209; // @[Mux.scala 69:16]
  wire  _T_211; // @[Mux.scala 69:16]
  wire  _T_213; // @[Mux.scala 69:16]
  wire  _T_215; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_0_5_valid; // @[Mux.scala 69:16]
  wire  _T_419; // @[Mux.scala 69:16]
  wire  _T_421; // @[Mux.scala 69:16]
  wire  _T_423; // @[Mux.scala 69:16]
  wire  _T_425; // @[Mux.scala 69:16]
  wire  _T_427; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_1_5_valid; // @[Mux.scala 69:16]
  reg [63:0] _T_49; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_29;
  wire  _T_229; // @[Mux.scala 69:19]
  wire  _T_227; // @[Mux.scala 69:19]
  wire  _T_225; // @[Mux.scala 69:19]
  wire  _T_223; // @[Mux.scala 69:19]
  wire  _T_221; // @[Mux.scala 69:19]
  wire  _T_219; // @[Mux.scala 69:19]
  wire [31:0] _T_220; // @[Mux.scala 69:16]
  wire [31:0] _T_222; // @[Mux.scala 69:16]
  wire [31:0] _T_224; // @[Mux.scala 69:16]
  wire [31:0] _T_226; // @[Mux.scala 69:16]
  wire [31:0] _T_228; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_0_6_bits; // @[Mux.scala 69:16]
  wire  _T_441; // @[Mux.scala 69:19]
  wire  _T_439; // @[Mux.scala 69:19]
  wire  _T_437; // @[Mux.scala 69:19]
  wire  _T_435; // @[Mux.scala 69:19]
  wire  _T_433; // @[Mux.scala 69:19]
  wire  _T_431; // @[Mux.scala 69:19]
  wire [31:0] _T_432; // @[Mux.scala 69:16]
  wire [31:0] _T_434; // @[Mux.scala 69:16]
  wire [31:0] _T_436; // @[Mux.scala 69:16]
  wire [31:0] _T_438; // @[Mux.scala 69:16]
  wire [31:0] _T_440; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_1_6_bits; // @[Mux.scala 69:16]
  reg  _T_51; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_30;
  wire  _T_233; // @[Mux.scala 69:16]
  wire  _T_235; // @[Mux.scala 69:16]
  wire  _T_237; // @[Mux.scala 69:16]
  wire  _T_239; // @[Mux.scala 69:16]
  wire  _T_241; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_0_6_valid; // @[Mux.scala 69:16]
  wire  _T_445; // @[Mux.scala 69:16]
  wire  _T_447; // @[Mux.scala 69:16]
  wire  _T_449; // @[Mux.scala 69:16]
  wire  _T_451; // @[Mux.scala 69:16]
  wire  _T_453; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_1_6_valid; // @[Mux.scala 69:16]
  reg [63:0] _T_54; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_31;
  wire  _T_255; // @[Mux.scala 69:19]
  wire  _T_253; // @[Mux.scala 69:19]
  wire  _T_251; // @[Mux.scala 69:19]
  wire  _T_249; // @[Mux.scala 69:19]
  wire  _T_247; // @[Mux.scala 69:19]
  wire  _T_245; // @[Mux.scala 69:19]
  wire [31:0] _T_246; // @[Mux.scala 69:16]
  wire [31:0] _T_248; // @[Mux.scala 69:16]
  wire [31:0] _T_250; // @[Mux.scala 69:16]
  wire [31:0] _T_252; // @[Mux.scala 69:16]
  wire [31:0] _T_254; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_0_7_bits; // @[Mux.scala 69:16]
  wire  _T_467; // @[Mux.scala 69:19]
  wire  _T_465; // @[Mux.scala 69:19]
  wire  _T_463; // @[Mux.scala 69:19]
  wire  _T_461; // @[Mux.scala 69:19]
  wire  _T_459; // @[Mux.scala 69:19]
  wire  _T_457; // @[Mux.scala 69:19]
  wire [31:0] _T_458; // @[Mux.scala 69:16]
  wire [31:0] _T_460; // @[Mux.scala 69:16]
  wire [31:0] _T_462; // @[Mux.scala 69:16]
  wire [31:0] _T_464; // @[Mux.scala 69:16]
  wire [31:0] _T_466; // @[Mux.scala 69:16]
  wire [31:0] decomposed_output_ports_1_7_bits; // @[Mux.scala 69:16]
  reg  _T_56; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_32;
  wire  _T_259; // @[Mux.scala 69:16]
  wire  _T_261; // @[Mux.scala 69:16]
  wire  _T_263; // @[Mux.scala 69:16]
  wire  _T_265; // @[Mux.scala 69:16]
  wire  _T_267; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_0_7_valid; // @[Mux.scala 69:16]
  wire  _T_471; // @[Mux.scala 69:16]
  wire  _T_473; // @[Mux.scala 69:16]
  wire  _T_475; // @[Mux.scala 69:16]
  wire  _T_477; // @[Mux.scala 69:16]
  wire  _T_479; // @[Mux.scala 69:16]
  wire  decomposed_output_ports_1_7_valid; // @[Mux.scala 69:16]
  wire [4:0] config_module_id; // @[Router_Hw.scala 148:44]
  wire  module_id_match; // @[Router_Hw.scala 149:49]
  wire [53:0] config_data; // @[Router_Hw.scala 151:39]
  wire  _T_1066; // @[Router_Hw.scala 152:22]
  assign decomposed_input_ports_0_0_bits = io_in_0_bits[31:0]; // @[Router_Hw.scala 174:35]
  assign decomposed_input_ports_1_0_bits = io_in_0_bits[63:32]; // @[Router_Hw.scala 174:35]
  assign _T_542 = config_register_file_0[2:0]; // @[Router_Hw.scala 113:22]
  assign _T_543 = _T_542 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_544 = _T_543 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_545 = config_register_file_0[5:3]; // @[Router_Hw.scala 113:22]
  assign _T_546 = _T_545 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_547 = _T_546 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_569 = _T_544 & _T_547; // @[Router_Hw.scala 116:99]
  assign _T_548 = config_register_file_0[8:6]; // @[Router_Hw.scala 113:22]
  assign _T_549 = _T_548 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_550 = _T_549 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_570 = _T_569 & _T_550; // @[Router_Hw.scala 116:99]
  assign _T_551 = config_register_file_0[11:9]; // @[Router_Hw.scala 113:22]
  assign _T_552 = _T_551 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_553 = _T_552 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_571 = _T_570 & _T_553; // @[Router_Hw.scala 116:99]
  assign _T_554 = config_register_file_0[14:12]; // @[Router_Hw.scala 113:22]
  assign _T_555 = _T_554 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_556 = _T_555 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_572 = _T_571 & _T_556; // @[Router_Hw.scala 116:99]
  assign _T_557 = config_register_file_0[17:15]; // @[Router_Hw.scala 113:22]
  assign _T_558 = _T_557 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_559 = _T_558 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_573 = _T_572 & _T_559; // @[Router_Hw.scala 116:99]
  assign _T_560 = config_register_file_0[20:18]; // @[Router_Hw.scala 113:22]
  assign _T_561 = _T_560 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_562 = _T_561 ? decomposed_output_ports_0_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_574 = _T_573 & _T_562; // @[Router_Hw.scala 116:99]
  assign _T_563 = config_register_file_0[23:21]; // @[Router_Hw.scala 113:22]
  assign _T_564 = _T_563 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_565 = _T_564 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_575 = _T_574 & _T_565; // @[Router_Hw.scala 116:99]
  assign _T_566 = config_register_file_0[50:48]; // @[Router_Hw.scala 113:22]
  assign _T_567 = _T_566 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_568 = _T_567 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_0_ready = _T_575 & _T_568; // @[Router_Hw.scala 116:99]
  assign _T_760 = config_register_file_0[26:24]; // @[Router_Hw.scala 113:22]
  assign _T_761 = _T_760 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_762 = _T_761 ? decomposed_output_ports_1_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_763 = config_register_file_0[29:27]; // @[Router_Hw.scala 113:22]
  assign _T_764 = _T_763 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_765 = _T_764 ? decomposed_output_ports_1_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_787 = _T_762 & _T_765; // @[Router_Hw.scala 116:99]
  assign _T_766 = config_register_file_0[32:30]; // @[Router_Hw.scala 113:22]
  assign _T_767 = _T_766 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_768 = _T_767 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_788 = _T_787 & _T_768; // @[Router_Hw.scala 116:99]
  assign _T_769 = config_register_file_0[35:33]; // @[Router_Hw.scala 113:22]
  assign _T_770 = _T_769 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_771 = _T_770 ? decomposed_output_ports_1_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_789 = _T_788 & _T_771; // @[Router_Hw.scala 116:99]
  assign _T_772 = config_register_file_0[38:36]; // @[Router_Hw.scala 113:22]
  assign _T_773 = _T_772 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_774 = _T_773 ? decomposed_output_ports_1_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_790 = _T_789 & _T_774; // @[Router_Hw.scala 116:99]
  assign _T_775 = config_register_file_0[41:39]; // @[Router_Hw.scala 113:22]
  assign _T_776 = _T_775 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_777 = _T_776 ? decomposed_output_ports_1_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_791 = _T_790 & _T_777; // @[Router_Hw.scala 116:99]
  assign _T_778 = config_register_file_0[44:42]; // @[Router_Hw.scala 113:22]
  assign _T_779 = _T_778 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_780 = _T_779 ? decomposed_output_ports_1_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_792 = _T_791 & _T_780; // @[Router_Hw.scala 116:99]
  assign _T_781 = config_register_file_0[47:45]; // @[Router_Hw.scala 113:22]
  assign _T_782 = _T_781 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_783 = _T_782 ? decomposed_output_ports_1_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_793 = _T_792 & _T_783; // @[Router_Hw.scala 116:99]
  assign _T_784 = config_register_file_0[53:51]; // @[Router_Hw.scala 113:22]
  assign _T_785 = _T_784 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_786 = _T_785 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_1_0_ready = _T_793 & _T_786; // @[Router_Hw.scala 116:99]
  assign decomposed_input_ports_0_1_bits = io_in_1_bits[31:0]; // @[Router_Hw.scala 174:35]
  assign decomposed_input_ports_1_1_bits = io_in_1_bits[63:32]; // @[Router_Hw.scala 174:35]
  assign _T_578 = _T_542 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_579 = _T_578 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_581 = _T_545 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_582 = _T_581 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_604 = _T_579 & _T_582; // @[Router_Hw.scala 116:99]
  assign _T_584 = _T_548 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_585 = _T_584 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_605 = _T_604 & _T_585; // @[Router_Hw.scala 116:99]
  assign _T_587 = _T_551 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_588 = _T_587 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_606 = _T_605 & _T_588; // @[Router_Hw.scala 116:99]
  assign _T_590 = _T_554 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_591 = _T_590 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_607 = _T_606 & _T_591; // @[Router_Hw.scala 116:99]
  assign _T_593 = _T_557 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_594 = _T_593 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_608 = _T_607 & _T_594; // @[Router_Hw.scala 116:99]
  assign _T_596 = _T_560 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_597 = _T_596 ? decomposed_output_ports_0_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_609 = _T_608 & _T_597; // @[Router_Hw.scala 116:99]
  assign _T_599 = _T_563 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_600 = _T_599 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_610 = _T_609 & _T_600; // @[Router_Hw.scala 116:99]
  assign _T_602 = _T_566 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_603 = _T_602 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_1_ready = _T_610 & _T_603; // @[Router_Hw.scala 116:99]
  assign _T_979 = _T_542 == 3'h6; // @[Router_Hw.scala 113:53]
  assign _T_980 = _T_979 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_982 = _T_760 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_983 = _T_982 ? decomposed_output_ports_1_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1011 = _T_980 & _T_983; // @[Router_Hw.scala 116:99]
  assign _T_985 = _T_763 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_986 = _T_985 ? decomposed_output_ports_1_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1012 = _T_1011 & _T_986; // @[Router_Hw.scala 116:99]
  assign _T_988 = _T_766 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_989 = _T_988 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1013 = _T_1012 & _T_989; // @[Router_Hw.scala 116:99]
  assign _T_991 = _T_769 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_992 = _T_991 ? decomposed_output_ports_1_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1014 = _T_1013 & _T_992; // @[Router_Hw.scala 116:99]
  assign _T_994 = _T_772 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_995 = _T_994 ? decomposed_output_ports_1_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1015 = _T_1014 & _T_995; // @[Router_Hw.scala 116:99]
  assign _T_997 = _T_775 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_998 = _T_997 ? decomposed_output_ports_1_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1016 = _T_1015 & _T_998; // @[Router_Hw.scala 116:99]
  assign _T_1000 = _T_778 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_1001 = _T_1000 ? decomposed_output_ports_1_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1017 = _T_1016 & _T_1001; // @[Router_Hw.scala 116:99]
  assign _T_1003 = _T_781 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_1004 = _T_1003 ? decomposed_output_ports_1_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1018 = _T_1017 & _T_1004; // @[Router_Hw.scala 116:99]
  assign _T_1006 = _T_566 == 3'h6; // @[Router_Hw.scala 113:53]
  assign _T_1007 = _T_1006 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1019 = _T_1018 & _T_1007; // @[Router_Hw.scala 116:99]
  assign _T_1009 = _T_784 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_1010 = _T_1009 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_1_1_ready = _T_1019 & _T_1010; // @[Router_Hw.scala 116:99]
  assign decomposed_input_ports_0_2_bits = io_in_2_bits[31:0]; // @[Router_Hw.scala 174:35]
  assign decomposed_input_ports_1_2_bits = io_in_2_bits[63:32]; // @[Router_Hw.scala 174:35]
  assign _T_613 = _T_542 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_614 = _T_613 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_616 = _T_545 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_617 = _T_616 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_639 = _T_614 & _T_617; // @[Router_Hw.scala 116:99]
  assign _T_619 = _T_548 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_620 = _T_619 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_640 = _T_639 & _T_620; // @[Router_Hw.scala 116:99]
  assign _T_622 = _T_551 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_623 = _T_622 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_641 = _T_640 & _T_623; // @[Router_Hw.scala 116:99]
  assign _T_625 = _T_554 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_626 = _T_625 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_642 = _T_641 & _T_626; // @[Router_Hw.scala 116:99]
  assign _T_628 = _T_557 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_629 = _T_628 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_643 = _T_642 & _T_629; // @[Router_Hw.scala 116:99]
  assign _T_631 = _T_560 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_632 = _T_631 ? decomposed_output_ports_0_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_644 = _T_643 & _T_632; // @[Router_Hw.scala 116:99]
  assign _T_634 = _T_563 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_635 = _T_634 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_645 = _T_644 & _T_635; // @[Router_Hw.scala 116:99]
  assign _T_637 = _T_566 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_638 = _T_637 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_2_ready = _T_645 & _T_638; // @[Router_Hw.scala 116:99]
  assign _T_839 = _T_760 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_840 = _T_839 ? decomposed_output_ports_1_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_842 = _T_763 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_843 = _T_842 ? decomposed_output_ports_1_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_865 = _T_840 & _T_843; // @[Router_Hw.scala 116:99]
  assign _T_845 = _T_766 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_846 = _T_845 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_866 = _T_865 & _T_846; // @[Router_Hw.scala 116:99]
  assign _T_848 = _T_769 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_849 = _T_848 ? decomposed_output_ports_1_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_867 = _T_866 & _T_849; // @[Router_Hw.scala 116:99]
  assign _T_851 = _T_772 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_852 = _T_851 ? decomposed_output_ports_1_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_868 = _T_867 & _T_852; // @[Router_Hw.scala 116:99]
  assign _T_854 = _T_775 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_855 = _T_854 ? decomposed_output_ports_1_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_869 = _T_868 & _T_855; // @[Router_Hw.scala 116:99]
  assign _T_857 = _T_778 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_858 = _T_857 ? decomposed_output_ports_1_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_870 = _T_869 & _T_858; // @[Router_Hw.scala 116:99]
  assign _T_860 = _T_781 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_861 = _T_860 ? decomposed_output_ports_1_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_871 = _T_870 & _T_861; // @[Router_Hw.scala 116:99]
  assign _T_863 = _T_784 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_864 = _T_863 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_1_2_ready = _T_871 & _T_864; // @[Router_Hw.scala 116:99]
  assign decomposed_input_ports_0_3_bits = io_in_3_bits[31:0]; // @[Router_Hw.scala 174:35]
  assign decomposed_input_ports_1_3_bits = io_in_3_bits[63:32]; // @[Router_Hw.scala 174:35]
  assign _T_648 = _T_542 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_649 = _T_648 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_651 = _T_545 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_652 = _T_651 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_674 = _T_649 & _T_652; // @[Router_Hw.scala 116:99]
  assign _T_654 = _T_548 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_655 = _T_654 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_675 = _T_674 & _T_655; // @[Router_Hw.scala 116:99]
  assign _T_657 = _T_551 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_658 = _T_657 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_676 = _T_675 & _T_658; // @[Router_Hw.scala 116:99]
  assign _T_660 = _T_554 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_661 = _T_660 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_677 = _T_676 & _T_661; // @[Router_Hw.scala 116:99]
  assign _T_663 = _T_557 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_664 = _T_663 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_678 = _T_677 & _T_664; // @[Router_Hw.scala 116:99]
  assign _T_666 = _T_560 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_667 = _T_666 ? decomposed_output_ports_0_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_679 = _T_678 & _T_667; // @[Router_Hw.scala 116:99]
  assign _T_669 = _T_563 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_670 = _T_669 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_680 = _T_679 & _T_670; // @[Router_Hw.scala 116:99]
  assign _T_672 = _T_566 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_673 = _T_672 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_3_ready = _T_680 & _T_673; // @[Router_Hw.scala 116:99]
  assign _T_874 = _T_760 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_875 = _T_874 ? decomposed_output_ports_1_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_877 = _T_763 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_878 = _T_877 ? decomposed_output_ports_1_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_900 = _T_875 & _T_878; // @[Router_Hw.scala 116:99]
  assign _T_880 = _T_766 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_881 = _T_880 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_901 = _T_900 & _T_881; // @[Router_Hw.scala 116:99]
  assign _T_883 = _T_769 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_884 = _T_883 ? decomposed_output_ports_1_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_902 = _T_901 & _T_884; // @[Router_Hw.scala 116:99]
  assign _T_886 = _T_772 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_887 = _T_886 ? decomposed_output_ports_1_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_903 = _T_902 & _T_887; // @[Router_Hw.scala 116:99]
  assign _T_889 = _T_775 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_890 = _T_889 ? decomposed_output_ports_1_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_904 = _T_903 & _T_890; // @[Router_Hw.scala 116:99]
  assign _T_892 = _T_778 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_893 = _T_892 ? decomposed_output_ports_1_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_905 = _T_904 & _T_893; // @[Router_Hw.scala 116:99]
  assign _T_895 = _T_781 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_896 = _T_895 ? decomposed_output_ports_1_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_906 = _T_905 & _T_896; // @[Router_Hw.scala 116:99]
  assign _T_898 = _T_784 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_899 = _T_898 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_1_3_ready = _T_906 & _T_899; // @[Router_Hw.scala 116:99]
  assign decomposed_input_ports_0_4_bits = io_in_4_bits[31:0]; // @[Router_Hw.scala 174:35]
  assign decomposed_input_ports_1_4_bits = io_in_4_bits[63:32]; // @[Router_Hw.scala 174:35]
  assign _T_683 = _T_542 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_684 = _T_683 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_686 = _T_545 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_687 = _T_686 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_709 = _T_684 & _T_687; // @[Router_Hw.scala 116:99]
  assign _T_689 = _T_548 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_690 = _T_689 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_710 = _T_709 & _T_690; // @[Router_Hw.scala 116:99]
  assign _T_692 = _T_551 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_693 = _T_692 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_711 = _T_710 & _T_693; // @[Router_Hw.scala 116:99]
  assign _T_695 = _T_554 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_696 = _T_695 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_712 = _T_711 & _T_696; // @[Router_Hw.scala 116:99]
  assign _T_698 = _T_557 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_699 = _T_698 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_713 = _T_712 & _T_699; // @[Router_Hw.scala 116:99]
  assign _T_701 = _T_560 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_702 = _T_701 ? decomposed_output_ports_0_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_714 = _T_713 & _T_702; // @[Router_Hw.scala 116:99]
  assign _T_704 = _T_563 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_705 = _T_704 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_715 = _T_714 & _T_705; // @[Router_Hw.scala 116:99]
  assign _T_707 = _T_566 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_708 = _T_707 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_4_ready = _T_715 & _T_708; // @[Router_Hw.scala 116:99]
  assign _T_909 = _T_760 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_910 = _T_909 ? decomposed_output_ports_1_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_912 = _T_763 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_913 = _T_912 ? decomposed_output_ports_1_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_935 = _T_910 & _T_913; // @[Router_Hw.scala 116:99]
  assign _T_915 = _T_766 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_916 = _T_915 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_936 = _T_935 & _T_916; // @[Router_Hw.scala 116:99]
  assign _T_918 = _T_769 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_919 = _T_918 ? decomposed_output_ports_1_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_937 = _T_936 & _T_919; // @[Router_Hw.scala 116:99]
  assign _T_921 = _T_772 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_922 = _T_921 ? decomposed_output_ports_1_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_938 = _T_937 & _T_922; // @[Router_Hw.scala 116:99]
  assign _T_924 = _T_775 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_925 = _T_924 ? decomposed_output_ports_1_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_939 = _T_938 & _T_925; // @[Router_Hw.scala 116:99]
  assign _T_927 = _T_778 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_928 = _T_927 ? decomposed_output_ports_1_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_940 = _T_939 & _T_928; // @[Router_Hw.scala 116:99]
  assign _T_930 = _T_781 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_931 = _T_930 ? decomposed_output_ports_1_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_941 = _T_940 & _T_931; // @[Router_Hw.scala 116:99]
  assign _T_933 = _T_784 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_934 = _T_933 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_1_4_ready = _T_941 & _T_934; // @[Router_Hw.scala 116:99]
  assign _T_14 = decomposed_input_ports_0_4_ready & decomposed_input_ports_1_4_ready; // @[Router_Hw.scala 178:90]
  assign decomposed_input_ports_0_5_bits = io_in_5_bits[31:0]; // @[Router_Hw.scala 174:35]
  assign decomposed_input_ports_1_5_bits = io_in_5_bits[63:32]; // @[Router_Hw.scala 174:35]
  assign _T_1022 = _T_542 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_1023 = _T_1022 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1025 = _T_545 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_1026 = _T_1025 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1054 = _T_1023 & _T_1026; // @[Router_Hw.scala 116:99]
  assign _T_1028 = _T_548 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_1029 = _T_1028 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1055 = _T_1054 & _T_1029; // @[Router_Hw.scala 116:99]
  assign _T_1031 = _T_551 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_1032 = _T_1031 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1056 = _T_1055 & _T_1032; // @[Router_Hw.scala 116:99]
  assign _T_1034 = _T_554 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_1035 = _T_1034 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1057 = _T_1056 & _T_1035; // @[Router_Hw.scala 116:99]
  assign _T_1037 = _T_557 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_1038 = _T_1037 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1058 = _T_1057 & _T_1038; // @[Router_Hw.scala 116:99]
  assign _T_1040 = _T_560 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_1041 = _T_1040 ? decomposed_output_ports_0_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1059 = _T_1058 & _T_1041; // @[Router_Hw.scala 116:99]
  assign _T_1043 = _T_563 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_1044 = _T_1043 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1060 = _T_1059 & _T_1044; // @[Router_Hw.scala 116:99]
  assign _T_1046 = _T_766 == 3'h6; // @[Router_Hw.scala 113:53]
  assign _T_1047 = _T_1046 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1061 = _T_1060 & _T_1047; // @[Router_Hw.scala 116:99]
  assign _T_1049 = _T_566 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_1050 = _T_1049 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_1062 = _T_1061 & _T_1050; // @[Router_Hw.scala 116:99]
  assign _T_1052 = _T_784 == 3'h6; // @[Router_Hw.scala 113:53]
  assign _T_1053 = _T_1052 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_5_ready = _T_1062 & _T_1053; // @[Router_Hw.scala 116:99]
  assign _T_944 = _T_760 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_945 = _T_944 ? decomposed_output_ports_1_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_947 = _T_763 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_948 = _T_947 ? decomposed_output_ports_1_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_970 = _T_945 & _T_948; // @[Router_Hw.scala 116:99]
  assign _T_950 = _T_766 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_951 = _T_950 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_971 = _T_970 & _T_951; // @[Router_Hw.scala 116:99]
  assign _T_953 = _T_769 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_954 = _T_953 ? decomposed_output_ports_1_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_972 = _T_971 & _T_954; // @[Router_Hw.scala 116:99]
  assign _T_956 = _T_772 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_957 = _T_956 ? decomposed_output_ports_1_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_973 = _T_972 & _T_957; // @[Router_Hw.scala 116:99]
  assign _T_959 = _T_775 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_960 = _T_959 ? decomposed_output_ports_1_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_974 = _T_973 & _T_960; // @[Router_Hw.scala 116:99]
  assign _T_962 = _T_778 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_963 = _T_962 ? decomposed_output_ports_1_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_975 = _T_974 & _T_963; // @[Router_Hw.scala 116:99]
  assign _T_965 = _T_781 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_966 = _T_965 ? decomposed_output_ports_1_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_976 = _T_975 & _T_966; // @[Router_Hw.scala 116:99]
  assign _T_968 = _T_784 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_969 = _T_968 ? decomposed_output_ports_1_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_1_5_ready = _T_976 & _T_969; // @[Router_Hw.scala 116:99]
  assign _T_495 = 3'h0 == _T_566; // @[Mux.scala 69:19]
  assign _T_493 = 3'h1 == _T_566; // @[Mux.scala 69:19]
  assign _T_491 = 3'h2 == _T_566; // @[Mux.scala 69:19]
  assign _T_489 = 3'h3 == _T_566; // @[Mux.scala 69:19]
  assign _T_487 = 3'h4 == _T_566; // @[Mux.scala 69:19]
  assign _T_485 = 3'h5 == _T_566; // @[Mux.scala 69:19]
  assign _T_483 = 3'h6 == _T_566; // @[Mux.scala 69:19]
  assign _T_484 = _T_483 ? decomposed_input_ports_1_1_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_486 = _T_485 ? decomposed_input_ports_0_5_bits : _T_484; // @[Mux.scala 69:16]
  assign _T_488 = _T_487 ? decomposed_input_ports_0_4_bits : _T_486; // @[Mux.scala 69:16]
  assign _T_490 = _T_489 ? decomposed_input_ports_0_3_bits : _T_488; // @[Mux.scala 69:16]
  assign _T_492 = _T_491 ? decomposed_input_ports_0_2_bits : _T_490; // @[Mux.scala 69:16]
  assign _T_494 = _T_493 ? decomposed_input_ports_0_1_bits : _T_492; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_0_bits = _T_495 ? decomposed_input_ports_0_0_bits : _T_494; // @[Mux.scala 69:16]
  assign _T_281 = 3'h0 == _T_760; // @[Mux.scala 69:19]
  assign _T_279 = 3'h1 == _T_760; // @[Mux.scala 69:19]
  assign _T_277 = 3'h2 == _T_760; // @[Mux.scala 69:19]
  assign _T_275 = 3'h3 == _T_760; // @[Mux.scala 69:19]
  assign _T_273 = 3'h4 == _T_760; // @[Mux.scala 69:19]
  assign _T_271 = 3'h5 == _T_760; // @[Mux.scala 69:19]
  assign _T_272 = _T_271 ? decomposed_input_ports_1_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_274 = _T_273 ? decomposed_input_ports_1_4_bits : _T_272; // @[Mux.scala 69:16]
  assign _T_276 = _T_275 ? decomposed_input_ports_1_3_bits : _T_274; // @[Mux.scala 69:16]
  assign _T_278 = _T_277 ? decomposed_input_ports_1_2_bits : _T_276; // @[Mux.scala 69:16]
  assign _T_280 = _T_279 ? decomposed_input_ports_1_1_bits : _T_278; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_0_bits = _T_281 ? decomposed_input_ports_1_0_bits : _T_280; // @[Mux.scala 69:16]
  assign _T_499 = _T_483 ? io_in_1_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_501 = _T_485 ? io_in_5_valid : _T_499; // @[Mux.scala 69:16]
  assign _T_503 = _T_487 ? io_in_4_valid : _T_501; // @[Mux.scala 69:16]
  assign _T_505 = _T_489 ? io_in_3_valid : _T_503; // @[Mux.scala 69:16]
  assign _T_507 = _T_491 ? io_in_2_valid : _T_505; // @[Mux.scala 69:16]
  assign _T_509 = _T_493 ? io_in_1_valid : _T_507; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_0_valid = _T_495 ? io_in_0_valid : _T_509; // @[Mux.scala 69:16]
  assign _T_285 = _T_271 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_287 = _T_273 ? io_in_4_valid : _T_285; // @[Mux.scala 69:16]
  assign _T_289 = _T_275 ? io_in_3_valid : _T_287; // @[Mux.scala 69:16]
  assign _T_291 = _T_277 ? io_in_2_valid : _T_289; // @[Mux.scala 69:16]
  assign _T_293 = _T_279 ? io_in_1_valid : _T_291; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_0_valid = _T_281 ? io_in_0_valid : _T_293; // @[Mux.scala 69:16]
  assign _T_99 = 3'h0 == _T_545; // @[Mux.scala 69:19]
  assign _T_97 = 3'h1 == _T_545; // @[Mux.scala 69:19]
  assign _T_95 = 3'h2 == _T_545; // @[Mux.scala 69:19]
  assign _T_93 = 3'h3 == _T_545; // @[Mux.scala 69:19]
  assign _T_91 = 3'h4 == _T_545; // @[Mux.scala 69:19]
  assign _T_89 = 3'h5 == _T_545; // @[Mux.scala 69:19]
  assign _T_90 = _T_89 ? decomposed_input_ports_0_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_92 = _T_91 ? decomposed_input_ports_0_4_bits : _T_90; // @[Mux.scala 69:16]
  assign _T_94 = _T_93 ? decomposed_input_ports_0_3_bits : _T_92; // @[Mux.scala 69:16]
  assign _T_96 = _T_95 ? decomposed_input_ports_0_2_bits : _T_94; // @[Mux.scala 69:16]
  assign _T_98 = _T_97 ? decomposed_input_ports_0_1_bits : _T_96; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_1_bits = _T_99 ? decomposed_input_ports_0_0_bits : _T_98; // @[Mux.scala 69:16]
  assign _T_307 = 3'h0 == _T_763; // @[Mux.scala 69:19]
  assign _T_305 = 3'h1 == _T_763; // @[Mux.scala 69:19]
  assign _T_303 = 3'h2 == _T_763; // @[Mux.scala 69:19]
  assign _T_301 = 3'h3 == _T_763; // @[Mux.scala 69:19]
  assign _T_299 = 3'h4 == _T_763; // @[Mux.scala 69:19]
  assign _T_297 = 3'h5 == _T_763; // @[Mux.scala 69:19]
  assign _T_298 = _T_297 ? decomposed_input_ports_1_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_300 = _T_299 ? decomposed_input_ports_1_4_bits : _T_298; // @[Mux.scala 69:16]
  assign _T_302 = _T_301 ? decomposed_input_ports_1_3_bits : _T_300; // @[Mux.scala 69:16]
  assign _T_304 = _T_303 ? decomposed_input_ports_1_2_bits : _T_302; // @[Mux.scala 69:16]
  assign _T_306 = _T_305 ? decomposed_input_ports_1_1_bits : _T_304; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_1_bits = _T_307 ? decomposed_input_ports_1_0_bits : _T_306; // @[Mux.scala 69:16]
  assign _T_103 = _T_89 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_105 = _T_91 ? io_in_4_valid : _T_103; // @[Mux.scala 69:16]
  assign _T_107 = _T_93 ? io_in_3_valid : _T_105; // @[Mux.scala 69:16]
  assign _T_109 = _T_95 ? io_in_2_valid : _T_107; // @[Mux.scala 69:16]
  assign _T_111 = _T_97 ? io_in_1_valid : _T_109; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_1_valid = _T_99 ? io_in_0_valid : _T_111; // @[Mux.scala 69:16]
  assign _T_311 = _T_297 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_313 = _T_299 ? io_in_4_valid : _T_311; // @[Mux.scala 69:16]
  assign _T_315 = _T_301 ? io_in_3_valid : _T_313; // @[Mux.scala 69:16]
  assign _T_317 = _T_303 ? io_in_2_valid : _T_315; // @[Mux.scala 69:16]
  assign _T_319 = _T_305 ? io_in_1_valid : _T_317; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_1_valid = _T_307 ? io_in_0_valid : _T_319; // @[Mux.scala 69:16]
  assign _T_125 = 3'h0 == _T_548; // @[Mux.scala 69:19]
  assign _T_123 = 3'h1 == _T_548; // @[Mux.scala 69:19]
  assign _T_121 = 3'h2 == _T_548; // @[Mux.scala 69:19]
  assign _T_119 = 3'h3 == _T_548; // @[Mux.scala 69:19]
  assign _T_117 = 3'h4 == _T_548; // @[Mux.scala 69:19]
  assign _T_115 = 3'h5 == _T_548; // @[Mux.scala 69:19]
  assign _T_116 = _T_115 ? decomposed_input_ports_0_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_118 = _T_117 ? decomposed_input_ports_0_4_bits : _T_116; // @[Mux.scala 69:16]
  assign _T_120 = _T_119 ? decomposed_input_ports_0_3_bits : _T_118; // @[Mux.scala 69:16]
  assign _T_122 = _T_121 ? decomposed_input_ports_0_2_bits : _T_120; // @[Mux.scala 69:16]
  assign _T_124 = _T_123 ? decomposed_input_ports_0_1_bits : _T_122; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_2_bits = _T_125 ? decomposed_input_ports_0_0_bits : _T_124; // @[Mux.scala 69:16]
  assign _T_525 = 3'h0 == _T_784; // @[Mux.scala 69:19]
  assign _T_523 = 3'h1 == _T_784; // @[Mux.scala 69:19]
  assign _T_521 = 3'h2 == _T_784; // @[Mux.scala 69:19]
  assign _T_519 = 3'h3 == _T_784; // @[Mux.scala 69:19]
  assign _T_517 = 3'h4 == _T_784; // @[Mux.scala 69:19]
  assign _T_515 = 3'h5 == _T_784; // @[Mux.scala 69:19]
  assign _T_513 = 3'h6 == _T_784; // @[Mux.scala 69:19]
  assign _T_514 = _T_513 ? decomposed_input_ports_0_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_516 = _T_515 ? decomposed_input_ports_1_5_bits : _T_514; // @[Mux.scala 69:16]
  assign _T_518 = _T_517 ? decomposed_input_ports_1_4_bits : _T_516; // @[Mux.scala 69:16]
  assign _T_520 = _T_519 ? decomposed_input_ports_1_3_bits : _T_518; // @[Mux.scala 69:16]
  assign _T_522 = _T_521 ? decomposed_input_ports_1_2_bits : _T_520; // @[Mux.scala 69:16]
  assign _T_524 = _T_523 ? decomposed_input_ports_1_1_bits : _T_522; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_2_bits = _T_525 ? decomposed_input_ports_1_0_bits : _T_524; // @[Mux.scala 69:16]
  assign _T_129 = _T_115 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_131 = _T_117 ? io_in_4_valid : _T_129; // @[Mux.scala 69:16]
  assign _T_133 = _T_119 ? io_in_3_valid : _T_131; // @[Mux.scala 69:16]
  assign _T_135 = _T_121 ? io_in_2_valid : _T_133; // @[Mux.scala 69:16]
  assign _T_137 = _T_123 ? io_in_1_valid : _T_135; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_2_valid = _T_125 ? io_in_0_valid : _T_137; // @[Mux.scala 69:16]
  assign _T_529 = _T_513 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_531 = _T_515 ? io_in_5_valid : _T_529; // @[Mux.scala 69:16]
  assign _T_533 = _T_517 ? io_in_4_valid : _T_531; // @[Mux.scala 69:16]
  assign _T_535 = _T_519 ? io_in_3_valid : _T_533; // @[Mux.scala 69:16]
  assign _T_537 = _T_521 ? io_in_2_valid : _T_535; // @[Mux.scala 69:16]
  assign _T_539 = _T_523 ? io_in_1_valid : _T_537; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_2_valid = _T_525 ? io_in_0_valid : _T_539; // @[Mux.scala 69:16]
  assign _T_151 = 3'h0 == _T_551; // @[Mux.scala 69:19]
  assign _T_149 = 3'h1 == _T_551; // @[Mux.scala 69:19]
  assign _T_147 = 3'h2 == _T_551; // @[Mux.scala 69:19]
  assign _T_145 = 3'h3 == _T_551; // @[Mux.scala 69:19]
  assign _T_143 = 3'h4 == _T_551; // @[Mux.scala 69:19]
  assign _T_141 = 3'h5 == _T_551; // @[Mux.scala 69:19]
  assign _T_142 = _T_141 ? decomposed_input_ports_0_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_144 = _T_143 ? decomposed_input_ports_0_4_bits : _T_142; // @[Mux.scala 69:16]
  assign _T_146 = _T_145 ? decomposed_input_ports_0_3_bits : _T_144; // @[Mux.scala 69:16]
  assign _T_148 = _T_147 ? decomposed_input_ports_0_2_bits : _T_146; // @[Mux.scala 69:16]
  assign _T_150 = _T_149 ? decomposed_input_ports_0_1_bits : _T_148; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_3_bits = _T_151 ? decomposed_input_ports_0_0_bits : _T_150; // @[Mux.scala 69:16]
  assign _T_363 = 3'h0 == _T_769; // @[Mux.scala 69:19]
  assign _T_361 = 3'h1 == _T_769; // @[Mux.scala 69:19]
  assign _T_359 = 3'h2 == _T_769; // @[Mux.scala 69:19]
  assign _T_357 = 3'h3 == _T_769; // @[Mux.scala 69:19]
  assign _T_355 = 3'h4 == _T_769; // @[Mux.scala 69:19]
  assign _T_353 = 3'h5 == _T_769; // @[Mux.scala 69:19]
  assign _T_354 = _T_353 ? decomposed_input_ports_1_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_356 = _T_355 ? decomposed_input_ports_1_4_bits : _T_354; // @[Mux.scala 69:16]
  assign _T_358 = _T_357 ? decomposed_input_ports_1_3_bits : _T_356; // @[Mux.scala 69:16]
  assign _T_360 = _T_359 ? decomposed_input_ports_1_2_bits : _T_358; // @[Mux.scala 69:16]
  assign _T_362 = _T_361 ? decomposed_input_ports_1_1_bits : _T_360; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_3_bits = _T_363 ? decomposed_input_ports_1_0_bits : _T_362; // @[Mux.scala 69:16]
  assign _T_155 = _T_141 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_157 = _T_143 ? io_in_4_valid : _T_155; // @[Mux.scala 69:16]
  assign _T_159 = _T_145 ? io_in_3_valid : _T_157; // @[Mux.scala 69:16]
  assign _T_161 = _T_147 ? io_in_2_valid : _T_159; // @[Mux.scala 69:16]
  assign _T_163 = _T_149 ? io_in_1_valid : _T_161; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_3_valid = _T_151 ? io_in_0_valid : _T_163; // @[Mux.scala 69:16]
  assign _T_367 = _T_353 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_369 = _T_355 ? io_in_4_valid : _T_367; // @[Mux.scala 69:16]
  assign _T_371 = _T_357 ? io_in_3_valid : _T_369; // @[Mux.scala 69:16]
  assign _T_373 = _T_359 ? io_in_2_valid : _T_371; // @[Mux.scala 69:16]
  assign _T_375 = _T_361 ? io_in_1_valid : _T_373; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_3_valid = _T_363 ? io_in_0_valid : _T_375; // @[Mux.scala 69:16]
  assign _T_177 = 3'h0 == _T_554; // @[Mux.scala 69:19]
  assign _T_175 = 3'h1 == _T_554; // @[Mux.scala 69:19]
  assign _T_173 = 3'h2 == _T_554; // @[Mux.scala 69:19]
  assign _T_171 = 3'h3 == _T_554; // @[Mux.scala 69:19]
  assign _T_169 = 3'h4 == _T_554; // @[Mux.scala 69:19]
  assign _T_167 = 3'h5 == _T_554; // @[Mux.scala 69:19]
  assign _T_168 = _T_167 ? decomposed_input_ports_0_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_170 = _T_169 ? decomposed_input_ports_0_4_bits : _T_168; // @[Mux.scala 69:16]
  assign _T_172 = _T_171 ? decomposed_input_ports_0_3_bits : _T_170; // @[Mux.scala 69:16]
  assign _T_174 = _T_173 ? decomposed_input_ports_0_2_bits : _T_172; // @[Mux.scala 69:16]
  assign _T_176 = _T_175 ? decomposed_input_ports_0_1_bits : _T_174; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_4_bits = _T_177 ? decomposed_input_ports_0_0_bits : _T_176; // @[Mux.scala 69:16]
  assign _T_389 = 3'h0 == _T_772; // @[Mux.scala 69:19]
  assign _T_387 = 3'h1 == _T_772; // @[Mux.scala 69:19]
  assign _T_385 = 3'h2 == _T_772; // @[Mux.scala 69:19]
  assign _T_383 = 3'h3 == _T_772; // @[Mux.scala 69:19]
  assign _T_381 = 3'h4 == _T_772; // @[Mux.scala 69:19]
  assign _T_379 = 3'h5 == _T_772; // @[Mux.scala 69:19]
  assign _T_380 = _T_379 ? decomposed_input_ports_1_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_382 = _T_381 ? decomposed_input_ports_1_4_bits : _T_380; // @[Mux.scala 69:16]
  assign _T_384 = _T_383 ? decomposed_input_ports_1_3_bits : _T_382; // @[Mux.scala 69:16]
  assign _T_386 = _T_385 ? decomposed_input_ports_1_2_bits : _T_384; // @[Mux.scala 69:16]
  assign _T_388 = _T_387 ? decomposed_input_ports_1_1_bits : _T_386; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_4_bits = _T_389 ? decomposed_input_ports_1_0_bits : _T_388; // @[Mux.scala 69:16]
  assign _T_181 = _T_167 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_183 = _T_169 ? io_in_4_valid : _T_181; // @[Mux.scala 69:16]
  assign _T_185 = _T_171 ? io_in_3_valid : _T_183; // @[Mux.scala 69:16]
  assign _T_187 = _T_173 ? io_in_2_valid : _T_185; // @[Mux.scala 69:16]
  assign _T_189 = _T_175 ? io_in_1_valid : _T_187; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_4_valid = _T_177 ? io_in_0_valid : _T_189; // @[Mux.scala 69:16]
  assign _T_393 = _T_379 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_395 = _T_381 ? io_in_4_valid : _T_393; // @[Mux.scala 69:16]
  assign _T_397 = _T_383 ? io_in_3_valid : _T_395; // @[Mux.scala 69:16]
  assign _T_399 = _T_385 ? io_in_2_valid : _T_397; // @[Mux.scala 69:16]
  assign _T_401 = _T_387 ? io_in_1_valid : _T_399; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_4_valid = _T_389 ? io_in_0_valid : _T_401; // @[Mux.scala 69:16]
  assign _T_203 = 3'h0 == _T_557; // @[Mux.scala 69:19]
  assign _T_201 = 3'h1 == _T_557; // @[Mux.scala 69:19]
  assign _T_199 = 3'h2 == _T_557; // @[Mux.scala 69:19]
  assign _T_197 = 3'h3 == _T_557; // @[Mux.scala 69:19]
  assign _T_195 = 3'h4 == _T_557; // @[Mux.scala 69:19]
  assign _T_193 = 3'h5 == _T_557; // @[Mux.scala 69:19]
  assign _T_194 = _T_193 ? decomposed_input_ports_0_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_196 = _T_195 ? decomposed_input_ports_0_4_bits : _T_194; // @[Mux.scala 69:16]
  assign _T_198 = _T_197 ? decomposed_input_ports_0_3_bits : _T_196; // @[Mux.scala 69:16]
  assign _T_200 = _T_199 ? decomposed_input_ports_0_2_bits : _T_198; // @[Mux.scala 69:16]
  assign _T_202 = _T_201 ? decomposed_input_ports_0_1_bits : _T_200; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_5_bits = _T_203 ? decomposed_input_ports_0_0_bits : _T_202; // @[Mux.scala 69:16]
  assign _T_415 = 3'h0 == _T_775; // @[Mux.scala 69:19]
  assign _T_413 = 3'h1 == _T_775; // @[Mux.scala 69:19]
  assign _T_411 = 3'h2 == _T_775; // @[Mux.scala 69:19]
  assign _T_409 = 3'h3 == _T_775; // @[Mux.scala 69:19]
  assign _T_407 = 3'h4 == _T_775; // @[Mux.scala 69:19]
  assign _T_405 = 3'h5 == _T_775; // @[Mux.scala 69:19]
  assign _T_406 = _T_405 ? decomposed_input_ports_1_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_408 = _T_407 ? decomposed_input_ports_1_4_bits : _T_406; // @[Mux.scala 69:16]
  assign _T_410 = _T_409 ? decomposed_input_ports_1_3_bits : _T_408; // @[Mux.scala 69:16]
  assign _T_412 = _T_411 ? decomposed_input_ports_1_2_bits : _T_410; // @[Mux.scala 69:16]
  assign _T_414 = _T_413 ? decomposed_input_ports_1_1_bits : _T_412; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_5_bits = _T_415 ? decomposed_input_ports_1_0_bits : _T_414; // @[Mux.scala 69:16]
  assign _T_207 = _T_193 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_209 = _T_195 ? io_in_4_valid : _T_207; // @[Mux.scala 69:16]
  assign _T_211 = _T_197 ? io_in_3_valid : _T_209; // @[Mux.scala 69:16]
  assign _T_213 = _T_199 ? io_in_2_valid : _T_211; // @[Mux.scala 69:16]
  assign _T_215 = _T_201 ? io_in_1_valid : _T_213; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_5_valid = _T_203 ? io_in_0_valid : _T_215; // @[Mux.scala 69:16]
  assign _T_419 = _T_405 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_421 = _T_407 ? io_in_4_valid : _T_419; // @[Mux.scala 69:16]
  assign _T_423 = _T_409 ? io_in_3_valid : _T_421; // @[Mux.scala 69:16]
  assign _T_425 = _T_411 ? io_in_2_valid : _T_423; // @[Mux.scala 69:16]
  assign _T_427 = _T_413 ? io_in_1_valid : _T_425; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_5_valid = _T_415 ? io_in_0_valid : _T_427; // @[Mux.scala 69:16]
  assign _T_229 = 3'h0 == _T_560; // @[Mux.scala 69:19]
  assign _T_227 = 3'h1 == _T_560; // @[Mux.scala 69:19]
  assign _T_225 = 3'h2 == _T_560; // @[Mux.scala 69:19]
  assign _T_223 = 3'h3 == _T_560; // @[Mux.scala 69:19]
  assign _T_221 = 3'h4 == _T_560; // @[Mux.scala 69:19]
  assign _T_219 = 3'h5 == _T_560; // @[Mux.scala 69:19]
  assign _T_220 = _T_219 ? decomposed_input_ports_0_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_222 = _T_221 ? decomposed_input_ports_0_4_bits : _T_220; // @[Mux.scala 69:16]
  assign _T_224 = _T_223 ? decomposed_input_ports_0_3_bits : _T_222; // @[Mux.scala 69:16]
  assign _T_226 = _T_225 ? decomposed_input_ports_0_2_bits : _T_224; // @[Mux.scala 69:16]
  assign _T_228 = _T_227 ? decomposed_input_ports_0_1_bits : _T_226; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_6_bits = _T_229 ? decomposed_input_ports_0_0_bits : _T_228; // @[Mux.scala 69:16]
  assign _T_441 = 3'h0 == _T_778; // @[Mux.scala 69:19]
  assign _T_439 = 3'h1 == _T_778; // @[Mux.scala 69:19]
  assign _T_437 = 3'h2 == _T_778; // @[Mux.scala 69:19]
  assign _T_435 = 3'h3 == _T_778; // @[Mux.scala 69:19]
  assign _T_433 = 3'h4 == _T_778; // @[Mux.scala 69:19]
  assign _T_431 = 3'h5 == _T_778; // @[Mux.scala 69:19]
  assign _T_432 = _T_431 ? decomposed_input_ports_1_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_434 = _T_433 ? decomposed_input_ports_1_4_bits : _T_432; // @[Mux.scala 69:16]
  assign _T_436 = _T_435 ? decomposed_input_ports_1_3_bits : _T_434; // @[Mux.scala 69:16]
  assign _T_438 = _T_437 ? decomposed_input_ports_1_2_bits : _T_436; // @[Mux.scala 69:16]
  assign _T_440 = _T_439 ? decomposed_input_ports_1_1_bits : _T_438; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_6_bits = _T_441 ? decomposed_input_ports_1_0_bits : _T_440; // @[Mux.scala 69:16]
  assign _T_233 = _T_219 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_235 = _T_221 ? io_in_4_valid : _T_233; // @[Mux.scala 69:16]
  assign _T_237 = _T_223 ? io_in_3_valid : _T_235; // @[Mux.scala 69:16]
  assign _T_239 = _T_225 ? io_in_2_valid : _T_237; // @[Mux.scala 69:16]
  assign _T_241 = _T_227 ? io_in_1_valid : _T_239; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_6_valid = _T_229 ? io_in_0_valid : _T_241; // @[Mux.scala 69:16]
  assign _T_445 = _T_431 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_447 = _T_433 ? io_in_4_valid : _T_445; // @[Mux.scala 69:16]
  assign _T_449 = _T_435 ? io_in_3_valid : _T_447; // @[Mux.scala 69:16]
  assign _T_451 = _T_437 ? io_in_2_valid : _T_449; // @[Mux.scala 69:16]
  assign _T_453 = _T_439 ? io_in_1_valid : _T_451; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_6_valid = _T_441 ? io_in_0_valid : _T_453; // @[Mux.scala 69:16]
  assign _T_255 = 3'h0 == _T_563; // @[Mux.scala 69:19]
  assign _T_253 = 3'h1 == _T_563; // @[Mux.scala 69:19]
  assign _T_251 = 3'h2 == _T_563; // @[Mux.scala 69:19]
  assign _T_249 = 3'h3 == _T_563; // @[Mux.scala 69:19]
  assign _T_247 = 3'h4 == _T_563; // @[Mux.scala 69:19]
  assign _T_245 = 3'h5 == _T_563; // @[Mux.scala 69:19]
  assign _T_246 = _T_245 ? decomposed_input_ports_0_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_248 = _T_247 ? decomposed_input_ports_0_4_bits : _T_246; // @[Mux.scala 69:16]
  assign _T_250 = _T_249 ? decomposed_input_ports_0_3_bits : _T_248; // @[Mux.scala 69:16]
  assign _T_252 = _T_251 ? decomposed_input_ports_0_2_bits : _T_250; // @[Mux.scala 69:16]
  assign _T_254 = _T_253 ? decomposed_input_ports_0_1_bits : _T_252; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_7_bits = _T_255 ? decomposed_input_ports_0_0_bits : _T_254; // @[Mux.scala 69:16]
  assign _T_467 = 3'h0 == _T_781; // @[Mux.scala 69:19]
  assign _T_465 = 3'h1 == _T_781; // @[Mux.scala 69:19]
  assign _T_463 = 3'h2 == _T_781; // @[Mux.scala 69:19]
  assign _T_461 = 3'h3 == _T_781; // @[Mux.scala 69:19]
  assign _T_459 = 3'h4 == _T_781; // @[Mux.scala 69:19]
  assign _T_457 = 3'h5 == _T_781; // @[Mux.scala 69:19]
  assign _T_458 = _T_457 ? decomposed_input_ports_1_5_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_460 = _T_459 ? decomposed_input_ports_1_4_bits : _T_458; // @[Mux.scala 69:16]
  assign _T_462 = _T_461 ? decomposed_input_ports_1_3_bits : _T_460; // @[Mux.scala 69:16]
  assign _T_464 = _T_463 ? decomposed_input_ports_1_2_bits : _T_462; // @[Mux.scala 69:16]
  assign _T_466 = _T_465 ? decomposed_input_ports_1_1_bits : _T_464; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_7_bits = _T_467 ? decomposed_input_ports_1_0_bits : _T_466; // @[Mux.scala 69:16]
  assign _T_259 = _T_245 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_261 = _T_247 ? io_in_4_valid : _T_259; // @[Mux.scala 69:16]
  assign _T_263 = _T_249 ? io_in_3_valid : _T_261; // @[Mux.scala 69:16]
  assign _T_265 = _T_251 ? io_in_2_valid : _T_263; // @[Mux.scala 69:16]
  assign _T_267 = _T_253 ? io_in_1_valid : _T_265; // @[Mux.scala 69:16]
  assign decomposed_output_ports_0_7_valid = _T_255 ? io_in_0_valid : _T_267; // @[Mux.scala 69:16]
  assign _T_471 = _T_457 ? io_in_5_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_473 = _T_459 ? io_in_4_valid : _T_471; // @[Mux.scala 69:16]
  assign _T_475 = _T_461 ? io_in_3_valid : _T_473; // @[Mux.scala 69:16]
  assign _T_477 = _T_463 ? io_in_2_valid : _T_475; // @[Mux.scala 69:16]
  assign _T_479 = _T_465 ? io_in_1_valid : _T_477; // @[Mux.scala 69:16]
  assign decomposed_output_ports_1_7_valid = _T_467 ? io_in_0_valid : _T_479; // @[Mux.scala 69:16]
  assign config_module_id = io_in_4_bits[63:59]; // @[Router_Hw.scala 148:44]
  assign module_id_match = config_module_id == 5'he; // @[Router_Hw.scala 149:49]
  assign config_data = io_in_4_bits[53:0]; // @[Router_Hw.scala 151:39]
  assign _T_1066 = io_in_4_config & module_id_match; // @[Router_Hw.scala 152:22]
  assign io_in_0_ready = decomposed_input_ports_0_0_ready & decomposed_input_ports_1_0_ready; // @[Router_Hw.scala 178:33]
  assign io_in_1_ready = decomposed_input_ports_0_1_ready & decomposed_input_ports_1_1_ready; // @[Router_Hw.scala 178:33]
  assign io_in_2_ready = decomposed_input_ports_0_2_ready & decomposed_input_ports_1_2_ready; // @[Router_Hw.scala 178:33]
  assign io_in_3_ready = decomposed_input_ports_0_3_ready & decomposed_input_ports_1_3_ready; // @[Router_Hw.scala 178:33]
  assign io_in_4_ready = io_in_4_config ? io_out_3_ready : _T_14; // @[Router_Hw.scala 178:33 Router_Hw.scala 198:31]
  assign io_in_5_ready = decomposed_input_ports_0_5_ready & decomposed_input_ports_1_5_ready; // @[Router_Hw.scala 178:33]
  assign io_out_0_valid = _T_21; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_19; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = _T_26; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_24; // @[Router_Hw.scala 212:34]
  assign io_out_2_valid = _T_31; // @[Router_Hw.scala 213:35]
  assign io_out_2_bits = _T_29; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = io_in_4_config ? io_in_4_valid : _T_36; // @[Router_Hw.scala 198:31 Router_Hw.scala 204:37]
  assign io_out_3_bits = io_in_4_config ? io_in_4_bits : _T_34; // @[Router_Hw.scala 198:31 Router_Hw.scala 203:36]
  assign io_out_3_config = io_in_4_config; // @[Router_Hw.scala 198:31 Router_Hw.scala 205:38]
  assign io_out_4_valid = _T_41; // @[Router_Hw.scala 213:35]
  assign io_out_4_bits = _T_39; // @[Router_Hw.scala 212:34]
  assign io_out_5_valid = _T_46; // @[Router_Hw.scala 213:35]
  assign io_out_5_bits = _T_44; // @[Router_Hw.scala 212:34]
  assign io_out_6_valid = _T_51; // @[Router_Hw.scala 213:35]
  assign io_out_6_bits = _T_49; // @[Router_Hw.scala 212:34]
  assign io_out_7_valid = _T_56; // @[Router_Hw.scala 213:35]
  assign io_out_7_bits = _T_54; // @[Router_Hw.scala 212:34]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  config_register_file_0 = _RAND_0[53:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  decomposed_output_ports_0_4_ready = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_5_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  decomposed_output_ports_0_6_ready = _RAND_7[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  decomposed_output_ports_0_7_ready = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  decomposed_output_ports_1_0_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  decomposed_output_ports_1_1_ready = _RAND_10[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  decomposed_output_ports_1_2_ready = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  decomposed_output_ports_1_3_ready = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {1{`RANDOM}};
  decomposed_output_ports_1_4_ready = _RAND_13[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  decomposed_output_ports_1_5_ready = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  decomposed_output_ports_1_6_ready = _RAND_15[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {1{`RANDOM}};
  decomposed_output_ports_1_7_ready = _RAND_16[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {2{`RANDOM}};
  _T_19 = _RAND_17[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_18 = {1{`RANDOM}};
  _T_21 = _RAND_18[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_19 = {2{`RANDOM}};
  _T_24 = _RAND_19[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_20 = {1{`RANDOM}};
  _T_26 = _RAND_20[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_21 = {2{`RANDOM}};
  _T_29 = _RAND_21[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_22 = {1{`RANDOM}};
  _T_31 = _RAND_22[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_23 = {2{`RANDOM}};
  _T_34 = _RAND_23[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_24 = {1{`RANDOM}};
  _T_36 = _RAND_24[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_25 = {2{`RANDOM}};
  _T_39 = _RAND_25[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_26 = {1{`RANDOM}};
  _T_41 = _RAND_26[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_27 = {2{`RANDOM}};
  _T_44 = _RAND_27[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_28 = {1{`RANDOM}};
  _T_46 = _RAND_28[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_29 = {2{`RANDOM}};
  _T_49 = _RAND_29[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_30 = {1{`RANDOM}};
  _T_51 = _RAND_30[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_31 = {2{`RANDOM}};
  _T_54 = _RAND_31[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_32 = {1{`RANDOM}};
  _T_56 = _RAND_32[0:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (reset) begin
      config_register_file_0 <= 54'h0;
    end else begin
      if (_T_1066) begin
        config_register_file_0 <= config_data;
      end
    end
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    if (io_in_4_config) begin
      decomposed_output_ports_0_3_ready <= 1'h0;
    end else begin
      decomposed_output_ports_0_3_ready <= io_out_3_ready;
    end
    decomposed_output_ports_0_4_ready <= io_out_4_ready;
    decomposed_output_ports_0_5_ready <= io_out_5_ready;
    decomposed_output_ports_0_6_ready <= io_out_6_ready;
    decomposed_output_ports_0_7_ready <= io_out_7_ready;
    decomposed_output_ports_1_0_ready <= io_out_0_ready;
    decomposed_output_ports_1_1_ready <= io_out_1_ready;
    decomposed_output_ports_1_2_ready <= io_out_2_ready;
    if (io_in_4_config) begin
      decomposed_output_ports_1_3_ready <= 1'h0;
    end else begin
      decomposed_output_ports_1_3_ready <= io_out_3_ready;
    end
    decomposed_output_ports_1_4_ready <= io_out_4_ready;
    decomposed_output_ports_1_5_ready <= io_out_5_ready;
    decomposed_output_ports_1_6_ready <= io_out_6_ready;
    decomposed_output_ports_1_7_ready <= io_out_7_ready;
    _T_19 <= {decomposed_output_ports_0_0_bits,decomposed_output_ports_1_0_bits};
    _T_21 <= decomposed_output_ports_0_0_valid & decomposed_output_ports_1_0_valid;
    _T_24 <= {decomposed_output_ports_0_1_bits,decomposed_output_ports_1_1_bits};
    _T_26 <= decomposed_output_ports_0_1_valid & decomposed_output_ports_1_1_valid;
    _T_29 <= {decomposed_output_ports_0_2_bits,decomposed_output_ports_1_2_bits};
    _T_31 <= decomposed_output_ports_0_2_valid & decomposed_output_ports_1_2_valid;
    _T_34 <= {decomposed_output_ports_0_3_bits,decomposed_output_ports_1_3_bits};
    _T_36 <= decomposed_output_ports_0_3_valid & decomposed_output_ports_1_3_valid;
    _T_39 <= {decomposed_output_ports_0_4_bits,decomposed_output_ports_1_4_bits};
    _T_41 <= decomposed_output_ports_0_4_valid & decomposed_output_ports_1_4_valid;
    _T_44 <= {decomposed_output_ports_0_5_bits,decomposed_output_ports_1_5_bits};
    _T_46 <= decomposed_output_ports_0_5_valid & decomposed_output_ports_1_5_valid;
    _T_49 <= {decomposed_output_ports_0_6_bits,decomposed_output_ports_1_6_bits};
    _T_51 <= decomposed_output_ports_0_6_valid & decomposed_output_ports_1_6_valid;
    _T_54 <= {decomposed_output_ports_0_7_bits,decomposed_output_ports_1_7_bits};
    _T_56 <= decomposed_output_ports_0_7_valid & decomposed_output_ports_1_7_valid;
  end
endmodule
module Router_Hw_2(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_2_config,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready,
  output        io_out_4_valid,
  output [63:0] io_out_4_bits,
  input         io_out_4_ready,
  output        io_out_4_config
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_5; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_6; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_8; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_9; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [63:0] _T_11; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_7;
  reg  _T_12; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_8;
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_9;
  reg [63:0] _T_14; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_10;
  reg  _T_15; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_11;
  reg  decomposed_output_ports_0_4_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_12;
  reg [63:0] _T_17; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_13;
  reg  _T_18; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_14;
  reg [9:0] config_register_file_0; // @[Router_Hw.scala 140:37]
  reg [31:0] _RAND_15;
  wire [1:0] _T_147; // @[Router_Hw.scala 113:22]
  wire  _T_148; // @[Router_Hw.scala 113:53]
  wire  _T_149; // @[Router_Hw.scala 113:10]
  wire [1:0] _T_150; // @[Router_Hw.scala 113:22]
  wire  _T_151; // @[Router_Hw.scala 113:53]
  wire  _T_152; // @[Router_Hw.scala 113:10]
  wire  _T_162; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_153; // @[Router_Hw.scala 113:22]
  wire  _T_154; // @[Router_Hw.scala 113:53]
  wire  _T_155; // @[Router_Hw.scala 113:10]
  wire  _T_163; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_156; // @[Router_Hw.scala 113:22]
  wire  _T_157; // @[Router_Hw.scala 113:53]
  wire  _T_158; // @[Router_Hw.scala 113:10]
  wire  _T_164; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_159; // @[Router_Hw.scala 113:22]
  wire  _T_160; // @[Router_Hw.scala 113:53]
  wire  _T_161; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_2_ready; // @[Router_Hw.scala 116:99]
  wire  _T_20; // @[Mux.scala 69:19]
  wire  _T_22; // @[Mux.scala 69:19]
  wire  _T_24; // @[Mux.scala 69:19]
  wire  _T_26; // @[Mux.scala 69:19]
  wire  _T_38; // @[Mux.scala 69:19]
  wire  _T_40; // @[Mux.scala 69:19]
  wire  _T_42; // @[Mux.scala 69:19]
  wire  _T_44; // @[Mux.scala 69:19]
  wire  _T_56; // @[Mux.scala 69:19]
  wire  _T_58; // @[Mux.scala 69:19]
  wire  _T_60; // @[Mux.scala 69:19]
  wire  _T_62; // @[Mux.scala 69:19]
  wire  _T_74; // @[Mux.scala 69:19]
  wire  _T_76; // @[Mux.scala 69:19]
  wire  _T_78; // @[Mux.scala 69:19]
  wire  _T_80; // @[Mux.scala 69:19]
  wire  _T_92; // @[Mux.scala 69:19]
  wire  _T_94; // @[Mux.scala 69:19]
  wire  _T_96; // @[Mux.scala 69:19]
  wire  _T_98; // @[Mux.scala 69:19]
  wire  _T_110; // @[Router_Hw.scala 113:53]
  wire  _T_111; // @[Router_Hw.scala 113:10]
  wire  _T_113; // @[Router_Hw.scala 113:53]
  wire  _T_114; // @[Router_Hw.scala 113:10]
  wire  _T_116; // @[Router_Hw.scala 113:53]
  wire  _T_117; // @[Router_Hw.scala 113:10]
  wire  _T_119; // @[Router_Hw.scala 113:53]
  wire  _T_120; // @[Router_Hw.scala 113:10]
  wire  _T_122; // @[Router_Hw.scala 113:53]
  wire  _T_123; // @[Router_Hw.scala 113:10]
  wire  _T_124; // @[Router_Hw.scala 116:99]
  wire  _T_125; // @[Router_Hw.scala 116:99]
  wire  _T_126; // @[Router_Hw.scala 116:99]
  wire  _T_129; // @[Router_Hw.scala 113:53]
  wire  _T_130; // @[Router_Hw.scala 113:10]
  wire  _T_132; // @[Router_Hw.scala 113:53]
  wire  _T_133; // @[Router_Hw.scala 113:10]
  wire  _T_135; // @[Router_Hw.scala 113:53]
  wire  _T_136; // @[Router_Hw.scala 113:10]
  wire  _T_138; // @[Router_Hw.scala 113:53]
  wire  _T_139; // @[Router_Hw.scala 113:10]
  wire  _T_141; // @[Router_Hw.scala 113:53]
  wire  _T_142; // @[Router_Hw.scala 113:10]
  wire  _T_143; // @[Router_Hw.scala 116:99]
  wire  _T_144; // @[Router_Hw.scala 116:99]
  wire  _T_145; // @[Router_Hw.scala 116:99]
  wire  _T_167; // @[Router_Hw.scala 113:53]
  wire  _T_168; // @[Router_Hw.scala 113:10]
  wire  _T_170; // @[Router_Hw.scala 113:53]
  wire  _T_171; // @[Router_Hw.scala 113:10]
  wire  _T_173; // @[Router_Hw.scala 113:53]
  wire  _T_174; // @[Router_Hw.scala 113:10]
  wire  _T_176; // @[Router_Hw.scala 113:53]
  wire  _T_177; // @[Router_Hw.scala 113:10]
  wire  _T_179; // @[Router_Hw.scala 113:53]
  wire  _T_180; // @[Router_Hw.scala 113:10]
  wire  _T_181; // @[Router_Hw.scala 116:99]
  wire  _T_182; // @[Router_Hw.scala 116:99]
  wire  _T_183; // @[Router_Hw.scala 116:99]
  wire [4:0] config_module_id; // @[Router_Hw.scala 148:44]
  wire  module_id_match; // @[Router_Hw.scala 149:49]
  wire [9:0] config_data; // @[Router_Hw.scala 151:39]
  wire  _T_187; // @[Router_Hw.scala 152:22]
  assign _T_147 = config_register_file_0[1:0]; // @[Router_Hw.scala 113:22]
  assign _T_148 = _T_147 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_149 = _T_148 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_150 = config_register_file_0[3:2]; // @[Router_Hw.scala 113:22]
  assign _T_151 = _T_150 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_152 = _T_151 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_162 = _T_149 & _T_152; // @[Router_Hw.scala 116:99]
  assign _T_153 = config_register_file_0[5:4]; // @[Router_Hw.scala 113:22]
  assign _T_154 = _T_153 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_155 = _T_154 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_163 = _T_162 & _T_155; // @[Router_Hw.scala 116:99]
  assign _T_156 = config_register_file_0[7:6]; // @[Router_Hw.scala 113:22]
  assign _T_157 = _T_156 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_158 = _T_157 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_164 = _T_163 & _T_158; // @[Router_Hw.scala 116:99]
  assign _T_159 = config_register_file_0[9:8]; // @[Router_Hw.scala 113:22]
  assign _T_160 = _T_159 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_161 = _T_160 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_2_ready = _T_164 & _T_161; // @[Router_Hw.scala 116:99]
  assign _T_20 = 2'h3 == _T_147; // @[Mux.scala 69:19]
  assign _T_22 = 2'h2 == _T_147; // @[Mux.scala 69:19]
  assign _T_24 = 2'h1 == _T_147; // @[Mux.scala 69:19]
  assign _T_26 = 2'h0 == _T_147; // @[Mux.scala 69:19]
  assign _T_38 = 2'h3 == _T_150; // @[Mux.scala 69:19]
  assign _T_40 = 2'h2 == _T_150; // @[Mux.scala 69:19]
  assign _T_42 = 2'h1 == _T_150; // @[Mux.scala 69:19]
  assign _T_44 = 2'h0 == _T_150; // @[Mux.scala 69:19]
  assign _T_56 = 2'h3 == _T_153; // @[Mux.scala 69:19]
  assign _T_58 = 2'h2 == _T_153; // @[Mux.scala 69:19]
  assign _T_60 = 2'h1 == _T_153; // @[Mux.scala 69:19]
  assign _T_62 = 2'h0 == _T_153; // @[Mux.scala 69:19]
  assign _T_74 = 2'h3 == _T_156; // @[Mux.scala 69:19]
  assign _T_76 = 2'h2 == _T_156; // @[Mux.scala 69:19]
  assign _T_78 = 2'h1 == _T_156; // @[Mux.scala 69:19]
  assign _T_80 = 2'h0 == _T_156; // @[Mux.scala 69:19]
  assign _T_92 = 2'h3 == _T_159; // @[Mux.scala 69:19]
  assign _T_94 = 2'h2 == _T_159; // @[Mux.scala 69:19]
  assign _T_96 = 2'h1 == _T_159; // @[Mux.scala 69:19]
  assign _T_98 = 2'h0 == _T_159; // @[Mux.scala 69:19]
  assign _T_110 = _T_147 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_111 = _T_110 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_113 = _T_150 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_114 = _T_113 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_116 = _T_153 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_117 = _T_116 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_119 = _T_156 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_120 = _T_119 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_122 = _T_159 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_123 = _T_122 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_124 = _T_111 & _T_114; // @[Router_Hw.scala 116:99]
  assign _T_125 = _T_124 & _T_117; // @[Router_Hw.scala 116:99]
  assign _T_126 = _T_125 & _T_120; // @[Router_Hw.scala 116:99]
  assign _T_129 = _T_147 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_130 = _T_129 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_132 = _T_150 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_133 = _T_132 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_135 = _T_153 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_136 = _T_135 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_138 = _T_156 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_139 = _T_138 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_141 = _T_159 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_142 = _T_141 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_143 = _T_130 & _T_133; // @[Router_Hw.scala 116:99]
  assign _T_144 = _T_143 & _T_136; // @[Router_Hw.scala 116:99]
  assign _T_145 = _T_144 & _T_139; // @[Router_Hw.scala 116:99]
  assign _T_167 = _T_147 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_168 = _T_167 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_170 = _T_150 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_171 = _T_170 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_173 = _T_153 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_174 = _T_173 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_176 = _T_156 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_177 = _T_176 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_179 = _T_159 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_180 = _T_179 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_181 = _T_168 & _T_171; // @[Router_Hw.scala 116:99]
  assign _T_182 = _T_181 & _T_174; // @[Router_Hw.scala 116:99]
  assign _T_183 = _T_182 & _T_177; // @[Router_Hw.scala 116:99]
  assign config_module_id = io_in_2_bits[63:59]; // @[Router_Hw.scala 148:44]
  assign module_id_match = config_module_id == 5'h11; // @[Router_Hw.scala 149:49]
  assign config_data = io_in_2_bits[9:0]; // @[Router_Hw.scala 151:39]
  assign _T_187 = io_in_2_config & module_id_match; // @[Router_Hw.scala 152:22]
  assign io_in_0_ready = _T_126 & _T_123; // @[Router_Hw.scala 178:33]
  assign io_in_1_ready = _T_145 & _T_142; // @[Router_Hw.scala 178:33]
  assign io_in_2_ready = io_in_2_config ? io_out_4_ready : decomposed_input_ports_0_2_ready; // @[Router_Hw.scala 178:33 Router_Hw.scala 198:31]
  assign io_in_3_ready = _T_183 & _T_180; // @[Router_Hw.scala 178:33]
  assign io_out_0_valid = _T_6; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_5; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = _T_9; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_8; // @[Router_Hw.scala 212:34]
  assign io_out_2_valid = _T_12; // @[Router_Hw.scala 213:35]
  assign io_out_2_bits = _T_11; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = _T_15; // @[Router_Hw.scala 213:35]
  assign io_out_3_bits = _T_14; // @[Router_Hw.scala 212:34]
  assign io_out_4_valid = io_in_2_config ? io_in_2_valid : _T_18; // @[Router_Hw.scala 198:31 Router_Hw.scala 204:37]
  assign io_out_4_bits = io_in_2_config ? io_in_2_bits : _T_17; // @[Router_Hw.scala 198:31 Router_Hw.scala 203:36]
  assign io_out_4_config = io_in_2_config; // @[Router_Hw.scala 198:31 Router_Hw.scala 205:38]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_5 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_6 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_8 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_9 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_11 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_12 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {2{`RANDOM}};
  _T_14 = _RAND_10[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  _T_15 = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  decomposed_output_ports_0_4_ready = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {2{`RANDOM}};
  _T_17 = _RAND_13[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  _T_18 = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  config_register_file_0 = _RAND_15[9:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (_T_26) begin
      _T_5 <= io_in_0_bits;
    end else begin
      if (_T_24) begin
        _T_5 <= io_in_1_bits;
      end else begin
        if (_T_22) begin
          _T_5 <= io_in_2_bits;
        end else begin
          if (_T_20) begin
            _T_5 <= io_in_3_bits;
          end else begin
            _T_5 <= 64'h0;
          end
        end
      end
    end
    if (_T_26) begin
      _T_6 <= io_in_0_valid;
    end else begin
      if (_T_24) begin
        _T_6 <= io_in_1_valid;
      end else begin
        if (_T_22) begin
          _T_6 <= io_in_2_valid;
        end else begin
          if (_T_20) begin
            _T_6 <= io_in_3_valid;
          end else begin
            _T_6 <= 1'h0;
          end
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (_T_44) begin
      _T_8 <= io_in_0_bits;
    end else begin
      if (_T_42) begin
        _T_8 <= io_in_1_bits;
      end else begin
        if (_T_40) begin
          _T_8 <= io_in_2_bits;
        end else begin
          if (_T_38) begin
            _T_8 <= io_in_3_bits;
          end else begin
            _T_8 <= 64'h0;
          end
        end
      end
    end
    if (_T_44) begin
      _T_9 <= io_in_0_valid;
    end else begin
      if (_T_42) begin
        _T_9 <= io_in_1_valid;
      end else begin
        if (_T_40) begin
          _T_9 <= io_in_2_valid;
        end else begin
          if (_T_38) begin
            _T_9 <= io_in_3_valid;
          end else begin
            _T_9 <= 1'h0;
          end
        end
      end
    end
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    if (_T_62) begin
      _T_11 <= io_in_0_bits;
    end else begin
      if (_T_60) begin
        _T_11 <= io_in_1_bits;
      end else begin
        if (_T_58) begin
          _T_11 <= io_in_2_bits;
        end else begin
          if (_T_56) begin
            _T_11 <= io_in_3_bits;
          end else begin
            _T_11 <= 64'h0;
          end
        end
      end
    end
    if (_T_62) begin
      _T_12 <= io_in_0_valid;
    end else begin
      if (_T_60) begin
        _T_12 <= io_in_1_valid;
      end else begin
        if (_T_58) begin
          _T_12 <= io_in_2_valid;
        end else begin
          if (_T_56) begin
            _T_12 <= io_in_3_valid;
          end else begin
            _T_12 <= 1'h0;
          end
        end
      end
    end
    decomposed_output_ports_0_3_ready <= io_out_3_ready;
    if (_T_80) begin
      _T_14 <= io_in_0_bits;
    end else begin
      if (_T_78) begin
        _T_14 <= io_in_1_bits;
      end else begin
        if (_T_76) begin
          _T_14 <= io_in_2_bits;
        end else begin
          if (_T_74) begin
            _T_14 <= io_in_3_bits;
          end else begin
            _T_14 <= 64'h0;
          end
        end
      end
    end
    if (_T_80) begin
      _T_15 <= io_in_0_valid;
    end else begin
      if (_T_78) begin
        _T_15 <= io_in_1_valid;
      end else begin
        if (_T_76) begin
          _T_15 <= io_in_2_valid;
        end else begin
          if (_T_74) begin
            _T_15 <= io_in_3_valid;
          end else begin
            _T_15 <= 1'h0;
          end
        end
      end
    end
    if (io_in_2_config) begin
      decomposed_output_ports_0_4_ready <= 1'h0;
    end else begin
      decomposed_output_ports_0_4_ready <= io_out_4_ready;
    end
    if (_T_98) begin
      _T_17 <= io_in_0_bits;
    end else begin
      if (_T_96) begin
        _T_17 <= io_in_1_bits;
      end else begin
        if (_T_94) begin
          _T_17 <= io_in_2_bits;
        end else begin
          if (_T_92) begin
            _T_17 <= io_in_3_bits;
          end else begin
            _T_17 <= 64'h0;
          end
        end
      end
    end
    if (_T_98) begin
      _T_18 <= io_in_0_valid;
    end else begin
      if (_T_96) begin
        _T_18 <= io_in_1_valid;
      end else begin
        if (_T_94) begin
          _T_18 <= io_in_2_valid;
        end else begin
          if (_T_92) begin
            _T_18 <= io_in_3_valid;
          end else begin
            _T_18 <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 10'h0;
    end else begin
      if (_T_187) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Router_Hw_3(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  input         io_in_4_valid,
  input  [63:0] io_in_4_bits,
  output        io_in_4_ready,
  input         io_in_4_config,
  input         io_in_5_valid,
  input  [63:0] io_in_5_bits,
  output        io_in_5_ready,
  input         io_in_6_valid,
  input  [63:0] io_in_6_bits,
  output        io_in_6_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready,
  output        io_out_4_valid,
  output [63:0] io_out_4_bits,
  input         io_out_4_ready,
  output        io_out_5_valid,
  output [63:0] io_out_5_bits,
  input         io_out_5_ready,
  output        io_out_7_valid,
  output [63:0] io_out_7_bits,
  input         io_out_7_ready,
  output        io_out_7_config
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_8; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_9; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_11; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_12; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [63:0] _T_17; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_7;
  reg  _T_18; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_8;
  reg  decomposed_output_ports_0_4_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_9;
  reg [63:0] _T_20; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_10;
  reg  _T_21; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_11;
  reg  decomposed_output_ports_0_5_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_12;
  reg [63:0] _T_23; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_13;
  reg  _T_24; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_14;
  reg  decomposed_output_ports_0_7_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_15;
  reg [63:0] _T_29; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_16;
  reg  _T_30; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_17;
  reg [23:0] config_register_file_0; // @[Router_Hw.scala 140:37]
  reg [31:0] _RAND_18;
  wire [2:0] _T_395; // @[Router_Hw.scala 113:22]
  wire  _T_396; // @[Router_Hw.scala 113:53]
  wire  _T_397; // @[Router_Hw.scala 113:10]
  wire [2:0] _T_398; // @[Router_Hw.scala 113:22]
  wire  _T_399; // @[Router_Hw.scala 113:53]
  wire  _T_400; // @[Router_Hw.scala 113:10]
  wire  _T_419; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_404; // @[Router_Hw.scala 113:22]
  wire  _T_405; // @[Router_Hw.scala 113:53]
  wire  _T_406; // @[Router_Hw.scala 113:10]
  wire  _T_421; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_407; // @[Router_Hw.scala 113:22]
  wire  _T_408; // @[Router_Hw.scala 113:53]
  wire  _T_409; // @[Router_Hw.scala 113:10]
  wire  _T_422; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_410; // @[Router_Hw.scala 113:22]
  wire  _T_411; // @[Router_Hw.scala 113:53]
  wire  _T_412; // @[Router_Hw.scala 113:10]
  wire  _T_423; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_416; // @[Router_Hw.scala 113:22]
  wire  _T_417; // @[Router_Hw.scala 113:53]
  wire  _T_418; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_4_ready; // @[Router_Hw.scala 116:99]
  wire  _T_32; // @[Mux.scala 69:19]
  wire  _T_34; // @[Mux.scala 69:19]
  wire  _T_36; // @[Mux.scala 69:19]
  wire  _T_38; // @[Mux.scala 69:19]
  wire  _T_40; // @[Mux.scala 69:19]
  wire  _T_42; // @[Mux.scala 69:19]
  wire  _T_44; // @[Mux.scala 69:19]
  wire  _T_62; // @[Mux.scala 69:19]
  wire  _T_64; // @[Mux.scala 69:19]
  wire  _T_66; // @[Mux.scala 69:19]
  wire  _T_68; // @[Mux.scala 69:19]
  wire  _T_70; // @[Mux.scala 69:19]
  wire  _T_72; // @[Mux.scala 69:19]
  wire  _T_74; // @[Mux.scala 69:19]
  wire  _T_122; // @[Mux.scala 69:19]
  wire  _T_124; // @[Mux.scala 69:19]
  wire  _T_126; // @[Mux.scala 69:19]
  wire  _T_128; // @[Mux.scala 69:19]
  wire  _T_130; // @[Mux.scala 69:19]
  wire  _T_132; // @[Mux.scala 69:19]
  wire  _T_134; // @[Mux.scala 69:19]
  wire  _T_152; // @[Mux.scala 69:19]
  wire  _T_154; // @[Mux.scala 69:19]
  wire  _T_156; // @[Mux.scala 69:19]
  wire  _T_158; // @[Mux.scala 69:19]
  wire  _T_160; // @[Mux.scala 69:19]
  wire  _T_162; // @[Mux.scala 69:19]
  wire  _T_164; // @[Mux.scala 69:19]
  wire  _T_182; // @[Mux.scala 69:19]
  wire  _T_184; // @[Mux.scala 69:19]
  wire  _T_186; // @[Mux.scala 69:19]
  wire  _T_188; // @[Mux.scala 69:19]
  wire  _T_190; // @[Mux.scala 69:19]
  wire  _T_192; // @[Mux.scala 69:19]
  wire  _T_194; // @[Mux.scala 69:19]
  wire  _T_242; // @[Mux.scala 69:19]
  wire  _T_244; // @[Mux.scala 69:19]
  wire  _T_246; // @[Mux.scala 69:19]
  wire  _T_248; // @[Mux.scala 69:19]
  wire  _T_250; // @[Mux.scala 69:19]
  wire  _T_252; // @[Mux.scala 69:19]
  wire  _T_254; // @[Mux.scala 69:19]
  wire  _T_272; // @[Router_Hw.scala 113:53]
  wire  _T_273; // @[Router_Hw.scala 113:10]
  wire  _T_275; // @[Router_Hw.scala 113:53]
  wire  _T_276; // @[Router_Hw.scala 113:10]
  wire  _T_281; // @[Router_Hw.scala 113:53]
  wire  _T_282; // @[Router_Hw.scala 113:10]
  wire  _T_284; // @[Router_Hw.scala 113:53]
  wire  _T_285; // @[Router_Hw.scala 113:10]
  wire  _T_287; // @[Router_Hw.scala 113:53]
  wire  _T_288; // @[Router_Hw.scala 113:10]
  wire  _T_293; // @[Router_Hw.scala 113:53]
  wire  _T_294; // @[Router_Hw.scala 113:10]
  wire  _T_295; // @[Router_Hw.scala 116:99]
  wire  _T_297; // @[Router_Hw.scala 116:99]
  wire  _T_298; // @[Router_Hw.scala 116:99]
  wire  _T_299; // @[Router_Hw.scala 116:99]
  wire  _T_303; // @[Router_Hw.scala 113:53]
  wire  _T_304; // @[Router_Hw.scala 113:10]
  wire  _T_306; // @[Router_Hw.scala 113:53]
  wire  _T_307; // @[Router_Hw.scala 113:10]
  wire  _T_312; // @[Router_Hw.scala 113:53]
  wire  _T_313; // @[Router_Hw.scala 113:10]
  wire  _T_315; // @[Router_Hw.scala 113:53]
  wire  _T_316; // @[Router_Hw.scala 113:10]
  wire  _T_318; // @[Router_Hw.scala 113:53]
  wire  _T_319; // @[Router_Hw.scala 113:10]
  wire  _T_324; // @[Router_Hw.scala 113:53]
  wire  _T_325; // @[Router_Hw.scala 113:10]
  wire  _T_326; // @[Router_Hw.scala 116:99]
  wire  _T_328; // @[Router_Hw.scala 116:99]
  wire  _T_329; // @[Router_Hw.scala 116:99]
  wire  _T_330; // @[Router_Hw.scala 116:99]
  wire  _T_334; // @[Router_Hw.scala 113:53]
  wire  _T_335; // @[Router_Hw.scala 113:10]
  wire  _T_337; // @[Router_Hw.scala 113:53]
  wire  _T_338; // @[Router_Hw.scala 113:10]
  wire  _T_343; // @[Router_Hw.scala 113:53]
  wire  _T_344; // @[Router_Hw.scala 113:10]
  wire  _T_346; // @[Router_Hw.scala 113:53]
  wire  _T_347; // @[Router_Hw.scala 113:10]
  wire  _T_349; // @[Router_Hw.scala 113:53]
  wire  _T_350; // @[Router_Hw.scala 113:10]
  wire  _T_355; // @[Router_Hw.scala 113:53]
  wire  _T_356; // @[Router_Hw.scala 113:10]
  wire  _T_357; // @[Router_Hw.scala 116:99]
  wire  _T_359; // @[Router_Hw.scala 116:99]
  wire  _T_360; // @[Router_Hw.scala 116:99]
  wire  _T_361; // @[Router_Hw.scala 116:99]
  wire  _T_365; // @[Router_Hw.scala 113:53]
  wire  _T_366; // @[Router_Hw.scala 113:10]
  wire  _T_368; // @[Router_Hw.scala 113:53]
  wire  _T_369; // @[Router_Hw.scala 113:10]
  wire  _T_374; // @[Router_Hw.scala 113:53]
  wire  _T_375; // @[Router_Hw.scala 113:10]
  wire  _T_377; // @[Router_Hw.scala 113:53]
  wire  _T_378; // @[Router_Hw.scala 113:10]
  wire  _T_380; // @[Router_Hw.scala 113:53]
  wire  _T_381; // @[Router_Hw.scala 113:10]
  wire  _T_386; // @[Router_Hw.scala 113:53]
  wire  _T_387; // @[Router_Hw.scala 113:10]
  wire  _T_388; // @[Router_Hw.scala 116:99]
  wire  _T_390; // @[Router_Hw.scala 116:99]
  wire  _T_391; // @[Router_Hw.scala 116:99]
  wire  _T_392; // @[Router_Hw.scala 116:99]
  wire  _T_427; // @[Router_Hw.scala 113:53]
  wire  _T_428; // @[Router_Hw.scala 113:10]
  wire  _T_430; // @[Router_Hw.scala 113:53]
  wire  _T_431; // @[Router_Hw.scala 113:10]
  wire  _T_436; // @[Router_Hw.scala 113:53]
  wire  _T_437; // @[Router_Hw.scala 113:10]
  wire  _T_439; // @[Router_Hw.scala 113:53]
  wire  _T_440; // @[Router_Hw.scala 113:10]
  wire  _T_442; // @[Router_Hw.scala 113:53]
  wire  _T_443; // @[Router_Hw.scala 113:10]
  wire  _T_448; // @[Router_Hw.scala 113:53]
  wire  _T_449; // @[Router_Hw.scala 113:10]
  wire  _T_450; // @[Router_Hw.scala 116:99]
  wire  _T_452; // @[Router_Hw.scala 116:99]
  wire  _T_453; // @[Router_Hw.scala 116:99]
  wire  _T_454; // @[Router_Hw.scala 116:99]
  wire  _T_458; // @[Router_Hw.scala 113:53]
  wire  _T_459; // @[Router_Hw.scala 113:10]
  wire  _T_461; // @[Router_Hw.scala 113:53]
  wire  _T_462; // @[Router_Hw.scala 113:10]
  wire  _T_467; // @[Router_Hw.scala 113:53]
  wire  _T_468; // @[Router_Hw.scala 113:10]
  wire  _T_470; // @[Router_Hw.scala 113:53]
  wire  _T_471; // @[Router_Hw.scala 113:10]
  wire  _T_473; // @[Router_Hw.scala 113:53]
  wire  _T_474; // @[Router_Hw.scala 113:10]
  wire  _T_479; // @[Router_Hw.scala 113:53]
  wire  _T_480; // @[Router_Hw.scala 113:10]
  wire  _T_481; // @[Router_Hw.scala 116:99]
  wire  _T_483; // @[Router_Hw.scala 116:99]
  wire  _T_484; // @[Router_Hw.scala 116:99]
  wire  _T_485; // @[Router_Hw.scala 116:99]
  wire [4:0] config_module_id; // @[Router_Hw.scala 148:44]
  wire  module_id_match; // @[Router_Hw.scala 149:49]
  wire [23:0] config_data; // @[Router_Hw.scala 151:39]
  wire  _T_490; // @[Router_Hw.scala 152:22]
  assign _T_395 = config_register_file_0[2:0]; // @[Router_Hw.scala 113:22]
  assign _T_396 = _T_395 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_397 = _T_396 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_398 = config_register_file_0[5:3]; // @[Router_Hw.scala 113:22]
  assign _T_399 = _T_398 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_400 = _T_399 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_419 = _T_397 & _T_400; // @[Router_Hw.scala 116:99]
  assign _T_404 = config_register_file_0[11:9]; // @[Router_Hw.scala 113:22]
  assign _T_405 = _T_404 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_406 = _T_405 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_421 = _T_419 & _T_406; // @[Router_Hw.scala 116:99]
  assign _T_407 = config_register_file_0[14:12]; // @[Router_Hw.scala 113:22]
  assign _T_408 = _T_407 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_409 = _T_408 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_422 = _T_421 & _T_409; // @[Router_Hw.scala 116:99]
  assign _T_410 = config_register_file_0[17:15]; // @[Router_Hw.scala 113:22]
  assign _T_411 = _T_410 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_412 = _T_411 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_423 = _T_422 & _T_412; // @[Router_Hw.scala 116:99]
  assign _T_416 = config_register_file_0[23:21]; // @[Router_Hw.scala 113:22]
  assign _T_417 = _T_416 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_418 = _T_417 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_4_ready = _T_423 & _T_418; // @[Router_Hw.scala 116:99]
  assign _T_32 = 3'h6 == _T_395; // @[Mux.scala 69:19]
  assign _T_34 = 3'h5 == _T_395; // @[Mux.scala 69:19]
  assign _T_36 = 3'h4 == _T_395; // @[Mux.scala 69:19]
  assign _T_38 = 3'h3 == _T_395; // @[Mux.scala 69:19]
  assign _T_40 = 3'h2 == _T_395; // @[Mux.scala 69:19]
  assign _T_42 = 3'h1 == _T_395; // @[Mux.scala 69:19]
  assign _T_44 = 3'h0 == _T_395; // @[Mux.scala 69:19]
  assign _T_62 = 3'h6 == _T_398; // @[Mux.scala 69:19]
  assign _T_64 = 3'h5 == _T_398; // @[Mux.scala 69:19]
  assign _T_66 = 3'h4 == _T_398; // @[Mux.scala 69:19]
  assign _T_68 = 3'h3 == _T_398; // @[Mux.scala 69:19]
  assign _T_70 = 3'h2 == _T_398; // @[Mux.scala 69:19]
  assign _T_72 = 3'h1 == _T_398; // @[Mux.scala 69:19]
  assign _T_74 = 3'h0 == _T_398; // @[Mux.scala 69:19]
  assign _T_122 = 3'h6 == _T_404; // @[Mux.scala 69:19]
  assign _T_124 = 3'h5 == _T_404; // @[Mux.scala 69:19]
  assign _T_126 = 3'h4 == _T_404; // @[Mux.scala 69:19]
  assign _T_128 = 3'h3 == _T_404; // @[Mux.scala 69:19]
  assign _T_130 = 3'h2 == _T_404; // @[Mux.scala 69:19]
  assign _T_132 = 3'h1 == _T_404; // @[Mux.scala 69:19]
  assign _T_134 = 3'h0 == _T_404; // @[Mux.scala 69:19]
  assign _T_152 = 3'h6 == _T_407; // @[Mux.scala 69:19]
  assign _T_154 = 3'h5 == _T_407; // @[Mux.scala 69:19]
  assign _T_156 = 3'h4 == _T_407; // @[Mux.scala 69:19]
  assign _T_158 = 3'h3 == _T_407; // @[Mux.scala 69:19]
  assign _T_160 = 3'h2 == _T_407; // @[Mux.scala 69:19]
  assign _T_162 = 3'h1 == _T_407; // @[Mux.scala 69:19]
  assign _T_164 = 3'h0 == _T_407; // @[Mux.scala 69:19]
  assign _T_182 = 3'h6 == _T_410; // @[Mux.scala 69:19]
  assign _T_184 = 3'h5 == _T_410; // @[Mux.scala 69:19]
  assign _T_186 = 3'h4 == _T_410; // @[Mux.scala 69:19]
  assign _T_188 = 3'h3 == _T_410; // @[Mux.scala 69:19]
  assign _T_190 = 3'h2 == _T_410; // @[Mux.scala 69:19]
  assign _T_192 = 3'h1 == _T_410; // @[Mux.scala 69:19]
  assign _T_194 = 3'h0 == _T_410; // @[Mux.scala 69:19]
  assign _T_242 = 3'h6 == _T_416; // @[Mux.scala 69:19]
  assign _T_244 = 3'h5 == _T_416; // @[Mux.scala 69:19]
  assign _T_246 = 3'h4 == _T_416; // @[Mux.scala 69:19]
  assign _T_248 = 3'h3 == _T_416; // @[Mux.scala 69:19]
  assign _T_250 = 3'h2 == _T_416; // @[Mux.scala 69:19]
  assign _T_252 = 3'h1 == _T_416; // @[Mux.scala 69:19]
  assign _T_254 = 3'h0 == _T_416; // @[Mux.scala 69:19]
  assign _T_272 = _T_395 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_273 = _T_272 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_275 = _T_398 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_276 = _T_275 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_281 = _T_404 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_282 = _T_281 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_284 = _T_407 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_285 = _T_284 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_287 = _T_410 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_288 = _T_287 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_293 = _T_416 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_294 = _T_293 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_295 = _T_273 & _T_276; // @[Router_Hw.scala 116:99]
  assign _T_297 = _T_295 & _T_282; // @[Router_Hw.scala 116:99]
  assign _T_298 = _T_297 & _T_285; // @[Router_Hw.scala 116:99]
  assign _T_299 = _T_298 & _T_288; // @[Router_Hw.scala 116:99]
  assign _T_303 = _T_395 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_304 = _T_303 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_306 = _T_398 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_307 = _T_306 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_312 = _T_404 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_313 = _T_312 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_315 = _T_407 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_316 = _T_315 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_318 = _T_410 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_319 = _T_318 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_324 = _T_416 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_325 = _T_324 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_326 = _T_304 & _T_307; // @[Router_Hw.scala 116:99]
  assign _T_328 = _T_326 & _T_313; // @[Router_Hw.scala 116:99]
  assign _T_329 = _T_328 & _T_316; // @[Router_Hw.scala 116:99]
  assign _T_330 = _T_329 & _T_319; // @[Router_Hw.scala 116:99]
  assign _T_334 = _T_395 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_335 = _T_334 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_337 = _T_398 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_338 = _T_337 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_343 = _T_404 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_344 = _T_343 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_346 = _T_407 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_347 = _T_346 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_349 = _T_410 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_350 = _T_349 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_355 = _T_416 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_356 = _T_355 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_357 = _T_335 & _T_338; // @[Router_Hw.scala 116:99]
  assign _T_359 = _T_357 & _T_344; // @[Router_Hw.scala 116:99]
  assign _T_360 = _T_359 & _T_347; // @[Router_Hw.scala 116:99]
  assign _T_361 = _T_360 & _T_350; // @[Router_Hw.scala 116:99]
  assign _T_365 = _T_395 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_366 = _T_365 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_368 = _T_398 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_369 = _T_368 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_374 = _T_404 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_375 = _T_374 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_377 = _T_407 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_378 = _T_377 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_380 = _T_410 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_381 = _T_380 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_386 = _T_416 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_387 = _T_386 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_388 = _T_366 & _T_369; // @[Router_Hw.scala 116:99]
  assign _T_390 = _T_388 & _T_375; // @[Router_Hw.scala 116:99]
  assign _T_391 = _T_390 & _T_378; // @[Router_Hw.scala 116:99]
  assign _T_392 = _T_391 & _T_381; // @[Router_Hw.scala 116:99]
  assign _T_427 = _T_395 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_428 = _T_427 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_430 = _T_398 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_431 = _T_430 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_436 = _T_404 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_437 = _T_436 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_439 = _T_407 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_440 = _T_439 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_442 = _T_410 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_443 = _T_442 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_448 = _T_416 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_449 = _T_448 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_450 = _T_428 & _T_431; // @[Router_Hw.scala 116:99]
  assign _T_452 = _T_450 & _T_437; // @[Router_Hw.scala 116:99]
  assign _T_453 = _T_452 & _T_440; // @[Router_Hw.scala 116:99]
  assign _T_454 = _T_453 & _T_443; // @[Router_Hw.scala 116:99]
  assign _T_458 = _T_395 == 3'h6; // @[Router_Hw.scala 113:53]
  assign _T_459 = _T_458 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_461 = _T_398 == 3'h6; // @[Router_Hw.scala 113:53]
  assign _T_462 = _T_461 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_467 = _T_404 == 3'h6; // @[Router_Hw.scala 113:53]
  assign _T_468 = _T_467 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_470 = _T_407 == 3'h6; // @[Router_Hw.scala 113:53]
  assign _T_471 = _T_470 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_473 = _T_410 == 3'h6; // @[Router_Hw.scala 113:53]
  assign _T_474 = _T_473 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_479 = _T_416 == 3'h6; // @[Router_Hw.scala 113:53]
  assign _T_480 = _T_479 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_481 = _T_459 & _T_462; // @[Router_Hw.scala 116:99]
  assign _T_483 = _T_481 & _T_468; // @[Router_Hw.scala 116:99]
  assign _T_484 = _T_483 & _T_471; // @[Router_Hw.scala 116:99]
  assign _T_485 = _T_484 & _T_474; // @[Router_Hw.scala 116:99]
  assign config_module_id = io_in_4_bits[63:59]; // @[Router_Hw.scala 148:44]
  assign module_id_match = config_module_id == 5'h13; // @[Router_Hw.scala 149:49]
  assign config_data = io_in_4_bits[23:0]; // @[Router_Hw.scala 151:39]
  assign _T_490 = io_in_4_config & module_id_match; // @[Router_Hw.scala 152:22]
  assign io_in_0_ready = _T_299 & _T_294; // @[Router_Hw.scala 178:33]
  assign io_in_1_ready = _T_330 & _T_325; // @[Router_Hw.scala 178:33]
  assign io_in_2_ready = _T_361 & _T_356; // @[Router_Hw.scala 178:33]
  assign io_in_3_ready = _T_392 & _T_387; // @[Router_Hw.scala 178:33]
  assign io_in_4_ready = io_in_4_config ? io_out_7_ready : decomposed_input_ports_0_4_ready; // @[Router_Hw.scala 178:33 Router_Hw.scala 198:31]
  assign io_in_5_ready = _T_454 & _T_449; // @[Router_Hw.scala 178:33]
  assign io_in_6_ready = _T_485 & _T_480; // @[Router_Hw.scala 178:33]
  assign io_out_0_valid = _T_9; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_8; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = _T_12; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_11; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = _T_18; // @[Router_Hw.scala 213:35]
  assign io_out_3_bits = _T_17; // @[Router_Hw.scala 212:34]
  assign io_out_4_valid = _T_21; // @[Router_Hw.scala 213:35]
  assign io_out_4_bits = _T_20; // @[Router_Hw.scala 212:34]
  assign io_out_5_valid = _T_24; // @[Router_Hw.scala 213:35]
  assign io_out_5_bits = _T_23; // @[Router_Hw.scala 212:34]
  assign io_out_7_valid = io_in_4_config ? io_in_4_valid : _T_30; // @[Router_Hw.scala 198:31 Router_Hw.scala 204:37]
  assign io_out_7_bits = io_in_4_config ? io_in_4_bits : _T_29; // @[Router_Hw.scala 198:31 Router_Hw.scala 203:36]
  assign io_out_7_config = io_in_4_config; // @[Router_Hw.scala 198:31 Router_Hw.scala 205:38]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_8 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_9 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_11 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_12 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_17 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_18 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  decomposed_output_ports_0_4_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {2{`RANDOM}};
  _T_20 = _RAND_10[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  _T_21 = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  decomposed_output_ports_0_5_ready = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {2{`RANDOM}};
  _T_23 = _RAND_13[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  _T_24 = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  decomposed_output_ports_0_7_ready = _RAND_15[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {2{`RANDOM}};
  _T_29 = _RAND_16[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {1{`RANDOM}};
  _T_30 = _RAND_17[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_18 = {1{`RANDOM}};
  config_register_file_0 = _RAND_18[23:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (_T_44) begin
      _T_8 <= io_in_0_bits;
    end else begin
      if (_T_42) begin
        _T_8 <= io_in_1_bits;
      end else begin
        if (_T_40) begin
          _T_8 <= io_in_2_bits;
        end else begin
          if (_T_38) begin
            _T_8 <= io_in_3_bits;
          end else begin
            if (_T_36) begin
              _T_8 <= io_in_4_bits;
            end else begin
              if (_T_34) begin
                _T_8 <= io_in_5_bits;
              end else begin
                if (_T_32) begin
                  _T_8 <= io_in_6_bits;
                end else begin
                  _T_8 <= 64'h0;
                end
              end
            end
          end
        end
      end
    end
    if (_T_44) begin
      _T_9 <= io_in_0_valid;
    end else begin
      if (_T_42) begin
        _T_9 <= io_in_1_valid;
      end else begin
        if (_T_40) begin
          _T_9 <= io_in_2_valid;
        end else begin
          if (_T_38) begin
            _T_9 <= io_in_3_valid;
          end else begin
            if (_T_36) begin
              _T_9 <= io_in_4_valid;
            end else begin
              if (_T_34) begin
                _T_9 <= io_in_5_valid;
              end else begin
                if (_T_32) begin
                  _T_9 <= io_in_6_valid;
                end else begin
                  _T_9 <= 1'h0;
                end
              end
            end
          end
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (_T_74) begin
      _T_11 <= io_in_0_bits;
    end else begin
      if (_T_72) begin
        _T_11 <= io_in_1_bits;
      end else begin
        if (_T_70) begin
          _T_11 <= io_in_2_bits;
        end else begin
          if (_T_68) begin
            _T_11 <= io_in_3_bits;
          end else begin
            if (_T_66) begin
              _T_11 <= io_in_4_bits;
            end else begin
              if (_T_64) begin
                _T_11 <= io_in_5_bits;
              end else begin
                if (_T_62) begin
                  _T_11 <= io_in_6_bits;
                end else begin
                  _T_11 <= 64'h0;
                end
              end
            end
          end
        end
      end
    end
    if (_T_74) begin
      _T_12 <= io_in_0_valid;
    end else begin
      if (_T_72) begin
        _T_12 <= io_in_1_valid;
      end else begin
        if (_T_70) begin
          _T_12 <= io_in_2_valid;
        end else begin
          if (_T_68) begin
            _T_12 <= io_in_3_valid;
          end else begin
            if (_T_66) begin
              _T_12 <= io_in_4_valid;
            end else begin
              if (_T_64) begin
                _T_12 <= io_in_5_valid;
              end else begin
                if (_T_62) begin
                  _T_12 <= io_in_6_valid;
                end else begin
                  _T_12 <= 1'h0;
                end
              end
            end
          end
        end
      end
    end
    decomposed_output_ports_0_3_ready <= io_out_3_ready;
    if (_T_134) begin
      _T_17 <= io_in_0_bits;
    end else begin
      if (_T_132) begin
        _T_17 <= io_in_1_bits;
      end else begin
        if (_T_130) begin
          _T_17 <= io_in_2_bits;
        end else begin
          if (_T_128) begin
            _T_17 <= io_in_3_bits;
          end else begin
            if (_T_126) begin
              _T_17 <= io_in_4_bits;
            end else begin
              if (_T_124) begin
                _T_17 <= io_in_5_bits;
              end else begin
                if (_T_122) begin
                  _T_17 <= io_in_6_bits;
                end else begin
                  _T_17 <= 64'h0;
                end
              end
            end
          end
        end
      end
    end
    if (_T_134) begin
      _T_18 <= io_in_0_valid;
    end else begin
      if (_T_132) begin
        _T_18 <= io_in_1_valid;
      end else begin
        if (_T_130) begin
          _T_18 <= io_in_2_valid;
        end else begin
          if (_T_128) begin
            _T_18 <= io_in_3_valid;
          end else begin
            if (_T_126) begin
              _T_18 <= io_in_4_valid;
            end else begin
              if (_T_124) begin
                _T_18 <= io_in_5_valid;
              end else begin
                if (_T_122) begin
                  _T_18 <= io_in_6_valid;
                end else begin
                  _T_18 <= 1'h0;
                end
              end
            end
          end
        end
      end
    end
    decomposed_output_ports_0_4_ready <= io_out_4_ready;
    if (_T_164) begin
      _T_20 <= io_in_0_bits;
    end else begin
      if (_T_162) begin
        _T_20 <= io_in_1_bits;
      end else begin
        if (_T_160) begin
          _T_20 <= io_in_2_bits;
        end else begin
          if (_T_158) begin
            _T_20 <= io_in_3_bits;
          end else begin
            if (_T_156) begin
              _T_20 <= io_in_4_bits;
            end else begin
              if (_T_154) begin
                _T_20 <= io_in_5_bits;
              end else begin
                if (_T_152) begin
                  _T_20 <= io_in_6_bits;
                end else begin
                  _T_20 <= 64'h0;
                end
              end
            end
          end
        end
      end
    end
    if (_T_164) begin
      _T_21 <= io_in_0_valid;
    end else begin
      if (_T_162) begin
        _T_21 <= io_in_1_valid;
      end else begin
        if (_T_160) begin
          _T_21 <= io_in_2_valid;
        end else begin
          if (_T_158) begin
            _T_21 <= io_in_3_valid;
          end else begin
            if (_T_156) begin
              _T_21 <= io_in_4_valid;
            end else begin
              if (_T_154) begin
                _T_21 <= io_in_5_valid;
              end else begin
                if (_T_152) begin
                  _T_21 <= io_in_6_valid;
                end else begin
                  _T_21 <= 1'h0;
                end
              end
            end
          end
        end
      end
    end
    decomposed_output_ports_0_5_ready <= io_out_5_ready;
    if (_T_194) begin
      _T_23 <= io_in_0_bits;
    end else begin
      if (_T_192) begin
        _T_23 <= io_in_1_bits;
      end else begin
        if (_T_190) begin
          _T_23 <= io_in_2_bits;
        end else begin
          if (_T_188) begin
            _T_23 <= io_in_3_bits;
          end else begin
            if (_T_186) begin
              _T_23 <= io_in_4_bits;
            end else begin
              if (_T_184) begin
                _T_23 <= io_in_5_bits;
              end else begin
                if (_T_182) begin
                  _T_23 <= io_in_6_bits;
                end else begin
                  _T_23 <= 64'h0;
                end
              end
            end
          end
        end
      end
    end
    if (_T_194) begin
      _T_24 <= io_in_0_valid;
    end else begin
      if (_T_192) begin
        _T_24 <= io_in_1_valid;
      end else begin
        if (_T_190) begin
          _T_24 <= io_in_2_valid;
        end else begin
          if (_T_188) begin
            _T_24 <= io_in_3_valid;
          end else begin
            if (_T_186) begin
              _T_24 <= io_in_4_valid;
            end else begin
              if (_T_184) begin
                _T_24 <= io_in_5_valid;
              end else begin
                if (_T_182) begin
                  _T_24 <= io_in_6_valid;
                end else begin
                  _T_24 <= 1'h0;
                end
              end
            end
          end
        end
      end
    end
    if (io_in_4_config) begin
      decomposed_output_ports_0_7_ready <= 1'h0;
    end else begin
      decomposed_output_ports_0_7_ready <= io_out_7_ready;
    end
    if (_T_254) begin
      _T_29 <= io_in_0_bits;
    end else begin
      if (_T_252) begin
        _T_29 <= io_in_1_bits;
      end else begin
        if (_T_250) begin
          _T_29 <= io_in_2_bits;
        end else begin
          if (_T_248) begin
            _T_29 <= io_in_3_bits;
          end else begin
            if (_T_246) begin
              _T_29 <= io_in_4_bits;
            end else begin
              if (_T_244) begin
                _T_29 <= io_in_5_bits;
              end else begin
                if (_T_242) begin
                  _T_29 <= io_in_6_bits;
                end else begin
                  _T_29 <= 64'h0;
                end
              end
            end
          end
        end
      end
    end
    if (_T_254) begin
      _T_30 <= io_in_0_valid;
    end else begin
      if (_T_252) begin
        _T_30 <= io_in_1_valid;
      end else begin
        if (_T_250) begin
          _T_30 <= io_in_2_valid;
        end else begin
          if (_T_248) begin
            _T_30 <= io_in_3_valid;
          end else begin
            if (_T_246) begin
              _T_30 <= io_in_4_valid;
            end else begin
              if (_T_244) begin
                _T_30 <= io_in_5_valid;
              end else begin
                if (_T_242) begin
                  _T_30 <= io_in_6_valid;
                end else begin
                  _T_30 <= 1'h0;
                end
              end
            end
          end
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 24'h0;
    end else begin
      if (_T_490) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Router_Hw_4(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  input         io_in_3_config,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready,
  output        io_out_4_valid,
  output [63:0] io_out_4_bits,
  input         io_out_4_ready,
  output        io_out_5_valid,
  output [63:0] io_out_5_bits,
  input         io_out_5_ready
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_5; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_6; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_8; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_9; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [11:0] config_register_file_0; // @[Router_Hw.scala 140:37]
  reg [31:0] _RAND_7;
  wire [1:0] _T_199; // @[Router_Hw.scala 113:22]
  wire  _T_200; // @[Router_Hw.scala 113:53]
  wire  _T_201; // @[Router_Hw.scala 113:10]
  wire [1:0] _T_202; // @[Router_Hw.scala 113:22]
  wire  _T_203; // @[Router_Hw.scala 113:53]
  wire  _T_204; // @[Router_Hw.scala 113:10]
  wire  _T_217; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_205; // @[Router_Hw.scala 113:22]
  wire  _T_206; // @[Router_Hw.scala 113:53]
  wire  _T_207; // @[Router_Hw.scala 113:10]
  wire  _T_218; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_208; // @[Router_Hw.scala 113:22]
  wire  _T_209; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_8;
  wire  _T_210; // @[Router_Hw.scala 113:10]
  wire  _T_219; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_211; // @[Router_Hw.scala 113:22]
  wire  _T_212; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_4_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_9;
  wire  _T_213; // @[Router_Hw.scala 113:10]
  wire  _T_220; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_214; // @[Router_Hw.scala 113:22]
  wire  _T_215; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_5_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_10;
  wire  _T_216; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_3_ready; // @[Router_Hw.scala 116:99]
  reg [63:0] _T_14; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_11;
  reg  _T_15; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_12;
  reg [63:0] _T_17; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_13;
  reg  _T_18; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_14;
  reg [63:0] _T_20; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_15;
  reg  _T_21; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_16;
  wire  _T_23; // @[Mux.scala 69:19]
  wire  _T_25; // @[Mux.scala 69:19]
  wire  _T_27; // @[Mux.scala 69:19]
  wire  _T_29; // @[Mux.scala 69:19]
  wire  _T_41; // @[Mux.scala 69:19]
  wire  _T_43; // @[Mux.scala 69:19]
  wire  _T_45; // @[Mux.scala 69:19]
  wire  _T_47; // @[Mux.scala 69:19]
  wire  _T_77; // @[Mux.scala 69:19]
  wire  _T_79; // @[Mux.scala 69:19]
  wire  _T_81; // @[Mux.scala 69:19]
  wire  _T_83; // @[Mux.scala 69:19]
  wire  _T_95; // @[Mux.scala 69:19]
  wire  _T_97; // @[Mux.scala 69:19]
  wire  _T_99; // @[Mux.scala 69:19]
  wire  _T_101; // @[Mux.scala 69:19]
  wire  _T_113; // @[Mux.scala 69:19]
  wire  _T_115; // @[Mux.scala 69:19]
  wire  _T_117; // @[Mux.scala 69:19]
  wire  _T_119; // @[Mux.scala 69:19]
  wire  _T_131; // @[Router_Hw.scala 113:53]
  wire  _T_132; // @[Router_Hw.scala 113:10]
  wire  _T_134; // @[Router_Hw.scala 113:53]
  wire  _T_135; // @[Router_Hw.scala 113:10]
  wire  _T_137; // @[Router_Hw.scala 113:53]
  wire  _T_138; // @[Router_Hw.scala 113:10]
  wire  _T_140; // @[Router_Hw.scala 113:53]
  wire  _T_141; // @[Router_Hw.scala 113:10]
  wire  _T_143; // @[Router_Hw.scala 113:53]
  wire  _T_144; // @[Router_Hw.scala 113:10]
  wire  _T_146; // @[Router_Hw.scala 113:53]
  wire  _T_147; // @[Router_Hw.scala 113:10]
  wire  _T_148; // @[Router_Hw.scala 116:99]
  wire  _T_149; // @[Router_Hw.scala 116:99]
  wire  _T_150; // @[Router_Hw.scala 116:99]
  wire  _T_151; // @[Router_Hw.scala 116:99]
  wire  _T_154; // @[Router_Hw.scala 113:53]
  wire  _T_155; // @[Router_Hw.scala 113:10]
  wire  _T_157; // @[Router_Hw.scala 113:53]
  wire  _T_158; // @[Router_Hw.scala 113:10]
  wire  _T_160; // @[Router_Hw.scala 113:53]
  wire  _T_161; // @[Router_Hw.scala 113:10]
  wire  _T_163; // @[Router_Hw.scala 113:53]
  wire  _T_164; // @[Router_Hw.scala 113:10]
  wire  _T_166; // @[Router_Hw.scala 113:53]
  wire  _T_167; // @[Router_Hw.scala 113:10]
  wire  _T_169; // @[Router_Hw.scala 113:53]
  wire  _T_170; // @[Router_Hw.scala 113:10]
  wire  _T_171; // @[Router_Hw.scala 116:99]
  wire  _T_172; // @[Router_Hw.scala 116:99]
  wire  _T_173; // @[Router_Hw.scala 116:99]
  wire  _T_174; // @[Router_Hw.scala 116:99]
  wire  _T_177; // @[Router_Hw.scala 113:53]
  wire  _T_178; // @[Router_Hw.scala 113:10]
  wire  _T_180; // @[Router_Hw.scala 113:53]
  wire  _T_181; // @[Router_Hw.scala 113:10]
  wire  _T_183; // @[Router_Hw.scala 113:53]
  wire  _T_184; // @[Router_Hw.scala 113:10]
  wire  _T_186; // @[Router_Hw.scala 113:53]
  wire  _T_187; // @[Router_Hw.scala 113:10]
  wire  _T_189; // @[Router_Hw.scala 113:53]
  wire  _T_190; // @[Router_Hw.scala 113:10]
  wire  _T_192; // @[Router_Hw.scala 113:53]
  wire  _T_193; // @[Router_Hw.scala 113:10]
  wire  _T_194; // @[Router_Hw.scala 116:99]
  wire  _T_195; // @[Router_Hw.scala 116:99]
  wire  _T_196; // @[Router_Hw.scala 116:99]
  wire  _T_197; // @[Router_Hw.scala 116:99]
  wire [4:0] config_module_id; // @[Router_Hw.scala 148:44]
  wire  module_id_match; // @[Router_Hw.scala 149:49]
  wire [11:0] config_data; // @[Router_Hw.scala 151:39]
  wire  _T_224; // @[Router_Hw.scala 152:22]
  assign _T_199 = config_register_file_0[1:0]; // @[Router_Hw.scala 113:22]
  assign _T_200 = _T_199 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_201 = _T_200 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_202 = config_register_file_0[3:2]; // @[Router_Hw.scala 113:22]
  assign _T_203 = _T_202 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_204 = _T_203 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_217 = _T_201 & _T_204; // @[Router_Hw.scala 116:99]
  assign _T_205 = config_register_file_0[5:4]; // @[Router_Hw.scala 113:22]
  assign _T_206 = _T_205 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_207 = _T_206 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_218 = _T_217 & _T_207; // @[Router_Hw.scala 116:99]
  assign _T_208 = config_register_file_0[7:6]; // @[Router_Hw.scala 113:22]
  assign _T_209 = _T_208 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_210 = _T_209 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_219 = _T_218 & _T_210; // @[Router_Hw.scala 116:99]
  assign _T_211 = config_register_file_0[9:8]; // @[Router_Hw.scala 113:22]
  assign _T_212 = _T_211 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_213 = _T_212 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_220 = _T_219 & _T_213; // @[Router_Hw.scala 116:99]
  assign _T_214 = config_register_file_0[11:10]; // @[Router_Hw.scala 113:22]
  assign _T_215 = _T_214 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_216 = _T_215 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_3_ready = _T_220 & _T_216; // @[Router_Hw.scala 116:99]
  assign _T_23 = 2'h3 == _T_199; // @[Mux.scala 69:19]
  assign _T_25 = 2'h2 == _T_199; // @[Mux.scala 69:19]
  assign _T_27 = 2'h1 == _T_199; // @[Mux.scala 69:19]
  assign _T_29 = 2'h0 == _T_199; // @[Mux.scala 69:19]
  assign _T_41 = 2'h3 == _T_202; // @[Mux.scala 69:19]
  assign _T_43 = 2'h2 == _T_202; // @[Mux.scala 69:19]
  assign _T_45 = 2'h1 == _T_202; // @[Mux.scala 69:19]
  assign _T_47 = 2'h0 == _T_202; // @[Mux.scala 69:19]
  assign _T_77 = 2'h3 == _T_208; // @[Mux.scala 69:19]
  assign _T_79 = 2'h2 == _T_208; // @[Mux.scala 69:19]
  assign _T_81 = 2'h1 == _T_208; // @[Mux.scala 69:19]
  assign _T_83 = 2'h0 == _T_208; // @[Mux.scala 69:19]
  assign _T_95 = 2'h3 == _T_211; // @[Mux.scala 69:19]
  assign _T_97 = 2'h2 == _T_211; // @[Mux.scala 69:19]
  assign _T_99 = 2'h1 == _T_211; // @[Mux.scala 69:19]
  assign _T_101 = 2'h0 == _T_211; // @[Mux.scala 69:19]
  assign _T_113 = 2'h3 == _T_214; // @[Mux.scala 69:19]
  assign _T_115 = 2'h2 == _T_214; // @[Mux.scala 69:19]
  assign _T_117 = 2'h1 == _T_214; // @[Mux.scala 69:19]
  assign _T_119 = 2'h0 == _T_214; // @[Mux.scala 69:19]
  assign _T_131 = _T_199 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_132 = _T_131 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_134 = _T_202 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_135 = _T_134 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_137 = _T_205 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_138 = _T_137 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_140 = _T_208 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_141 = _T_140 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_143 = _T_211 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_144 = _T_143 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_146 = _T_214 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_147 = _T_146 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_148 = _T_132 & _T_135; // @[Router_Hw.scala 116:99]
  assign _T_149 = _T_148 & _T_138; // @[Router_Hw.scala 116:99]
  assign _T_150 = _T_149 & _T_141; // @[Router_Hw.scala 116:99]
  assign _T_151 = _T_150 & _T_144; // @[Router_Hw.scala 116:99]
  assign _T_154 = _T_199 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_155 = _T_154 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_157 = _T_202 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_158 = _T_157 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_160 = _T_205 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_161 = _T_160 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_163 = _T_208 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_164 = _T_163 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_166 = _T_211 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_167 = _T_166 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_169 = _T_214 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_170 = _T_169 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_171 = _T_155 & _T_158; // @[Router_Hw.scala 116:99]
  assign _T_172 = _T_171 & _T_161; // @[Router_Hw.scala 116:99]
  assign _T_173 = _T_172 & _T_164; // @[Router_Hw.scala 116:99]
  assign _T_174 = _T_173 & _T_167; // @[Router_Hw.scala 116:99]
  assign _T_177 = _T_199 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_178 = _T_177 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_180 = _T_202 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_181 = _T_180 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_183 = _T_205 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_184 = _T_183 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_186 = _T_208 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_187 = _T_186 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_189 = _T_211 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_190 = _T_189 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_192 = _T_214 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_193 = _T_192 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_194 = _T_178 & _T_181; // @[Router_Hw.scala 116:99]
  assign _T_195 = _T_194 & _T_184; // @[Router_Hw.scala 116:99]
  assign _T_196 = _T_195 & _T_187; // @[Router_Hw.scala 116:99]
  assign _T_197 = _T_196 & _T_190; // @[Router_Hw.scala 116:99]
  assign config_module_id = io_in_3_bits[63:59]; // @[Router_Hw.scala 148:44]
  assign module_id_match = config_module_id == 5'h16; // @[Router_Hw.scala 149:49]
  assign config_data = io_in_3_bits[11:0]; // @[Router_Hw.scala 151:39]
  assign _T_224 = io_in_3_config & module_id_match; // @[Router_Hw.scala 152:22]
  assign io_in_0_ready = _T_151 & _T_147; // @[Router_Hw.scala 178:33]
  assign io_in_1_ready = _T_174 & _T_170; // @[Router_Hw.scala 178:33]
  assign io_in_2_ready = _T_197 & _T_193; // @[Router_Hw.scala 178:33]
  assign io_in_3_ready = io_in_3_config ? 1'h1 : decomposed_input_ports_0_3_ready; // @[Router_Hw.scala 178:33 Router_Hw.scala 198:31]
  assign io_out_0_valid = _T_6; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_5; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = _T_9; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_8; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = _T_15; // @[Router_Hw.scala 213:35]
  assign io_out_3_bits = _T_14; // @[Router_Hw.scala 212:34]
  assign io_out_4_valid = _T_18; // @[Router_Hw.scala 213:35]
  assign io_out_4_bits = _T_17; // @[Router_Hw.scala 212:34]
  assign io_out_5_valid = _T_21; // @[Router_Hw.scala 213:35]
  assign io_out_5_bits = _T_20; // @[Router_Hw.scala 212:34]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_5 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_6 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_8 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_9 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  config_register_file_0 = _RAND_7[11:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  decomposed_output_ports_0_4_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  decomposed_output_ports_0_5_ready = _RAND_10[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {2{`RANDOM}};
  _T_14 = _RAND_11[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  _T_15 = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {2{`RANDOM}};
  _T_17 = _RAND_13[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  _T_18 = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {2{`RANDOM}};
  _T_20 = _RAND_15[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {1{`RANDOM}};
  _T_21 = _RAND_16[0:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (_T_29) begin
      _T_5 <= io_in_0_bits;
    end else begin
      if (_T_27) begin
        _T_5 <= io_in_1_bits;
      end else begin
        if (_T_25) begin
          _T_5 <= io_in_2_bits;
        end else begin
          if (_T_23) begin
            _T_5 <= io_in_3_bits;
          end else begin
            _T_5 <= 64'h0;
          end
        end
      end
    end
    if (_T_29) begin
      _T_6 <= io_in_0_valid;
    end else begin
      if (_T_27) begin
        _T_6 <= io_in_1_valid;
      end else begin
        if (_T_25) begin
          _T_6 <= io_in_2_valid;
        end else begin
          if (_T_23) begin
            _T_6 <= io_in_3_valid;
          end else begin
            _T_6 <= 1'h0;
          end
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (_T_47) begin
      _T_8 <= io_in_0_bits;
    end else begin
      if (_T_45) begin
        _T_8 <= io_in_1_bits;
      end else begin
        if (_T_43) begin
          _T_8 <= io_in_2_bits;
        end else begin
          if (_T_41) begin
            _T_8 <= io_in_3_bits;
          end else begin
            _T_8 <= 64'h0;
          end
        end
      end
    end
    if (_T_47) begin
      _T_9 <= io_in_0_valid;
    end else begin
      if (_T_45) begin
        _T_9 <= io_in_1_valid;
      end else begin
        if (_T_43) begin
          _T_9 <= io_in_2_valid;
        end else begin
          if (_T_41) begin
            _T_9 <= io_in_3_valid;
          end else begin
            _T_9 <= 1'h0;
          end
        end
      end
    end
    if (io_in_3_config) begin
      decomposed_output_ports_0_2_ready <= 1'h0;
    end else begin
      decomposed_output_ports_0_2_ready <= 1'h1;
    end
    if (reset) begin
      config_register_file_0 <= 12'h0;
    end else begin
      if (_T_224) begin
        config_register_file_0 <= config_data;
      end
    end
    decomposed_output_ports_0_3_ready <= io_out_3_ready;
    decomposed_output_ports_0_4_ready <= io_out_4_ready;
    decomposed_output_ports_0_5_ready <= io_out_5_ready;
    if (_T_83) begin
      _T_14 <= io_in_0_bits;
    end else begin
      if (_T_81) begin
        _T_14 <= io_in_1_bits;
      end else begin
        if (_T_79) begin
          _T_14 <= io_in_2_bits;
        end else begin
          if (_T_77) begin
            _T_14 <= io_in_3_bits;
          end else begin
            _T_14 <= 64'h0;
          end
        end
      end
    end
    if (_T_83) begin
      _T_15 <= io_in_0_valid;
    end else begin
      if (_T_81) begin
        _T_15 <= io_in_1_valid;
      end else begin
        if (_T_79) begin
          _T_15 <= io_in_2_valid;
        end else begin
          if (_T_77) begin
            _T_15 <= io_in_3_valid;
          end else begin
            _T_15 <= 1'h0;
          end
        end
      end
    end
    if (_T_101) begin
      _T_17 <= io_in_0_bits;
    end else begin
      if (_T_99) begin
        _T_17 <= io_in_1_bits;
      end else begin
        if (_T_97) begin
          _T_17 <= io_in_2_bits;
        end else begin
          if (_T_95) begin
            _T_17 <= io_in_3_bits;
          end else begin
            _T_17 <= 64'h0;
          end
        end
      end
    end
    if (_T_101) begin
      _T_18 <= io_in_0_valid;
    end else begin
      if (_T_99) begin
        _T_18 <= io_in_1_valid;
      end else begin
        if (_T_97) begin
          _T_18 <= io_in_2_valid;
        end else begin
          if (_T_95) begin
            _T_18 <= io_in_3_valid;
          end else begin
            _T_18 <= 1'h0;
          end
        end
      end
    end
    if (_T_119) begin
      _T_20 <= io_in_0_bits;
    end else begin
      if (_T_117) begin
        _T_20 <= io_in_1_bits;
      end else begin
        if (_T_115) begin
          _T_20 <= io_in_2_bits;
        end else begin
          if (_T_113) begin
            _T_20 <= io_in_3_bits;
          end else begin
            _T_20 <= 64'h0;
          end
        end
      end
    end
    if (_T_119) begin
      _T_21 <= io_in_0_valid;
    end else begin
      if (_T_117) begin
        _T_21 <= io_in_1_valid;
      end else begin
        if (_T_115) begin
          _T_21 <= io_in_2_valid;
        end else begin
          if (_T_113) begin
            _T_21 <= io_in_3_valid;
          end else begin
            _T_21 <= 1'h0;
          end
        end
      end
    end
  end
endmodule
module Router_Hw_5(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  input         io_in_3_config,
  input         io_in_4_valid,
  input  [63:0] io_in_4_bits,
  output        io_in_4_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready,
  output        io_out_4_valid,
  output [63:0] io_out_4_bits,
  input         io_out_4_ready,
  output        io_out_5_valid,
  output [63:0] io_out_5_bits,
  input         io_out_5_ready
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_6; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_7; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_9; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_10; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [63:0] _T_12; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_7;
  reg  _T_13; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_8;
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_9;
  reg [63:0] _T_15; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_10;
  reg  _T_16; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_11;
  reg  decomposed_output_ports_0_4_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_12;
  reg [63:0] _T_18; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_13;
  reg  _T_19; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_14;
  reg  decomposed_output_ports_0_5_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_15;
  reg [63:0] _T_21; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_16;
  reg  _T_22; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_17;
  reg [17:0] config_register_file_0; // @[Router_Hw.scala 140:37]
  reg [31:0] _RAND_18;
  wire [2:0] _T_224; // @[Router_Hw.scala 113:22]
  wire  _T_225; // @[Router_Hw.scala 113:53]
  wire  _T_226; // @[Router_Hw.scala 113:10]
  wire [2:0] _T_227; // @[Router_Hw.scala 113:22]
  wire  _T_228; // @[Router_Hw.scala 113:53]
  wire  _T_229; // @[Router_Hw.scala 113:10]
  wire  _T_242; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_230; // @[Router_Hw.scala 113:22]
  wire  _T_231; // @[Router_Hw.scala 113:53]
  wire  _T_232; // @[Router_Hw.scala 113:10]
  wire  _T_243; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_233; // @[Router_Hw.scala 113:22]
  wire  _T_234; // @[Router_Hw.scala 113:53]
  wire  _T_235; // @[Router_Hw.scala 113:10]
  wire  _T_244; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_236; // @[Router_Hw.scala 113:22]
  wire  _T_237; // @[Router_Hw.scala 113:53]
  wire  _T_238; // @[Router_Hw.scala 113:10]
  wire  _T_245; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_239; // @[Router_Hw.scala 113:22]
  wire  _T_240; // @[Router_Hw.scala 113:53]
  wire  _T_241; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_3_ready; // @[Router_Hw.scala 116:99]
  wire  _T_24; // @[Mux.scala 69:19]
  wire  _T_26; // @[Mux.scala 69:19]
  wire  _T_28; // @[Mux.scala 69:19]
  wire  _T_30; // @[Mux.scala 69:19]
  wire  _T_32; // @[Mux.scala 69:19]
  wire  _T_46; // @[Mux.scala 69:19]
  wire  _T_48; // @[Mux.scala 69:19]
  wire  _T_50; // @[Mux.scala 69:19]
  wire  _T_52; // @[Mux.scala 69:19]
  wire  _T_54; // @[Mux.scala 69:19]
  wire  _T_68; // @[Mux.scala 69:19]
  wire  _T_70; // @[Mux.scala 69:19]
  wire  _T_72; // @[Mux.scala 69:19]
  wire  _T_74; // @[Mux.scala 69:19]
  wire  _T_76; // @[Mux.scala 69:19]
  wire  _T_90; // @[Mux.scala 69:19]
  wire  _T_92; // @[Mux.scala 69:19]
  wire  _T_94; // @[Mux.scala 69:19]
  wire  _T_96; // @[Mux.scala 69:19]
  wire  _T_98; // @[Mux.scala 69:19]
  wire  _T_112; // @[Mux.scala 69:19]
  wire  _T_114; // @[Mux.scala 69:19]
  wire  _T_116; // @[Mux.scala 69:19]
  wire  _T_118; // @[Mux.scala 69:19]
  wire  _T_120; // @[Mux.scala 69:19]
  wire  _T_134; // @[Mux.scala 69:19]
  wire  _T_136; // @[Mux.scala 69:19]
  wire  _T_138; // @[Mux.scala 69:19]
  wire  _T_140; // @[Mux.scala 69:19]
  wire  _T_142; // @[Mux.scala 69:19]
  wire  _T_156; // @[Router_Hw.scala 113:53]
  wire  _T_157; // @[Router_Hw.scala 113:10]
  wire  _T_159; // @[Router_Hw.scala 113:53]
  wire  _T_160; // @[Router_Hw.scala 113:10]
  wire  _T_162; // @[Router_Hw.scala 113:53]
  wire  _T_163; // @[Router_Hw.scala 113:10]
  wire  _T_165; // @[Router_Hw.scala 113:53]
  wire  _T_166; // @[Router_Hw.scala 113:10]
  wire  _T_168; // @[Router_Hw.scala 113:53]
  wire  _T_169; // @[Router_Hw.scala 113:10]
  wire  _T_171; // @[Router_Hw.scala 113:53]
  wire  _T_172; // @[Router_Hw.scala 113:10]
  wire  _T_173; // @[Router_Hw.scala 116:99]
  wire  _T_174; // @[Router_Hw.scala 116:99]
  wire  _T_175; // @[Router_Hw.scala 116:99]
  wire  _T_176; // @[Router_Hw.scala 116:99]
  wire  _T_179; // @[Router_Hw.scala 113:53]
  wire  _T_180; // @[Router_Hw.scala 113:10]
  wire  _T_182; // @[Router_Hw.scala 113:53]
  wire  _T_183; // @[Router_Hw.scala 113:10]
  wire  _T_185; // @[Router_Hw.scala 113:53]
  wire  _T_186; // @[Router_Hw.scala 113:10]
  wire  _T_188; // @[Router_Hw.scala 113:53]
  wire  _T_189; // @[Router_Hw.scala 113:10]
  wire  _T_191; // @[Router_Hw.scala 113:53]
  wire  _T_192; // @[Router_Hw.scala 113:10]
  wire  _T_194; // @[Router_Hw.scala 113:53]
  wire  _T_195; // @[Router_Hw.scala 113:10]
  wire  _T_196; // @[Router_Hw.scala 116:99]
  wire  _T_197; // @[Router_Hw.scala 116:99]
  wire  _T_198; // @[Router_Hw.scala 116:99]
  wire  _T_199; // @[Router_Hw.scala 116:99]
  wire  _T_202; // @[Router_Hw.scala 113:53]
  wire  _T_203; // @[Router_Hw.scala 113:10]
  wire  _T_205; // @[Router_Hw.scala 113:53]
  wire  _T_206; // @[Router_Hw.scala 113:10]
  wire  _T_208; // @[Router_Hw.scala 113:53]
  wire  _T_209; // @[Router_Hw.scala 113:10]
  wire  _T_211; // @[Router_Hw.scala 113:53]
  wire  _T_212; // @[Router_Hw.scala 113:10]
  wire  _T_214; // @[Router_Hw.scala 113:53]
  wire  _T_215; // @[Router_Hw.scala 113:10]
  wire  _T_217; // @[Router_Hw.scala 113:53]
  wire  _T_218; // @[Router_Hw.scala 113:10]
  wire  _T_219; // @[Router_Hw.scala 116:99]
  wire  _T_220; // @[Router_Hw.scala 116:99]
  wire  _T_221; // @[Router_Hw.scala 116:99]
  wire  _T_222; // @[Router_Hw.scala 116:99]
  wire  _T_248; // @[Router_Hw.scala 113:53]
  wire  _T_249; // @[Router_Hw.scala 113:10]
  wire  _T_251; // @[Router_Hw.scala 113:53]
  wire  _T_252; // @[Router_Hw.scala 113:10]
  wire  _T_254; // @[Router_Hw.scala 113:53]
  wire  _T_255; // @[Router_Hw.scala 113:10]
  wire  _T_257; // @[Router_Hw.scala 113:53]
  wire  _T_258; // @[Router_Hw.scala 113:10]
  wire  _T_260; // @[Router_Hw.scala 113:53]
  wire  _T_261; // @[Router_Hw.scala 113:10]
  wire  _T_263; // @[Router_Hw.scala 113:53]
  wire  _T_264; // @[Router_Hw.scala 113:10]
  wire  _T_265; // @[Router_Hw.scala 116:99]
  wire  _T_266; // @[Router_Hw.scala 116:99]
  wire  _T_267; // @[Router_Hw.scala 116:99]
  wire  _T_268; // @[Router_Hw.scala 116:99]
  wire [4:0] config_module_id; // @[Router_Hw.scala 148:44]
  wire  module_id_match; // @[Router_Hw.scala 149:49]
  wire [17:0] config_data; // @[Router_Hw.scala 151:39]
  wire  _T_272; // @[Router_Hw.scala 152:22]
  assign _T_224 = config_register_file_0[2:0]; // @[Router_Hw.scala 113:22]
  assign _T_225 = _T_224 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_226 = _T_225 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_227 = config_register_file_0[5:3]; // @[Router_Hw.scala 113:22]
  assign _T_228 = _T_227 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_229 = _T_228 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_242 = _T_226 & _T_229; // @[Router_Hw.scala 116:99]
  assign _T_230 = config_register_file_0[8:6]; // @[Router_Hw.scala 113:22]
  assign _T_231 = _T_230 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_232 = _T_231 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_243 = _T_242 & _T_232; // @[Router_Hw.scala 116:99]
  assign _T_233 = config_register_file_0[11:9]; // @[Router_Hw.scala 113:22]
  assign _T_234 = _T_233 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_235 = _T_234 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_244 = _T_243 & _T_235; // @[Router_Hw.scala 116:99]
  assign _T_236 = config_register_file_0[14:12]; // @[Router_Hw.scala 113:22]
  assign _T_237 = _T_236 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_238 = _T_237 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_245 = _T_244 & _T_238; // @[Router_Hw.scala 116:99]
  assign _T_239 = config_register_file_0[17:15]; // @[Router_Hw.scala 113:22]
  assign _T_240 = _T_239 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_241 = _T_240 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_3_ready = _T_245 & _T_241; // @[Router_Hw.scala 116:99]
  assign _T_24 = 3'h4 == _T_224; // @[Mux.scala 69:19]
  assign _T_26 = 3'h3 == _T_224; // @[Mux.scala 69:19]
  assign _T_28 = 3'h2 == _T_224; // @[Mux.scala 69:19]
  assign _T_30 = 3'h1 == _T_224; // @[Mux.scala 69:19]
  assign _T_32 = 3'h0 == _T_224; // @[Mux.scala 69:19]
  assign _T_46 = 3'h4 == _T_227; // @[Mux.scala 69:19]
  assign _T_48 = 3'h3 == _T_227; // @[Mux.scala 69:19]
  assign _T_50 = 3'h2 == _T_227; // @[Mux.scala 69:19]
  assign _T_52 = 3'h1 == _T_227; // @[Mux.scala 69:19]
  assign _T_54 = 3'h0 == _T_227; // @[Mux.scala 69:19]
  assign _T_68 = 3'h4 == _T_230; // @[Mux.scala 69:19]
  assign _T_70 = 3'h3 == _T_230; // @[Mux.scala 69:19]
  assign _T_72 = 3'h2 == _T_230; // @[Mux.scala 69:19]
  assign _T_74 = 3'h1 == _T_230; // @[Mux.scala 69:19]
  assign _T_76 = 3'h0 == _T_230; // @[Mux.scala 69:19]
  assign _T_90 = 3'h4 == _T_233; // @[Mux.scala 69:19]
  assign _T_92 = 3'h3 == _T_233; // @[Mux.scala 69:19]
  assign _T_94 = 3'h2 == _T_233; // @[Mux.scala 69:19]
  assign _T_96 = 3'h1 == _T_233; // @[Mux.scala 69:19]
  assign _T_98 = 3'h0 == _T_233; // @[Mux.scala 69:19]
  assign _T_112 = 3'h4 == _T_236; // @[Mux.scala 69:19]
  assign _T_114 = 3'h3 == _T_236; // @[Mux.scala 69:19]
  assign _T_116 = 3'h2 == _T_236; // @[Mux.scala 69:19]
  assign _T_118 = 3'h1 == _T_236; // @[Mux.scala 69:19]
  assign _T_120 = 3'h0 == _T_236; // @[Mux.scala 69:19]
  assign _T_134 = 3'h4 == _T_239; // @[Mux.scala 69:19]
  assign _T_136 = 3'h3 == _T_239; // @[Mux.scala 69:19]
  assign _T_138 = 3'h2 == _T_239; // @[Mux.scala 69:19]
  assign _T_140 = 3'h1 == _T_239; // @[Mux.scala 69:19]
  assign _T_142 = 3'h0 == _T_239; // @[Mux.scala 69:19]
  assign _T_156 = _T_224 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_157 = _T_156 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_159 = _T_227 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_160 = _T_159 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_162 = _T_230 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_163 = _T_162 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_165 = _T_233 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_166 = _T_165 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_168 = _T_236 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_169 = _T_168 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_171 = _T_239 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_172 = _T_171 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_173 = _T_157 & _T_160; // @[Router_Hw.scala 116:99]
  assign _T_174 = _T_173 & _T_163; // @[Router_Hw.scala 116:99]
  assign _T_175 = _T_174 & _T_166; // @[Router_Hw.scala 116:99]
  assign _T_176 = _T_175 & _T_169; // @[Router_Hw.scala 116:99]
  assign _T_179 = _T_224 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_180 = _T_179 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_182 = _T_227 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_183 = _T_182 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_185 = _T_230 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_186 = _T_185 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_188 = _T_233 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_189 = _T_188 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_191 = _T_236 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_192 = _T_191 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_194 = _T_239 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_195 = _T_194 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_196 = _T_180 & _T_183; // @[Router_Hw.scala 116:99]
  assign _T_197 = _T_196 & _T_186; // @[Router_Hw.scala 116:99]
  assign _T_198 = _T_197 & _T_189; // @[Router_Hw.scala 116:99]
  assign _T_199 = _T_198 & _T_192; // @[Router_Hw.scala 116:99]
  assign _T_202 = _T_224 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_203 = _T_202 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_205 = _T_227 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_206 = _T_205 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_208 = _T_230 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_209 = _T_208 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_211 = _T_233 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_212 = _T_211 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_214 = _T_236 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_215 = _T_214 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_217 = _T_239 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_218 = _T_217 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_219 = _T_203 & _T_206; // @[Router_Hw.scala 116:99]
  assign _T_220 = _T_219 & _T_209; // @[Router_Hw.scala 116:99]
  assign _T_221 = _T_220 & _T_212; // @[Router_Hw.scala 116:99]
  assign _T_222 = _T_221 & _T_215; // @[Router_Hw.scala 116:99]
  assign _T_248 = _T_224 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_249 = _T_248 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_251 = _T_227 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_252 = _T_251 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_254 = _T_230 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_255 = _T_254 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_257 = _T_233 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_258 = _T_257 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_260 = _T_236 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_261 = _T_260 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_263 = _T_239 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_264 = _T_263 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_265 = _T_249 & _T_252; // @[Router_Hw.scala 116:99]
  assign _T_266 = _T_265 & _T_255; // @[Router_Hw.scala 116:99]
  assign _T_267 = _T_266 & _T_258; // @[Router_Hw.scala 116:99]
  assign _T_268 = _T_267 & _T_261; // @[Router_Hw.scala 116:99]
  assign config_module_id = io_in_3_bits[63:59]; // @[Router_Hw.scala 148:44]
  assign module_id_match = config_module_id == 5'h10; // @[Router_Hw.scala 149:49]
  assign config_data = io_in_3_bits[17:0]; // @[Router_Hw.scala 151:39]
  assign _T_272 = io_in_3_config & module_id_match; // @[Router_Hw.scala 152:22]
  assign io_in_0_ready = _T_176 & _T_172; // @[Router_Hw.scala 178:33]
  assign io_in_1_ready = _T_199 & _T_195; // @[Router_Hw.scala 178:33]
  assign io_in_2_ready = _T_222 & _T_218; // @[Router_Hw.scala 178:33]
  assign io_in_3_ready = io_in_3_config ? io_out_5_ready : decomposed_input_ports_0_3_ready; // @[Router_Hw.scala 178:33 Router_Hw.scala 198:31]
  assign io_in_4_ready = _T_268 & _T_264; // @[Router_Hw.scala 178:33]
  assign io_out_0_valid = _T_7; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_6; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = _T_10; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_9; // @[Router_Hw.scala 212:34]
  assign io_out_2_valid = _T_13; // @[Router_Hw.scala 213:35]
  assign io_out_2_bits = _T_12; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = _T_16; // @[Router_Hw.scala 213:35]
  assign io_out_3_bits = _T_15; // @[Router_Hw.scala 212:34]
  assign io_out_4_valid = _T_19; // @[Router_Hw.scala 213:35]
  assign io_out_4_bits = _T_18; // @[Router_Hw.scala 212:34]
  assign io_out_5_valid = io_in_3_config ? io_in_3_valid : _T_22; // @[Router_Hw.scala 198:31 Router_Hw.scala 204:37]
  assign io_out_5_bits = io_in_3_config ? io_in_3_bits : _T_21; // @[Router_Hw.scala 198:31 Router_Hw.scala 203:36]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_6 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_7 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_9 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_10 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_12 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_13 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {2{`RANDOM}};
  _T_15 = _RAND_10[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  _T_16 = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  decomposed_output_ports_0_4_ready = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {2{`RANDOM}};
  _T_18 = _RAND_13[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  _T_19 = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  decomposed_output_ports_0_5_ready = _RAND_15[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {2{`RANDOM}};
  _T_21 = _RAND_16[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {1{`RANDOM}};
  _T_22 = _RAND_17[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_18 = {1{`RANDOM}};
  config_register_file_0 = _RAND_18[17:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (_T_32) begin
      _T_6 <= io_in_0_bits;
    end else begin
      if (_T_30) begin
        _T_6 <= io_in_1_bits;
      end else begin
        if (_T_28) begin
          _T_6 <= io_in_2_bits;
        end else begin
          if (_T_26) begin
            _T_6 <= io_in_3_bits;
          end else begin
            if (_T_24) begin
              _T_6 <= io_in_4_bits;
            end else begin
              _T_6 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_32) begin
      _T_7 <= io_in_0_valid;
    end else begin
      if (_T_30) begin
        _T_7 <= io_in_1_valid;
      end else begin
        if (_T_28) begin
          _T_7 <= io_in_2_valid;
        end else begin
          if (_T_26) begin
            _T_7 <= io_in_3_valid;
          end else begin
            if (_T_24) begin
              _T_7 <= io_in_4_valid;
            end else begin
              _T_7 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (_T_54) begin
      _T_9 <= io_in_0_bits;
    end else begin
      if (_T_52) begin
        _T_9 <= io_in_1_bits;
      end else begin
        if (_T_50) begin
          _T_9 <= io_in_2_bits;
        end else begin
          if (_T_48) begin
            _T_9 <= io_in_3_bits;
          end else begin
            if (_T_46) begin
              _T_9 <= io_in_4_bits;
            end else begin
              _T_9 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_54) begin
      _T_10 <= io_in_0_valid;
    end else begin
      if (_T_52) begin
        _T_10 <= io_in_1_valid;
      end else begin
        if (_T_50) begin
          _T_10 <= io_in_2_valid;
        end else begin
          if (_T_48) begin
            _T_10 <= io_in_3_valid;
          end else begin
            if (_T_46) begin
              _T_10 <= io_in_4_valid;
            end else begin
              _T_10 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    if (_T_76) begin
      _T_12 <= io_in_0_bits;
    end else begin
      if (_T_74) begin
        _T_12 <= io_in_1_bits;
      end else begin
        if (_T_72) begin
          _T_12 <= io_in_2_bits;
        end else begin
          if (_T_70) begin
            _T_12 <= io_in_3_bits;
          end else begin
            if (_T_68) begin
              _T_12 <= io_in_4_bits;
            end else begin
              _T_12 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_76) begin
      _T_13 <= io_in_0_valid;
    end else begin
      if (_T_74) begin
        _T_13 <= io_in_1_valid;
      end else begin
        if (_T_72) begin
          _T_13 <= io_in_2_valid;
        end else begin
          if (_T_70) begin
            _T_13 <= io_in_3_valid;
          end else begin
            if (_T_68) begin
              _T_13 <= io_in_4_valid;
            end else begin
              _T_13 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_3_ready <= io_out_3_ready;
    if (_T_98) begin
      _T_15 <= io_in_0_bits;
    end else begin
      if (_T_96) begin
        _T_15 <= io_in_1_bits;
      end else begin
        if (_T_94) begin
          _T_15 <= io_in_2_bits;
        end else begin
          if (_T_92) begin
            _T_15 <= io_in_3_bits;
          end else begin
            if (_T_90) begin
              _T_15 <= io_in_4_bits;
            end else begin
              _T_15 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_98) begin
      _T_16 <= io_in_0_valid;
    end else begin
      if (_T_96) begin
        _T_16 <= io_in_1_valid;
      end else begin
        if (_T_94) begin
          _T_16 <= io_in_2_valid;
        end else begin
          if (_T_92) begin
            _T_16 <= io_in_3_valid;
          end else begin
            if (_T_90) begin
              _T_16 <= io_in_4_valid;
            end else begin
              _T_16 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_4_ready <= io_out_4_ready;
    if (_T_120) begin
      _T_18 <= io_in_0_bits;
    end else begin
      if (_T_118) begin
        _T_18 <= io_in_1_bits;
      end else begin
        if (_T_116) begin
          _T_18 <= io_in_2_bits;
        end else begin
          if (_T_114) begin
            _T_18 <= io_in_3_bits;
          end else begin
            if (_T_112) begin
              _T_18 <= io_in_4_bits;
            end else begin
              _T_18 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_120) begin
      _T_19 <= io_in_0_valid;
    end else begin
      if (_T_118) begin
        _T_19 <= io_in_1_valid;
      end else begin
        if (_T_116) begin
          _T_19 <= io_in_2_valid;
        end else begin
          if (_T_114) begin
            _T_19 <= io_in_3_valid;
          end else begin
            if (_T_112) begin
              _T_19 <= io_in_4_valid;
            end else begin
              _T_19 <= 1'h0;
            end
          end
        end
      end
    end
    if (io_in_3_config) begin
      decomposed_output_ports_0_5_ready <= 1'h0;
    end else begin
      decomposed_output_ports_0_5_ready <= io_out_5_ready;
    end
    if (_T_142) begin
      _T_21 <= io_in_0_bits;
    end else begin
      if (_T_140) begin
        _T_21 <= io_in_1_bits;
      end else begin
        if (_T_138) begin
          _T_21 <= io_in_2_bits;
        end else begin
          if (_T_136) begin
            _T_21 <= io_in_3_bits;
          end else begin
            if (_T_134) begin
              _T_21 <= io_in_4_bits;
            end else begin
              _T_21 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_142) begin
      _T_22 <= io_in_0_valid;
    end else begin
      if (_T_140) begin
        _T_22 <= io_in_1_valid;
      end else begin
        if (_T_138) begin
          _T_22 <= io_in_2_valid;
        end else begin
          if (_T_136) begin
            _T_22 <= io_in_3_valid;
          end else begin
            if (_T_134) begin
              _T_22 <= io_in_4_valid;
            end else begin
              _T_22 <= 1'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 18'h0;
    end else begin
      if (_T_272) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Router_Hw_6(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_0_config,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_1_config,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready,
  output        io_out_4_valid,
  output [63:0] io_out_4_bits,
  input         io_out_4_ready
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_5; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_6; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_8; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_9; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg [9:0] config_register_file_0; // @[Router_Hw.scala 140:37]
  reg [31:0] _RAND_6;
  wire [1:0] _T_109; // @[Router_Hw.scala 113:22]
  wire  _T_110; // @[Router_Hw.scala 113:53]
  wire  _T_111; // @[Router_Hw.scala 113:10]
  wire [1:0] _T_112; // @[Router_Hw.scala 113:22]
  wire  _T_113; // @[Router_Hw.scala 113:53]
  wire  _T_114; // @[Router_Hw.scala 113:10]
  wire  _T_124; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_115; // @[Router_Hw.scala 113:22]
  wire  _T_116; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_7;
  wire  _T_117; // @[Router_Hw.scala 113:10]
  wire  _T_125; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_118; // @[Router_Hw.scala 113:22]
  wire  _T_119; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_8;
  wire  _T_120; // @[Router_Hw.scala 113:10]
  wire  _T_126; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_121; // @[Router_Hw.scala 113:22]
  wire  _T_122; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_4_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_9;
  wire  _T_123; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_0_ready; // @[Router_Hw.scala 116:99]
  reg [63:0] _T_11; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_10;
  reg  _T_12; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_11;
  reg [63:0] _T_14; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_12;
  reg  _T_15; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_13;
  reg [63:0] _T_17; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_14;
  reg  _T_18; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_15;
  wire  _T_20; // @[Mux.scala 69:19]
  wire  _T_22; // @[Mux.scala 69:19]
  wire  _T_24; // @[Mux.scala 69:19]
  wire  _T_26; // @[Mux.scala 69:19]
  wire  _T_38; // @[Mux.scala 69:19]
  wire  _T_40; // @[Mux.scala 69:19]
  wire  _T_42; // @[Mux.scala 69:19]
  wire  _T_44; // @[Mux.scala 69:19]
  wire  _T_56; // @[Mux.scala 69:19]
  wire  _T_58; // @[Mux.scala 69:19]
  wire  _T_60; // @[Mux.scala 69:19]
  wire  _T_62; // @[Mux.scala 69:19]
  wire  _T_74; // @[Mux.scala 69:19]
  wire  _T_76; // @[Mux.scala 69:19]
  wire  _T_78; // @[Mux.scala 69:19]
  wire  _T_80; // @[Mux.scala 69:19]
  wire  _T_92; // @[Mux.scala 69:19]
  wire  _T_94; // @[Mux.scala 69:19]
  wire  _T_96; // @[Mux.scala 69:19]
  wire  _T_98; // @[Mux.scala 69:19]
  wire  _T_129; // @[Router_Hw.scala 113:53]
  wire  _T_130; // @[Router_Hw.scala 113:10]
  wire  _T_132; // @[Router_Hw.scala 113:53]
  wire  _T_133; // @[Router_Hw.scala 113:10]
  wire  _T_135; // @[Router_Hw.scala 113:53]
  wire  _T_136; // @[Router_Hw.scala 113:10]
  wire  _T_138; // @[Router_Hw.scala 113:53]
  wire  _T_139; // @[Router_Hw.scala 113:10]
  wire  _T_141; // @[Router_Hw.scala 113:53]
  wire  _T_142; // @[Router_Hw.scala 113:10]
  wire  _T_143; // @[Router_Hw.scala 116:99]
  wire  _T_144; // @[Router_Hw.scala 116:99]
  wire  _T_145; // @[Router_Hw.scala 116:99]
  wire  _T_148; // @[Router_Hw.scala 113:53]
  wire  _T_149; // @[Router_Hw.scala 113:10]
  wire  _T_151; // @[Router_Hw.scala 113:53]
  wire  _T_152; // @[Router_Hw.scala 113:10]
  wire  _T_154; // @[Router_Hw.scala 113:53]
  wire  _T_155; // @[Router_Hw.scala 113:10]
  wire  _T_157; // @[Router_Hw.scala 113:53]
  wire  _T_158; // @[Router_Hw.scala 113:10]
  wire  _T_160; // @[Router_Hw.scala 113:53]
  wire  _T_161; // @[Router_Hw.scala 113:10]
  wire  _T_162; // @[Router_Hw.scala 116:99]
  wire  _T_163; // @[Router_Hw.scala 116:99]
  wire  _T_164; // @[Router_Hw.scala 116:99]
  wire  _T_167; // @[Router_Hw.scala 113:53]
  wire  _T_168; // @[Router_Hw.scala 113:10]
  wire  _T_170; // @[Router_Hw.scala 113:53]
  wire  _T_171; // @[Router_Hw.scala 113:10]
  wire  _T_173; // @[Router_Hw.scala 113:53]
  wire  _T_174; // @[Router_Hw.scala 113:10]
  wire  _T_176; // @[Router_Hw.scala 113:53]
  wire  _T_177; // @[Router_Hw.scala 113:10]
  wire  _T_179; // @[Router_Hw.scala 113:53]
  wire  _T_180; // @[Router_Hw.scala 113:10]
  wire  _T_181; // @[Router_Hw.scala 116:99]
  wire  _T_182; // @[Router_Hw.scala 116:99]
  wire  _T_183; // @[Router_Hw.scala 116:99]
  wire [4:0] config_module_id; // @[Router_Hw.scala 148:44]
  wire  module_id_match; // @[Router_Hw.scala 149:49]
  wire [9:0] config_data; // @[Router_Hw.scala 151:39]
  wire  _T_187; // @[Router_Hw.scala 152:22]
  assign _T_109 = config_register_file_0[1:0]; // @[Router_Hw.scala 113:22]
  assign _T_110 = _T_109 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_111 = _T_110 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_112 = config_register_file_0[3:2]; // @[Router_Hw.scala 113:22]
  assign _T_113 = _T_112 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_114 = _T_113 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_124 = _T_111 & _T_114; // @[Router_Hw.scala 116:99]
  assign _T_115 = config_register_file_0[5:4]; // @[Router_Hw.scala 113:22]
  assign _T_116 = _T_115 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_117 = _T_116 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_125 = _T_124 & _T_117; // @[Router_Hw.scala 116:99]
  assign _T_118 = config_register_file_0[7:6]; // @[Router_Hw.scala 113:22]
  assign _T_119 = _T_118 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_120 = _T_119 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_126 = _T_125 & _T_120; // @[Router_Hw.scala 116:99]
  assign _T_121 = config_register_file_0[9:8]; // @[Router_Hw.scala 113:22]
  assign _T_122 = _T_121 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_123 = _T_122 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_0_ready = _T_126 & _T_123; // @[Router_Hw.scala 116:99]
  assign _T_20 = 2'h3 == _T_109; // @[Mux.scala 69:19]
  assign _T_22 = 2'h2 == _T_109; // @[Mux.scala 69:19]
  assign _T_24 = 2'h1 == _T_109; // @[Mux.scala 69:19]
  assign _T_26 = 2'h0 == _T_109; // @[Mux.scala 69:19]
  assign _T_38 = 2'h3 == _T_112; // @[Mux.scala 69:19]
  assign _T_40 = 2'h2 == _T_112; // @[Mux.scala 69:19]
  assign _T_42 = 2'h1 == _T_112; // @[Mux.scala 69:19]
  assign _T_44 = 2'h0 == _T_112; // @[Mux.scala 69:19]
  assign _T_56 = 2'h3 == _T_115; // @[Mux.scala 69:19]
  assign _T_58 = 2'h2 == _T_115; // @[Mux.scala 69:19]
  assign _T_60 = 2'h1 == _T_115; // @[Mux.scala 69:19]
  assign _T_62 = 2'h0 == _T_115; // @[Mux.scala 69:19]
  assign _T_74 = 2'h3 == _T_118; // @[Mux.scala 69:19]
  assign _T_76 = 2'h2 == _T_118; // @[Mux.scala 69:19]
  assign _T_78 = 2'h1 == _T_118; // @[Mux.scala 69:19]
  assign _T_80 = 2'h0 == _T_118; // @[Mux.scala 69:19]
  assign _T_92 = 2'h3 == _T_121; // @[Mux.scala 69:19]
  assign _T_94 = 2'h2 == _T_121; // @[Mux.scala 69:19]
  assign _T_96 = 2'h1 == _T_121; // @[Mux.scala 69:19]
  assign _T_98 = 2'h0 == _T_121; // @[Mux.scala 69:19]
  assign _T_129 = _T_109 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_130 = _T_129 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_132 = _T_112 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_133 = _T_132 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_135 = _T_115 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_136 = _T_135 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_138 = _T_118 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_139 = _T_138 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_141 = _T_121 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_142 = _T_141 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_143 = _T_130 & _T_133; // @[Router_Hw.scala 116:99]
  assign _T_144 = _T_143 & _T_136; // @[Router_Hw.scala 116:99]
  assign _T_145 = _T_144 & _T_139; // @[Router_Hw.scala 116:99]
  assign _T_148 = _T_109 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_149 = _T_148 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_151 = _T_112 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_152 = _T_151 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_154 = _T_115 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_155 = _T_154 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_157 = _T_118 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_158 = _T_157 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_160 = _T_121 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_161 = _T_160 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_162 = _T_149 & _T_152; // @[Router_Hw.scala 116:99]
  assign _T_163 = _T_162 & _T_155; // @[Router_Hw.scala 116:99]
  assign _T_164 = _T_163 & _T_158; // @[Router_Hw.scala 116:99]
  assign _T_167 = _T_109 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_168 = _T_167 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_170 = _T_112 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_171 = _T_170 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_173 = _T_115 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_174 = _T_173 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_176 = _T_118 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_177 = _T_176 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_179 = _T_121 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_180 = _T_179 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_181 = _T_168 & _T_171; // @[Router_Hw.scala 116:99]
  assign _T_182 = _T_181 & _T_174; // @[Router_Hw.scala 116:99]
  assign _T_183 = _T_182 & _T_177; // @[Router_Hw.scala 116:99]
  assign config_module_id = io_in_0_bits[63:59]; // @[Router_Hw.scala 148:44]
  assign module_id_match = config_module_id == 5'ha; // @[Router_Hw.scala 149:49]
  assign config_data = io_in_0_bits[9:0]; // @[Router_Hw.scala 151:39]
  assign _T_187 = io_in_0_config & module_id_match; // @[Router_Hw.scala 152:22]
  assign io_in_0_ready = io_in_0_config ? io_out_1_ready : decomposed_input_ports_0_0_ready; // @[Router_Hw.scala 178:33 Router_Hw.scala 198:31]
  assign io_in_1_ready = _T_145 & _T_142; // @[Router_Hw.scala 178:33]
  assign io_in_2_ready = _T_164 & _T_161; // @[Router_Hw.scala 178:33]
  assign io_in_3_ready = _T_183 & _T_180; // @[Router_Hw.scala 178:33]
  assign io_out_0_valid = _T_6; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_5; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = io_in_0_config ? io_in_0_valid : _T_9; // @[Router_Hw.scala 198:31 Router_Hw.scala 204:37]
  assign io_out_1_bits = io_in_0_config ? io_in_0_bits : _T_8; // @[Router_Hw.scala 198:31 Router_Hw.scala 203:36]
  assign io_out_1_config = io_in_0_config; // @[Router_Hw.scala 198:31 Router_Hw.scala 205:38]
  assign io_out_2_valid = _T_12; // @[Router_Hw.scala 213:35]
  assign io_out_2_bits = _T_11; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = _T_15; // @[Router_Hw.scala 213:35]
  assign io_out_3_bits = _T_14; // @[Router_Hw.scala 212:34]
  assign io_out_4_valid = _T_18; // @[Router_Hw.scala 213:35]
  assign io_out_4_bits = _T_17; // @[Router_Hw.scala 212:34]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_5 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_6 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_8 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_9 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  config_register_file_0 = _RAND_6[9:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_7[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  decomposed_output_ports_0_4_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {2{`RANDOM}};
  _T_11 = _RAND_10[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  _T_12 = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {2{`RANDOM}};
  _T_14 = _RAND_12[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {1{`RANDOM}};
  _T_15 = _RAND_13[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {2{`RANDOM}};
  _T_17 = _RAND_14[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  _T_18 = _RAND_15[0:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (_T_26) begin
      _T_5 <= io_in_0_bits;
    end else begin
      if (_T_24) begin
        _T_5 <= io_in_1_bits;
      end else begin
        if (_T_22) begin
          _T_5 <= io_in_2_bits;
        end else begin
          if (_T_20) begin
            _T_5 <= io_in_3_bits;
          end else begin
            _T_5 <= 64'h0;
          end
        end
      end
    end
    if (_T_26) begin
      _T_6 <= io_in_0_valid;
    end else begin
      if (_T_24) begin
        _T_6 <= io_in_1_valid;
      end else begin
        if (_T_22) begin
          _T_6 <= io_in_2_valid;
        end else begin
          if (_T_20) begin
            _T_6 <= io_in_3_valid;
          end else begin
            _T_6 <= 1'h0;
          end
        end
      end
    end
    if (io_in_0_config) begin
      decomposed_output_ports_0_1_ready <= 1'h0;
    end else begin
      decomposed_output_ports_0_1_ready <= io_out_1_ready;
    end
    if (_T_44) begin
      _T_8 <= io_in_0_bits;
    end else begin
      if (_T_42) begin
        _T_8 <= io_in_1_bits;
      end else begin
        if (_T_40) begin
          _T_8 <= io_in_2_bits;
        end else begin
          if (_T_38) begin
            _T_8 <= io_in_3_bits;
          end else begin
            _T_8 <= 64'h0;
          end
        end
      end
    end
    if (_T_44) begin
      _T_9 <= io_in_0_valid;
    end else begin
      if (_T_42) begin
        _T_9 <= io_in_1_valid;
      end else begin
        if (_T_40) begin
          _T_9 <= io_in_2_valid;
        end else begin
          if (_T_38) begin
            _T_9 <= io_in_3_valid;
          end else begin
            _T_9 <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 10'h0;
    end else begin
      if (_T_187) begin
        config_register_file_0 <= config_data;
      end
    end
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    decomposed_output_ports_0_3_ready <= io_out_3_ready;
    decomposed_output_ports_0_4_ready <= io_out_4_ready;
    if (_T_62) begin
      _T_11 <= io_in_0_bits;
    end else begin
      if (_T_60) begin
        _T_11 <= io_in_1_bits;
      end else begin
        if (_T_58) begin
          _T_11 <= io_in_2_bits;
        end else begin
          if (_T_56) begin
            _T_11 <= io_in_3_bits;
          end else begin
            _T_11 <= 64'h0;
          end
        end
      end
    end
    if (_T_62) begin
      _T_12 <= io_in_0_valid;
    end else begin
      if (_T_60) begin
        _T_12 <= io_in_1_valid;
      end else begin
        if (_T_58) begin
          _T_12 <= io_in_2_valid;
        end else begin
          if (_T_56) begin
            _T_12 <= io_in_3_valid;
          end else begin
            _T_12 <= 1'h0;
          end
        end
      end
    end
    if (_T_80) begin
      _T_14 <= io_in_0_bits;
    end else begin
      if (_T_78) begin
        _T_14 <= io_in_1_bits;
      end else begin
        if (_T_76) begin
          _T_14 <= io_in_2_bits;
        end else begin
          if (_T_74) begin
            _T_14 <= io_in_3_bits;
          end else begin
            _T_14 <= 64'h0;
          end
        end
      end
    end
    if (_T_80) begin
      _T_15 <= io_in_0_valid;
    end else begin
      if (_T_78) begin
        _T_15 <= io_in_1_valid;
      end else begin
        if (_T_76) begin
          _T_15 <= io_in_2_valid;
        end else begin
          if (_T_74) begin
            _T_15 <= io_in_3_valid;
          end else begin
            _T_15 <= 1'h0;
          end
        end
      end
    end
    if (_T_98) begin
      _T_17 <= io_in_0_bits;
    end else begin
      if (_T_96) begin
        _T_17 <= io_in_1_bits;
      end else begin
        if (_T_94) begin
          _T_17 <= io_in_2_bits;
        end else begin
          if (_T_92) begin
            _T_17 <= io_in_3_bits;
          end else begin
            _T_17 <= 64'h0;
          end
        end
      end
    end
    if (_T_98) begin
      _T_18 <= io_in_0_valid;
    end else begin
      if (_T_96) begin
        _T_18 <= io_in_1_valid;
      end else begin
        if (_T_94) begin
          _T_18 <= io_in_2_valid;
        end else begin
          if (_T_92) begin
            _T_18 <= io_in_3_valid;
          end else begin
            _T_18 <= 1'h0;
          end
        end
      end
    end
  end
endmodule
module Router_Hw_7(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_2_config,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready,
  output        io_out_4_valid,
  output [63:0] io_out_4_bits,
  input         io_out_4_ready,
  output        io_out_4_config
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_5; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_6; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_8; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_9; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [63:0] _T_11; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_7;
  reg  _T_12; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_8;
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_9;
  reg [63:0] _T_14; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_10;
  reg  _T_15; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_11;
  reg  decomposed_output_ports_0_4_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_12;
  reg [63:0] _T_17; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_13;
  reg  _T_18; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_14;
  reg [9:0] config_register_file_0; // @[Router_Hw.scala 140:37]
  reg [31:0] _RAND_15;
  wire [1:0] _T_147; // @[Router_Hw.scala 113:22]
  wire  _T_148; // @[Router_Hw.scala 113:53]
  wire  _T_149; // @[Router_Hw.scala 113:10]
  wire [1:0] _T_150; // @[Router_Hw.scala 113:22]
  wire  _T_151; // @[Router_Hw.scala 113:53]
  wire  _T_152; // @[Router_Hw.scala 113:10]
  wire  _T_162; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_153; // @[Router_Hw.scala 113:22]
  wire  _T_154; // @[Router_Hw.scala 113:53]
  wire  _T_155; // @[Router_Hw.scala 113:10]
  wire  _T_163; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_156; // @[Router_Hw.scala 113:22]
  wire  _T_157; // @[Router_Hw.scala 113:53]
  wire  _T_158; // @[Router_Hw.scala 113:10]
  wire  _T_164; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_159; // @[Router_Hw.scala 113:22]
  wire  _T_160; // @[Router_Hw.scala 113:53]
  wire  _T_161; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_2_ready; // @[Router_Hw.scala 116:99]
  wire  _T_20; // @[Mux.scala 69:19]
  wire  _T_22; // @[Mux.scala 69:19]
  wire  _T_24; // @[Mux.scala 69:19]
  wire  _T_26; // @[Mux.scala 69:19]
  wire  _T_38; // @[Mux.scala 69:19]
  wire  _T_40; // @[Mux.scala 69:19]
  wire  _T_42; // @[Mux.scala 69:19]
  wire  _T_44; // @[Mux.scala 69:19]
  wire  _T_56; // @[Mux.scala 69:19]
  wire  _T_58; // @[Mux.scala 69:19]
  wire  _T_60; // @[Mux.scala 69:19]
  wire  _T_62; // @[Mux.scala 69:19]
  wire  _T_74; // @[Mux.scala 69:19]
  wire  _T_76; // @[Mux.scala 69:19]
  wire  _T_78; // @[Mux.scala 69:19]
  wire  _T_80; // @[Mux.scala 69:19]
  wire  _T_92; // @[Mux.scala 69:19]
  wire  _T_94; // @[Mux.scala 69:19]
  wire  _T_96; // @[Mux.scala 69:19]
  wire  _T_98; // @[Mux.scala 69:19]
  wire  _T_110; // @[Router_Hw.scala 113:53]
  wire  _T_111; // @[Router_Hw.scala 113:10]
  wire  _T_113; // @[Router_Hw.scala 113:53]
  wire  _T_114; // @[Router_Hw.scala 113:10]
  wire  _T_116; // @[Router_Hw.scala 113:53]
  wire  _T_117; // @[Router_Hw.scala 113:10]
  wire  _T_119; // @[Router_Hw.scala 113:53]
  wire  _T_120; // @[Router_Hw.scala 113:10]
  wire  _T_122; // @[Router_Hw.scala 113:53]
  wire  _T_123; // @[Router_Hw.scala 113:10]
  wire  _T_124; // @[Router_Hw.scala 116:99]
  wire  _T_125; // @[Router_Hw.scala 116:99]
  wire  _T_126; // @[Router_Hw.scala 116:99]
  wire  _T_129; // @[Router_Hw.scala 113:53]
  wire  _T_130; // @[Router_Hw.scala 113:10]
  wire  _T_132; // @[Router_Hw.scala 113:53]
  wire  _T_133; // @[Router_Hw.scala 113:10]
  wire  _T_135; // @[Router_Hw.scala 113:53]
  wire  _T_136; // @[Router_Hw.scala 113:10]
  wire  _T_138; // @[Router_Hw.scala 113:53]
  wire  _T_139; // @[Router_Hw.scala 113:10]
  wire  _T_141; // @[Router_Hw.scala 113:53]
  wire  _T_142; // @[Router_Hw.scala 113:10]
  wire  _T_143; // @[Router_Hw.scala 116:99]
  wire  _T_144; // @[Router_Hw.scala 116:99]
  wire  _T_145; // @[Router_Hw.scala 116:99]
  wire  _T_167; // @[Router_Hw.scala 113:53]
  wire  _T_168; // @[Router_Hw.scala 113:10]
  wire  _T_170; // @[Router_Hw.scala 113:53]
  wire  _T_171; // @[Router_Hw.scala 113:10]
  wire  _T_173; // @[Router_Hw.scala 113:53]
  wire  _T_174; // @[Router_Hw.scala 113:10]
  wire  _T_176; // @[Router_Hw.scala 113:53]
  wire  _T_177; // @[Router_Hw.scala 113:10]
  wire  _T_179; // @[Router_Hw.scala 113:53]
  wire  _T_180; // @[Router_Hw.scala 113:10]
  wire  _T_181; // @[Router_Hw.scala 116:99]
  wire  _T_182; // @[Router_Hw.scala 116:99]
  wire  _T_183; // @[Router_Hw.scala 116:99]
  wire [4:0] config_module_id; // @[Router_Hw.scala 148:44]
  wire  module_id_match; // @[Router_Hw.scala 149:49]
  wire [9:0] config_data; // @[Router_Hw.scala 151:39]
  wire  _T_187; // @[Router_Hw.scala 152:22]
  assign _T_147 = config_register_file_0[1:0]; // @[Router_Hw.scala 113:22]
  assign _T_148 = _T_147 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_149 = _T_148 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_150 = config_register_file_0[3:2]; // @[Router_Hw.scala 113:22]
  assign _T_151 = _T_150 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_152 = _T_151 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_162 = _T_149 & _T_152; // @[Router_Hw.scala 116:99]
  assign _T_153 = config_register_file_0[5:4]; // @[Router_Hw.scala 113:22]
  assign _T_154 = _T_153 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_155 = _T_154 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_163 = _T_162 & _T_155; // @[Router_Hw.scala 116:99]
  assign _T_156 = config_register_file_0[7:6]; // @[Router_Hw.scala 113:22]
  assign _T_157 = _T_156 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_158 = _T_157 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_164 = _T_163 & _T_158; // @[Router_Hw.scala 116:99]
  assign _T_159 = config_register_file_0[9:8]; // @[Router_Hw.scala 113:22]
  assign _T_160 = _T_159 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_161 = _T_160 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_2_ready = _T_164 & _T_161; // @[Router_Hw.scala 116:99]
  assign _T_20 = 2'h3 == _T_147; // @[Mux.scala 69:19]
  assign _T_22 = 2'h2 == _T_147; // @[Mux.scala 69:19]
  assign _T_24 = 2'h1 == _T_147; // @[Mux.scala 69:19]
  assign _T_26 = 2'h0 == _T_147; // @[Mux.scala 69:19]
  assign _T_38 = 2'h3 == _T_150; // @[Mux.scala 69:19]
  assign _T_40 = 2'h2 == _T_150; // @[Mux.scala 69:19]
  assign _T_42 = 2'h1 == _T_150; // @[Mux.scala 69:19]
  assign _T_44 = 2'h0 == _T_150; // @[Mux.scala 69:19]
  assign _T_56 = 2'h3 == _T_153; // @[Mux.scala 69:19]
  assign _T_58 = 2'h2 == _T_153; // @[Mux.scala 69:19]
  assign _T_60 = 2'h1 == _T_153; // @[Mux.scala 69:19]
  assign _T_62 = 2'h0 == _T_153; // @[Mux.scala 69:19]
  assign _T_74 = 2'h3 == _T_156; // @[Mux.scala 69:19]
  assign _T_76 = 2'h2 == _T_156; // @[Mux.scala 69:19]
  assign _T_78 = 2'h1 == _T_156; // @[Mux.scala 69:19]
  assign _T_80 = 2'h0 == _T_156; // @[Mux.scala 69:19]
  assign _T_92 = 2'h3 == _T_159; // @[Mux.scala 69:19]
  assign _T_94 = 2'h2 == _T_159; // @[Mux.scala 69:19]
  assign _T_96 = 2'h1 == _T_159; // @[Mux.scala 69:19]
  assign _T_98 = 2'h0 == _T_159; // @[Mux.scala 69:19]
  assign _T_110 = _T_147 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_111 = _T_110 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_113 = _T_150 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_114 = _T_113 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_116 = _T_153 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_117 = _T_116 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_119 = _T_156 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_120 = _T_119 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_122 = _T_159 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_123 = _T_122 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_124 = _T_111 & _T_114; // @[Router_Hw.scala 116:99]
  assign _T_125 = _T_124 & _T_117; // @[Router_Hw.scala 116:99]
  assign _T_126 = _T_125 & _T_120; // @[Router_Hw.scala 116:99]
  assign _T_129 = _T_147 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_130 = _T_129 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_132 = _T_150 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_133 = _T_132 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_135 = _T_153 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_136 = _T_135 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_138 = _T_156 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_139 = _T_138 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_141 = _T_159 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_142 = _T_141 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_143 = _T_130 & _T_133; // @[Router_Hw.scala 116:99]
  assign _T_144 = _T_143 & _T_136; // @[Router_Hw.scala 116:99]
  assign _T_145 = _T_144 & _T_139; // @[Router_Hw.scala 116:99]
  assign _T_167 = _T_147 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_168 = _T_167 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_170 = _T_150 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_171 = _T_170 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_173 = _T_153 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_174 = _T_173 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_176 = _T_156 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_177 = _T_176 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_179 = _T_159 == 2'h3; // @[Router_Hw.scala 113:53]
  assign _T_180 = _T_179 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_181 = _T_168 & _T_171; // @[Router_Hw.scala 116:99]
  assign _T_182 = _T_181 & _T_174; // @[Router_Hw.scala 116:99]
  assign _T_183 = _T_182 & _T_177; // @[Router_Hw.scala 116:99]
  assign config_module_id = io_in_2_bits[63:59]; // @[Router_Hw.scala 148:44]
  assign module_id_match = config_module_id == 5'hd; // @[Router_Hw.scala 149:49]
  assign config_data = io_in_2_bits[9:0]; // @[Router_Hw.scala 151:39]
  assign _T_187 = io_in_2_config & module_id_match; // @[Router_Hw.scala 152:22]
  assign io_in_0_ready = _T_126 & _T_123; // @[Router_Hw.scala 178:33]
  assign io_in_1_ready = _T_145 & _T_142; // @[Router_Hw.scala 178:33]
  assign io_in_2_ready = io_in_2_config ? io_out_4_ready : decomposed_input_ports_0_2_ready; // @[Router_Hw.scala 178:33 Router_Hw.scala 198:31]
  assign io_in_3_ready = _T_183 & _T_180; // @[Router_Hw.scala 178:33]
  assign io_out_0_valid = _T_6; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_5; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = _T_9; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_8; // @[Router_Hw.scala 212:34]
  assign io_out_2_valid = _T_12; // @[Router_Hw.scala 213:35]
  assign io_out_2_bits = _T_11; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = _T_15; // @[Router_Hw.scala 213:35]
  assign io_out_3_bits = _T_14; // @[Router_Hw.scala 212:34]
  assign io_out_4_valid = io_in_2_config ? io_in_2_valid : _T_18; // @[Router_Hw.scala 198:31 Router_Hw.scala 204:37]
  assign io_out_4_bits = io_in_2_config ? io_in_2_bits : _T_17; // @[Router_Hw.scala 198:31 Router_Hw.scala 203:36]
  assign io_out_4_config = io_in_2_config; // @[Router_Hw.scala 198:31 Router_Hw.scala 205:38]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_5 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_6 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_8 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_9 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_11 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_12 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {2{`RANDOM}};
  _T_14 = _RAND_10[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  _T_15 = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  decomposed_output_ports_0_4_ready = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {2{`RANDOM}};
  _T_17 = _RAND_13[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  _T_18 = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  config_register_file_0 = _RAND_15[9:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (_T_26) begin
      _T_5 <= io_in_0_bits;
    end else begin
      if (_T_24) begin
        _T_5 <= io_in_1_bits;
      end else begin
        if (_T_22) begin
          _T_5 <= io_in_2_bits;
        end else begin
          if (_T_20) begin
            _T_5 <= io_in_3_bits;
          end else begin
            _T_5 <= 64'h0;
          end
        end
      end
    end
    if (_T_26) begin
      _T_6 <= io_in_0_valid;
    end else begin
      if (_T_24) begin
        _T_6 <= io_in_1_valid;
      end else begin
        if (_T_22) begin
          _T_6 <= io_in_2_valid;
        end else begin
          if (_T_20) begin
            _T_6 <= io_in_3_valid;
          end else begin
            _T_6 <= 1'h0;
          end
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (_T_44) begin
      _T_8 <= io_in_0_bits;
    end else begin
      if (_T_42) begin
        _T_8 <= io_in_1_bits;
      end else begin
        if (_T_40) begin
          _T_8 <= io_in_2_bits;
        end else begin
          if (_T_38) begin
            _T_8 <= io_in_3_bits;
          end else begin
            _T_8 <= 64'h0;
          end
        end
      end
    end
    if (_T_44) begin
      _T_9 <= io_in_0_valid;
    end else begin
      if (_T_42) begin
        _T_9 <= io_in_1_valid;
      end else begin
        if (_T_40) begin
          _T_9 <= io_in_2_valid;
        end else begin
          if (_T_38) begin
            _T_9 <= io_in_3_valid;
          end else begin
            _T_9 <= 1'h0;
          end
        end
      end
    end
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    if (_T_62) begin
      _T_11 <= io_in_0_bits;
    end else begin
      if (_T_60) begin
        _T_11 <= io_in_1_bits;
      end else begin
        if (_T_58) begin
          _T_11 <= io_in_2_bits;
        end else begin
          if (_T_56) begin
            _T_11 <= io_in_3_bits;
          end else begin
            _T_11 <= 64'h0;
          end
        end
      end
    end
    if (_T_62) begin
      _T_12 <= io_in_0_valid;
    end else begin
      if (_T_60) begin
        _T_12 <= io_in_1_valid;
      end else begin
        if (_T_58) begin
          _T_12 <= io_in_2_valid;
        end else begin
          if (_T_56) begin
            _T_12 <= io_in_3_valid;
          end else begin
            _T_12 <= 1'h0;
          end
        end
      end
    end
    decomposed_output_ports_0_3_ready <= io_out_3_ready;
    if (_T_80) begin
      _T_14 <= io_in_0_bits;
    end else begin
      if (_T_78) begin
        _T_14 <= io_in_1_bits;
      end else begin
        if (_T_76) begin
          _T_14 <= io_in_2_bits;
        end else begin
          if (_T_74) begin
            _T_14 <= io_in_3_bits;
          end else begin
            _T_14 <= 64'h0;
          end
        end
      end
    end
    if (_T_80) begin
      _T_15 <= io_in_0_valid;
    end else begin
      if (_T_78) begin
        _T_15 <= io_in_1_valid;
      end else begin
        if (_T_76) begin
          _T_15 <= io_in_2_valid;
        end else begin
          if (_T_74) begin
            _T_15 <= io_in_3_valid;
          end else begin
            _T_15 <= 1'h0;
          end
        end
      end
    end
    if (io_in_2_config) begin
      decomposed_output_ports_0_4_ready <= 1'h0;
    end else begin
      decomposed_output_ports_0_4_ready <= io_out_4_ready;
    end
    if (_T_98) begin
      _T_17 <= io_in_0_bits;
    end else begin
      if (_T_96) begin
        _T_17 <= io_in_1_bits;
      end else begin
        if (_T_94) begin
          _T_17 <= io_in_2_bits;
        end else begin
          if (_T_92) begin
            _T_17 <= io_in_3_bits;
          end else begin
            _T_17 <= 64'h0;
          end
        end
      end
    end
    if (_T_98) begin
      _T_18 <= io_in_0_valid;
    end else begin
      if (_T_96) begin
        _T_18 <= io_in_1_valid;
      end else begin
        if (_T_94) begin
          _T_18 <= io_in_2_valid;
        end else begin
          if (_T_92) begin
            _T_18 <= io_in_3_valid;
          end else begin
            _T_18 <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 10'h0;
    end else begin
      if (_T_187) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Router_Hw_8(
  input         clock,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready
);
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_7; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_8; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_10; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_11; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [63:0] _T_13; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_7;
  reg  _T_14; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_8;
  wire  _T_84; // @[Router_Hw.scala 116:99]
  assign _T_84 = decomposed_output_ports_0_1_ready & decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 116:99]
  assign io_in_0_ready = _T_84 & decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 178:33]
  assign io_out_1_valid = _T_8; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_7; // @[Router_Hw.scala 212:34]
  assign io_out_2_valid = _T_11; // @[Router_Hw.scala 213:35]
  assign io_out_2_bits = _T_10; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = _T_14; // @[Router_Hw.scala 213:35]
  assign io_out_3_bits = _T_13; // @[Router_Hw.scala 212:34]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_7 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_8 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_10 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_11 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_13 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_14 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    _T_7 <= io_in_0_bits;
    _T_8 <= io_in_0_valid;
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    _T_10 <= io_in_0_bits;
    _T_11 <= io_in_0_valid;
    decomposed_output_ports_0_3_ready <= io_out_3_ready;
    _T_13 <= io_in_0_bits;
    _T_14 <= io_in_0_valid;
  end
endmodule
module Router_Hw_9(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  input         io_in_4_valid,
  input  [63:0] io_in_4_bits,
  output        io_in_4_ready,
  input         io_in_4_config,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready,
  output        io_out_3_config,
  output        io_out_4_valid,
  output [63:0] io_out_4_bits,
  input         io_out_4_ready,
  output        io_out_5_valid,
  output [63:0] io_out_5_bits,
  input         io_out_5_ready,
  output        io_out_6_valid,
  output [63:0] io_out_6_bits,
  input         io_out_6_ready,
  output        io_out_7_valid,
  output [63:0] io_out_7_bits,
  input         io_out_7_ready
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_6; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_7; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_9; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_10; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [63:0] _T_12; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_7;
  reg  _T_13; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_8;
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_9;
  reg [63:0] _T_15; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_10;
  reg  _T_16; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_11;
  reg [23:0] config_register_file_0; // @[Router_Hw.scala 140:37]
  reg [31:0] _RAND_12;
  wire [2:0] _T_329; // @[Router_Hw.scala 113:22]
  wire  _T_330; // @[Router_Hw.scala 113:53]
  wire  _T_331; // @[Router_Hw.scala 113:10]
  wire [2:0] _T_332; // @[Router_Hw.scala 113:22]
  wire  _T_333; // @[Router_Hw.scala 113:53]
  wire  _T_334; // @[Router_Hw.scala 113:10]
  wire  _T_353; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_335; // @[Router_Hw.scala 113:22]
  wire  _T_336; // @[Router_Hw.scala 113:53]
  wire  _T_337; // @[Router_Hw.scala 113:10]
  wire  _T_354; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_338; // @[Router_Hw.scala 113:22]
  wire  _T_339; // @[Router_Hw.scala 113:53]
  wire  _T_340; // @[Router_Hw.scala 113:10]
  wire  _T_355; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_341; // @[Router_Hw.scala 113:22]
  wire  _T_342; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_4_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_13;
  wire  _T_343; // @[Router_Hw.scala 113:10]
  wire  _T_356; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_344; // @[Router_Hw.scala 113:22]
  wire  _T_345; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_5_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_14;
  wire  _T_346; // @[Router_Hw.scala 113:10]
  wire  _T_357; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_347; // @[Router_Hw.scala 113:22]
  wire  _T_348; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_6_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_15;
  wire  _T_349; // @[Router_Hw.scala 113:10]
  wire  _T_358; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_350; // @[Router_Hw.scala 113:22]
  wire  _T_351; // @[Router_Hw.scala 113:53]
  reg  decomposed_output_ports_0_7_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_16;
  wire  _T_352; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_4_ready; // @[Router_Hw.scala 116:99]
  reg [63:0] _T_18; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_17;
  reg  _T_19; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_18;
  reg [63:0] _T_21; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_19;
  reg  _T_22; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_20;
  reg [63:0] _T_24; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_21;
  reg  _T_25; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_22;
  reg [63:0] _T_27; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_23;
  reg  _T_28; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_24;
  wire  _T_30; // @[Mux.scala 69:19]
  wire  _T_32; // @[Mux.scala 69:19]
  wire  _T_34; // @[Mux.scala 69:19]
  wire  _T_36; // @[Mux.scala 69:19]
  wire  _T_38; // @[Mux.scala 69:19]
  wire  _T_52; // @[Mux.scala 69:19]
  wire  _T_54; // @[Mux.scala 69:19]
  wire  _T_56; // @[Mux.scala 69:19]
  wire  _T_58; // @[Mux.scala 69:19]
  wire  _T_60; // @[Mux.scala 69:19]
  wire  _T_74; // @[Mux.scala 69:19]
  wire  _T_76; // @[Mux.scala 69:19]
  wire  _T_78; // @[Mux.scala 69:19]
  wire  _T_80; // @[Mux.scala 69:19]
  wire  _T_82; // @[Mux.scala 69:19]
  wire  _T_96; // @[Mux.scala 69:19]
  wire  _T_98; // @[Mux.scala 69:19]
  wire  _T_100; // @[Mux.scala 69:19]
  wire  _T_102; // @[Mux.scala 69:19]
  wire  _T_104; // @[Mux.scala 69:19]
  wire  _T_118; // @[Mux.scala 69:19]
  wire  _T_120; // @[Mux.scala 69:19]
  wire  _T_122; // @[Mux.scala 69:19]
  wire  _T_124; // @[Mux.scala 69:19]
  wire  _T_126; // @[Mux.scala 69:19]
  wire  _T_140; // @[Mux.scala 69:19]
  wire  _T_142; // @[Mux.scala 69:19]
  wire  _T_144; // @[Mux.scala 69:19]
  wire  _T_146; // @[Mux.scala 69:19]
  wire  _T_148; // @[Mux.scala 69:19]
  wire  _T_162; // @[Mux.scala 69:19]
  wire  _T_164; // @[Mux.scala 69:19]
  wire  _T_166; // @[Mux.scala 69:19]
  wire  _T_168; // @[Mux.scala 69:19]
  wire  _T_170; // @[Mux.scala 69:19]
  wire  _T_184; // @[Mux.scala 69:19]
  wire  _T_186; // @[Mux.scala 69:19]
  wire  _T_188; // @[Mux.scala 69:19]
  wire  _T_190; // @[Mux.scala 69:19]
  wire  _T_192; // @[Mux.scala 69:19]
  wire  _T_206; // @[Router_Hw.scala 113:53]
  wire  _T_207; // @[Router_Hw.scala 113:10]
  wire  _T_209; // @[Router_Hw.scala 113:53]
  wire  _T_210; // @[Router_Hw.scala 113:10]
  wire  _T_212; // @[Router_Hw.scala 113:53]
  wire  _T_213; // @[Router_Hw.scala 113:10]
  wire  _T_215; // @[Router_Hw.scala 113:53]
  wire  _T_216; // @[Router_Hw.scala 113:10]
  wire  _T_218; // @[Router_Hw.scala 113:53]
  wire  _T_219; // @[Router_Hw.scala 113:10]
  wire  _T_221; // @[Router_Hw.scala 113:53]
  wire  _T_222; // @[Router_Hw.scala 113:10]
  wire  _T_224; // @[Router_Hw.scala 113:53]
  wire  _T_225; // @[Router_Hw.scala 113:10]
  wire  _T_227; // @[Router_Hw.scala 113:53]
  wire  _T_228; // @[Router_Hw.scala 113:10]
  wire  _T_229; // @[Router_Hw.scala 116:99]
  wire  _T_230; // @[Router_Hw.scala 116:99]
  wire  _T_231; // @[Router_Hw.scala 116:99]
  wire  _T_232; // @[Router_Hw.scala 116:99]
  wire  _T_233; // @[Router_Hw.scala 116:99]
  wire  _T_234; // @[Router_Hw.scala 116:99]
  wire  _T_237; // @[Router_Hw.scala 113:53]
  wire  _T_238; // @[Router_Hw.scala 113:10]
  wire  _T_240; // @[Router_Hw.scala 113:53]
  wire  _T_241; // @[Router_Hw.scala 113:10]
  wire  _T_243; // @[Router_Hw.scala 113:53]
  wire  _T_244; // @[Router_Hw.scala 113:10]
  wire  _T_246; // @[Router_Hw.scala 113:53]
  wire  _T_247; // @[Router_Hw.scala 113:10]
  wire  _T_249; // @[Router_Hw.scala 113:53]
  wire  _T_250; // @[Router_Hw.scala 113:10]
  wire  _T_252; // @[Router_Hw.scala 113:53]
  wire  _T_253; // @[Router_Hw.scala 113:10]
  wire  _T_255; // @[Router_Hw.scala 113:53]
  wire  _T_256; // @[Router_Hw.scala 113:10]
  wire  _T_258; // @[Router_Hw.scala 113:53]
  wire  _T_259; // @[Router_Hw.scala 113:10]
  wire  _T_260; // @[Router_Hw.scala 116:99]
  wire  _T_261; // @[Router_Hw.scala 116:99]
  wire  _T_262; // @[Router_Hw.scala 116:99]
  wire  _T_263; // @[Router_Hw.scala 116:99]
  wire  _T_264; // @[Router_Hw.scala 116:99]
  wire  _T_265; // @[Router_Hw.scala 116:99]
  wire  _T_268; // @[Router_Hw.scala 113:53]
  wire  _T_269; // @[Router_Hw.scala 113:10]
  wire  _T_271; // @[Router_Hw.scala 113:53]
  wire  _T_272; // @[Router_Hw.scala 113:10]
  wire  _T_274; // @[Router_Hw.scala 113:53]
  wire  _T_275; // @[Router_Hw.scala 113:10]
  wire  _T_277; // @[Router_Hw.scala 113:53]
  wire  _T_278; // @[Router_Hw.scala 113:10]
  wire  _T_280; // @[Router_Hw.scala 113:53]
  wire  _T_281; // @[Router_Hw.scala 113:10]
  wire  _T_283; // @[Router_Hw.scala 113:53]
  wire  _T_284; // @[Router_Hw.scala 113:10]
  wire  _T_286; // @[Router_Hw.scala 113:53]
  wire  _T_287; // @[Router_Hw.scala 113:10]
  wire  _T_289; // @[Router_Hw.scala 113:53]
  wire  _T_290; // @[Router_Hw.scala 113:10]
  wire  _T_291; // @[Router_Hw.scala 116:99]
  wire  _T_292; // @[Router_Hw.scala 116:99]
  wire  _T_293; // @[Router_Hw.scala 116:99]
  wire  _T_294; // @[Router_Hw.scala 116:99]
  wire  _T_295; // @[Router_Hw.scala 116:99]
  wire  _T_296; // @[Router_Hw.scala 116:99]
  wire  _T_299; // @[Router_Hw.scala 113:53]
  wire  _T_300; // @[Router_Hw.scala 113:10]
  wire  _T_302; // @[Router_Hw.scala 113:53]
  wire  _T_303; // @[Router_Hw.scala 113:10]
  wire  _T_305; // @[Router_Hw.scala 113:53]
  wire  _T_306; // @[Router_Hw.scala 113:10]
  wire  _T_308; // @[Router_Hw.scala 113:53]
  wire  _T_309; // @[Router_Hw.scala 113:10]
  wire  _T_311; // @[Router_Hw.scala 113:53]
  wire  _T_312; // @[Router_Hw.scala 113:10]
  wire  _T_314; // @[Router_Hw.scala 113:53]
  wire  _T_315; // @[Router_Hw.scala 113:10]
  wire  _T_317; // @[Router_Hw.scala 113:53]
  wire  _T_318; // @[Router_Hw.scala 113:10]
  wire  _T_320; // @[Router_Hw.scala 113:53]
  wire  _T_321; // @[Router_Hw.scala 113:10]
  wire  _T_322; // @[Router_Hw.scala 116:99]
  wire  _T_323; // @[Router_Hw.scala 116:99]
  wire  _T_324; // @[Router_Hw.scala 116:99]
  wire  _T_325; // @[Router_Hw.scala 116:99]
  wire  _T_326; // @[Router_Hw.scala 116:99]
  wire  _T_327; // @[Router_Hw.scala 116:99]
  wire [4:0] config_module_id; // @[Router_Hw.scala 148:44]
  wire  module_id_match; // @[Router_Hw.scala 149:49]
  wire [23:0] config_data; // @[Router_Hw.scala 151:39]
  wire  _T_362; // @[Router_Hw.scala 152:22]
  assign _T_329 = config_register_file_0[2:0]; // @[Router_Hw.scala 113:22]
  assign _T_330 = _T_329 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_331 = _T_330 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_332 = config_register_file_0[5:3]; // @[Router_Hw.scala 113:22]
  assign _T_333 = _T_332 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_334 = _T_333 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_353 = _T_331 & _T_334; // @[Router_Hw.scala 116:99]
  assign _T_335 = config_register_file_0[8:6]; // @[Router_Hw.scala 113:22]
  assign _T_336 = _T_335 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_337 = _T_336 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_354 = _T_353 & _T_337; // @[Router_Hw.scala 116:99]
  assign _T_338 = config_register_file_0[11:9]; // @[Router_Hw.scala 113:22]
  assign _T_339 = _T_338 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_340 = _T_339 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_355 = _T_354 & _T_340; // @[Router_Hw.scala 116:99]
  assign _T_341 = config_register_file_0[14:12]; // @[Router_Hw.scala 113:22]
  assign _T_342 = _T_341 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_343 = _T_342 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_356 = _T_355 & _T_343; // @[Router_Hw.scala 116:99]
  assign _T_344 = config_register_file_0[17:15]; // @[Router_Hw.scala 113:22]
  assign _T_345 = _T_344 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_346 = _T_345 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_357 = _T_356 & _T_346; // @[Router_Hw.scala 116:99]
  assign _T_347 = config_register_file_0[20:18]; // @[Router_Hw.scala 113:22]
  assign _T_348 = _T_347 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_349 = _T_348 ? decomposed_output_ports_0_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_358 = _T_357 & _T_349; // @[Router_Hw.scala 116:99]
  assign _T_350 = config_register_file_0[23:21]; // @[Router_Hw.scala 113:22]
  assign _T_351 = _T_350 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_352 = _T_351 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_4_ready = _T_358 & _T_352; // @[Router_Hw.scala 116:99]
  assign _T_30 = 3'h4 == _T_329; // @[Mux.scala 69:19]
  assign _T_32 = 3'h3 == _T_329; // @[Mux.scala 69:19]
  assign _T_34 = 3'h2 == _T_329; // @[Mux.scala 69:19]
  assign _T_36 = 3'h1 == _T_329; // @[Mux.scala 69:19]
  assign _T_38 = 3'h0 == _T_329; // @[Mux.scala 69:19]
  assign _T_52 = 3'h4 == _T_332; // @[Mux.scala 69:19]
  assign _T_54 = 3'h3 == _T_332; // @[Mux.scala 69:19]
  assign _T_56 = 3'h2 == _T_332; // @[Mux.scala 69:19]
  assign _T_58 = 3'h1 == _T_332; // @[Mux.scala 69:19]
  assign _T_60 = 3'h0 == _T_332; // @[Mux.scala 69:19]
  assign _T_74 = 3'h4 == _T_335; // @[Mux.scala 69:19]
  assign _T_76 = 3'h3 == _T_335; // @[Mux.scala 69:19]
  assign _T_78 = 3'h2 == _T_335; // @[Mux.scala 69:19]
  assign _T_80 = 3'h1 == _T_335; // @[Mux.scala 69:19]
  assign _T_82 = 3'h0 == _T_335; // @[Mux.scala 69:19]
  assign _T_96 = 3'h4 == _T_338; // @[Mux.scala 69:19]
  assign _T_98 = 3'h3 == _T_338; // @[Mux.scala 69:19]
  assign _T_100 = 3'h2 == _T_338; // @[Mux.scala 69:19]
  assign _T_102 = 3'h1 == _T_338; // @[Mux.scala 69:19]
  assign _T_104 = 3'h0 == _T_338; // @[Mux.scala 69:19]
  assign _T_118 = 3'h4 == _T_341; // @[Mux.scala 69:19]
  assign _T_120 = 3'h3 == _T_341; // @[Mux.scala 69:19]
  assign _T_122 = 3'h2 == _T_341; // @[Mux.scala 69:19]
  assign _T_124 = 3'h1 == _T_341; // @[Mux.scala 69:19]
  assign _T_126 = 3'h0 == _T_341; // @[Mux.scala 69:19]
  assign _T_140 = 3'h4 == _T_344; // @[Mux.scala 69:19]
  assign _T_142 = 3'h3 == _T_344; // @[Mux.scala 69:19]
  assign _T_144 = 3'h2 == _T_344; // @[Mux.scala 69:19]
  assign _T_146 = 3'h1 == _T_344; // @[Mux.scala 69:19]
  assign _T_148 = 3'h0 == _T_344; // @[Mux.scala 69:19]
  assign _T_162 = 3'h4 == _T_347; // @[Mux.scala 69:19]
  assign _T_164 = 3'h3 == _T_347; // @[Mux.scala 69:19]
  assign _T_166 = 3'h2 == _T_347; // @[Mux.scala 69:19]
  assign _T_168 = 3'h1 == _T_347; // @[Mux.scala 69:19]
  assign _T_170 = 3'h0 == _T_347; // @[Mux.scala 69:19]
  assign _T_184 = 3'h4 == _T_350; // @[Mux.scala 69:19]
  assign _T_186 = 3'h3 == _T_350; // @[Mux.scala 69:19]
  assign _T_188 = 3'h2 == _T_350; // @[Mux.scala 69:19]
  assign _T_190 = 3'h1 == _T_350; // @[Mux.scala 69:19]
  assign _T_192 = 3'h0 == _T_350; // @[Mux.scala 69:19]
  assign _T_206 = _T_329 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_207 = _T_206 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_209 = _T_332 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_210 = _T_209 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_212 = _T_335 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_213 = _T_212 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_215 = _T_338 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_216 = _T_215 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_218 = _T_341 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_219 = _T_218 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_221 = _T_344 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_222 = _T_221 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_224 = _T_347 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_225 = _T_224 ? decomposed_output_ports_0_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_227 = _T_350 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_228 = _T_227 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_229 = _T_207 & _T_210; // @[Router_Hw.scala 116:99]
  assign _T_230 = _T_229 & _T_213; // @[Router_Hw.scala 116:99]
  assign _T_231 = _T_230 & _T_216; // @[Router_Hw.scala 116:99]
  assign _T_232 = _T_231 & _T_219; // @[Router_Hw.scala 116:99]
  assign _T_233 = _T_232 & _T_222; // @[Router_Hw.scala 116:99]
  assign _T_234 = _T_233 & _T_225; // @[Router_Hw.scala 116:99]
  assign _T_237 = _T_329 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_238 = _T_237 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_240 = _T_332 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_241 = _T_240 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_243 = _T_335 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_244 = _T_243 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_246 = _T_338 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_247 = _T_246 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_249 = _T_341 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_250 = _T_249 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_252 = _T_344 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_253 = _T_252 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_255 = _T_347 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_256 = _T_255 ? decomposed_output_ports_0_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_258 = _T_350 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_259 = _T_258 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_260 = _T_238 & _T_241; // @[Router_Hw.scala 116:99]
  assign _T_261 = _T_260 & _T_244; // @[Router_Hw.scala 116:99]
  assign _T_262 = _T_261 & _T_247; // @[Router_Hw.scala 116:99]
  assign _T_263 = _T_262 & _T_250; // @[Router_Hw.scala 116:99]
  assign _T_264 = _T_263 & _T_253; // @[Router_Hw.scala 116:99]
  assign _T_265 = _T_264 & _T_256; // @[Router_Hw.scala 116:99]
  assign _T_268 = _T_329 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_269 = _T_268 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_271 = _T_332 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_272 = _T_271 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_274 = _T_335 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_275 = _T_274 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_277 = _T_338 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_278 = _T_277 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_280 = _T_341 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_281 = _T_280 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_283 = _T_344 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_284 = _T_283 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_286 = _T_347 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_287 = _T_286 ? decomposed_output_ports_0_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_289 = _T_350 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_290 = _T_289 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_291 = _T_269 & _T_272; // @[Router_Hw.scala 116:99]
  assign _T_292 = _T_291 & _T_275; // @[Router_Hw.scala 116:99]
  assign _T_293 = _T_292 & _T_278; // @[Router_Hw.scala 116:99]
  assign _T_294 = _T_293 & _T_281; // @[Router_Hw.scala 116:99]
  assign _T_295 = _T_294 & _T_284; // @[Router_Hw.scala 116:99]
  assign _T_296 = _T_295 & _T_287; // @[Router_Hw.scala 116:99]
  assign _T_299 = _T_329 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_300 = _T_299 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_302 = _T_332 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_303 = _T_302 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_305 = _T_335 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_306 = _T_305 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_308 = _T_338 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_309 = _T_308 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_311 = _T_341 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_312 = _T_311 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_314 = _T_344 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_315 = _T_314 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_317 = _T_347 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_318 = _T_317 ? decomposed_output_ports_0_6_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_320 = _T_350 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_321 = _T_320 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_322 = _T_300 & _T_303; // @[Router_Hw.scala 116:99]
  assign _T_323 = _T_322 & _T_306; // @[Router_Hw.scala 116:99]
  assign _T_324 = _T_323 & _T_309; // @[Router_Hw.scala 116:99]
  assign _T_325 = _T_324 & _T_312; // @[Router_Hw.scala 116:99]
  assign _T_326 = _T_325 & _T_315; // @[Router_Hw.scala 116:99]
  assign _T_327 = _T_326 & _T_318; // @[Router_Hw.scala 116:99]
  assign config_module_id = io_in_4_bits[63:59]; // @[Router_Hw.scala 148:44]
  assign module_id_match = config_module_id == 5'h12; // @[Router_Hw.scala 149:49]
  assign config_data = io_in_4_bits[23:0]; // @[Router_Hw.scala 151:39]
  assign _T_362 = io_in_4_config & module_id_match; // @[Router_Hw.scala 152:22]
  assign io_in_0_ready = _T_234 & _T_228; // @[Router_Hw.scala 178:33]
  assign io_in_1_ready = _T_265 & _T_259; // @[Router_Hw.scala 178:33]
  assign io_in_2_ready = _T_296 & _T_290; // @[Router_Hw.scala 178:33]
  assign io_in_3_ready = _T_327 & _T_321; // @[Router_Hw.scala 178:33]
  assign io_in_4_ready = io_in_4_config ? io_out_3_ready : decomposed_input_ports_0_4_ready; // @[Router_Hw.scala 178:33 Router_Hw.scala 198:31]
  assign io_out_0_valid = _T_7; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_6; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = _T_10; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_9; // @[Router_Hw.scala 212:34]
  assign io_out_2_valid = _T_13; // @[Router_Hw.scala 213:35]
  assign io_out_2_bits = _T_12; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = io_in_4_config ? io_in_4_valid : _T_16; // @[Router_Hw.scala 198:31 Router_Hw.scala 204:37]
  assign io_out_3_bits = io_in_4_config ? io_in_4_bits : _T_15; // @[Router_Hw.scala 198:31 Router_Hw.scala 203:36]
  assign io_out_3_config = io_in_4_config; // @[Router_Hw.scala 198:31 Router_Hw.scala 205:38]
  assign io_out_4_valid = _T_19; // @[Router_Hw.scala 213:35]
  assign io_out_4_bits = _T_18; // @[Router_Hw.scala 212:34]
  assign io_out_5_valid = _T_22; // @[Router_Hw.scala 213:35]
  assign io_out_5_bits = _T_21; // @[Router_Hw.scala 212:34]
  assign io_out_6_valid = _T_25; // @[Router_Hw.scala 213:35]
  assign io_out_6_bits = _T_24; // @[Router_Hw.scala 212:34]
  assign io_out_7_valid = _T_28; // @[Router_Hw.scala 213:35]
  assign io_out_7_bits = _T_27; // @[Router_Hw.scala 212:34]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_6 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_7 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_9 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_10 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_12 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_13 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {2{`RANDOM}};
  _T_15 = _RAND_10[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  _T_16 = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  config_register_file_0 = _RAND_12[23:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {1{`RANDOM}};
  decomposed_output_ports_0_4_ready = _RAND_13[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  decomposed_output_ports_0_5_ready = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  decomposed_output_ports_0_6_ready = _RAND_15[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {1{`RANDOM}};
  decomposed_output_ports_0_7_ready = _RAND_16[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {2{`RANDOM}};
  _T_18 = _RAND_17[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_18 = {1{`RANDOM}};
  _T_19 = _RAND_18[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_19 = {2{`RANDOM}};
  _T_21 = _RAND_19[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_20 = {1{`RANDOM}};
  _T_22 = _RAND_20[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_21 = {2{`RANDOM}};
  _T_24 = _RAND_21[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_22 = {1{`RANDOM}};
  _T_25 = _RAND_22[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_23 = {2{`RANDOM}};
  _T_27 = _RAND_23[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_24 = {1{`RANDOM}};
  _T_28 = _RAND_24[0:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (_T_38) begin
      _T_6 <= io_in_0_bits;
    end else begin
      if (_T_36) begin
        _T_6 <= io_in_1_bits;
      end else begin
        if (_T_34) begin
          _T_6 <= io_in_2_bits;
        end else begin
          if (_T_32) begin
            _T_6 <= io_in_3_bits;
          end else begin
            if (_T_30) begin
              _T_6 <= io_in_4_bits;
            end else begin
              _T_6 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_38) begin
      _T_7 <= io_in_0_valid;
    end else begin
      if (_T_36) begin
        _T_7 <= io_in_1_valid;
      end else begin
        if (_T_34) begin
          _T_7 <= io_in_2_valid;
        end else begin
          if (_T_32) begin
            _T_7 <= io_in_3_valid;
          end else begin
            if (_T_30) begin
              _T_7 <= io_in_4_valid;
            end else begin
              _T_7 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (_T_60) begin
      _T_9 <= io_in_0_bits;
    end else begin
      if (_T_58) begin
        _T_9 <= io_in_1_bits;
      end else begin
        if (_T_56) begin
          _T_9 <= io_in_2_bits;
        end else begin
          if (_T_54) begin
            _T_9 <= io_in_3_bits;
          end else begin
            if (_T_52) begin
              _T_9 <= io_in_4_bits;
            end else begin
              _T_9 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_60) begin
      _T_10 <= io_in_0_valid;
    end else begin
      if (_T_58) begin
        _T_10 <= io_in_1_valid;
      end else begin
        if (_T_56) begin
          _T_10 <= io_in_2_valid;
        end else begin
          if (_T_54) begin
            _T_10 <= io_in_3_valid;
          end else begin
            if (_T_52) begin
              _T_10 <= io_in_4_valid;
            end else begin
              _T_10 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    if (_T_82) begin
      _T_12 <= io_in_0_bits;
    end else begin
      if (_T_80) begin
        _T_12 <= io_in_1_bits;
      end else begin
        if (_T_78) begin
          _T_12 <= io_in_2_bits;
        end else begin
          if (_T_76) begin
            _T_12 <= io_in_3_bits;
          end else begin
            if (_T_74) begin
              _T_12 <= io_in_4_bits;
            end else begin
              _T_12 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_82) begin
      _T_13 <= io_in_0_valid;
    end else begin
      if (_T_80) begin
        _T_13 <= io_in_1_valid;
      end else begin
        if (_T_78) begin
          _T_13 <= io_in_2_valid;
        end else begin
          if (_T_76) begin
            _T_13 <= io_in_3_valid;
          end else begin
            if (_T_74) begin
              _T_13 <= io_in_4_valid;
            end else begin
              _T_13 <= 1'h0;
            end
          end
        end
      end
    end
    if (io_in_4_config) begin
      decomposed_output_ports_0_3_ready <= 1'h0;
    end else begin
      decomposed_output_ports_0_3_ready <= io_out_3_ready;
    end
    if (_T_104) begin
      _T_15 <= io_in_0_bits;
    end else begin
      if (_T_102) begin
        _T_15 <= io_in_1_bits;
      end else begin
        if (_T_100) begin
          _T_15 <= io_in_2_bits;
        end else begin
          if (_T_98) begin
            _T_15 <= io_in_3_bits;
          end else begin
            if (_T_96) begin
              _T_15 <= io_in_4_bits;
            end else begin
              _T_15 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_104) begin
      _T_16 <= io_in_0_valid;
    end else begin
      if (_T_102) begin
        _T_16 <= io_in_1_valid;
      end else begin
        if (_T_100) begin
          _T_16 <= io_in_2_valid;
        end else begin
          if (_T_98) begin
            _T_16 <= io_in_3_valid;
          end else begin
            if (_T_96) begin
              _T_16 <= io_in_4_valid;
            end else begin
              _T_16 <= 1'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 24'h0;
    end else begin
      if (_T_362) begin
        config_register_file_0 <= config_data;
      end
    end
    decomposed_output_ports_0_4_ready <= io_out_4_ready;
    decomposed_output_ports_0_5_ready <= io_out_5_ready;
    decomposed_output_ports_0_6_ready <= io_out_6_ready;
    decomposed_output_ports_0_7_ready <= io_out_7_ready;
    if (_T_126) begin
      _T_18 <= io_in_0_bits;
    end else begin
      if (_T_124) begin
        _T_18 <= io_in_1_bits;
      end else begin
        if (_T_122) begin
          _T_18 <= io_in_2_bits;
        end else begin
          if (_T_120) begin
            _T_18 <= io_in_3_bits;
          end else begin
            if (_T_118) begin
              _T_18 <= io_in_4_bits;
            end else begin
              _T_18 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_126) begin
      _T_19 <= io_in_0_valid;
    end else begin
      if (_T_124) begin
        _T_19 <= io_in_1_valid;
      end else begin
        if (_T_122) begin
          _T_19 <= io_in_2_valid;
        end else begin
          if (_T_120) begin
            _T_19 <= io_in_3_valid;
          end else begin
            if (_T_118) begin
              _T_19 <= io_in_4_valid;
            end else begin
              _T_19 <= 1'h0;
            end
          end
        end
      end
    end
    if (_T_148) begin
      _T_21 <= io_in_0_bits;
    end else begin
      if (_T_146) begin
        _T_21 <= io_in_1_bits;
      end else begin
        if (_T_144) begin
          _T_21 <= io_in_2_bits;
        end else begin
          if (_T_142) begin
            _T_21 <= io_in_3_bits;
          end else begin
            if (_T_140) begin
              _T_21 <= io_in_4_bits;
            end else begin
              _T_21 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_148) begin
      _T_22 <= io_in_0_valid;
    end else begin
      if (_T_146) begin
        _T_22 <= io_in_1_valid;
      end else begin
        if (_T_144) begin
          _T_22 <= io_in_2_valid;
        end else begin
          if (_T_142) begin
            _T_22 <= io_in_3_valid;
          end else begin
            if (_T_140) begin
              _T_22 <= io_in_4_valid;
            end else begin
              _T_22 <= 1'h0;
            end
          end
        end
      end
    end
    if (_T_170) begin
      _T_24 <= io_in_0_bits;
    end else begin
      if (_T_168) begin
        _T_24 <= io_in_1_bits;
      end else begin
        if (_T_166) begin
          _T_24 <= io_in_2_bits;
        end else begin
          if (_T_164) begin
            _T_24 <= io_in_3_bits;
          end else begin
            if (_T_162) begin
              _T_24 <= io_in_4_bits;
            end else begin
              _T_24 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_170) begin
      _T_25 <= io_in_0_valid;
    end else begin
      if (_T_168) begin
        _T_25 <= io_in_1_valid;
      end else begin
        if (_T_166) begin
          _T_25 <= io_in_2_valid;
        end else begin
          if (_T_164) begin
            _T_25 <= io_in_3_valid;
          end else begin
            if (_T_162) begin
              _T_25 <= io_in_4_valid;
            end else begin
              _T_25 <= 1'h0;
            end
          end
        end
      end
    end
    if (_T_192) begin
      _T_27 <= io_in_0_bits;
    end else begin
      if (_T_190) begin
        _T_27 <= io_in_1_bits;
      end else begin
        if (_T_188) begin
          _T_27 <= io_in_2_bits;
        end else begin
          if (_T_186) begin
            _T_27 <= io_in_3_bits;
          end else begin
            if (_T_184) begin
              _T_27 <= io_in_4_bits;
            end else begin
              _T_27 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_192) begin
      _T_28 <= io_in_0_valid;
    end else begin
      if (_T_190) begin
        _T_28 <= io_in_1_valid;
      end else begin
        if (_T_188) begin
          _T_28 <= io_in_2_valid;
        end else begin
          if (_T_186) begin
            _T_28 <= io_in_3_valid;
          end else begin
            if (_T_184) begin
              _T_28 <= io_in_4_valid;
            end else begin
              _T_28 <= 1'h0;
            end
          end
        end
      end
    end
  end
endmodule
module Router_Hw_10(
  input         clock,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_3; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_4; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_6; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_7; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [63:0] _T_9; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_7;
  reg  _T_10; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_8;
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_9;
  reg [63:0] _T_12; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_10;
  reg  _T_13; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_11;
  wire  _T_66; // @[Router_Hw.scala 116:99]
  wire  _T_67; // @[Router_Hw.scala 116:99]
  assign _T_66 = decomposed_output_ports_0_0_ready & decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 116:99]
  assign _T_67 = _T_66 & decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 116:99]
  assign io_in_0_ready = _T_67 & decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 178:33]
  assign io_out_0_valid = _T_4; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_3; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = _T_7; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_6; // @[Router_Hw.scala 212:34]
  assign io_out_2_valid = _T_10; // @[Router_Hw.scala 213:35]
  assign io_out_2_bits = _T_9; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = _T_13; // @[Router_Hw.scala 213:35]
  assign io_out_3_bits = _T_12; // @[Router_Hw.scala 212:34]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_3 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_4 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_6 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_7 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_9 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_10 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {2{`RANDOM}};
  _T_12 = _RAND_10[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  _T_13 = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    _T_3 <= io_in_0_bits;
    _T_4 <= io_in_0_valid;
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    _T_6 <= io_in_0_bits;
    _T_7 <= io_in_0_valid;
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    _T_9 <= io_in_0_bits;
    _T_10 <= io_in_0_valid;
    decomposed_output_ports_0_3_ready <= io_out_3_ready;
    _T_12 <= io_in_0_bits;
    _T_13 <= io_in_0_valid;
  end
endmodule
module Router_Hw_11(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  input         io_in_4_valid,
  input  [63:0] io_in_4_bits,
  output        io_in_4_ready,
  input         io_in_4_config,
  input         io_in_5_valid,
  input  [63:0] io_in_5_bits,
  output        io_in_5_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready,
  output        io_out_4_valid,
  output [63:0] io_out_4_bits,
  input         io_out_4_ready,
  output        io_out_5_valid,
  output [63:0] io_out_5_bits,
  input         io_out_5_ready,
  output        io_out_7_valid,
  output [63:0] io_out_7_bits,
  input         io_out_7_ready,
  output        io_out_7_config
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_7; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_8; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_10; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_11; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [63:0] _T_13; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_7;
  reg  _T_14; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_8;
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_9;
  reg [63:0] _T_16; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_10;
  reg  _T_17; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_11;
  reg  decomposed_output_ports_0_4_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_12;
  reg [63:0] _T_19; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_13;
  reg  _T_20; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_14;
  reg  decomposed_output_ports_0_5_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_15;
  reg [63:0] _T_22; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_16;
  reg  _T_23; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_17;
  reg  decomposed_output_ports_0_7_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_18;
  reg [63:0] _T_28; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_19;
  reg  _T_29; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_20;
  reg [23:0] config_register_file_0; // @[Router_Hw.scala 140:37]
  reg [31:0] _RAND_21;
  wire [2:0] _T_362; // @[Router_Hw.scala 113:22]
  wire  _T_363; // @[Router_Hw.scala 113:53]
  wire  _T_364; // @[Router_Hw.scala 113:10]
  wire [2:0] _T_365; // @[Router_Hw.scala 113:22]
  wire  _T_366; // @[Router_Hw.scala 113:53]
  wire  _T_367; // @[Router_Hw.scala 113:10]
  wire  _T_386; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_368; // @[Router_Hw.scala 113:22]
  wire  _T_369; // @[Router_Hw.scala 113:53]
  wire  _T_370; // @[Router_Hw.scala 113:10]
  wire  _T_387; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_371; // @[Router_Hw.scala 113:22]
  wire  _T_372; // @[Router_Hw.scala 113:53]
  wire  _T_373; // @[Router_Hw.scala 113:10]
  wire  _T_388; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_374; // @[Router_Hw.scala 113:22]
  wire  _T_375; // @[Router_Hw.scala 113:53]
  wire  _T_376; // @[Router_Hw.scala 113:10]
  wire  _T_389; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_377; // @[Router_Hw.scala 113:22]
  wire  _T_378; // @[Router_Hw.scala 113:53]
  wire  _T_379; // @[Router_Hw.scala 113:10]
  wire  _T_390; // @[Router_Hw.scala 116:99]
  wire [2:0] _T_383; // @[Router_Hw.scala 113:22]
  wire  _T_384; // @[Router_Hw.scala 113:53]
  wire  _T_385; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_4_ready; // @[Router_Hw.scala 116:99]
  wire  _T_31; // @[Mux.scala 69:19]
  wire  _T_33; // @[Mux.scala 69:19]
  wire  _T_35; // @[Mux.scala 69:19]
  wire  _T_37; // @[Mux.scala 69:19]
  wire  _T_39; // @[Mux.scala 69:19]
  wire  _T_41; // @[Mux.scala 69:19]
  wire  _T_57; // @[Mux.scala 69:19]
  wire  _T_59; // @[Mux.scala 69:19]
  wire  _T_61; // @[Mux.scala 69:19]
  wire  _T_63; // @[Mux.scala 69:19]
  wire  _T_65; // @[Mux.scala 69:19]
  wire  _T_67; // @[Mux.scala 69:19]
  wire  _T_83; // @[Mux.scala 69:19]
  wire  _T_85; // @[Mux.scala 69:19]
  wire  _T_87; // @[Mux.scala 69:19]
  wire  _T_89; // @[Mux.scala 69:19]
  wire  _T_91; // @[Mux.scala 69:19]
  wire  _T_93; // @[Mux.scala 69:19]
  wire  _T_109; // @[Mux.scala 69:19]
  wire  _T_111; // @[Mux.scala 69:19]
  wire  _T_113; // @[Mux.scala 69:19]
  wire  _T_115; // @[Mux.scala 69:19]
  wire  _T_117; // @[Mux.scala 69:19]
  wire  _T_119; // @[Mux.scala 69:19]
  wire  _T_135; // @[Mux.scala 69:19]
  wire  _T_137; // @[Mux.scala 69:19]
  wire  _T_139; // @[Mux.scala 69:19]
  wire  _T_141; // @[Mux.scala 69:19]
  wire  _T_143; // @[Mux.scala 69:19]
  wire  _T_145; // @[Mux.scala 69:19]
  wire  _T_161; // @[Mux.scala 69:19]
  wire  _T_163; // @[Mux.scala 69:19]
  wire  _T_165; // @[Mux.scala 69:19]
  wire  _T_167; // @[Mux.scala 69:19]
  wire  _T_169; // @[Mux.scala 69:19]
  wire  _T_171; // @[Mux.scala 69:19]
  wire  _T_213; // @[Mux.scala 69:19]
  wire  _T_215; // @[Mux.scala 69:19]
  wire  _T_217; // @[Mux.scala 69:19]
  wire  _T_219; // @[Mux.scala 69:19]
  wire  _T_221; // @[Mux.scala 69:19]
  wire  _T_223; // @[Mux.scala 69:19]
  wire  _T_239; // @[Router_Hw.scala 113:53]
  wire  _T_240; // @[Router_Hw.scala 113:10]
  wire  _T_242; // @[Router_Hw.scala 113:53]
  wire  _T_243; // @[Router_Hw.scala 113:10]
  wire  _T_245; // @[Router_Hw.scala 113:53]
  wire  _T_246; // @[Router_Hw.scala 113:10]
  wire  _T_248; // @[Router_Hw.scala 113:53]
  wire  _T_249; // @[Router_Hw.scala 113:10]
  wire  _T_251; // @[Router_Hw.scala 113:53]
  wire  _T_252; // @[Router_Hw.scala 113:10]
  wire  _T_254; // @[Router_Hw.scala 113:53]
  wire  _T_255; // @[Router_Hw.scala 113:10]
  wire  _T_260; // @[Router_Hw.scala 113:53]
  wire  _T_261; // @[Router_Hw.scala 113:10]
  wire  _T_262; // @[Router_Hw.scala 116:99]
  wire  _T_263; // @[Router_Hw.scala 116:99]
  wire  _T_264; // @[Router_Hw.scala 116:99]
  wire  _T_265; // @[Router_Hw.scala 116:99]
  wire  _T_266; // @[Router_Hw.scala 116:99]
  wire  _T_270; // @[Router_Hw.scala 113:53]
  wire  _T_271; // @[Router_Hw.scala 113:10]
  wire  _T_273; // @[Router_Hw.scala 113:53]
  wire  _T_274; // @[Router_Hw.scala 113:10]
  wire  _T_276; // @[Router_Hw.scala 113:53]
  wire  _T_277; // @[Router_Hw.scala 113:10]
  wire  _T_279; // @[Router_Hw.scala 113:53]
  wire  _T_280; // @[Router_Hw.scala 113:10]
  wire  _T_282; // @[Router_Hw.scala 113:53]
  wire  _T_283; // @[Router_Hw.scala 113:10]
  wire  _T_285; // @[Router_Hw.scala 113:53]
  wire  _T_286; // @[Router_Hw.scala 113:10]
  wire  _T_291; // @[Router_Hw.scala 113:53]
  wire  _T_292; // @[Router_Hw.scala 113:10]
  wire  _T_293; // @[Router_Hw.scala 116:99]
  wire  _T_294; // @[Router_Hw.scala 116:99]
  wire  _T_295; // @[Router_Hw.scala 116:99]
  wire  _T_296; // @[Router_Hw.scala 116:99]
  wire  _T_297; // @[Router_Hw.scala 116:99]
  wire  _T_301; // @[Router_Hw.scala 113:53]
  wire  _T_302; // @[Router_Hw.scala 113:10]
  wire  _T_304; // @[Router_Hw.scala 113:53]
  wire  _T_305; // @[Router_Hw.scala 113:10]
  wire  _T_307; // @[Router_Hw.scala 113:53]
  wire  _T_308; // @[Router_Hw.scala 113:10]
  wire  _T_310; // @[Router_Hw.scala 113:53]
  wire  _T_311; // @[Router_Hw.scala 113:10]
  wire  _T_313; // @[Router_Hw.scala 113:53]
  wire  _T_314; // @[Router_Hw.scala 113:10]
  wire  _T_316; // @[Router_Hw.scala 113:53]
  wire  _T_317; // @[Router_Hw.scala 113:10]
  wire  _T_322; // @[Router_Hw.scala 113:53]
  wire  _T_323; // @[Router_Hw.scala 113:10]
  wire  _T_324; // @[Router_Hw.scala 116:99]
  wire  _T_325; // @[Router_Hw.scala 116:99]
  wire  _T_326; // @[Router_Hw.scala 116:99]
  wire  _T_327; // @[Router_Hw.scala 116:99]
  wire  _T_328; // @[Router_Hw.scala 116:99]
  wire  _T_332; // @[Router_Hw.scala 113:53]
  wire  _T_333; // @[Router_Hw.scala 113:10]
  wire  _T_335; // @[Router_Hw.scala 113:53]
  wire  _T_336; // @[Router_Hw.scala 113:10]
  wire  _T_338; // @[Router_Hw.scala 113:53]
  wire  _T_339; // @[Router_Hw.scala 113:10]
  wire  _T_341; // @[Router_Hw.scala 113:53]
  wire  _T_342; // @[Router_Hw.scala 113:10]
  wire  _T_344; // @[Router_Hw.scala 113:53]
  wire  _T_345; // @[Router_Hw.scala 113:10]
  wire  _T_347; // @[Router_Hw.scala 113:53]
  wire  _T_348; // @[Router_Hw.scala 113:10]
  wire  _T_353; // @[Router_Hw.scala 113:53]
  wire  _T_354; // @[Router_Hw.scala 113:10]
  wire  _T_355; // @[Router_Hw.scala 116:99]
  wire  _T_356; // @[Router_Hw.scala 116:99]
  wire  _T_357; // @[Router_Hw.scala 116:99]
  wire  _T_358; // @[Router_Hw.scala 116:99]
  wire  _T_359; // @[Router_Hw.scala 116:99]
  wire  _T_394; // @[Router_Hw.scala 113:53]
  wire  _T_395; // @[Router_Hw.scala 113:10]
  wire  _T_397; // @[Router_Hw.scala 113:53]
  wire  _T_398; // @[Router_Hw.scala 113:10]
  wire  _T_400; // @[Router_Hw.scala 113:53]
  wire  _T_401; // @[Router_Hw.scala 113:10]
  wire  _T_403; // @[Router_Hw.scala 113:53]
  wire  _T_404; // @[Router_Hw.scala 113:10]
  wire  _T_406; // @[Router_Hw.scala 113:53]
  wire  _T_407; // @[Router_Hw.scala 113:10]
  wire  _T_409; // @[Router_Hw.scala 113:53]
  wire  _T_410; // @[Router_Hw.scala 113:10]
  wire  _T_415; // @[Router_Hw.scala 113:53]
  wire  _T_416; // @[Router_Hw.scala 113:10]
  wire  _T_417; // @[Router_Hw.scala 116:99]
  wire  _T_418; // @[Router_Hw.scala 116:99]
  wire  _T_419; // @[Router_Hw.scala 116:99]
  wire  _T_420; // @[Router_Hw.scala 116:99]
  wire  _T_421; // @[Router_Hw.scala 116:99]
  wire [4:0] config_module_id; // @[Router_Hw.scala 148:44]
  wire  module_id_match; // @[Router_Hw.scala 149:49]
  wire [23:0] config_data; // @[Router_Hw.scala 151:39]
  wire  _T_426; // @[Router_Hw.scala 152:22]
  assign _T_362 = config_register_file_0[2:0]; // @[Router_Hw.scala 113:22]
  assign _T_363 = _T_362 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_364 = _T_363 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_365 = config_register_file_0[5:3]; // @[Router_Hw.scala 113:22]
  assign _T_366 = _T_365 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_367 = _T_366 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_386 = _T_364 & _T_367; // @[Router_Hw.scala 116:99]
  assign _T_368 = config_register_file_0[8:6]; // @[Router_Hw.scala 113:22]
  assign _T_369 = _T_368 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_370 = _T_369 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_387 = _T_386 & _T_370; // @[Router_Hw.scala 116:99]
  assign _T_371 = config_register_file_0[11:9]; // @[Router_Hw.scala 113:22]
  assign _T_372 = _T_371 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_373 = _T_372 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_388 = _T_387 & _T_373; // @[Router_Hw.scala 116:99]
  assign _T_374 = config_register_file_0[14:12]; // @[Router_Hw.scala 113:22]
  assign _T_375 = _T_374 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_376 = _T_375 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_389 = _T_388 & _T_376; // @[Router_Hw.scala 116:99]
  assign _T_377 = config_register_file_0[17:15]; // @[Router_Hw.scala 113:22]
  assign _T_378 = _T_377 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_379 = _T_378 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_390 = _T_389 & _T_379; // @[Router_Hw.scala 116:99]
  assign _T_383 = config_register_file_0[23:21]; // @[Router_Hw.scala 113:22]
  assign _T_384 = _T_383 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_385 = _T_384 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_4_ready = _T_390 & _T_385; // @[Router_Hw.scala 116:99]
  assign _T_31 = 3'h5 == _T_362; // @[Mux.scala 69:19]
  assign _T_33 = 3'h4 == _T_362; // @[Mux.scala 69:19]
  assign _T_35 = 3'h3 == _T_362; // @[Mux.scala 69:19]
  assign _T_37 = 3'h2 == _T_362; // @[Mux.scala 69:19]
  assign _T_39 = 3'h1 == _T_362; // @[Mux.scala 69:19]
  assign _T_41 = 3'h0 == _T_362; // @[Mux.scala 69:19]
  assign _T_57 = 3'h5 == _T_365; // @[Mux.scala 69:19]
  assign _T_59 = 3'h4 == _T_365; // @[Mux.scala 69:19]
  assign _T_61 = 3'h3 == _T_365; // @[Mux.scala 69:19]
  assign _T_63 = 3'h2 == _T_365; // @[Mux.scala 69:19]
  assign _T_65 = 3'h1 == _T_365; // @[Mux.scala 69:19]
  assign _T_67 = 3'h0 == _T_365; // @[Mux.scala 69:19]
  assign _T_83 = 3'h5 == _T_368; // @[Mux.scala 69:19]
  assign _T_85 = 3'h4 == _T_368; // @[Mux.scala 69:19]
  assign _T_87 = 3'h3 == _T_368; // @[Mux.scala 69:19]
  assign _T_89 = 3'h2 == _T_368; // @[Mux.scala 69:19]
  assign _T_91 = 3'h1 == _T_368; // @[Mux.scala 69:19]
  assign _T_93 = 3'h0 == _T_368; // @[Mux.scala 69:19]
  assign _T_109 = 3'h5 == _T_371; // @[Mux.scala 69:19]
  assign _T_111 = 3'h4 == _T_371; // @[Mux.scala 69:19]
  assign _T_113 = 3'h3 == _T_371; // @[Mux.scala 69:19]
  assign _T_115 = 3'h2 == _T_371; // @[Mux.scala 69:19]
  assign _T_117 = 3'h1 == _T_371; // @[Mux.scala 69:19]
  assign _T_119 = 3'h0 == _T_371; // @[Mux.scala 69:19]
  assign _T_135 = 3'h5 == _T_374; // @[Mux.scala 69:19]
  assign _T_137 = 3'h4 == _T_374; // @[Mux.scala 69:19]
  assign _T_139 = 3'h3 == _T_374; // @[Mux.scala 69:19]
  assign _T_141 = 3'h2 == _T_374; // @[Mux.scala 69:19]
  assign _T_143 = 3'h1 == _T_374; // @[Mux.scala 69:19]
  assign _T_145 = 3'h0 == _T_374; // @[Mux.scala 69:19]
  assign _T_161 = 3'h5 == _T_377; // @[Mux.scala 69:19]
  assign _T_163 = 3'h4 == _T_377; // @[Mux.scala 69:19]
  assign _T_165 = 3'h3 == _T_377; // @[Mux.scala 69:19]
  assign _T_167 = 3'h2 == _T_377; // @[Mux.scala 69:19]
  assign _T_169 = 3'h1 == _T_377; // @[Mux.scala 69:19]
  assign _T_171 = 3'h0 == _T_377; // @[Mux.scala 69:19]
  assign _T_213 = 3'h5 == _T_383; // @[Mux.scala 69:19]
  assign _T_215 = 3'h4 == _T_383; // @[Mux.scala 69:19]
  assign _T_217 = 3'h3 == _T_383; // @[Mux.scala 69:19]
  assign _T_219 = 3'h2 == _T_383; // @[Mux.scala 69:19]
  assign _T_221 = 3'h1 == _T_383; // @[Mux.scala 69:19]
  assign _T_223 = 3'h0 == _T_383; // @[Mux.scala 69:19]
  assign _T_239 = _T_362 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_240 = _T_239 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_242 = _T_365 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_243 = _T_242 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_245 = _T_368 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_246 = _T_245 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_248 = _T_371 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_249 = _T_248 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_251 = _T_374 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_252 = _T_251 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_254 = _T_377 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_255 = _T_254 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_260 = _T_383 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_261 = _T_260 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_262 = _T_240 & _T_243; // @[Router_Hw.scala 116:99]
  assign _T_263 = _T_262 & _T_246; // @[Router_Hw.scala 116:99]
  assign _T_264 = _T_263 & _T_249; // @[Router_Hw.scala 116:99]
  assign _T_265 = _T_264 & _T_252; // @[Router_Hw.scala 116:99]
  assign _T_266 = _T_265 & _T_255; // @[Router_Hw.scala 116:99]
  assign _T_270 = _T_362 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_271 = _T_270 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_273 = _T_365 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_274 = _T_273 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_276 = _T_368 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_277 = _T_276 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_279 = _T_371 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_280 = _T_279 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_282 = _T_374 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_283 = _T_282 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_285 = _T_377 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_286 = _T_285 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_291 = _T_383 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_292 = _T_291 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_293 = _T_271 & _T_274; // @[Router_Hw.scala 116:99]
  assign _T_294 = _T_293 & _T_277; // @[Router_Hw.scala 116:99]
  assign _T_295 = _T_294 & _T_280; // @[Router_Hw.scala 116:99]
  assign _T_296 = _T_295 & _T_283; // @[Router_Hw.scala 116:99]
  assign _T_297 = _T_296 & _T_286; // @[Router_Hw.scala 116:99]
  assign _T_301 = _T_362 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_302 = _T_301 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_304 = _T_365 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_305 = _T_304 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_307 = _T_368 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_308 = _T_307 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_310 = _T_371 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_311 = _T_310 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_313 = _T_374 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_314 = _T_313 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_316 = _T_377 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_317 = _T_316 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_322 = _T_383 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_323 = _T_322 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_324 = _T_302 & _T_305; // @[Router_Hw.scala 116:99]
  assign _T_325 = _T_324 & _T_308; // @[Router_Hw.scala 116:99]
  assign _T_326 = _T_325 & _T_311; // @[Router_Hw.scala 116:99]
  assign _T_327 = _T_326 & _T_314; // @[Router_Hw.scala 116:99]
  assign _T_328 = _T_327 & _T_317; // @[Router_Hw.scala 116:99]
  assign _T_332 = _T_362 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_333 = _T_332 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_335 = _T_365 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_336 = _T_335 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_338 = _T_368 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_339 = _T_338 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_341 = _T_371 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_342 = _T_341 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_344 = _T_374 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_345 = _T_344 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_347 = _T_377 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_348 = _T_347 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_353 = _T_383 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_354 = _T_353 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_355 = _T_333 & _T_336; // @[Router_Hw.scala 116:99]
  assign _T_356 = _T_355 & _T_339; // @[Router_Hw.scala 116:99]
  assign _T_357 = _T_356 & _T_342; // @[Router_Hw.scala 116:99]
  assign _T_358 = _T_357 & _T_345; // @[Router_Hw.scala 116:99]
  assign _T_359 = _T_358 & _T_348; // @[Router_Hw.scala 116:99]
  assign _T_394 = _T_362 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_395 = _T_394 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_397 = _T_365 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_398 = _T_397 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_400 = _T_368 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_401 = _T_400 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_403 = _T_371 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_404 = _T_403 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_406 = _T_374 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_407 = _T_406 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_409 = _T_377 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_410 = _T_409 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_415 = _T_383 == 3'h5; // @[Router_Hw.scala 113:53]
  assign _T_416 = _T_415 ? decomposed_output_ports_0_7_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_417 = _T_395 & _T_398; // @[Router_Hw.scala 116:99]
  assign _T_418 = _T_417 & _T_401; // @[Router_Hw.scala 116:99]
  assign _T_419 = _T_418 & _T_404; // @[Router_Hw.scala 116:99]
  assign _T_420 = _T_419 & _T_407; // @[Router_Hw.scala 116:99]
  assign _T_421 = _T_420 & _T_410; // @[Router_Hw.scala 116:99]
  assign config_module_id = io_in_4_bits[63:59]; // @[Router_Hw.scala 148:44]
  assign module_id_match = config_module_id == 5'hf; // @[Router_Hw.scala 149:49]
  assign config_data = io_in_4_bits[23:0]; // @[Router_Hw.scala 151:39]
  assign _T_426 = io_in_4_config & module_id_match; // @[Router_Hw.scala 152:22]
  assign io_in_0_ready = _T_266 & _T_261; // @[Router_Hw.scala 178:33]
  assign io_in_1_ready = _T_297 & _T_292; // @[Router_Hw.scala 178:33]
  assign io_in_2_ready = _T_328 & _T_323; // @[Router_Hw.scala 178:33]
  assign io_in_3_ready = _T_359 & _T_354; // @[Router_Hw.scala 178:33]
  assign io_in_4_ready = io_in_4_config ? io_out_7_ready : decomposed_input_ports_0_4_ready; // @[Router_Hw.scala 178:33 Router_Hw.scala 198:31]
  assign io_in_5_ready = _T_421 & _T_416; // @[Router_Hw.scala 178:33]
  assign io_out_0_valid = _T_8; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_7; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = _T_11; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_10; // @[Router_Hw.scala 212:34]
  assign io_out_2_valid = _T_14; // @[Router_Hw.scala 213:35]
  assign io_out_2_bits = _T_13; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = _T_17; // @[Router_Hw.scala 213:35]
  assign io_out_3_bits = _T_16; // @[Router_Hw.scala 212:34]
  assign io_out_4_valid = _T_20; // @[Router_Hw.scala 213:35]
  assign io_out_4_bits = _T_19; // @[Router_Hw.scala 212:34]
  assign io_out_5_valid = _T_23; // @[Router_Hw.scala 213:35]
  assign io_out_5_bits = _T_22; // @[Router_Hw.scala 212:34]
  assign io_out_7_valid = io_in_4_config ? io_in_4_valid : _T_29; // @[Router_Hw.scala 198:31 Router_Hw.scala 204:37]
  assign io_out_7_bits = io_in_4_config ? io_in_4_bits : _T_28; // @[Router_Hw.scala 198:31 Router_Hw.scala 203:36]
  assign io_out_7_config = io_in_4_config; // @[Router_Hw.scala 198:31 Router_Hw.scala 205:38]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_7 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_8 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_10 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_11 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_13 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_14 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {2{`RANDOM}};
  _T_16 = _RAND_10[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  _T_17 = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  decomposed_output_ports_0_4_ready = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {2{`RANDOM}};
  _T_19 = _RAND_13[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  _T_20 = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  decomposed_output_ports_0_5_ready = _RAND_15[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {2{`RANDOM}};
  _T_22 = _RAND_16[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {1{`RANDOM}};
  _T_23 = _RAND_17[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_18 = {1{`RANDOM}};
  decomposed_output_ports_0_7_ready = _RAND_18[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_19 = {2{`RANDOM}};
  _T_28 = _RAND_19[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_20 = {1{`RANDOM}};
  _T_29 = _RAND_20[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_21 = {1{`RANDOM}};
  config_register_file_0 = _RAND_21[23:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (_T_41) begin
      _T_7 <= io_in_0_bits;
    end else begin
      if (_T_39) begin
        _T_7 <= io_in_1_bits;
      end else begin
        if (_T_37) begin
          _T_7 <= io_in_2_bits;
        end else begin
          if (_T_35) begin
            _T_7 <= io_in_3_bits;
          end else begin
            if (_T_33) begin
              _T_7 <= io_in_4_bits;
            end else begin
              if (_T_31) begin
                _T_7 <= io_in_5_bits;
              end else begin
                _T_7 <= 64'h0;
              end
            end
          end
        end
      end
    end
    if (_T_41) begin
      _T_8 <= io_in_0_valid;
    end else begin
      if (_T_39) begin
        _T_8 <= io_in_1_valid;
      end else begin
        if (_T_37) begin
          _T_8 <= io_in_2_valid;
        end else begin
          if (_T_35) begin
            _T_8 <= io_in_3_valid;
          end else begin
            if (_T_33) begin
              _T_8 <= io_in_4_valid;
            end else begin
              if (_T_31) begin
                _T_8 <= io_in_5_valid;
              end else begin
                _T_8 <= 1'h0;
              end
            end
          end
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (_T_67) begin
      _T_10 <= io_in_0_bits;
    end else begin
      if (_T_65) begin
        _T_10 <= io_in_1_bits;
      end else begin
        if (_T_63) begin
          _T_10 <= io_in_2_bits;
        end else begin
          if (_T_61) begin
            _T_10 <= io_in_3_bits;
          end else begin
            if (_T_59) begin
              _T_10 <= io_in_4_bits;
            end else begin
              if (_T_57) begin
                _T_10 <= io_in_5_bits;
              end else begin
                _T_10 <= 64'h0;
              end
            end
          end
        end
      end
    end
    if (_T_67) begin
      _T_11 <= io_in_0_valid;
    end else begin
      if (_T_65) begin
        _T_11 <= io_in_1_valid;
      end else begin
        if (_T_63) begin
          _T_11 <= io_in_2_valid;
        end else begin
          if (_T_61) begin
            _T_11 <= io_in_3_valid;
          end else begin
            if (_T_59) begin
              _T_11 <= io_in_4_valid;
            end else begin
              if (_T_57) begin
                _T_11 <= io_in_5_valid;
              end else begin
                _T_11 <= 1'h0;
              end
            end
          end
        end
      end
    end
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    if (_T_93) begin
      _T_13 <= io_in_0_bits;
    end else begin
      if (_T_91) begin
        _T_13 <= io_in_1_bits;
      end else begin
        if (_T_89) begin
          _T_13 <= io_in_2_bits;
        end else begin
          if (_T_87) begin
            _T_13 <= io_in_3_bits;
          end else begin
            if (_T_85) begin
              _T_13 <= io_in_4_bits;
            end else begin
              if (_T_83) begin
                _T_13 <= io_in_5_bits;
              end else begin
                _T_13 <= 64'h0;
              end
            end
          end
        end
      end
    end
    if (_T_93) begin
      _T_14 <= io_in_0_valid;
    end else begin
      if (_T_91) begin
        _T_14 <= io_in_1_valid;
      end else begin
        if (_T_89) begin
          _T_14 <= io_in_2_valid;
        end else begin
          if (_T_87) begin
            _T_14 <= io_in_3_valid;
          end else begin
            if (_T_85) begin
              _T_14 <= io_in_4_valid;
            end else begin
              if (_T_83) begin
                _T_14 <= io_in_5_valid;
              end else begin
                _T_14 <= 1'h0;
              end
            end
          end
        end
      end
    end
    decomposed_output_ports_0_3_ready <= io_out_3_ready;
    if (_T_119) begin
      _T_16 <= io_in_0_bits;
    end else begin
      if (_T_117) begin
        _T_16 <= io_in_1_bits;
      end else begin
        if (_T_115) begin
          _T_16 <= io_in_2_bits;
        end else begin
          if (_T_113) begin
            _T_16 <= io_in_3_bits;
          end else begin
            if (_T_111) begin
              _T_16 <= io_in_4_bits;
            end else begin
              if (_T_109) begin
                _T_16 <= io_in_5_bits;
              end else begin
                _T_16 <= 64'h0;
              end
            end
          end
        end
      end
    end
    if (_T_119) begin
      _T_17 <= io_in_0_valid;
    end else begin
      if (_T_117) begin
        _T_17 <= io_in_1_valid;
      end else begin
        if (_T_115) begin
          _T_17 <= io_in_2_valid;
        end else begin
          if (_T_113) begin
            _T_17 <= io_in_3_valid;
          end else begin
            if (_T_111) begin
              _T_17 <= io_in_4_valid;
            end else begin
              if (_T_109) begin
                _T_17 <= io_in_5_valid;
              end else begin
                _T_17 <= 1'h0;
              end
            end
          end
        end
      end
    end
    decomposed_output_ports_0_4_ready <= io_out_4_ready;
    if (_T_145) begin
      _T_19 <= io_in_0_bits;
    end else begin
      if (_T_143) begin
        _T_19 <= io_in_1_bits;
      end else begin
        if (_T_141) begin
          _T_19 <= io_in_2_bits;
        end else begin
          if (_T_139) begin
            _T_19 <= io_in_3_bits;
          end else begin
            if (_T_137) begin
              _T_19 <= io_in_4_bits;
            end else begin
              if (_T_135) begin
                _T_19 <= io_in_5_bits;
              end else begin
                _T_19 <= 64'h0;
              end
            end
          end
        end
      end
    end
    if (_T_145) begin
      _T_20 <= io_in_0_valid;
    end else begin
      if (_T_143) begin
        _T_20 <= io_in_1_valid;
      end else begin
        if (_T_141) begin
          _T_20 <= io_in_2_valid;
        end else begin
          if (_T_139) begin
            _T_20 <= io_in_3_valid;
          end else begin
            if (_T_137) begin
              _T_20 <= io_in_4_valid;
            end else begin
              if (_T_135) begin
                _T_20 <= io_in_5_valid;
              end else begin
                _T_20 <= 1'h0;
              end
            end
          end
        end
      end
    end
    decomposed_output_ports_0_5_ready <= io_out_5_ready;
    if (_T_171) begin
      _T_22 <= io_in_0_bits;
    end else begin
      if (_T_169) begin
        _T_22 <= io_in_1_bits;
      end else begin
        if (_T_167) begin
          _T_22 <= io_in_2_bits;
        end else begin
          if (_T_165) begin
            _T_22 <= io_in_3_bits;
          end else begin
            if (_T_163) begin
              _T_22 <= io_in_4_bits;
            end else begin
              if (_T_161) begin
                _T_22 <= io_in_5_bits;
              end else begin
                _T_22 <= 64'h0;
              end
            end
          end
        end
      end
    end
    if (_T_171) begin
      _T_23 <= io_in_0_valid;
    end else begin
      if (_T_169) begin
        _T_23 <= io_in_1_valid;
      end else begin
        if (_T_167) begin
          _T_23 <= io_in_2_valid;
        end else begin
          if (_T_165) begin
            _T_23 <= io_in_3_valid;
          end else begin
            if (_T_163) begin
              _T_23 <= io_in_4_valid;
            end else begin
              if (_T_161) begin
                _T_23 <= io_in_5_valid;
              end else begin
                _T_23 <= 1'h0;
              end
            end
          end
        end
      end
    end
    if (io_in_4_config) begin
      decomposed_output_ports_0_7_ready <= 1'h0;
    end else begin
      decomposed_output_ports_0_7_ready <= io_out_7_ready;
    end
    if (_T_223) begin
      _T_28 <= io_in_0_bits;
    end else begin
      if (_T_221) begin
        _T_28 <= io_in_1_bits;
      end else begin
        if (_T_219) begin
          _T_28 <= io_in_2_bits;
        end else begin
          if (_T_217) begin
            _T_28 <= io_in_3_bits;
          end else begin
            if (_T_215) begin
              _T_28 <= io_in_4_bits;
            end else begin
              if (_T_213) begin
                _T_28 <= io_in_5_bits;
              end else begin
                _T_28 <= 64'h0;
              end
            end
          end
        end
      end
    end
    if (_T_223) begin
      _T_29 <= io_in_0_valid;
    end else begin
      if (_T_221) begin
        _T_29 <= io_in_1_valid;
      end else begin
        if (_T_219) begin
          _T_29 <= io_in_2_valid;
        end else begin
          if (_T_217) begin
            _T_29 <= io_in_3_valid;
          end else begin
            if (_T_215) begin
              _T_29 <= io_in_4_valid;
            end else begin
              if (_T_213) begin
                _T_29 <= io_in_5_valid;
              end else begin
                _T_29 <= 1'h0;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 24'h0;
    end else begin
      if (_T_426) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Router_Hw_12(
  input         clock,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready,
  output        io_out_4_valid,
  output [63:0] io_out_4_bits,
  input         io_out_4_ready,
  output        io_out_5_valid,
  output [63:0] io_out_5_bits,
  input         io_out_5_ready
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_6; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_7; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_9; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_10; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [63:0] _T_12; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_7;
  reg  _T_13; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_8;
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_9;
  reg [63:0] _T_15; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_10;
  reg  _T_16; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_11;
  reg  decomposed_output_ports_0_4_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_12;
  reg [63:0] _T_18; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_13;
  reg  _T_19; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_14;
  reg  decomposed_output_ports_0_5_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_15;
  reg [63:0] _T_21; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_16;
  reg  _T_22; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_17;
  wire  _T_173; // @[Router_Hw.scala 116:99]
  wire  _T_174; // @[Router_Hw.scala 116:99]
  wire  _T_175; // @[Router_Hw.scala 116:99]
  wire  _T_176; // @[Router_Hw.scala 116:99]
  assign _T_173 = decomposed_output_ports_0_0_ready & decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 116:99]
  assign _T_174 = _T_173 & decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 116:99]
  assign _T_175 = _T_174 & decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 116:99]
  assign _T_176 = _T_175 & decomposed_output_ports_0_4_ready; // @[Router_Hw.scala 116:99]
  assign io_in_0_ready = _T_176 & decomposed_output_ports_0_5_ready; // @[Router_Hw.scala 178:33]
  assign io_out_0_valid = _T_7; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_6; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = _T_10; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_9; // @[Router_Hw.scala 212:34]
  assign io_out_2_valid = _T_13; // @[Router_Hw.scala 213:35]
  assign io_out_2_bits = _T_12; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = _T_16; // @[Router_Hw.scala 213:35]
  assign io_out_3_bits = _T_15; // @[Router_Hw.scala 212:34]
  assign io_out_4_valid = _T_19; // @[Router_Hw.scala 213:35]
  assign io_out_4_bits = _T_18; // @[Router_Hw.scala 212:34]
  assign io_out_5_valid = _T_22; // @[Router_Hw.scala 198:31 Router_Hw.scala 204:37]
  assign io_out_5_bits = _T_21; // @[Router_Hw.scala 198:31 Router_Hw.scala 203:36]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_6 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_7 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_9 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_10 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_12 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_13 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {2{`RANDOM}};
  _T_15 = _RAND_10[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  _T_16 = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  decomposed_output_ports_0_4_ready = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {2{`RANDOM}};
  _T_18 = _RAND_13[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  _T_19 = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  decomposed_output_ports_0_5_ready = _RAND_15[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {2{`RANDOM}};
  _T_21 = _RAND_16[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {1{`RANDOM}};
  _T_22 = _RAND_17[0:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    _T_6 <= io_in_0_bits;
    _T_7 <= io_in_0_valid;
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    _T_9 <= io_in_0_bits;
    _T_10 <= io_in_0_valid;
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    _T_12 <= io_in_0_bits;
    _T_13 <= io_in_0_valid;
    decomposed_output_ports_0_3_ready <= io_out_3_ready;
    _T_15 <= io_in_0_bits;
    _T_16 <= io_in_0_valid;
    decomposed_output_ports_0_4_ready <= io_out_4_ready;
    _T_18 <= io_in_0_bits;
    _T_19 <= io_in_0_valid;
    decomposed_output_ports_0_5_ready <= io_out_5_ready;
    _T_21 <= io_in_0_bits;
    _T_22 <= io_in_0_valid;
  end
endmodule
module Router_Hw_13(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_2_config,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_2_config
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_4; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_5; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_7; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_8; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [63:0] _T_10; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_7;
  reg  _T_11; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_8;
  reg [5:0] config_register_file_0; // @[Router_Hw.scala 140:37]
  reg [31:0] _RAND_9;
  wire [1:0] _T_76; // @[Router_Hw.scala 113:22]
  wire  _T_77; // @[Router_Hw.scala 113:53]
  wire  _T_78; // @[Router_Hw.scala 113:10]
  wire [1:0] _T_79; // @[Router_Hw.scala 113:22]
  wire  _T_80; // @[Router_Hw.scala 113:53]
  wire  _T_81; // @[Router_Hw.scala 113:10]
  wire  _T_85; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_82; // @[Router_Hw.scala 113:22]
  wire  _T_83; // @[Router_Hw.scala 113:53]
  wire  _T_84; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_2_ready; // @[Router_Hw.scala 116:99]
  wire  _T_13; // @[Mux.scala 69:19]
  wire  _T_15; // @[Mux.scala 69:19]
  wire  _T_17; // @[Mux.scala 69:19]
  wire  _T_27; // @[Mux.scala 69:19]
  wire  _T_29; // @[Mux.scala 69:19]
  wire  _T_31; // @[Mux.scala 69:19]
  wire  _T_41; // @[Mux.scala 69:19]
  wire  _T_43; // @[Mux.scala 69:19]
  wire  _T_45; // @[Mux.scala 69:19]
  wire  _T_55; // @[Router_Hw.scala 113:53]
  wire  _T_56; // @[Router_Hw.scala 113:10]
  wire  _T_58; // @[Router_Hw.scala 113:53]
  wire  _T_59; // @[Router_Hw.scala 113:10]
  wire  _T_61; // @[Router_Hw.scala 113:53]
  wire  _T_62; // @[Router_Hw.scala 113:10]
  wire  _T_63; // @[Router_Hw.scala 116:99]
  wire  _T_66; // @[Router_Hw.scala 113:53]
  wire  _T_67; // @[Router_Hw.scala 113:10]
  wire  _T_69; // @[Router_Hw.scala 113:53]
  wire  _T_70; // @[Router_Hw.scala 113:10]
  wire  _T_72; // @[Router_Hw.scala 113:53]
  wire  _T_73; // @[Router_Hw.scala 113:10]
  wire  _T_74; // @[Router_Hw.scala 116:99]
  wire [4:0] config_module_id; // @[Router_Hw.scala 148:44]
  wire  module_id_match; // @[Router_Hw.scala 149:49]
  wire [5:0] config_data; // @[Router_Hw.scala 151:39]
  wire  _T_89; // @[Router_Hw.scala 152:22]
  assign _T_76 = config_register_file_0[1:0]; // @[Router_Hw.scala 113:22]
  assign _T_77 = _T_76 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_78 = _T_77 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_79 = config_register_file_0[3:2]; // @[Router_Hw.scala 113:22]
  assign _T_80 = _T_79 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_81 = _T_80 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_85 = _T_78 & _T_81; // @[Router_Hw.scala 116:99]
  assign _T_82 = config_register_file_0[5:4]; // @[Router_Hw.scala 113:22]
  assign _T_83 = _T_82 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_84 = _T_83 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_2_ready = _T_85 & _T_84; // @[Router_Hw.scala 116:99]
  assign _T_13 = 2'h2 == _T_76; // @[Mux.scala 69:19]
  assign _T_15 = 2'h1 == _T_76; // @[Mux.scala 69:19]
  assign _T_17 = 2'h0 == _T_76; // @[Mux.scala 69:19]
  assign _T_27 = 2'h2 == _T_79; // @[Mux.scala 69:19]
  assign _T_29 = 2'h1 == _T_79; // @[Mux.scala 69:19]
  assign _T_31 = 2'h0 == _T_79; // @[Mux.scala 69:19]
  assign _T_41 = 2'h2 == _T_82; // @[Mux.scala 69:19]
  assign _T_43 = 2'h1 == _T_82; // @[Mux.scala 69:19]
  assign _T_45 = 2'h0 == _T_82; // @[Mux.scala 69:19]
  assign _T_55 = _T_76 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_56 = _T_55 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_58 = _T_79 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_59 = _T_58 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_61 = _T_82 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_62 = _T_61 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_63 = _T_56 & _T_59; // @[Router_Hw.scala 116:99]
  assign _T_66 = _T_76 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_67 = _T_66 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_69 = _T_79 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_70 = _T_69 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_72 = _T_82 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_73 = _T_72 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_74 = _T_67 & _T_70; // @[Router_Hw.scala 116:99]
  assign config_module_id = io_in_2_bits[63:59]; // @[Router_Hw.scala 148:44]
  assign module_id_match = config_module_id == 5'h9; // @[Router_Hw.scala 149:49]
  assign config_data = io_in_2_bits[5:0]; // @[Router_Hw.scala 151:39]
  assign _T_89 = io_in_2_config & module_id_match; // @[Router_Hw.scala 152:22]
  assign io_in_0_ready = _T_63 & _T_62; // @[Router_Hw.scala 178:33]
  assign io_in_1_ready = _T_74 & _T_73; // @[Router_Hw.scala 178:33]
  assign io_in_2_ready = io_in_2_config ? io_out_2_ready : decomposed_input_ports_0_2_ready; // @[Router_Hw.scala 178:33 Router_Hw.scala 198:31]
  assign io_out_0_valid = _T_5; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_4; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = _T_8; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_7; // @[Router_Hw.scala 212:34]
  assign io_out_2_valid = io_in_2_config ? io_in_2_valid : _T_11; // @[Router_Hw.scala 198:31 Router_Hw.scala 204:37]
  assign io_out_2_bits = io_in_2_config ? io_in_2_bits : _T_10; // @[Router_Hw.scala 198:31 Router_Hw.scala 203:36]
  assign io_out_2_config = io_in_2_config; // @[Router_Hw.scala 198:31 Router_Hw.scala 205:38]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_4 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_5 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_7 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_8 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_10 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_11 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  config_register_file_0 = _RAND_9[5:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (_T_17) begin
      _T_4 <= io_in_0_bits;
    end else begin
      if (_T_15) begin
        _T_4 <= io_in_1_bits;
      end else begin
        if (_T_13) begin
          _T_4 <= io_in_2_bits;
        end else begin
          _T_4 <= 64'h0;
        end
      end
    end
    if (_T_17) begin
      _T_5 <= io_in_0_valid;
    end else begin
      if (_T_15) begin
        _T_5 <= io_in_1_valid;
      end else begin
        if (_T_13) begin
          _T_5 <= io_in_2_valid;
        end else begin
          _T_5 <= 1'h0;
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (_T_31) begin
      _T_7 <= io_in_0_bits;
    end else begin
      if (_T_29) begin
        _T_7 <= io_in_1_bits;
      end else begin
        if (_T_27) begin
          _T_7 <= io_in_2_bits;
        end else begin
          _T_7 <= 64'h0;
        end
      end
    end
    if (_T_31) begin
      _T_8 <= io_in_0_valid;
    end else begin
      if (_T_29) begin
        _T_8 <= io_in_1_valid;
      end else begin
        if (_T_27) begin
          _T_8 <= io_in_2_valid;
        end else begin
          _T_8 <= 1'h0;
        end
      end
    end
    if (io_in_2_config) begin
      decomposed_output_ports_0_2_ready <= 1'h0;
    end else begin
      decomposed_output_ports_0_2_ready <= io_out_2_ready;
    end
    if (_T_45) begin
      _T_10 <= io_in_0_bits;
    end else begin
      if (_T_43) begin
        _T_10 <= io_in_1_bits;
      end else begin
        if (_T_41) begin
          _T_10 <= io_in_2_bits;
        end else begin
          _T_10 <= 64'h0;
        end
      end
    end
    if (_T_45) begin
      _T_11 <= io_in_0_valid;
    end else begin
      if (_T_43) begin
        _T_11 <= io_in_1_valid;
      end else begin
        if (_T_41) begin
          _T_11 <= io_in_2_valid;
        end else begin
          _T_11 <= 1'h0;
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 6'h0;
    end else begin
      if (_T_89) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Router_Hw_14(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_0_config,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_2_config
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_4; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_5; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_7; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_8; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [63:0] _T_10; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_7;
  reg  _T_11; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_8;
  reg [5:0] config_register_file_0; // @[Router_Hw.scala 140:37]
  reg [31:0] _RAND_9;
  wire [1:0] _T_54; // @[Router_Hw.scala 113:22]
  wire  _T_55; // @[Router_Hw.scala 113:53]
  wire  _T_56; // @[Router_Hw.scala 113:10]
  wire [1:0] _T_57; // @[Router_Hw.scala 113:22]
  wire  _T_58; // @[Router_Hw.scala 113:53]
  wire  _T_59; // @[Router_Hw.scala 113:10]
  wire  _T_63; // @[Router_Hw.scala 116:99]
  wire [1:0] _T_60; // @[Router_Hw.scala 113:22]
  wire  _T_61; // @[Router_Hw.scala 113:53]
  wire  _T_62; // @[Router_Hw.scala 113:10]
  wire  decomposed_input_ports_0_0_ready; // @[Router_Hw.scala 116:99]
  wire  _T_13; // @[Mux.scala 69:19]
  wire  _T_15; // @[Mux.scala 69:19]
  wire  _T_17; // @[Mux.scala 69:19]
  wire  _T_27; // @[Mux.scala 69:19]
  wire  _T_29; // @[Mux.scala 69:19]
  wire  _T_31; // @[Mux.scala 69:19]
  wire  _T_41; // @[Mux.scala 69:19]
  wire  _T_43; // @[Mux.scala 69:19]
  wire  _T_45; // @[Mux.scala 69:19]
  wire  _T_66; // @[Router_Hw.scala 113:53]
  wire  _T_67; // @[Router_Hw.scala 113:10]
  wire  _T_69; // @[Router_Hw.scala 113:53]
  wire  _T_70; // @[Router_Hw.scala 113:10]
  wire  _T_72; // @[Router_Hw.scala 113:53]
  wire  _T_73; // @[Router_Hw.scala 113:10]
  wire  _T_74; // @[Router_Hw.scala 116:99]
  wire  _T_77; // @[Router_Hw.scala 113:53]
  wire  _T_78; // @[Router_Hw.scala 113:10]
  wire  _T_80; // @[Router_Hw.scala 113:53]
  wire  _T_81; // @[Router_Hw.scala 113:10]
  wire  _T_83; // @[Router_Hw.scala 113:53]
  wire  _T_84; // @[Router_Hw.scala 113:10]
  wire  _T_85; // @[Router_Hw.scala 116:99]
  wire [4:0] config_module_id; // @[Router_Hw.scala 148:44]
  wire  module_id_match; // @[Router_Hw.scala 149:49]
  wire [5:0] config_data; // @[Router_Hw.scala 151:39]
  wire  _T_89; // @[Router_Hw.scala 152:22]
  assign _T_54 = config_register_file_0[1:0]; // @[Router_Hw.scala 113:22]
  assign _T_55 = _T_54 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_56 = _T_55 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_57 = config_register_file_0[3:2]; // @[Router_Hw.scala 113:22]
  assign _T_58 = _T_57 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_59 = _T_58 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_63 = _T_56 & _T_59; // @[Router_Hw.scala 116:99]
  assign _T_60 = config_register_file_0[5:4]; // @[Router_Hw.scala 113:22]
  assign _T_61 = _T_60 == 2'h0; // @[Router_Hw.scala 113:53]
  assign _T_62 = _T_61 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign decomposed_input_ports_0_0_ready = _T_63 & _T_62; // @[Router_Hw.scala 116:99]
  assign _T_13 = 2'h2 == _T_54; // @[Mux.scala 69:19]
  assign _T_15 = 2'h1 == _T_54; // @[Mux.scala 69:19]
  assign _T_17 = 2'h0 == _T_54; // @[Mux.scala 69:19]
  assign _T_27 = 2'h2 == _T_57; // @[Mux.scala 69:19]
  assign _T_29 = 2'h1 == _T_57; // @[Mux.scala 69:19]
  assign _T_31 = 2'h0 == _T_57; // @[Mux.scala 69:19]
  assign _T_41 = 2'h2 == _T_60; // @[Mux.scala 69:19]
  assign _T_43 = 2'h1 == _T_60; // @[Mux.scala 69:19]
  assign _T_45 = 2'h0 == _T_60; // @[Mux.scala 69:19]
  assign _T_66 = _T_54 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_67 = _T_66 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_69 = _T_57 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_70 = _T_69 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_72 = _T_60 == 2'h1; // @[Router_Hw.scala 113:53]
  assign _T_73 = _T_72 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_74 = _T_67 & _T_70; // @[Router_Hw.scala 116:99]
  assign _T_77 = _T_54 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_78 = _T_77 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_80 = _T_57 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_81 = _T_80 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_83 = _T_60 == 2'h2; // @[Router_Hw.scala 113:53]
  assign _T_84 = _T_83 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_85 = _T_78 & _T_81; // @[Router_Hw.scala 116:99]
  assign config_module_id = io_in_0_bits[63:59]; // @[Router_Hw.scala 148:44]
  assign module_id_match = config_module_id == 5'hc; // @[Router_Hw.scala 149:49]
  assign config_data = io_in_0_bits[5:0]; // @[Router_Hw.scala 151:39]
  assign _T_89 = io_in_0_config & module_id_match; // @[Router_Hw.scala 152:22]
  assign io_in_0_ready = io_in_0_config ? io_out_2_ready : decomposed_input_ports_0_0_ready; // @[Router_Hw.scala 178:33 Router_Hw.scala 198:31]
  assign io_in_1_ready = _T_74 & _T_73; // @[Router_Hw.scala 178:33]
  assign io_in_2_ready = _T_85 & _T_84; // @[Router_Hw.scala 178:33]
  assign io_out_0_valid = _T_5; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_4; // @[Router_Hw.scala 212:34]
  assign io_out_1_valid = _T_8; // @[Router_Hw.scala 213:35]
  assign io_out_1_bits = _T_7; // @[Router_Hw.scala 212:34]
  assign io_out_2_valid = io_in_0_config ? io_in_0_valid : _T_11; // @[Router_Hw.scala 198:31 Router_Hw.scala 204:37]
  assign io_out_2_bits = io_in_0_config ? io_in_0_bits : _T_10; // @[Router_Hw.scala 198:31 Router_Hw.scala 203:36]
  assign io_out_2_config = io_in_0_config; // @[Router_Hw.scala 198:31 Router_Hw.scala 205:38]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_4 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_5 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_7 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_8 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_10 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_11 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  config_register_file_0 = _RAND_9[5:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (_T_17) begin
      _T_4 <= io_in_0_bits;
    end else begin
      if (_T_15) begin
        _T_4 <= io_in_1_bits;
      end else begin
        if (_T_13) begin
          _T_4 <= io_in_2_bits;
        end else begin
          _T_4 <= 64'h0;
        end
      end
    end
    if (_T_17) begin
      _T_5 <= io_in_0_valid;
    end else begin
      if (_T_15) begin
        _T_5 <= io_in_1_valid;
      end else begin
        if (_T_13) begin
          _T_5 <= io_in_2_valid;
        end else begin
          _T_5 <= 1'h0;
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (_T_31) begin
      _T_7 <= io_in_0_bits;
    end else begin
      if (_T_29) begin
        _T_7 <= io_in_1_bits;
      end else begin
        if (_T_27) begin
          _T_7 <= io_in_2_bits;
        end else begin
          _T_7 <= 64'h0;
        end
      end
    end
    if (_T_31) begin
      _T_8 <= io_in_0_valid;
    end else begin
      if (_T_29) begin
        _T_8 <= io_in_1_valid;
      end else begin
        if (_T_27) begin
          _T_8 <= io_in_2_valid;
        end else begin
          _T_8 <= 1'h0;
        end
      end
    end
    if (io_in_0_config) begin
      decomposed_output_ports_0_2_ready <= 1'h0;
    end else begin
      decomposed_output_ports_0_2_ready <= io_out_2_ready;
    end
    if (_T_45) begin
      _T_10 <= io_in_0_bits;
    end else begin
      if (_T_43) begin
        _T_10 <= io_in_1_bits;
      end else begin
        if (_T_41) begin
          _T_10 <= io_in_2_bits;
        end else begin
          _T_10 <= 64'h0;
        end
      end
    end
    if (_T_45) begin
      _T_11 <= io_in_0_valid;
    end else begin
      if (_T_43) begin
        _T_11 <= io_in_1_valid;
      end else begin
        if (_T_41) begin
          _T_11 <= io_in_2_valid;
        end else begin
          _T_11 <= 1'h0;
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 6'h0;
    end else begin
      if (_T_89) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Router_Hw_15(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  input         io_in_3_config,
  input         io_in_4_valid,
  input  [63:0] io_in_4_bits,
  output        io_in_4_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready,
  output        io_out_3_valid,
  output [63:0] io_out_3_bits,
  input         io_out_3_ready,
  output        io_out_4_valid,
  output [63:0] io_out_4_bits,
  input         io_out_4_ready,
  output        io_out_5_valid,
  output [63:0] io_out_5_bits,
  input         io_out_5_ready
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_0;
  reg [63:0] _T_6; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_1;
  reg  _T_7; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_3;
  reg [63:0] _T_12; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_4;
  reg  _T_13; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_6;
  reg [63:0] _T_15; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_7;
  reg  _T_16; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_8;
  reg  decomposed_output_ports_0_4_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_9;
  reg [63:0] _T_18; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_10;
  reg  _T_19; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_11;
  reg  decomposed_output_ports_0_5_ready; // @[Router_Hw.scala 183:29]
  reg [31:0] _RAND_12;
  reg [63:0] _T_21; // @[Router_Hw.scala 187:28]
  reg [63:0] _RAND_13;
  reg  _T_22; // @[Router_Hw.scala 189:29]
  reg [31:0] _RAND_14;
  reg [17:0] config_register_file_0; // @[Router_Hw.scala 140:37]
  reg [31:0] _RAND_15;
  wire [2:0] _T_23; // @[Router_Hw.scala 105:28]
  wire  _T_24; // @[Mux.scala 69:19]
  wire  _T_26; // @[Mux.scala 69:19]
  wire  _T_28; // @[Mux.scala 69:19]
  wire  _T_30; // @[Mux.scala 69:19]
  wire  _T_32; // @[Mux.scala 69:19]
  wire [2:0] _T_67; // @[Router_Hw.scala 105:28]
  wire  _T_68; // @[Mux.scala 69:19]
  wire  _T_70; // @[Mux.scala 69:19]
  wire  _T_72; // @[Mux.scala 69:19]
  wire  _T_74; // @[Mux.scala 69:19]
  wire  _T_76; // @[Mux.scala 69:19]
  wire [2:0] _T_89; // @[Router_Hw.scala 105:28]
  wire  _T_90; // @[Mux.scala 69:19]
  wire  _T_92; // @[Mux.scala 69:19]
  wire  _T_94; // @[Mux.scala 69:19]
  wire  _T_96; // @[Mux.scala 69:19]
  wire  _T_98; // @[Mux.scala 69:19]
  wire [2:0] _T_111; // @[Router_Hw.scala 105:28]
  wire  _T_112; // @[Mux.scala 69:19]
  wire  _T_114; // @[Mux.scala 69:19]
  wire  _T_116; // @[Mux.scala 69:19]
  wire  _T_118; // @[Mux.scala 69:19]
  wire  _T_120; // @[Mux.scala 69:19]
  wire [2:0] _T_133; // @[Router_Hw.scala 105:28]
  wire  _T_134; // @[Mux.scala 69:19]
  wire  _T_136; // @[Mux.scala 69:19]
  wire  _T_138; // @[Mux.scala 69:19]
  wire  _T_140; // @[Mux.scala 69:19]
  wire  _T_142; // @[Mux.scala 69:19]
  wire  _T_156; // @[Router_Hw.scala 113:53]
  wire  _T_157; // @[Router_Hw.scala 113:10]
  wire  _T_162; // @[Router_Hw.scala 113:53]
  wire  _T_163; // @[Router_Hw.scala 113:10]
  wire  _T_165; // @[Router_Hw.scala 113:53]
  wire  _T_166; // @[Router_Hw.scala 113:10]
  wire  _T_168; // @[Router_Hw.scala 113:53]
  wire  _T_169; // @[Router_Hw.scala 113:10]
  wire  _T_171; // @[Router_Hw.scala 113:53]
  wire  _T_172; // @[Router_Hw.scala 113:10]
  wire  _T_174; // @[Router_Hw.scala 116:99]
  wire  _T_175; // @[Router_Hw.scala 116:99]
  wire  _T_176; // @[Router_Hw.scala 116:99]
  wire  _T_179; // @[Router_Hw.scala 113:53]
  wire  _T_180; // @[Router_Hw.scala 113:10]
  wire  _T_185; // @[Router_Hw.scala 113:53]
  wire  _T_186; // @[Router_Hw.scala 113:10]
  wire  _T_188; // @[Router_Hw.scala 113:53]
  wire  _T_189; // @[Router_Hw.scala 113:10]
  wire  _T_191; // @[Router_Hw.scala 113:53]
  wire  _T_192; // @[Router_Hw.scala 113:10]
  wire  _T_194; // @[Router_Hw.scala 113:53]
  wire  _T_195; // @[Router_Hw.scala 113:10]
  wire  _T_197; // @[Router_Hw.scala 116:99]
  wire  _T_198; // @[Router_Hw.scala 116:99]
  wire  _T_199; // @[Router_Hw.scala 116:99]
  wire  _T_202; // @[Router_Hw.scala 113:53]
  wire  _T_203; // @[Router_Hw.scala 113:10]
  wire  _T_208; // @[Router_Hw.scala 113:53]
  wire  _T_209; // @[Router_Hw.scala 113:10]
  wire  _T_211; // @[Router_Hw.scala 113:53]
  wire  _T_212; // @[Router_Hw.scala 113:10]
  wire  _T_214; // @[Router_Hw.scala 113:53]
  wire  _T_215; // @[Router_Hw.scala 113:10]
  wire  _T_217; // @[Router_Hw.scala 113:53]
  wire  _T_218; // @[Router_Hw.scala 113:10]
  wire  _T_220; // @[Router_Hw.scala 116:99]
  wire  _T_221; // @[Router_Hw.scala 116:99]
  wire  _T_222; // @[Router_Hw.scala 116:99]
  wire  _T_225; // @[Router_Hw.scala 113:53]
  wire  _T_226; // @[Router_Hw.scala 113:10]
  wire  _T_231; // @[Router_Hw.scala 113:53]
  wire  _T_232; // @[Router_Hw.scala 113:10]
  wire  _T_234; // @[Router_Hw.scala 113:53]
  wire  _T_235; // @[Router_Hw.scala 113:10]
  wire  _T_237; // @[Router_Hw.scala 113:53]
  wire  _T_238; // @[Router_Hw.scala 113:10]
  wire  _T_240; // @[Router_Hw.scala 113:53]
  wire  _T_241; // @[Router_Hw.scala 113:10]
  wire  _T_243; // @[Router_Hw.scala 116:99]
  wire  _T_244; // @[Router_Hw.scala 116:99]
  wire  _T_245; // @[Router_Hw.scala 116:99]
  wire  _T_248; // @[Router_Hw.scala 113:53]
  wire  _T_249; // @[Router_Hw.scala 113:10]
  wire  _T_254; // @[Router_Hw.scala 113:53]
  wire  _T_255; // @[Router_Hw.scala 113:10]
  wire  _T_257; // @[Router_Hw.scala 113:53]
  wire  _T_258; // @[Router_Hw.scala 113:10]
  wire  _T_260; // @[Router_Hw.scala 113:53]
  wire  _T_261; // @[Router_Hw.scala 113:10]
  wire  _T_263; // @[Router_Hw.scala 113:53]
  wire  _T_264; // @[Router_Hw.scala 113:10]
  wire  _T_266; // @[Router_Hw.scala 116:99]
  wire  _T_267; // @[Router_Hw.scala 116:99]
  wire  _T_268; // @[Router_Hw.scala 116:99]
  wire [4:0] config_module_id; // @[Router_Hw.scala 148:44]
  wire  module_id_match; // @[Router_Hw.scala 149:49]
  wire [17:0] config_data; // @[Router_Hw.scala 151:39]
  wire  _T_272; // @[Router_Hw.scala 152:22]
  assign _T_23 = config_register_file_0[2:0]; // @[Router_Hw.scala 105:28]
  assign _T_24 = 3'h4 == _T_23; // @[Mux.scala 69:19]
  assign _T_26 = 3'h3 == _T_23; // @[Mux.scala 69:19]
  assign _T_28 = 3'h2 == _T_23; // @[Mux.scala 69:19]
  assign _T_30 = 3'h1 == _T_23; // @[Mux.scala 69:19]
  assign _T_32 = 3'h0 == _T_23; // @[Mux.scala 69:19]
  assign _T_67 = config_register_file_0[8:6]; // @[Router_Hw.scala 105:28]
  assign _T_68 = 3'h4 == _T_67; // @[Mux.scala 69:19]
  assign _T_70 = 3'h3 == _T_67; // @[Mux.scala 69:19]
  assign _T_72 = 3'h2 == _T_67; // @[Mux.scala 69:19]
  assign _T_74 = 3'h1 == _T_67; // @[Mux.scala 69:19]
  assign _T_76 = 3'h0 == _T_67; // @[Mux.scala 69:19]
  assign _T_89 = config_register_file_0[11:9]; // @[Router_Hw.scala 105:28]
  assign _T_90 = 3'h4 == _T_89; // @[Mux.scala 69:19]
  assign _T_92 = 3'h3 == _T_89; // @[Mux.scala 69:19]
  assign _T_94 = 3'h2 == _T_89; // @[Mux.scala 69:19]
  assign _T_96 = 3'h1 == _T_89; // @[Mux.scala 69:19]
  assign _T_98 = 3'h0 == _T_89; // @[Mux.scala 69:19]
  assign _T_111 = config_register_file_0[14:12]; // @[Router_Hw.scala 105:28]
  assign _T_112 = 3'h4 == _T_111; // @[Mux.scala 69:19]
  assign _T_114 = 3'h3 == _T_111; // @[Mux.scala 69:19]
  assign _T_116 = 3'h2 == _T_111; // @[Mux.scala 69:19]
  assign _T_118 = 3'h1 == _T_111; // @[Mux.scala 69:19]
  assign _T_120 = 3'h0 == _T_111; // @[Mux.scala 69:19]
  assign _T_133 = config_register_file_0[17:15]; // @[Router_Hw.scala 105:28]
  assign _T_134 = 3'h4 == _T_133; // @[Mux.scala 69:19]
  assign _T_136 = 3'h3 == _T_133; // @[Mux.scala 69:19]
  assign _T_138 = 3'h2 == _T_133; // @[Mux.scala 69:19]
  assign _T_140 = 3'h1 == _T_133; // @[Mux.scala 69:19]
  assign _T_142 = 3'h0 == _T_133; // @[Mux.scala 69:19]
  assign _T_156 = _T_23 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_157 = _T_156 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_162 = _T_67 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_163 = _T_162 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_165 = _T_89 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_166 = _T_165 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_168 = _T_111 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_169 = _T_168 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_171 = _T_133 == 3'h0; // @[Router_Hw.scala 113:53]
  assign _T_172 = _T_171 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_174 = _T_157 & _T_163; // @[Router_Hw.scala 116:99]
  assign _T_175 = _T_174 & _T_166; // @[Router_Hw.scala 116:99]
  assign _T_176 = _T_175 & _T_169; // @[Router_Hw.scala 116:99]
  assign _T_179 = _T_23 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_180 = _T_179 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_185 = _T_67 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_186 = _T_185 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_188 = _T_89 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_189 = _T_188 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_191 = _T_111 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_192 = _T_191 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_194 = _T_133 == 3'h1; // @[Router_Hw.scala 113:53]
  assign _T_195 = _T_194 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_197 = _T_180 & _T_186; // @[Router_Hw.scala 116:99]
  assign _T_198 = _T_197 & _T_189; // @[Router_Hw.scala 116:99]
  assign _T_199 = _T_198 & _T_192; // @[Router_Hw.scala 116:99]
  assign _T_202 = _T_23 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_203 = _T_202 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_208 = _T_67 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_209 = _T_208 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_211 = _T_89 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_212 = _T_211 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_214 = _T_111 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_215 = _T_214 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_217 = _T_133 == 3'h2; // @[Router_Hw.scala 113:53]
  assign _T_218 = _T_217 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_220 = _T_203 & _T_209; // @[Router_Hw.scala 116:99]
  assign _T_221 = _T_220 & _T_212; // @[Router_Hw.scala 116:99]
  assign _T_222 = _T_221 & _T_215; // @[Router_Hw.scala 116:99]
  assign _T_225 = _T_23 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_226 = _T_225 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_231 = _T_67 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_232 = _T_231 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_234 = _T_89 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_235 = _T_234 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_237 = _T_111 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_238 = _T_237 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_240 = _T_133 == 3'h3; // @[Router_Hw.scala 113:53]
  assign _T_241 = _T_240 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_243 = _T_226 & _T_232; // @[Router_Hw.scala 116:99]
  assign _T_244 = _T_243 & _T_235; // @[Router_Hw.scala 116:99]
  assign _T_245 = _T_244 & _T_238; // @[Router_Hw.scala 116:99]
  assign _T_248 = _T_23 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_249 = _T_248 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_254 = _T_67 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_255 = _T_254 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_257 = _T_89 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_258 = _T_257 ? decomposed_output_ports_0_3_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_260 = _T_111 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_261 = _T_260 ? decomposed_output_ports_0_4_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_263 = _T_133 == 3'h4; // @[Router_Hw.scala 113:53]
  assign _T_264 = _T_263 ? decomposed_output_ports_0_5_ready : 1'h1; // @[Router_Hw.scala 113:10]
  assign _T_266 = _T_249 & _T_255; // @[Router_Hw.scala 116:99]
  assign _T_267 = _T_266 & _T_258; // @[Router_Hw.scala 116:99]
  assign _T_268 = _T_267 & _T_261; // @[Router_Hw.scala 116:99]
  assign config_module_id = io_in_3_bits[63:59]; // @[Router_Hw.scala 148:44]
  assign module_id_match = config_module_id == 5'h17; // @[Router_Hw.scala 149:49]
  assign config_data = io_in_3_bits[17:0]; // @[Router_Hw.scala 151:39]
  assign _T_272 = io_in_3_config & module_id_match; // @[Router_Hw.scala 152:22]
  assign io_in_0_ready = _T_176 & _T_172; // @[Router_Hw.scala 178:33]
  assign io_in_1_ready = _T_199 & _T_195; // @[Router_Hw.scala 178:33]
  assign io_in_2_ready = _T_222 & _T_218; // @[Router_Hw.scala 178:33]
  assign io_in_3_ready = _T_245 & _T_241; // @[Router_Hw.scala 178:33]
  assign io_in_4_ready = _T_268 & _T_264; // @[Router_Hw.scala 178:33]
  assign io_out_0_valid = _T_7; // @[Router_Hw.scala 213:35]
  assign io_out_0_bits = _T_6; // @[Router_Hw.scala 212:34]
  assign io_out_2_valid = _T_13; // @[Router_Hw.scala 213:35]
  assign io_out_2_bits = _T_12; // @[Router_Hw.scala 212:34]
  assign io_out_3_valid = _T_16; // @[Router_Hw.scala 213:35]
  assign io_out_3_bits = _T_15; // @[Router_Hw.scala 212:34]
  assign io_out_4_valid = _T_19; // @[Router_Hw.scala 213:35]
  assign io_out_4_bits = _T_18; // @[Router_Hw.scala 212:34]
  assign io_out_5_valid = _T_22; // @[Router_Hw.scala 213:35]
  assign io_out_5_bits = _T_21; // @[Router_Hw.scala 212:34]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_6 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_7 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_12 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_13 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_15 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_16 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  decomposed_output_ports_0_4_ready = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {2{`RANDOM}};
  _T_18 = _RAND_10[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  _T_19 = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  decomposed_output_ports_0_5_ready = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {2{`RANDOM}};
  _T_21 = _RAND_13[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  _T_22 = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  config_register_file_0 = _RAND_15[17:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (_T_32) begin
      _T_6 <= io_in_0_bits;
    end else begin
      if (_T_30) begin
        _T_6 <= io_in_1_bits;
      end else begin
        if (_T_28) begin
          _T_6 <= io_in_2_bits;
        end else begin
          if (_T_26) begin
            _T_6 <= io_in_3_bits;
          end else begin
            if (_T_24) begin
              _T_6 <= io_in_4_bits;
            end else begin
              _T_6 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_32) begin
      _T_7 <= io_in_0_valid;
    end else begin
      if (_T_30) begin
        _T_7 <= io_in_1_valid;
      end else begin
        if (_T_28) begin
          _T_7 <= io_in_2_valid;
        end else begin
          if (_T_26) begin
            _T_7 <= io_in_3_valid;
          end else begin
            if (_T_24) begin
              _T_7 <= io_in_4_valid;
            end else begin
              _T_7 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    if (_T_76) begin
      _T_12 <= io_in_0_bits;
    end else begin
      if (_T_74) begin
        _T_12 <= io_in_1_bits;
      end else begin
        if (_T_72) begin
          _T_12 <= io_in_2_bits;
        end else begin
          if (_T_70) begin
            _T_12 <= io_in_3_bits;
          end else begin
            if (_T_68) begin
              _T_12 <= io_in_4_bits;
            end else begin
              _T_12 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_76) begin
      _T_13 <= io_in_0_valid;
    end else begin
      if (_T_74) begin
        _T_13 <= io_in_1_valid;
      end else begin
        if (_T_72) begin
          _T_13 <= io_in_2_valid;
        end else begin
          if (_T_70) begin
            _T_13 <= io_in_3_valid;
          end else begin
            if (_T_68) begin
              _T_13 <= io_in_4_valid;
            end else begin
              _T_13 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_3_ready <= io_out_3_ready;
    if (_T_98) begin
      _T_15 <= io_in_0_bits;
    end else begin
      if (_T_96) begin
        _T_15 <= io_in_1_bits;
      end else begin
        if (_T_94) begin
          _T_15 <= io_in_2_bits;
        end else begin
          if (_T_92) begin
            _T_15 <= io_in_3_bits;
          end else begin
            if (_T_90) begin
              _T_15 <= io_in_4_bits;
            end else begin
              _T_15 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_98) begin
      _T_16 <= io_in_0_valid;
    end else begin
      if (_T_96) begin
        _T_16 <= io_in_1_valid;
      end else begin
        if (_T_94) begin
          _T_16 <= io_in_2_valid;
        end else begin
          if (_T_92) begin
            _T_16 <= io_in_3_valid;
          end else begin
            if (_T_90) begin
              _T_16 <= io_in_4_valid;
            end else begin
              _T_16 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_4_ready <= io_out_4_ready;
    if (_T_120) begin
      _T_18 <= io_in_0_bits;
    end else begin
      if (_T_118) begin
        _T_18 <= io_in_1_bits;
      end else begin
        if (_T_116) begin
          _T_18 <= io_in_2_bits;
        end else begin
          if (_T_114) begin
            _T_18 <= io_in_3_bits;
          end else begin
            if (_T_112) begin
              _T_18 <= io_in_4_bits;
            end else begin
              _T_18 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_120) begin
      _T_19 <= io_in_0_valid;
    end else begin
      if (_T_118) begin
        _T_19 <= io_in_1_valid;
      end else begin
        if (_T_116) begin
          _T_19 <= io_in_2_valid;
        end else begin
          if (_T_114) begin
            _T_19 <= io_in_3_valid;
          end else begin
            if (_T_112) begin
              _T_19 <= io_in_4_valid;
            end else begin
              _T_19 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_5_ready <= io_out_5_ready;
    if (_T_142) begin
      _T_21 <= io_in_0_bits;
    end else begin
      if (_T_140) begin
        _T_21 <= io_in_1_bits;
      end else begin
        if (_T_138) begin
          _T_21 <= io_in_2_bits;
        end else begin
          if (_T_136) begin
            _T_21 <= io_in_3_bits;
          end else begin
            if (_T_134) begin
              _T_21 <= io_in_4_bits;
            end else begin
              _T_21 <= 64'h0;
            end
          end
        end
      end
    end
    if (_T_142) begin
      _T_22 <= io_in_0_valid;
    end else begin
      if (_T_140) begin
        _T_22 <= io_in_1_valid;
      end else begin
        if (_T_138) begin
          _T_22 <= io_in_2_valid;
        end else begin
          if (_T_136) begin
            _T_22 <= io_in_3_valid;
          end else begin
            if (_T_134) begin
              _T_22 <= io_in_4_valid;
            end else begin
              _T_22 <= 1'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 18'h0;
    end else begin
      if (_T_272) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module delay_pipe_hw(
  input  [63:0] io_in_bits,
  input         io_in_valid,
  output        io_in_ready,
  output [63:0] io_out_bits,
  output        io_out_valid,
  input         io_out_ready
);
  assign io_in_ready = io_out_ready; // @[Dedicated_PE_Hw.scala 323:12]
  assign io_out_bits = io_in_bits; // @[Dedicated_PE_Hw.scala 323:12]
  assign io_out_valid = io_in_valid; // @[Dedicated_PE_Hw.scala 323:12]
endmodule
module alu_hw(
  input  [63:0] io_in_0_bits,
  input         io_in_0_valid,
  output        io_in_0_ready,
  input  [63:0] io_in_1_bits,
  input         io_in_1_valid,
  output        io_in_1_ready,
  output [63:0] io_out_bits,
  output        io_out_valid,
  input         io_out_ready,
  input  [2:0]  io_opcode
);
  wire [63:0] alu_results_4; // @[fullinst.scala 41:49]
  wire  _T_5; // @[Dedicated_PE_Hw.scala 353:20]
  assign alu_results_4 = io_in_0_bits & io_in_1_bits; // @[fullinst.scala 41:49]
  assign _T_5 = io_opcode == 3'h4; // @[Dedicated_PE_Hw.scala 353:20]
  assign io_in_0_ready = io_out_ready; // @[Dedicated_PE_Hw.scala 374:20]
  assign io_in_1_ready = io_out_ready; // @[Dedicated_PE_Hw.scala 374:20]
  assign io_out_bits = _T_5 ? alu_results_4 : 64'h0; // @[Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19 Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19 Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19 Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19 Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19]
  assign io_out_valid = io_in_0_valid & io_in_1_valid; // @[Dedicated_PE_Hw.scala 372:16]
endmodule
module Dedicated_PE_Hw(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_0_config,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_0_config
);
  wire [63:0] all_delaypipes_hw_0_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_1_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_alus_hw_0_io_in_0_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_0_io_in_1_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [2:0] all_alus_hw_0_io_opcode; // @[Dedicated_PE_Hw.scala 117:43]
  reg [8:0] config_register_file_0; // @[Dedicated_PE_Hw.scala 192:37]
  reg [31:0] _RAND_0;
  wire [1:0] _T_46; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_47; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_48; // @[Dedicated_PE_Hw.scala 164:10]
  wire [1:0] _T_49; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_50; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_51; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_0_0_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire [63:0] decomposed_output_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  decomposed_output_ports_0_0_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  _T_8; // @[Mux.scala 69:19]
  wire [63:0] _T_9; // @[Mux.scala 69:16]
  wire  _T_10; // @[Mux.scala 69:19]
  wire [63:0] _T_11; // @[Mux.scala 69:16]
  wire  _T_12; // @[Mux.scala 69:19]
  wire [63:0] _T_13; // @[Mux.scala 69:16]
  wire  _T_14; // @[Mux.scala 69:19]
  wire  _T_18; // @[Mux.scala 69:16]
  wire  _T_20; // @[Mux.scala 69:16]
  wire  _T_22; // @[Mux.scala 69:16]
  wire  _T_27; // @[Mux.scala 69:19]
  wire [63:0] _T_28; // @[Mux.scala 69:16]
  wire  _T_29; // @[Mux.scala 69:19]
  wire [63:0] _T_30; // @[Mux.scala 69:16]
  wire  _T_31; // @[Mux.scala 69:19]
  wire [63:0] _T_32; // @[Mux.scala 69:16]
  wire  _T_33; // @[Mux.scala 69:19]
  wire  _T_37; // @[Mux.scala 69:16]
  wire  _T_39; // @[Mux.scala 69:16]
  wire  _T_41; // @[Mux.scala 69:16]
  wire  _T_54; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_55; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_57; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_58; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_61; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_62; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_64; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_65; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_68; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_69; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_71; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_72; // @[Dedicated_PE_Hw.scala 164:10]
  wire [4:0] config_module_id; // @[Dedicated_PE_Hw.scala 200:44]
  wire  module_id_match; // @[Dedicated_PE_Hw.scala 201:49]
  wire [8:0] config_data; // @[Dedicated_PE_Hw.scala 203:39]
  wire  _T_76; // @[Dedicated_PE_Hw.scala 204:22]
  delay_pipe_hw all_delaypipes_hw_0 ( // @[Dedicated_PE_Hw.scala 116:55]
    .io_in_bits(all_delaypipes_hw_0_io_in_bits),
    .io_in_valid(all_delaypipes_hw_0_io_in_valid),
    .io_in_ready(all_delaypipes_hw_0_io_in_ready),
    .io_out_bits(all_delaypipes_hw_0_io_out_bits),
    .io_out_valid(all_delaypipes_hw_0_io_out_valid),
    .io_out_ready(all_delaypipes_hw_0_io_out_ready)
  );
  delay_pipe_hw all_delaypipes_hw_1 ( // @[Dedicated_PE_Hw.scala 116:55]
    .io_in_bits(all_delaypipes_hw_1_io_in_bits),
    .io_in_valid(all_delaypipes_hw_1_io_in_valid),
    .io_in_ready(all_delaypipes_hw_1_io_in_ready),
    .io_out_bits(all_delaypipes_hw_1_io_out_bits),
    .io_out_valid(all_delaypipes_hw_1_io_out_valid),
    .io_out_ready(all_delaypipes_hw_1_io_out_ready)
  );
  alu_hw all_alus_hw_0 ( // @[Dedicated_PE_Hw.scala 117:43]
    .io_in_0_bits(all_alus_hw_0_io_in_0_bits),
    .io_in_0_valid(all_alus_hw_0_io_in_0_valid),
    .io_in_0_ready(all_alus_hw_0_io_in_0_ready),
    .io_in_1_bits(all_alus_hw_0_io_in_1_bits),
    .io_in_1_valid(all_alus_hw_0_io_in_1_valid),
    .io_in_1_ready(all_alus_hw_0_io_in_1_ready),
    .io_out_bits(all_alus_hw_0_io_out_bits),
    .io_out_valid(all_alus_hw_0_io_out_valid),
    .io_out_ready(all_alus_hw_0_io_out_ready),
    .io_opcode(all_alus_hw_0_io_opcode)
  );
  assign _T_46 = config_register_file_0[1:0]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_47 = _T_46 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_48 = _T_47 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_49 = config_register_file_0[3:2]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_50 = _T_49 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_51 = _T_50 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_0_0_ready = _T_48 & _T_51; // @[Dedicated_PE_Hw.scala 168:99]
  assign decomposed_output_ports_0_0_bits = all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign decomposed_output_ports_0_0_valid = all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign _T_8 = 2'h3 == _T_46; // @[Mux.scala 69:19]
  assign _T_9 = _T_8 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_10 = 2'h2 == _T_46; // @[Mux.scala 69:19]
  assign _T_11 = _T_10 ? io_in_2_bits : _T_9; // @[Mux.scala 69:16]
  assign _T_12 = 2'h1 == _T_46; // @[Mux.scala 69:19]
  assign _T_13 = _T_12 ? io_in_1_bits : _T_11; // @[Mux.scala 69:16]
  assign _T_14 = 2'h0 == _T_46; // @[Mux.scala 69:19]
  assign _T_18 = _T_8 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_20 = _T_10 ? io_in_2_valid : _T_18; // @[Mux.scala 69:16]
  assign _T_22 = _T_12 ? io_in_1_valid : _T_20; // @[Mux.scala 69:16]
  assign _T_27 = 2'h3 == _T_49; // @[Mux.scala 69:19]
  assign _T_28 = _T_27 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_29 = 2'h2 == _T_49; // @[Mux.scala 69:19]
  assign _T_30 = _T_29 ? io_in_2_bits : _T_28; // @[Mux.scala 69:16]
  assign _T_31 = 2'h1 == _T_49; // @[Mux.scala 69:19]
  assign _T_32 = _T_31 ? io_in_1_bits : _T_30; // @[Mux.scala 69:16]
  assign _T_33 = 2'h0 == _T_49; // @[Mux.scala 69:19]
  assign _T_37 = _T_27 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_39 = _T_29 ? io_in_2_valid : _T_37; // @[Mux.scala 69:16]
  assign _T_41 = _T_31 ? io_in_1_valid : _T_39; // @[Mux.scala 69:16]
  assign _T_54 = _T_46 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_55 = _T_54 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_57 = _T_49 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_58 = _T_57 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_61 = _T_46 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_62 = _T_61 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_64 = _T_49 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_65 = _T_64 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_68 = _T_46 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_69 = _T_68 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_71 = _T_49 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_72 = _T_71 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign config_module_id = io_in_0_bits[63:59]; // @[Dedicated_PE_Hw.scala 200:44]
  assign module_id_match = config_module_id == 5'h6; // @[Dedicated_PE_Hw.scala 201:49]
  assign config_data = io_in_0_bits[8:0]; // @[Dedicated_PE_Hw.scala 203:39]
  assign _T_76 = io_in_0_config & module_id_match; // @[Dedicated_PE_Hw.scala 204:22]
  assign io_in_0_ready = io_in_0_config ? io_out_0_ready : decomposed_input_ports_0_0_ready; // @[Dedicated_PE_Hw.scala 230:33 Dedicated_PE_Hw.scala 251:31]
  assign io_in_1_ready = _T_55 & _T_58; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_2_ready = _T_62 & _T_65; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_3_ready = _T_69 & _T_72; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_out_0_valid = io_in_0_config ? io_in_0_valid : decomposed_output_ports_0_0_valid; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 257:37]
  assign io_out_0_bits = io_in_0_config ? io_in_0_bits : decomposed_output_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 256:36]
  assign io_out_0_config = io_in_0_config; // @[Dedicated_PE_Hw.scala 247:36 Dedicated_PE_Hw.scala 251:31]
  assign all_delaypipes_hw_0_io_in_bits = _T_14 ? io_in_0_bits : _T_13; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_0_io_in_valid = _T_14 ? io_in_0_valid : _T_22; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_0_io_out_ready = all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_delaypipes_hw_1_io_in_bits = _T_33 ? io_in_0_bits : _T_32; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_1_io_in_valid = _T_33 ? io_in_0_valid : _T_41; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_1_io_out_ready = all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_0_bits = all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_0_valid = all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_bits = all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_valid = all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_out_ready = io_in_0_config ? 1'h0 : io_out_0_ready; // @[Dedicated_PE_Hw.scala 145:91]
  assign all_alus_hw_0_io_opcode = config_register_file_0[8:6]; // @[Dedicated_PE_Hw.scala 156:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  config_register_file_0 = _RAND_0[8:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (reset) begin
      config_register_file_0 <= 9'h0;
    end else begin
      if (_T_76) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module delay_pipe_hw_2(
  input         clock,
  input         reset,
  input  [31:0] io_in_bits,
  input         io_in_valid,
  output        io_in_ready,
  output [31:0] io_out_bits,
  output        io_out_valid,
  input         io_out_ready,
  input  [3:0]  io_delay
);
  reg [31:0] _T__0; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_0;
  reg [31:0] _T__1; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_1;
  reg [31:0] _T__2; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_2;
  reg [31:0] _T__3; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_3;
  reg [31:0] _T__4; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_4;
  reg [31:0] _T__5; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_5;
  reg [31:0] _T__6; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_6;
  reg [31:0] _T__7; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_7;
  reg [31:0] _T__8; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_8;
  reg [31:0] _T__9; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_9;
  reg [31:0] _T__10; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_10;
  reg [31:0] _T__11; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_11;
  reg [31:0] _T__12; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_12;
  reg [31:0] _T__13; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_13;
  reg [31:0] _T__14; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_14;
  reg [31:0] _T__15; // @[Dedicated_PE_Hw.scala 311:24]
  reg [31:0] _RAND_15;
  reg  _T_1_0; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_16;
  reg  _T_1_1; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_17;
  reg  _T_1_2; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_18;
  reg  _T_1_3; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_19;
  reg  _T_1_4; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_20;
  reg  _T_1_5; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_21;
  reg  _T_1_6; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_22;
  reg  _T_1_7; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_23;
  reg  _T_1_8; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_24;
  reg  _T_1_9; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_25;
  reg  _T_1_10; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_26;
  reg  _T_1_11; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_27;
  reg  _T_1_12; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_28;
  reg  _T_1_13; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_29;
  reg  _T_1_14; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_30;
  reg  _T_1_15; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_31;
  reg [3:0] _T_2; // @[Dedicated_PE_Hw.scala 313:23]
  reg [31:0] _RAND_32;
  reg [3:0] _T_3; // @[Dedicated_PE_Hw.scala 314:23]
  reg [31:0] _RAND_33;
  wire [31:0] _GEN_1; // @[Dedicated_PE_Hw.scala 315:17]
  wire [31:0] _GEN_2; // @[Dedicated_PE_Hw.scala 315:17]
  wire [31:0] _GEN_3; // @[Dedicated_PE_Hw.scala 315:17]
  wire [31:0] _GEN_4; // @[Dedicated_PE_Hw.scala 315:17]
  wire [31:0] _GEN_5; // @[Dedicated_PE_Hw.scala 315:17]
  wire [31:0] _GEN_6; // @[Dedicated_PE_Hw.scala 315:17]
  wire [31:0] _GEN_7; // @[Dedicated_PE_Hw.scala 315:17]
  wire [31:0] _GEN_8; // @[Dedicated_PE_Hw.scala 315:17]
  wire [31:0] _GEN_9; // @[Dedicated_PE_Hw.scala 315:17]
  wire [31:0] _GEN_10; // @[Dedicated_PE_Hw.scala 315:17]
  wire [31:0] _GEN_11; // @[Dedicated_PE_Hw.scala 315:17]
  wire [31:0] _GEN_12; // @[Dedicated_PE_Hw.scala 315:17]
  wire [31:0] _GEN_13; // @[Dedicated_PE_Hw.scala 315:17]
  wire [31:0] _GEN_14; // @[Dedicated_PE_Hw.scala 315:17]
  wire  _GEN_17; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_18; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_19; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_20; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_21; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_22; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_23; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_24; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_25; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_26; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_27; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_28; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_29; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_30; // @[Dedicated_PE_Hw.scala 316:18]
  wire [3:0] _T_5; // @[Dedicated_PE_Hw.scala 320:18]
  wire [3:0] _T_7; // @[Dedicated_PE_Hw.scala 321:18]
  assign _GEN_1 = 4'h1 == _T_2 ? _T__1 : _T__0; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_2 = 4'h2 == _T_2 ? _T__2 : _GEN_1; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_3 = 4'h3 == _T_2 ? _T__3 : _GEN_2; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_4 = 4'h4 == _T_2 ? _T__4 : _GEN_3; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_5 = 4'h5 == _T_2 ? _T__5 : _GEN_4; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_6 = 4'h6 == _T_2 ? _T__6 : _GEN_5; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_7 = 4'h7 == _T_2 ? _T__7 : _GEN_6; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_8 = 4'h8 == _T_2 ? _T__8 : _GEN_7; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_9 = 4'h9 == _T_2 ? _T__9 : _GEN_8; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_10 = 4'ha == _T_2 ? _T__10 : _GEN_9; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_11 = 4'hb == _T_2 ? _T__11 : _GEN_10; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_12 = 4'hc == _T_2 ? _T__12 : _GEN_11; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_13 = 4'hd == _T_2 ? _T__13 : _GEN_12; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_14 = 4'he == _T_2 ? _T__14 : _GEN_13; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_17 = 4'h1 == _T_2 ? _T_1_1 : _T_1_0; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_18 = 4'h2 == _T_2 ? _T_1_2 : _GEN_17; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_19 = 4'h3 == _T_2 ? _T_1_3 : _GEN_18; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_20 = 4'h4 == _T_2 ? _T_1_4 : _GEN_19; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_21 = 4'h5 == _T_2 ? _T_1_5 : _GEN_20; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_22 = 4'h6 == _T_2 ? _T_1_6 : _GEN_21; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_23 = 4'h7 == _T_2 ? _T_1_7 : _GEN_22; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_24 = 4'h8 == _T_2 ? _T_1_8 : _GEN_23; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_25 = 4'h9 == _T_2 ? _T_1_9 : _GEN_24; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_26 = 4'ha == _T_2 ? _T_1_10 : _GEN_25; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_27 = 4'hb == _T_2 ? _T_1_11 : _GEN_26; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_28 = 4'hc == _T_2 ? _T_1_12 : _GEN_27; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_29 = 4'hd == _T_2 ? _T_1_13 : _GEN_28; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_30 = 4'he == _T_2 ? _T_1_14 : _GEN_29; // @[Dedicated_PE_Hw.scala 316:18]
  assign _T_5 = _T_2 + 4'h1; // @[Dedicated_PE_Hw.scala 320:18]
  assign _T_7 = _T_2 + io_delay; // @[Dedicated_PE_Hw.scala 321:18]
  assign io_in_ready = io_out_ready; // @[Dedicated_PE_Hw.scala 319:17]
  assign io_out_bits = 4'hf == _T_2 ? _T__15 : _GEN_14; // @[Dedicated_PE_Hw.scala 315:17]
  assign io_out_valid = 4'hf == _T_2 ? _T_1_15 : _GEN_30; // @[Dedicated_PE_Hw.scala 316:18]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  _T__0 = _RAND_0[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  _T__1 = _RAND_1[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T__2 = _RAND_2[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  _T__3 = _RAND_3[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  _T__4 = _RAND_4[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T__5 = _RAND_5[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  _T__6 = _RAND_6[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  _T__7 = _RAND_7[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T__8 = _RAND_8[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  _T__9 = _RAND_9[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  _T__10 = _RAND_10[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  _T__11 = _RAND_11[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  _T__12 = _RAND_12[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {1{`RANDOM}};
  _T__13 = _RAND_13[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  _T__14 = _RAND_14[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  _T__15 = _RAND_15[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {1{`RANDOM}};
  _T_1_0 = _RAND_16[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {1{`RANDOM}};
  _T_1_1 = _RAND_17[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_18 = {1{`RANDOM}};
  _T_1_2 = _RAND_18[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_19 = {1{`RANDOM}};
  _T_1_3 = _RAND_19[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_20 = {1{`RANDOM}};
  _T_1_4 = _RAND_20[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_21 = {1{`RANDOM}};
  _T_1_5 = _RAND_21[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_22 = {1{`RANDOM}};
  _T_1_6 = _RAND_22[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_23 = {1{`RANDOM}};
  _T_1_7 = _RAND_23[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_24 = {1{`RANDOM}};
  _T_1_8 = _RAND_24[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_25 = {1{`RANDOM}};
  _T_1_9 = _RAND_25[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_26 = {1{`RANDOM}};
  _T_1_10 = _RAND_26[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_27 = {1{`RANDOM}};
  _T_1_11 = _RAND_27[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_28 = {1{`RANDOM}};
  _T_1_12 = _RAND_28[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_29 = {1{`RANDOM}};
  _T_1_13 = _RAND_29[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_30 = {1{`RANDOM}};
  _T_1_14 = _RAND_30[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_31 = {1{`RANDOM}};
  _T_1_15 = _RAND_31[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_32 = {1{`RANDOM}};
  _T_2 = _RAND_32[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_33 = {1{`RANDOM}};
  _T_3 = _RAND_33[3:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (4'h0 == _T_3) begin
      _T__0 <= io_in_bits;
    end
    if (4'h1 == _T_3) begin
      _T__1 <= io_in_bits;
    end
    if (4'h2 == _T_3) begin
      _T__2 <= io_in_bits;
    end
    if (4'h3 == _T_3) begin
      _T__3 <= io_in_bits;
    end
    if (4'h4 == _T_3) begin
      _T__4 <= io_in_bits;
    end
    if (4'h5 == _T_3) begin
      _T__5 <= io_in_bits;
    end
    if (4'h6 == _T_3) begin
      _T__6 <= io_in_bits;
    end
    if (4'h7 == _T_3) begin
      _T__7 <= io_in_bits;
    end
    if (4'h8 == _T_3) begin
      _T__8 <= io_in_bits;
    end
    if (4'h9 == _T_3) begin
      _T__9 <= io_in_bits;
    end
    if (4'ha == _T_3) begin
      _T__10 <= io_in_bits;
    end
    if (4'hb == _T_3) begin
      _T__11 <= io_in_bits;
    end
    if (4'hc == _T_3) begin
      _T__12 <= io_in_bits;
    end
    if (4'hd == _T_3) begin
      _T__13 <= io_in_bits;
    end
    if (4'he == _T_3) begin
      _T__14 <= io_in_bits;
    end
    if (4'hf == _T_3) begin
      _T__15 <= io_in_bits;
    end
    if (4'h0 == _T_3) begin
      _T_1_0 <= io_in_valid;
    end
    if (4'h1 == _T_3) begin
      _T_1_1 <= io_in_valid;
    end
    if (4'h2 == _T_3) begin
      _T_1_2 <= io_in_valid;
    end
    if (4'h3 == _T_3) begin
      _T_1_3 <= io_in_valid;
    end
    if (4'h4 == _T_3) begin
      _T_1_4 <= io_in_valid;
    end
    if (4'h5 == _T_3) begin
      _T_1_5 <= io_in_valid;
    end
    if (4'h6 == _T_3) begin
      _T_1_6 <= io_in_valid;
    end
    if (4'h7 == _T_3) begin
      _T_1_7 <= io_in_valid;
    end
    if (4'h8 == _T_3) begin
      _T_1_8 <= io_in_valid;
    end
    if (4'h9 == _T_3) begin
      _T_1_9 <= io_in_valid;
    end
    if (4'ha == _T_3) begin
      _T_1_10 <= io_in_valid;
    end
    if (4'hb == _T_3) begin
      _T_1_11 <= io_in_valid;
    end
    if (4'hc == _T_3) begin
      _T_1_12 <= io_in_valid;
    end
    if (4'hd == _T_3) begin
      _T_1_13 <= io_in_valid;
    end
    if (4'he == _T_3) begin
      _T_1_14 <= io_in_valid;
    end
    if (4'hf == _T_3) begin
      _T_1_15 <= io_in_valid;
    end
    if (reset) begin
      _T_2 <= 4'h0;
    end else begin
      _T_2 <= _T_5;
    end
    if (reset) begin
      _T_3 <= 4'h0;
    end else begin
      _T_3 <= _T_7;
    end
  end
endmodule
module alu_hw_1(
  input  [31:0] io_in_0_bits,
  input         io_in_0_valid,
  output        io_in_0_ready,
  input  [31:0] io_in_1_bits,
  input         io_in_1_valid,
  output        io_in_1_ready,
  output [31:0] io_out_bits,
  output        io_out_valid,
  input         io_out_ready,
  input  [2:0]  io_opcode
);
  wire [31:0] alu_results_4; // @[fullinst.scala 41:49]
  wire  _T_5; // @[Dedicated_PE_Hw.scala 353:20]
  assign alu_results_4 = io_in_0_bits & io_in_1_bits; // @[fullinst.scala 41:49]
  assign _T_5 = io_opcode == 3'h4; // @[Dedicated_PE_Hw.scala 353:20]
  assign io_in_0_ready = io_out_ready; // @[Dedicated_PE_Hw.scala 374:20]
  assign io_in_1_ready = io_out_ready; // @[Dedicated_PE_Hw.scala 374:20]
  assign io_out_bits = _T_5 ? alu_results_4 : 32'h0; // @[Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19 Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19 Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19 Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19 Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19]
  assign io_out_valid = io_in_0_valid & io_in_1_valid; // @[Dedicated_PE_Hw.scala 372:16]
endmodule
module Dedicated_PE_Hw_1(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_1_config,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_0_config
);
  wire  all_delaypipes_hw_0_clock; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_reset; // @[Dedicated_PE_Hw.scala 116:55]
  wire [31:0] all_delaypipes_hw_0_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [31:0] all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [3:0] all_delaypipes_hw_0_io_delay; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_clock; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_reset; // @[Dedicated_PE_Hw.scala 116:55]
  wire [31:0] all_delaypipes_hw_1_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [31:0] all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [3:0] all_delaypipes_hw_1_io_delay; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_2_clock; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_2_reset; // @[Dedicated_PE_Hw.scala 116:55]
  wire [31:0] all_delaypipes_hw_2_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_2_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_2_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [31:0] all_delaypipes_hw_2_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_2_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_2_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [3:0] all_delaypipes_hw_2_io_delay; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_3_clock; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_3_reset; // @[Dedicated_PE_Hw.scala 116:55]
  wire [31:0] all_delaypipes_hw_3_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_3_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_3_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [31:0] all_delaypipes_hw_3_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_3_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_3_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [3:0] all_delaypipes_hw_3_io_delay; // @[Dedicated_PE_Hw.scala 116:55]
  wire [31:0] all_alus_hw_0_io_in_0_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [31:0] all_alus_hw_0_io_in_1_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [31:0] all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [2:0] all_alus_hw_0_io_opcode; // @[Dedicated_PE_Hw.scala 117:43]
  wire [31:0] all_alus_hw_1_io_in_0_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_1_io_in_0_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_1_io_in_0_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [31:0] all_alus_hw_1_io_in_1_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_1_io_in_1_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_1_io_in_1_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [31:0] all_alus_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_1_io_out_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [2:0] all_alus_hw_1_io_opcode; // @[Dedicated_PE_Hw.scala 117:43]
  wire [31:0] decomposed_input_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 226:35]
  wire [31:0] decomposed_input_ports_1_0_bits; // @[Dedicated_PE_Hw.scala 226:35]
  reg [29:0] config_register_file_0; // @[Dedicated_PE_Hw.scala 192:37]
  reg [31:0] _RAND_0;
  wire [1:0] _T_95; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_96; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_97; // @[Dedicated_PE_Hw.scala 164:10]
  wire [1:0] _T_98; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_99; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_100; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_0_0_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire [1:0] _T_123; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_124; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_125; // @[Dedicated_PE_Hw.scala 164:10]
  wire [1:0] _T_126; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_127; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_128; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_1_0_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire [31:0] decomposed_input_ports_0_1_bits; // @[Dedicated_PE_Hw.scala 226:35]
  wire [31:0] decomposed_input_ports_1_1_bits; // @[Dedicated_PE_Hw.scala 226:35]
  wire  _T_103; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_104; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_106; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_107; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_0_1_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire  _T_131; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_132; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_134; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_135; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_1_1_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire  _T_5; // @[Dedicated_PE_Hw.scala 230:90]
  wire [31:0] decomposed_input_ports_0_2_bits; // @[Dedicated_PE_Hw.scala 226:35]
  wire [31:0] decomposed_input_ports_1_2_bits; // @[Dedicated_PE_Hw.scala 226:35]
  wire  _T_110; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_111; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_113; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_114; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_0_2_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire  _T_138; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_139; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_141; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_142; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_1_2_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire [31:0] decomposed_input_ports_0_3_bits; // @[Dedicated_PE_Hw.scala 226:35]
  wire [31:0] decomposed_input_ports_1_3_bits; // @[Dedicated_PE_Hw.scala 226:35]
  wire  _T_117; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_118; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_120; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_121; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_0_3_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire  _T_145; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_146; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_148; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_149; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_1_3_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire [31:0] decomposed_output_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire [31:0] decomposed_output_ports_1_0_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire [63:0] _T_14; // @[Cat.scala 30:58]
  wire  decomposed_output_ports_0_0_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  decomposed_output_ports_1_0_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  _T_16; // @[Dedicated_PE_Hw.scala 242:77]
  wire  _T_18; // @[Mux.scala 69:19]
  wire [31:0] _T_19; // @[Mux.scala 69:16]
  wire  _T_20; // @[Mux.scala 69:19]
  wire [31:0] _T_21; // @[Mux.scala 69:16]
  wire  _T_22; // @[Mux.scala 69:19]
  wire [31:0] _T_23; // @[Mux.scala 69:16]
  wire  _T_24; // @[Mux.scala 69:19]
  wire  _T_28; // @[Mux.scala 69:16]
  wire  _T_30; // @[Mux.scala 69:16]
  wire  _T_32; // @[Mux.scala 69:16]
  wire  _T_37; // @[Mux.scala 69:19]
  wire [31:0] _T_38; // @[Mux.scala 69:16]
  wire  _T_39; // @[Mux.scala 69:19]
  wire [31:0] _T_40; // @[Mux.scala 69:16]
  wire  _T_41; // @[Mux.scala 69:19]
  wire [31:0] _T_42; // @[Mux.scala 69:16]
  wire  _T_43; // @[Mux.scala 69:19]
  wire  _T_47; // @[Mux.scala 69:16]
  wire  _T_49; // @[Mux.scala 69:16]
  wire  _T_51; // @[Mux.scala 69:16]
  wire  _T_57; // @[Mux.scala 69:19]
  wire [31:0] _T_58; // @[Mux.scala 69:16]
  wire  _T_59; // @[Mux.scala 69:19]
  wire [31:0] _T_60; // @[Mux.scala 69:16]
  wire  _T_61; // @[Mux.scala 69:19]
  wire [31:0] _T_62; // @[Mux.scala 69:16]
  wire  _T_63; // @[Mux.scala 69:19]
  wire  _T_67; // @[Mux.scala 69:16]
  wire  _T_69; // @[Mux.scala 69:16]
  wire  _T_71; // @[Mux.scala 69:16]
  wire  _T_76; // @[Mux.scala 69:19]
  wire [31:0] _T_77; // @[Mux.scala 69:16]
  wire  _T_78; // @[Mux.scala 69:19]
  wire [31:0] _T_79; // @[Mux.scala 69:16]
  wire  _T_80; // @[Mux.scala 69:19]
  wire [31:0] _T_81; // @[Mux.scala 69:16]
  wire  _T_82; // @[Mux.scala 69:19]
  wire  _T_86; // @[Mux.scala 69:16]
  wire  _T_88; // @[Mux.scala 69:16]
  wire  _T_90; // @[Mux.scala 69:16]
  wire [4:0] config_module_id; // @[Dedicated_PE_Hw.scala 200:44]
  wire  module_id_match; // @[Dedicated_PE_Hw.scala 201:49]
  wire [29:0] config_data; // @[Dedicated_PE_Hw.scala 203:39]
  wire  _T_153; // @[Dedicated_PE_Hw.scala 204:22]
  delay_pipe_hw_2 all_delaypipes_hw_0 ( // @[Dedicated_PE_Hw.scala 116:55]
    .clock(all_delaypipes_hw_0_clock),
    .reset(all_delaypipes_hw_0_reset),
    .io_in_bits(all_delaypipes_hw_0_io_in_bits),
    .io_in_valid(all_delaypipes_hw_0_io_in_valid),
    .io_in_ready(all_delaypipes_hw_0_io_in_ready),
    .io_out_bits(all_delaypipes_hw_0_io_out_bits),
    .io_out_valid(all_delaypipes_hw_0_io_out_valid),
    .io_out_ready(all_delaypipes_hw_0_io_out_ready),
    .io_delay(all_delaypipes_hw_0_io_delay)
  );
  delay_pipe_hw_2 all_delaypipes_hw_1 ( // @[Dedicated_PE_Hw.scala 116:55]
    .clock(all_delaypipes_hw_1_clock),
    .reset(all_delaypipes_hw_1_reset),
    .io_in_bits(all_delaypipes_hw_1_io_in_bits),
    .io_in_valid(all_delaypipes_hw_1_io_in_valid),
    .io_in_ready(all_delaypipes_hw_1_io_in_ready),
    .io_out_bits(all_delaypipes_hw_1_io_out_bits),
    .io_out_valid(all_delaypipes_hw_1_io_out_valid),
    .io_out_ready(all_delaypipes_hw_1_io_out_ready),
    .io_delay(all_delaypipes_hw_1_io_delay)
  );
  delay_pipe_hw_2 all_delaypipes_hw_2 ( // @[Dedicated_PE_Hw.scala 116:55]
    .clock(all_delaypipes_hw_2_clock),
    .reset(all_delaypipes_hw_2_reset),
    .io_in_bits(all_delaypipes_hw_2_io_in_bits),
    .io_in_valid(all_delaypipes_hw_2_io_in_valid),
    .io_in_ready(all_delaypipes_hw_2_io_in_ready),
    .io_out_bits(all_delaypipes_hw_2_io_out_bits),
    .io_out_valid(all_delaypipes_hw_2_io_out_valid),
    .io_out_ready(all_delaypipes_hw_2_io_out_ready),
    .io_delay(all_delaypipes_hw_2_io_delay)
  );
  delay_pipe_hw_2 all_delaypipes_hw_3 ( // @[Dedicated_PE_Hw.scala 116:55]
    .clock(all_delaypipes_hw_3_clock),
    .reset(all_delaypipes_hw_3_reset),
    .io_in_bits(all_delaypipes_hw_3_io_in_bits),
    .io_in_valid(all_delaypipes_hw_3_io_in_valid),
    .io_in_ready(all_delaypipes_hw_3_io_in_ready),
    .io_out_bits(all_delaypipes_hw_3_io_out_bits),
    .io_out_valid(all_delaypipes_hw_3_io_out_valid),
    .io_out_ready(all_delaypipes_hw_3_io_out_ready),
    .io_delay(all_delaypipes_hw_3_io_delay)
  );
  alu_hw_1 all_alus_hw_0 ( // @[Dedicated_PE_Hw.scala 117:43]
    .io_in_0_bits(all_alus_hw_0_io_in_0_bits),
    .io_in_0_valid(all_alus_hw_0_io_in_0_valid),
    .io_in_0_ready(all_alus_hw_0_io_in_0_ready),
    .io_in_1_bits(all_alus_hw_0_io_in_1_bits),
    .io_in_1_valid(all_alus_hw_0_io_in_1_valid),
    .io_in_1_ready(all_alus_hw_0_io_in_1_ready),
    .io_out_bits(all_alus_hw_0_io_out_bits),
    .io_out_valid(all_alus_hw_0_io_out_valid),
    .io_out_ready(all_alus_hw_0_io_out_ready),
    .io_opcode(all_alus_hw_0_io_opcode)
  );
  alu_hw_1 all_alus_hw_1 ( // @[Dedicated_PE_Hw.scala 117:43]
    .io_in_0_bits(all_alus_hw_1_io_in_0_bits),
    .io_in_0_valid(all_alus_hw_1_io_in_0_valid),
    .io_in_0_ready(all_alus_hw_1_io_in_0_ready),
    .io_in_1_bits(all_alus_hw_1_io_in_1_bits),
    .io_in_1_valid(all_alus_hw_1_io_in_1_valid),
    .io_in_1_ready(all_alus_hw_1_io_in_1_ready),
    .io_out_bits(all_alus_hw_1_io_out_bits),
    .io_out_valid(all_alus_hw_1_io_out_valid),
    .io_out_ready(all_alus_hw_1_io_out_ready),
    .io_opcode(all_alus_hw_1_io_opcode)
  );
  assign decomposed_input_ports_0_0_bits = io_in_0_bits[31:0]; // @[Dedicated_PE_Hw.scala 226:35]
  assign decomposed_input_ports_1_0_bits = io_in_0_bits[63:32]; // @[Dedicated_PE_Hw.scala 226:35]
  assign _T_95 = config_register_file_0[1:0]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_96 = _T_95 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_97 = _T_96 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_98 = config_register_file_0[3:2]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_99 = _T_98 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_100 = _T_99 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_0_0_ready = _T_97 & _T_100; // @[Dedicated_PE_Hw.scala 168:99]
  assign _T_123 = config_register_file_0[5:4]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_124 = _T_123 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_125 = _T_124 ? all_delaypipes_hw_2_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_126 = config_register_file_0[7:6]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_127 = _T_126 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_128 = _T_127 ? all_delaypipes_hw_3_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_1_0_ready = _T_125 & _T_128; // @[Dedicated_PE_Hw.scala 168:99]
  assign decomposed_input_ports_0_1_bits = io_in_1_bits[31:0]; // @[Dedicated_PE_Hw.scala 226:35]
  assign decomposed_input_ports_1_1_bits = io_in_1_bits[63:32]; // @[Dedicated_PE_Hw.scala 226:35]
  assign _T_103 = _T_95 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_104 = _T_103 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_106 = _T_98 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_107 = _T_106 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_0_1_ready = _T_104 & _T_107; // @[Dedicated_PE_Hw.scala 168:99]
  assign _T_131 = _T_123 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_132 = _T_131 ? all_delaypipes_hw_2_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_134 = _T_126 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_135 = _T_134 ? all_delaypipes_hw_3_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_1_1_ready = _T_132 & _T_135; // @[Dedicated_PE_Hw.scala 168:99]
  assign _T_5 = decomposed_input_ports_0_1_ready & decomposed_input_ports_1_1_ready; // @[Dedicated_PE_Hw.scala 230:90]
  assign decomposed_input_ports_0_2_bits = io_in_2_bits[31:0]; // @[Dedicated_PE_Hw.scala 226:35]
  assign decomposed_input_ports_1_2_bits = io_in_2_bits[63:32]; // @[Dedicated_PE_Hw.scala 226:35]
  assign _T_110 = _T_95 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_111 = _T_110 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_113 = _T_98 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_114 = _T_113 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_0_2_ready = _T_111 & _T_114; // @[Dedicated_PE_Hw.scala 168:99]
  assign _T_138 = _T_123 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_139 = _T_138 ? all_delaypipes_hw_2_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_141 = _T_126 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_142 = _T_141 ? all_delaypipes_hw_3_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_1_2_ready = _T_139 & _T_142; // @[Dedicated_PE_Hw.scala 168:99]
  assign decomposed_input_ports_0_3_bits = io_in_3_bits[31:0]; // @[Dedicated_PE_Hw.scala 226:35]
  assign decomposed_input_ports_1_3_bits = io_in_3_bits[63:32]; // @[Dedicated_PE_Hw.scala 226:35]
  assign _T_117 = _T_95 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_118 = _T_117 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_120 = _T_98 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_121 = _T_120 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_0_3_ready = _T_118 & _T_121; // @[Dedicated_PE_Hw.scala 168:99]
  assign _T_145 = _T_123 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_146 = _T_145 ? all_delaypipes_hw_2_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_148 = _T_126 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_149 = _T_148 ? all_delaypipes_hw_3_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_1_3_ready = _T_146 & _T_149; // @[Dedicated_PE_Hw.scala 168:99]
  assign decomposed_output_ports_0_0_bits = all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign decomposed_output_ports_1_0_bits = all_alus_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign _T_14 = {decomposed_output_ports_0_0_bits,decomposed_output_ports_1_0_bits}; // @[Cat.scala 30:58]
  assign decomposed_output_ports_0_0_valid = all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign decomposed_output_ports_1_0_valid = all_alus_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign _T_16 = decomposed_output_ports_0_0_valid & decomposed_output_ports_1_0_valid; // @[Dedicated_PE_Hw.scala 242:77]
  assign _T_18 = 2'h3 == _T_95; // @[Mux.scala 69:19]
  assign _T_19 = _T_18 ? decomposed_input_ports_0_3_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_20 = 2'h2 == _T_95; // @[Mux.scala 69:19]
  assign _T_21 = _T_20 ? decomposed_input_ports_0_2_bits : _T_19; // @[Mux.scala 69:16]
  assign _T_22 = 2'h1 == _T_95; // @[Mux.scala 69:19]
  assign _T_23 = _T_22 ? decomposed_input_ports_0_1_bits : _T_21; // @[Mux.scala 69:16]
  assign _T_24 = 2'h0 == _T_95; // @[Mux.scala 69:19]
  assign _T_28 = _T_18 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_30 = _T_20 ? io_in_2_valid : _T_28; // @[Mux.scala 69:16]
  assign _T_32 = _T_22 ? io_in_1_valid : _T_30; // @[Mux.scala 69:16]
  assign _T_37 = 2'h3 == _T_98; // @[Mux.scala 69:19]
  assign _T_38 = _T_37 ? decomposed_input_ports_0_3_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_39 = 2'h2 == _T_98; // @[Mux.scala 69:19]
  assign _T_40 = _T_39 ? decomposed_input_ports_0_2_bits : _T_38; // @[Mux.scala 69:16]
  assign _T_41 = 2'h1 == _T_98; // @[Mux.scala 69:19]
  assign _T_42 = _T_41 ? decomposed_input_ports_0_1_bits : _T_40; // @[Mux.scala 69:16]
  assign _T_43 = 2'h0 == _T_98; // @[Mux.scala 69:19]
  assign _T_47 = _T_37 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_49 = _T_39 ? io_in_2_valid : _T_47; // @[Mux.scala 69:16]
  assign _T_51 = _T_41 ? io_in_1_valid : _T_49; // @[Mux.scala 69:16]
  assign _T_57 = 2'h3 == _T_123; // @[Mux.scala 69:19]
  assign _T_58 = _T_57 ? decomposed_input_ports_1_3_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_59 = 2'h2 == _T_123; // @[Mux.scala 69:19]
  assign _T_60 = _T_59 ? decomposed_input_ports_1_2_bits : _T_58; // @[Mux.scala 69:16]
  assign _T_61 = 2'h1 == _T_123; // @[Mux.scala 69:19]
  assign _T_62 = _T_61 ? decomposed_input_ports_1_1_bits : _T_60; // @[Mux.scala 69:16]
  assign _T_63 = 2'h0 == _T_123; // @[Mux.scala 69:19]
  assign _T_67 = _T_57 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_69 = _T_59 ? io_in_2_valid : _T_67; // @[Mux.scala 69:16]
  assign _T_71 = _T_61 ? io_in_1_valid : _T_69; // @[Mux.scala 69:16]
  assign _T_76 = 2'h3 == _T_126; // @[Mux.scala 69:19]
  assign _T_77 = _T_76 ? decomposed_input_ports_1_3_bits : 32'h0; // @[Mux.scala 69:16]
  assign _T_78 = 2'h2 == _T_126; // @[Mux.scala 69:19]
  assign _T_79 = _T_78 ? decomposed_input_ports_1_2_bits : _T_77; // @[Mux.scala 69:16]
  assign _T_80 = 2'h1 == _T_126; // @[Mux.scala 69:19]
  assign _T_81 = _T_80 ? decomposed_input_ports_1_1_bits : _T_79; // @[Mux.scala 69:16]
  assign _T_82 = 2'h0 == _T_126; // @[Mux.scala 69:19]
  assign _T_86 = _T_76 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_88 = _T_78 ? io_in_2_valid : _T_86; // @[Mux.scala 69:16]
  assign _T_90 = _T_80 ? io_in_1_valid : _T_88; // @[Mux.scala 69:16]
  assign config_module_id = io_in_1_bits[63:59]; // @[Dedicated_PE_Hw.scala 200:44]
  assign module_id_match = config_module_id == 5'h3; // @[Dedicated_PE_Hw.scala 201:49]
  assign config_data = io_in_1_bits[29:0]; // @[Dedicated_PE_Hw.scala 203:39]
  assign _T_153 = io_in_1_config & module_id_match; // @[Dedicated_PE_Hw.scala 204:22]
  assign io_in_0_ready = decomposed_input_ports_0_0_ready & decomposed_input_ports_1_0_ready; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_1_ready = io_in_1_config ? io_out_0_ready : _T_5; // @[Dedicated_PE_Hw.scala 230:33 Dedicated_PE_Hw.scala 251:31]
  assign io_in_2_ready = decomposed_input_ports_0_2_ready & decomposed_input_ports_1_2_ready; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_3_ready = decomposed_input_ports_0_3_ready & decomposed_input_ports_1_3_ready; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_out_0_valid = io_in_1_config ? io_in_1_valid : _T_16; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 257:37]
  assign io_out_0_bits = io_in_1_config ? io_in_1_bits : _T_14; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 256:36]
  assign io_out_0_config = io_in_1_config; // @[Dedicated_PE_Hw.scala 247:36 Dedicated_PE_Hw.scala 251:31]
  assign all_delaypipes_hw_0_clock = clock;
  assign all_delaypipes_hw_0_reset = reset;
  assign all_delaypipes_hw_0_io_in_bits = _T_24 ? decomposed_input_ports_0_0_bits : _T_23; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_0_io_in_valid = _T_24 ? io_in_0_valid : _T_32; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_0_io_out_ready = all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_delaypipes_hw_0_io_delay = config_register_file_0[11:8]; // @[Dedicated_PE_Hw.scala 142:30]
  assign all_delaypipes_hw_1_clock = clock;
  assign all_delaypipes_hw_1_reset = reset;
  assign all_delaypipes_hw_1_io_in_bits = _T_43 ? decomposed_input_ports_0_0_bits : _T_42; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_1_io_in_valid = _T_43 ? io_in_0_valid : _T_51; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_1_io_out_ready = all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_delaypipes_hw_1_io_delay = config_register_file_0[15:12]; // @[Dedicated_PE_Hw.scala 142:30]
  assign all_delaypipes_hw_2_clock = clock;
  assign all_delaypipes_hw_2_reset = reset;
  assign all_delaypipes_hw_2_io_in_bits = _T_63 ? decomposed_input_ports_1_0_bits : _T_62; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_2_io_in_valid = _T_63 ? io_in_0_valid : _T_71; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_2_io_out_ready = all_alus_hw_1_io_in_0_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_delaypipes_hw_2_io_delay = config_register_file_0[19:16]; // @[Dedicated_PE_Hw.scala 142:30]
  assign all_delaypipes_hw_3_clock = clock;
  assign all_delaypipes_hw_3_reset = reset;
  assign all_delaypipes_hw_3_io_in_bits = _T_82 ? decomposed_input_ports_1_0_bits : _T_81; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_3_io_in_valid = _T_82 ? io_in_0_valid : _T_90; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_3_io_out_ready = all_alus_hw_1_io_in_1_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_delaypipes_hw_3_io_delay = config_register_file_0[23:20]; // @[Dedicated_PE_Hw.scala 142:30]
  assign all_alus_hw_0_io_in_0_bits = all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_0_valid = all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_bits = all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_valid = all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_out_ready = io_in_1_config ? 1'h0 : io_out_0_ready; // @[Dedicated_PE_Hw.scala 145:91]
  assign all_alus_hw_0_io_opcode = config_register_file_0[26:24]; // @[Dedicated_PE_Hw.scala 156:22]
  assign all_alus_hw_1_io_in_0_bits = all_delaypipes_hw_2_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_1_io_in_0_valid = all_delaypipes_hw_2_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_1_io_in_1_bits = all_delaypipes_hw_3_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_1_io_in_1_valid = all_delaypipes_hw_3_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_1_io_out_ready = io_in_1_config ? 1'h0 : io_out_0_ready; // @[Dedicated_PE_Hw.scala 145:91]
  assign all_alus_hw_1_io_opcode = config_register_file_0[29:27]; // @[Dedicated_PE_Hw.scala 156:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  config_register_file_0 = _RAND_0[29:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (reset) begin
      config_register_file_0 <= 30'h0;
    end else begin
      if (_T_153) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module alu_hw_4(
  input  [63:0] io_in_0_bits,
  input         io_in_0_valid,
  output        io_in_0_ready,
  input  [63:0] io_in_1_bits,
  input         io_in_1_valid,
  output        io_in_1_ready,
  output [63:0] io_out_bits,
  output        io_out_valid,
  input         io_out_ready,
  input         io_opcode
);
  wire [63:0] alu_results_1; // @[fullinst.scala 36:49]
  assign alu_results_1 = io_in_0_bits + io_in_1_bits; // @[fullinst.scala 36:49]
  assign io_in_0_ready = io_out_ready; // @[Dedicated_PE_Hw.scala 374:20]
  assign io_in_1_ready = io_out_ready; // @[Dedicated_PE_Hw.scala 374:20]
  assign io_out_bits = io_opcode ? alu_results_1 : 64'h0; // @[Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19 Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19]
  assign io_out_valid = io_in_0_valid & io_in_1_valid; // @[Dedicated_PE_Hw.scala 372:16]
endmodule
module Dedicated_PE_Hw_2(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_1_config,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_0_config,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready
);
  wire [63:0] all_delaypipes_hw_0_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_1_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_2_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_2_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_2_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_2_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_2_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_2_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_3_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_3_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_3_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_3_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_3_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_3_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_alus_hw_0_io_in_0_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_0_io_in_1_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [2:0] all_alus_hw_0_io_opcode; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_1_io_in_0_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_1_io_in_0_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_1_io_in_0_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_1_io_in_1_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_1_io_in_1_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_1_io_in_1_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_1_io_out_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_1_io_opcode; // @[Dedicated_PE_Hw.scala 117:43]
  reg [15:0] config_register_file_0; // @[Dedicated_PE_Hw.scala 192:37]
  reg [31:0] _RAND_0;
  wire [1:0] _T_103; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_104; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_105; // @[Dedicated_PE_Hw.scala 164:10]
  wire [1:0] _T_106; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_107; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_108; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_115; // @[Dedicated_PE_Hw.scala 168:99]
  wire [1:0] _T_109; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_110; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_111; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_116; // @[Dedicated_PE_Hw.scala 168:99]
  wire [1:0] _T_112; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_113; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_114; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_0_1_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire [63:0] decomposed_output_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  decomposed_output_ports_0_0_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  _T_11; // @[Mux.scala 69:19]
  wire [63:0] _T_12; // @[Mux.scala 69:16]
  wire  _T_13; // @[Mux.scala 69:19]
  wire [63:0] _T_14; // @[Mux.scala 69:16]
  wire  _T_15; // @[Mux.scala 69:19]
  wire [63:0] _T_16; // @[Mux.scala 69:16]
  wire  _T_17; // @[Mux.scala 69:19]
  wire  _T_21; // @[Mux.scala 69:16]
  wire  _T_23; // @[Mux.scala 69:16]
  wire  _T_25; // @[Mux.scala 69:16]
  wire  _T_30; // @[Mux.scala 69:19]
  wire [63:0] _T_31; // @[Mux.scala 69:16]
  wire  _T_32; // @[Mux.scala 69:19]
  wire [63:0] _T_33; // @[Mux.scala 69:16]
  wire  _T_34; // @[Mux.scala 69:19]
  wire [63:0] _T_35; // @[Mux.scala 69:16]
  wire  _T_36; // @[Mux.scala 69:19]
  wire  _T_40; // @[Mux.scala 69:16]
  wire  _T_42; // @[Mux.scala 69:16]
  wire  _T_44; // @[Mux.scala 69:16]
  wire  _T_50; // @[Mux.scala 69:19]
  wire [63:0] _T_51; // @[Mux.scala 69:16]
  wire  _T_52; // @[Mux.scala 69:19]
  wire [63:0] _T_53; // @[Mux.scala 69:16]
  wire  _T_54; // @[Mux.scala 69:19]
  wire [63:0] _T_55; // @[Mux.scala 69:16]
  wire  _T_56; // @[Mux.scala 69:19]
  wire  _T_60; // @[Mux.scala 69:16]
  wire  _T_62; // @[Mux.scala 69:16]
  wire  _T_64; // @[Mux.scala 69:16]
  wire  _T_69; // @[Mux.scala 69:19]
  wire [63:0] _T_70; // @[Mux.scala 69:16]
  wire  _T_71; // @[Mux.scala 69:19]
  wire [63:0] _T_72; // @[Mux.scala 69:16]
  wire  _T_73; // @[Mux.scala 69:19]
  wire [63:0] _T_74; // @[Mux.scala 69:16]
  wire  _T_75; // @[Mux.scala 69:19]
  wire  _T_79; // @[Mux.scala 69:16]
  wire  _T_81; // @[Mux.scala 69:16]
  wire  _T_83; // @[Mux.scala 69:16]
  wire  _T_89; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_90; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_92; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_93; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_95; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_96; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_98; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_99; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_100; // @[Dedicated_PE_Hw.scala 168:99]
  wire  _T_101; // @[Dedicated_PE_Hw.scala 168:99]
  wire  _T_119; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_120; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_122; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_123; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_125; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_126; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_128; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_129; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_130; // @[Dedicated_PE_Hw.scala 168:99]
  wire  _T_131; // @[Dedicated_PE_Hw.scala 168:99]
  wire  _T_134; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_135; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_137; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_138; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_140; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_141; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_143; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_144; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_145; // @[Dedicated_PE_Hw.scala 168:99]
  wire  _T_146; // @[Dedicated_PE_Hw.scala 168:99]
  wire [4:0] config_module_id; // @[Dedicated_PE_Hw.scala 200:44]
  wire  module_id_match; // @[Dedicated_PE_Hw.scala 201:49]
  wire [15:0] config_data; // @[Dedicated_PE_Hw.scala 203:39]
  wire  _T_150; // @[Dedicated_PE_Hw.scala 204:22]
  delay_pipe_hw all_delaypipes_hw_0 ( // @[Dedicated_PE_Hw.scala 116:55]
    .io_in_bits(all_delaypipes_hw_0_io_in_bits),
    .io_in_valid(all_delaypipes_hw_0_io_in_valid),
    .io_in_ready(all_delaypipes_hw_0_io_in_ready),
    .io_out_bits(all_delaypipes_hw_0_io_out_bits),
    .io_out_valid(all_delaypipes_hw_0_io_out_valid),
    .io_out_ready(all_delaypipes_hw_0_io_out_ready)
  );
  delay_pipe_hw all_delaypipes_hw_1 ( // @[Dedicated_PE_Hw.scala 116:55]
    .io_in_bits(all_delaypipes_hw_1_io_in_bits),
    .io_in_valid(all_delaypipes_hw_1_io_in_valid),
    .io_in_ready(all_delaypipes_hw_1_io_in_ready),
    .io_out_bits(all_delaypipes_hw_1_io_out_bits),
    .io_out_valid(all_delaypipes_hw_1_io_out_valid),
    .io_out_ready(all_delaypipes_hw_1_io_out_ready)
  );
  delay_pipe_hw all_delaypipes_hw_2 ( // @[Dedicated_PE_Hw.scala 116:55]
    .io_in_bits(all_delaypipes_hw_2_io_in_bits),
    .io_in_valid(all_delaypipes_hw_2_io_in_valid),
    .io_in_ready(all_delaypipes_hw_2_io_in_ready),
    .io_out_bits(all_delaypipes_hw_2_io_out_bits),
    .io_out_valid(all_delaypipes_hw_2_io_out_valid),
    .io_out_ready(all_delaypipes_hw_2_io_out_ready)
  );
  delay_pipe_hw all_delaypipes_hw_3 ( // @[Dedicated_PE_Hw.scala 116:55]
    .io_in_bits(all_delaypipes_hw_3_io_in_bits),
    .io_in_valid(all_delaypipes_hw_3_io_in_valid),
    .io_in_ready(all_delaypipes_hw_3_io_in_ready),
    .io_out_bits(all_delaypipes_hw_3_io_out_bits),
    .io_out_valid(all_delaypipes_hw_3_io_out_valid),
    .io_out_ready(all_delaypipes_hw_3_io_out_ready)
  );
  alu_hw all_alus_hw_0 ( // @[Dedicated_PE_Hw.scala 117:43]
    .io_in_0_bits(all_alus_hw_0_io_in_0_bits),
    .io_in_0_valid(all_alus_hw_0_io_in_0_valid),
    .io_in_0_ready(all_alus_hw_0_io_in_0_ready),
    .io_in_1_bits(all_alus_hw_0_io_in_1_bits),
    .io_in_1_valid(all_alus_hw_0_io_in_1_valid),
    .io_in_1_ready(all_alus_hw_0_io_in_1_ready),
    .io_out_bits(all_alus_hw_0_io_out_bits),
    .io_out_valid(all_alus_hw_0_io_out_valid),
    .io_out_ready(all_alus_hw_0_io_out_ready),
    .io_opcode(all_alus_hw_0_io_opcode)
  );
  alu_hw_4 all_alus_hw_1 ( // @[Dedicated_PE_Hw.scala 117:43]
    .io_in_0_bits(all_alus_hw_1_io_in_0_bits),
    .io_in_0_valid(all_alus_hw_1_io_in_0_valid),
    .io_in_0_ready(all_alus_hw_1_io_in_0_ready),
    .io_in_1_bits(all_alus_hw_1_io_in_1_bits),
    .io_in_1_valid(all_alus_hw_1_io_in_1_valid),
    .io_in_1_ready(all_alus_hw_1_io_in_1_ready),
    .io_out_bits(all_alus_hw_1_io_out_bits),
    .io_out_valid(all_alus_hw_1_io_out_valid),
    .io_out_ready(all_alus_hw_1_io_out_ready),
    .io_opcode(all_alus_hw_1_io_opcode)
  );
  assign _T_103 = config_register_file_0[1:0]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_104 = _T_103 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_105 = _T_104 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_106 = config_register_file_0[3:2]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_107 = _T_106 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_108 = _T_107 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_115 = _T_105 & _T_108; // @[Dedicated_PE_Hw.scala 168:99]
  assign _T_109 = config_register_file_0[5:4]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_110 = _T_109 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_111 = _T_110 ? all_delaypipes_hw_2_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_116 = _T_115 & _T_111; // @[Dedicated_PE_Hw.scala 168:99]
  assign _T_112 = config_register_file_0[7:6]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_113 = _T_112 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_114 = _T_113 ? all_delaypipes_hw_3_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_0_1_ready = _T_116 & _T_114; // @[Dedicated_PE_Hw.scala 168:99]
  assign decomposed_output_ports_0_0_bits = all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign decomposed_output_ports_0_0_valid = all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign _T_11 = 2'h3 == _T_103; // @[Mux.scala 69:19]
  assign _T_12 = _T_11 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_13 = 2'h2 == _T_103; // @[Mux.scala 69:19]
  assign _T_14 = _T_13 ? io_in_2_bits : _T_12; // @[Mux.scala 69:16]
  assign _T_15 = 2'h1 == _T_103; // @[Mux.scala 69:19]
  assign _T_16 = _T_15 ? io_in_1_bits : _T_14; // @[Mux.scala 69:16]
  assign _T_17 = 2'h0 == _T_103; // @[Mux.scala 69:19]
  assign _T_21 = _T_11 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_23 = _T_13 ? io_in_2_valid : _T_21; // @[Mux.scala 69:16]
  assign _T_25 = _T_15 ? io_in_1_valid : _T_23; // @[Mux.scala 69:16]
  assign _T_30 = 2'h3 == _T_106; // @[Mux.scala 69:19]
  assign _T_31 = _T_30 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_32 = 2'h2 == _T_106; // @[Mux.scala 69:19]
  assign _T_33 = _T_32 ? io_in_2_bits : _T_31; // @[Mux.scala 69:16]
  assign _T_34 = 2'h1 == _T_106; // @[Mux.scala 69:19]
  assign _T_35 = _T_34 ? io_in_1_bits : _T_33; // @[Mux.scala 69:16]
  assign _T_36 = 2'h0 == _T_106; // @[Mux.scala 69:19]
  assign _T_40 = _T_30 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_42 = _T_32 ? io_in_2_valid : _T_40; // @[Mux.scala 69:16]
  assign _T_44 = _T_34 ? io_in_1_valid : _T_42; // @[Mux.scala 69:16]
  assign _T_50 = 2'h3 == _T_109; // @[Mux.scala 69:19]
  assign _T_51 = _T_50 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_52 = 2'h2 == _T_109; // @[Mux.scala 69:19]
  assign _T_53 = _T_52 ? io_in_2_bits : _T_51; // @[Mux.scala 69:16]
  assign _T_54 = 2'h1 == _T_109; // @[Mux.scala 69:19]
  assign _T_55 = _T_54 ? io_in_1_bits : _T_53; // @[Mux.scala 69:16]
  assign _T_56 = 2'h0 == _T_109; // @[Mux.scala 69:19]
  assign _T_60 = _T_50 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_62 = _T_52 ? io_in_2_valid : _T_60; // @[Mux.scala 69:16]
  assign _T_64 = _T_54 ? io_in_1_valid : _T_62; // @[Mux.scala 69:16]
  assign _T_69 = 2'h3 == _T_112; // @[Mux.scala 69:19]
  assign _T_70 = _T_69 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_71 = 2'h2 == _T_112; // @[Mux.scala 69:19]
  assign _T_72 = _T_71 ? io_in_2_bits : _T_70; // @[Mux.scala 69:16]
  assign _T_73 = 2'h1 == _T_112; // @[Mux.scala 69:19]
  assign _T_74 = _T_73 ? io_in_1_bits : _T_72; // @[Mux.scala 69:16]
  assign _T_75 = 2'h0 == _T_112; // @[Mux.scala 69:19]
  assign _T_79 = _T_69 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_81 = _T_71 ? io_in_2_valid : _T_79; // @[Mux.scala 69:16]
  assign _T_83 = _T_73 ? io_in_1_valid : _T_81; // @[Mux.scala 69:16]
  assign _T_89 = _T_103 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_90 = _T_89 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_92 = _T_106 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_93 = _T_92 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_95 = _T_109 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_96 = _T_95 ? all_delaypipes_hw_2_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_98 = _T_112 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_99 = _T_98 ? all_delaypipes_hw_3_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_100 = _T_90 & _T_93; // @[Dedicated_PE_Hw.scala 168:99]
  assign _T_101 = _T_100 & _T_96; // @[Dedicated_PE_Hw.scala 168:99]
  assign _T_119 = _T_103 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_120 = _T_119 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_122 = _T_106 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_123 = _T_122 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_125 = _T_109 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_126 = _T_125 ? all_delaypipes_hw_2_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_128 = _T_112 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_129 = _T_128 ? all_delaypipes_hw_3_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_130 = _T_120 & _T_123; // @[Dedicated_PE_Hw.scala 168:99]
  assign _T_131 = _T_130 & _T_126; // @[Dedicated_PE_Hw.scala 168:99]
  assign _T_134 = _T_103 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_135 = _T_134 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_137 = _T_106 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_138 = _T_137 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_140 = _T_109 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_141 = _T_140 ? all_delaypipes_hw_2_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_143 = _T_112 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_144 = _T_143 ? all_delaypipes_hw_3_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_145 = _T_135 & _T_138; // @[Dedicated_PE_Hw.scala 168:99]
  assign _T_146 = _T_145 & _T_141; // @[Dedicated_PE_Hw.scala 168:99]
  assign config_module_id = io_in_1_bits[63:59]; // @[Dedicated_PE_Hw.scala 200:44]
  assign module_id_match = config_module_id == 5'h2; // @[Dedicated_PE_Hw.scala 201:49]
  assign config_data = io_in_1_bits[15:0]; // @[Dedicated_PE_Hw.scala 203:39]
  assign _T_150 = io_in_1_config & module_id_match; // @[Dedicated_PE_Hw.scala 204:22]
  assign io_in_0_ready = _T_101 & _T_99; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_1_ready = io_in_1_config ? io_out_0_ready : decomposed_input_ports_0_1_ready; // @[Dedicated_PE_Hw.scala 230:33 Dedicated_PE_Hw.scala 251:31]
  assign io_in_2_ready = _T_131 & _T_129; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_3_ready = _T_146 & _T_144; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_out_0_valid = io_in_1_config ? io_in_1_valid : decomposed_output_ports_0_0_valid; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 257:37]
  assign io_out_0_bits = io_in_1_config ? io_in_1_bits : decomposed_output_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 256:36]
  assign io_out_0_config = io_in_1_config; // @[Dedicated_PE_Hw.scala 247:36 Dedicated_PE_Hw.scala 251:31]
  assign io_out_1_valid = all_alus_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 265:35]
  assign io_out_1_bits = all_alus_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 264:34]
  assign all_delaypipes_hw_0_io_in_bits = _T_17 ? io_in_0_bits : _T_16; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_0_io_in_valid = _T_17 ? io_in_0_valid : _T_25; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_0_io_out_ready = all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_delaypipes_hw_1_io_in_bits = _T_36 ? io_in_0_bits : _T_35; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_1_io_in_valid = _T_36 ? io_in_0_valid : _T_44; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_1_io_out_ready = all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_delaypipes_hw_2_io_in_bits = _T_56 ? io_in_0_bits : _T_55; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_2_io_in_valid = _T_56 ? io_in_0_valid : _T_64; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_2_io_out_ready = all_alus_hw_1_io_in_0_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_delaypipes_hw_3_io_in_bits = _T_75 ? io_in_0_bits : _T_74; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_3_io_in_valid = _T_75 ? io_in_0_valid : _T_83; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_3_io_out_ready = all_alus_hw_1_io_in_1_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_0_bits = all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_0_valid = all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_bits = all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_valid = all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_out_ready = io_in_1_config ? 1'h0 : io_out_0_ready; // @[Dedicated_PE_Hw.scala 145:91]
  assign all_alus_hw_0_io_opcode = config_register_file_0[14:12]; // @[Dedicated_PE_Hw.scala 156:22]
  assign all_alus_hw_1_io_in_0_bits = all_delaypipes_hw_2_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_1_io_in_0_valid = all_delaypipes_hw_2_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_1_io_in_1_bits = all_delaypipes_hw_3_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_1_io_in_1_valid = all_delaypipes_hw_3_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_1_io_out_ready = io_out_1_ready; // @[Dedicated_PE_Hw.scala 145:91]
  assign all_alus_hw_1_io_opcode = config_register_file_0[15]; // @[Dedicated_PE_Hw.scala 156:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  config_register_file_0 = _RAND_0[15:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (reset) begin
      config_register_file_0 <= 16'h0;
    end else begin
      if (_T_150) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module alu_hw_5(
  input  [63:0] io_in_0_bits,
  input         io_in_0_valid,
  output        io_in_0_ready,
  input  [63:0] io_in_1_bits,
  input         io_in_1_valid,
  output        io_in_1_ready,
  output [63:0] io_out_bits,
  output        io_out_valid,
  input         io_out_ready,
  input  [1:0]  io_opcode
);
  wire  alu_results_3; // @[fullinst.scala 58:48]
  wire  _T_3; // @[Dedicated_PE_Hw.scala 353:20]
  wire  _GEN_3; // @[Dedicated_PE_Hw.scala 353:37]
  assign alu_results_3 = io_in_0_bits <= io_in_1_bits; // @[fullinst.scala 58:48]
  assign _T_3 = io_opcode == 2'h3; // @[Dedicated_PE_Hw.scala 353:20]
  assign _GEN_3 = _T_3 ? alu_results_3 : 1'h0; // @[Dedicated_PE_Hw.scala 353:37]
  assign io_in_0_ready = io_out_ready; // @[Dedicated_PE_Hw.scala 374:20]
  assign io_in_1_ready = io_out_ready; // @[Dedicated_PE_Hw.scala 374:20]
  assign io_out_bits = {{63'd0}, _GEN_3}; // @[Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19 Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19 Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19 Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19]
  assign io_out_valid = io_in_0_valid & io_in_1_valid; // @[Dedicated_PE_Hw.scala 372:16]
endmodule
module Dedicated_PE_Hw_3(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_1_config,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_0_config
);
  wire [63:0] all_delaypipes_hw_0_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_1_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_alus_hw_0_io_in_0_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_0_io_in_1_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [1:0] all_alus_hw_0_io_opcode; // @[Dedicated_PE_Hw.scala 117:43]
  reg [7:0] config_register_file_0; // @[Dedicated_PE_Hw.scala 192:37]
  reg [31:0] _RAND_0;
  wire [1:0] _T_53; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_54; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_55; // @[Dedicated_PE_Hw.scala 164:10]
  wire [1:0] _T_56; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_57; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_58; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_0_1_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire [63:0] decomposed_output_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  decomposed_output_ports_0_0_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  _T_8; // @[Mux.scala 69:19]
  wire [63:0] _T_9; // @[Mux.scala 69:16]
  wire  _T_10; // @[Mux.scala 69:19]
  wire [63:0] _T_11; // @[Mux.scala 69:16]
  wire  _T_12; // @[Mux.scala 69:19]
  wire [63:0] _T_13; // @[Mux.scala 69:16]
  wire  _T_14; // @[Mux.scala 69:19]
  wire  _T_18; // @[Mux.scala 69:16]
  wire  _T_20; // @[Mux.scala 69:16]
  wire  _T_22; // @[Mux.scala 69:16]
  wire  _T_27; // @[Mux.scala 69:19]
  wire [63:0] _T_28; // @[Mux.scala 69:16]
  wire  _T_29; // @[Mux.scala 69:19]
  wire [63:0] _T_30; // @[Mux.scala 69:16]
  wire  _T_31; // @[Mux.scala 69:19]
  wire [63:0] _T_32; // @[Mux.scala 69:16]
  wire  _T_33; // @[Mux.scala 69:19]
  wire  _T_37; // @[Mux.scala 69:16]
  wire  _T_39; // @[Mux.scala 69:16]
  wire  _T_41; // @[Mux.scala 69:16]
  wire  _T_47; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_48; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_50; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_51; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_61; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_62; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_64; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_65; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_68; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_69; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_71; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_72; // @[Dedicated_PE_Hw.scala 164:10]
  wire [4:0] config_module_id; // @[Dedicated_PE_Hw.scala 200:44]
  wire  module_id_match; // @[Dedicated_PE_Hw.scala 201:49]
  wire [7:0] config_data; // @[Dedicated_PE_Hw.scala 203:39]
  wire  _T_76; // @[Dedicated_PE_Hw.scala 204:22]
  delay_pipe_hw all_delaypipes_hw_0 ( // @[Dedicated_PE_Hw.scala 116:55]
    .io_in_bits(all_delaypipes_hw_0_io_in_bits),
    .io_in_valid(all_delaypipes_hw_0_io_in_valid),
    .io_in_ready(all_delaypipes_hw_0_io_in_ready),
    .io_out_bits(all_delaypipes_hw_0_io_out_bits),
    .io_out_valid(all_delaypipes_hw_0_io_out_valid),
    .io_out_ready(all_delaypipes_hw_0_io_out_ready)
  );
  delay_pipe_hw all_delaypipes_hw_1 ( // @[Dedicated_PE_Hw.scala 116:55]
    .io_in_bits(all_delaypipes_hw_1_io_in_bits),
    .io_in_valid(all_delaypipes_hw_1_io_in_valid),
    .io_in_ready(all_delaypipes_hw_1_io_in_ready),
    .io_out_bits(all_delaypipes_hw_1_io_out_bits),
    .io_out_valid(all_delaypipes_hw_1_io_out_valid),
    .io_out_ready(all_delaypipes_hw_1_io_out_ready)
  );
  alu_hw_5 all_alus_hw_0 ( // @[Dedicated_PE_Hw.scala 117:43]
    .io_in_0_bits(all_alus_hw_0_io_in_0_bits),
    .io_in_0_valid(all_alus_hw_0_io_in_0_valid),
    .io_in_0_ready(all_alus_hw_0_io_in_0_ready),
    .io_in_1_bits(all_alus_hw_0_io_in_1_bits),
    .io_in_1_valid(all_alus_hw_0_io_in_1_valid),
    .io_in_1_ready(all_alus_hw_0_io_in_1_ready),
    .io_out_bits(all_alus_hw_0_io_out_bits),
    .io_out_valid(all_alus_hw_0_io_out_valid),
    .io_out_ready(all_alus_hw_0_io_out_ready),
    .io_opcode(all_alus_hw_0_io_opcode)
  );
  assign _T_53 = config_register_file_0[1:0]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_54 = _T_53 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_55 = _T_54 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_56 = config_register_file_0[3:2]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_57 = _T_56 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_58 = _T_57 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_0_1_ready = _T_55 & _T_58; // @[Dedicated_PE_Hw.scala 168:99]
  assign decomposed_output_ports_0_0_bits = all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign decomposed_output_ports_0_0_valid = all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign _T_8 = 2'h3 == _T_53; // @[Mux.scala 69:19]
  assign _T_9 = _T_8 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_10 = 2'h2 == _T_53; // @[Mux.scala 69:19]
  assign _T_11 = _T_10 ? io_in_2_bits : _T_9; // @[Mux.scala 69:16]
  assign _T_12 = 2'h1 == _T_53; // @[Mux.scala 69:19]
  assign _T_13 = _T_12 ? io_in_1_bits : _T_11; // @[Mux.scala 69:16]
  assign _T_14 = 2'h0 == _T_53; // @[Mux.scala 69:19]
  assign _T_18 = _T_8 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_20 = _T_10 ? io_in_2_valid : _T_18; // @[Mux.scala 69:16]
  assign _T_22 = _T_12 ? io_in_1_valid : _T_20; // @[Mux.scala 69:16]
  assign _T_27 = 2'h3 == _T_56; // @[Mux.scala 69:19]
  assign _T_28 = _T_27 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_29 = 2'h2 == _T_56; // @[Mux.scala 69:19]
  assign _T_30 = _T_29 ? io_in_2_bits : _T_28; // @[Mux.scala 69:16]
  assign _T_31 = 2'h1 == _T_56; // @[Mux.scala 69:19]
  assign _T_32 = _T_31 ? io_in_1_bits : _T_30; // @[Mux.scala 69:16]
  assign _T_33 = 2'h0 == _T_56; // @[Mux.scala 69:19]
  assign _T_37 = _T_27 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_39 = _T_29 ? io_in_2_valid : _T_37; // @[Mux.scala 69:16]
  assign _T_41 = _T_31 ? io_in_1_valid : _T_39; // @[Mux.scala 69:16]
  assign _T_47 = _T_53 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_48 = _T_47 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_50 = _T_56 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_51 = _T_50 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_61 = _T_53 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_62 = _T_61 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_64 = _T_56 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_65 = _T_64 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_68 = _T_53 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_69 = _T_68 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_71 = _T_56 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_72 = _T_71 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign config_module_id = io_in_1_bits[63:59]; // @[Dedicated_PE_Hw.scala 200:44]
  assign module_id_match = config_module_id == 5'h5; // @[Dedicated_PE_Hw.scala 201:49]
  assign config_data = io_in_1_bits[7:0]; // @[Dedicated_PE_Hw.scala 203:39]
  assign _T_76 = io_in_1_config & module_id_match; // @[Dedicated_PE_Hw.scala 204:22]
  assign io_in_0_ready = _T_48 & _T_51; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_1_ready = io_in_1_config ? io_out_0_ready : decomposed_input_ports_0_1_ready; // @[Dedicated_PE_Hw.scala 230:33 Dedicated_PE_Hw.scala 251:31]
  assign io_in_2_ready = _T_62 & _T_65; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_3_ready = _T_69 & _T_72; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_out_0_valid = io_in_1_config ? io_in_1_valid : decomposed_output_ports_0_0_valid; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 257:37]
  assign io_out_0_bits = io_in_1_config ? io_in_1_bits : decomposed_output_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 256:36]
  assign io_out_0_config = io_in_1_config; // @[Dedicated_PE_Hw.scala 247:36 Dedicated_PE_Hw.scala 251:31]
  assign all_delaypipes_hw_0_io_in_bits = _T_14 ? io_in_0_bits : _T_13; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_0_io_in_valid = _T_14 ? io_in_0_valid : _T_22; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_0_io_out_ready = all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_delaypipes_hw_1_io_in_bits = _T_33 ? io_in_0_bits : _T_32; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_1_io_in_valid = _T_33 ? io_in_0_valid : _T_41; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_1_io_out_ready = all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_0_bits = all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_0_valid = all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_bits = all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_valid = all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_out_ready = io_in_1_config ? 1'h0 : io_out_0_ready; // @[Dedicated_PE_Hw.scala 145:91]
  assign all_alus_hw_0_io_opcode = config_register_file_0[7:6]; // @[Dedicated_PE_Hw.scala 156:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  config_register_file_0 = _RAND_0[7:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (reset) begin
      config_register_file_0 <= 8'h0;
    end else begin
      if (_T_76) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module alu_hw_6(
  input  [63:0] io_in_0_bits,
  input         io_in_0_valid,
  output        io_in_0_ready,
  input  [63:0] io_in_1_bits,
  input         io_in_1_valid,
  output        io_in_1_ready,
  output [63:0] io_out_bits,
  output        io_out_valid,
  input         io_out_ready,
  input         io_opcode
);
  wire [63:0] alu_results_1; // @[fullinst.scala 39:49]
  assign alu_results_1 = io_in_0_bits / io_in_1_bits; // @[fullinst.scala 39:49]
  assign io_in_0_ready = io_out_ready; // @[Dedicated_PE_Hw.scala 374:20]
  assign io_in_1_ready = io_out_ready; // @[Dedicated_PE_Hw.scala 374:20]
  assign io_out_bits = io_opcode ? alu_results_1 : 64'h0; // @[Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19 Dedicated_PE_Hw.scala 354:19 Dedicated_PE_Hw.scala 356:19]
  assign io_out_valid = io_in_0_valid & io_in_1_valid; // @[Dedicated_PE_Hw.scala 372:16]
endmodule
module Dedicated_PE_Hw_4(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_1_config,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_0_config
);
  wire [63:0] all_delaypipes_hw_0_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_1_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_alus_hw_0_io_in_0_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_0_io_in_1_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_opcode; // @[Dedicated_PE_Hw.scala 117:43]
  reg [6:0] config_register_file_0; // @[Dedicated_PE_Hw.scala 192:37]
  reg [31:0] _RAND_0;
  wire [1:0] _T_53; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_54; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_55; // @[Dedicated_PE_Hw.scala 164:10]
  wire [1:0] _T_56; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_57; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_58; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_0_1_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire [63:0] decomposed_output_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  decomposed_output_ports_0_0_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  _T_8; // @[Mux.scala 69:19]
  wire [63:0] _T_9; // @[Mux.scala 69:16]
  wire  _T_10; // @[Mux.scala 69:19]
  wire [63:0] _T_11; // @[Mux.scala 69:16]
  wire  _T_12; // @[Mux.scala 69:19]
  wire [63:0] _T_13; // @[Mux.scala 69:16]
  wire  _T_14; // @[Mux.scala 69:19]
  wire  _T_18; // @[Mux.scala 69:16]
  wire  _T_20; // @[Mux.scala 69:16]
  wire  _T_22; // @[Mux.scala 69:16]
  wire  _T_27; // @[Mux.scala 69:19]
  wire [63:0] _T_28; // @[Mux.scala 69:16]
  wire  _T_29; // @[Mux.scala 69:19]
  wire [63:0] _T_30; // @[Mux.scala 69:16]
  wire  _T_31; // @[Mux.scala 69:19]
  wire [63:0] _T_32; // @[Mux.scala 69:16]
  wire  _T_33; // @[Mux.scala 69:19]
  wire  _T_37; // @[Mux.scala 69:16]
  wire  _T_39; // @[Mux.scala 69:16]
  wire  _T_41; // @[Mux.scala 69:16]
  wire  _T_47; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_48; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_50; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_51; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_61; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_62; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_64; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_65; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_68; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_69; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_71; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_72; // @[Dedicated_PE_Hw.scala 164:10]
  wire [4:0] config_module_id; // @[Dedicated_PE_Hw.scala 200:44]
  wire  module_id_match; // @[Dedicated_PE_Hw.scala 201:49]
  wire [6:0] config_data; // @[Dedicated_PE_Hw.scala 203:39]
  wire  _T_76; // @[Dedicated_PE_Hw.scala 204:22]
  delay_pipe_hw all_delaypipes_hw_0 ( // @[Dedicated_PE_Hw.scala 116:55]
    .io_in_bits(all_delaypipes_hw_0_io_in_bits),
    .io_in_valid(all_delaypipes_hw_0_io_in_valid),
    .io_in_ready(all_delaypipes_hw_0_io_in_ready),
    .io_out_bits(all_delaypipes_hw_0_io_out_bits),
    .io_out_valid(all_delaypipes_hw_0_io_out_valid),
    .io_out_ready(all_delaypipes_hw_0_io_out_ready)
  );
  delay_pipe_hw all_delaypipes_hw_1 ( // @[Dedicated_PE_Hw.scala 116:55]
    .io_in_bits(all_delaypipes_hw_1_io_in_bits),
    .io_in_valid(all_delaypipes_hw_1_io_in_valid),
    .io_in_ready(all_delaypipes_hw_1_io_in_ready),
    .io_out_bits(all_delaypipes_hw_1_io_out_bits),
    .io_out_valid(all_delaypipes_hw_1_io_out_valid),
    .io_out_ready(all_delaypipes_hw_1_io_out_ready)
  );
  alu_hw_6 all_alus_hw_0 ( // @[Dedicated_PE_Hw.scala 117:43]
    .io_in_0_bits(all_alus_hw_0_io_in_0_bits),
    .io_in_0_valid(all_alus_hw_0_io_in_0_valid),
    .io_in_0_ready(all_alus_hw_0_io_in_0_ready),
    .io_in_1_bits(all_alus_hw_0_io_in_1_bits),
    .io_in_1_valid(all_alus_hw_0_io_in_1_valid),
    .io_in_1_ready(all_alus_hw_0_io_in_1_ready),
    .io_out_bits(all_alus_hw_0_io_out_bits),
    .io_out_valid(all_alus_hw_0_io_out_valid),
    .io_out_ready(all_alus_hw_0_io_out_ready),
    .io_opcode(all_alus_hw_0_io_opcode)
  );
  assign _T_53 = config_register_file_0[1:0]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_54 = _T_53 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_55 = _T_54 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_56 = config_register_file_0[3:2]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_57 = _T_56 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_58 = _T_57 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_0_1_ready = _T_55 & _T_58; // @[Dedicated_PE_Hw.scala 168:99]
  assign decomposed_output_ports_0_0_bits = all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign decomposed_output_ports_0_0_valid = all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign _T_8 = 2'h3 == _T_53; // @[Mux.scala 69:19]
  assign _T_9 = _T_8 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_10 = 2'h2 == _T_53; // @[Mux.scala 69:19]
  assign _T_11 = _T_10 ? io_in_2_bits : _T_9; // @[Mux.scala 69:16]
  assign _T_12 = 2'h1 == _T_53; // @[Mux.scala 69:19]
  assign _T_13 = _T_12 ? io_in_1_bits : _T_11; // @[Mux.scala 69:16]
  assign _T_14 = 2'h0 == _T_53; // @[Mux.scala 69:19]
  assign _T_18 = _T_8 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_20 = _T_10 ? io_in_2_valid : _T_18; // @[Mux.scala 69:16]
  assign _T_22 = _T_12 ? io_in_1_valid : _T_20; // @[Mux.scala 69:16]
  assign _T_27 = 2'h3 == _T_56; // @[Mux.scala 69:19]
  assign _T_28 = _T_27 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_29 = 2'h2 == _T_56; // @[Mux.scala 69:19]
  assign _T_30 = _T_29 ? io_in_2_bits : _T_28; // @[Mux.scala 69:16]
  assign _T_31 = 2'h1 == _T_56; // @[Mux.scala 69:19]
  assign _T_32 = _T_31 ? io_in_1_bits : _T_30; // @[Mux.scala 69:16]
  assign _T_33 = 2'h0 == _T_56; // @[Mux.scala 69:19]
  assign _T_37 = _T_27 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_39 = _T_29 ? io_in_2_valid : _T_37; // @[Mux.scala 69:16]
  assign _T_41 = _T_31 ? io_in_1_valid : _T_39; // @[Mux.scala 69:16]
  assign _T_47 = _T_53 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_48 = _T_47 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_50 = _T_56 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_51 = _T_50 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_61 = _T_53 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_62 = _T_61 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_64 = _T_56 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_65 = _T_64 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_68 = _T_53 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_69 = _T_68 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_71 = _T_56 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_72 = _T_71 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign config_module_id = io_in_1_bits[63:59]; // @[Dedicated_PE_Hw.scala 200:44]
  assign module_id_match = config_module_id == 5'h7; // @[Dedicated_PE_Hw.scala 201:49]
  assign config_data = io_in_1_bits[6:0]; // @[Dedicated_PE_Hw.scala 203:39]
  assign _T_76 = io_in_1_config & module_id_match; // @[Dedicated_PE_Hw.scala 204:22]
  assign io_in_0_ready = _T_48 & _T_51; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_1_ready = io_in_1_config ? io_out_0_ready : decomposed_input_ports_0_1_ready; // @[Dedicated_PE_Hw.scala 230:33 Dedicated_PE_Hw.scala 251:31]
  assign io_in_2_ready = _T_62 & _T_65; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_3_ready = _T_69 & _T_72; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_out_0_valid = io_in_1_config ? io_in_1_valid : decomposed_output_ports_0_0_valid; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 257:37]
  assign io_out_0_bits = io_in_1_config ? io_in_1_bits : decomposed_output_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 256:36]
  assign io_out_0_config = io_in_1_config; // @[Dedicated_PE_Hw.scala 247:36 Dedicated_PE_Hw.scala 251:31]
  assign all_delaypipes_hw_0_io_in_bits = _T_14 ? io_in_0_bits : _T_13; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_0_io_in_valid = _T_14 ? io_in_0_valid : _T_22; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_0_io_out_ready = all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_delaypipes_hw_1_io_in_bits = _T_33 ? io_in_0_bits : _T_32; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_1_io_in_valid = _T_33 ? io_in_0_valid : _T_41; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_1_io_out_ready = all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_0_bits = all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_0_valid = all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_bits = all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_valid = all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_out_ready = io_in_1_config ? 1'h0 : io_out_0_ready; // @[Dedicated_PE_Hw.scala 145:91]
  assign all_alus_hw_0_io_opcode = config_register_file_0[6]; // @[Dedicated_PE_Hw.scala 156:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  config_register_file_0 = _RAND_0[6:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (reset) begin
      config_register_file_0 <= 7'h0;
    end else begin
      if (_T_76) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module delay_pipe_hw_14(
  input         clock,
  input         reset,
  input  [63:0] io_in_bits,
  input         io_in_valid,
  output        io_in_ready,
  output [63:0] io_out_bits,
  output        io_out_valid,
  input         io_out_ready,
  input  [3:0]  io_delay
);
  reg [63:0] _T__0; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_0;
  reg [63:0] _T__1; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_1;
  reg [63:0] _T__2; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_2;
  reg [63:0] _T__3; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_3;
  reg [63:0] _T__4; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_4;
  reg [63:0] _T__5; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_5;
  reg [63:0] _T__6; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_6;
  reg [63:0] _T__7; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_7;
  reg [63:0] _T__8; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_8;
  reg [63:0] _T__9; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_9;
  reg [63:0] _T__10; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_10;
  reg [63:0] _T__11; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_11;
  reg [63:0] _T__12; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_12;
  reg [63:0] _T__13; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_13;
  reg [63:0] _T__14; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_14;
  reg [63:0] _T__15; // @[Dedicated_PE_Hw.scala 311:24]
  reg [63:0] _RAND_15;
  reg  _T_1_0; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_16;
  reg  _T_1_1; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_17;
  reg  _T_1_2; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_18;
  reg  _T_1_3; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_19;
  reg  _T_1_4; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_20;
  reg  _T_1_5; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_21;
  reg  _T_1_6; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_22;
  reg  _T_1_7; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_23;
  reg  _T_1_8; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_24;
  reg  _T_1_9; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_25;
  reg  _T_1_10; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_26;
  reg  _T_1_11; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_27;
  reg  _T_1_12; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_28;
  reg  _T_1_13; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_29;
  reg  _T_1_14; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_30;
  reg  _T_1_15; // @[Dedicated_PE_Hw.scala 312:25]
  reg [31:0] _RAND_31;
  reg [3:0] _T_2; // @[Dedicated_PE_Hw.scala 313:23]
  reg [31:0] _RAND_32;
  reg [3:0] _T_3; // @[Dedicated_PE_Hw.scala 314:23]
  reg [31:0] _RAND_33;
  wire [63:0] _GEN_1; // @[Dedicated_PE_Hw.scala 315:17]
  wire [63:0] _GEN_2; // @[Dedicated_PE_Hw.scala 315:17]
  wire [63:0] _GEN_3; // @[Dedicated_PE_Hw.scala 315:17]
  wire [63:0] _GEN_4; // @[Dedicated_PE_Hw.scala 315:17]
  wire [63:0] _GEN_5; // @[Dedicated_PE_Hw.scala 315:17]
  wire [63:0] _GEN_6; // @[Dedicated_PE_Hw.scala 315:17]
  wire [63:0] _GEN_7; // @[Dedicated_PE_Hw.scala 315:17]
  wire [63:0] _GEN_8; // @[Dedicated_PE_Hw.scala 315:17]
  wire [63:0] _GEN_9; // @[Dedicated_PE_Hw.scala 315:17]
  wire [63:0] _GEN_10; // @[Dedicated_PE_Hw.scala 315:17]
  wire [63:0] _GEN_11; // @[Dedicated_PE_Hw.scala 315:17]
  wire [63:0] _GEN_12; // @[Dedicated_PE_Hw.scala 315:17]
  wire [63:0] _GEN_13; // @[Dedicated_PE_Hw.scala 315:17]
  wire [63:0] _GEN_14; // @[Dedicated_PE_Hw.scala 315:17]
  wire  _GEN_17; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_18; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_19; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_20; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_21; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_22; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_23; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_24; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_25; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_26; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_27; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_28; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_29; // @[Dedicated_PE_Hw.scala 316:18]
  wire  _GEN_30; // @[Dedicated_PE_Hw.scala 316:18]
  wire [3:0] _T_5; // @[Dedicated_PE_Hw.scala 320:18]
  wire [3:0] _T_7; // @[Dedicated_PE_Hw.scala 321:18]
  assign _GEN_1 = 4'h1 == _T_2 ? _T__1 : _T__0; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_2 = 4'h2 == _T_2 ? _T__2 : _GEN_1; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_3 = 4'h3 == _T_2 ? _T__3 : _GEN_2; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_4 = 4'h4 == _T_2 ? _T__4 : _GEN_3; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_5 = 4'h5 == _T_2 ? _T__5 : _GEN_4; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_6 = 4'h6 == _T_2 ? _T__6 : _GEN_5; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_7 = 4'h7 == _T_2 ? _T__7 : _GEN_6; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_8 = 4'h8 == _T_2 ? _T__8 : _GEN_7; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_9 = 4'h9 == _T_2 ? _T__9 : _GEN_8; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_10 = 4'ha == _T_2 ? _T__10 : _GEN_9; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_11 = 4'hb == _T_2 ? _T__11 : _GEN_10; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_12 = 4'hc == _T_2 ? _T__12 : _GEN_11; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_13 = 4'hd == _T_2 ? _T__13 : _GEN_12; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_14 = 4'he == _T_2 ? _T__14 : _GEN_13; // @[Dedicated_PE_Hw.scala 315:17]
  assign _GEN_17 = 4'h1 == _T_2 ? _T_1_1 : _T_1_0; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_18 = 4'h2 == _T_2 ? _T_1_2 : _GEN_17; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_19 = 4'h3 == _T_2 ? _T_1_3 : _GEN_18; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_20 = 4'h4 == _T_2 ? _T_1_4 : _GEN_19; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_21 = 4'h5 == _T_2 ? _T_1_5 : _GEN_20; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_22 = 4'h6 == _T_2 ? _T_1_6 : _GEN_21; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_23 = 4'h7 == _T_2 ? _T_1_7 : _GEN_22; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_24 = 4'h8 == _T_2 ? _T_1_8 : _GEN_23; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_25 = 4'h9 == _T_2 ? _T_1_9 : _GEN_24; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_26 = 4'ha == _T_2 ? _T_1_10 : _GEN_25; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_27 = 4'hb == _T_2 ? _T_1_11 : _GEN_26; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_28 = 4'hc == _T_2 ? _T_1_12 : _GEN_27; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_29 = 4'hd == _T_2 ? _T_1_13 : _GEN_28; // @[Dedicated_PE_Hw.scala 316:18]
  assign _GEN_30 = 4'he == _T_2 ? _T_1_14 : _GEN_29; // @[Dedicated_PE_Hw.scala 316:18]
  assign _T_5 = _T_2 + 4'h1; // @[Dedicated_PE_Hw.scala 320:18]
  assign _T_7 = _T_2 + io_delay; // @[Dedicated_PE_Hw.scala 321:18]
  assign io_in_ready = io_out_ready; // @[Dedicated_PE_Hw.scala 319:17]
  assign io_out_bits = 4'hf == _T_2 ? _T__15 : _GEN_14; // @[Dedicated_PE_Hw.scala 315:17]
  assign io_out_valid = 4'hf == _T_2 ? _T_1_15 : _GEN_30; // @[Dedicated_PE_Hw.scala 316:18]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {2{`RANDOM}};
  _T__0 = _RAND_0[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T__1 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {2{`RANDOM}};
  _T__2 = _RAND_2[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {2{`RANDOM}};
  _T__3 = _RAND_3[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T__4 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {2{`RANDOM}};
  _T__5 = _RAND_5[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {2{`RANDOM}};
  _T__6 = _RAND_6[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T__7 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {2{`RANDOM}};
  _T__8 = _RAND_8[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {2{`RANDOM}};
  _T__9 = _RAND_9[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {2{`RANDOM}};
  _T__10 = _RAND_10[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {2{`RANDOM}};
  _T__11 = _RAND_11[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {2{`RANDOM}};
  _T__12 = _RAND_12[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {2{`RANDOM}};
  _T__13 = _RAND_13[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {2{`RANDOM}};
  _T__14 = _RAND_14[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {2{`RANDOM}};
  _T__15 = _RAND_15[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {1{`RANDOM}};
  _T_1_0 = _RAND_16[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {1{`RANDOM}};
  _T_1_1 = _RAND_17[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_18 = {1{`RANDOM}};
  _T_1_2 = _RAND_18[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_19 = {1{`RANDOM}};
  _T_1_3 = _RAND_19[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_20 = {1{`RANDOM}};
  _T_1_4 = _RAND_20[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_21 = {1{`RANDOM}};
  _T_1_5 = _RAND_21[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_22 = {1{`RANDOM}};
  _T_1_6 = _RAND_22[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_23 = {1{`RANDOM}};
  _T_1_7 = _RAND_23[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_24 = {1{`RANDOM}};
  _T_1_8 = _RAND_24[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_25 = {1{`RANDOM}};
  _T_1_9 = _RAND_25[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_26 = {1{`RANDOM}};
  _T_1_10 = _RAND_26[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_27 = {1{`RANDOM}};
  _T_1_11 = _RAND_27[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_28 = {1{`RANDOM}};
  _T_1_12 = _RAND_28[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_29 = {1{`RANDOM}};
  _T_1_13 = _RAND_29[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_30 = {1{`RANDOM}};
  _T_1_14 = _RAND_30[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_31 = {1{`RANDOM}};
  _T_1_15 = _RAND_31[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_32 = {1{`RANDOM}};
  _T_2 = _RAND_32[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_33 = {1{`RANDOM}};
  _T_3 = _RAND_33[3:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (4'h0 == _T_3) begin
      _T__0 <= io_in_bits;
    end
    if (4'h1 == _T_3) begin
      _T__1 <= io_in_bits;
    end
    if (4'h2 == _T_3) begin
      _T__2 <= io_in_bits;
    end
    if (4'h3 == _T_3) begin
      _T__3 <= io_in_bits;
    end
    if (4'h4 == _T_3) begin
      _T__4 <= io_in_bits;
    end
    if (4'h5 == _T_3) begin
      _T__5 <= io_in_bits;
    end
    if (4'h6 == _T_3) begin
      _T__6 <= io_in_bits;
    end
    if (4'h7 == _T_3) begin
      _T__7 <= io_in_bits;
    end
    if (4'h8 == _T_3) begin
      _T__8 <= io_in_bits;
    end
    if (4'h9 == _T_3) begin
      _T__9 <= io_in_bits;
    end
    if (4'ha == _T_3) begin
      _T__10 <= io_in_bits;
    end
    if (4'hb == _T_3) begin
      _T__11 <= io_in_bits;
    end
    if (4'hc == _T_3) begin
      _T__12 <= io_in_bits;
    end
    if (4'hd == _T_3) begin
      _T__13 <= io_in_bits;
    end
    if (4'he == _T_3) begin
      _T__14 <= io_in_bits;
    end
    if (4'hf == _T_3) begin
      _T__15 <= io_in_bits;
    end
    if (4'h0 == _T_3) begin
      _T_1_0 <= io_in_valid;
    end
    if (4'h1 == _T_3) begin
      _T_1_1 <= io_in_valid;
    end
    if (4'h2 == _T_3) begin
      _T_1_2 <= io_in_valid;
    end
    if (4'h3 == _T_3) begin
      _T_1_3 <= io_in_valid;
    end
    if (4'h4 == _T_3) begin
      _T_1_4 <= io_in_valid;
    end
    if (4'h5 == _T_3) begin
      _T_1_5 <= io_in_valid;
    end
    if (4'h6 == _T_3) begin
      _T_1_6 <= io_in_valid;
    end
    if (4'h7 == _T_3) begin
      _T_1_7 <= io_in_valid;
    end
    if (4'h8 == _T_3) begin
      _T_1_8 <= io_in_valid;
    end
    if (4'h9 == _T_3) begin
      _T_1_9 <= io_in_valid;
    end
    if (4'ha == _T_3) begin
      _T_1_10 <= io_in_valid;
    end
    if (4'hb == _T_3) begin
      _T_1_11 <= io_in_valid;
    end
    if (4'hc == _T_3) begin
      _T_1_12 <= io_in_valid;
    end
    if (4'hd == _T_3) begin
      _T_1_13 <= io_in_valid;
    end
    if (4'he == _T_3) begin
      _T_1_14 <= io_in_valid;
    end
    if (4'hf == _T_3) begin
      _T_1_15 <= io_in_valid;
    end
    if (reset) begin
      _T_2 <= 4'h0;
    end else begin
      _T_2 <= _T_5;
    end
    if (reset) begin
      _T_3 <= 4'h0;
    end else begin
      _T_3 <= _T_7;
    end
  end
endmodule
module Dedicated_PE_Hw_5(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_0_config,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_0_config
);
  wire  all_delaypipes_hw_0_clock; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_reset; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_0_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [3:0] all_delaypipes_hw_0_io_delay; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_clock; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_reset; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_1_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [3:0] all_delaypipes_hw_1_io_delay; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_alus_hw_0_io_in_0_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_0_io_in_1_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [2:0] all_alus_hw_0_io_opcode; // @[Dedicated_PE_Hw.scala 117:43]
  reg [14:0] config_register_file_0; // @[Dedicated_PE_Hw.scala 192:37]
  reg [31:0] _RAND_0;
  wire [1:0] _T_46; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_47; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_48; // @[Dedicated_PE_Hw.scala 164:10]
  wire [1:0] _T_49; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_50; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_51; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_0_0_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire [63:0] decomposed_output_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  decomposed_output_ports_0_0_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  _T_8; // @[Mux.scala 69:19]
  wire [63:0] _T_9; // @[Mux.scala 69:16]
  wire  _T_10; // @[Mux.scala 69:19]
  wire [63:0] _T_11; // @[Mux.scala 69:16]
  wire  _T_12; // @[Mux.scala 69:19]
  wire [63:0] _T_13; // @[Mux.scala 69:16]
  wire  _T_14; // @[Mux.scala 69:19]
  wire  _T_18; // @[Mux.scala 69:16]
  wire  _T_20; // @[Mux.scala 69:16]
  wire  _T_22; // @[Mux.scala 69:16]
  wire  _T_27; // @[Mux.scala 69:19]
  wire [63:0] _T_28; // @[Mux.scala 69:16]
  wire  _T_29; // @[Mux.scala 69:19]
  wire [63:0] _T_30; // @[Mux.scala 69:16]
  wire  _T_31; // @[Mux.scala 69:19]
  wire [63:0] _T_32; // @[Mux.scala 69:16]
  wire  _T_33; // @[Mux.scala 69:19]
  wire  _T_37; // @[Mux.scala 69:16]
  wire  _T_39; // @[Mux.scala 69:16]
  wire  _T_41; // @[Mux.scala 69:16]
  wire  _T_54; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_55; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_57; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_58; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_61; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_62; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_64; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_65; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_68; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_69; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_71; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_72; // @[Dedicated_PE_Hw.scala 164:10]
  wire [4:0] config_module_id; // @[Dedicated_PE_Hw.scala 200:44]
  wire  module_id_match; // @[Dedicated_PE_Hw.scala 201:49]
  wire [14:0] config_data; // @[Dedicated_PE_Hw.scala 203:39]
  wire  _T_76; // @[Dedicated_PE_Hw.scala 204:22]
  delay_pipe_hw_14 all_delaypipes_hw_0 ( // @[Dedicated_PE_Hw.scala 116:55]
    .clock(all_delaypipes_hw_0_clock),
    .reset(all_delaypipes_hw_0_reset),
    .io_in_bits(all_delaypipes_hw_0_io_in_bits),
    .io_in_valid(all_delaypipes_hw_0_io_in_valid),
    .io_in_ready(all_delaypipes_hw_0_io_in_ready),
    .io_out_bits(all_delaypipes_hw_0_io_out_bits),
    .io_out_valid(all_delaypipes_hw_0_io_out_valid),
    .io_out_ready(all_delaypipes_hw_0_io_out_ready),
    .io_delay(all_delaypipes_hw_0_io_delay)
  );
  delay_pipe_hw_14 all_delaypipes_hw_1 ( // @[Dedicated_PE_Hw.scala 116:55]
    .clock(all_delaypipes_hw_1_clock),
    .reset(all_delaypipes_hw_1_reset),
    .io_in_bits(all_delaypipes_hw_1_io_in_bits),
    .io_in_valid(all_delaypipes_hw_1_io_in_valid),
    .io_in_ready(all_delaypipes_hw_1_io_in_ready),
    .io_out_bits(all_delaypipes_hw_1_io_out_bits),
    .io_out_valid(all_delaypipes_hw_1_io_out_valid),
    .io_out_ready(all_delaypipes_hw_1_io_out_ready),
    .io_delay(all_delaypipes_hw_1_io_delay)
  );
  alu_hw all_alus_hw_0 ( // @[Dedicated_PE_Hw.scala 117:43]
    .io_in_0_bits(all_alus_hw_0_io_in_0_bits),
    .io_in_0_valid(all_alus_hw_0_io_in_0_valid),
    .io_in_0_ready(all_alus_hw_0_io_in_0_ready),
    .io_in_1_bits(all_alus_hw_0_io_in_1_bits),
    .io_in_1_valid(all_alus_hw_0_io_in_1_valid),
    .io_in_1_ready(all_alus_hw_0_io_in_1_ready),
    .io_out_bits(all_alus_hw_0_io_out_bits),
    .io_out_valid(all_alus_hw_0_io_out_valid),
    .io_out_ready(all_alus_hw_0_io_out_ready),
    .io_opcode(all_alus_hw_0_io_opcode)
  );
  assign _T_46 = config_register_file_0[1:0]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_47 = _T_46 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_48 = _T_47 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_49 = config_register_file_0[3:2]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_50 = _T_49 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_51 = _T_50 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_0_0_ready = _T_48 & _T_51; // @[Dedicated_PE_Hw.scala 168:99]
  assign decomposed_output_ports_0_0_bits = all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign decomposed_output_ports_0_0_valid = all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign _T_8 = 2'h3 == _T_46; // @[Mux.scala 69:19]
  assign _T_9 = _T_8 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_10 = 2'h2 == _T_46; // @[Mux.scala 69:19]
  assign _T_11 = _T_10 ? io_in_2_bits : _T_9; // @[Mux.scala 69:16]
  assign _T_12 = 2'h1 == _T_46; // @[Mux.scala 69:19]
  assign _T_13 = _T_12 ? io_in_1_bits : _T_11; // @[Mux.scala 69:16]
  assign _T_14 = 2'h0 == _T_46; // @[Mux.scala 69:19]
  assign _T_18 = _T_8 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_20 = _T_10 ? io_in_2_valid : _T_18; // @[Mux.scala 69:16]
  assign _T_22 = _T_12 ? io_in_1_valid : _T_20; // @[Mux.scala 69:16]
  assign _T_27 = 2'h3 == _T_49; // @[Mux.scala 69:19]
  assign _T_28 = _T_27 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_29 = 2'h2 == _T_49; // @[Mux.scala 69:19]
  assign _T_30 = _T_29 ? io_in_2_bits : _T_28; // @[Mux.scala 69:16]
  assign _T_31 = 2'h1 == _T_49; // @[Mux.scala 69:19]
  assign _T_32 = _T_31 ? io_in_1_bits : _T_30; // @[Mux.scala 69:16]
  assign _T_33 = 2'h0 == _T_49; // @[Mux.scala 69:19]
  assign _T_37 = _T_27 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_39 = _T_29 ? io_in_2_valid : _T_37; // @[Mux.scala 69:16]
  assign _T_41 = _T_31 ? io_in_1_valid : _T_39; // @[Mux.scala 69:16]
  assign _T_54 = _T_46 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_55 = _T_54 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_57 = _T_49 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_58 = _T_57 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_61 = _T_46 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_62 = _T_61 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_64 = _T_49 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_65 = _T_64 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_68 = _T_46 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_69 = _T_68 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_71 = _T_49 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_72 = _T_71 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign config_module_id = io_in_0_bits[63:59]; // @[Dedicated_PE_Hw.scala 200:44]
  assign module_id_match = config_module_id == 5'h1; // @[Dedicated_PE_Hw.scala 201:49]
  assign config_data = io_in_0_bits[14:0]; // @[Dedicated_PE_Hw.scala 203:39]
  assign _T_76 = io_in_0_config & module_id_match; // @[Dedicated_PE_Hw.scala 204:22]
  assign io_in_0_ready = io_in_0_config ? io_out_0_ready : decomposed_input_ports_0_0_ready; // @[Dedicated_PE_Hw.scala 230:33 Dedicated_PE_Hw.scala 251:31]
  assign io_in_1_ready = _T_55 & _T_58; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_2_ready = _T_62 & _T_65; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_3_ready = _T_69 & _T_72; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_out_0_valid = io_in_0_config ? io_in_0_valid : decomposed_output_ports_0_0_valid; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 257:37]
  assign io_out_0_bits = io_in_0_config ? io_in_0_bits : decomposed_output_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 256:36]
  assign io_out_0_config = io_in_0_config; // @[Dedicated_PE_Hw.scala 247:36 Dedicated_PE_Hw.scala 251:31]
  assign all_delaypipes_hw_0_clock = clock;
  assign all_delaypipes_hw_0_reset = reset;
  assign all_delaypipes_hw_0_io_in_bits = _T_14 ? io_in_0_bits : _T_13; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_0_io_in_valid = _T_14 ? io_in_0_valid : _T_22; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_0_io_out_ready = all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_delaypipes_hw_0_io_delay = config_register_file_0[7:4]; // @[Dedicated_PE_Hw.scala 142:30]
  assign all_delaypipes_hw_1_clock = clock;
  assign all_delaypipes_hw_1_reset = reset;
  assign all_delaypipes_hw_1_io_in_bits = _T_33 ? io_in_0_bits : _T_32; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_1_io_in_valid = _T_33 ? io_in_0_valid : _T_41; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_1_io_out_ready = all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_delaypipes_hw_1_io_delay = config_register_file_0[11:8]; // @[Dedicated_PE_Hw.scala 142:30]
  assign all_alus_hw_0_io_in_0_bits = all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_0_valid = all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_bits = all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_valid = all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_out_ready = io_in_0_config ? 1'h0 : io_out_0_ready; // @[Dedicated_PE_Hw.scala 145:91]
  assign all_alus_hw_0_io_opcode = config_register_file_0[14:12]; // @[Dedicated_PE_Hw.scala 156:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  config_register_file_0 = _RAND_0[14:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (reset) begin
      config_register_file_0 <= 15'h0;
    end else begin
      if (_T_76) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Dedicated_PE_Hw_6(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_0_config,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_0_config
);
  wire [63:0] all_delaypipes_hw_0_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_1_io_in_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_in_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 116:55]
  wire  all_delaypipes_hw_1_io_out_ready; // @[Dedicated_PE_Hw.scala 116:55]
  wire [63:0] all_alus_hw_0_io_in_0_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_0_io_in_1_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [63:0] all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 117:43]
  wire  all_alus_hw_0_io_out_ready; // @[Dedicated_PE_Hw.scala 117:43]
  wire [2:0] all_alus_hw_0_io_opcode; // @[Dedicated_PE_Hw.scala 117:43]
  reg [8:0] config_register_file_0; // @[Dedicated_PE_Hw.scala 192:37]
  reg [31:0] _RAND_0;
  wire [1:0] _T_46; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_47; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_48; // @[Dedicated_PE_Hw.scala 164:10]
  wire [1:0] _T_49; // @[Dedicated_PE_Hw.scala 164:22]
  wire  _T_50; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_51; // @[Dedicated_PE_Hw.scala 164:10]
  wire  decomposed_input_ports_0_0_ready; // @[Dedicated_PE_Hw.scala 168:99]
  wire [63:0] decomposed_output_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  decomposed_output_ports_0_0_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  wire  _T_8; // @[Mux.scala 69:19]
  wire [63:0] _T_9; // @[Mux.scala 69:16]
  wire  _T_10; // @[Mux.scala 69:19]
  wire [63:0] _T_11; // @[Mux.scala 69:16]
  wire  _T_12; // @[Mux.scala 69:19]
  wire [63:0] _T_13; // @[Mux.scala 69:16]
  wire  _T_14; // @[Mux.scala 69:19]
  wire  _T_18; // @[Mux.scala 69:16]
  wire  _T_20; // @[Mux.scala 69:16]
  wire  _T_22; // @[Mux.scala 69:16]
  wire  _T_27; // @[Mux.scala 69:19]
  wire [63:0] _T_28; // @[Mux.scala 69:16]
  wire  _T_29; // @[Mux.scala 69:19]
  wire [63:0] _T_30; // @[Mux.scala 69:16]
  wire  _T_31; // @[Mux.scala 69:19]
  wire [63:0] _T_32; // @[Mux.scala 69:16]
  wire  _T_33; // @[Mux.scala 69:19]
  wire  _T_37; // @[Mux.scala 69:16]
  wire  _T_39; // @[Mux.scala 69:16]
  wire  _T_41; // @[Mux.scala 69:16]
  wire  _T_54; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_55; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_57; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_58; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_61; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_62; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_64; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_65; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_68; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_69; // @[Dedicated_PE_Hw.scala 164:10]
  wire  _T_71; // @[Dedicated_PE_Hw.scala 164:53]
  wire  _T_72; // @[Dedicated_PE_Hw.scala 164:10]
  wire [4:0] config_module_id; // @[Dedicated_PE_Hw.scala 200:44]
  wire  module_id_match; // @[Dedicated_PE_Hw.scala 201:49]
  wire [8:0] config_data; // @[Dedicated_PE_Hw.scala 203:39]
  wire  _T_76; // @[Dedicated_PE_Hw.scala 204:22]
  delay_pipe_hw all_delaypipes_hw_0 ( // @[Dedicated_PE_Hw.scala 116:55]
    .io_in_bits(all_delaypipes_hw_0_io_in_bits),
    .io_in_valid(all_delaypipes_hw_0_io_in_valid),
    .io_in_ready(all_delaypipes_hw_0_io_in_ready),
    .io_out_bits(all_delaypipes_hw_0_io_out_bits),
    .io_out_valid(all_delaypipes_hw_0_io_out_valid),
    .io_out_ready(all_delaypipes_hw_0_io_out_ready)
  );
  delay_pipe_hw all_delaypipes_hw_1 ( // @[Dedicated_PE_Hw.scala 116:55]
    .io_in_bits(all_delaypipes_hw_1_io_in_bits),
    .io_in_valid(all_delaypipes_hw_1_io_in_valid),
    .io_in_ready(all_delaypipes_hw_1_io_in_ready),
    .io_out_bits(all_delaypipes_hw_1_io_out_bits),
    .io_out_valid(all_delaypipes_hw_1_io_out_valid),
    .io_out_ready(all_delaypipes_hw_1_io_out_ready)
  );
  alu_hw all_alus_hw_0 ( // @[Dedicated_PE_Hw.scala 117:43]
    .io_in_0_bits(all_alus_hw_0_io_in_0_bits),
    .io_in_0_valid(all_alus_hw_0_io_in_0_valid),
    .io_in_0_ready(all_alus_hw_0_io_in_0_ready),
    .io_in_1_bits(all_alus_hw_0_io_in_1_bits),
    .io_in_1_valid(all_alus_hw_0_io_in_1_valid),
    .io_in_1_ready(all_alus_hw_0_io_in_1_ready),
    .io_out_bits(all_alus_hw_0_io_out_bits),
    .io_out_valid(all_alus_hw_0_io_out_valid),
    .io_out_ready(all_alus_hw_0_io_out_ready),
    .io_opcode(all_alus_hw_0_io_opcode)
  );
  assign _T_46 = config_register_file_0[1:0]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_47 = _T_46 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_48 = _T_47 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_49 = config_register_file_0[3:2]; // @[Dedicated_PE_Hw.scala 164:22]
  assign _T_50 = _T_49 == 2'h0; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_51 = _T_50 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign decomposed_input_ports_0_0_ready = _T_48 & _T_51; // @[Dedicated_PE_Hw.scala 168:99]
  assign decomposed_output_ports_0_0_bits = all_alus_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign decomposed_output_ports_0_0_valid = all_alus_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 219:57 Dedicated_PE_Hw.scala 145:91]
  assign _T_8 = 2'h3 == _T_46; // @[Mux.scala 69:19]
  assign _T_9 = _T_8 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_10 = 2'h2 == _T_46; // @[Mux.scala 69:19]
  assign _T_11 = _T_10 ? io_in_2_bits : _T_9; // @[Mux.scala 69:16]
  assign _T_12 = 2'h1 == _T_46; // @[Mux.scala 69:19]
  assign _T_13 = _T_12 ? io_in_1_bits : _T_11; // @[Mux.scala 69:16]
  assign _T_14 = 2'h0 == _T_46; // @[Mux.scala 69:19]
  assign _T_18 = _T_8 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_20 = _T_10 ? io_in_2_valid : _T_18; // @[Mux.scala 69:16]
  assign _T_22 = _T_12 ? io_in_1_valid : _T_20; // @[Mux.scala 69:16]
  assign _T_27 = 2'h3 == _T_49; // @[Mux.scala 69:19]
  assign _T_28 = _T_27 ? io_in_3_bits : 64'h0; // @[Mux.scala 69:16]
  assign _T_29 = 2'h2 == _T_49; // @[Mux.scala 69:19]
  assign _T_30 = _T_29 ? io_in_2_bits : _T_28; // @[Mux.scala 69:16]
  assign _T_31 = 2'h1 == _T_49; // @[Mux.scala 69:19]
  assign _T_32 = _T_31 ? io_in_1_bits : _T_30; // @[Mux.scala 69:16]
  assign _T_33 = 2'h0 == _T_49; // @[Mux.scala 69:19]
  assign _T_37 = _T_27 ? io_in_3_valid : 1'h0; // @[Mux.scala 69:16]
  assign _T_39 = _T_29 ? io_in_2_valid : _T_37; // @[Mux.scala 69:16]
  assign _T_41 = _T_31 ? io_in_1_valid : _T_39; // @[Mux.scala 69:16]
  assign _T_54 = _T_46 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_55 = _T_54 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_57 = _T_49 == 2'h1; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_58 = _T_57 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_61 = _T_46 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_62 = _T_61 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_64 = _T_49 == 2'h2; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_65 = _T_64 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_68 = _T_46 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_69 = _T_68 ? all_delaypipes_hw_0_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign _T_71 = _T_49 == 2'h3; // @[Dedicated_PE_Hw.scala 164:53]
  assign _T_72 = _T_71 ? all_delaypipes_hw_1_io_in_ready : 1'h1; // @[Dedicated_PE_Hw.scala 164:10]
  assign config_module_id = io_in_0_bits[63:59]; // @[Dedicated_PE_Hw.scala 200:44]
  assign module_id_match = config_module_id == 5'h4; // @[Dedicated_PE_Hw.scala 201:49]
  assign config_data = io_in_0_bits[8:0]; // @[Dedicated_PE_Hw.scala 203:39]
  assign _T_76 = io_in_0_config & module_id_match; // @[Dedicated_PE_Hw.scala 204:22]
  assign io_in_0_ready = io_in_0_config ? io_out_0_ready : decomposed_input_ports_0_0_ready; // @[Dedicated_PE_Hw.scala 230:33 Dedicated_PE_Hw.scala 251:31]
  assign io_in_1_ready = _T_55 & _T_58; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_2_ready = _T_62 & _T_65; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_in_3_ready = _T_69 & _T_72; // @[Dedicated_PE_Hw.scala 230:33]
  assign io_out_0_valid = io_in_0_config ? io_in_0_valid : decomposed_output_ports_0_0_valid; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 257:37]
  assign io_out_0_bits = io_in_0_config ? io_in_0_bits : decomposed_output_ports_0_0_bits; // @[Dedicated_PE_Hw.scala 251:31 Dedicated_PE_Hw.scala 256:36]
  assign io_out_0_config = io_in_0_config; // @[Dedicated_PE_Hw.scala 247:36 Dedicated_PE_Hw.scala 251:31]
  assign all_delaypipes_hw_0_io_in_bits = _T_14 ? io_in_0_bits : _T_13; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_0_io_in_valid = _T_14 ? io_in_0_valid : _T_22; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_0_io_out_ready = all_alus_hw_0_io_in_0_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_delaypipes_hw_1_io_in_bits = _T_33 ? io_in_0_bits : _T_32; // @[Dedicated_PE_Hw.scala 135:32]
  assign all_delaypipes_hw_1_io_in_valid = _T_33 ? io_in_0_valid : _T_41; // @[Dedicated_PE_Hw.scala 137:33]
  assign all_delaypipes_hw_1_io_out_ready = all_alus_hw_0_io_in_1_ready; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_0_bits = all_delaypipes_hw_0_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_0_valid = all_delaypipes_hw_0_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_bits = all_delaypipes_hw_1_io_out_bits; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_in_1_valid = all_delaypipes_hw_1_io_out_valid; // @[Dedicated_PE_Hw.scala 140:33]
  assign all_alus_hw_0_io_out_ready = io_in_0_config ? 1'h0 : io_out_0_ready; // @[Dedicated_PE_Hw.scala 145:91]
  assign all_alus_hw_0_io_opcode = config_register_file_0[8:6]; // @[Dedicated_PE_Hw.scala 156:22]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  config_register_file_0 = _RAND_0[8:0];
  `endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end
  always @(posedge clock) begin
    if (reset) begin
      config_register_file_0 <= 9'h0;
    end else begin
      if (_T_76) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Shared_PE_Hw(
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_2_valid,
  input  [63:0] io_in_2_bits,
  output        io_in_2_ready,
  input         io_in_3_valid,
  input  [63:0] io_in_3_bits,
  output        io_in_3_ready,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_2_valid,
  output [63:0] io_out_2_bits,
  input         io_out_2_ready
);
  assign io_in_1_ready = io_out_2_ready; // @[Shared_PE_Hw.scala 35:14]
  assign io_in_2_ready = io_out_1_ready; // @[Shared_PE_Hw.scala 35:14]
  assign io_in_3_ready = io_out_0_ready; // @[Shared_PE_Hw.scala 35:14]
  assign io_out_0_valid = io_in_3_valid; // @[Shared_PE_Hw.scala 35:14]
  assign io_out_0_bits = io_in_3_bits; // @[Shared_PE_Hw.scala 35:14]
  assign io_out_1_valid = io_in_2_valid; // @[Shared_PE_Hw.scala 35:14]
  assign io_out_1_bits = io_in_2_bits; // @[Shared_PE_Hw.scala 35:14]
  assign io_out_2_valid = io_in_1_valid; // @[Shared_PE_Hw.scala 35:14]
  assign io_out_2_bits = io_in_1_bits; // @[Shared_PE_Hw.scala 35:14]
endmodule
module Cgra_Hw(
  input         clock,
  input         reset,
  input         io_in_0_valid,
  input  [63:0] io_in_0_bits,
  output        io_in_0_ready,
  input         io_in_0_config,
  input         io_in_1_valid,
  input  [63:0] io_in_1_bits,
  output        io_in_1_ready,
  input         io_in_1_config,
  output        io_out_0_valid,
  output [63:0] io_out_0_bits,
  input         io_out_0_ready,
  output        io_out_0_config,
  output        io_out_1_valid,
  output [63:0] io_out_1_bits,
  input         io_out_1_ready,
  output        io_out_1_config
);
  wire  VectorPort_Hw_clock; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_reset; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_io_in_0_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_io_in_0_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_io_in_0_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_io_in_0_config; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_io_out_0_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_io_out_0_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_io_out_0_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_io_out_0_config; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_io_out_1_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_io_out_1_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_io_out_1_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_io_out_2_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_io_out_2_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_io_out_2_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_io_out_2_config; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_1_clock; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_1_reset; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_1_io_in_0_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_1_io_in_0_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_1_io_in_0_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_1_io_in_0_config; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_1_io_out_0_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_1_io_out_0_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_1_io_out_0_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_1_io_out_0_config; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_1_io_out_1_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_1_io_out_1_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_1_io_out_1_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_1_io_out_2_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_1_io_out_2_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_1_io_out_2_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_1_io_out_2_config; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_2_clock; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_2_reset; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_2_io_in_0_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_2_io_in_0_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_2_io_in_0_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_2_io_in_1_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_2_io_in_1_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_2_io_in_1_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_2_io_in_2_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_2_io_in_2_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_2_io_in_2_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_2_io_out_0_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_2_io_out_0_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_2_io_out_0_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_3_clock; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_3_reset; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_3_io_in_0_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_3_io_in_0_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_3_io_in_0_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_3_io_in_1_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_3_io_in_1_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_3_io_in_1_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_3_io_in_2_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_3_io_in_2_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_3_io_in_2_ready; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_3_io_out_0_valid; // @[Cgra_Hw.scala 33:63]
  wire [63:0] VectorPort_Hw_3_io_out_0_bits; // @[Cgra_Hw.scala 33:63]
  wire  VectorPort_Hw_3_io_out_0_ready; // @[Cgra_Hw.scala 33:63]
  wire  Router_Hw_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_reset; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_in_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_io_in_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_in_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_in_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_io_in_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_in_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_in_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_io_in_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_in_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_in_3_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_out_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_io_out_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_out_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_io_out_4_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_reset; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_in_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_in_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_in_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_in_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_in_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_in_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_in_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_in_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_in_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_in_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_in_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_in_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_in_4_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_in_5_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_in_5_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_in_5_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_3_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_out_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_5_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_out_5_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_5_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_6_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_out_6_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_6_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_7_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_1_io_out_7_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_1_io_out_7_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_reset; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_2_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_in_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_2_io_in_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_in_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_in_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_2_io_in_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_in_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_in_2_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_in_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_2_io_in_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_in_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_2_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_2_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_2_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_2_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_out_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_2_io_out_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_out_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_2_io_out_4_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_reset; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_3_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_3_io_in_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_3_io_in_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_3_io_in_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_3_io_in_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_4_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_5_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_3_io_in_5_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_5_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_6_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_3_io_in_6_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_in_6_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_3_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_3_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_3_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_out_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_3_io_out_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_out_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_out_5_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_3_io_out_5_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_out_5_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_out_7_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_3_io_out_7_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_out_7_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_3_io_out_7_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_reset; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_4_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_in_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_4_io_in_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_in_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_in_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_4_io_in_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_in_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_in_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_4_io_in_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_in_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_in_3_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_4_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_4_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_4_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_out_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_4_io_out_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_out_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_out_5_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_4_io_out_5_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_4_io_out_5_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_reset; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_5_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_in_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_5_io_in_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_in_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_in_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_5_io_in_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_in_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_in_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_5_io_in_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_in_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_in_3_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_in_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_5_io_in_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_in_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_5_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_5_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_5_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_5_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_out_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_5_io_out_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_out_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_out_5_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_5_io_out_5_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_5_io_out_5_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_reset; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_6_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_in_0_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_in_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_6_io_in_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_in_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_in_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_6_io_in_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_in_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_in_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_6_io_in_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_in_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_6_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_6_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_out_1_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_6_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_6_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_out_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_6_io_out_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_6_io_out_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_reset; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_7_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_in_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_7_io_in_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_in_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_in_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_7_io_in_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_in_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_in_2_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_in_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_7_io_in_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_in_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_7_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_7_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_7_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_7_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_out_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_7_io_out_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_out_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_7_io_out_4_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_8_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_8_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_8_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_8_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_8_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_8_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_8_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_8_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_8_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_8_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_8_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_8_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_8_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_reset; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_9_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_in_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_9_io_in_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_in_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_in_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_9_io_in_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_in_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_in_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_9_io_in_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_in_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_in_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_9_io_in_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_in_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_in_4_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_9_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_9_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_9_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_9_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_3_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_9_io_out_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_5_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_9_io_out_5_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_5_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_6_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_9_io_out_6_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_6_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_7_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_9_io_out_7_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_9_io_out_7_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_10_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_10_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_10_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_10_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_10_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_10_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_10_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_10_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_10_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_10_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_10_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_10_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_10_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_10_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_10_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_10_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_reset; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_11_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_in_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_11_io_in_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_in_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_in_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_11_io_in_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_in_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_in_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_11_io_in_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_in_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_in_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_11_io_in_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_in_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_in_4_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_in_5_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_11_io_in_5_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_in_5_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_11_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_11_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_11_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_11_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_11_io_out_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_5_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_11_io_out_5_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_5_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_7_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_11_io_out_7_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_7_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_11_io_out_7_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_12_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_12_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_12_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_12_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_12_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_out_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_12_io_out_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_out_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_out_5_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_12_io_out_5_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_12_io_out_5_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_reset; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_13_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_in_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_13_io_in_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_in_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_in_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_13_io_in_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_in_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_in_2_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_13_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_13_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_13_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_13_io_out_2_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_reset; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_14_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_in_0_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_in_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_14_io_in_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_in_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_in_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_14_io_in_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_in_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_14_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_out_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_14_io_out_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_out_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_14_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_14_io_out_2_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_clock; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_reset; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_in_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_15_io_in_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_in_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_in_1_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_15_io_in_1_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_in_1_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_in_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_15_io_in_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_in_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_in_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_15_io_in_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_in_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_in_3_config; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_in_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_15_io_in_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_in_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_out_0_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_15_io_out_0_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_out_0_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_out_2_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_15_io_out_2_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_out_2_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_out_3_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_15_io_out_3_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_out_3_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_out_4_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_15_io_out_4_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_out_4_ready; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_out_5_valid; // @[Cgra_Hw.scala 38:51]
  wire [63:0] Router_Hw_15_io_out_5_bits; // @[Cgra_Hw.scala 38:51]
  wire  Router_Hw_15_io_out_5_ready; // @[Cgra_Hw.scala 38:51]
  wire  Dedicated_PE_Hw_clock; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_reset; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_io_in_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_io_in_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_io_in_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_io_in_0_config; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_io_in_1_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_io_in_1_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_io_in_1_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_io_in_2_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_io_in_2_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_io_in_2_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_io_in_3_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_io_in_3_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_io_in_3_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_io_out_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_io_out_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_io_out_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_io_out_0_config; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_clock; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_reset; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_io_in_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_1_io_in_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_io_in_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_io_in_1_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_1_io_in_1_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_io_in_1_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_io_in_1_config; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_io_in_2_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_1_io_in_2_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_io_in_2_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_io_in_3_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_1_io_in_3_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_io_in_3_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_io_out_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_1_io_out_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_io_out_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_1_io_out_0_config; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_clock; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_reset; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_in_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_2_io_in_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_in_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_in_1_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_2_io_in_1_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_in_1_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_in_1_config; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_in_2_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_2_io_in_2_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_in_2_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_in_3_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_2_io_in_3_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_in_3_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_out_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_2_io_out_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_out_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_out_0_config; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_out_1_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_2_io_out_1_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_2_io_out_1_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_clock; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_reset; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_io_in_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_3_io_in_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_io_in_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_io_in_1_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_3_io_in_1_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_io_in_1_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_io_in_1_config; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_io_in_2_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_3_io_in_2_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_io_in_2_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_io_in_3_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_3_io_in_3_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_io_in_3_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_io_out_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_3_io_out_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_io_out_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_3_io_out_0_config; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_clock; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_reset; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_io_in_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_4_io_in_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_io_in_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_io_in_1_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_4_io_in_1_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_io_in_1_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_io_in_1_config; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_io_in_2_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_4_io_in_2_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_io_in_2_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_io_in_3_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_4_io_in_3_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_io_in_3_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_io_out_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_4_io_out_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_io_out_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_4_io_out_0_config; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_clock; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_reset; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_io_in_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_5_io_in_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_io_in_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_io_in_0_config; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_io_in_1_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_5_io_in_1_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_io_in_1_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_io_in_2_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_5_io_in_2_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_io_in_2_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_io_in_3_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_5_io_in_3_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_io_in_3_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_io_out_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_5_io_out_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_io_out_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_5_io_out_0_config; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_clock; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_reset; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_io_in_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_6_io_in_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_io_in_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_io_in_0_config; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_io_in_1_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_6_io_in_1_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_io_in_1_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_io_in_2_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_6_io_in_2_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_io_in_2_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_io_in_3_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_6_io_in_3_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_io_in_3_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_io_out_0_valid; // @[Cgra_Hw.scala 43:66]
  wire [63:0] Dedicated_PE_Hw_6_io_out_0_bits; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_io_out_0_ready; // @[Cgra_Hw.scala 43:66]
  wire  Dedicated_PE_Hw_6_io_out_0_config; // @[Cgra_Hw.scala 43:66]
  wire  Shared_PE_Hw_io_in_1_valid; // @[Cgra_Hw.scala 48:60]
  wire [63:0] Shared_PE_Hw_io_in_1_bits; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_io_in_1_ready; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_io_in_2_valid; // @[Cgra_Hw.scala 48:60]
  wire [63:0] Shared_PE_Hw_io_in_2_bits; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_io_in_2_ready; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_io_in_3_valid; // @[Cgra_Hw.scala 48:60]
  wire [63:0] Shared_PE_Hw_io_in_3_bits; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_io_in_3_ready; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_io_out_0_valid; // @[Cgra_Hw.scala 48:60]
  wire [63:0] Shared_PE_Hw_io_out_0_bits; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_io_out_0_ready; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_io_out_1_valid; // @[Cgra_Hw.scala 48:60]
  wire [63:0] Shared_PE_Hw_io_out_1_bits; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_io_out_1_ready; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_io_out_2_valid; // @[Cgra_Hw.scala 48:60]
  wire [63:0] Shared_PE_Hw_io_out_2_bits; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_io_out_2_ready; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_1_io_in_1_valid; // @[Cgra_Hw.scala 48:60]
  wire [63:0] Shared_PE_Hw_1_io_in_1_bits; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_1_io_in_1_ready; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_1_io_in_2_valid; // @[Cgra_Hw.scala 48:60]
  wire [63:0] Shared_PE_Hw_1_io_in_2_bits; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_1_io_in_2_ready; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_1_io_in_3_valid; // @[Cgra_Hw.scala 48:60]
  wire [63:0] Shared_PE_Hw_1_io_in_3_bits; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_1_io_in_3_ready; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_1_io_out_0_valid; // @[Cgra_Hw.scala 48:60]
  wire [63:0] Shared_PE_Hw_1_io_out_0_bits; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_1_io_out_0_ready; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_1_io_out_1_valid; // @[Cgra_Hw.scala 48:60]
  wire [63:0] Shared_PE_Hw_1_io_out_1_bits; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_1_io_out_1_ready; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_1_io_out_2_valid; // @[Cgra_Hw.scala 48:60]
  wire [63:0] Shared_PE_Hw_1_io_out_2_bits; // @[Cgra_Hw.scala 48:60]
  wire  Shared_PE_Hw_1_io_out_2_ready; // @[Cgra_Hw.scala 48:60]
  VectorPort_Hw VectorPort_Hw ( // @[Cgra_Hw.scala 33:63]
    .clock(VectorPort_Hw_clock),
    .reset(VectorPort_Hw_reset),
    .io_in_0_valid(VectorPort_Hw_io_in_0_valid),
    .io_in_0_bits(VectorPort_Hw_io_in_0_bits),
    .io_in_0_ready(VectorPort_Hw_io_in_0_ready),
    .io_in_0_config(VectorPort_Hw_io_in_0_config),
    .io_out_0_valid(VectorPort_Hw_io_out_0_valid),
    .io_out_0_bits(VectorPort_Hw_io_out_0_bits),
    .io_out_0_ready(VectorPort_Hw_io_out_0_ready),
    .io_out_0_config(VectorPort_Hw_io_out_0_config),
    .io_out_1_valid(VectorPort_Hw_io_out_1_valid),
    .io_out_1_bits(VectorPort_Hw_io_out_1_bits),
    .io_out_1_ready(VectorPort_Hw_io_out_1_ready),
    .io_out_2_valid(VectorPort_Hw_io_out_2_valid),
    .io_out_2_bits(VectorPort_Hw_io_out_2_bits),
    .io_out_2_ready(VectorPort_Hw_io_out_2_ready),
    .io_out_2_config(VectorPort_Hw_io_out_2_config)
  );
  VectorPort_Hw VectorPort_Hw_1 ( // @[Cgra_Hw.scala 33:63]
    .clock(VectorPort_Hw_1_clock),
    .reset(VectorPort_Hw_1_reset),
    .io_in_0_valid(VectorPort_Hw_1_io_in_0_valid),
    .io_in_0_bits(VectorPort_Hw_1_io_in_0_bits),
    .io_in_0_ready(VectorPort_Hw_1_io_in_0_ready),
    .io_in_0_config(VectorPort_Hw_1_io_in_0_config),
    .io_out_0_valid(VectorPort_Hw_1_io_out_0_valid),
    .io_out_0_bits(VectorPort_Hw_1_io_out_0_bits),
    .io_out_0_ready(VectorPort_Hw_1_io_out_0_ready),
    .io_out_0_config(VectorPort_Hw_1_io_out_0_config),
    .io_out_1_valid(VectorPort_Hw_1_io_out_1_valid),
    .io_out_1_bits(VectorPort_Hw_1_io_out_1_bits),
    .io_out_1_ready(VectorPort_Hw_1_io_out_1_ready),
    .io_out_2_valid(VectorPort_Hw_1_io_out_2_valid),
    .io_out_2_bits(VectorPort_Hw_1_io_out_2_bits),
    .io_out_2_ready(VectorPort_Hw_1_io_out_2_ready),
    .io_out_2_config(VectorPort_Hw_1_io_out_2_config)
  );
  VectorPort_Hw_2 VectorPort_Hw_2 ( // @[Cgra_Hw.scala 33:63]
    .clock(VectorPort_Hw_2_clock),
    .reset(VectorPort_Hw_2_reset),
    .io_in_0_valid(VectorPort_Hw_2_io_in_0_valid),
    .io_in_0_bits(VectorPort_Hw_2_io_in_0_bits),
    .io_in_0_ready(VectorPort_Hw_2_io_in_0_ready),
    .io_in_1_valid(VectorPort_Hw_2_io_in_1_valid),
    .io_in_1_bits(VectorPort_Hw_2_io_in_1_bits),
    .io_in_1_ready(VectorPort_Hw_2_io_in_1_ready),
    .io_in_2_valid(VectorPort_Hw_2_io_in_2_valid),
    .io_in_2_bits(VectorPort_Hw_2_io_in_2_bits),
    .io_in_2_ready(VectorPort_Hw_2_io_in_2_ready),
    .io_out_0_valid(VectorPort_Hw_2_io_out_0_valid),
    .io_out_0_bits(VectorPort_Hw_2_io_out_0_bits),
    .io_out_0_ready(VectorPort_Hw_2_io_out_0_ready)
  );
  VectorPort_Hw_2 VectorPort_Hw_3 ( // @[Cgra_Hw.scala 33:63]
    .clock(VectorPort_Hw_3_clock),
    .reset(VectorPort_Hw_3_reset),
    .io_in_0_valid(VectorPort_Hw_3_io_in_0_valid),
    .io_in_0_bits(VectorPort_Hw_3_io_in_0_bits),
    .io_in_0_ready(VectorPort_Hw_3_io_in_0_ready),
    .io_in_1_valid(VectorPort_Hw_3_io_in_1_valid),
    .io_in_1_bits(VectorPort_Hw_3_io_in_1_bits),
    .io_in_1_ready(VectorPort_Hw_3_io_in_1_ready),
    .io_in_2_valid(VectorPort_Hw_3_io_in_2_valid),
    .io_in_2_bits(VectorPort_Hw_3_io_in_2_bits),
    .io_in_2_ready(VectorPort_Hw_3_io_in_2_ready),
    .io_out_0_valid(VectorPort_Hw_3_io_out_0_valid),
    .io_out_0_bits(VectorPort_Hw_3_io_out_0_bits),
    .io_out_0_ready(VectorPort_Hw_3_io_out_0_ready)
  );
  Router_Hw Router_Hw ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_clock),
    .reset(Router_Hw_reset),
    .io_in_0_valid(Router_Hw_io_in_0_valid),
    .io_in_0_bits(Router_Hw_io_in_0_bits),
    .io_in_0_ready(Router_Hw_io_in_0_ready),
    .io_in_1_valid(Router_Hw_io_in_1_valid),
    .io_in_1_bits(Router_Hw_io_in_1_bits),
    .io_in_1_ready(Router_Hw_io_in_1_ready),
    .io_in_2_valid(Router_Hw_io_in_2_valid),
    .io_in_2_bits(Router_Hw_io_in_2_bits),
    .io_in_2_ready(Router_Hw_io_in_2_ready),
    .io_in_3_valid(Router_Hw_io_in_3_valid),
    .io_in_3_bits(Router_Hw_io_in_3_bits),
    .io_in_3_ready(Router_Hw_io_in_3_ready),
    .io_in_3_config(Router_Hw_io_in_3_config),
    .io_out_0_valid(Router_Hw_io_out_0_valid),
    .io_out_0_bits(Router_Hw_io_out_0_bits),
    .io_out_0_ready(Router_Hw_io_out_0_ready),
    .io_out_1_valid(Router_Hw_io_out_1_valid),
    .io_out_1_bits(Router_Hw_io_out_1_bits),
    .io_out_1_ready(Router_Hw_io_out_1_ready),
    .io_out_2_valid(Router_Hw_io_out_2_valid),
    .io_out_2_bits(Router_Hw_io_out_2_bits),
    .io_out_2_ready(Router_Hw_io_out_2_ready),
    .io_out_3_valid(Router_Hw_io_out_3_valid),
    .io_out_3_bits(Router_Hw_io_out_3_bits),
    .io_out_3_ready(Router_Hw_io_out_3_ready),
    .io_out_4_valid(Router_Hw_io_out_4_valid),
    .io_out_4_bits(Router_Hw_io_out_4_bits),
    .io_out_4_ready(Router_Hw_io_out_4_ready),
    .io_out_4_config(Router_Hw_io_out_4_config)
  );
  Router_Hw_1 Router_Hw_1 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_1_clock),
    .reset(Router_Hw_1_reset),
    .io_in_0_valid(Router_Hw_1_io_in_0_valid),
    .io_in_0_bits(Router_Hw_1_io_in_0_bits),
    .io_in_0_ready(Router_Hw_1_io_in_0_ready),
    .io_in_1_valid(Router_Hw_1_io_in_1_valid),
    .io_in_1_bits(Router_Hw_1_io_in_1_bits),
    .io_in_1_ready(Router_Hw_1_io_in_1_ready),
    .io_in_2_valid(Router_Hw_1_io_in_2_valid),
    .io_in_2_bits(Router_Hw_1_io_in_2_bits),
    .io_in_2_ready(Router_Hw_1_io_in_2_ready),
    .io_in_3_valid(Router_Hw_1_io_in_3_valid),
    .io_in_3_bits(Router_Hw_1_io_in_3_bits),
    .io_in_3_ready(Router_Hw_1_io_in_3_ready),
    .io_in_4_valid(Router_Hw_1_io_in_4_valid),
    .io_in_4_bits(Router_Hw_1_io_in_4_bits),
    .io_in_4_ready(Router_Hw_1_io_in_4_ready),
    .io_in_4_config(Router_Hw_1_io_in_4_config),
    .io_in_5_valid(Router_Hw_1_io_in_5_valid),
    .io_in_5_bits(Router_Hw_1_io_in_5_bits),
    .io_in_5_ready(Router_Hw_1_io_in_5_ready),
    .io_out_0_valid(Router_Hw_1_io_out_0_valid),
    .io_out_0_bits(Router_Hw_1_io_out_0_bits),
    .io_out_0_ready(Router_Hw_1_io_out_0_ready),
    .io_out_1_valid(Router_Hw_1_io_out_1_valid),
    .io_out_1_bits(Router_Hw_1_io_out_1_bits),
    .io_out_1_ready(Router_Hw_1_io_out_1_ready),
    .io_out_2_valid(Router_Hw_1_io_out_2_valid),
    .io_out_2_bits(Router_Hw_1_io_out_2_bits),
    .io_out_2_ready(Router_Hw_1_io_out_2_ready),
    .io_out_3_valid(Router_Hw_1_io_out_3_valid),
    .io_out_3_bits(Router_Hw_1_io_out_3_bits),
    .io_out_3_ready(Router_Hw_1_io_out_3_ready),
    .io_out_3_config(Router_Hw_1_io_out_3_config),
    .io_out_4_valid(Router_Hw_1_io_out_4_valid),
    .io_out_4_bits(Router_Hw_1_io_out_4_bits),
    .io_out_4_ready(Router_Hw_1_io_out_4_ready),
    .io_out_5_valid(Router_Hw_1_io_out_5_valid),
    .io_out_5_bits(Router_Hw_1_io_out_5_bits),
    .io_out_5_ready(Router_Hw_1_io_out_5_ready),
    .io_out_6_valid(Router_Hw_1_io_out_6_valid),
    .io_out_6_bits(Router_Hw_1_io_out_6_bits),
    .io_out_6_ready(Router_Hw_1_io_out_6_ready),
    .io_out_7_valid(Router_Hw_1_io_out_7_valid),
    .io_out_7_bits(Router_Hw_1_io_out_7_bits),
    .io_out_7_ready(Router_Hw_1_io_out_7_ready)
  );
  Router_Hw_2 Router_Hw_2 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_2_clock),
    .reset(Router_Hw_2_reset),
    .io_in_0_valid(Router_Hw_2_io_in_0_valid),
    .io_in_0_bits(Router_Hw_2_io_in_0_bits),
    .io_in_0_ready(Router_Hw_2_io_in_0_ready),
    .io_in_1_valid(Router_Hw_2_io_in_1_valid),
    .io_in_1_bits(Router_Hw_2_io_in_1_bits),
    .io_in_1_ready(Router_Hw_2_io_in_1_ready),
    .io_in_2_valid(Router_Hw_2_io_in_2_valid),
    .io_in_2_bits(Router_Hw_2_io_in_2_bits),
    .io_in_2_ready(Router_Hw_2_io_in_2_ready),
    .io_in_2_config(Router_Hw_2_io_in_2_config),
    .io_in_3_valid(Router_Hw_2_io_in_3_valid),
    .io_in_3_bits(Router_Hw_2_io_in_3_bits),
    .io_in_3_ready(Router_Hw_2_io_in_3_ready),
    .io_out_0_valid(Router_Hw_2_io_out_0_valid),
    .io_out_0_bits(Router_Hw_2_io_out_0_bits),
    .io_out_0_ready(Router_Hw_2_io_out_0_ready),
    .io_out_1_valid(Router_Hw_2_io_out_1_valid),
    .io_out_1_bits(Router_Hw_2_io_out_1_bits),
    .io_out_1_ready(Router_Hw_2_io_out_1_ready),
    .io_out_2_valid(Router_Hw_2_io_out_2_valid),
    .io_out_2_bits(Router_Hw_2_io_out_2_bits),
    .io_out_2_ready(Router_Hw_2_io_out_2_ready),
    .io_out_3_valid(Router_Hw_2_io_out_3_valid),
    .io_out_3_bits(Router_Hw_2_io_out_3_bits),
    .io_out_3_ready(Router_Hw_2_io_out_3_ready),
    .io_out_4_valid(Router_Hw_2_io_out_4_valid),
    .io_out_4_bits(Router_Hw_2_io_out_4_bits),
    .io_out_4_ready(Router_Hw_2_io_out_4_ready),
    .io_out_4_config(Router_Hw_2_io_out_4_config)
  );
  Router_Hw_3 Router_Hw_3 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_3_clock),
    .reset(Router_Hw_3_reset),
    .io_in_0_valid(Router_Hw_3_io_in_0_valid),
    .io_in_0_bits(Router_Hw_3_io_in_0_bits),
    .io_in_0_ready(Router_Hw_3_io_in_0_ready),
    .io_in_1_valid(Router_Hw_3_io_in_1_valid),
    .io_in_1_bits(Router_Hw_3_io_in_1_bits),
    .io_in_1_ready(Router_Hw_3_io_in_1_ready),
    .io_in_2_valid(Router_Hw_3_io_in_2_valid),
    .io_in_2_bits(Router_Hw_3_io_in_2_bits),
    .io_in_2_ready(Router_Hw_3_io_in_2_ready),
    .io_in_3_valid(Router_Hw_3_io_in_3_valid),
    .io_in_3_bits(Router_Hw_3_io_in_3_bits),
    .io_in_3_ready(Router_Hw_3_io_in_3_ready),
    .io_in_4_valid(Router_Hw_3_io_in_4_valid),
    .io_in_4_bits(Router_Hw_3_io_in_4_bits),
    .io_in_4_ready(Router_Hw_3_io_in_4_ready),
    .io_in_4_config(Router_Hw_3_io_in_4_config),
    .io_in_5_valid(Router_Hw_3_io_in_5_valid),
    .io_in_5_bits(Router_Hw_3_io_in_5_bits),
    .io_in_5_ready(Router_Hw_3_io_in_5_ready),
    .io_in_6_valid(Router_Hw_3_io_in_6_valid),
    .io_in_6_bits(Router_Hw_3_io_in_6_bits),
    .io_in_6_ready(Router_Hw_3_io_in_6_ready),
    .io_out_0_valid(Router_Hw_3_io_out_0_valid),
    .io_out_0_bits(Router_Hw_3_io_out_0_bits),
    .io_out_0_ready(Router_Hw_3_io_out_0_ready),
    .io_out_1_valid(Router_Hw_3_io_out_1_valid),
    .io_out_1_bits(Router_Hw_3_io_out_1_bits),
    .io_out_1_ready(Router_Hw_3_io_out_1_ready),
    .io_out_3_valid(Router_Hw_3_io_out_3_valid),
    .io_out_3_bits(Router_Hw_3_io_out_3_bits),
    .io_out_3_ready(Router_Hw_3_io_out_3_ready),
    .io_out_4_valid(Router_Hw_3_io_out_4_valid),
    .io_out_4_bits(Router_Hw_3_io_out_4_bits),
    .io_out_4_ready(Router_Hw_3_io_out_4_ready),
    .io_out_5_valid(Router_Hw_3_io_out_5_valid),
    .io_out_5_bits(Router_Hw_3_io_out_5_bits),
    .io_out_5_ready(Router_Hw_3_io_out_5_ready),
    .io_out_7_valid(Router_Hw_3_io_out_7_valid),
    .io_out_7_bits(Router_Hw_3_io_out_7_bits),
    .io_out_7_ready(Router_Hw_3_io_out_7_ready),
    .io_out_7_config(Router_Hw_3_io_out_7_config)
  );
  Router_Hw_4 Router_Hw_4 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_4_clock),
    .reset(Router_Hw_4_reset),
    .io_in_0_valid(Router_Hw_4_io_in_0_valid),
    .io_in_0_bits(Router_Hw_4_io_in_0_bits),
    .io_in_0_ready(Router_Hw_4_io_in_0_ready),
    .io_in_1_valid(Router_Hw_4_io_in_1_valid),
    .io_in_1_bits(Router_Hw_4_io_in_1_bits),
    .io_in_1_ready(Router_Hw_4_io_in_1_ready),
    .io_in_2_valid(Router_Hw_4_io_in_2_valid),
    .io_in_2_bits(Router_Hw_4_io_in_2_bits),
    .io_in_2_ready(Router_Hw_4_io_in_2_ready),
    .io_in_3_valid(Router_Hw_4_io_in_3_valid),
    .io_in_3_bits(Router_Hw_4_io_in_3_bits),
    .io_in_3_ready(Router_Hw_4_io_in_3_ready),
    .io_in_3_config(Router_Hw_4_io_in_3_config),
    .io_out_0_valid(Router_Hw_4_io_out_0_valid),
    .io_out_0_bits(Router_Hw_4_io_out_0_bits),
    .io_out_0_ready(Router_Hw_4_io_out_0_ready),
    .io_out_1_valid(Router_Hw_4_io_out_1_valid),
    .io_out_1_bits(Router_Hw_4_io_out_1_bits),
    .io_out_1_ready(Router_Hw_4_io_out_1_ready),
    .io_out_3_valid(Router_Hw_4_io_out_3_valid),
    .io_out_3_bits(Router_Hw_4_io_out_3_bits),
    .io_out_3_ready(Router_Hw_4_io_out_3_ready),
    .io_out_4_valid(Router_Hw_4_io_out_4_valid),
    .io_out_4_bits(Router_Hw_4_io_out_4_bits),
    .io_out_4_ready(Router_Hw_4_io_out_4_ready),
    .io_out_5_valid(Router_Hw_4_io_out_5_valid),
    .io_out_5_bits(Router_Hw_4_io_out_5_bits),
    .io_out_5_ready(Router_Hw_4_io_out_5_ready)
  );
  Router_Hw_5 Router_Hw_5 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_5_clock),
    .reset(Router_Hw_5_reset),
    .io_in_0_valid(Router_Hw_5_io_in_0_valid),
    .io_in_0_bits(Router_Hw_5_io_in_0_bits),
    .io_in_0_ready(Router_Hw_5_io_in_0_ready),
    .io_in_1_valid(Router_Hw_5_io_in_1_valid),
    .io_in_1_bits(Router_Hw_5_io_in_1_bits),
    .io_in_1_ready(Router_Hw_5_io_in_1_ready),
    .io_in_2_valid(Router_Hw_5_io_in_2_valid),
    .io_in_2_bits(Router_Hw_5_io_in_2_bits),
    .io_in_2_ready(Router_Hw_5_io_in_2_ready),
    .io_in_3_valid(Router_Hw_5_io_in_3_valid),
    .io_in_3_bits(Router_Hw_5_io_in_3_bits),
    .io_in_3_ready(Router_Hw_5_io_in_3_ready),
    .io_in_3_config(Router_Hw_5_io_in_3_config),
    .io_in_4_valid(Router_Hw_5_io_in_4_valid),
    .io_in_4_bits(Router_Hw_5_io_in_4_bits),
    .io_in_4_ready(Router_Hw_5_io_in_4_ready),
    .io_out_0_valid(Router_Hw_5_io_out_0_valid),
    .io_out_0_bits(Router_Hw_5_io_out_0_bits),
    .io_out_0_ready(Router_Hw_5_io_out_0_ready),
    .io_out_1_valid(Router_Hw_5_io_out_1_valid),
    .io_out_1_bits(Router_Hw_5_io_out_1_bits),
    .io_out_1_ready(Router_Hw_5_io_out_1_ready),
    .io_out_2_valid(Router_Hw_5_io_out_2_valid),
    .io_out_2_bits(Router_Hw_5_io_out_2_bits),
    .io_out_2_ready(Router_Hw_5_io_out_2_ready),
    .io_out_3_valid(Router_Hw_5_io_out_3_valid),
    .io_out_3_bits(Router_Hw_5_io_out_3_bits),
    .io_out_3_ready(Router_Hw_5_io_out_3_ready),
    .io_out_4_valid(Router_Hw_5_io_out_4_valid),
    .io_out_4_bits(Router_Hw_5_io_out_4_bits),
    .io_out_4_ready(Router_Hw_5_io_out_4_ready),
    .io_out_5_valid(Router_Hw_5_io_out_5_valid),
    .io_out_5_bits(Router_Hw_5_io_out_5_bits),
    .io_out_5_ready(Router_Hw_5_io_out_5_ready)
  );
  Router_Hw_6 Router_Hw_6 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_6_clock),
    .reset(Router_Hw_6_reset),
    .io_in_0_valid(Router_Hw_6_io_in_0_valid),
    .io_in_0_bits(Router_Hw_6_io_in_0_bits),
    .io_in_0_ready(Router_Hw_6_io_in_0_ready),
    .io_in_0_config(Router_Hw_6_io_in_0_config),
    .io_in_1_valid(Router_Hw_6_io_in_1_valid),
    .io_in_1_bits(Router_Hw_6_io_in_1_bits),
    .io_in_1_ready(Router_Hw_6_io_in_1_ready),
    .io_in_2_valid(Router_Hw_6_io_in_2_valid),
    .io_in_2_bits(Router_Hw_6_io_in_2_bits),
    .io_in_2_ready(Router_Hw_6_io_in_2_ready),
    .io_in_3_valid(Router_Hw_6_io_in_3_valid),
    .io_in_3_bits(Router_Hw_6_io_in_3_bits),
    .io_in_3_ready(Router_Hw_6_io_in_3_ready),
    .io_out_0_valid(Router_Hw_6_io_out_0_valid),
    .io_out_0_bits(Router_Hw_6_io_out_0_bits),
    .io_out_0_ready(Router_Hw_6_io_out_0_ready),
    .io_out_1_valid(Router_Hw_6_io_out_1_valid),
    .io_out_1_bits(Router_Hw_6_io_out_1_bits),
    .io_out_1_ready(Router_Hw_6_io_out_1_ready),
    .io_out_1_config(Router_Hw_6_io_out_1_config),
    .io_out_2_valid(Router_Hw_6_io_out_2_valid),
    .io_out_2_bits(Router_Hw_6_io_out_2_bits),
    .io_out_2_ready(Router_Hw_6_io_out_2_ready),
    .io_out_3_valid(Router_Hw_6_io_out_3_valid),
    .io_out_3_bits(Router_Hw_6_io_out_3_bits),
    .io_out_3_ready(Router_Hw_6_io_out_3_ready),
    .io_out_4_valid(Router_Hw_6_io_out_4_valid),
    .io_out_4_bits(Router_Hw_6_io_out_4_bits),
    .io_out_4_ready(Router_Hw_6_io_out_4_ready)
  );
  Router_Hw_7 Router_Hw_7 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_7_clock),
    .reset(Router_Hw_7_reset),
    .io_in_0_valid(Router_Hw_7_io_in_0_valid),
    .io_in_0_bits(Router_Hw_7_io_in_0_bits),
    .io_in_0_ready(Router_Hw_7_io_in_0_ready),
    .io_in_1_valid(Router_Hw_7_io_in_1_valid),
    .io_in_1_bits(Router_Hw_7_io_in_1_bits),
    .io_in_1_ready(Router_Hw_7_io_in_1_ready),
    .io_in_2_valid(Router_Hw_7_io_in_2_valid),
    .io_in_2_bits(Router_Hw_7_io_in_2_bits),
    .io_in_2_ready(Router_Hw_7_io_in_2_ready),
    .io_in_2_config(Router_Hw_7_io_in_2_config),
    .io_in_3_valid(Router_Hw_7_io_in_3_valid),
    .io_in_3_bits(Router_Hw_7_io_in_3_bits),
    .io_in_3_ready(Router_Hw_7_io_in_3_ready),
    .io_out_0_valid(Router_Hw_7_io_out_0_valid),
    .io_out_0_bits(Router_Hw_7_io_out_0_bits),
    .io_out_0_ready(Router_Hw_7_io_out_0_ready),
    .io_out_1_valid(Router_Hw_7_io_out_1_valid),
    .io_out_1_bits(Router_Hw_7_io_out_1_bits),
    .io_out_1_ready(Router_Hw_7_io_out_1_ready),
    .io_out_2_valid(Router_Hw_7_io_out_2_valid),
    .io_out_2_bits(Router_Hw_7_io_out_2_bits),
    .io_out_2_ready(Router_Hw_7_io_out_2_ready),
    .io_out_3_valid(Router_Hw_7_io_out_3_valid),
    .io_out_3_bits(Router_Hw_7_io_out_3_bits),
    .io_out_3_ready(Router_Hw_7_io_out_3_ready),
    .io_out_4_valid(Router_Hw_7_io_out_4_valid),
    .io_out_4_bits(Router_Hw_7_io_out_4_bits),
    .io_out_4_ready(Router_Hw_7_io_out_4_ready),
    .io_out_4_config(Router_Hw_7_io_out_4_config)
  );
  Router_Hw_8 Router_Hw_8 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_8_clock),
    .io_in_0_valid(Router_Hw_8_io_in_0_valid),
    .io_in_0_bits(Router_Hw_8_io_in_0_bits),
    .io_in_0_ready(Router_Hw_8_io_in_0_ready),
    .io_out_1_valid(Router_Hw_8_io_out_1_valid),
    .io_out_1_bits(Router_Hw_8_io_out_1_bits),
    .io_out_1_ready(Router_Hw_8_io_out_1_ready),
    .io_out_2_valid(Router_Hw_8_io_out_2_valid),
    .io_out_2_bits(Router_Hw_8_io_out_2_bits),
    .io_out_2_ready(Router_Hw_8_io_out_2_ready),
    .io_out_3_valid(Router_Hw_8_io_out_3_valid),
    .io_out_3_bits(Router_Hw_8_io_out_3_bits),
    .io_out_3_ready(Router_Hw_8_io_out_3_ready)
  );
  Router_Hw_9 Router_Hw_9 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_9_clock),
    .reset(Router_Hw_9_reset),
    .io_in_0_valid(Router_Hw_9_io_in_0_valid),
    .io_in_0_bits(Router_Hw_9_io_in_0_bits),
    .io_in_0_ready(Router_Hw_9_io_in_0_ready),
    .io_in_1_valid(Router_Hw_9_io_in_1_valid),
    .io_in_1_bits(Router_Hw_9_io_in_1_bits),
    .io_in_1_ready(Router_Hw_9_io_in_1_ready),
    .io_in_2_valid(Router_Hw_9_io_in_2_valid),
    .io_in_2_bits(Router_Hw_9_io_in_2_bits),
    .io_in_2_ready(Router_Hw_9_io_in_2_ready),
    .io_in_3_valid(Router_Hw_9_io_in_3_valid),
    .io_in_3_bits(Router_Hw_9_io_in_3_bits),
    .io_in_3_ready(Router_Hw_9_io_in_3_ready),
    .io_in_4_valid(Router_Hw_9_io_in_4_valid),
    .io_in_4_bits(Router_Hw_9_io_in_4_bits),
    .io_in_4_ready(Router_Hw_9_io_in_4_ready),
    .io_in_4_config(Router_Hw_9_io_in_4_config),
    .io_out_0_valid(Router_Hw_9_io_out_0_valid),
    .io_out_0_bits(Router_Hw_9_io_out_0_bits),
    .io_out_0_ready(Router_Hw_9_io_out_0_ready),
    .io_out_1_valid(Router_Hw_9_io_out_1_valid),
    .io_out_1_bits(Router_Hw_9_io_out_1_bits),
    .io_out_1_ready(Router_Hw_9_io_out_1_ready),
    .io_out_2_valid(Router_Hw_9_io_out_2_valid),
    .io_out_2_bits(Router_Hw_9_io_out_2_bits),
    .io_out_2_ready(Router_Hw_9_io_out_2_ready),
    .io_out_3_valid(Router_Hw_9_io_out_3_valid),
    .io_out_3_bits(Router_Hw_9_io_out_3_bits),
    .io_out_3_ready(Router_Hw_9_io_out_3_ready),
    .io_out_3_config(Router_Hw_9_io_out_3_config),
    .io_out_4_valid(Router_Hw_9_io_out_4_valid),
    .io_out_4_bits(Router_Hw_9_io_out_4_bits),
    .io_out_4_ready(Router_Hw_9_io_out_4_ready),
    .io_out_5_valid(Router_Hw_9_io_out_5_valid),
    .io_out_5_bits(Router_Hw_9_io_out_5_bits),
    .io_out_5_ready(Router_Hw_9_io_out_5_ready),
    .io_out_6_valid(Router_Hw_9_io_out_6_valid),
    .io_out_6_bits(Router_Hw_9_io_out_6_bits),
    .io_out_6_ready(Router_Hw_9_io_out_6_ready),
    .io_out_7_valid(Router_Hw_9_io_out_7_valid),
    .io_out_7_bits(Router_Hw_9_io_out_7_bits),
    .io_out_7_ready(Router_Hw_9_io_out_7_ready)
  );
  Router_Hw_10 Router_Hw_10 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_10_clock),
    .io_in_0_valid(Router_Hw_10_io_in_0_valid),
    .io_in_0_bits(Router_Hw_10_io_in_0_bits),
    .io_in_0_ready(Router_Hw_10_io_in_0_ready),
    .io_out_0_valid(Router_Hw_10_io_out_0_valid),
    .io_out_0_bits(Router_Hw_10_io_out_0_bits),
    .io_out_0_ready(Router_Hw_10_io_out_0_ready),
    .io_out_1_valid(Router_Hw_10_io_out_1_valid),
    .io_out_1_bits(Router_Hw_10_io_out_1_bits),
    .io_out_1_ready(Router_Hw_10_io_out_1_ready),
    .io_out_2_valid(Router_Hw_10_io_out_2_valid),
    .io_out_2_bits(Router_Hw_10_io_out_2_bits),
    .io_out_2_ready(Router_Hw_10_io_out_2_ready),
    .io_out_3_valid(Router_Hw_10_io_out_3_valid),
    .io_out_3_bits(Router_Hw_10_io_out_3_bits),
    .io_out_3_ready(Router_Hw_10_io_out_3_ready)
  );
  Router_Hw_11 Router_Hw_11 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_11_clock),
    .reset(Router_Hw_11_reset),
    .io_in_0_valid(Router_Hw_11_io_in_0_valid),
    .io_in_0_bits(Router_Hw_11_io_in_0_bits),
    .io_in_0_ready(Router_Hw_11_io_in_0_ready),
    .io_in_1_valid(Router_Hw_11_io_in_1_valid),
    .io_in_1_bits(Router_Hw_11_io_in_1_bits),
    .io_in_1_ready(Router_Hw_11_io_in_1_ready),
    .io_in_2_valid(Router_Hw_11_io_in_2_valid),
    .io_in_2_bits(Router_Hw_11_io_in_2_bits),
    .io_in_2_ready(Router_Hw_11_io_in_2_ready),
    .io_in_3_valid(Router_Hw_11_io_in_3_valid),
    .io_in_3_bits(Router_Hw_11_io_in_3_bits),
    .io_in_3_ready(Router_Hw_11_io_in_3_ready),
    .io_in_4_valid(Router_Hw_11_io_in_4_valid),
    .io_in_4_bits(Router_Hw_11_io_in_4_bits),
    .io_in_4_ready(Router_Hw_11_io_in_4_ready),
    .io_in_4_config(Router_Hw_11_io_in_4_config),
    .io_in_5_valid(Router_Hw_11_io_in_5_valid),
    .io_in_5_bits(Router_Hw_11_io_in_5_bits),
    .io_in_5_ready(Router_Hw_11_io_in_5_ready),
    .io_out_0_valid(Router_Hw_11_io_out_0_valid),
    .io_out_0_bits(Router_Hw_11_io_out_0_bits),
    .io_out_0_ready(Router_Hw_11_io_out_0_ready),
    .io_out_1_valid(Router_Hw_11_io_out_1_valid),
    .io_out_1_bits(Router_Hw_11_io_out_1_bits),
    .io_out_1_ready(Router_Hw_11_io_out_1_ready),
    .io_out_2_valid(Router_Hw_11_io_out_2_valid),
    .io_out_2_bits(Router_Hw_11_io_out_2_bits),
    .io_out_2_ready(Router_Hw_11_io_out_2_ready),
    .io_out_3_valid(Router_Hw_11_io_out_3_valid),
    .io_out_3_bits(Router_Hw_11_io_out_3_bits),
    .io_out_3_ready(Router_Hw_11_io_out_3_ready),
    .io_out_4_valid(Router_Hw_11_io_out_4_valid),
    .io_out_4_bits(Router_Hw_11_io_out_4_bits),
    .io_out_4_ready(Router_Hw_11_io_out_4_ready),
    .io_out_5_valid(Router_Hw_11_io_out_5_valid),
    .io_out_5_bits(Router_Hw_11_io_out_5_bits),
    .io_out_5_ready(Router_Hw_11_io_out_5_ready),
    .io_out_7_valid(Router_Hw_11_io_out_7_valid),
    .io_out_7_bits(Router_Hw_11_io_out_7_bits),
    .io_out_7_ready(Router_Hw_11_io_out_7_ready),
    .io_out_7_config(Router_Hw_11_io_out_7_config)
  );
  Router_Hw_12 Router_Hw_12 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_12_clock),
    .io_in_0_valid(Router_Hw_12_io_in_0_valid),
    .io_in_0_bits(Router_Hw_12_io_in_0_bits),
    .io_in_0_ready(Router_Hw_12_io_in_0_ready),
    .io_out_0_valid(Router_Hw_12_io_out_0_valid),
    .io_out_0_bits(Router_Hw_12_io_out_0_bits),
    .io_out_0_ready(Router_Hw_12_io_out_0_ready),
    .io_out_1_valid(Router_Hw_12_io_out_1_valid),
    .io_out_1_bits(Router_Hw_12_io_out_1_bits),
    .io_out_1_ready(Router_Hw_12_io_out_1_ready),
    .io_out_2_valid(Router_Hw_12_io_out_2_valid),
    .io_out_2_bits(Router_Hw_12_io_out_2_bits),
    .io_out_2_ready(Router_Hw_12_io_out_2_ready),
    .io_out_3_valid(Router_Hw_12_io_out_3_valid),
    .io_out_3_bits(Router_Hw_12_io_out_3_bits),
    .io_out_3_ready(Router_Hw_12_io_out_3_ready),
    .io_out_4_valid(Router_Hw_12_io_out_4_valid),
    .io_out_4_bits(Router_Hw_12_io_out_4_bits),
    .io_out_4_ready(Router_Hw_12_io_out_4_ready),
    .io_out_5_valid(Router_Hw_12_io_out_5_valid),
    .io_out_5_bits(Router_Hw_12_io_out_5_bits),
    .io_out_5_ready(Router_Hw_12_io_out_5_ready)
  );
  Router_Hw_13 Router_Hw_13 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_13_clock),
    .reset(Router_Hw_13_reset),
    .io_in_0_valid(Router_Hw_13_io_in_0_valid),
    .io_in_0_bits(Router_Hw_13_io_in_0_bits),
    .io_in_0_ready(Router_Hw_13_io_in_0_ready),
    .io_in_1_valid(Router_Hw_13_io_in_1_valid),
    .io_in_1_bits(Router_Hw_13_io_in_1_bits),
    .io_in_1_ready(Router_Hw_13_io_in_1_ready),
    .io_in_2_valid(Router_Hw_13_io_in_2_valid),
    .io_in_2_bits(Router_Hw_13_io_in_2_bits),
    .io_in_2_ready(Router_Hw_13_io_in_2_ready),
    .io_in_2_config(Router_Hw_13_io_in_2_config),
    .io_out_0_valid(Router_Hw_13_io_out_0_valid),
    .io_out_0_bits(Router_Hw_13_io_out_0_bits),
    .io_out_0_ready(Router_Hw_13_io_out_0_ready),
    .io_out_1_valid(Router_Hw_13_io_out_1_valid),
    .io_out_1_bits(Router_Hw_13_io_out_1_bits),
    .io_out_1_ready(Router_Hw_13_io_out_1_ready),
    .io_out_2_valid(Router_Hw_13_io_out_2_valid),
    .io_out_2_bits(Router_Hw_13_io_out_2_bits),
    .io_out_2_ready(Router_Hw_13_io_out_2_ready),
    .io_out_2_config(Router_Hw_13_io_out_2_config)
  );
  Router_Hw_14 Router_Hw_14 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_14_clock),
    .reset(Router_Hw_14_reset),
    .io_in_0_valid(Router_Hw_14_io_in_0_valid),
    .io_in_0_bits(Router_Hw_14_io_in_0_bits),
    .io_in_0_ready(Router_Hw_14_io_in_0_ready),
    .io_in_0_config(Router_Hw_14_io_in_0_config),
    .io_in_1_valid(Router_Hw_14_io_in_1_valid),
    .io_in_1_bits(Router_Hw_14_io_in_1_bits),
    .io_in_1_ready(Router_Hw_14_io_in_1_ready),
    .io_in_2_valid(Router_Hw_14_io_in_2_valid),
    .io_in_2_bits(Router_Hw_14_io_in_2_bits),
    .io_in_2_ready(Router_Hw_14_io_in_2_ready),
    .io_out_0_valid(Router_Hw_14_io_out_0_valid),
    .io_out_0_bits(Router_Hw_14_io_out_0_bits),
    .io_out_0_ready(Router_Hw_14_io_out_0_ready),
    .io_out_1_valid(Router_Hw_14_io_out_1_valid),
    .io_out_1_bits(Router_Hw_14_io_out_1_bits),
    .io_out_1_ready(Router_Hw_14_io_out_1_ready),
    .io_out_2_valid(Router_Hw_14_io_out_2_valid),
    .io_out_2_bits(Router_Hw_14_io_out_2_bits),
    .io_out_2_ready(Router_Hw_14_io_out_2_ready),
    .io_out_2_config(Router_Hw_14_io_out_2_config)
  );
  Router_Hw_15 Router_Hw_15 ( // @[Cgra_Hw.scala 38:51]
    .clock(Router_Hw_15_clock),
    .reset(Router_Hw_15_reset),
    .io_in_0_valid(Router_Hw_15_io_in_0_valid),
    .io_in_0_bits(Router_Hw_15_io_in_0_bits),
    .io_in_0_ready(Router_Hw_15_io_in_0_ready),
    .io_in_1_valid(Router_Hw_15_io_in_1_valid),
    .io_in_1_bits(Router_Hw_15_io_in_1_bits),
    .io_in_1_ready(Router_Hw_15_io_in_1_ready),
    .io_in_2_valid(Router_Hw_15_io_in_2_valid),
    .io_in_2_bits(Router_Hw_15_io_in_2_bits),
    .io_in_2_ready(Router_Hw_15_io_in_2_ready),
    .io_in_3_valid(Router_Hw_15_io_in_3_valid),
    .io_in_3_bits(Router_Hw_15_io_in_3_bits),
    .io_in_3_ready(Router_Hw_15_io_in_3_ready),
    .io_in_3_config(Router_Hw_15_io_in_3_config),
    .io_in_4_valid(Router_Hw_15_io_in_4_valid),
    .io_in_4_bits(Router_Hw_15_io_in_4_bits),
    .io_in_4_ready(Router_Hw_15_io_in_4_ready),
    .io_out_0_valid(Router_Hw_15_io_out_0_valid),
    .io_out_0_bits(Router_Hw_15_io_out_0_bits),
    .io_out_0_ready(Router_Hw_15_io_out_0_ready),
    .io_out_2_valid(Router_Hw_15_io_out_2_valid),
    .io_out_2_bits(Router_Hw_15_io_out_2_bits),
    .io_out_2_ready(Router_Hw_15_io_out_2_ready),
    .io_out_3_valid(Router_Hw_15_io_out_3_valid),
    .io_out_3_bits(Router_Hw_15_io_out_3_bits),
    .io_out_3_ready(Router_Hw_15_io_out_3_ready),
    .io_out_4_valid(Router_Hw_15_io_out_4_valid),
    .io_out_4_bits(Router_Hw_15_io_out_4_bits),
    .io_out_4_ready(Router_Hw_15_io_out_4_ready),
    .io_out_5_valid(Router_Hw_15_io_out_5_valid),
    .io_out_5_bits(Router_Hw_15_io_out_5_bits),
    .io_out_5_ready(Router_Hw_15_io_out_5_ready)
  );
  Dedicated_PE_Hw Dedicated_PE_Hw ( // @[Cgra_Hw.scala 43:66]
    .clock(Dedicated_PE_Hw_clock),
    .reset(Dedicated_PE_Hw_reset),
    .io_in_0_valid(Dedicated_PE_Hw_io_in_0_valid),
    .io_in_0_bits(Dedicated_PE_Hw_io_in_0_bits),
    .io_in_0_ready(Dedicated_PE_Hw_io_in_0_ready),
    .io_in_0_config(Dedicated_PE_Hw_io_in_0_config),
    .io_in_1_valid(Dedicated_PE_Hw_io_in_1_valid),
    .io_in_1_bits(Dedicated_PE_Hw_io_in_1_bits),
    .io_in_1_ready(Dedicated_PE_Hw_io_in_1_ready),
    .io_in_2_valid(Dedicated_PE_Hw_io_in_2_valid),
    .io_in_2_bits(Dedicated_PE_Hw_io_in_2_bits),
    .io_in_2_ready(Dedicated_PE_Hw_io_in_2_ready),
    .io_in_3_valid(Dedicated_PE_Hw_io_in_3_valid),
    .io_in_3_bits(Dedicated_PE_Hw_io_in_3_bits),
    .io_in_3_ready(Dedicated_PE_Hw_io_in_3_ready),
    .io_out_0_valid(Dedicated_PE_Hw_io_out_0_valid),
    .io_out_0_bits(Dedicated_PE_Hw_io_out_0_bits),
    .io_out_0_ready(Dedicated_PE_Hw_io_out_0_ready),
    .io_out_0_config(Dedicated_PE_Hw_io_out_0_config)
  );
  Dedicated_PE_Hw_1 Dedicated_PE_Hw_1 ( // @[Cgra_Hw.scala 43:66]
    .clock(Dedicated_PE_Hw_1_clock),
    .reset(Dedicated_PE_Hw_1_reset),
    .io_in_0_valid(Dedicated_PE_Hw_1_io_in_0_valid),
    .io_in_0_bits(Dedicated_PE_Hw_1_io_in_0_bits),
    .io_in_0_ready(Dedicated_PE_Hw_1_io_in_0_ready),
    .io_in_1_valid(Dedicated_PE_Hw_1_io_in_1_valid),
    .io_in_1_bits(Dedicated_PE_Hw_1_io_in_1_bits),
    .io_in_1_ready(Dedicated_PE_Hw_1_io_in_1_ready),
    .io_in_1_config(Dedicated_PE_Hw_1_io_in_1_config),
    .io_in_2_valid(Dedicated_PE_Hw_1_io_in_2_valid),
    .io_in_2_bits(Dedicated_PE_Hw_1_io_in_2_bits),
    .io_in_2_ready(Dedicated_PE_Hw_1_io_in_2_ready),
    .io_in_3_valid(Dedicated_PE_Hw_1_io_in_3_valid),
    .io_in_3_bits(Dedicated_PE_Hw_1_io_in_3_bits),
    .io_in_3_ready(Dedicated_PE_Hw_1_io_in_3_ready),
    .io_out_0_valid(Dedicated_PE_Hw_1_io_out_0_valid),
    .io_out_0_bits(Dedicated_PE_Hw_1_io_out_0_bits),
    .io_out_0_ready(Dedicated_PE_Hw_1_io_out_0_ready),
    .io_out_0_config(Dedicated_PE_Hw_1_io_out_0_config)
  );
  Dedicated_PE_Hw_2 Dedicated_PE_Hw_2 ( // @[Cgra_Hw.scala 43:66]
    .clock(Dedicated_PE_Hw_2_clock),
    .reset(Dedicated_PE_Hw_2_reset),
    .io_in_0_valid(Dedicated_PE_Hw_2_io_in_0_valid),
    .io_in_0_bits(Dedicated_PE_Hw_2_io_in_0_bits),
    .io_in_0_ready(Dedicated_PE_Hw_2_io_in_0_ready),
    .io_in_1_valid(Dedicated_PE_Hw_2_io_in_1_valid),
    .io_in_1_bits(Dedicated_PE_Hw_2_io_in_1_bits),
    .io_in_1_ready(Dedicated_PE_Hw_2_io_in_1_ready),
    .io_in_1_config(Dedicated_PE_Hw_2_io_in_1_config),
    .io_in_2_valid(Dedicated_PE_Hw_2_io_in_2_valid),
    .io_in_2_bits(Dedicated_PE_Hw_2_io_in_2_bits),
    .io_in_2_ready(Dedicated_PE_Hw_2_io_in_2_ready),
    .io_in_3_valid(Dedicated_PE_Hw_2_io_in_3_valid),
    .io_in_3_bits(Dedicated_PE_Hw_2_io_in_3_bits),
    .io_in_3_ready(Dedicated_PE_Hw_2_io_in_3_ready),
    .io_out_0_valid(Dedicated_PE_Hw_2_io_out_0_valid),
    .io_out_0_bits(Dedicated_PE_Hw_2_io_out_0_bits),
    .io_out_0_ready(Dedicated_PE_Hw_2_io_out_0_ready),
    .io_out_0_config(Dedicated_PE_Hw_2_io_out_0_config),
    .io_out_1_valid(Dedicated_PE_Hw_2_io_out_1_valid),
    .io_out_1_bits(Dedicated_PE_Hw_2_io_out_1_bits),
    .io_out_1_ready(Dedicated_PE_Hw_2_io_out_1_ready)
  );
  Dedicated_PE_Hw_3 Dedicated_PE_Hw_3 ( // @[Cgra_Hw.scala 43:66]
    .clock(Dedicated_PE_Hw_3_clock),
    .reset(Dedicated_PE_Hw_3_reset),
    .io_in_0_valid(Dedicated_PE_Hw_3_io_in_0_valid),
    .io_in_0_bits(Dedicated_PE_Hw_3_io_in_0_bits),
    .io_in_0_ready(Dedicated_PE_Hw_3_io_in_0_ready),
    .io_in_1_valid(Dedicated_PE_Hw_3_io_in_1_valid),
    .io_in_1_bits(Dedicated_PE_Hw_3_io_in_1_bits),
    .io_in_1_ready(Dedicated_PE_Hw_3_io_in_1_ready),
    .io_in_1_config(Dedicated_PE_Hw_3_io_in_1_config),
    .io_in_2_valid(Dedicated_PE_Hw_3_io_in_2_valid),
    .io_in_2_bits(Dedicated_PE_Hw_3_io_in_2_bits),
    .io_in_2_ready(Dedicated_PE_Hw_3_io_in_2_ready),
    .io_in_3_valid(Dedicated_PE_Hw_3_io_in_3_valid),
    .io_in_3_bits(Dedicated_PE_Hw_3_io_in_3_bits),
    .io_in_3_ready(Dedicated_PE_Hw_3_io_in_3_ready),
    .io_out_0_valid(Dedicated_PE_Hw_3_io_out_0_valid),
    .io_out_0_bits(Dedicated_PE_Hw_3_io_out_0_bits),
    .io_out_0_ready(Dedicated_PE_Hw_3_io_out_0_ready),
    .io_out_0_config(Dedicated_PE_Hw_3_io_out_0_config)
  );
  Dedicated_PE_Hw_4 Dedicated_PE_Hw_4 ( // @[Cgra_Hw.scala 43:66]
    .clock(Dedicated_PE_Hw_4_clock),
    .reset(Dedicated_PE_Hw_4_reset),
    .io_in_0_valid(Dedicated_PE_Hw_4_io_in_0_valid),
    .io_in_0_bits(Dedicated_PE_Hw_4_io_in_0_bits),
    .io_in_0_ready(Dedicated_PE_Hw_4_io_in_0_ready),
    .io_in_1_valid(Dedicated_PE_Hw_4_io_in_1_valid),
    .io_in_1_bits(Dedicated_PE_Hw_4_io_in_1_bits),
    .io_in_1_ready(Dedicated_PE_Hw_4_io_in_1_ready),
    .io_in_1_config(Dedicated_PE_Hw_4_io_in_1_config),
    .io_in_2_valid(Dedicated_PE_Hw_4_io_in_2_valid),
    .io_in_2_bits(Dedicated_PE_Hw_4_io_in_2_bits),
    .io_in_2_ready(Dedicated_PE_Hw_4_io_in_2_ready),
    .io_in_3_valid(Dedicated_PE_Hw_4_io_in_3_valid),
    .io_in_3_bits(Dedicated_PE_Hw_4_io_in_3_bits),
    .io_in_3_ready(Dedicated_PE_Hw_4_io_in_3_ready),
    .io_out_0_valid(Dedicated_PE_Hw_4_io_out_0_valid),
    .io_out_0_bits(Dedicated_PE_Hw_4_io_out_0_bits),
    .io_out_0_ready(Dedicated_PE_Hw_4_io_out_0_ready),
    .io_out_0_config(Dedicated_PE_Hw_4_io_out_0_config)
  );
  Dedicated_PE_Hw_5 Dedicated_PE_Hw_5 ( // @[Cgra_Hw.scala 43:66]
    .clock(Dedicated_PE_Hw_5_clock),
    .reset(Dedicated_PE_Hw_5_reset),
    .io_in_0_valid(Dedicated_PE_Hw_5_io_in_0_valid),
    .io_in_0_bits(Dedicated_PE_Hw_5_io_in_0_bits),
    .io_in_0_ready(Dedicated_PE_Hw_5_io_in_0_ready),
    .io_in_0_config(Dedicated_PE_Hw_5_io_in_0_config),
    .io_in_1_valid(Dedicated_PE_Hw_5_io_in_1_valid),
    .io_in_1_bits(Dedicated_PE_Hw_5_io_in_1_bits),
    .io_in_1_ready(Dedicated_PE_Hw_5_io_in_1_ready),
    .io_in_2_valid(Dedicated_PE_Hw_5_io_in_2_valid),
    .io_in_2_bits(Dedicated_PE_Hw_5_io_in_2_bits),
    .io_in_2_ready(Dedicated_PE_Hw_5_io_in_2_ready),
    .io_in_3_valid(Dedicated_PE_Hw_5_io_in_3_valid),
    .io_in_3_bits(Dedicated_PE_Hw_5_io_in_3_bits),
    .io_in_3_ready(Dedicated_PE_Hw_5_io_in_3_ready),
    .io_out_0_valid(Dedicated_PE_Hw_5_io_out_0_valid),
    .io_out_0_bits(Dedicated_PE_Hw_5_io_out_0_bits),
    .io_out_0_ready(Dedicated_PE_Hw_5_io_out_0_ready),
    .io_out_0_config(Dedicated_PE_Hw_5_io_out_0_config)
  );
  Dedicated_PE_Hw_6 Dedicated_PE_Hw_6 ( // @[Cgra_Hw.scala 43:66]
    .clock(Dedicated_PE_Hw_6_clock),
    .reset(Dedicated_PE_Hw_6_reset),
    .io_in_0_valid(Dedicated_PE_Hw_6_io_in_0_valid),
    .io_in_0_bits(Dedicated_PE_Hw_6_io_in_0_bits),
    .io_in_0_ready(Dedicated_PE_Hw_6_io_in_0_ready),
    .io_in_0_config(Dedicated_PE_Hw_6_io_in_0_config),
    .io_in_1_valid(Dedicated_PE_Hw_6_io_in_1_valid),
    .io_in_1_bits(Dedicated_PE_Hw_6_io_in_1_bits),
    .io_in_1_ready(Dedicated_PE_Hw_6_io_in_1_ready),
    .io_in_2_valid(Dedicated_PE_Hw_6_io_in_2_valid),
    .io_in_2_bits(Dedicated_PE_Hw_6_io_in_2_bits),
    .io_in_2_ready(Dedicated_PE_Hw_6_io_in_2_ready),
    .io_in_3_valid(Dedicated_PE_Hw_6_io_in_3_valid),
    .io_in_3_bits(Dedicated_PE_Hw_6_io_in_3_bits),
    .io_in_3_ready(Dedicated_PE_Hw_6_io_in_3_ready),
    .io_out_0_valid(Dedicated_PE_Hw_6_io_out_0_valid),
    .io_out_0_bits(Dedicated_PE_Hw_6_io_out_0_bits),
    .io_out_0_ready(Dedicated_PE_Hw_6_io_out_0_ready),
    .io_out_0_config(Dedicated_PE_Hw_6_io_out_0_config)
  );
  Shared_PE_Hw Shared_PE_Hw ( // @[Cgra_Hw.scala 48:60]
    .io_in_1_valid(Shared_PE_Hw_io_in_1_valid),
    .io_in_1_bits(Shared_PE_Hw_io_in_1_bits),
    .io_in_1_ready(Shared_PE_Hw_io_in_1_ready),
    .io_in_2_valid(Shared_PE_Hw_io_in_2_valid),
    .io_in_2_bits(Shared_PE_Hw_io_in_2_bits),
    .io_in_2_ready(Shared_PE_Hw_io_in_2_ready),
    .io_in_3_valid(Shared_PE_Hw_io_in_3_valid),
    .io_in_3_bits(Shared_PE_Hw_io_in_3_bits),
    .io_in_3_ready(Shared_PE_Hw_io_in_3_ready),
    .io_out_0_valid(Shared_PE_Hw_io_out_0_valid),
    .io_out_0_bits(Shared_PE_Hw_io_out_0_bits),
    .io_out_0_ready(Shared_PE_Hw_io_out_0_ready),
    .io_out_1_valid(Shared_PE_Hw_io_out_1_valid),
    .io_out_1_bits(Shared_PE_Hw_io_out_1_bits),
    .io_out_1_ready(Shared_PE_Hw_io_out_1_ready),
    .io_out_2_valid(Shared_PE_Hw_io_out_2_valid),
    .io_out_2_bits(Shared_PE_Hw_io_out_2_bits),
    .io_out_2_ready(Shared_PE_Hw_io_out_2_ready)
  );
  Shared_PE_Hw Shared_PE_Hw_1 ( // @[Cgra_Hw.scala 48:60]
    .io_in_1_valid(Shared_PE_Hw_1_io_in_1_valid),
    .io_in_1_bits(Shared_PE_Hw_1_io_in_1_bits),
    .io_in_1_ready(Shared_PE_Hw_1_io_in_1_ready),
    .io_in_2_valid(Shared_PE_Hw_1_io_in_2_valid),
    .io_in_2_bits(Shared_PE_Hw_1_io_in_2_bits),
    .io_in_2_ready(Shared_PE_Hw_1_io_in_2_ready),
    .io_in_3_valid(Shared_PE_Hw_1_io_in_3_valid),
    .io_in_3_bits(Shared_PE_Hw_1_io_in_3_bits),
    .io_in_3_ready(Shared_PE_Hw_1_io_in_3_ready),
    .io_out_0_valid(Shared_PE_Hw_1_io_out_0_valid),
    .io_out_0_bits(Shared_PE_Hw_1_io_out_0_bits),
    .io_out_0_ready(Shared_PE_Hw_1_io_out_0_ready),
    .io_out_1_valid(Shared_PE_Hw_1_io_out_1_valid),
    .io_out_1_bits(Shared_PE_Hw_1_io_out_1_bits),
    .io_out_1_ready(Shared_PE_Hw_1_io_out_1_ready),
    .io_out_2_valid(Shared_PE_Hw_1_io_out_2_valid),
    .io_out_2_bits(Shared_PE_Hw_1_io_out_2_bits),
    .io_out_2_ready(Shared_PE_Hw_1_io_out_2_ready)
  );
  assign io_in_0_ready = VectorPort_Hw_1_io_in_0_ready; // @[Cgra_Hw.scala 78:47]
  assign io_in_1_ready = VectorPort_Hw_io_in_0_ready; // @[Cgra_Hw.scala 78:47]
  assign io_out_0_valid = VectorPort_Hw_3_io_out_0_valid; // @[Cgra_Hw.scala 80:48]
  assign io_out_0_bits = VectorPort_Hw_3_io_out_0_bits; // @[Cgra_Hw.scala 80:48]
  assign io_out_0_config = 1'h0; // @[Cgra_Hw.scala 80:48]
  assign io_out_1_valid = VectorPort_Hw_2_io_out_0_valid; // @[Cgra_Hw.scala 80:48]
  assign io_out_1_bits = VectorPort_Hw_2_io_out_0_bits; // @[Cgra_Hw.scala 80:48]
  assign io_out_1_config = 1'h0; // @[Cgra_Hw.scala 80:48]
  assign VectorPort_Hw_clock = clock;
  assign VectorPort_Hw_reset = reset;
  assign VectorPort_Hw_io_in_0_valid = io_in_1_valid; // @[Cgra_Hw.scala 78:47]
  assign VectorPort_Hw_io_in_0_bits = io_in_1_bits; // @[Cgra_Hw.scala 78:47]
  assign VectorPort_Hw_io_in_0_config = io_in_1_config; // @[Cgra_Hw.scala 78:47]
  assign VectorPort_Hw_io_out_0_ready = Router_Hw_13_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_io_out_1_ready = Router_Hw_7_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_io_out_2_ready = Router_Hw_2_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_1_clock = clock;
  assign VectorPort_Hw_1_reset = reset;
  assign VectorPort_Hw_1_io_in_0_valid = io_in_0_valid; // @[Cgra_Hw.scala 78:47]
  assign VectorPort_Hw_1_io_in_0_bits = io_in_0_bits; // @[Cgra_Hw.scala 78:47]
  assign VectorPort_Hw_1_io_in_0_config = io_in_0_config; // @[Cgra_Hw.scala 78:47]
  assign VectorPort_Hw_1_io_out_0_ready = Router_Hw_6_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_1_io_out_1_ready = Router_Hw_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_1_io_out_2_ready = Router_Hw_14_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_2_clock = clock;
  assign VectorPort_Hw_2_reset = reset;
  assign VectorPort_Hw_2_io_in_0_valid = Router_Hw_10_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_2_io_in_0_bits = Router_Hw_10_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_2_io_in_1_valid = Router_Hw_4_io_out_5_valid; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_2_io_in_1_bits = Router_Hw_4_io_out_5_bits; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_2_io_in_2_valid = Router_Hw_15_io_out_5_valid; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_2_io_in_2_bits = Router_Hw_15_io_out_5_bits; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_2_io_out_0_ready = io_out_1_ready; // @[Cgra_Hw.scala 80:48]
  assign VectorPort_Hw_3_clock = clock;
  assign VectorPort_Hw_3_reset = reset;
  assign VectorPort_Hw_3_io_in_0_valid = Router_Hw_5_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_3_io_in_0_bits = Router_Hw_5_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_3_io_in_1_valid = Router_Hw_12_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_3_io_in_1_bits = Router_Hw_12_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_3_io_in_2_valid = Router_Hw_8_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_3_io_in_2_bits = Router_Hw_8_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign VectorPort_Hw_3_io_out_0_ready = io_out_0_ready; // @[Cgra_Hw.scala 80:48]
  assign Router_Hw_clock = clock;
  assign Router_Hw_reset = reset;
  assign Router_Hw_io_in_0_valid = VectorPort_Hw_1_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_io_in_0_bits = VectorPort_Hw_1_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_io_in_1_valid = Router_Hw_11_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_io_in_1_bits = Router_Hw_11_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_io_in_2_valid = Router_Hw_14_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_io_in_2_bits = Router_Hw_14_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_io_in_3_valid = Router_Hw_6_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_io_in_3_bits = Router_Hw_6_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_io_in_3_config = Router_Hw_6_io_out_1_config; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_io_out_0_ready = Router_Hw_11_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_io_out_1_ready = Router_Hw_14_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_io_out_2_ready = Router_Hw_6_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_io_out_3_ready = Dedicated_PE_Hw_1_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_io_out_4_ready = Dedicated_PE_Hw_2_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_clock = clock;
  assign Router_Hw_1_reset = reset;
  assign Router_Hw_1_io_in_0_valid = Router_Hw_6_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_in_0_bits = Router_Hw_6_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_in_1_valid = Router_Hw_9_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_in_1_bits = Router_Hw_9_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_in_2_valid = Router_Hw_11_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_in_2_bits = Router_Hw_11_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_in_3_valid = Router_Hw_7_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_in_3_bits = Router_Hw_7_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_in_4_valid = Dedicated_PE_Hw_5_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_in_4_bits = Dedicated_PE_Hw_5_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_in_4_config = Dedicated_PE_Hw_5_io_out_0_config; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_in_5_valid = Dedicated_PE_Hw_2_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_in_5_bits = Dedicated_PE_Hw_2_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_out_0_ready = Router_Hw_6_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_out_1_ready = Router_Hw_9_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_out_2_ready = Router_Hw_11_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_out_3_ready = Router_Hw_7_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_out_4_ready = Dedicated_PE_Hw_2_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_out_5_ready = Dedicated_PE_Hw_5_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_out_6_ready = Dedicated_PE_Hw_3_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_1_io_out_7_ready = Dedicated_PE_Hw_6_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_clock = clock;
  assign Router_Hw_2_reset = reset;
  assign Router_Hw_2_io_in_0_valid = Router_Hw_7_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_io_in_0_bits = Router_Hw_7_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_io_in_1_valid = Router_Hw_10_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_io_in_1_bits = Router_Hw_10_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_io_in_2_valid = Router_Hw_9_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_io_in_2_bits = Router_Hw_9_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_io_in_2_config = Router_Hw_9_io_out_3_config; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_io_in_3_valid = VectorPort_Hw_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_io_in_3_bits = VectorPort_Hw_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_io_out_0_ready = Router_Hw_7_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_io_out_1_ready = Router_Hw_10_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_io_out_2_ready = Router_Hw_9_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_io_out_3_ready = Dedicated_PE_Hw_6_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_2_io_out_4_ready = Dedicated_PE_Hw_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_clock = clock;
  assign Router_Hw_3_reset = reset;
  assign Router_Hw_3_io_in_0_valid = Router_Hw_11_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_0_bits = Router_Hw_11_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_1_valid = Router_Hw_15_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_1_bits = Router_Hw_15_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_2_valid = Router_Hw_12_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_2_bits = Router_Hw_12_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_3_valid = Router_Hw_9_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_3_bits = Router_Hw_9_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_4_valid = Dedicated_PE_Hw_3_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_4_bits = Dedicated_PE_Hw_3_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_4_config = Dedicated_PE_Hw_3_io_out_0_config; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_5_valid = Shared_PE_Hw_1_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_5_bits = Shared_PE_Hw_1_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_6_valid = Shared_PE_Hw_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_in_6_bits = Shared_PE_Hw_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_out_0_ready = Router_Hw_11_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_out_1_ready = Router_Hw_15_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_out_3_ready = Router_Hw_9_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_out_4_ready = Shared_PE_Hw_1_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_out_5_ready = Dedicated_PE_Hw_3_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_3_io_out_7_ready = Dedicated_PE_Hw_4_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_clock = clock;
  assign Router_Hw_4_reset = reset;
  assign Router_Hw_4_io_in_0_valid = Router_Hw_9_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_io_in_0_bits = Router_Hw_9_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_io_in_1_valid = Router_Hw_15_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_io_in_1_bits = Router_Hw_15_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_io_in_2_valid = Router_Hw_10_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_io_in_2_bits = Router_Hw_10_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_io_in_3_valid = Dedicated_PE_Hw_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_io_in_3_bits = Dedicated_PE_Hw_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_io_in_3_config = Dedicated_PE_Hw_io_out_0_config; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_io_out_0_ready = Router_Hw_9_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_io_out_1_ready = Router_Hw_15_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_io_out_3_ready = Dedicated_PE_Hw_4_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_io_out_4_ready = Dedicated_PE_Hw_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_4_io_out_5_ready = VectorPort_Hw_2_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_clock = clock;
  assign Router_Hw_5_reset = reset;
  assign Router_Hw_5_io_in_0_valid = Router_Hw_14_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_in_0_bits = Router_Hw_14_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_in_1_valid = Router_Hw_12_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_in_1_bits = Router_Hw_12_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_in_2_valid = Router_Hw_11_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_in_2_bits = Router_Hw_11_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_in_3_valid = Dedicated_PE_Hw_1_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_in_3_bits = Dedicated_PE_Hw_1_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_in_3_config = Dedicated_PE_Hw_1_io_out_0_config; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_in_4_valid = Shared_PE_Hw_1_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_in_4_bits = Shared_PE_Hw_1_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_out_0_ready = Router_Hw_14_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_out_1_ready = Router_Hw_12_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_out_2_ready = VectorPort_Hw_3_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_out_3_ready = Router_Hw_11_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_out_4_ready = Dedicated_PE_Hw_1_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_5_io_out_5_ready = Shared_PE_Hw_1_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_clock = clock;
  assign Router_Hw_6_reset = reset;
  assign Router_Hw_6_io_in_0_valid = VectorPort_Hw_1_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_io_in_0_bits = VectorPort_Hw_1_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_io_in_0_config = VectorPort_Hw_1_io_out_0_config; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_io_in_1_valid = Router_Hw_1_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_io_in_1_bits = Router_Hw_1_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_io_in_2_valid = Router_Hw_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_io_in_2_bits = Router_Hw_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_io_in_3_valid = Router_Hw_13_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_io_in_3_bits = Router_Hw_13_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_io_out_0_ready = Router_Hw_1_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_io_out_1_ready = Router_Hw_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_io_out_2_ready = Router_Hw_13_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_io_out_3_ready = Dedicated_PE_Hw_2_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_6_io_out_4_ready = Dedicated_PE_Hw_5_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_clock = clock;
  assign Router_Hw_7_reset = reset;
  assign Router_Hw_7_io_in_0_valid = Router_Hw_13_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_io_in_0_bits = Router_Hw_13_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_io_in_1_valid = Router_Hw_2_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_io_in_1_bits = Router_Hw_2_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_io_in_2_valid = Router_Hw_1_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_io_in_2_bits = Router_Hw_1_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_io_in_2_config = Router_Hw_1_io_out_3_config; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_io_in_3_valid = VectorPort_Hw_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_io_in_3_bits = VectorPort_Hw_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_io_out_0_ready = Router_Hw_13_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_io_out_1_ready = Router_Hw_2_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_io_out_2_ready = Router_Hw_1_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_io_out_3_ready = Dedicated_PE_Hw_5_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_7_io_out_4_ready = Dedicated_PE_Hw_6_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_8_clock = clock;
  assign Router_Hw_8_io_in_0_valid = Router_Hw_12_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_8_io_in_0_bits = Router_Hw_12_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_8_io_out_1_ready = VectorPort_Hw_3_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_8_io_out_2_ready = Router_Hw_15_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_8_io_out_3_ready = Shared_PE_Hw_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_clock = clock;
  assign Router_Hw_9_reset = reset;
  assign Router_Hw_9_io_in_0_valid = Router_Hw_1_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_in_0_bits = Router_Hw_1_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_in_1_valid = Router_Hw_4_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_in_1_bits = Router_Hw_4_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_in_2_valid = Router_Hw_3_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_in_2_bits = Router_Hw_3_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_in_3_valid = Router_Hw_2_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_in_3_bits = Router_Hw_2_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_in_4_valid = Dedicated_PE_Hw_6_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_in_4_bits = Dedicated_PE_Hw_6_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_in_4_config = Dedicated_PE_Hw_6_io_out_0_config; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_out_0_ready = Router_Hw_1_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_out_1_ready = Router_Hw_4_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_out_2_ready = Router_Hw_3_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_out_3_ready = Router_Hw_2_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_out_4_ready = Dedicated_PE_Hw_3_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_out_5_ready = Dedicated_PE_Hw_6_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_out_6_ready = Dedicated_PE_Hw_4_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_9_io_out_7_ready = Dedicated_PE_Hw_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_10_clock = clock;
  assign Router_Hw_10_io_in_0_valid = Router_Hw_2_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_10_io_in_0_bits = Router_Hw_2_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_10_io_out_0_ready = Router_Hw_2_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_10_io_out_1_ready = Router_Hw_4_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_10_io_out_2_ready = Dedicated_PE_Hw_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_10_io_out_3_ready = VectorPort_Hw_2_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_clock = clock;
  assign Router_Hw_11_reset = reset;
  assign Router_Hw_11_io_in_0_valid = Router_Hw_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_in_0_bits = Router_Hw_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_in_1_valid = Router_Hw_3_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_in_1_bits = Router_Hw_3_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_in_2_valid = Router_Hw_5_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_in_2_bits = Router_Hw_5_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_in_3_valid = Router_Hw_1_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_in_3_bits = Router_Hw_1_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_in_4_valid = Dedicated_PE_Hw_2_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_in_4_bits = Dedicated_PE_Hw_2_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_in_4_config = Dedicated_PE_Hw_2_io_out_0_config; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_in_5_valid = Shared_PE_Hw_1_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_in_5_bits = Shared_PE_Hw_1_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_out_0_ready = Router_Hw_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_out_1_ready = Router_Hw_3_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_out_2_ready = Router_Hw_5_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_out_3_ready = Router_Hw_1_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_out_4_ready = Dedicated_PE_Hw_1_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_out_5_ready = Dedicated_PE_Hw_2_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_11_io_out_7_ready = Dedicated_PE_Hw_3_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_12_clock = clock;
  assign Router_Hw_12_io_in_0_valid = Router_Hw_5_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_12_io_in_0_bits = Router_Hw_5_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_12_io_out_0_ready = Router_Hw_5_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_12_io_out_1_ready = Router_Hw_8_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_12_io_out_2_ready = VectorPort_Hw_3_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_12_io_out_3_ready = Router_Hw_3_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_12_io_out_4_ready = Shared_PE_Hw_1_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_12_io_out_5_ready = Shared_PE_Hw_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_13_clock = clock;
  assign Router_Hw_13_reset = reset;
  assign Router_Hw_13_io_in_0_valid = Router_Hw_7_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_13_io_in_0_bits = Router_Hw_7_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_13_io_in_1_valid = Router_Hw_6_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_13_io_in_1_bits = Router_Hw_6_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_13_io_in_2_valid = VectorPort_Hw_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_13_io_in_2_bits = VectorPort_Hw_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_13_io_in_2_config = VectorPort_Hw_io_out_0_config; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_13_io_out_0_ready = Router_Hw_7_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_13_io_out_1_ready = Router_Hw_6_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_13_io_out_2_ready = Dedicated_PE_Hw_5_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_14_clock = clock;
  assign Router_Hw_14_reset = reset;
  assign Router_Hw_14_io_in_0_valid = VectorPort_Hw_1_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_14_io_in_0_bits = VectorPort_Hw_1_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_14_io_in_0_config = VectorPort_Hw_1_io_out_2_config; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_14_io_in_1_valid = Router_Hw_5_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_14_io_in_1_bits = Router_Hw_5_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_14_io_in_2_valid = Router_Hw_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_14_io_in_2_bits = Router_Hw_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_14_io_out_0_ready = Router_Hw_5_io_in_0_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_14_io_out_1_ready = Router_Hw_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_14_io_out_2_ready = Dedicated_PE_Hw_1_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_clock = clock;
  assign Router_Hw_15_reset = reset;
  assign Router_Hw_15_io_in_0_valid = Router_Hw_3_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_in_0_bits = Router_Hw_3_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_in_1_valid = Router_Hw_8_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_in_1_bits = Router_Hw_8_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_in_2_valid = Router_Hw_4_io_out_1_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_in_2_bits = Router_Hw_4_io_out_1_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_in_3_valid = Dedicated_PE_Hw_4_io_out_0_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_in_3_bits = Dedicated_PE_Hw_4_io_out_0_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_in_3_config = Dedicated_PE_Hw_4_io_out_0_config; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_in_4_valid = Shared_PE_Hw_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_in_4_bits = Shared_PE_Hw_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_out_0_ready = Router_Hw_3_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_out_2_ready = Router_Hw_4_io_in_1_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_out_3_ready = Shared_PE_Hw_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_out_4_ready = Dedicated_PE_Hw_4_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Router_Hw_15_io_out_5_ready = VectorPort_Hw_2_io_in_2_ready; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_clock = clock;
  assign Dedicated_PE_Hw_reset = reset;
  assign Dedicated_PE_Hw_io_in_0_valid = Router_Hw_2_io_out_4_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_io_in_0_bits = Router_Hw_2_io_out_4_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_io_in_0_config = Router_Hw_2_io_out_4_config; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_io_in_1_valid = Router_Hw_9_io_out_7_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_io_in_1_bits = Router_Hw_9_io_out_7_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_io_in_2_valid = Router_Hw_10_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_io_in_2_bits = Router_Hw_10_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_io_in_3_valid = Router_Hw_4_io_out_4_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_io_in_3_bits = Router_Hw_4_io_out_4_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_io_out_0_ready = Router_Hw_4_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_1_clock = clock;
  assign Dedicated_PE_Hw_1_reset = reset;
  assign Dedicated_PE_Hw_1_io_in_0_valid = Router_Hw_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_1_io_in_0_bits = Router_Hw_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_1_io_in_1_valid = Router_Hw_14_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_1_io_in_1_bits = Router_Hw_14_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_1_io_in_1_config = Router_Hw_14_io_out_2_config; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_1_io_in_2_valid = Router_Hw_11_io_out_4_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_1_io_in_2_bits = Router_Hw_11_io_out_4_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_1_io_in_3_valid = Router_Hw_5_io_out_4_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_1_io_in_3_bits = Router_Hw_5_io_out_4_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_1_io_out_0_ready = Router_Hw_5_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_2_clock = clock;
  assign Dedicated_PE_Hw_2_reset = reset;
  assign Dedicated_PE_Hw_2_io_in_0_valid = Router_Hw_6_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_2_io_in_0_bits = Router_Hw_6_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_2_io_in_1_valid = Router_Hw_io_out_4_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_2_io_in_1_bits = Router_Hw_io_out_4_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_2_io_in_1_config = Router_Hw_io_out_4_config; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_2_io_in_2_valid = Router_Hw_1_io_out_4_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_2_io_in_2_bits = Router_Hw_1_io_out_4_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_2_io_in_3_valid = Router_Hw_11_io_out_5_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_2_io_in_3_bits = Router_Hw_11_io_out_5_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_2_io_out_0_ready = Router_Hw_11_io_in_4_ready; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_2_io_out_1_ready = Router_Hw_1_io_in_5_ready; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_3_clock = clock;
  assign Dedicated_PE_Hw_3_reset = reset;
  assign Dedicated_PE_Hw_3_io_in_0_valid = Router_Hw_1_io_out_6_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_3_io_in_0_bits = Router_Hw_1_io_out_6_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_3_io_in_1_valid = Router_Hw_11_io_out_7_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_3_io_in_1_bits = Router_Hw_11_io_out_7_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_3_io_in_1_config = Router_Hw_11_io_out_7_config; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_3_io_in_2_valid = Router_Hw_9_io_out_4_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_3_io_in_2_bits = Router_Hw_9_io_out_4_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_3_io_in_3_valid = Router_Hw_3_io_out_5_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_3_io_in_3_bits = Router_Hw_3_io_out_5_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_3_io_out_0_ready = Router_Hw_3_io_in_4_ready; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_4_clock = clock;
  assign Dedicated_PE_Hw_4_reset = reset;
  assign Dedicated_PE_Hw_4_io_in_0_valid = Router_Hw_9_io_out_6_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_4_io_in_0_bits = Router_Hw_9_io_out_6_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_4_io_in_1_valid = Router_Hw_3_io_out_7_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_4_io_in_1_bits = Router_Hw_3_io_out_7_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_4_io_in_1_config = Router_Hw_3_io_out_7_config; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_4_io_in_2_valid = Router_Hw_4_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_4_io_in_2_bits = Router_Hw_4_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_4_io_in_3_valid = Router_Hw_15_io_out_4_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_4_io_in_3_bits = Router_Hw_15_io_out_4_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_4_io_out_0_ready = Router_Hw_15_io_in_3_ready; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_5_clock = clock;
  assign Dedicated_PE_Hw_5_reset = reset;
  assign Dedicated_PE_Hw_5_io_in_0_valid = Router_Hw_13_io_out_2_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_5_io_in_0_bits = Router_Hw_13_io_out_2_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_5_io_in_0_config = Router_Hw_13_io_out_2_config; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_5_io_in_1_valid = Router_Hw_6_io_out_4_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_5_io_in_1_bits = Router_Hw_6_io_out_4_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_5_io_in_2_valid = Router_Hw_7_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_5_io_in_2_bits = Router_Hw_7_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_5_io_in_3_valid = Router_Hw_1_io_out_5_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_5_io_in_3_bits = Router_Hw_1_io_out_5_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_5_io_out_0_ready = Router_Hw_1_io_in_4_ready; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_6_clock = clock;
  assign Dedicated_PE_Hw_6_reset = reset;
  assign Dedicated_PE_Hw_6_io_in_0_valid = Router_Hw_7_io_out_4_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_6_io_in_0_bits = Router_Hw_7_io_out_4_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_6_io_in_0_config = Router_Hw_7_io_out_4_config; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_6_io_in_1_valid = Router_Hw_1_io_out_7_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_6_io_in_1_bits = Router_Hw_1_io_out_7_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_6_io_in_2_valid = Router_Hw_2_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_6_io_in_2_bits = Router_Hw_2_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_6_io_in_3_valid = Router_Hw_9_io_out_5_valid; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_6_io_in_3_bits = Router_Hw_9_io_out_5_bits; // @[Cgra_Hw.scala 82:48]
  assign Dedicated_PE_Hw_6_io_out_0_ready = Router_Hw_9_io_in_4_ready; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_io_in_1_valid = Router_Hw_12_io_out_5_valid; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_io_in_1_bits = Router_Hw_12_io_out_5_bits; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_io_in_2_valid = Router_Hw_15_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_io_in_2_bits = Router_Hw_15_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_io_in_3_valid = Router_Hw_8_io_out_3_valid; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_io_in_3_bits = Router_Hw_8_io_out_3_bits; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_io_out_0_ready = Router_Hw_3_io_in_6_ready; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_io_out_1_ready = 1'h1; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_io_out_2_ready = Router_Hw_15_io_in_4_ready; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_1_io_in_1_valid = Router_Hw_5_io_out_5_valid; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_1_io_in_1_bits = Router_Hw_5_io_out_5_bits; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_1_io_in_2_valid = Router_Hw_3_io_out_4_valid; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_1_io_in_2_bits = Router_Hw_3_io_out_4_bits; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_1_io_in_3_valid = Router_Hw_12_io_out_4_valid; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_1_io_in_3_bits = Router_Hw_12_io_out_4_bits; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_1_io_out_0_ready = Router_Hw_11_io_in_5_ready; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_1_io_out_1_ready = Router_Hw_5_io_in_4_ready; // @[Cgra_Hw.scala 82:48]
  assign Shared_PE_Hw_1_io_out_2_ready = Router_Hw_3_io_in_5_ready; // @[Cgra_Hw.scala 82:48]
endmodule
