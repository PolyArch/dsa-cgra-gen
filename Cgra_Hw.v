module VectorPort_Hw( // @[:@3.2]
  input         clock, // @[:@4.4]
  input         reset, // @[:@5.4]
  input         io_in_0_valid, // @[:@6.4]
  input  [63:0] io_in_0_bits, // @[:@6.4]
  output        io_in_0_ready, // @[:@6.4]
  input         io_in_0_config, // @[:@6.4]
  output        io_out_0_valid, // @[:@6.4]
  output [63:0] io_out_0_bits, // @[:@6.4]
  input         io_out_0_ready, // @[:@6.4]
  output        io_out_0_config, // @[:@6.4]
  output        io_out_1_valid, // @[:@6.4]
  output [63:0] io_out_1_bits, // @[:@6.4]
  input         io_out_1_ready, // @[:@6.4]
  output        io_out_1_config, // @[:@6.4]
  output        io_out_2_valid, // @[:@6.4]
  output [63:0] io_out_2_bits, // @[:@6.4]
  input         io_out_2_ready, // @[:@6.4]
  output        io_out_2_config // @[:@6.4]
);
  reg [1:0] distribute_counter; // @[VectorPort_Hw.scala 25:35:@8.4]
  reg [31:0] _RAND_0;
  reg  vector_registers_0_valid; // @[VectorPort_Hw.scala 26:29:@9.4]
  reg [31:0] _RAND_1;
  reg [63:0] vector_registers_0_bits; // @[VectorPort_Hw.scala 26:29:@9.4]
  reg [63:0] _RAND_2;
  reg  vector_registers_0_ready; // @[VectorPort_Hw.scala 26:29:@9.4]
  reg [31:0] _RAND_3;
  reg  vector_registers_0_config; // @[VectorPort_Hw.scala 26:29:@9.4]
  reg [31:0] _RAND_4;
  reg  vector_registers_1_valid; // @[VectorPort_Hw.scala 26:29:@9.4]
  reg [31:0] _RAND_5;
  reg [63:0] vector_registers_1_bits; // @[VectorPort_Hw.scala 26:29:@9.4]
  reg [63:0] _RAND_6;
  reg  vector_registers_1_ready; // @[VectorPort_Hw.scala 26:29:@9.4]
  reg [31:0] _RAND_7;
  reg  vector_registers_1_config; // @[VectorPort_Hw.scala 26:29:@9.4]
  reg [31:0] _RAND_8;
  reg  vector_registers_2_valid; // @[VectorPort_Hw.scala 26:29:@9.4]
  reg [31:0] _RAND_9;
  reg [63:0] vector_registers_2_bits; // @[VectorPort_Hw.scala 26:29:@9.4]
  reg [63:0] _RAND_10;
  reg  vector_registers_2_ready; // @[VectorPort_Hw.scala 26:29:@9.4]
  reg [31:0] _RAND_11;
  reg  vector_registers_2_config; // @[VectorPort_Hw.scala 26:29:@9.4]
  reg [31:0] _RAND_12;
  wire  _GEN_9; // @[VectorPort_Hw.scala 32:42:@23.4]
  wire [2:0] _T_129; // @[VectorPort_Hw.scala 40:44:@26.4]
  wire [1:0] _T_130; // @[VectorPort_Hw.scala 40:44:@27.4]
  assign _GEN_9 = 2'h1 == distribute_counter ? vector_registers_1_ready : vector_registers_0_ready; // @[VectorPort_Hw.scala 32:42:@23.4]
  assign _T_129 = distribute_counter + 2'h1; // @[VectorPort_Hw.scala 40:44:@26.4]
  assign _T_130 = distribute_counter + 2'h1; // @[VectorPort_Hw.scala 40:44:@27.4]
  assign io_in_0_ready = 2'h2 == distribute_counter ? vector_registers_2_ready : _GEN_9; // @[VectorPort_Hw.scala 32:42:@23.4]
  assign io_out_0_valid = vector_registers_0_valid; // @[VectorPort_Hw.scala 31:17:@13.4]
  assign io_out_0_bits = vector_registers_0_bits; // @[VectorPort_Hw.scala 31:17:@12.4]
  assign io_out_0_config = vector_registers_0_config; // @[VectorPort_Hw.scala 31:17:@10.4]
  assign io_out_1_valid = vector_registers_1_valid; // @[VectorPort_Hw.scala 31:17:@17.4]
  assign io_out_1_bits = vector_registers_1_bits; // @[VectorPort_Hw.scala 31:17:@16.4]
  assign io_out_1_config = vector_registers_1_config; // @[VectorPort_Hw.scala 31:17:@14.4]
  assign io_out_2_valid = vector_registers_2_valid; // @[VectorPort_Hw.scala 31:17:@21.4]
  assign io_out_2_bits = vector_registers_2_bits; // @[VectorPort_Hw.scala 31:17:@20.4]
  assign io_out_2_config = vector_registers_2_config; // @[VectorPort_Hw.scala 31:17:@18.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
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
  vector_registers_1_config = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  vector_registers_2_valid = _RAND_9[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {2{`RANDOM}};
  vector_registers_2_bits = _RAND_10[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  vector_registers_2_ready = _RAND_11[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  vector_registers_2_config = _RAND_12[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      distribute_counter <= 2'h0;
    end else begin
      distribute_counter <= _T_130;
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
    if (2'h1 == distribute_counter) begin
      vector_registers_1_config <= io_in_0_config;
    end
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
module VectorPort_Hw_2( // @[:@57.2]
  input         clock, // @[:@58.4]
  input         reset, // @[:@59.4]
  input         io_in_0_valid, // @[:@60.4]
  input  [63:0] io_in_0_bits, // @[:@60.4]
  output        io_in_0_ready, // @[:@60.4]
  input         io_in_1_valid, // @[:@60.4]
  input  [63:0] io_in_1_bits, // @[:@60.4]
  output        io_in_1_ready, // @[:@60.4]
  input         io_in_2_valid, // @[:@60.4]
  input  [63:0] io_in_2_bits, // @[:@60.4]
  output        io_in_2_ready, // @[:@60.4]
  output        io_out_0_valid, // @[:@60.4]
  output [63:0] io_out_0_bits, // @[:@60.4]
  input         io_out_0_ready // @[:@60.4]
);
  reg [1:0] distribute_counter; // @[VectorPort_Hw.scala 25:35:@62.4]
  reg [31:0] _RAND_0;
  reg  vector_registers_0_valid; // @[VectorPort_Hw.scala 26:29:@63.4]
  reg [31:0] _RAND_1;
  reg [63:0] vector_registers_0_bits; // @[VectorPort_Hw.scala 26:29:@63.4]
  reg [63:0] _RAND_2;
  reg  vector_registers_0_ready; // @[VectorPort_Hw.scala 26:29:@63.4]
  reg [31:0] _RAND_3;
  reg  vector_registers_1_valid; // @[VectorPort_Hw.scala 26:29:@63.4]
  reg [31:0] _RAND_4;
  reg [63:0] vector_registers_1_bits; // @[VectorPort_Hw.scala 26:29:@63.4]
  reg [63:0] _RAND_5;
  reg  vector_registers_1_ready; // @[VectorPort_Hw.scala 26:29:@63.4]
  reg [31:0] _RAND_6;
  reg  vector_registers_2_valid; // @[VectorPort_Hw.scala 26:29:@63.4]
  reg [31:0] _RAND_7;
  reg [63:0] vector_registers_2_bits; // @[VectorPort_Hw.scala 26:29:@63.4]
  reg [63:0] _RAND_8;
  reg  vector_registers_2_ready; // @[VectorPort_Hw.scala 26:29:@63.4]
  reg [31:0] _RAND_9;
  wire  _GEN_4; // @[VectorPort_Hw.scala 37:17:@76.4]
  wire [63:0] _GEN_5; // @[VectorPort_Hw.scala 37:17:@76.4]
  wire [2:0] _T_165; // @[VectorPort_Hw.scala 40:44:@80.4]
  wire [1:0] _T_166; // @[VectorPort_Hw.scala 40:44:@81.4]
  assign _GEN_4 = 2'h1 == distribute_counter ? vector_registers_1_valid : vector_registers_0_valid; // @[VectorPort_Hw.scala 37:17:@76.4]
  assign _GEN_5 = 2'h1 == distribute_counter ? vector_registers_1_bits : vector_registers_0_bits; // @[VectorPort_Hw.scala 37:17:@76.4]
  assign _T_165 = distribute_counter + 2'h1; // @[VectorPort_Hw.scala 40:44:@80.4]
  assign _T_166 = distribute_counter + 2'h1; // @[VectorPort_Hw.scala 40:44:@81.4]
  assign io_in_0_ready = vector_registers_0_ready; // @[VectorPort_Hw.scala 36:27:@65.4]
  assign io_in_1_ready = vector_registers_1_ready; // @[VectorPort_Hw.scala 36:27:@69.4]
  assign io_in_2_ready = vector_registers_2_ready; // @[VectorPort_Hw.scala 36:27:@73.4]
  assign io_out_0_valid = 2'h2 == distribute_counter ? vector_registers_2_valid : _GEN_4; // @[VectorPort_Hw.scala 37:17:@79.4]
  assign io_out_0_bits = 2'h2 == distribute_counter ? vector_registers_2_bits : _GEN_5; // @[VectorPort_Hw.scala 37:17:@78.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
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
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      distribute_counter <= 2'h0;
    end else begin
      distribute_counter <= _T_166;
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
module Router_Hw( // @[:@111.2]
  input         clock, // @[:@112.4]
  input         reset, // @[:@113.4]
  input         io_in_0_valid, // @[:@114.4]
  input  [63:0] io_in_0_bits, // @[:@114.4]
  output        io_in_0_ready, // @[:@114.4]
  input         io_in_0_config, // @[:@114.4]
  input         io_in_1_valid, // @[:@114.4]
  input  [63:0] io_in_1_bits, // @[:@114.4]
  output        io_in_1_ready, // @[:@114.4]
  input         io_in_2_valid, // @[:@114.4]
  input  [63:0] io_in_2_bits, // @[:@114.4]
  output        io_in_2_ready, // @[:@114.4]
  input         io_in_3_valid, // @[:@114.4]
  input  [63:0] io_in_3_bits, // @[:@114.4]
  output        io_in_3_ready, // @[:@114.4]
  output        io_out_0_valid, // @[:@114.4]
  output [63:0] io_out_0_bits, // @[:@114.4]
  input         io_out_0_ready, // @[:@114.4]
  output        io_out_1_valid, // @[:@114.4]
  output [63:0] io_out_1_bits, // @[:@114.4]
  input         io_out_1_ready, // @[:@114.4]
  output        io_out_2_valid, // @[:@114.4]
  output [63:0] io_out_2_bits, // @[:@114.4]
  input         io_out_2_ready // @[:@114.4]
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 163:29:@134.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_315; // @[Router_Hw.scala 167:32:@136.4]
  reg [63:0] _RAND_1;
  reg  _T_318; // @[Router_Hw.scala 169:33:@138.4]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 163:29:@144.4]
  reg [31:0] _RAND_3;
  reg [63:0] _T_329; // @[Router_Hw.scala 167:32:@146.4]
  reg [63:0] _RAND_4;
  reg  _T_332; // @[Router_Hw.scala 169:33:@148.4]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 163:29:@154.4]
  reg [31:0] _RAND_6;
  reg [63:0] _T_343; // @[Router_Hw.scala 167:32:@156.4]
  reg [63:0] _RAND_7;
  reg  _T_346; // @[Router_Hw.scala 169:33:@158.4]
  reg [31:0] _RAND_8;
  reg [9:0] config_register_file_0; // @[Router_Hw.scala 117:37:@367.4]
  reg [31:0] _RAND_9;
  wire [1:0] _T_385; // @[Router_Hw.scala 82:28:@185.4]
  wire  _T_387; // @[Mux.scala 46:19:@186.4]
  wire [63:0] _T_388; // @[Mux.scala 46:16:@187.4]
  wire  _T_389; // @[Mux.scala 46:19:@188.4]
  wire [63:0] _T_390; // @[Mux.scala 46:16:@189.4]
  wire  _T_391; // @[Mux.scala 46:19:@190.4]
  wire [63:0] _T_392; // @[Mux.scala 46:16:@191.4]
  wire  _T_393; // @[Mux.scala 46:19:@192.4]
  wire [63:0] decomposed_output_ports_0_0_bits; // @[Mux.scala 46:16:@193.4]
  wire  _T_398; // @[Mux.scala 46:16:@197.4]
  wire  _T_400; // @[Mux.scala 46:16:@199.4]
  wire  _T_402; // @[Mux.scala 46:16:@201.4]
  wire  decomposed_output_ports_0_0_valid; // @[Mux.scala 46:16:@203.4]
  wire [1:0] _T_413; // @[Router_Hw.scala 82:28:@205.4]
  wire  _T_415; // @[Mux.scala 46:19:@206.4]
  wire [63:0] _T_416; // @[Mux.scala 46:16:@207.4]
  wire  _T_417; // @[Mux.scala 46:19:@208.4]
  wire [63:0] _T_418; // @[Mux.scala 46:16:@209.4]
  wire  _T_419; // @[Mux.scala 46:19:@210.4]
  wire [63:0] _T_420; // @[Mux.scala 46:16:@211.4]
  wire  _T_421; // @[Mux.scala 46:19:@212.4]
  wire [63:0] decomposed_output_ports_0_1_bits; // @[Mux.scala 46:16:@213.4]
  wire  _T_426; // @[Mux.scala 46:16:@217.4]
  wire  _T_428; // @[Mux.scala 46:16:@219.4]
  wire  _T_430; // @[Mux.scala 46:16:@221.4]
  wire  decomposed_output_ports_0_1_valid; // @[Mux.scala 46:16:@223.4]
  wire [1:0] _T_441; // @[Router_Hw.scala 82:28:@225.4]
  wire  _T_443; // @[Mux.scala 46:19:@226.4]
  wire [63:0] _T_444; // @[Mux.scala 46:16:@227.4]
  wire  _T_445; // @[Mux.scala 46:19:@228.4]
  wire [63:0] _T_446; // @[Mux.scala 46:16:@229.4]
  wire  _T_447; // @[Mux.scala 46:19:@230.4]
  wire [63:0] _T_448; // @[Mux.scala 46:16:@231.4]
  wire  _T_449; // @[Mux.scala 46:19:@232.4]
  wire [63:0] decomposed_output_ports_0_2_bits; // @[Mux.scala 46:16:@233.4]
  wire  _T_454; // @[Mux.scala 46:16:@237.4]
  wire  _T_456; // @[Mux.scala 46:16:@239.4]
  wire  _T_458; // @[Mux.scala 46:16:@241.4]
  wire  decomposed_output_ports_0_2_valid; // @[Mux.scala 46:16:@243.4]
  wire  _T_519; // @[Router_Hw.scala 90:53:@286.4]
  wire  _T_521; // @[Router_Hw.scala 90:10:@287.4]
  wire  _T_524; // @[Router_Hw.scala 90:53:@289.4]
  wire  _T_526; // @[Router_Hw.scala 90:10:@290.4]
  wire  _T_529; // @[Router_Hw.scala 90:53:@292.4]
  wire  _T_531; // @[Router_Hw.scala 90:10:@293.4]
  wire  _T_542; // @[Router_Hw.scala 93:99:@300.4]
  wire  _T_548; // @[Router_Hw.scala 90:53:@306.4]
  wire  _T_550; // @[Router_Hw.scala 90:10:@307.4]
  wire  _T_553; // @[Router_Hw.scala 90:53:@309.4]
  wire  _T_555; // @[Router_Hw.scala 90:10:@310.4]
  wire  _T_558; // @[Router_Hw.scala 90:53:@312.4]
  wire  _T_560; // @[Router_Hw.scala 90:10:@313.4]
  wire  _T_571; // @[Router_Hw.scala 93:99:@320.4]
  wire  _T_577; // @[Router_Hw.scala 90:53:@326.4]
  wire  _T_579; // @[Router_Hw.scala 90:10:@327.4]
  wire  _T_582; // @[Router_Hw.scala 90:53:@329.4]
  wire  _T_584; // @[Router_Hw.scala 90:10:@330.4]
  wire  _T_587; // @[Router_Hw.scala 90:53:@332.4]
  wire  _T_589; // @[Router_Hw.scala 90:10:@333.4]
  wire  _T_600; // @[Router_Hw.scala 93:99:@340.4]
  wire  _T_606; // @[Router_Hw.scala 90:53:@346.4]
  wire  _T_608; // @[Router_Hw.scala 90:10:@347.4]
  wire  _T_611; // @[Router_Hw.scala 90:53:@349.4]
  wire  _T_613; // @[Router_Hw.scala 90:10:@350.4]
  wire  _T_616; // @[Router_Hw.scala 90:53:@352.4]
  wire  _T_618; // @[Router_Hw.scala 90:10:@353.4]
  wire  _T_629; // @[Router_Hw.scala 93:99:@360.4]
  wire [4:0] config_module_id; // @[Router_Hw.scala 128:44:@370.4]
  wire  module_id_match; // @[Router_Hw.scala 129:49:@371.4]
  wire [9:0] config_data; // @[Router_Hw.scala 131:39:@373.4]
  wire  _T_656; // @[Router_Hw.scala 132:22:@374.4]
  wire [9:0] _GEN_0; // @[Router_Hw.scala 132:41:@375.4]
  assign _T_385 = config_register_file_0[1:0]; // @[Router_Hw.scala 82:28:@185.4]
  assign _T_387 = 2'h3 == _T_385; // @[Mux.scala 46:19:@186.4]
  assign _T_388 = _T_387 ? io_in_3_bits : 64'h0; // @[Mux.scala 46:16:@187.4]
  assign _T_389 = 2'h2 == _T_385; // @[Mux.scala 46:19:@188.4]
  assign _T_390 = _T_389 ? io_in_2_bits : _T_388; // @[Mux.scala 46:16:@189.4]
  assign _T_391 = 2'h1 == _T_385; // @[Mux.scala 46:19:@190.4]
  assign _T_392 = _T_391 ? io_in_1_bits : _T_390; // @[Mux.scala 46:16:@191.4]
  assign _T_393 = 2'h0 == _T_385; // @[Mux.scala 46:19:@192.4]
  assign decomposed_output_ports_0_0_bits = _T_393 ? io_in_0_bits : _T_392; // @[Mux.scala 46:16:@193.4]
  assign _T_398 = _T_387 ? io_in_3_valid : 1'h0; // @[Mux.scala 46:16:@197.4]
  assign _T_400 = _T_389 ? io_in_2_valid : _T_398; // @[Mux.scala 46:16:@199.4]
  assign _T_402 = _T_391 ? io_in_1_valid : _T_400; // @[Mux.scala 46:16:@201.4]
  assign decomposed_output_ports_0_0_valid = _T_393 ? io_in_0_valid : _T_402; // @[Mux.scala 46:16:@203.4]
  assign _T_413 = config_register_file_0[3:2]; // @[Router_Hw.scala 82:28:@205.4]
  assign _T_415 = 2'h3 == _T_413; // @[Mux.scala 46:19:@206.4]
  assign _T_416 = _T_415 ? io_in_3_bits : 64'h0; // @[Mux.scala 46:16:@207.4]
  assign _T_417 = 2'h2 == _T_413; // @[Mux.scala 46:19:@208.4]
  assign _T_418 = _T_417 ? io_in_2_bits : _T_416; // @[Mux.scala 46:16:@209.4]
  assign _T_419 = 2'h1 == _T_413; // @[Mux.scala 46:19:@210.4]
  assign _T_420 = _T_419 ? io_in_1_bits : _T_418; // @[Mux.scala 46:16:@211.4]
  assign _T_421 = 2'h0 == _T_413; // @[Mux.scala 46:19:@212.4]
  assign decomposed_output_ports_0_1_bits = _T_421 ? io_in_0_bits : _T_420; // @[Mux.scala 46:16:@213.4]
  assign _T_426 = _T_415 ? io_in_3_valid : 1'h0; // @[Mux.scala 46:16:@217.4]
  assign _T_428 = _T_417 ? io_in_2_valid : _T_426; // @[Mux.scala 46:16:@219.4]
  assign _T_430 = _T_419 ? io_in_1_valid : _T_428; // @[Mux.scala 46:16:@221.4]
  assign decomposed_output_ports_0_1_valid = _T_421 ? io_in_0_valid : _T_430; // @[Mux.scala 46:16:@223.4]
  assign _T_441 = config_register_file_0[5:4]; // @[Router_Hw.scala 82:28:@225.4]
  assign _T_443 = 2'h3 == _T_441; // @[Mux.scala 46:19:@226.4]
  assign _T_444 = _T_443 ? io_in_3_bits : 64'h0; // @[Mux.scala 46:16:@227.4]
  assign _T_445 = 2'h2 == _T_441; // @[Mux.scala 46:19:@228.4]
  assign _T_446 = _T_445 ? io_in_2_bits : _T_444; // @[Mux.scala 46:16:@229.4]
  assign _T_447 = 2'h1 == _T_441; // @[Mux.scala 46:19:@230.4]
  assign _T_448 = _T_447 ? io_in_1_bits : _T_446; // @[Mux.scala 46:16:@231.4]
  assign _T_449 = 2'h0 == _T_441; // @[Mux.scala 46:19:@232.4]
  assign decomposed_output_ports_0_2_bits = _T_449 ? io_in_0_bits : _T_448; // @[Mux.scala 46:16:@233.4]
  assign _T_454 = _T_443 ? io_in_3_valid : 1'h0; // @[Mux.scala 46:16:@237.4]
  assign _T_456 = _T_445 ? io_in_2_valid : _T_454; // @[Mux.scala 46:16:@239.4]
  assign _T_458 = _T_447 ? io_in_1_valid : _T_456; // @[Mux.scala 46:16:@241.4]
  assign decomposed_output_ports_0_2_valid = _T_449 ? io_in_0_valid : _T_458; // @[Mux.scala 46:16:@243.4]
  assign _T_519 = _T_385 == 2'h0; // @[Router_Hw.scala 90:53:@286.4]
  assign _T_521 = _T_519 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@287.4]
  assign _T_524 = _T_413 == 2'h0; // @[Router_Hw.scala 90:53:@289.4]
  assign _T_526 = _T_524 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@290.4]
  assign _T_529 = _T_441 == 2'h0; // @[Router_Hw.scala 90:53:@292.4]
  assign _T_531 = _T_529 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 90:10:@293.4]
  assign _T_542 = _T_521 & _T_526; // @[Router_Hw.scala 93:99:@300.4]
  assign _T_548 = _T_385 == 2'h1; // @[Router_Hw.scala 90:53:@306.4]
  assign _T_550 = _T_548 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@307.4]
  assign _T_553 = _T_413 == 2'h1; // @[Router_Hw.scala 90:53:@309.4]
  assign _T_555 = _T_553 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@310.4]
  assign _T_558 = _T_441 == 2'h1; // @[Router_Hw.scala 90:53:@312.4]
  assign _T_560 = _T_558 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 90:10:@313.4]
  assign _T_571 = _T_550 & _T_555; // @[Router_Hw.scala 93:99:@320.4]
  assign _T_577 = _T_385 == 2'h2; // @[Router_Hw.scala 90:53:@326.4]
  assign _T_579 = _T_577 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@327.4]
  assign _T_582 = _T_413 == 2'h2; // @[Router_Hw.scala 90:53:@329.4]
  assign _T_584 = _T_582 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@330.4]
  assign _T_587 = _T_441 == 2'h2; // @[Router_Hw.scala 90:53:@332.4]
  assign _T_589 = _T_587 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 90:10:@333.4]
  assign _T_600 = _T_579 & _T_584; // @[Router_Hw.scala 93:99:@340.4]
  assign _T_606 = _T_385 == 2'h3; // @[Router_Hw.scala 90:53:@346.4]
  assign _T_608 = _T_606 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@347.4]
  assign _T_611 = _T_413 == 2'h3; // @[Router_Hw.scala 90:53:@349.4]
  assign _T_613 = _T_611 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@350.4]
  assign _T_616 = _T_441 == 2'h3; // @[Router_Hw.scala 90:53:@352.4]
  assign _T_618 = _T_616 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 90:10:@353.4]
  assign _T_629 = _T_608 & _T_613; // @[Router_Hw.scala 93:99:@360.4]
  assign config_module_id = io_in_0_bits[63:59]; // @[Router_Hw.scala 128:44:@370.4]
  assign module_id_match = config_module_id == 5'hb; // @[Router_Hw.scala 129:49:@371.4]
  assign config_data = io_in_0_bits[9:0]; // @[Router_Hw.scala 131:39:@373.4]
  assign _T_656 = io_in_0_config & module_id_match; // @[Router_Hw.scala 132:22:@374.4]
  assign _GEN_0 = _T_656 ? config_data : config_register_file_0; // @[Router_Hw.scala 132:41:@375.4]
  assign io_in_0_ready = _T_542 & _T_531; // @[Router_Hw.scala 158:33:@120.4]
  assign io_in_1_ready = _T_571 & _T_560; // @[Router_Hw.scala 158:33:@124.4]
  assign io_in_2_ready = _T_600 & _T_589; // @[Router_Hw.scala 158:33:@128.4]
  assign io_in_3_ready = _T_629 & _T_618; // @[Router_Hw.scala 158:33:@132.4]
  assign io_out_0_valid = _T_318; // @[Router_Hw.scala 190:35:@142.4]
  assign io_out_0_bits = _T_315; // @[Router_Hw.scala 189:34:@141.4]
  assign io_out_1_valid = _T_332; // @[Router_Hw.scala 190:35:@152.4]
  assign io_out_1_bits = _T_329; // @[Router_Hw.scala 189:34:@151.4]
  assign io_out_2_valid = _T_346; // @[Router_Hw.scala 190:35:@162.4]
  assign io_out_2_bits = _T_343; // @[Router_Hw.scala 189:34:@161.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_315 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_318 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_329 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_332 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_343 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_346 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  config_register_file_0 = _RAND_9[9:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (reset) begin
      _T_315 <= 64'h0;
    end else begin
      if (_T_393) begin
        _T_315 <= io_in_0_bits;
      end else begin
        if (_T_391) begin
          _T_315 <= io_in_1_bits;
        end else begin
          if (_T_389) begin
            _T_315 <= io_in_2_bits;
          end else begin
            if (_T_387) begin
              _T_315 <= io_in_3_bits;
            end else begin
              _T_315 <= 64'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      _T_318 <= 1'h0;
    end else begin
      if (_T_393) begin
        _T_318 <= io_in_0_valid;
      end else begin
        if (_T_391) begin
          _T_318 <= io_in_1_valid;
        end else begin
          if (_T_389) begin
            _T_318 <= io_in_2_valid;
          end else begin
            if (_T_387) begin
              _T_318 <= io_in_3_valid;
            end else begin
              _T_318 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (reset) begin
      _T_329 <= 64'h0;
    end else begin
      if (_T_421) begin
        _T_329 <= io_in_0_bits;
      end else begin
        if (_T_419) begin
          _T_329 <= io_in_1_bits;
        end else begin
          if (_T_417) begin
            _T_329 <= io_in_2_bits;
          end else begin
            if (_T_415) begin
              _T_329 <= io_in_3_bits;
            end else begin
              _T_329 <= 64'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      _T_332 <= 1'h0;
    end else begin
      if (_T_421) begin
        _T_332 <= io_in_0_valid;
      end else begin
        if (_T_419) begin
          _T_332 <= io_in_1_valid;
        end else begin
          if (_T_417) begin
            _T_332 <= io_in_2_valid;
          end else begin
            if (_T_415) begin
              _T_332 <= io_in_3_valid;
            end else begin
              _T_332 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    if (reset) begin
      _T_343 <= 64'h0;
    end else begin
      if (_T_449) begin
        _T_343 <= io_in_0_bits;
      end else begin
        if (_T_447) begin
          _T_343 <= io_in_1_bits;
        end else begin
          if (_T_445) begin
            _T_343 <= io_in_2_bits;
          end else begin
            if (_T_443) begin
              _T_343 <= io_in_3_bits;
            end else begin
              _T_343 <= 64'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      _T_346 <= 1'h0;
    end else begin
      if (_T_449) begin
        _T_346 <= io_in_0_valid;
      end else begin
        if (_T_447) begin
          _T_346 <= io_in_1_valid;
        end else begin
          if (_T_445) begin
            _T_346 <= io_in_2_valid;
          end else begin
            if (_T_443) begin
              _T_346 <= io_in_3_valid;
            end else begin
              _T_346 <= 1'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 10'h0;
    end else begin
      if (_T_656) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Router_Hw_1( // @[:@379.2]
  input         clock, // @[:@380.4]
  input         reset, // @[:@381.4]
  input         io_in_0_valid, // @[:@382.4]
  input  [63:0] io_in_0_bits, // @[:@382.4]
  output        io_in_0_ready, // @[:@382.4]
  output        io_out_0_valid, // @[:@382.4]
  output [63:0] io_out_0_bits, // @[:@382.4]
  input         io_out_0_ready, // @[:@382.4]
  output        io_out_1_valid, // @[:@382.4]
  output [63:0] io_out_1_bits, // @[:@382.4]
  input         io_out_1_ready // @[:@382.4]
);
  wire [31:0] decomposed_input_ports_0_0_bits; // @[Router_Hw.scala 154:35:@386.4]
  wire [31:0] decomposed_input_ports_1_0_bits; // @[Router_Hw.scala 154:35:@389.4]
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 163:29:@436.4]
  reg [31:0] _RAND_0;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 163:29:@450.4]
  reg [31:0] _RAND_1;
  wire  _T_1483; // @[Router_Hw.scala 93:99:@1096.4]
  wire  decomposed_input_ports_0_0_ready; // @[Router_Hw.scala 93:99:@1103.4]
  reg  decomposed_output_ports_1_0_ready; // @[Router_Hw.scala 163:29:@436.4]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_1_1_ready; // @[Router_Hw.scala 163:29:@450.4]
  reg [31:0] _RAND_3;
  wire  decomposed_input_ports_1_0_ready; // @[Router_Hw.scala 93:99:@1320.4]
  reg [63:0] _T_567; // @[Router_Hw.scala 167:32:@439.4]
  reg [63:0] _RAND_4;
  wire [63:0] _T_568; // @[Cat.scala 30:58:@440.4]
  reg  _T_571; // @[Router_Hw.scala 169:33:@442.4]
  reg [31:0] _RAND_5;
  wire  _T_572; // @[Router_Hw.scala 170:77:@443.4]
  reg [63:0] _T_584; // @[Router_Hw.scala 167:32:@453.4]
  reg [63:0] _RAND_6;
  reg  _T_588; // @[Router_Hw.scala 169:33:@456.4]
  reg [31:0] _RAND_7;
  assign decomposed_input_ports_0_0_bits = io_in_0_bits[31:0]; // @[Router_Hw.scala 154:35:@386.4]
  assign decomposed_input_ports_1_0_bits = io_in_0_bits[63:32]; // @[Router_Hw.scala 154:35:@389.4]
  assign _T_1483 = decomposed_output_ports_0_0_ready & decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 93:99:@1096.4]
  assign decomposed_input_ports_0_0_ready = _T_1483 & decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 93:99:@1103.4]
  assign decomposed_input_ports_1_0_ready = decomposed_output_ports_1_0_ready & decomposed_output_ports_1_1_ready; // @[Router_Hw.scala 93:99:@1320.4]
  assign _T_568 = {decomposed_input_ports_0_0_bits,decomposed_input_ports_1_0_bits}; // @[Cat.scala 30:58:@440.4]
  assign _T_572 = io_in_0_valid & io_in_0_valid; // @[Router_Hw.scala 170:77:@443.4]
  assign io_in_0_ready = decomposed_input_ports_0_0_ready & decomposed_input_ports_1_0_ready; // @[Router_Hw.scala 158:33:@393.4]
  assign io_out_0_valid = _T_571; // @[Router_Hw.scala 190:35:@448.4]
  assign io_out_0_bits = _T_567; // @[Router_Hw.scala 189:34:@447.4]
  assign io_out_1_valid = _T_588; // @[Router_Hw.scala 190:35:@462.4]
  assign io_out_1_bits = _T_584; // @[Router_Hw.scala 189:34:@461.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  decomposed_output_ports_1_0_ready = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_1_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_567 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_571 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {2{`RANDOM}};
  _T_584 = _RAND_6[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  _T_588 = _RAND_7[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    decomposed_output_ports_1_0_ready <= io_out_0_ready;
    decomposed_output_ports_1_1_ready <= io_out_1_ready;
    if (reset) begin
      _T_567 <= 64'h0;
    end else begin
      _T_567 <= _T_568;
    end
    if (reset) begin
      _T_571 <= 1'h0;
    end else begin
      _T_571 <= _T_572;
    end
    if (reset) begin
      _T_584 <= 64'h0;
    end else begin
      _T_584 <= _T_568;
    end
    if (reset) begin
      _T_588 <= 1'h0;
    end else begin
      _T_588 <= _T_572;
    end
  end
endmodule
module Router_Hw_2( // @[:@1619.2]
  input         clock, // @[:@1620.4]
  input         reset, // @[:@1621.4]
  input         io_in_0_valid, // @[:@1622.4]
  input  [63:0] io_in_0_bits, // @[:@1622.4]
  output        io_in_0_ready, // @[:@1622.4]
  output        io_out_1_valid, // @[:@1622.4]
  output [63:0] io_out_1_bits, // @[:@1622.4]
  input         io_out_1_ready // @[:@1622.4]
);
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 163:29:@1652.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_329; // @[Router_Hw.scala 167:32:@1654.4]
  reg [63:0] _RAND_1;
  reg  _T_332; // @[Router_Hw.scala 169:33:@1656.4]
  reg [31:0] _RAND_2;
  assign io_in_0_ready = decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 158:33:@1628.4]
  assign io_out_1_valid = _T_332; // @[Router_Hw.scala 190:35:@1660.4]
  assign io_out_1_bits = _T_329; // @[Router_Hw.scala 189:34:@1659.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_329 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_332 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (reset) begin
      _T_329 <= 64'h0;
    end else begin
      _T_329 <= io_in_0_bits;
    end
    if (reset) begin
      _T_332 <= 1'h0;
    end else begin
      _T_332 <= io_in_0_valid;
    end
  end
endmodule
module Router_Hw_3( // @[:@1887.2]
  input         clock, // @[:@1888.4]
  input         reset, // @[:@1889.4]
  input         io_in_0_valid, // @[:@1890.4]
  input  [63:0] io_in_0_bits, // @[:@1890.4]
  output        io_in_0_ready, // @[:@1890.4]
  output        io_out_1_valid, // @[:@1890.4]
  output [63:0] io_out_1_bits, // @[:@1890.4]
  input         io_out_1_ready // @[:@1890.4]
);
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 163:29:@1932.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_476; // @[Router_Hw.scala 167:32:@1934.4]
  reg [63:0] _RAND_1;
  reg  _T_479; // @[Router_Hw.scala 169:33:@1936.4]
  reg [31:0] _RAND_2;
  assign io_in_0_ready = decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 158:33:@1896.4]
  assign io_out_1_valid = _T_479; // @[Router_Hw.scala 190:35:@1940.4]
  assign io_out_1_bits = _T_476; // @[Router_Hw.scala 189:34:@1939.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_476 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_479 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (reset) begin
      _T_476 <= 64'h0;
    end else begin
      _T_476 <= io_in_0_bits;
    end
    if (reset) begin
      _T_479 <= 1'h0;
    end else begin
      _T_479 <= io_in_0_valid;
    end
  end
endmodule
module Router_Hw_4( // @[:@2497.2]
  input         clock, // @[:@2498.4]
  input         reset, // @[:@2499.4]
  input         io_in_0_valid, // @[:@2500.4]
  input  [63:0] io_in_0_bits, // @[:@2500.4]
  output        io_in_0_ready, // @[:@2500.4]
  output        io_out_5_valid, // @[:@2500.4]
  output [63:0] io_out_5_bits, // @[:@2500.4]
  input         io_out_5_ready // @[:@2500.4]
);
  reg  decomposed_output_ports_0_5_ready; // @[Router_Hw.scala 163:29:@2570.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_400; // @[Router_Hw.scala 167:32:@2572.4]
  reg [63:0] _RAND_1;
  reg  _T_403; // @[Router_Hw.scala 169:33:@2574.4]
  reg [31:0] _RAND_2;
  assign io_in_0_ready = decomposed_output_ports_0_5_ready; // @[Router_Hw.scala 158:33:@2506.4]
  assign io_out_5_valid = _T_403; // @[Router_Hw.scala 190:35:@2578.4]
  assign io_out_5_bits = _T_400; // @[Router_Hw.scala 189:34:@2577.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_5_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_400 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_403 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_5_ready <= io_out_5_ready;
    if (reset) begin
      _T_400 <= 64'h0;
    end else begin
      _T_400 <= io_in_0_bits;
    end
    if (reset) begin
      _T_403 <= 1'h0;
    end else begin
      _T_403 <= io_in_0_valid;
    end
  end
endmodule
module Router_Hw_5( // @[:@2811.2]
  input         clock, // @[:@2812.4]
  input         reset, // @[:@2813.4]
  input         io_in_0_valid, // @[:@2814.4]
  input  [63:0] io_in_0_bits, // @[:@2814.4]
  output        io_in_0_ready, // @[:@2814.4]
  output        io_out_0_valid, // @[:@2814.4]
  output [63:0] io_out_0_bits, // @[:@2814.4]
  input         io_out_0_ready, // @[:@2814.4]
  output        io_out_1_valid, // @[:@2814.4]
  output [63:0] io_out_1_bits, // @[:@2814.4]
  input         io_out_1_ready, // @[:@2814.4]
  output        io_out_2_valid, // @[:@2814.4]
  output [63:0] io_out_2_bits, // @[:@2814.4]
  input         io_out_2_ready // @[:@2814.4]
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 163:29:@2838.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_364; // @[Router_Hw.scala 167:32:@2840.4]
  reg [63:0] _RAND_1;
  reg  _T_367; // @[Router_Hw.scala 169:33:@2842.4]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 163:29:@2848.4]
  reg [31:0] _RAND_3;
  reg [63:0] _T_378; // @[Router_Hw.scala 167:32:@2850.4]
  reg [63:0] _RAND_4;
  reg  _T_381; // @[Router_Hw.scala 169:33:@2852.4]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 163:29:@2858.4]
  reg [31:0] _RAND_6;
  reg [63:0] _T_392; // @[Router_Hw.scala 167:32:@2860.4]
  reg [63:0] _RAND_7;
  reg  _T_395; // @[Router_Hw.scala 169:33:@2862.4]
  reg [31:0] _RAND_8;
  wire  _T_674; // @[Router_Hw.scala 93:99:@3061.4]
  assign _T_674 = decomposed_output_ports_0_0_ready & decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 93:99:@3061.4]
  assign io_in_0_ready = _T_674 & decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 158:33:@2820.4]
  assign io_out_0_valid = _T_367; // @[Router_Hw.scala 190:35:@2846.4]
  assign io_out_0_bits = _T_364; // @[Router_Hw.scala 189:34:@2845.4]
  assign io_out_1_valid = _T_381; // @[Router_Hw.scala 190:35:@2856.4]
  assign io_out_1_bits = _T_378; // @[Router_Hw.scala 189:34:@2855.4]
  assign io_out_2_valid = _T_395; // @[Router_Hw.scala 190:35:@2866.4]
  assign io_out_2_bits = _T_392; // @[Router_Hw.scala 189:34:@2865.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_364 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_367 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_378 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_381 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_392 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_395 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (reset) begin
      _T_364 <= 64'h0;
    end else begin
      _T_364 <= io_in_0_bits;
    end
    if (reset) begin
      _T_367 <= 1'h0;
    end else begin
      _T_367 <= io_in_0_valid;
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (reset) begin
      _T_378 <= 64'h0;
    end else begin
      _T_378 <= io_in_0_bits;
    end
    if (reset) begin
      _T_381 <= 1'h0;
    end else begin
      _T_381 <= io_in_0_valid;
    end
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    if (reset) begin
      _T_392 <= 64'h0;
    end else begin
      _T_392 <= io_in_0_bits;
    end
    if (reset) begin
      _T_395 <= 1'h0;
    end else begin
      _T_395 <= io_in_0_valid;
    end
  end
endmodule
module Router_Hw_6( // @[:@3177.2]
  input         clock, // @[:@3178.4]
  input         reset, // @[:@3179.4]
  input         io_in_0_valid, // @[:@3180.4]
  input  [63:0] io_in_0_bits, // @[:@3180.4]
  output        io_in_0_ready, // @[:@3180.4]
  input         io_in_0_config, // @[:@3180.4]
  input         io_in_1_valid, // @[:@3180.4]
  input  [63:0] io_in_1_bits, // @[:@3180.4]
  output        io_in_1_ready, // @[:@3180.4]
  input         io_in_2_valid, // @[:@3180.4]
  input  [63:0] io_in_2_bits, // @[:@3180.4]
  output        io_in_2_ready, // @[:@3180.4]
  input         io_in_3_valid, // @[:@3180.4]
  input  [63:0] io_in_3_bits, // @[:@3180.4]
  output        io_in_3_ready, // @[:@3180.4]
  output        io_out_0_valid, // @[:@3180.4]
  output [63:0] io_out_0_bits, // @[:@3180.4]
  input         io_out_0_ready, // @[:@3180.4]
  output        io_out_1_valid, // @[:@3180.4]
  output [63:0] io_out_1_bits, // @[:@3180.4]
  input         io_out_1_ready, // @[:@3180.4]
  output        io_out_2_valid, // @[:@3180.4]
  output [63:0] io_out_2_bits, // @[:@3180.4]
  input         io_out_2_ready // @[:@3180.4]
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 163:29:@3200.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_315; // @[Router_Hw.scala 167:32:@3202.4]
  reg [63:0] _RAND_1;
  reg  _T_318; // @[Router_Hw.scala 169:33:@3204.4]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 163:29:@3210.4]
  reg [31:0] _RAND_3;
  reg [63:0] _T_329; // @[Router_Hw.scala 167:32:@3212.4]
  reg [63:0] _RAND_4;
  reg  _T_332; // @[Router_Hw.scala 169:33:@3214.4]
  reg [31:0] _RAND_5;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 163:29:@3220.4]
  reg [31:0] _RAND_6;
  reg [63:0] _T_343; // @[Router_Hw.scala 167:32:@3222.4]
  reg [63:0] _RAND_7;
  reg  _T_346; // @[Router_Hw.scala 169:33:@3224.4]
  reg [31:0] _RAND_8;
  reg [9:0] config_register_file_0; // @[Router_Hw.scala 117:37:@3433.4]
  reg [31:0] _RAND_9;
  wire [1:0] _T_385; // @[Router_Hw.scala 82:28:@3251.4]
  wire  _T_387; // @[Mux.scala 46:19:@3252.4]
  wire [63:0] _T_388; // @[Mux.scala 46:16:@3253.4]
  wire  _T_389; // @[Mux.scala 46:19:@3254.4]
  wire [63:0] _T_390; // @[Mux.scala 46:16:@3255.4]
  wire  _T_391; // @[Mux.scala 46:19:@3256.4]
  wire [63:0] _T_392; // @[Mux.scala 46:16:@3257.4]
  wire  _T_393; // @[Mux.scala 46:19:@3258.4]
  wire [63:0] decomposed_output_ports_0_0_bits; // @[Mux.scala 46:16:@3259.4]
  wire  _T_398; // @[Mux.scala 46:16:@3263.4]
  wire  _T_400; // @[Mux.scala 46:16:@3265.4]
  wire  _T_402; // @[Mux.scala 46:16:@3267.4]
  wire  decomposed_output_ports_0_0_valid; // @[Mux.scala 46:16:@3269.4]
  wire [1:0] _T_413; // @[Router_Hw.scala 82:28:@3271.4]
  wire  _T_415; // @[Mux.scala 46:19:@3272.4]
  wire [63:0] _T_416; // @[Mux.scala 46:16:@3273.4]
  wire  _T_417; // @[Mux.scala 46:19:@3274.4]
  wire [63:0] _T_418; // @[Mux.scala 46:16:@3275.4]
  wire  _T_419; // @[Mux.scala 46:19:@3276.4]
  wire [63:0] _T_420; // @[Mux.scala 46:16:@3277.4]
  wire  _T_421; // @[Mux.scala 46:19:@3278.4]
  wire [63:0] decomposed_output_ports_0_1_bits; // @[Mux.scala 46:16:@3279.4]
  wire  _T_426; // @[Mux.scala 46:16:@3283.4]
  wire  _T_428; // @[Mux.scala 46:16:@3285.4]
  wire  _T_430; // @[Mux.scala 46:16:@3287.4]
  wire  decomposed_output_ports_0_1_valid; // @[Mux.scala 46:16:@3289.4]
  wire [1:0] _T_441; // @[Router_Hw.scala 82:28:@3291.4]
  wire  _T_443; // @[Mux.scala 46:19:@3292.4]
  wire [63:0] _T_444; // @[Mux.scala 46:16:@3293.4]
  wire  _T_445; // @[Mux.scala 46:19:@3294.4]
  wire [63:0] _T_446; // @[Mux.scala 46:16:@3295.4]
  wire  _T_447; // @[Mux.scala 46:19:@3296.4]
  wire [63:0] _T_448; // @[Mux.scala 46:16:@3297.4]
  wire  _T_449; // @[Mux.scala 46:19:@3298.4]
  wire [63:0] decomposed_output_ports_0_2_bits; // @[Mux.scala 46:16:@3299.4]
  wire  _T_454; // @[Mux.scala 46:16:@3303.4]
  wire  _T_456; // @[Mux.scala 46:16:@3305.4]
  wire  _T_458; // @[Mux.scala 46:16:@3307.4]
  wire  decomposed_output_ports_0_2_valid; // @[Mux.scala 46:16:@3309.4]
  wire  _T_519; // @[Router_Hw.scala 90:53:@3352.4]
  wire  _T_521; // @[Router_Hw.scala 90:10:@3353.4]
  wire  _T_524; // @[Router_Hw.scala 90:53:@3355.4]
  wire  _T_526; // @[Router_Hw.scala 90:10:@3356.4]
  wire  _T_529; // @[Router_Hw.scala 90:53:@3358.4]
  wire  _T_531; // @[Router_Hw.scala 90:10:@3359.4]
  wire  _T_542; // @[Router_Hw.scala 93:99:@3366.4]
  wire  _T_548; // @[Router_Hw.scala 90:53:@3372.4]
  wire  _T_550; // @[Router_Hw.scala 90:10:@3373.4]
  wire  _T_553; // @[Router_Hw.scala 90:53:@3375.4]
  wire  _T_555; // @[Router_Hw.scala 90:10:@3376.4]
  wire  _T_558; // @[Router_Hw.scala 90:53:@3378.4]
  wire  _T_560; // @[Router_Hw.scala 90:10:@3379.4]
  wire  _T_571; // @[Router_Hw.scala 93:99:@3386.4]
  wire  _T_577; // @[Router_Hw.scala 90:53:@3392.4]
  wire  _T_579; // @[Router_Hw.scala 90:10:@3393.4]
  wire  _T_582; // @[Router_Hw.scala 90:53:@3395.4]
  wire  _T_584; // @[Router_Hw.scala 90:10:@3396.4]
  wire  _T_587; // @[Router_Hw.scala 90:53:@3398.4]
  wire  _T_589; // @[Router_Hw.scala 90:10:@3399.4]
  wire  _T_600; // @[Router_Hw.scala 93:99:@3406.4]
  wire  _T_606; // @[Router_Hw.scala 90:53:@3412.4]
  wire  _T_608; // @[Router_Hw.scala 90:10:@3413.4]
  wire  _T_611; // @[Router_Hw.scala 90:53:@3415.4]
  wire  _T_613; // @[Router_Hw.scala 90:10:@3416.4]
  wire  _T_616; // @[Router_Hw.scala 90:53:@3418.4]
  wire  _T_618; // @[Router_Hw.scala 90:10:@3419.4]
  wire  _T_629; // @[Router_Hw.scala 93:99:@3426.4]
  wire [4:0] config_module_id; // @[Router_Hw.scala 128:44:@3436.4]
  wire  module_id_match; // @[Router_Hw.scala 129:49:@3437.4]
  wire [9:0] config_data; // @[Router_Hw.scala 131:39:@3439.4]
  wire  _T_656; // @[Router_Hw.scala 132:22:@3440.4]
  wire [9:0] _GEN_0; // @[Router_Hw.scala 132:41:@3441.4]
  assign _T_385 = config_register_file_0[1:0]; // @[Router_Hw.scala 82:28:@3251.4]
  assign _T_387 = 2'h3 == _T_385; // @[Mux.scala 46:19:@3252.4]
  assign _T_388 = _T_387 ? io_in_3_bits : 64'h0; // @[Mux.scala 46:16:@3253.4]
  assign _T_389 = 2'h2 == _T_385; // @[Mux.scala 46:19:@3254.4]
  assign _T_390 = _T_389 ? io_in_2_bits : _T_388; // @[Mux.scala 46:16:@3255.4]
  assign _T_391 = 2'h1 == _T_385; // @[Mux.scala 46:19:@3256.4]
  assign _T_392 = _T_391 ? io_in_1_bits : _T_390; // @[Mux.scala 46:16:@3257.4]
  assign _T_393 = 2'h0 == _T_385; // @[Mux.scala 46:19:@3258.4]
  assign decomposed_output_ports_0_0_bits = _T_393 ? io_in_0_bits : _T_392; // @[Mux.scala 46:16:@3259.4]
  assign _T_398 = _T_387 ? io_in_3_valid : 1'h0; // @[Mux.scala 46:16:@3263.4]
  assign _T_400 = _T_389 ? io_in_2_valid : _T_398; // @[Mux.scala 46:16:@3265.4]
  assign _T_402 = _T_391 ? io_in_1_valid : _T_400; // @[Mux.scala 46:16:@3267.4]
  assign decomposed_output_ports_0_0_valid = _T_393 ? io_in_0_valid : _T_402; // @[Mux.scala 46:16:@3269.4]
  assign _T_413 = config_register_file_0[3:2]; // @[Router_Hw.scala 82:28:@3271.4]
  assign _T_415 = 2'h3 == _T_413; // @[Mux.scala 46:19:@3272.4]
  assign _T_416 = _T_415 ? io_in_3_bits : 64'h0; // @[Mux.scala 46:16:@3273.4]
  assign _T_417 = 2'h2 == _T_413; // @[Mux.scala 46:19:@3274.4]
  assign _T_418 = _T_417 ? io_in_2_bits : _T_416; // @[Mux.scala 46:16:@3275.4]
  assign _T_419 = 2'h1 == _T_413; // @[Mux.scala 46:19:@3276.4]
  assign _T_420 = _T_419 ? io_in_1_bits : _T_418; // @[Mux.scala 46:16:@3277.4]
  assign _T_421 = 2'h0 == _T_413; // @[Mux.scala 46:19:@3278.4]
  assign decomposed_output_ports_0_1_bits = _T_421 ? io_in_0_bits : _T_420; // @[Mux.scala 46:16:@3279.4]
  assign _T_426 = _T_415 ? io_in_3_valid : 1'h0; // @[Mux.scala 46:16:@3283.4]
  assign _T_428 = _T_417 ? io_in_2_valid : _T_426; // @[Mux.scala 46:16:@3285.4]
  assign _T_430 = _T_419 ? io_in_1_valid : _T_428; // @[Mux.scala 46:16:@3287.4]
  assign decomposed_output_ports_0_1_valid = _T_421 ? io_in_0_valid : _T_430; // @[Mux.scala 46:16:@3289.4]
  assign _T_441 = config_register_file_0[5:4]; // @[Router_Hw.scala 82:28:@3291.4]
  assign _T_443 = 2'h3 == _T_441; // @[Mux.scala 46:19:@3292.4]
  assign _T_444 = _T_443 ? io_in_3_bits : 64'h0; // @[Mux.scala 46:16:@3293.4]
  assign _T_445 = 2'h2 == _T_441; // @[Mux.scala 46:19:@3294.4]
  assign _T_446 = _T_445 ? io_in_2_bits : _T_444; // @[Mux.scala 46:16:@3295.4]
  assign _T_447 = 2'h1 == _T_441; // @[Mux.scala 46:19:@3296.4]
  assign _T_448 = _T_447 ? io_in_1_bits : _T_446; // @[Mux.scala 46:16:@3297.4]
  assign _T_449 = 2'h0 == _T_441; // @[Mux.scala 46:19:@3298.4]
  assign decomposed_output_ports_0_2_bits = _T_449 ? io_in_0_bits : _T_448; // @[Mux.scala 46:16:@3299.4]
  assign _T_454 = _T_443 ? io_in_3_valid : 1'h0; // @[Mux.scala 46:16:@3303.4]
  assign _T_456 = _T_445 ? io_in_2_valid : _T_454; // @[Mux.scala 46:16:@3305.4]
  assign _T_458 = _T_447 ? io_in_1_valid : _T_456; // @[Mux.scala 46:16:@3307.4]
  assign decomposed_output_ports_0_2_valid = _T_449 ? io_in_0_valid : _T_458; // @[Mux.scala 46:16:@3309.4]
  assign _T_519 = _T_385 == 2'h0; // @[Router_Hw.scala 90:53:@3352.4]
  assign _T_521 = _T_519 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@3353.4]
  assign _T_524 = _T_413 == 2'h0; // @[Router_Hw.scala 90:53:@3355.4]
  assign _T_526 = _T_524 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@3356.4]
  assign _T_529 = _T_441 == 2'h0; // @[Router_Hw.scala 90:53:@3358.4]
  assign _T_531 = _T_529 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 90:10:@3359.4]
  assign _T_542 = _T_521 & _T_526; // @[Router_Hw.scala 93:99:@3366.4]
  assign _T_548 = _T_385 == 2'h1; // @[Router_Hw.scala 90:53:@3372.4]
  assign _T_550 = _T_548 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@3373.4]
  assign _T_553 = _T_413 == 2'h1; // @[Router_Hw.scala 90:53:@3375.4]
  assign _T_555 = _T_553 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@3376.4]
  assign _T_558 = _T_441 == 2'h1; // @[Router_Hw.scala 90:53:@3378.4]
  assign _T_560 = _T_558 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 90:10:@3379.4]
  assign _T_571 = _T_550 & _T_555; // @[Router_Hw.scala 93:99:@3386.4]
  assign _T_577 = _T_385 == 2'h2; // @[Router_Hw.scala 90:53:@3392.4]
  assign _T_579 = _T_577 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@3393.4]
  assign _T_582 = _T_413 == 2'h2; // @[Router_Hw.scala 90:53:@3395.4]
  assign _T_584 = _T_582 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@3396.4]
  assign _T_587 = _T_441 == 2'h2; // @[Router_Hw.scala 90:53:@3398.4]
  assign _T_589 = _T_587 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 90:10:@3399.4]
  assign _T_600 = _T_579 & _T_584; // @[Router_Hw.scala 93:99:@3406.4]
  assign _T_606 = _T_385 == 2'h3; // @[Router_Hw.scala 90:53:@3412.4]
  assign _T_608 = _T_606 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@3413.4]
  assign _T_611 = _T_413 == 2'h3; // @[Router_Hw.scala 90:53:@3415.4]
  assign _T_613 = _T_611 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@3416.4]
  assign _T_616 = _T_441 == 2'h3; // @[Router_Hw.scala 90:53:@3418.4]
  assign _T_618 = _T_616 ? decomposed_output_ports_0_2_ready : 1'h1; // @[Router_Hw.scala 90:10:@3419.4]
  assign _T_629 = _T_608 & _T_613; // @[Router_Hw.scala 93:99:@3426.4]
  assign config_module_id = io_in_0_bits[63:59]; // @[Router_Hw.scala 128:44:@3436.4]
  assign module_id_match = config_module_id == 5'ha; // @[Router_Hw.scala 129:49:@3437.4]
  assign config_data = io_in_0_bits[9:0]; // @[Router_Hw.scala 131:39:@3439.4]
  assign _T_656 = io_in_0_config & module_id_match; // @[Router_Hw.scala 132:22:@3440.4]
  assign _GEN_0 = _T_656 ? config_data : config_register_file_0; // @[Router_Hw.scala 132:41:@3441.4]
  assign io_in_0_ready = _T_542 & _T_531; // @[Router_Hw.scala 158:33:@3186.4]
  assign io_in_1_ready = _T_571 & _T_560; // @[Router_Hw.scala 158:33:@3190.4]
  assign io_in_2_ready = _T_600 & _T_589; // @[Router_Hw.scala 158:33:@3194.4]
  assign io_in_3_ready = _T_629 & _T_618; // @[Router_Hw.scala 158:33:@3198.4]
  assign io_out_0_valid = _T_318; // @[Router_Hw.scala 190:35:@3208.4]
  assign io_out_0_bits = _T_315; // @[Router_Hw.scala 189:34:@3207.4]
  assign io_out_1_valid = _T_332; // @[Router_Hw.scala 190:35:@3218.4]
  assign io_out_1_bits = _T_329; // @[Router_Hw.scala 189:34:@3217.4]
  assign io_out_2_valid = _T_346; // @[Router_Hw.scala 190:35:@3228.4]
  assign io_out_2_bits = _T_343; // @[Router_Hw.scala 189:34:@3227.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_315 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_318 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_329 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_332 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_6[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {2{`RANDOM}};
  _T_343 = _RAND_7[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  _T_346 = _RAND_8[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  config_register_file_0 = _RAND_9[9:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (reset) begin
      _T_315 <= 64'h0;
    end else begin
      if (_T_393) begin
        _T_315 <= io_in_0_bits;
      end else begin
        if (_T_391) begin
          _T_315 <= io_in_1_bits;
        end else begin
          if (_T_389) begin
            _T_315 <= io_in_2_bits;
          end else begin
            if (_T_387) begin
              _T_315 <= io_in_3_bits;
            end else begin
              _T_315 <= 64'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      _T_318 <= 1'h0;
    end else begin
      if (_T_393) begin
        _T_318 <= io_in_0_valid;
      end else begin
        if (_T_391) begin
          _T_318 <= io_in_1_valid;
        end else begin
          if (_T_389) begin
            _T_318 <= io_in_2_valid;
          end else begin
            if (_T_387) begin
              _T_318 <= io_in_3_valid;
            end else begin
              _T_318 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (reset) begin
      _T_329 <= 64'h0;
    end else begin
      if (_T_421) begin
        _T_329 <= io_in_0_bits;
      end else begin
        if (_T_419) begin
          _T_329 <= io_in_1_bits;
        end else begin
          if (_T_417) begin
            _T_329 <= io_in_2_bits;
          end else begin
            if (_T_415) begin
              _T_329 <= io_in_3_bits;
            end else begin
              _T_329 <= 64'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      _T_332 <= 1'h0;
    end else begin
      if (_T_421) begin
        _T_332 <= io_in_0_valid;
      end else begin
        if (_T_419) begin
          _T_332 <= io_in_1_valid;
        end else begin
          if (_T_417) begin
            _T_332 <= io_in_2_valid;
          end else begin
            if (_T_415) begin
              _T_332 <= io_in_3_valid;
            end else begin
              _T_332 <= 1'h0;
            end
          end
        end
      end
    end
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    if (reset) begin
      _T_343 <= 64'h0;
    end else begin
      if (_T_449) begin
        _T_343 <= io_in_0_bits;
      end else begin
        if (_T_447) begin
          _T_343 <= io_in_1_bits;
        end else begin
          if (_T_445) begin
            _T_343 <= io_in_2_bits;
          end else begin
            if (_T_443) begin
              _T_343 <= io_in_3_bits;
            end else begin
              _T_343 <= 64'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      _T_346 <= 1'h0;
    end else begin
      if (_T_449) begin
        _T_346 <= io_in_0_valid;
      end else begin
        if (_T_447) begin
          _T_346 <= io_in_1_valid;
        end else begin
          if (_T_445) begin
            _T_346 <= io_in_2_valid;
          end else begin
            if (_T_443) begin
              _T_346 <= io_in_3_valid;
            end else begin
              _T_346 <= 1'h0;
            end
          end
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 10'h0;
    end else begin
      if (_T_656) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Router_Hw_7( // @[:@3445.2]
  input         clock, // @[:@3446.4]
  input         reset, // @[:@3447.4]
  input         io_in_0_valid, // @[:@3448.4]
  input  [63:0] io_in_0_bits, // @[:@3448.4]
  output        io_in_0_ready, // @[:@3448.4]
  output        io_out_0_valid, // @[:@3448.4]
  output [63:0] io_out_0_bits, // @[:@3448.4]
  input         io_out_0_ready, // @[:@3448.4]
  output        io_out_1_valid, // @[:@3448.4]
  output [63:0] io_out_1_bits, // @[:@3448.4]
  input         io_out_1_ready // @[:@3448.4]
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 163:29:@3468.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_315; // @[Router_Hw.scala 167:32:@3470.4]
  reg [63:0] _RAND_1;
  reg  _T_318; // @[Router_Hw.scala 169:33:@3472.4]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 163:29:@3478.4]
  reg [31:0] _RAND_3;
  reg [63:0] _T_329; // @[Router_Hw.scala 167:32:@3480.4]
  reg [63:0] _RAND_4;
  reg  _T_332; // @[Router_Hw.scala 169:33:@3482.4]
  reg [31:0] _RAND_5;
  assign io_in_0_ready = decomposed_output_ports_0_0_ready & decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 158:33:@3454.4]
  assign io_out_0_valid = _T_318; // @[Router_Hw.scala 190:35:@3476.4]
  assign io_out_0_bits = _T_315; // @[Router_Hw.scala 189:34:@3475.4]
  assign io_out_1_valid = _T_332; // @[Router_Hw.scala 190:35:@3486.4]
  assign io_out_1_bits = _T_329; // @[Router_Hw.scala 189:34:@3485.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_315 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_318 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_329 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_332 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (reset) begin
      _T_315 <= 64'h0;
    end else begin
      _T_315 <= io_in_0_bits;
    end
    if (reset) begin
      _T_318 <= 1'h0;
    end else begin
      _T_318 <= io_in_0_valid;
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (reset) begin
      _T_329 <= 64'h0;
    end else begin
      _T_329 <= io_in_0_bits;
    end
    if (reset) begin
      _T_332 <= 1'h0;
    end else begin
      _T_332 <= io_in_0_valid;
    end
  end
endmodule
module Router_Hw_8( // @[:@3713.2]
  input         clock, // @[:@3714.4]
  input         reset, // @[:@3715.4]
  input         io_in_0_valid, // @[:@3716.4]
  input  [63:0] io_in_0_bits, // @[:@3716.4]
  output        io_in_0_ready, // @[:@3716.4]
  output        io_out_1_valid, // @[:@3716.4]
  output [63:0] io_out_1_bits, // @[:@3716.4]
  input         io_out_1_ready // @[:@3716.4]
);
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 163:29:@3742.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_280; // @[Router_Hw.scala 167:32:@3744.4]
  reg [63:0] _RAND_1;
  reg  _T_283; // @[Router_Hw.scala 169:33:@3746.4]
  reg [31:0] _RAND_2;
  assign io_in_0_ready = decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 158:33:@3722.4]
  assign io_out_1_valid = _T_283; // @[Router_Hw.scala 190:35:@3750.4]
  assign io_out_1_bits = _T_280; // @[Router_Hw.scala 189:34:@3749.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_280 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_283 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (reset) begin
      _T_280 <= 64'h0;
    end else begin
      _T_280 <= io_in_0_bits;
    end
    if (reset) begin
      _T_283 <= 1'h0;
    end else begin
      _T_283 <= io_in_0_valid;
    end
  end
endmodule
module Router_Hw_9( // @[:@3899.2]
  input         clock, // @[:@3900.4]
  input         reset, // @[:@3901.4]
  input         io_in_0_valid, // @[:@3902.4]
  input  [63:0] io_in_0_bits, // @[:@3902.4]
  output        io_in_0_ready, // @[:@3902.4]
  output        io_out_1_valid, // @[:@3902.4]
  output [63:0] io_out_1_bits, // @[:@3902.4]
  input         io_out_1_ready // @[:@3902.4]
);
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 163:29:@3936.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_408; // @[Router_Hw.scala 167:32:@3938.4]
  reg [63:0] _RAND_1;
  reg  _T_411; // @[Router_Hw.scala 169:33:@3940.4]
  reg [31:0] _RAND_2;
  assign io_in_0_ready = decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 158:33:@3908.4]
  assign io_out_1_valid = _T_411; // @[Router_Hw.scala 190:35:@3944.4]
  assign io_out_1_bits = _T_408; // @[Router_Hw.scala 189:34:@3943.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_408 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_411 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (reset) begin
      _T_408 <= 64'h0;
    end else begin
      _T_408 <= io_in_0_bits;
    end
    if (reset) begin
      _T_411 <= 1'h0;
    end else begin
      _T_411 <= io_in_0_valid;
    end
  end
endmodule
module Router_Hw_10( // @[:@4373.2]
  input         clock, // @[:@4374.4]
  input         reset, // @[:@4375.4]
  input         io_in_0_valid, // @[:@4376.4]
  input  [63:0] io_in_0_bits, // @[:@4376.4]
  output        io_in_0_ready, // @[:@4376.4]
  output        io_out_3_valid, // @[:@4376.4]
  output [63:0] io_out_3_bits, // @[:@4376.4]
  input         io_out_3_ready // @[:@4376.4]
);
  reg  decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 163:29:@4418.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_274; // @[Router_Hw.scala 167:32:@4420.4]
  reg [63:0] _RAND_1;
  reg  _T_277; // @[Router_Hw.scala 169:33:@4422.4]
  reg [31:0] _RAND_2;
  assign io_in_0_ready = decomposed_output_ports_0_3_ready; // @[Router_Hw.scala 158:33:@4382.4]
  assign io_out_3_valid = _T_277; // @[Router_Hw.scala 190:35:@4426.4]
  assign io_out_3_bits = _T_274; // @[Router_Hw.scala 189:34:@4425.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_3_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_274 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_277 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_3_ready <= io_out_3_ready;
    if (reset) begin
      _T_274 <= 64'h0;
    end else begin
      _T_274 <= io_in_0_bits;
    end
    if (reset) begin
      _T_277 <= 1'h0;
    end else begin
      _T_277 <= io_in_0_valid;
    end
  end
endmodule
module Router_Hw_11( // @[:@4523.2]
  input         clock, // @[:@4524.4]
  input         reset, // @[:@4525.4]
  input         io_in_0_valid, // @[:@4526.4]
  input  [63:0] io_in_0_bits, // @[:@4526.4]
  output        io_in_0_ready, // @[:@4526.4]
  output        io_out_0_valid, // @[:@4526.4]
  output [63:0] io_out_0_bits, // @[:@4526.4]
  input         io_out_0_ready, // @[:@4526.4]
  output        io_out_1_valid, // @[:@4526.4]
  output [63:0] io_out_1_bits, // @[:@4526.4]
  input         io_out_1_ready // @[:@4526.4]
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 163:29:@4554.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_428; // @[Router_Hw.scala 167:32:@4556.4]
  reg [63:0] _RAND_1;
  reg  _T_431; // @[Router_Hw.scala 169:33:@4558.4]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 163:29:@4564.4]
  reg [31:0] _RAND_3;
  reg [63:0] _T_442; // @[Router_Hw.scala 167:32:@4566.4]
  reg [63:0] _RAND_4;
  reg  _T_445; // @[Router_Hw.scala 169:33:@4568.4]
  reg [31:0] _RAND_5;
  assign io_in_0_ready = decomposed_output_ports_0_0_ready & decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 158:33:@4532.4]
  assign io_out_0_valid = _T_431; // @[Router_Hw.scala 190:35:@4562.4]
  assign io_out_0_bits = _T_428; // @[Router_Hw.scala 189:34:@4561.4]
  assign io_out_1_valid = _T_445; // @[Router_Hw.scala 190:35:@4572.4]
  assign io_out_1_bits = _T_442; // @[Router_Hw.scala 189:34:@4571.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_428 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_431 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_442 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_445 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (reset) begin
      _T_428 <= 64'h0;
    end else begin
      _T_428 <= io_in_0_bits;
    end
    if (reset) begin
      _T_431 <= 1'h0;
    end else begin
      _T_431 <= io_in_0_valid;
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (reset) begin
      _T_442 <= 64'h0;
    end else begin
      _T_442 <= io_in_0_bits;
    end
    if (reset) begin
      _T_445 <= 1'h0;
    end else begin
      _T_445 <= io_in_0_valid;
    end
  end
endmodule
module Router_Hw_12( // @[:@5065.2]
  input         clock, // @[:@5066.4]
  input         reset, // @[:@5067.4]
  input         io_in_0_valid, // @[:@5068.4]
  input  [63:0] io_in_0_bits, // @[:@5068.4]
  output        io_in_0_ready, // @[:@5068.4]
  output        io_out_1_valid, // @[:@5068.4]
  output [63:0] io_out_1_bits, // @[:@5068.4]
  input         io_out_1_ready, // @[:@5068.4]
  output        io_out_2_valid, // @[:@5068.4]
  output [63:0] io_out_2_bits, // @[:@5068.4]
  input         io_out_2_ready // @[:@5068.4]
);
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 163:29:@5102.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_378; // @[Router_Hw.scala 167:32:@5104.4]
  reg [63:0] _RAND_1;
  reg  _T_381; // @[Router_Hw.scala 169:33:@5106.4]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 163:29:@5112.4]
  reg [31:0] _RAND_3;
  reg [63:0] _T_392; // @[Router_Hw.scala 167:32:@5114.4]
  reg [63:0] _RAND_4;
  reg  _T_395; // @[Router_Hw.scala 169:33:@5116.4]
  reg [31:0] _RAND_5;
  assign io_in_0_ready = decomposed_output_ports_0_1_ready & decomposed_output_ports_0_2_ready; // @[Router_Hw.scala 158:33:@5074.4]
  assign io_out_1_valid = _T_381; // @[Router_Hw.scala 190:35:@5110.4]
  assign io_out_1_bits = _T_378; // @[Router_Hw.scala 189:34:@5109.4]
  assign io_out_2_valid = _T_395; // @[Router_Hw.scala 190:35:@5120.4]
  assign io_out_2_bits = _T_392; // @[Router_Hw.scala 189:34:@5119.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_378 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_381 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_2_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_392 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_395 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (reset) begin
      _T_378 <= 64'h0;
    end else begin
      _T_378 <= io_in_0_bits;
    end
    if (reset) begin
      _T_381 <= 1'h0;
    end else begin
      _T_381 <= io_in_0_valid;
    end
    decomposed_output_ports_0_2_ready <= io_out_2_ready;
    if (reset) begin
      _T_392 <= 64'h0;
    end else begin
      _T_392 <= io_in_0_bits;
    end
    if (reset) begin
      _T_395 <= 1'h0;
    end else begin
      _T_395 <= io_in_0_valid;
    end
  end
endmodule
module Router_Hw_13( // @[:@5431.2]
  input         clock, // @[:@5432.4]
  input         reset, // @[:@5433.4]
  input         io_in_0_valid, // @[:@5434.4]
  input  [63:0] io_in_0_bits, // @[:@5434.4]
  output        io_in_0_ready, // @[:@5434.4]
  input         io_in_1_valid, // @[:@5434.4]
  input  [63:0] io_in_1_bits, // @[:@5434.4]
  output        io_in_1_ready, // @[:@5434.4]
  input         io_in_2_valid, // @[:@5434.4]
  input  [63:0] io_in_2_bits, // @[:@5434.4]
  output        io_in_2_ready, // @[:@5434.4]
  input         io_in_2_config, // @[:@5434.4]
  output        io_out_0_valid, // @[:@5434.4]
  output [63:0] io_out_0_bits, // @[:@5434.4]
  input         io_out_0_ready, // @[:@5434.4]
  output        io_out_1_valid, // @[:@5434.4]
  output [63:0] io_out_1_bits, // @[:@5434.4]
  input         io_out_1_ready // @[:@5434.4]
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 163:29:@5450.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_251; // @[Router_Hw.scala 167:32:@5452.4]
  reg [63:0] _RAND_1;
  reg  _T_254; // @[Router_Hw.scala 169:33:@5454.4]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 163:29:@5460.4]
  reg [31:0] _RAND_3;
  reg [63:0] _T_265; // @[Router_Hw.scala 167:32:@5462.4]
  reg [63:0] _RAND_4;
  reg  _T_268; // @[Router_Hw.scala 169:33:@5464.4]
  reg [31:0] _RAND_5;
  reg [5:0] config_register_file_0; // @[Router_Hw.scala 117:37:@5567.4]
  reg [31:0] _RAND_6;
  wire [1:0] _T_291; // @[Router_Hw.scala 82:28:@5481.4]
  wire  _T_293; // @[Mux.scala 46:19:@5482.4]
  wire [63:0] _T_294; // @[Mux.scala 46:16:@5483.4]
  wire  _T_295; // @[Mux.scala 46:19:@5484.4]
  wire [63:0] _T_296; // @[Mux.scala 46:16:@5485.4]
  wire  _T_297; // @[Mux.scala 46:19:@5486.4]
  wire [63:0] decomposed_output_ports_0_0_bits; // @[Mux.scala 46:16:@5487.4]
  wire  _T_302; // @[Mux.scala 46:16:@5491.4]
  wire  _T_304; // @[Mux.scala 46:16:@5493.4]
  wire  decomposed_output_ports_0_0_valid; // @[Mux.scala 46:16:@5495.4]
  wire [1:0] _T_313; // @[Router_Hw.scala 82:28:@5497.4]
  wire  _T_315; // @[Mux.scala 46:19:@5498.4]
  wire [63:0] _T_316; // @[Mux.scala 46:16:@5499.4]
  wire  _T_317; // @[Mux.scala 46:19:@5500.4]
  wire [63:0] _T_318; // @[Mux.scala 46:16:@5501.4]
  wire  _T_319; // @[Mux.scala 46:19:@5502.4]
  wire [63:0] decomposed_output_ports_0_1_bits; // @[Mux.scala 46:16:@5503.4]
  wire  _T_324; // @[Mux.scala 46:16:@5507.4]
  wire  _T_326; // @[Mux.scala 46:16:@5509.4]
  wire  decomposed_output_ports_0_1_valid; // @[Mux.scala 46:16:@5511.4]
  wire  _T_353; // @[Router_Hw.scala 90:53:@5530.4]
  wire  _T_355; // @[Router_Hw.scala 90:10:@5531.4]
  wire  _T_358; // @[Router_Hw.scala 90:53:@5533.4]
  wire  _T_360; // @[Router_Hw.scala 90:10:@5534.4]
  wire  _T_370; // @[Router_Hw.scala 90:53:@5542.4]
  wire  _T_372; // @[Router_Hw.scala 90:10:@5543.4]
  wire  _T_375; // @[Router_Hw.scala 90:53:@5545.4]
  wire  _T_377; // @[Router_Hw.scala 90:10:@5546.4]
  wire  _T_387; // @[Router_Hw.scala 90:53:@5554.4]
  wire  _T_389; // @[Router_Hw.scala 90:10:@5555.4]
  wire  _T_392; // @[Router_Hw.scala 90:53:@5557.4]
  wire  _T_394; // @[Router_Hw.scala 90:10:@5558.4]
  wire [4:0] config_module_id; // @[Router_Hw.scala 128:44:@5570.4]
  wire  module_id_match; // @[Router_Hw.scala 129:49:@5571.4]
  wire [5:0] config_data; // @[Router_Hw.scala 131:39:@5573.4]
  wire  _T_425; // @[Router_Hw.scala 132:22:@5574.4]
  wire [5:0] _GEN_0; // @[Router_Hw.scala 132:41:@5575.4]
  assign _T_291 = config_register_file_0[1:0]; // @[Router_Hw.scala 82:28:@5481.4]
  assign _T_293 = 2'h2 == _T_291; // @[Mux.scala 46:19:@5482.4]
  assign _T_294 = _T_293 ? io_in_2_bits : 64'h0; // @[Mux.scala 46:16:@5483.4]
  assign _T_295 = 2'h1 == _T_291; // @[Mux.scala 46:19:@5484.4]
  assign _T_296 = _T_295 ? io_in_1_bits : _T_294; // @[Mux.scala 46:16:@5485.4]
  assign _T_297 = 2'h0 == _T_291; // @[Mux.scala 46:19:@5486.4]
  assign decomposed_output_ports_0_0_bits = _T_297 ? io_in_0_bits : _T_296; // @[Mux.scala 46:16:@5487.4]
  assign _T_302 = _T_293 ? io_in_2_valid : 1'h0; // @[Mux.scala 46:16:@5491.4]
  assign _T_304 = _T_295 ? io_in_1_valid : _T_302; // @[Mux.scala 46:16:@5493.4]
  assign decomposed_output_ports_0_0_valid = _T_297 ? io_in_0_valid : _T_304; // @[Mux.scala 46:16:@5495.4]
  assign _T_313 = config_register_file_0[3:2]; // @[Router_Hw.scala 82:28:@5497.4]
  assign _T_315 = 2'h2 == _T_313; // @[Mux.scala 46:19:@5498.4]
  assign _T_316 = _T_315 ? io_in_2_bits : 64'h0; // @[Mux.scala 46:16:@5499.4]
  assign _T_317 = 2'h1 == _T_313; // @[Mux.scala 46:19:@5500.4]
  assign _T_318 = _T_317 ? io_in_1_bits : _T_316; // @[Mux.scala 46:16:@5501.4]
  assign _T_319 = 2'h0 == _T_313; // @[Mux.scala 46:19:@5502.4]
  assign decomposed_output_ports_0_1_bits = _T_319 ? io_in_0_bits : _T_318; // @[Mux.scala 46:16:@5503.4]
  assign _T_324 = _T_315 ? io_in_2_valid : 1'h0; // @[Mux.scala 46:16:@5507.4]
  assign _T_326 = _T_317 ? io_in_1_valid : _T_324; // @[Mux.scala 46:16:@5509.4]
  assign decomposed_output_ports_0_1_valid = _T_319 ? io_in_0_valid : _T_326; // @[Mux.scala 46:16:@5511.4]
  assign _T_353 = _T_291 == 2'h0; // @[Router_Hw.scala 90:53:@5530.4]
  assign _T_355 = _T_353 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@5531.4]
  assign _T_358 = _T_313 == 2'h0; // @[Router_Hw.scala 90:53:@5533.4]
  assign _T_360 = _T_358 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@5534.4]
  assign _T_370 = _T_291 == 2'h1; // @[Router_Hw.scala 90:53:@5542.4]
  assign _T_372 = _T_370 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@5543.4]
  assign _T_375 = _T_313 == 2'h1; // @[Router_Hw.scala 90:53:@5545.4]
  assign _T_377 = _T_375 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@5546.4]
  assign _T_387 = _T_291 == 2'h2; // @[Router_Hw.scala 90:53:@5554.4]
  assign _T_389 = _T_387 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@5555.4]
  assign _T_392 = _T_313 == 2'h2; // @[Router_Hw.scala 90:53:@5557.4]
  assign _T_394 = _T_392 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@5558.4]
  assign config_module_id = io_in_2_bits[63:59]; // @[Router_Hw.scala 128:44:@5570.4]
  assign module_id_match = config_module_id == 5'h9; // @[Router_Hw.scala 129:49:@5571.4]
  assign config_data = io_in_2_bits[5:0]; // @[Router_Hw.scala 131:39:@5573.4]
  assign _T_425 = io_in_2_config & module_id_match; // @[Router_Hw.scala 132:22:@5574.4]
  assign _GEN_0 = _T_425 ? config_data : config_register_file_0; // @[Router_Hw.scala 132:41:@5575.4]
  assign io_in_0_ready = _T_355 & _T_360; // @[Router_Hw.scala 158:33:@5440.4]
  assign io_in_1_ready = _T_372 & _T_377; // @[Router_Hw.scala 158:33:@5444.4]
  assign io_in_2_ready = _T_389 & _T_394; // @[Router_Hw.scala 158:33:@5448.4]
  assign io_out_0_valid = _T_254; // @[Router_Hw.scala 190:35:@5458.4]
  assign io_out_0_bits = _T_251; // @[Router_Hw.scala 189:34:@5457.4]
  assign io_out_1_valid = _T_268; // @[Router_Hw.scala 190:35:@5468.4]
  assign io_out_1_bits = _T_265; // @[Router_Hw.scala 189:34:@5467.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_251 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_254 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_265 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_268 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  config_register_file_0 = _RAND_6[5:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (reset) begin
      _T_251 <= 64'h0;
    end else begin
      if (_T_297) begin
        _T_251 <= io_in_0_bits;
      end else begin
        if (_T_295) begin
          _T_251 <= io_in_1_bits;
        end else begin
          if (_T_293) begin
            _T_251 <= io_in_2_bits;
          end else begin
            _T_251 <= 64'h0;
          end
        end
      end
    end
    if (reset) begin
      _T_254 <= 1'h0;
    end else begin
      if (_T_297) begin
        _T_254 <= io_in_0_valid;
      end else begin
        if (_T_295) begin
          _T_254 <= io_in_1_valid;
        end else begin
          if (_T_293) begin
            _T_254 <= io_in_2_valid;
          end else begin
            _T_254 <= 1'h0;
          end
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (reset) begin
      _T_265 <= 64'h0;
    end else begin
      if (_T_319) begin
        _T_265 <= io_in_0_bits;
      end else begin
        if (_T_317) begin
          _T_265 <= io_in_1_bits;
        end else begin
          if (_T_315) begin
            _T_265 <= io_in_2_bits;
          end else begin
            _T_265 <= 64'h0;
          end
        end
      end
    end
    if (reset) begin
      _T_268 <= 1'h0;
    end else begin
      if (_T_319) begin
        _T_268 <= io_in_0_valid;
      end else begin
        if (_T_317) begin
          _T_268 <= io_in_1_valid;
        end else begin
          if (_T_315) begin
            _T_268 <= io_in_2_valid;
          end else begin
            _T_268 <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 6'h0;
    end else begin
      if (_T_425) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Router_Hw_14( // @[:@5579.2]
  input         clock, // @[:@5580.4]
  input         reset, // @[:@5581.4]
  input         io_in_0_valid, // @[:@5582.4]
  input  [63:0] io_in_0_bits, // @[:@5582.4]
  output        io_in_0_ready, // @[:@5582.4]
  input         io_in_0_config, // @[:@5582.4]
  input         io_in_1_valid, // @[:@5582.4]
  input  [63:0] io_in_1_bits, // @[:@5582.4]
  output        io_in_1_ready, // @[:@5582.4]
  input         io_in_2_valid, // @[:@5582.4]
  input  [63:0] io_in_2_bits, // @[:@5582.4]
  output        io_in_2_ready, // @[:@5582.4]
  output        io_out_0_valid, // @[:@5582.4]
  output [63:0] io_out_0_bits, // @[:@5582.4]
  input         io_out_0_ready, // @[:@5582.4]
  output        io_out_1_valid, // @[:@5582.4]
  output [63:0] io_out_1_bits, // @[:@5582.4]
  input         io_out_1_ready // @[:@5582.4]
);
  reg  decomposed_output_ports_0_0_ready; // @[Router_Hw.scala 163:29:@5598.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_251; // @[Router_Hw.scala 167:32:@5600.4]
  reg [63:0] _RAND_1;
  reg  _T_254; // @[Router_Hw.scala 169:33:@5602.4]
  reg [31:0] _RAND_2;
  reg  decomposed_output_ports_0_1_ready; // @[Router_Hw.scala 163:29:@5608.4]
  reg [31:0] _RAND_3;
  reg [63:0] _T_265; // @[Router_Hw.scala 167:32:@5610.4]
  reg [63:0] _RAND_4;
  reg  _T_268; // @[Router_Hw.scala 169:33:@5612.4]
  reg [31:0] _RAND_5;
  reg [5:0] config_register_file_0; // @[Router_Hw.scala 117:37:@5715.4]
  reg [31:0] _RAND_6;
  wire [1:0] _T_291; // @[Router_Hw.scala 82:28:@5629.4]
  wire  _T_293; // @[Mux.scala 46:19:@5630.4]
  wire [63:0] _T_294; // @[Mux.scala 46:16:@5631.4]
  wire  _T_295; // @[Mux.scala 46:19:@5632.4]
  wire [63:0] _T_296; // @[Mux.scala 46:16:@5633.4]
  wire  _T_297; // @[Mux.scala 46:19:@5634.4]
  wire [63:0] decomposed_output_ports_0_0_bits; // @[Mux.scala 46:16:@5635.4]
  wire  _T_302; // @[Mux.scala 46:16:@5639.4]
  wire  _T_304; // @[Mux.scala 46:16:@5641.4]
  wire  decomposed_output_ports_0_0_valid; // @[Mux.scala 46:16:@5643.4]
  wire [1:0] _T_313; // @[Router_Hw.scala 82:28:@5645.4]
  wire  _T_315; // @[Mux.scala 46:19:@5646.4]
  wire [63:0] _T_316; // @[Mux.scala 46:16:@5647.4]
  wire  _T_317; // @[Mux.scala 46:19:@5648.4]
  wire [63:0] _T_318; // @[Mux.scala 46:16:@5649.4]
  wire  _T_319; // @[Mux.scala 46:19:@5650.4]
  wire [63:0] decomposed_output_ports_0_1_bits; // @[Mux.scala 46:16:@5651.4]
  wire  _T_324; // @[Mux.scala 46:16:@5655.4]
  wire  _T_326; // @[Mux.scala 46:16:@5657.4]
  wire  decomposed_output_ports_0_1_valid; // @[Mux.scala 46:16:@5659.4]
  wire  _T_353; // @[Router_Hw.scala 90:53:@5678.4]
  wire  _T_355; // @[Router_Hw.scala 90:10:@5679.4]
  wire  _T_358; // @[Router_Hw.scala 90:53:@5681.4]
  wire  _T_360; // @[Router_Hw.scala 90:10:@5682.4]
  wire  _T_370; // @[Router_Hw.scala 90:53:@5690.4]
  wire  _T_372; // @[Router_Hw.scala 90:10:@5691.4]
  wire  _T_375; // @[Router_Hw.scala 90:53:@5693.4]
  wire  _T_377; // @[Router_Hw.scala 90:10:@5694.4]
  wire  _T_387; // @[Router_Hw.scala 90:53:@5702.4]
  wire  _T_389; // @[Router_Hw.scala 90:10:@5703.4]
  wire  _T_392; // @[Router_Hw.scala 90:53:@5705.4]
  wire  _T_394; // @[Router_Hw.scala 90:10:@5706.4]
  wire [4:0] config_module_id; // @[Router_Hw.scala 128:44:@5718.4]
  wire  module_id_match; // @[Router_Hw.scala 129:49:@5719.4]
  wire [5:0] config_data; // @[Router_Hw.scala 131:39:@5721.4]
  wire  _T_425; // @[Router_Hw.scala 132:22:@5722.4]
  wire [5:0] _GEN_0; // @[Router_Hw.scala 132:41:@5723.4]
  assign _T_291 = config_register_file_0[1:0]; // @[Router_Hw.scala 82:28:@5629.4]
  assign _T_293 = 2'h2 == _T_291; // @[Mux.scala 46:19:@5630.4]
  assign _T_294 = _T_293 ? io_in_2_bits : 64'h0; // @[Mux.scala 46:16:@5631.4]
  assign _T_295 = 2'h1 == _T_291; // @[Mux.scala 46:19:@5632.4]
  assign _T_296 = _T_295 ? io_in_1_bits : _T_294; // @[Mux.scala 46:16:@5633.4]
  assign _T_297 = 2'h0 == _T_291; // @[Mux.scala 46:19:@5634.4]
  assign decomposed_output_ports_0_0_bits = _T_297 ? io_in_0_bits : _T_296; // @[Mux.scala 46:16:@5635.4]
  assign _T_302 = _T_293 ? io_in_2_valid : 1'h0; // @[Mux.scala 46:16:@5639.4]
  assign _T_304 = _T_295 ? io_in_1_valid : _T_302; // @[Mux.scala 46:16:@5641.4]
  assign decomposed_output_ports_0_0_valid = _T_297 ? io_in_0_valid : _T_304; // @[Mux.scala 46:16:@5643.4]
  assign _T_313 = config_register_file_0[3:2]; // @[Router_Hw.scala 82:28:@5645.4]
  assign _T_315 = 2'h2 == _T_313; // @[Mux.scala 46:19:@5646.4]
  assign _T_316 = _T_315 ? io_in_2_bits : 64'h0; // @[Mux.scala 46:16:@5647.4]
  assign _T_317 = 2'h1 == _T_313; // @[Mux.scala 46:19:@5648.4]
  assign _T_318 = _T_317 ? io_in_1_bits : _T_316; // @[Mux.scala 46:16:@5649.4]
  assign _T_319 = 2'h0 == _T_313; // @[Mux.scala 46:19:@5650.4]
  assign decomposed_output_ports_0_1_bits = _T_319 ? io_in_0_bits : _T_318; // @[Mux.scala 46:16:@5651.4]
  assign _T_324 = _T_315 ? io_in_2_valid : 1'h0; // @[Mux.scala 46:16:@5655.4]
  assign _T_326 = _T_317 ? io_in_1_valid : _T_324; // @[Mux.scala 46:16:@5657.4]
  assign decomposed_output_ports_0_1_valid = _T_319 ? io_in_0_valid : _T_326; // @[Mux.scala 46:16:@5659.4]
  assign _T_353 = _T_291 == 2'h0; // @[Router_Hw.scala 90:53:@5678.4]
  assign _T_355 = _T_353 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@5679.4]
  assign _T_358 = _T_313 == 2'h0; // @[Router_Hw.scala 90:53:@5681.4]
  assign _T_360 = _T_358 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@5682.4]
  assign _T_370 = _T_291 == 2'h1; // @[Router_Hw.scala 90:53:@5690.4]
  assign _T_372 = _T_370 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@5691.4]
  assign _T_375 = _T_313 == 2'h1; // @[Router_Hw.scala 90:53:@5693.4]
  assign _T_377 = _T_375 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@5694.4]
  assign _T_387 = _T_291 == 2'h2; // @[Router_Hw.scala 90:53:@5702.4]
  assign _T_389 = _T_387 ? decomposed_output_ports_0_0_ready : 1'h1; // @[Router_Hw.scala 90:10:@5703.4]
  assign _T_392 = _T_313 == 2'h2; // @[Router_Hw.scala 90:53:@5705.4]
  assign _T_394 = _T_392 ? decomposed_output_ports_0_1_ready : 1'h1; // @[Router_Hw.scala 90:10:@5706.4]
  assign config_module_id = io_in_0_bits[63:59]; // @[Router_Hw.scala 128:44:@5718.4]
  assign module_id_match = config_module_id == 5'hc; // @[Router_Hw.scala 129:49:@5719.4]
  assign config_data = io_in_0_bits[5:0]; // @[Router_Hw.scala 131:39:@5721.4]
  assign _T_425 = io_in_0_config & module_id_match; // @[Router_Hw.scala 132:22:@5722.4]
  assign _GEN_0 = _T_425 ? config_data : config_register_file_0; // @[Router_Hw.scala 132:41:@5723.4]
  assign io_in_0_ready = _T_355 & _T_360; // @[Router_Hw.scala 158:33:@5588.4]
  assign io_in_1_ready = _T_372 & _T_377; // @[Router_Hw.scala 158:33:@5592.4]
  assign io_in_2_ready = _T_389 & _T_394; // @[Router_Hw.scala 158:33:@5596.4]
  assign io_out_0_valid = _T_254; // @[Router_Hw.scala 190:35:@5606.4]
  assign io_out_0_bits = _T_251; // @[Router_Hw.scala 189:34:@5605.4]
  assign io_out_1_valid = _T_268; // @[Router_Hw.scala 190:35:@5616.4]
  assign io_out_1_bits = _T_265; // @[Router_Hw.scala 189:34:@5615.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_0_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_251 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_254 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  decomposed_output_ports_0_1_ready = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {2{`RANDOM}};
  _T_265 = _RAND_4[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  _T_268 = _RAND_5[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  config_register_file_0 = _RAND_6[5:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_0_ready <= io_out_0_ready;
    if (reset) begin
      _T_251 <= 64'h0;
    end else begin
      if (_T_297) begin
        _T_251 <= io_in_0_bits;
      end else begin
        if (_T_295) begin
          _T_251 <= io_in_1_bits;
        end else begin
          if (_T_293) begin
            _T_251 <= io_in_2_bits;
          end else begin
            _T_251 <= 64'h0;
          end
        end
      end
    end
    if (reset) begin
      _T_254 <= 1'h0;
    end else begin
      if (_T_297) begin
        _T_254 <= io_in_0_valid;
      end else begin
        if (_T_295) begin
          _T_254 <= io_in_1_valid;
        end else begin
          if (_T_293) begin
            _T_254 <= io_in_2_valid;
          end else begin
            _T_254 <= 1'h0;
          end
        end
      end
    end
    decomposed_output_ports_0_1_ready <= io_out_1_ready;
    if (reset) begin
      _T_265 <= 64'h0;
    end else begin
      if (_T_319) begin
        _T_265 <= io_in_0_bits;
      end else begin
        if (_T_317) begin
          _T_265 <= io_in_1_bits;
        end else begin
          if (_T_315) begin
            _T_265 <= io_in_2_bits;
          end else begin
            _T_265 <= 64'h0;
          end
        end
      end
    end
    if (reset) begin
      _T_268 <= 1'h0;
    end else begin
      if (_T_319) begin
        _T_268 <= io_in_0_valid;
      end else begin
        if (_T_317) begin
          _T_268 <= io_in_1_valid;
        end else begin
          if (_T_315) begin
            _T_268 <= io_in_2_valid;
          end else begin
            _T_268 <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      config_register_file_0 <= 6'h0;
    end else begin
      if (_T_425) begin
        config_register_file_0 <= config_data;
      end
    end
  end
endmodule
module Router_Hw_15( // @[:@5727.2]
  input         clock, // @[:@5728.4]
  input         reset, // @[:@5729.4]
  input         io_in_0_valid, // @[:@5730.4]
  input  [63:0] io_in_0_bits, // @[:@5730.4]
  output        io_in_0_ready, // @[:@5730.4]
  output        io_out_5_valid, // @[:@5730.4]
  output [63:0] io_out_5_bits, // @[:@5730.4]
  input         io_out_5_ready // @[:@5730.4]
);
  reg  decomposed_output_ports_0_5_ready; // @[Router_Hw.scala 163:29:@5804.4]
  reg [31:0] _RAND_0;
  reg [63:0] _T_434; // @[Router_Hw.scala 167:32:@5806.4]
  reg [63:0] _RAND_1;
  reg  _T_437; // @[Router_Hw.scala 169:33:@5808.4]
  reg [31:0] _RAND_2;
  assign io_in_0_ready = decomposed_output_ports_0_5_ready; // @[Router_Hw.scala 158:33:@5736.4]
  assign io_out_5_valid = _T_437; // @[Router_Hw.scala 190:35:@5812.4]
  assign io_out_5_bits = _T_434; // @[Router_Hw.scala 189:34:@5811.4]
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
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  decomposed_output_ports_0_5_ready = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  _T_434 = _RAND_1[63:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  _T_437 = _RAND_2[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    decomposed_output_ports_0_5_ready <= io_out_5_ready;
    if (reset) begin
      _T_434 <= 64'h0;
    end else begin
      _T_434 <= io_in_0_bits;
    end
    if (reset) begin
      _T_437 <= 1'h0;
    end else begin
      _T_437 <= io_in_0_valid;
    end
  end
endmodule
module Cgra_Hw( // @[:@8060.2]
  input         clock, // @[:@8061.4]
  input         reset, // @[:@8062.4]
  input         io_in_0_valid, // @[:@8063.4]
  input  [63:0] io_in_0_bits, // @[:@8063.4]
  output        io_in_0_ready, // @[:@8063.4]
  input         io_in_0_config, // @[:@8063.4]
  input         io_in_1_valid, // @[:@8063.4]
  input  [63:0] io_in_1_bits, // @[:@8063.4]
  output        io_in_1_ready, // @[:@8063.4]
  input         io_in_1_config, // @[:@8063.4]
  output        io_out_0_valid, // @[:@8063.4]
  output [63:0] io_out_0_bits, // @[:@8063.4]
  input         io_out_0_ready, // @[:@8063.4]
  output        io_out_0_config, // @[:@8063.4]
  output        io_out_1_valid, // @[:@8063.4]
  output [63:0] io_out_1_bits, // @[:@8063.4]
  input         io_out_1_ready, // @[:@8063.4]
  output        io_out_1_config // @[:@8063.4]
);
  wire  VectorPort_Hw_clock; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_reset; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_io_in_0_valid; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire [63:0] VectorPort_Hw_io_in_0_bits; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_io_in_0_ready; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_io_in_0_config; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_io_out_0_valid; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire [63:0] VectorPort_Hw_io_out_0_bits; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_io_out_0_ready; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_io_out_0_config; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_io_out_1_valid; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire [63:0] VectorPort_Hw_io_out_1_bits; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_io_out_1_ready; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_io_out_1_config; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_io_out_2_valid; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire [63:0] VectorPort_Hw_io_out_2_bits; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_io_out_2_ready; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_io_out_2_config; // @[Cgra_Hw.scala 33:63:@8065.4]
  wire  VectorPort_Hw_1_clock; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_1_reset; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_1_io_in_0_valid; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire [63:0] VectorPort_Hw_1_io_in_0_bits; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_1_io_in_0_ready; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_1_io_in_0_config; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_1_io_out_0_valid; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire [63:0] VectorPort_Hw_1_io_out_0_bits; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_1_io_out_0_ready; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_1_io_out_0_config; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_1_io_out_1_valid; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire [63:0] VectorPort_Hw_1_io_out_1_bits; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_1_io_out_1_ready; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_1_io_out_1_config; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_1_io_out_2_valid; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire [63:0] VectorPort_Hw_1_io_out_2_bits; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_1_io_out_2_ready; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_1_io_out_2_config; // @[Cgra_Hw.scala 33:63:@8068.4]
  wire  VectorPort_Hw_2_clock; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire  VectorPort_Hw_2_reset; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire  VectorPort_Hw_2_io_in_0_valid; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire [63:0] VectorPort_Hw_2_io_in_0_bits; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire  VectorPort_Hw_2_io_in_0_ready; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire  VectorPort_Hw_2_io_in_1_valid; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire [63:0] VectorPort_Hw_2_io_in_1_bits; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire  VectorPort_Hw_2_io_in_1_ready; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire  VectorPort_Hw_2_io_in_2_valid; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire [63:0] VectorPort_Hw_2_io_in_2_bits; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire  VectorPort_Hw_2_io_in_2_ready; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire  VectorPort_Hw_2_io_out_0_valid; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire [63:0] VectorPort_Hw_2_io_out_0_bits; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire  VectorPort_Hw_2_io_out_0_ready; // @[Cgra_Hw.scala 33:63:@8071.4]
  wire  VectorPort_Hw_3_clock; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire  VectorPort_Hw_3_reset; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire  VectorPort_Hw_3_io_in_0_valid; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire [63:0] VectorPort_Hw_3_io_in_0_bits; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire  VectorPort_Hw_3_io_in_0_ready; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire  VectorPort_Hw_3_io_in_1_valid; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire [63:0] VectorPort_Hw_3_io_in_1_bits; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire  VectorPort_Hw_3_io_in_1_ready; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire  VectorPort_Hw_3_io_in_2_valid; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire [63:0] VectorPort_Hw_3_io_in_2_bits; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire  VectorPort_Hw_3_io_in_2_ready; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire  VectorPort_Hw_3_io_out_0_valid; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire [63:0] VectorPort_Hw_3_io_out_0_bits; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire  VectorPort_Hw_3_io_out_0_ready; // @[Cgra_Hw.scala 33:63:@8074.4]
  wire  Router_Hw_clock; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_reset; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire [63:0] Router_Hw_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_in_0_config; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_in_1_valid; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire [63:0] Router_Hw_io_in_1_bits; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_in_1_ready; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_in_2_valid; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire [63:0] Router_Hw_io_in_2_bits; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_in_2_ready; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_in_3_valid; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire [63:0] Router_Hw_io_in_3_bits; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_in_3_ready; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_out_0_valid; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire [63:0] Router_Hw_io_out_0_bits; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_out_0_ready; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_out_1_valid; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire [63:0] Router_Hw_io_out_1_bits; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_out_1_ready; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_out_2_valid; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire [63:0] Router_Hw_io_out_2_bits; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_io_out_2_ready; // @[Cgra_Hw.scala 38:51:@8077.4]
  wire  Router_Hw_1_clock; // @[Cgra_Hw.scala 38:51:@8080.4]
  wire  Router_Hw_1_reset; // @[Cgra_Hw.scala 38:51:@8080.4]
  wire  Router_Hw_1_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8080.4]
  wire [63:0] Router_Hw_1_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8080.4]
  wire  Router_Hw_1_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8080.4]
  wire  Router_Hw_1_io_out_0_valid; // @[Cgra_Hw.scala 38:51:@8080.4]
  wire [63:0] Router_Hw_1_io_out_0_bits; // @[Cgra_Hw.scala 38:51:@8080.4]
  wire  Router_Hw_1_io_out_0_ready; // @[Cgra_Hw.scala 38:51:@8080.4]
  wire  Router_Hw_1_io_out_1_valid; // @[Cgra_Hw.scala 38:51:@8080.4]
  wire [63:0] Router_Hw_1_io_out_1_bits; // @[Cgra_Hw.scala 38:51:@8080.4]
  wire  Router_Hw_1_io_out_1_ready; // @[Cgra_Hw.scala 38:51:@8080.4]
  wire  Router_Hw_2_clock; // @[Cgra_Hw.scala 38:51:@8083.4]
  wire  Router_Hw_2_reset; // @[Cgra_Hw.scala 38:51:@8083.4]
  wire  Router_Hw_2_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8083.4]
  wire [63:0] Router_Hw_2_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8083.4]
  wire  Router_Hw_2_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8083.4]
  wire  Router_Hw_2_io_out_1_valid; // @[Cgra_Hw.scala 38:51:@8083.4]
  wire [63:0] Router_Hw_2_io_out_1_bits; // @[Cgra_Hw.scala 38:51:@8083.4]
  wire  Router_Hw_2_io_out_1_ready; // @[Cgra_Hw.scala 38:51:@8083.4]
  wire  Router_Hw_3_clock; // @[Cgra_Hw.scala 38:51:@8086.4]
  wire  Router_Hw_3_reset; // @[Cgra_Hw.scala 38:51:@8086.4]
  wire  Router_Hw_3_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8086.4]
  wire [63:0] Router_Hw_3_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8086.4]
  wire  Router_Hw_3_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8086.4]
  wire  Router_Hw_3_io_out_1_valid; // @[Cgra_Hw.scala 38:51:@8086.4]
  wire [63:0] Router_Hw_3_io_out_1_bits; // @[Cgra_Hw.scala 38:51:@8086.4]
  wire  Router_Hw_3_io_out_1_ready; // @[Cgra_Hw.scala 38:51:@8086.4]
  wire  Router_Hw_4_clock; // @[Cgra_Hw.scala 38:51:@8089.4]
  wire  Router_Hw_4_reset; // @[Cgra_Hw.scala 38:51:@8089.4]
  wire  Router_Hw_4_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8089.4]
  wire [63:0] Router_Hw_4_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8089.4]
  wire  Router_Hw_4_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8089.4]
  wire  Router_Hw_4_io_out_5_valid; // @[Cgra_Hw.scala 38:51:@8089.4]
  wire [63:0] Router_Hw_4_io_out_5_bits; // @[Cgra_Hw.scala 38:51:@8089.4]
  wire  Router_Hw_4_io_out_5_ready; // @[Cgra_Hw.scala 38:51:@8089.4]
  wire  Router_Hw_5_clock; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire  Router_Hw_5_reset; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire  Router_Hw_5_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire [63:0] Router_Hw_5_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire  Router_Hw_5_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire  Router_Hw_5_io_out_0_valid; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire [63:0] Router_Hw_5_io_out_0_bits; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire  Router_Hw_5_io_out_0_ready; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire  Router_Hw_5_io_out_1_valid; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire [63:0] Router_Hw_5_io_out_1_bits; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire  Router_Hw_5_io_out_1_ready; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire  Router_Hw_5_io_out_2_valid; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire [63:0] Router_Hw_5_io_out_2_bits; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire  Router_Hw_5_io_out_2_ready; // @[Cgra_Hw.scala 38:51:@8092.4]
  wire  Router_Hw_6_clock; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_reset; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire [63:0] Router_Hw_6_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_in_0_config; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_in_1_valid; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire [63:0] Router_Hw_6_io_in_1_bits; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_in_1_ready; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_in_2_valid; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire [63:0] Router_Hw_6_io_in_2_bits; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_in_2_ready; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_in_3_valid; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire [63:0] Router_Hw_6_io_in_3_bits; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_in_3_ready; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_out_0_valid; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire [63:0] Router_Hw_6_io_out_0_bits; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_out_0_ready; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_out_1_valid; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire [63:0] Router_Hw_6_io_out_1_bits; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_out_1_ready; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_out_2_valid; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire [63:0] Router_Hw_6_io_out_2_bits; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_6_io_out_2_ready; // @[Cgra_Hw.scala 38:51:@8095.4]
  wire  Router_Hw_7_clock; // @[Cgra_Hw.scala 38:51:@8098.4]
  wire  Router_Hw_7_reset; // @[Cgra_Hw.scala 38:51:@8098.4]
  wire  Router_Hw_7_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8098.4]
  wire [63:0] Router_Hw_7_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8098.4]
  wire  Router_Hw_7_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8098.4]
  wire  Router_Hw_7_io_out_0_valid; // @[Cgra_Hw.scala 38:51:@8098.4]
  wire [63:0] Router_Hw_7_io_out_0_bits; // @[Cgra_Hw.scala 38:51:@8098.4]
  wire  Router_Hw_7_io_out_0_ready; // @[Cgra_Hw.scala 38:51:@8098.4]
  wire  Router_Hw_7_io_out_1_valid; // @[Cgra_Hw.scala 38:51:@8098.4]
  wire [63:0] Router_Hw_7_io_out_1_bits; // @[Cgra_Hw.scala 38:51:@8098.4]
  wire  Router_Hw_7_io_out_1_ready; // @[Cgra_Hw.scala 38:51:@8098.4]
  wire  Router_Hw_8_clock; // @[Cgra_Hw.scala 38:51:@8101.4]
  wire  Router_Hw_8_reset; // @[Cgra_Hw.scala 38:51:@8101.4]
  wire  Router_Hw_8_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8101.4]
  wire [63:0] Router_Hw_8_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8101.4]
  wire  Router_Hw_8_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8101.4]
  wire  Router_Hw_8_io_out_1_valid; // @[Cgra_Hw.scala 38:51:@8101.4]
  wire [63:0] Router_Hw_8_io_out_1_bits; // @[Cgra_Hw.scala 38:51:@8101.4]
  wire  Router_Hw_8_io_out_1_ready; // @[Cgra_Hw.scala 38:51:@8101.4]
  wire  Router_Hw_9_clock; // @[Cgra_Hw.scala 38:51:@8104.4]
  wire  Router_Hw_9_reset; // @[Cgra_Hw.scala 38:51:@8104.4]
  wire  Router_Hw_9_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8104.4]
  wire [63:0] Router_Hw_9_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8104.4]
  wire  Router_Hw_9_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8104.4]
  wire  Router_Hw_9_io_out_1_valid; // @[Cgra_Hw.scala 38:51:@8104.4]
  wire [63:0] Router_Hw_9_io_out_1_bits; // @[Cgra_Hw.scala 38:51:@8104.4]
  wire  Router_Hw_9_io_out_1_ready; // @[Cgra_Hw.scala 38:51:@8104.4]
  wire  Router_Hw_10_clock; // @[Cgra_Hw.scala 38:51:@8107.4]
  wire  Router_Hw_10_reset; // @[Cgra_Hw.scala 38:51:@8107.4]
  wire  Router_Hw_10_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8107.4]
  wire [63:0] Router_Hw_10_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8107.4]
  wire  Router_Hw_10_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8107.4]
  wire  Router_Hw_10_io_out_3_valid; // @[Cgra_Hw.scala 38:51:@8107.4]
  wire [63:0] Router_Hw_10_io_out_3_bits; // @[Cgra_Hw.scala 38:51:@8107.4]
  wire  Router_Hw_10_io_out_3_ready; // @[Cgra_Hw.scala 38:51:@8107.4]
  wire  Router_Hw_11_clock; // @[Cgra_Hw.scala 38:51:@8110.4]
  wire  Router_Hw_11_reset; // @[Cgra_Hw.scala 38:51:@8110.4]
  wire  Router_Hw_11_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8110.4]
  wire [63:0] Router_Hw_11_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8110.4]
  wire  Router_Hw_11_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8110.4]
  wire  Router_Hw_11_io_out_0_valid; // @[Cgra_Hw.scala 38:51:@8110.4]
  wire [63:0] Router_Hw_11_io_out_0_bits; // @[Cgra_Hw.scala 38:51:@8110.4]
  wire  Router_Hw_11_io_out_0_ready; // @[Cgra_Hw.scala 38:51:@8110.4]
  wire  Router_Hw_11_io_out_1_valid; // @[Cgra_Hw.scala 38:51:@8110.4]
  wire [63:0] Router_Hw_11_io_out_1_bits; // @[Cgra_Hw.scala 38:51:@8110.4]
  wire  Router_Hw_11_io_out_1_ready; // @[Cgra_Hw.scala 38:51:@8110.4]
  wire  Router_Hw_12_clock; // @[Cgra_Hw.scala 38:51:@8113.4]
  wire  Router_Hw_12_reset; // @[Cgra_Hw.scala 38:51:@8113.4]
  wire  Router_Hw_12_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8113.4]
  wire [63:0] Router_Hw_12_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8113.4]
  wire  Router_Hw_12_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8113.4]
  wire  Router_Hw_12_io_out_1_valid; // @[Cgra_Hw.scala 38:51:@8113.4]
  wire [63:0] Router_Hw_12_io_out_1_bits; // @[Cgra_Hw.scala 38:51:@8113.4]
  wire  Router_Hw_12_io_out_1_ready; // @[Cgra_Hw.scala 38:51:@8113.4]
  wire  Router_Hw_12_io_out_2_valid; // @[Cgra_Hw.scala 38:51:@8113.4]
  wire [63:0] Router_Hw_12_io_out_2_bits; // @[Cgra_Hw.scala 38:51:@8113.4]
  wire  Router_Hw_12_io_out_2_ready; // @[Cgra_Hw.scala 38:51:@8113.4]
  wire  Router_Hw_13_clock; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire  Router_Hw_13_reset; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire  Router_Hw_13_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire [63:0] Router_Hw_13_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire  Router_Hw_13_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire  Router_Hw_13_io_in_1_valid; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire [63:0] Router_Hw_13_io_in_1_bits; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire  Router_Hw_13_io_in_1_ready; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire  Router_Hw_13_io_in_2_valid; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire [63:0] Router_Hw_13_io_in_2_bits; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire  Router_Hw_13_io_in_2_ready; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire  Router_Hw_13_io_in_2_config; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire  Router_Hw_13_io_out_0_valid; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire [63:0] Router_Hw_13_io_out_0_bits; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire  Router_Hw_13_io_out_0_ready; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire  Router_Hw_13_io_out_1_valid; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire [63:0] Router_Hw_13_io_out_1_bits; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire  Router_Hw_13_io_out_1_ready; // @[Cgra_Hw.scala 38:51:@8116.4]
  wire  Router_Hw_14_clock; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire  Router_Hw_14_reset; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire  Router_Hw_14_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire [63:0] Router_Hw_14_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire  Router_Hw_14_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire  Router_Hw_14_io_in_0_config; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire  Router_Hw_14_io_in_1_valid; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire [63:0] Router_Hw_14_io_in_1_bits; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire  Router_Hw_14_io_in_1_ready; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire  Router_Hw_14_io_in_2_valid; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire [63:0] Router_Hw_14_io_in_2_bits; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire  Router_Hw_14_io_in_2_ready; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire  Router_Hw_14_io_out_0_valid; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire [63:0] Router_Hw_14_io_out_0_bits; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire  Router_Hw_14_io_out_0_ready; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire  Router_Hw_14_io_out_1_valid; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire [63:0] Router_Hw_14_io_out_1_bits; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire  Router_Hw_14_io_out_1_ready; // @[Cgra_Hw.scala 38:51:@8119.4]
  wire  Router_Hw_15_clock; // @[Cgra_Hw.scala 38:51:@8122.4]
  wire  Router_Hw_15_reset; // @[Cgra_Hw.scala 38:51:@8122.4]
  wire  Router_Hw_15_io_in_0_valid; // @[Cgra_Hw.scala 38:51:@8122.4]
  wire [63:0] Router_Hw_15_io_in_0_bits; // @[Cgra_Hw.scala 38:51:@8122.4]
  wire  Router_Hw_15_io_in_0_ready; // @[Cgra_Hw.scala 38:51:@8122.4]
  wire  Router_Hw_15_io_out_5_valid; // @[Cgra_Hw.scala 38:51:@8122.4]
  wire [63:0] Router_Hw_15_io_out_5_bits; // @[Cgra_Hw.scala 38:51:@8122.4]
  wire  Router_Hw_15_io_out_5_ready; // @[Cgra_Hw.scala 38:51:@8122.4]
  VectorPort_Hw VectorPort_Hw ( // @[Cgra_Hw.scala 33:63:@8065.4]
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
    .io_out_1_config(VectorPort_Hw_io_out_1_config),
    .io_out_2_valid(VectorPort_Hw_io_out_2_valid),
    .io_out_2_bits(VectorPort_Hw_io_out_2_bits),
    .io_out_2_ready(VectorPort_Hw_io_out_2_ready),
    .io_out_2_config(VectorPort_Hw_io_out_2_config)
  );
  VectorPort_Hw VectorPort_Hw_1 ( // @[Cgra_Hw.scala 33:63:@8068.4]
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
    .io_out_1_config(VectorPort_Hw_1_io_out_1_config),
    .io_out_2_valid(VectorPort_Hw_1_io_out_2_valid),
    .io_out_2_bits(VectorPort_Hw_1_io_out_2_bits),
    .io_out_2_ready(VectorPort_Hw_1_io_out_2_ready),
    .io_out_2_config(VectorPort_Hw_1_io_out_2_config)
  );
  VectorPort_Hw_2 VectorPort_Hw_2 ( // @[Cgra_Hw.scala 33:63:@8071.4]
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
  VectorPort_Hw_2 VectorPort_Hw_3 ( // @[Cgra_Hw.scala 33:63:@8074.4]
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
  Router_Hw Router_Hw ( // @[Cgra_Hw.scala 38:51:@8077.4]
    .clock(Router_Hw_clock),
    .reset(Router_Hw_reset),
    .io_in_0_valid(Router_Hw_io_in_0_valid),
    .io_in_0_bits(Router_Hw_io_in_0_bits),
    .io_in_0_ready(Router_Hw_io_in_0_ready),
    .io_in_0_config(Router_Hw_io_in_0_config),
    .io_in_1_valid(Router_Hw_io_in_1_valid),
    .io_in_1_bits(Router_Hw_io_in_1_bits),
    .io_in_1_ready(Router_Hw_io_in_1_ready),
    .io_in_2_valid(Router_Hw_io_in_2_valid),
    .io_in_2_bits(Router_Hw_io_in_2_bits),
    .io_in_2_ready(Router_Hw_io_in_2_ready),
    .io_in_3_valid(Router_Hw_io_in_3_valid),
    .io_in_3_bits(Router_Hw_io_in_3_bits),
    .io_in_3_ready(Router_Hw_io_in_3_ready),
    .io_out_0_valid(Router_Hw_io_out_0_valid),
    .io_out_0_bits(Router_Hw_io_out_0_bits),
    .io_out_0_ready(Router_Hw_io_out_0_ready),
    .io_out_1_valid(Router_Hw_io_out_1_valid),
    .io_out_1_bits(Router_Hw_io_out_1_bits),
    .io_out_1_ready(Router_Hw_io_out_1_ready),
    .io_out_2_valid(Router_Hw_io_out_2_valid),
    .io_out_2_bits(Router_Hw_io_out_2_bits),
    .io_out_2_ready(Router_Hw_io_out_2_ready)
  );
  Router_Hw_1 Router_Hw_1 ( // @[Cgra_Hw.scala 38:51:@8080.4]
    .clock(Router_Hw_1_clock),
    .reset(Router_Hw_1_reset),
    .io_in_0_valid(Router_Hw_1_io_in_0_valid),
    .io_in_0_bits(Router_Hw_1_io_in_0_bits),
    .io_in_0_ready(Router_Hw_1_io_in_0_ready),
    .io_out_0_valid(Router_Hw_1_io_out_0_valid),
    .io_out_0_bits(Router_Hw_1_io_out_0_bits),
    .io_out_0_ready(Router_Hw_1_io_out_0_ready),
    .io_out_1_valid(Router_Hw_1_io_out_1_valid),
    .io_out_1_bits(Router_Hw_1_io_out_1_bits),
    .io_out_1_ready(Router_Hw_1_io_out_1_ready)
  );
  Router_Hw_2 Router_Hw_2 ( // @[Cgra_Hw.scala 38:51:@8083.4]
    .clock(Router_Hw_2_clock),
    .reset(Router_Hw_2_reset),
    .io_in_0_valid(Router_Hw_2_io_in_0_valid),
    .io_in_0_bits(Router_Hw_2_io_in_0_bits),
    .io_in_0_ready(Router_Hw_2_io_in_0_ready),
    .io_out_1_valid(Router_Hw_2_io_out_1_valid),
    .io_out_1_bits(Router_Hw_2_io_out_1_bits),
    .io_out_1_ready(Router_Hw_2_io_out_1_ready)
  );
  Router_Hw_3 Router_Hw_3 ( // @[Cgra_Hw.scala 38:51:@8086.4]
    .clock(Router_Hw_3_clock),
    .reset(Router_Hw_3_reset),
    .io_in_0_valid(Router_Hw_3_io_in_0_valid),
    .io_in_0_bits(Router_Hw_3_io_in_0_bits),
    .io_in_0_ready(Router_Hw_3_io_in_0_ready),
    .io_out_1_valid(Router_Hw_3_io_out_1_valid),
    .io_out_1_bits(Router_Hw_3_io_out_1_bits),
    .io_out_1_ready(Router_Hw_3_io_out_1_ready)
  );
  Router_Hw_4 Router_Hw_4 ( // @[Cgra_Hw.scala 38:51:@8089.4]
    .clock(Router_Hw_4_clock),
    .reset(Router_Hw_4_reset),
    .io_in_0_valid(Router_Hw_4_io_in_0_valid),
    .io_in_0_bits(Router_Hw_4_io_in_0_bits),
    .io_in_0_ready(Router_Hw_4_io_in_0_ready),
    .io_out_5_valid(Router_Hw_4_io_out_5_valid),
    .io_out_5_bits(Router_Hw_4_io_out_5_bits),
    .io_out_5_ready(Router_Hw_4_io_out_5_ready)
  );
  Router_Hw_5 Router_Hw_5 ( // @[Cgra_Hw.scala 38:51:@8092.4]
    .clock(Router_Hw_5_clock),
    .reset(Router_Hw_5_reset),
    .io_in_0_valid(Router_Hw_5_io_in_0_valid),
    .io_in_0_bits(Router_Hw_5_io_in_0_bits),
    .io_in_0_ready(Router_Hw_5_io_in_0_ready),
    .io_out_0_valid(Router_Hw_5_io_out_0_valid),
    .io_out_0_bits(Router_Hw_5_io_out_0_bits),
    .io_out_0_ready(Router_Hw_5_io_out_0_ready),
    .io_out_1_valid(Router_Hw_5_io_out_1_valid),
    .io_out_1_bits(Router_Hw_5_io_out_1_bits),
    .io_out_1_ready(Router_Hw_5_io_out_1_ready),
    .io_out_2_valid(Router_Hw_5_io_out_2_valid),
    .io_out_2_bits(Router_Hw_5_io_out_2_bits),
    .io_out_2_ready(Router_Hw_5_io_out_2_ready)
  );
  Router_Hw_6 Router_Hw_6 ( // @[Cgra_Hw.scala 38:51:@8095.4]
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
    .io_out_2_valid(Router_Hw_6_io_out_2_valid),
    .io_out_2_bits(Router_Hw_6_io_out_2_bits),
    .io_out_2_ready(Router_Hw_6_io_out_2_ready)
  );
  Router_Hw_7 Router_Hw_7 ( // @[Cgra_Hw.scala 38:51:@8098.4]
    .clock(Router_Hw_7_clock),
    .reset(Router_Hw_7_reset),
    .io_in_0_valid(Router_Hw_7_io_in_0_valid),
    .io_in_0_bits(Router_Hw_7_io_in_0_bits),
    .io_in_0_ready(Router_Hw_7_io_in_0_ready),
    .io_out_0_valid(Router_Hw_7_io_out_0_valid),
    .io_out_0_bits(Router_Hw_7_io_out_0_bits),
    .io_out_0_ready(Router_Hw_7_io_out_0_ready),
    .io_out_1_valid(Router_Hw_7_io_out_1_valid),
    .io_out_1_bits(Router_Hw_7_io_out_1_bits),
    .io_out_1_ready(Router_Hw_7_io_out_1_ready)
  );
  Router_Hw_8 Router_Hw_8 ( // @[Cgra_Hw.scala 38:51:@8101.4]
    .clock(Router_Hw_8_clock),
    .reset(Router_Hw_8_reset),
    .io_in_0_valid(Router_Hw_8_io_in_0_valid),
    .io_in_0_bits(Router_Hw_8_io_in_0_bits),
    .io_in_0_ready(Router_Hw_8_io_in_0_ready),
    .io_out_1_valid(Router_Hw_8_io_out_1_valid),
    .io_out_1_bits(Router_Hw_8_io_out_1_bits),
    .io_out_1_ready(Router_Hw_8_io_out_1_ready)
  );
  Router_Hw_9 Router_Hw_9 ( // @[Cgra_Hw.scala 38:51:@8104.4]
    .clock(Router_Hw_9_clock),
    .reset(Router_Hw_9_reset),
    .io_in_0_valid(Router_Hw_9_io_in_0_valid),
    .io_in_0_bits(Router_Hw_9_io_in_0_bits),
    .io_in_0_ready(Router_Hw_9_io_in_0_ready),
    .io_out_1_valid(Router_Hw_9_io_out_1_valid),
    .io_out_1_bits(Router_Hw_9_io_out_1_bits),
    .io_out_1_ready(Router_Hw_9_io_out_1_ready)
  );
  Router_Hw_10 Router_Hw_10 ( // @[Cgra_Hw.scala 38:51:@8107.4]
    .clock(Router_Hw_10_clock),
    .reset(Router_Hw_10_reset),
    .io_in_0_valid(Router_Hw_10_io_in_0_valid),
    .io_in_0_bits(Router_Hw_10_io_in_0_bits),
    .io_in_0_ready(Router_Hw_10_io_in_0_ready),
    .io_out_3_valid(Router_Hw_10_io_out_3_valid),
    .io_out_3_bits(Router_Hw_10_io_out_3_bits),
    .io_out_3_ready(Router_Hw_10_io_out_3_ready)
  );
  Router_Hw_11 Router_Hw_11 ( // @[Cgra_Hw.scala 38:51:@8110.4]
    .clock(Router_Hw_11_clock),
    .reset(Router_Hw_11_reset),
    .io_in_0_valid(Router_Hw_11_io_in_0_valid),
    .io_in_0_bits(Router_Hw_11_io_in_0_bits),
    .io_in_0_ready(Router_Hw_11_io_in_0_ready),
    .io_out_0_valid(Router_Hw_11_io_out_0_valid),
    .io_out_0_bits(Router_Hw_11_io_out_0_bits),
    .io_out_0_ready(Router_Hw_11_io_out_0_ready),
    .io_out_1_valid(Router_Hw_11_io_out_1_valid),
    .io_out_1_bits(Router_Hw_11_io_out_1_bits),
    .io_out_1_ready(Router_Hw_11_io_out_1_ready)
  );
  Router_Hw_12 Router_Hw_12 ( // @[Cgra_Hw.scala 38:51:@8113.4]
    .clock(Router_Hw_12_clock),
    .reset(Router_Hw_12_reset),
    .io_in_0_valid(Router_Hw_12_io_in_0_valid),
    .io_in_0_bits(Router_Hw_12_io_in_0_bits),
    .io_in_0_ready(Router_Hw_12_io_in_0_ready),
    .io_out_1_valid(Router_Hw_12_io_out_1_valid),
    .io_out_1_bits(Router_Hw_12_io_out_1_bits),
    .io_out_1_ready(Router_Hw_12_io_out_1_ready),
    .io_out_2_valid(Router_Hw_12_io_out_2_valid),
    .io_out_2_bits(Router_Hw_12_io_out_2_bits),
    .io_out_2_ready(Router_Hw_12_io_out_2_ready)
  );
  Router_Hw_13 Router_Hw_13 ( // @[Cgra_Hw.scala 38:51:@8116.4]
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
    .io_out_1_ready(Router_Hw_13_io_out_1_ready)
  );
  Router_Hw_14 Router_Hw_14 ( // @[Cgra_Hw.scala 38:51:@8119.4]
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
    .io_out_1_ready(Router_Hw_14_io_out_1_ready)
  );
  Router_Hw_15 Router_Hw_15 ( // @[Cgra_Hw.scala 38:51:@8122.4]
    .clock(Router_Hw_15_clock),
    .reset(Router_Hw_15_reset),
    .io_in_0_valid(Router_Hw_15_io_in_0_valid),
    .io_in_0_bits(Router_Hw_15_io_in_0_bits),
    .io_in_0_ready(Router_Hw_15_io_in_0_ready),
    .io_out_5_valid(Router_Hw_15_io_out_5_valid),
    .io_out_5_bits(Router_Hw_15_io_out_5_bits),
    .io_out_5_ready(Router_Hw_15_io_out_5_ready)
  );
  assign io_in_0_ready = VectorPort_Hw_1_io_in_0_ready; // @[Cgra_Hw.scala 78:47:@8153.4]
  assign io_in_1_ready = VectorPort_Hw_io_in_0_ready; // @[Cgra_Hw.scala 78:47:@8157.4]
  assign io_out_0_valid = VectorPort_Hw_3_io_out_0_valid; // @[Cgra_Hw.scala 80:48:@8163.4]
  assign io_out_0_bits = VectorPort_Hw_3_io_out_0_bits; // @[Cgra_Hw.scala 80:48:@8162.4]
  assign io_out_0_config = 1'h0; // @[Cgra_Hw.scala 80:48:@8160.4]
  assign io_out_1_valid = VectorPort_Hw_2_io_out_0_valid; // @[Cgra_Hw.scala 80:48:@8167.4]
  assign io_out_1_bits = VectorPort_Hw_2_io_out_0_bits; // @[Cgra_Hw.scala 80:48:@8166.4]
  assign io_out_1_config = 1'h0; // @[Cgra_Hw.scala 80:48:@8164.4]
  assign VectorPort_Hw_clock = clock; // @[:@8066.4]
  assign VectorPort_Hw_reset = reset; // @[:@8067.4]
  assign VectorPort_Hw_io_in_0_valid = io_in_1_valid; // @[Cgra_Hw.scala 78:47:@8159.4]
  assign VectorPort_Hw_io_in_0_bits = io_in_1_bits; // @[Cgra_Hw.scala 78:47:@8158.4]
  assign VectorPort_Hw_io_in_0_config = io_in_1_config; // @[Cgra_Hw.scala 78:47:@8156.4]
  assign VectorPort_Hw_io_out_0_ready = Router_Hw_13_io_in_2_ready; // @[Cgra_Hw.scala 82:48:@8181.4]
  assign VectorPort_Hw_io_out_1_ready = 1'h1; // @[Cgra_Hw.scala 82:48:@8185.4]
  assign VectorPort_Hw_io_out_2_ready = 1'h1; // @[Cgra_Hw.scala 82:48:@8189.4]
  assign VectorPort_Hw_1_clock = clock; // @[:@8069.4]
  assign VectorPort_Hw_1_reset = reset; // @[:@8070.4]
  assign VectorPort_Hw_1_io_in_0_valid = io_in_0_valid; // @[Cgra_Hw.scala 78:47:@8155.4]
  assign VectorPort_Hw_1_io_in_0_bits = io_in_0_bits; // @[Cgra_Hw.scala 78:47:@8154.4]
  assign VectorPort_Hw_1_io_in_0_config = io_in_0_config; // @[Cgra_Hw.scala 78:47:@8152.4]
  assign VectorPort_Hw_1_io_out_0_ready = Router_Hw_6_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8169.4]
  assign VectorPort_Hw_1_io_out_1_ready = Router_Hw_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8173.4]
  assign VectorPort_Hw_1_io_out_2_ready = Router_Hw_14_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8177.4]
  assign VectorPort_Hw_2_clock = clock; // @[:@8072.4]
  assign VectorPort_Hw_2_reset = reset; // @[:@8073.4]
  assign VectorPort_Hw_2_io_in_0_valid = Router_Hw_10_io_out_3_valid; // @[Cgra_Hw.scala 82:48:@8207.4]
  assign VectorPort_Hw_2_io_in_0_bits = Router_Hw_10_io_out_3_bits; // @[Cgra_Hw.scala 82:48:@8206.4]
  assign VectorPort_Hw_2_io_in_1_valid = Router_Hw_4_io_out_5_valid; // @[Cgra_Hw.scala 82:48:@8211.4]
  assign VectorPort_Hw_2_io_in_1_bits = Router_Hw_4_io_out_5_bits; // @[Cgra_Hw.scala 82:48:@8210.4]
  assign VectorPort_Hw_2_io_in_2_valid = Router_Hw_15_io_out_5_valid; // @[Cgra_Hw.scala 82:48:@8215.4]
  assign VectorPort_Hw_2_io_in_2_bits = Router_Hw_15_io_out_5_bits; // @[Cgra_Hw.scala 82:48:@8214.4]
  assign VectorPort_Hw_2_io_out_0_ready = io_out_1_ready; // @[Cgra_Hw.scala 80:48:@8165.4]
  assign VectorPort_Hw_3_clock = clock; // @[:@8075.4]
  assign VectorPort_Hw_3_reset = reset; // @[:@8076.4]
  assign VectorPort_Hw_3_io_in_0_valid = Router_Hw_5_io_out_2_valid; // @[Cgra_Hw.scala 82:48:@8195.4]
  assign VectorPort_Hw_3_io_in_0_bits = Router_Hw_5_io_out_2_bits; // @[Cgra_Hw.scala 82:48:@8194.4]
  assign VectorPort_Hw_3_io_in_1_valid = Router_Hw_12_io_out_2_valid; // @[Cgra_Hw.scala 82:48:@8199.4]
  assign VectorPort_Hw_3_io_in_1_bits = Router_Hw_12_io_out_2_bits; // @[Cgra_Hw.scala 82:48:@8198.4]
  assign VectorPort_Hw_3_io_in_2_valid = Router_Hw_8_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8203.4]
  assign VectorPort_Hw_3_io_in_2_bits = Router_Hw_8_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8202.4]
  assign VectorPort_Hw_3_io_out_0_ready = io_out_0_ready; // @[Cgra_Hw.scala 80:48:@8161.4]
  assign Router_Hw_clock = clock; // @[:@8078.4]
  assign Router_Hw_reset = reset; // @[:@8079.4]
  assign Router_Hw_io_in_0_valid = VectorPort_Hw_1_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8175.4]
  assign Router_Hw_io_in_0_bits = VectorPort_Hw_1_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8174.4]
  assign Router_Hw_io_in_0_config = VectorPort_Hw_1_io_out_1_config; // @[Cgra_Hw.scala 82:48:@8172.4]
  assign Router_Hw_io_in_1_valid = Router_Hw_11_io_out_0_valid; // @[Cgra_Hw.scala 82:48:@8343.4]
  assign Router_Hw_io_in_1_bits = Router_Hw_11_io_out_0_bits; // @[Cgra_Hw.scala 82:48:@8342.4]
  assign Router_Hw_io_in_2_valid = Router_Hw_14_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8271.4]
  assign Router_Hw_io_in_2_bits = Router_Hw_14_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8270.4]
  assign Router_Hw_io_in_3_valid = Router_Hw_6_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8247.4]
  assign Router_Hw_io_in_3_bits = Router_Hw_6_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8246.4]
  assign Router_Hw_io_out_0_ready = Router_Hw_11_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8257.4]
  assign Router_Hw_io_out_1_ready = Router_Hw_14_io_in_2_ready; // @[Cgra_Hw.scala 82:48:@8265.4]
  assign Router_Hw_io_out_2_ready = Router_Hw_6_io_in_2_ready; // @[Cgra_Hw.scala 82:48:@8249.4]
  assign Router_Hw_1_clock = clock; // @[:@8081.4]
  assign Router_Hw_1_reset = reset; // @[:@8082.4]
  assign Router_Hw_1_io_in_0_valid = Router_Hw_6_io_out_0_valid; // @[Cgra_Hw.scala 82:48:@8239.4]
  assign Router_Hw_1_io_in_0_bits = Router_Hw_6_io_out_0_bits; // @[Cgra_Hw.scala 82:48:@8238.4]
  assign Router_Hw_1_io_out_0_ready = Router_Hw_6_io_in_1_ready; // @[Cgra_Hw.scala 82:48:@8309.4]
  assign Router_Hw_1_io_out_1_ready = Router_Hw_9_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8325.4]
  assign Router_Hw_2_clock = clock; // @[:@8084.4]
  assign Router_Hw_2_reset = reset; // @[:@8085.4]
  assign Router_Hw_2_io_in_0_valid = Router_Hw_7_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8299.4]
  assign Router_Hw_2_io_in_0_bits = Router_Hw_7_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8298.4]
  assign Router_Hw_2_io_out_1_ready = Router_Hw_10_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8401.4]
  assign Router_Hw_3_clock = clock; // @[:@8087.4]
  assign Router_Hw_3_reset = reset; // @[:@8088.4]
  assign Router_Hw_3_io_in_0_valid = Router_Hw_11_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8359.4]
  assign Router_Hw_3_io_in_0_bits = Router_Hw_11_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8358.4]
  assign Router_Hw_3_io_out_1_ready = Router_Hw_15_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8461.4]
  assign Router_Hw_4_clock = clock; // @[:@8090.4]
  assign Router_Hw_4_reset = reset; // @[:@8091.4]
  assign Router_Hw_4_io_in_0_valid = Router_Hw_9_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8431.4]
  assign Router_Hw_4_io_in_0_bits = Router_Hw_9_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8430.4]
  assign Router_Hw_4_io_out_5_ready = VectorPort_Hw_2_io_in_1_ready; // @[Cgra_Hw.scala 82:48:@8209.4]
  assign Router_Hw_5_clock = clock; // @[:@8093.4]
  assign Router_Hw_5_reset = reset; // @[:@8094.4]
  assign Router_Hw_5_io_in_0_valid = Router_Hw_14_io_out_0_valid; // @[Cgra_Hw.scala 82:48:@8279.4]
  assign Router_Hw_5_io_in_0_bits = Router_Hw_14_io_out_0_bits; // @[Cgra_Hw.scala 82:48:@8278.4]
  assign Router_Hw_5_io_out_0_ready = Router_Hw_14_io_in_1_ready; // @[Cgra_Hw.scala 82:48:@8373.4]
  assign Router_Hw_5_io_out_1_ready = Router_Hw_12_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8377.4]
  assign Router_Hw_5_io_out_2_ready = VectorPort_Hw_3_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8193.4]
  assign Router_Hw_6_clock = clock; // @[:@8096.4]
  assign Router_Hw_6_reset = reset; // @[:@8097.4]
  assign Router_Hw_6_io_in_0_valid = VectorPort_Hw_1_io_out_0_valid; // @[Cgra_Hw.scala 82:48:@8171.4]
  assign Router_Hw_6_io_in_0_bits = VectorPort_Hw_1_io_out_0_bits; // @[Cgra_Hw.scala 82:48:@8170.4]
  assign Router_Hw_6_io_in_0_config = VectorPort_Hw_1_io_out_0_config; // @[Cgra_Hw.scala 82:48:@8168.4]
  assign Router_Hw_6_io_in_1_valid = Router_Hw_1_io_out_0_valid; // @[Cgra_Hw.scala 82:48:@8311.4]
  assign Router_Hw_6_io_in_1_bits = Router_Hw_1_io_out_0_bits; // @[Cgra_Hw.scala 82:48:@8310.4]
  assign Router_Hw_6_io_in_2_valid = Router_Hw_io_out_2_valid; // @[Cgra_Hw.scala 82:48:@8251.4]
  assign Router_Hw_6_io_in_2_bits = Router_Hw_io_out_2_bits; // @[Cgra_Hw.scala 82:48:@8250.4]
  assign Router_Hw_6_io_in_3_valid = Router_Hw_13_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8219.4]
  assign Router_Hw_6_io_in_3_bits = Router_Hw_13_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8218.4]
  assign Router_Hw_6_io_out_0_ready = Router_Hw_1_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8237.4]
  assign Router_Hw_6_io_out_1_ready = Router_Hw_io_in_3_ready; // @[Cgra_Hw.scala 82:48:@8245.4]
  assign Router_Hw_6_io_out_2_ready = Router_Hw_13_io_in_1_ready; // @[Cgra_Hw.scala 82:48:@8229.4]
  assign Router_Hw_7_clock = clock; // @[:@8099.4]
  assign Router_Hw_7_reset = reset; // @[:@8100.4]
  assign Router_Hw_7_io_in_0_valid = Router_Hw_13_io_out_0_valid; // @[Cgra_Hw.scala 82:48:@8223.4]
  assign Router_Hw_7_io_in_0_bits = Router_Hw_13_io_out_0_bits; // @[Cgra_Hw.scala 82:48:@8222.4]
  assign Router_Hw_7_io_out_0_ready = Router_Hw_13_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8281.4]
  assign Router_Hw_7_io_out_1_ready = Router_Hw_2_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8297.4]
  assign Router_Hw_8_clock = clock; // @[:@8102.4]
  assign Router_Hw_8_reset = reset; // @[:@8103.4]
  assign Router_Hw_8_io_in_0_valid = Router_Hw_12_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8483.4]
  assign Router_Hw_8_io_in_0_bits = Router_Hw_12_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8482.4]
  assign Router_Hw_8_io_out_1_ready = VectorPort_Hw_3_io_in_2_ready; // @[Cgra_Hw.scala 82:48:@8201.4]
  assign Router_Hw_9_clock = clock; // @[:@8105.4]
  assign Router_Hw_9_reset = reset; // @[:@8106.4]
  assign Router_Hw_9_io_in_0_valid = Router_Hw_1_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8327.4]
  assign Router_Hw_9_io_in_0_bits = Router_Hw_1_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8326.4]
  assign Router_Hw_9_io_out_1_ready = Router_Hw_4_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8429.4]
  assign Router_Hw_10_clock = clock; // @[:@8108.4]
  assign Router_Hw_10_reset = reset; // @[:@8109.4]
  assign Router_Hw_10_io_in_0_valid = Router_Hw_2_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8403.4]
  assign Router_Hw_10_io_in_0_bits = Router_Hw_2_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8402.4]
  assign Router_Hw_10_io_out_3_ready = VectorPort_Hw_2_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8205.4]
  assign Router_Hw_11_clock = clock; // @[:@8111.4]
  assign Router_Hw_11_reset = reset; // @[:@8112.4]
  assign Router_Hw_11_io_in_0_valid = Router_Hw_io_out_0_valid; // @[Cgra_Hw.scala 82:48:@8259.4]
  assign Router_Hw_11_io_in_0_bits = Router_Hw_io_out_0_bits; // @[Cgra_Hw.scala 82:48:@8258.4]
  assign Router_Hw_11_io_out_0_ready = Router_Hw_io_in_1_ready; // @[Cgra_Hw.scala 82:48:@8341.4]
  assign Router_Hw_11_io_out_1_ready = Router_Hw_3_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8357.4]
  assign Router_Hw_12_clock = clock; // @[:@8114.4]
  assign Router_Hw_12_reset = reset; // @[:@8115.4]
  assign Router_Hw_12_io_in_0_valid = Router_Hw_5_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8379.4]
  assign Router_Hw_12_io_in_0_bits = Router_Hw_5_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8378.4]
  assign Router_Hw_12_io_out_1_ready = Router_Hw_8_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8481.4]
  assign Router_Hw_12_io_out_2_ready = VectorPort_Hw_3_io_in_1_ready; // @[Cgra_Hw.scala 82:48:@8197.4]
  assign Router_Hw_13_clock = clock; // @[:@8117.4]
  assign Router_Hw_13_reset = reset; // @[:@8118.4]
  assign Router_Hw_13_io_in_0_valid = Router_Hw_7_io_out_0_valid; // @[Cgra_Hw.scala 82:48:@8283.4]
  assign Router_Hw_13_io_in_0_bits = Router_Hw_7_io_out_0_bits; // @[Cgra_Hw.scala 82:48:@8282.4]
  assign Router_Hw_13_io_in_1_valid = Router_Hw_6_io_out_2_valid; // @[Cgra_Hw.scala 82:48:@8231.4]
  assign Router_Hw_13_io_in_1_bits = Router_Hw_6_io_out_2_bits; // @[Cgra_Hw.scala 82:48:@8230.4]
  assign Router_Hw_13_io_in_2_valid = VectorPort_Hw_io_out_0_valid; // @[Cgra_Hw.scala 82:48:@8183.4]
  assign Router_Hw_13_io_in_2_bits = VectorPort_Hw_io_out_0_bits; // @[Cgra_Hw.scala 82:48:@8182.4]
  assign Router_Hw_13_io_in_2_config = VectorPort_Hw_io_out_0_config; // @[Cgra_Hw.scala 82:48:@8180.4]
  assign Router_Hw_13_io_out_0_ready = Router_Hw_7_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8221.4]
  assign Router_Hw_13_io_out_1_ready = Router_Hw_6_io_in_3_ready; // @[Cgra_Hw.scala 82:48:@8217.4]
  assign Router_Hw_14_clock = clock; // @[:@8120.4]
  assign Router_Hw_14_reset = reset; // @[:@8121.4]
  assign Router_Hw_14_io_in_0_valid = VectorPort_Hw_1_io_out_2_valid; // @[Cgra_Hw.scala 82:48:@8179.4]
  assign Router_Hw_14_io_in_0_bits = VectorPort_Hw_1_io_out_2_bits; // @[Cgra_Hw.scala 82:48:@8178.4]
  assign Router_Hw_14_io_in_0_config = VectorPort_Hw_1_io_out_2_config; // @[Cgra_Hw.scala 82:48:@8176.4]
  assign Router_Hw_14_io_in_1_valid = Router_Hw_5_io_out_0_valid; // @[Cgra_Hw.scala 82:48:@8375.4]
  assign Router_Hw_14_io_in_1_bits = Router_Hw_5_io_out_0_bits; // @[Cgra_Hw.scala 82:48:@8374.4]
  assign Router_Hw_14_io_in_2_valid = Router_Hw_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8267.4]
  assign Router_Hw_14_io_in_2_bits = Router_Hw_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8266.4]
  assign Router_Hw_14_io_out_0_ready = Router_Hw_5_io_in_0_ready; // @[Cgra_Hw.scala 82:48:@8277.4]
  assign Router_Hw_14_io_out_1_ready = Router_Hw_io_in_2_ready; // @[Cgra_Hw.scala 82:48:@8269.4]
  assign Router_Hw_15_clock = clock; // @[:@8123.4]
  assign Router_Hw_15_reset = reset; // @[:@8124.4]
  assign Router_Hw_15_io_in_0_valid = Router_Hw_3_io_out_1_valid; // @[Cgra_Hw.scala 82:48:@8463.4]
  assign Router_Hw_15_io_in_0_bits = Router_Hw_3_io_out_1_bits; // @[Cgra_Hw.scala 82:48:@8462.4]
  assign Router_Hw_15_io_out_5_ready = VectorPort_Hw_2_io_in_2_ready; // @[Cgra_Hw.scala 82:48:@8213.4]
endmodule
