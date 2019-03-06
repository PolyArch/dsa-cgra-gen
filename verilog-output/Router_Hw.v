module Multiplexer_Hw( // @[:@3.2]
  input  [2:0]  io_6, // @[:@6.4]
  input         io_5_ready, // @[:@6.4]
  output        io_5_valid, // @[:@6.4]
  output [31:0] io_5_bits, // @[:@6.4]
  output        io_4_ready, // @[:@6.4]
  input         io_4_valid, // @[:@6.4]
  input  [31:0] io_4_bits, // @[:@6.4]
  output        io_3_ready, // @[:@6.4]
  input         io_3_valid, // @[:@6.4]
  input  [31:0] io_3_bits, // @[:@6.4]
  output        io_2_ready, // @[:@6.4]
  input         io_2_valid, // @[:@6.4]
  input  [31:0] io_2_bits, // @[:@6.4]
  output        io_1_ready, // @[:@6.4]
  input         io_1_valid, // @[:@6.4]
  input  [31:0] io_1_bits, // @[:@6.4]
  output        io_0_ready, // @[:@6.4]
  input         io_0_valid, // @[:@6.4]
  input  [31:0] io_0_bits // @[:@6.4]
);
  wire  _T_98; // @[Multiplexer.scala 105:17:@17.4]
  wire [31:0] _GEN_0; // @[Multiplexer.scala 105:30:@18.4]
  wire  _GEN_1; // @[Multiplexer.scala 105:30:@18.4]
  wire  _T_100; // @[Multiplexer.scala 105:17:@23.4]
  wire [31:0] _GEN_3; // @[Multiplexer.scala 105:30:@24.4]
  wire  _GEN_4; // @[Multiplexer.scala 105:30:@24.4]
  wire  _T_102; // @[Multiplexer.scala 105:17:@29.4]
  wire [31:0] _GEN_6; // @[Multiplexer.scala 105:30:@30.4]
  wire  _GEN_7; // @[Multiplexer.scala 105:30:@30.4]
  wire  _T_104; // @[Multiplexer.scala 105:17:@35.4]
  wire [31:0] _GEN_9; // @[Multiplexer.scala 105:30:@36.4]
  wire  _GEN_10; // @[Multiplexer.scala 105:30:@36.4]
  wire  _T_106; // @[Multiplexer.scala 105:17:@41.4]
  assign _T_98 = io_6 == 3'h2; // @[Multiplexer.scala 105:17:@17.4]
  assign _GEN_0 = _T_98 ? io_2_bits : 32'h0; // @[Multiplexer.scala 105:30:@18.4]
  assign _GEN_1 = _T_98 ? io_2_valid : 1'h0; // @[Multiplexer.scala 105:30:@18.4]
  assign _T_100 = io_6 == 3'h4; // @[Multiplexer.scala 105:17:@23.4]
  assign _GEN_3 = _T_100 ? io_4_bits : _GEN_0; // @[Multiplexer.scala 105:30:@24.4]
  assign _GEN_4 = _T_100 ? io_4_valid : _GEN_1; // @[Multiplexer.scala 105:30:@24.4]
  assign _T_102 = io_6 == 3'h1; // @[Multiplexer.scala 105:17:@29.4]
  assign _GEN_6 = _T_102 ? io_1_bits : _GEN_3; // @[Multiplexer.scala 105:30:@30.4]
  assign _GEN_7 = _T_102 ? io_1_valid : _GEN_4; // @[Multiplexer.scala 105:30:@30.4]
  assign _T_104 = io_6 == 3'h3; // @[Multiplexer.scala 105:17:@35.4]
  assign _GEN_9 = _T_104 ? io_3_bits : _GEN_6; // @[Multiplexer.scala 105:30:@36.4]
  assign _GEN_10 = _T_104 ? io_3_valid : _GEN_7; // @[Multiplexer.scala 105:30:@36.4]
  assign _T_106 = io_6 == 3'h0; // @[Multiplexer.scala 105:17:@41.4]
  assign io_5_valid = _T_106 ? io_0_valid : _GEN_10; // @[Multiplexer.scala 91:28:@11.4 Multiplexer.scala 106:24:@20.6 Multiplexer.scala 106:24:@26.6 Multiplexer.scala 106:24:@32.6 Multiplexer.scala 106:24:@38.6 Multiplexer.scala 106:24:@44.6]
  assign io_5_bits = _T_106 ? io_0_bits : _GEN_9; // @[Multiplexer.scala 91:13:@10.4 Multiplexer.scala 106:24:@19.6 Multiplexer.scala 106:24:@25.6 Multiplexer.scala 106:24:@31.6 Multiplexer.scala 106:24:@37.6 Multiplexer.scala 106:24:@43.6]
  assign io_4_ready = _T_100 ? io_5_ready : 1'h0; // @[Multiplexer.scala 93:53:@16.4 Multiplexer.scala 106:24:@27.6]
  assign io_3_ready = _T_104 ? io_5_ready : 1'h0; // @[Multiplexer.scala 93:53:@15.4 Multiplexer.scala 106:24:@39.6]
  assign io_2_ready = _T_98 ? io_5_ready : 1'h0; // @[Multiplexer.scala 93:53:@14.4 Multiplexer.scala 106:24:@21.6]
  assign io_1_ready = _T_102 ? io_5_ready : 1'h0; // @[Multiplexer.scala 93:53:@13.4 Multiplexer.scala 106:24:@33.6]
  assign io_0_ready = _T_106 ? io_5_ready : 1'h0; // @[Multiplexer.scala 93:53:@12.4 Multiplexer.scala 106:24:@45.6]
endmodule
module Multiplexer_Hw_1( // @[:@48.2]
  input  [2:0]  io_7, // @[:@51.4]
  output        io_6_valid, // @[:@51.4]
  output [31:0] io_6_bits, // @[:@51.4]
  input         io_5_valid, // @[:@51.4]
  input  [31:0] io_5_bits, // @[:@51.4]
  input         io_4_valid, // @[:@51.4]
  input  [31:0] io_4_bits, // @[:@51.4]
  input         io_3_valid, // @[:@51.4]
  input  [31:0] io_3_bits, // @[:@51.4]
  input         io_2_valid, // @[:@51.4]
  input  [31:0] io_2_bits, // @[:@51.4]
  input         io_1_valid, // @[:@51.4]
  input  [31:0] io_1_bits, // @[:@51.4]
  input         io_0_valid, // @[:@51.4]
  input  [31:0] io_0_bits // @[:@51.4]
);
  wire  _T_113; // @[Multiplexer.scala 105:17:@63.4]
  wire [31:0] _GEN_0; // @[Multiplexer.scala 105:30:@64.4]
  wire  _GEN_1; // @[Multiplexer.scala 105:30:@64.4]
  wire  _T_115; // @[Multiplexer.scala 105:17:@69.4]
  wire [31:0] _GEN_3; // @[Multiplexer.scala 105:30:@70.4]
  wire  _GEN_4; // @[Multiplexer.scala 105:30:@70.4]
  wire  _T_117; // @[Multiplexer.scala 105:17:@75.4]
  wire [31:0] _GEN_6; // @[Multiplexer.scala 105:30:@76.4]
  wire  _GEN_7; // @[Multiplexer.scala 105:30:@76.4]
  wire  _T_119; // @[Multiplexer.scala 105:17:@81.4]
  wire [31:0] _GEN_9; // @[Multiplexer.scala 105:30:@82.4]
  wire  _GEN_10; // @[Multiplexer.scala 105:30:@82.4]
  wire  _T_121; // @[Multiplexer.scala 105:17:@87.4]
  wire [31:0] _GEN_12; // @[Multiplexer.scala 105:30:@88.4]
  wire  _GEN_13; // @[Multiplexer.scala 105:30:@88.4]
  wire  _T_123; // @[Multiplexer.scala 105:17:@93.4]
  assign _T_113 = io_7 == 3'h2; // @[Multiplexer.scala 105:17:@63.4]
  assign _GEN_0 = _T_113 ? io_2_bits : 32'h0; // @[Multiplexer.scala 105:30:@64.4]
  assign _GEN_1 = _T_113 ? io_2_valid : 1'h0; // @[Multiplexer.scala 105:30:@64.4]
  assign _T_115 = io_7 == 3'h5; // @[Multiplexer.scala 105:17:@69.4]
  assign _GEN_3 = _T_115 ? io_5_bits : _GEN_0; // @[Multiplexer.scala 105:30:@70.4]
  assign _GEN_4 = _T_115 ? io_5_valid : _GEN_1; // @[Multiplexer.scala 105:30:@70.4]
  assign _T_117 = io_7 == 3'h4; // @[Multiplexer.scala 105:17:@75.4]
  assign _GEN_6 = _T_117 ? io_4_bits : _GEN_3; // @[Multiplexer.scala 105:30:@76.4]
  assign _GEN_7 = _T_117 ? io_4_valid : _GEN_4; // @[Multiplexer.scala 105:30:@76.4]
  assign _T_119 = io_7 == 3'h1; // @[Multiplexer.scala 105:17:@81.4]
  assign _GEN_9 = _T_119 ? io_1_bits : _GEN_6; // @[Multiplexer.scala 105:30:@82.4]
  assign _GEN_10 = _T_119 ? io_1_valid : _GEN_7; // @[Multiplexer.scala 105:30:@82.4]
  assign _T_121 = io_7 == 3'h3; // @[Multiplexer.scala 105:17:@87.4]
  assign _GEN_12 = _T_121 ? io_3_bits : _GEN_9; // @[Multiplexer.scala 105:30:@88.4]
  assign _GEN_13 = _T_121 ? io_3_valid : _GEN_10; // @[Multiplexer.scala 105:30:@88.4]
  assign _T_123 = io_7 == 3'h0; // @[Multiplexer.scala 105:17:@93.4]
  assign io_6_valid = _T_123 ? io_0_valid : _GEN_13; // @[Multiplexer.scala 91:28:@56.4 Multiplexer.scala 106:24:@66.6 Multiplexer.scala 106:24:@72.6 Multiplexer.scala 106:24:@78.6 Multiplexer.scala 106:24:@84.6 Multiplexer.scala 106:24:@90.6 Multiplexer.scala 106:24:@96.6]
  assign io_6_bits = _T_123 ? io_0_bits : _GEN_12; // @[Multiplexer.scala 91:13:@55.4 Multiplexer.scala 106:24:@65.6 Multiplexer.scala 106:24:@71.6 Multiplexer.scala 106:24:@77.6 Multiplexer.scala 106:24:@83.6 Multiplexer.scala 106:24:@89.6 Multiplexer.scala 106:24:@95.6]
endmodule
module Multiplexer_Hw_4( // @[:@190.2]
  input  [1:0]  io_3, // @[:@193.4]
  input         io_2_ready, // @[:@193.4]
  output        io_2_valid, // @[:@193.4]
  output [63:0] io_2_bits, // @[:@193.4]
  output        io_1_ready, // @[:@193.4]
  input         io_1_valid, // @[:@193.4]
  input  [63:0] io_1_bits, // @[:@193.4]
  output        io_0_ready, // @[:@193.4]
  input         io_0_valid, // @[:@193.4]
  input  [63:0] io_0_bits // @[:@193.4]
);
  wire  config$; // @[Multiplexer.scala 84:20:@195.4 Multiplexer.scala 85:10:@196.4]
  wire [63:0] _GEN_0; // @[Multiplexer.scala 105:30:@202.4]
  wire  _GEN_1; // @[Multiplexer.scala 105:30:@202.4]
  wire  _T_55; // @[Multiplexer.scala 105:17:@207.4]
  assign config$ = io_3[0]; // @[Multiplexer.scala 84:20:@195.4 Multiplexer.scala 85:10:@196.4]
  assign _GEN_0 = config$ ? io_1_bits : 64'h0; // @[Multiplexer.scala 105:30:@202.4]
  assign _GEN_1 = config$ ? io_1_valid : 1'h0; // @[Multiplexer.scala 105:30:@202.4]
  assign _T_55 = config$ == 1'h0; // @[Multiplexer.scala 105:17:@207.4]
  assign io_2_valid = _T_55 ? io_0_valid : _GEN_1; // @[Multiplexer.scala 91:28:@198.4 Multiplexer.scala 106:24:@204.6 Multiplexer.scala 106:24:@210.6]
  assign io_2_bits = _T_55 ? io_0_bits : _GEN_0; // @[Multiplexer.scala 91:13:@197.4 Multiplexer.scala 106:24:@203.6 Multiplexer.scala 106:24:@209.6]
  assign io_1_ready = config$ ? io_2_ready : 1'h0; // @[Multiplexer.scala 93:53:@200.4 Multiplexer.scala 106:24:@205.6]
  assign io_0_ready = _T_55 ? io_2_ready : 1'h0; // @[Multiplexer.scala 93:53:@199.4 Multiplexer.scala 106:24:@211.6]
endmodule
module Multiplexer_Hw_5( // @[:@214.2]
  input  [1:0]  io_3, // @[:@217.4]
  input         io_2_ready, // @[:@217.4]
  output        io_2_valid, // @[:@217.4]
  output [15:0] io_2_bits, // @[:@217.4]
  output        io_1_ready, // @[:@217.4]
  input         io_1_valid, // @[:@217.4]
  input  [15:0] io_1_bits, // @[:@217.4]
  output        io_0_ready, // @[:@217.4]
  input         io_0_valid, // @[:@217.4]
  input  [15:0] io_0_bits // @[:@217.4]
);
  wire  config$; // @[Multiplexer.scala 84:20:@219.4 Multiplexer.scala 85:10:@220.4]
  wire [15:0] _GEN_0; // @[Multiplexer.scala 105:30:@226.4]
  wire  _GEN_1; // @[Multiplexer.scala 105:30:@226.4]
  wire  _T_55; // @[Multiplexer.scala 105:17:@231.4]
  assign config$ = io_3[0]; // @[Multiplexer.scala 84:20:@219.4 Multiplexer.scala 85:10:@220.4]
  assign _GEN_0 = config$ ? io_1_bits : 16'h0; // @[Multiplexer.scala 105:30:@226.4]
  assign _GEN_1 = config$ ? io_1_valid : 1'h0; // @[Multiplexer.scala 105:30:@226.4]
  assign _T_55 = config$ == 1'h0; // @[Multiplexer.scala 105:17:@231.4]
  assign io_2_valid = _T_55 ? io_0_valid : _GEN_1; // @[Multiplexer.scala 91:28:@222.4 Multiplexer.scala 106:24:@228.6 Multiplexer.scala 106:24:@234.6]
  assign io_2_bits = _T_55 ? io_0_bits : _GEN_0; // @[Multiplexer.scala 91:13:@221.4 Multiplexer.scala 106:24:@227.6 Multiplexer.scala 106:24:@233.6]
  assign io_1_ready = config$ ? io_2_ready : 1'h0; // @[Multiplexer.scala 93:53:@224.4 Multiplexer.scala 106:24:@229.6]
  assign io_0_ready = _T_55 ? io_2_ready : 1'h0; // @[Multiplexer.scala 93:53:@223.4 Multiplexer.scala 106:24:@235.6]
endmodule
module Router_Hw( // @[:@310.2]
  input         clock, // @[:@311.4]
  input         reset, // @[:@312.4]
  input         io_29_read_req, // @[:@313.4]
  output        io_29_read_ack, // @[:@313.4]
  input  [15:0] io_29_read_index, // @[:@313.4]
  output [31:0] io_29_read_data, // @[:@313.4]
  input         io_29_write_req, // @[:@313.4]
  output        io_29_write_ack, // @[:@313.4]
  input  [15:0] io_29_write_index, // @[:@313.4]
  input  [31:0] io_29_write_data, // @[:@313.4]
  input         io_28_ready, // @[:@313.4]
  output        io_28_valid, // @[:@313.4]
  output [15:0] io_28_bits, // @[:@313.4]
  input         io_27_ready, // @[:@313.4]
  output        io_27_valid, // @[:@313.4]
  output [15:0] io_27_bits, // @[:@313.4]
  input         io_26_ready, // @[:@313.4]
  output        io_26_valid, // @[:@313.4]
  output [15:0] io_26_bits, // @[:@313.4]
  input         io_25_ready, // @[:@313.4]
  output        io_25_valid, // @[:@313.4]
  output [15:0] io_25_bits, // @[:@313.4]
  input         io_24_ready, // @[:@313.4]
  output        io_24_valid, // @[:@313.4]
  output [63:0] io_24_bits, // @[:@313.4]
  input         io_23_ready, // @[:@313.4]
  output        io_23_valid, // @[:@313.4]
  output [31:0] io_23_bits, // @[:@313.4]
  input         io_22_ready, // @[:@313.4]
  output        io_22_valid, // @[:@313.4]
  output [31:0] io_22_bits, // @[:@313.4]
  input         io_21_ready, // @[:@313.4]
  output        io_21_valid, // @[:@313.4]
  output [31:0] io_21_bits, // @[:@313.4]
  input         io_20_ready, // @[:@313.4]
  output        io_20_valid, // @[:@313.4]
  output [31:0] io_20_bits, // @[:@313.4]
  output        io_19_ready, // @[:@313.4]
  input         io_19_valid, // @[:@313.4]
  input  [63:0] io_19_bits, // @[:@313.4]
  output        io_18_ready, // @[:@313.4]
  input         io_18_valid, // @[:@313.4]
  input  [63:0] io_18_bits, // @[:@313.4]
  output        io_17_ready, // @[:@313.4]
  input         io_17_valid, // @[:@313.4]
  input  [15:0] io_17_bits, // @[:@313.4]
  output        io_16_ready, // @[:@313.4]
  input         io_16_valid, // @[:@313.4]
  input  [15:0] io_16_bits, // @[:@313.4]
  output        io_15_ready, // @[:@313.4]
  input         io_15_valid, // @[:@313.4]
  input  [15:0] io_15_bits, // @[:@313.4]
  output        io_14_ready, // @[:@313.4]
  input         io_14_valid, // @[:@313.4]
  input  [15:0] io_14_bits, // @[:@313.4]
  output        io_13_ready, // @[:@313.4]
  input         io_13_valid, // @[:@313.4]
  input  [15:0] io_13_bits, // @[:@313.4]
  output        io_12_ready, // @[:@313.4]
  input         io_12_valid, // @[:@313.4]
  input  [15:0] io_12_bits, // @[:@313.4]
  output        io_11_ready, // @[:@313.4]
  input         io_11_valid, // @[:@313.4]
  input  [15:0] io_11_bits, // @[:@313.4]
  output        io_10_ready, // @[:@313.4]
  input         io_10_valid, // @[:@313.4]
  input  [15:0] io_10_bits, // @[:@313.4]
  output        io_9_ready, // @[:@313.4]
  input         io_9_valid, // @[:@313.4]
  input  [31:0] io_9_bits, // @[:@313.4]
  output        io_8_ready, // @[:@313.4]
  input         io_8_valid, // @[:@313.4]
  input  [31:0] io_8_bits, // @[:@313.4]
  output        io_7_ready, // @[:@313.4]
  input         io_7_valid, // @[:@313.4]
  input  [31:0] io_7_bits, // @[:@313.4]
  output        io_6_ready, // @[:@313.4]
  input         io_6_valid, // @[:@313.4]
  input  [31:0] io_6_bits, // @[:@313.4]
  output        io_5_ready, // @[:@313.4]
  input         io_5_valid, // @[:@313.4]
  input  [31:0] io_5_bits, // @[:@313.4]
  output        io_4_ready, // @[:@313.4]
  input         io_4_valid, // @[:@313.4]
  input  [31:0] io_4_bits, // @[:@313.4]
  output        io_3_ready, // @[:@313.4]
  input         io_3_valid, // @[:@313.4]
  input  [31:0] io_3_bits, // @[:@313.4]
  output        io_2_ready, // @[:@313.4]
  input         io_2_valid, // @[:@313.4]
  input  [31:0] io_2_bits, // @[:@313.4]
  output        io_1_ready, // @[:@313.4]
  input         io_1_valid, // @[:@313.4]
  input  [31:0] io_1_bits, // @[:@313.4]
  output        io_0_ready, // @[:@313.4]
  input         io_0_valid, // @[:@313.4]
  input  [31:0] io_0_bits // @[:@313.4]
);
  wire [2:0] Multiplexer_Hw_io_6; // @[Router.scala 95:24:@316.4]
  wire  Multiplexer_Hw_io_5_ready; // @[Router.scala 95:24:@316.4]
  wire  Multiplexer_Hw_io_5_valid; // @[Router.scala 95:24:@316.4]
  wire [31:0] Multiplexer_Hw_io_5_bits; // @[Router.scala 95:24:@316.4]
  wire  Multiplexer_Hw_io_4_ready; // @[Router.scala 95:24:@316.4]
  wire  Multiplexer_Hw_io_4_valid; // @[Router.scala 95:24:@316.4]
  wire [31:0] Multiplexer_Hw_io_4_bits; // @[Router.scala 95:24:@316.4]
  wire  Multiplexer_Hw_io_3_ready; // @[Router.scala 95:24:@316.4]
  wire  Multiplexer_Hw_io_3_valid; // @[Router.scala 95:24:@316.4]
  wire [31:0] Multiplexer_Hw_io_3_bits; // @[Router.scala 95:24:@316.4]
  wire  Multiplexer_Hw_io_2_ready; // @[Router.scala 95:24:@316.4]
  wire  Multiplexer_Hw_io_2_valid; // @[Router.scala 95:24:@316.4]
  wire [31:0] Multiplexer_Hw_io_2_bits; // @[Router.scala 95:24:@316.4]
  wire  Multiplexer_Hw_io_1_ready; // @[Router.scala 95:24:@316.4]
  wire  Multiplexer_Hw_io_1_valid; // @[Router.scala 95:24:@316.4]
  wire [31:0] Multiplexer_Hw_io_1_bits; // @[Router.scala 95:24:@316.4]
  wire  Multiplexer_Hw_io_0_ready; // @[Router.scala 95:24:@316.4]
  wire  Multiplexer_Hw_io_0_valid; // @[Router.scala 95:24:@316.4]
  wire [31:0] Multiplexer_Hw_io_0_bits; // @[Router.scala 95:24:@316.4]
  wire [2:0] Multiplexer_Hw_1_io_7; // @[Router.scala 95:24:@339.4]
  wire  Multiplexer_Hw_1_io_6_valid; // @[Router.scala 95:24:@339.4]
  wire [31:0] Multiplexer_Hw_1_io_6_bits; // @[Router.scala 95:24:@339.4]
  wire  Multiplexer_Hw_1_io_5_valid; // @[Router.scala 95:24:@339.4]
  wire [31:0] Multiplexer_Hw_1_io_5_bits; // @[Router.scala 95:24:@339.4]
  wire  Multiplexer_Hw_1_io_4_valid; // @[Router.scala 95:24:@339.4]
  wire [31:0] Multiplexer_Hw_1_io_4_bits; // @[Router.scala 95:24:@339.4]
  wire  Multiplexer_Hw_1_io_3_valid; // @[Router.scala 95:24:@339.4]
  wire [31:0] Multiplexer_Hw_1_io_3_bits; // @[Router.scala 95:24:@339.4]
  wire  Multiplexer_Hw_1_io_2_valid; // @[Router.scala 95:24:@339.4]
  wire [31:0] Multiplexer_Hw_1_io_2_bits; // @[Router.scala 95:24:@339.4]
  wire  Multiplexer_Hw_1_io_1_valid; // @[Router.scala 95:24:@339.4]
  wire [31:0] Multiplexer_Hw_1_io_1_bits; // @[Router.scala 95:24:@339.4]
  wire  Multiplexer_Hw_1_io_0_valid; // @[Router.scala 95:24:@339.4]
  wire [31:0] Multiplexer_Hw_1_io_0_bits; // @[Router.scala 95:24:@339.4]
  wire [2:0] Multiplexer_Hw_2_io_6; // @[Router.scala 95:24:@365.4]
  wire  Multiplexer_Hw_2_io_5_ready; // @[Router.scala 95:24:@365.4]
  wire  Multiplexer_Hw_2_io_5_valid; // @[Router.scala 95:24:@365.4]
  wire [31:0] Multiplexer_Hw_2_io_5_bits; // @[Router.scala 95:24:@365.4]
  wire  Multiplexer_Hw_2_io_4_ready; // @[Router.scala 95:24:@365.4]
  wire  Multiplexer_Hw_2_io_4_valid; // @[Router.scala 95:24:@365.4]
  wire [31:0] Multiplexer_Hw_2_io_4_bits; // @[Router.scala 95:24:@365.4]
  wire  Multiplexer_Hw_2_io_3_ready; // @[Router.scala 95:24:@365.4]
  wire  Multiplexer_Hw_2_io_3_valid; // @[Router.scala 95:24:@365.4]
  wire [31:0] Multiplexer_Hw_2_io_3_bits; // @[Router.scala 95:24:@365.4]
  wire  Multiplexer_Hw_2_io_2_ready; // @[Router.scala 95:24:@365.4]
  wire  Multiplexer_Hw_2_io_2_valid; // @[Router.scala 95:24:@365.4]
  wire [31:0] Multiplexer_Hw_2_io_2_bits; // @[Router.scala 95:24:@365.4]
  wire  Multiplexer_Hw_2_io_1_ready; // @[Router.scala 95:24:@365.4]
  wire  Multiplexer_Hw_2_io_1_valid; // @[Router.scala 95:24:@365.4]
  wire [31:0] Multiplexer_Hw_2_io_1_bits; // @[Router.scala 95:24:@365.4]
  wire  Multiplexer_Hw_2_io_0_ready; // @[Router.scala 95:24:@365.4]
  wire  Multiplexer_Hw_2_io_0_valid; // @[Router.scala 95:24:@365.4]
  wire [31:0] Multiplexer_Hw_2_io_0_bits; // @[Router.scala 95:24:@365.4]
  wire [2:0] Multiplexer_Hw_3_io_6; // @[Router.scala 95:24:@388.4]
  wire  Multiplexer_Hw_3_io_5_ready; // @[Router.scala 95:24:@388.4]
  wire  Multiplexer_Hw_3_io_5_valid; // @[Router.scala 95:24:@388.4]
  wire [31:0] Multiplexer_Hw_3_io_5_bits; // @[Router.scala 95:24:@388.4]
  wire  Multiplexer_Hw_3_io_4_ready; // @[Router.scala 95:24:@388.4]
  wire  Multiplexer_Hw_3_io_4_valid; // @[Router.scala 95:24:@388.4]
  wire [31:0] Multiplexer_Hw_3_io_4_bits; // @[Router.scala 95:24:@388.4]
  wire  Multiplexer_Hw_3_io_3_ready; // @[Router.scala 95:24:@388.4]
  wire  Multiplexer_Hw_3_io_3_valid; // @[Router.scala 95:24:@388.4]
  wire [31:0] Multiplexer_Hw_3_io_3_bits; // @[Router.scala 95:24:@388.4]
  wire  Multiplexer_Hw_3_io_2_ready; // @[Router.scala 95:24:@388.4]
  wire  Multiplexer_Hw_3_io_2_valid; // @[Router.scala 95:24:@388.4]
  wire [31:0] Multiplexer_Hw_3_io_2_bits; // @[Router.scala 95:24:@388.4]
  wire  Multiplexer_Hw_3_io_1_ready; // @[Router.scala 95:24:@388.4]
  wire  Multiplexer_Hw_3_io_1_valid; // @[Router.scala 95:24:@388.4]
  wire [31:0] Multiplexer_Hw_3_io_1_bits; // @[Router.scala 95:24:@388.4]
  wire  Multiplexer_Hw_3_io_0_ready; // @[Router.scala 95:24:@388.4]
  wire  Multiplexer_Hw_3_io_0_valid; // @[Router.scala 95:24:@388.4]
  wire [31:0] Multiplexer_Hw_3_io_0_bits; // @[Router.scala 95:24:@388.4]
  wire [1:0] Multiplexer_Hw_4_io_3; // @[Router.scala 95:24:@411.4]
  wire  Multiplexer_Hw_4_io_2_ready; // @[Router.scala 95:24:@411.4]
  wire  Multiplexer_Hw_4_io_2_valid; // @[Router.scala 95:24:@411.4]
  wire [63:0] Multiplexer_Hw_4_io_2_bits; // @[Router.scala 95:24:@411.4]
  wire  Multiplexer_Hw_4_io_1_ready; // @[Router.scala 95:24:@411.4]
  wire  Multiplexer_Hw_4_io_1_valid; // @[Router.scala 95:24:@411.4]
  wire [63:0] Multiplexer_Hw_4_io_1_bits; // @[Router.scala 95:24:@411.4]
  wire  Multiplexer_Hw_4_io_0_ready; // @[Router.scala 95:24:@411.4]
  wire  Multiplexer_Hw_4_io_0_valid; // @[Router.scala 95:24:@411.4]
  wire [63:0] Multiplexer_Hw_4_io_0_bits; // @[Router.scala 95:24:@411.4]
  wire [1:0] Multiplexer_Hw_5_io_3; // @[Router.scala 95:24:@425.4]
  wire  Multiplexer_Hw_5_io_2_ready; // @[Router.scala 95:24:@425.4]
  wire  Multiplexer_Hw_5_io_2_valid; // @[Router.scala 95:24:@425.4]
  wire [15:0] Multiplexer_Hw_5_io_2_bits; // @[Router.scala 95:24:@425.4]
  wire  Multiplexer_Hw_5_io_1_ready; // @[Router.scala 95:24:@425.4]
  wire  Multiplexer_Hw_5_io_1_valid; // @[Router.scala 95:24:@425.4]
  wire [15:0] Multiplexer_Hw_5_io_1_bits; // @[Router.scala 95:24:@425.4]
  wire  Multiplexer_Hw_5_io_0_ready; // @[Router.scala 95:24:@425.4]
  wire  Multiplexer_Hw_5_io_0_valid; // @[Router.scala 95:24:@425.4]
  wire [15:0] Multiplexer_Hw_5_io_0_bits; // @[Router.scala 95:24:@425.4]
  wire [1:0] Multiplexer_Hw_6_io_3; // @[Router.scala 95:24:@439.4]
  wire  Multiplexer_Hw_6_io_2_ready; // @[Router.scala 95:24:@439.4]
  wire  Multiplexer_Hw_6_io_2_valid; // @[Router.scala 95:24:@439.4]
  wire [15:0] Multiplexer_Hw_6_io_2_bits; // @[Router.scala 95:24:@439.4]
  wire  Multiplexer_Hw_6_io_1_ready; // @[Router.scala 95:24:@439.4]
  wire  Multiplexer_Hw_6_io_1_valid; // @[Router.scala 95:24:@439.4]
  wire [15:0] Multiplexer_Hw_6_io_1_bits; // @[Router.scala 95:24:@439.4]
  wire  Multiplexer_Hw_6_io_0_ready; // @[Router.scala 95:24:@439.4]
  wire  Multiplexer_Hw_6_io_0_valid; // @[Router.scala 95:24:@439.4]
  wire [15:0] Multiplexer_Hw_6_io_0_bits; // @[Router.scala 95:24:@439.4]
  wire [1:0] Multiplexer_Hw_7_io_3; // @[Router.scala 95:24:@453.4]
  wire  Multiplexer_Hw_7_io_2_ready; // @[Router.scala 95:24:@453.4]
  wire  Multiplexer_Hw_7_io_2_valid; // @[Router.scala 95:24:@453.4]
  wire [15:0] Multiplexer_Hw_7_io_2_bits; // @[Router.scala 95:24:@453.4]
  wire  Multiplexer_Hw_7_io_1_ready; // @[Router.scala 95:24:@453.4]
  wire  Multiplexer_Hw_7_io_1_valid; // @[Router.scala 95:24:@453.4]
  wire [15:0] Multiplexer_Hw_7_io_1_bits; // @[Router.scala 95:24:@453.4]
  wire  Multiplexer_Hw_7_io_0_ready; // @[Router.scala 95:24:@453.4]
  wire  Multiplexer_Hw_7_io_0_valid; // @[Router.scala 95:24:@453.4]
  wire [15:0] Multiplexer_Hw_7_io_0_bits; // @[Router.scala 95:24:@453.4]
  wire [1:0] Multiplexer_Hw_8_io_3; // @[Router.scala 95:24:@467.4]
  wire  Multiplexer_Hw_8_io_2_ready; // @[Router.scala 95:24:@467.4]
  wire  Multiplexer_Hw_8_io_2_valid; // @[Router.scala 95:24:@467.4]
  wire [15:0] Multiplexer_Hw_8_io_2_bits; // @[Router.scala 95:24:@467.4]
  wire  Multiplexer_Hw_8_io_1_ready; // @[Router.scala 95:24:@467.4]
  wire  Multiplexer_Hw_8_io_1_valid; // @[Router.scala 95:24:@467.4]
  wire [15:0] Multiplexer_Hw_8_io_1_bits; // @[Router.scala 95:24:@467.4]
  wire  Multiplexer_Hw_8_io_0_ready; // @[Router.scala 95:24:@467.4]
  wire  Multiplexer_Hw_8_io_0_valid; // @[Router.scala 95:24:@467.4]
  wire [15:0] Multiplexer_Hw_8_io_0_bits; // @[Router.scala 95:24:@467.4]
  reg [15:0] config_registers_0; // @[Router.scala 86:29:@315.4]
  reg [31:0] _RAND_0;
  reg [15:0] config_registers_1; // @[Router.scala 86:29:@315.4]
  reg [31:0] _RAND_1;
  wire [2:0] _T_438; // @[:@482.6]
  wire [15:0] _config_registers_T_438; // @[Router.scala 117:47:@483.6 Router.scala 117:47:@483.6]
  wire [15:0] _GEN_0; // @[Router.scala 117:47:@483.6]
  wire [15:0] _GEN_1; // @[Router.scala 117:47:@483.6]
  Multiplexer_Hw Multiplexer_Hw ( // @[Router.scala 95:24:@316.4]
    .io_6(Multiplexer_Hw_io_6),
    .io_5_ready(Multiplexer_Hw_io_5_ready),
    .io_5_valid(Multiplexer_Hw_io_5_valid),
    .io_5_bits(Multiplexer_Hw_io_5_bits),
    .io_4_ready(Multiplexer_Hw_io_4_ready),
    .io_4_valid(Multiplexer_Hw_io_4_valid),
    .io_4_bits(Multiplexer_Hw_io_4_bits),
    .io_3_ready(Multiplexer_Hw_io_3_ready),
    .io_3_valid(Multiplexer_Hw_io_3_valid),
    .io_3_bits(Multiplexer_Hw_io_3_bits),
    .io_2_ready(Multiplexer_Hw_io_2_ready),
    .io_2_valid(Multiplexer_Hw_io_2_valid),
    .io_2_bits(Multiplexer_Hw_io_2_bits),
    .io_1_ready(Multiplexer_Hw_io_1_ready),
    .io_1_valid(Multiplexer_Hw_io_1_valid),
    .io_1_bits(Multiplexer_Hw_io_1_bits),
    .io_0_ready(Multiplexer_Hw_io_0_ready),
    .io_0_valid(Multiplexer_Hw_io_0_valid),
    .io_0_bits(Multiplexer_Hw_io_0_bits)
  );
  Multiplexer_Hw_1 Multiplexer_Hw_1 ( // @[Router.scala 95:24:@339.4]
    .io_7(Multiplexer_Hw_1_io_7),
    .io_6_valid(Multiplexer_Hw_1_io_6_valid),
    .io_6_bits(Multiplexer_Hw_1_io_6_bits),
    .io_5_valid(Multiplexer_Hw_1_io_5_valid),
    .io_5_bits(Multiplexer_Hw_1_io_5_bits),
    .io_4_valid(Multiplexer_Hw_1_io_4_valid),
    .io_4_bits(Multiplexer_Hw_1_io_4_bits),
    .io_3_valid(Multiplexer_Hw_1_io_3_valid),
    .io_3_bits(Multiplexer_Hw_1_io_3_bits),
    .io_2_valid(Multiplexer_Hw_1_io_2_valid),
    .io_2_bits(Multiplexer_Hw_1_io_2_bits),
    .io_1_valid(Multiplexer_Hw_1_io_1_valid),
    .io_1_bits(Multiplexer_Hw_1_io_1_bits),
    .io_0_valid(Multiplexer_Hw_1_io_0_valid),
    .io_0_bits(Multiplexer_Hw_1_io_0_bits)
  );
  Multiplexer_Hw Multiplexer_Hw_2 ( // @[Router.scala 95:24:@365.4]
    .io_6(Multiplexer_Hw_2_io_6),
    .io_5_ready(Multiplexer_Hw_2_io_5_ready),
    .io_5_valid(Multiplexer_Hw_2_io_5_valid),
    .io_5_bits(Multiplexer_Hw_2_io_5_bits),
    .io_4_ready(Multiplexer_Hw_2_io_4_ready),
    .io_4_valid(Multiplexer_Hw_2_io_4_valid),
    .io_4_bits(Multiplexer_Hw_2_io_4_bits),
    .io_3_ready(Multiplexer_Hw_2_io_3_ready),
    .io_3_valid(Multiplexer_Hw_2_io_3_valid),
    .io_3_bits(Multiplexer_Hw_2_io_3_bits),
    .io_2_ready(Multiplexer_Hw_2_io_2_ready),
    .io_2_valid(Multiplexer_Hw_2_io_2_valid),
    .io_2_bits(Multiplexer_Hw_2_io_2_bits),
    .io_1_ready(Multiplexer_Hw_2_io_1_ready),
    .io_1_valid(Multiplexer_Hw_2_io_1_valid),
    .io_1_bits(Multiplexer_Hw_2_io_1_bits),
    .io_0_ready(Multiplexer_Hw_2_io_0_ready),
    .io_0_valid(Multiplexer_Hw_2_io_0_valid),
    .io_0_bits(Multiplexer_Hw_2_io_0_bits)
  );
  Multiplexer_Hw Multiplexer_Hw_3 ( // @[Router.scala 95:24:@388.4]
    .io_6(Multiplexer_Hw_3_io_6),
    .io_5_ready(Multiplexer_Hw_3_io_5_ready),
    .io_5_valid(Multiplexer_Hw_3_io_5_valid),
    .io_5_bits(Multiplexer_Hw_3_io_5_bits),
    .io_4_ready(Multiplexer_Hw_3_io_4_ready),
    .io_4_valid(Multiplexer_Hw_3_io_4_valid),
    .io_4_bits(Multiplexer_Hw_3_io_4_bits),
    .io_3_ready(Multiplexer_Hw_3_io_3_ready),
    .io_3_valid(Multiplexer_Hw_3_io_3_valid),
    .io_3_bits(Multiplexer_Hw_3_io_3_bits),
    .io_2_ready(Multiplexer_Hw_3_io_2_ready),
    .io_2_valid(Multiplexer_Hw_3_io_2_valid),
    .io_2_bits(Multiplexer_Hw_3_io_2_bits),
    .io_1_ready(Multiplexer_Hw_3_io_1_ready),
    .io_1_valid(Multiplexer_Hw_3_io_1_valid),
    .io_1_bits(Multiplexer_Hw_3_io_1_bits),
    .io_0_ready(Multiplexer_Hw_3_io_0_ready),
    .io_0_valid(Multiplexer_Hw_3_io_0_valid),
    .io_0_bits(Multiplexer_Hw_3_io_0_bits)
  );
  Multiplexer_Hw_4 Multiplexer_Hw_4 ( // @[Router.scala 95:24:@411.4]
    .io_3(Multiplexer_Hw_4_io_3),
    .io_2_ready(Multiplexer_Hw_4_io_2_ready),
    .io_2_valid(Multiplexer_Hw_4_io_2_valid),
    .io_2_bits(Multiplexer_Hw_4_io_2_bits),
    .io_1_ready(Multiplexer_Hw_4_io_1_ready),
    .io_1_valid(Multiplexer_Hw_4_io_1_valid),
    .io_1_bits(Multiplexer_Hw_4_io_1_bits),
    .io_0_ready(Multiplexer_Hw_4_io_0_ready),
    .io_0_valid(Multiplexer_Hw_4_io_0_valid),
    .io_0_bits(Multiplexer_Hw_4_io_0_bits)
  );
  Multiplexer_Hw_5 Multiplexer_Hw_5 ( // @[Router.scala 95:24:@425.4]
    .io_3(Multiplexer_Hw_5_io_3),
    .io_2_ready(Multiplexer_Hw_5_io_2_ready),
    .io_2_valid(Multiplexer_Hw_5_io_2_valid),
    .io_2_bits(Multiplexer_Hw_5_io_2_bits),
    .io_1_ready(Multiplexer_Hw_5_io_1_ready),
    .io_1_valid(Multiplexer_Hw_5_io_1_valid),
    .io_1_bits(Multiplexer_Hw_5_io_1_bits),
    .io_0_ready(Multiplexer_Hw_5_io_0_ready),
    .io_0_valid(Multiplexer_Hw_5_io_0_valid),
    .io_0_bits(Multiplexer_Hw_5_io_0_bits)
  );
  Multiplexer_Hw_5 Multiplexer_Hw_6 ( // @[Router.scala 95:24:@439.4]
    .io_3(Multiplexer_Hw_6_io_3),
    .io_2_ready(Multiplexer_Hw_6_io_2_ready),
    .io_2_valid(Multiplexer_Hw_6_io_2_valid),
    .io_2_bits(Multiplexer_Hw_6_io_2_bits),
    .io_1_ready(Multiplexer_Hw_6_io_1_ready),
    .io_1_valid(Multiplexer_Hw_6_io_1_valid),
    .io_1_bits(Multiplexer_Hw_6_io_1_bits),
    .io_0_ready(Multiplexer_Hw_6_io_0_ready),
    .io_0_valid(Multiplexer_Hw_6_io_0_valid),
    .io_0_bits(Multiplexer_Hw_6_io_0_bits)
  );
  Multiplexer_Hw_5 Multiplexer_Hw_7 ( // @[Router.scala 95:24:@453.4]
    .io_3(Multiplexer_Hw_7_io_3),
    .io_2_ready(Multiplexer_Hw_7_io_2_ready),
    .io_2_valid(Multiplexer_Hw_7_io_2_valid),
    .io_2_bits(Multiplexer_Hw_7_io_2_bits),
    .io_1_ready(Multiplexer_Hw_7_io_1_ready),
    .io_1_valid(Multiplexer_Hw_7_io_1_valid),
    .io_1_bits(Multiplexer_Hw_7_io_1_bits),
    .io_0_ready(Multiplexer_Hw_7_io_0_ready),
    .io_0_valid(Multiplexer_Hw_7_io_0_valid),
    .io_0_bits(Multiplexer_Hw_7_io_0_bits)
  );
  Multiplexer_Hw_5 Multiplexer_Hw_8 ( // @[Router.scala 95:24:@467.4]
    .io_3(Multiplexer_Hw_8_io_3),
    .io_2_ready(Multiplexer_Hw_8_io_2_ready),
    .io_2_valid(Multiplexer_Hw_8_io_2_valid),
    .io_2_bits(Multiplexer_Hw_8_io_2_bits),
    .io_1_ready(Multiplexer_Hw_8_io_1_ready),
    .io_1_valid(Multiplexer_Hw_8_io_1_valid),
    .io_1_bits(Multiplexer_Hw_8_io_1_bits),
    .io_0_ready(Multiplexer_Hw_8_io_0_ready),
    .io_0_valid(Multiplexer_Hw_8_io_0_valid),
    .io_0_bits(Multiplexer_Hw_8_io_0_bits)
  );
  assign _T_438 = io_29_write_index[2:0]; // @[:@482.6]
  assign _config_registers_T_438 = io_29_write_data[15:0]; // @[Router.scala 117:47:@483.6 Router.scala 117:47:@483.6]
  assign _GEN_0 = 3'h0 == _T_438 ? _config_registers_T_438 : config_registers_0; // @[Router.scala 117:47:@483.6]
  assign _GEN_1 = 3'h1 == _T_438 ? _config_registers_T_438 : config_registers_1; // @[Router.scala 117:47:@483.6]
  assign io_29_read_ack = 1'h0; // @[Router.scala 120:24:@486.4]
  assign io_29_read_data = 32'h0; // @[Router.scala 121:25:@487.4]
  assign io_29_write_ack = 1'h1; // @[Router.scala 119:25:@485.4]
  assign io_28_valid = Multiplexer_Hw_8_io_2_valid; // @[Router.scala 104:25:@477.4]
  assign io_28_bits = Multiplexer_Hw_8_io_2_bits; // @[Router.scala 104:25:@476.4]
  assign io_27_valid = Multiplexer_Hw_7_io_2_valid; // @[Router.scala 104:25:@463.4]
  assign io_27_bits = Multiplexer_Hw_7_io_2_bits; // @[Router.scala 104:25:@462.4]
  assign io_26_valid = Multiplexer_Hw_6_io_2_valid; // @[Router.scala 104:25:@449.4]
  assign io_26_bits = Multiplexer_Hw_6_io_2_bits; // @[Router.scala 104:25:@448.4]
  assign io_25_valid = Multiplexer_Hw_5_io_2_valid; // @[Router.scala 104:25:@435.4]
  assign io_25_bits = Multiplexer_Hw_5_io_2_bits; // @[Router.scala 104:25:@434.4]
  assign io_24_valid = Multiplexer_Hw_4_io_2_valid; // @[Router.scala 104:25:@421.4]
  assign io_24_bits = Multiplexer_Hw_4_io_2_bits; // @[Router.scala 104:25:@420.4]
  assign io_23_valid = Multiplexer_Hw_3_io_5_valid; // @[Router.scala 104:25:@407.4]
  assign io_23_bits = Multiplexer_Hw_3_io_5_bits; // @[Router.scala 104:25:@406.4]
  assign io_22_valid = Multiplexer_Hw_2_io_5_valid; // @[Router.scala 104:25:@384.4]
  assign io_22_bits = Multiplexer_Hw_2_io_5_bits; // @[Router.scala 104:25:@383.4]
  assign io_21_valid = Multiplexer_Hw_1_io_6_valid; // @[Router.scala 104:25:@361.4]
  assign io_21_bits = Multiplexer_Hw_1_io_6_bits; // @[Router.scala 104:25:@360.4]
  assign io_20_valid = Multiplexer_Hw_io_5_valid; // @[Router.scala 104:25:@335.4]
  assign io_20_bits = Multiplexer_Hw_io_5_bits; // @[Router.scala 104:25:@334.4]
  assign io_19_ready = Multiplexer_Hw_4_io_1_ready; // @[Router.scala 100:29:@416.4]
  assign io_18_ready = Multiplexer_Hw_4_io_0_ready; // @[Router.scala 100:29:@419.4]
  assign io_17_ready = Multiplexer_Hw_8_io_1_ready; // @[Router.scala 100:29:@472.4]
  assign io_16_ready = Multiplexer_Hw_7_io_1_ready; // @[Router.scala 100:29:@458.4]
  assign io_15_ready = Multiplexer_Hw_6_io_1_ready; // @[Router.scala 100:29:@447.4]
  assign io_14_ready = Multiplexer_Hw_5_io_1_ready; // @[Router.scala 100:29:@430.4]
  assign io_13_ready = Multiplexer_Hw_8_io_0_ready; // @[Router.scala 100:29:@475.4]
  assign io_12_ready = Multiplexer_Hw_7_io_0_ready; // @[Router.scala 100:29:@461.4]
  assign io_11_ready = Multiplexer_Hw_6_io_0_ready; // @[Router.scala 100:29:@444.4]
  assign io_10_ready = Multiplexer_Hw_5_io_0_ready; // @[Router.scala 100:29:@433.4]
  assign io_9_ready = Multiplexer_Hw_3_io_4_ready; // @[Router.scala 100:29:@356.4 Router.scala 100:29:@402.4]
  assign io_8_ready = Multiplexer_Hw_2_io_4_ready; // @[Router.scala 100:29:@321.4 Router.scala 100:29:@370.4]
  assign io_7_ready = Multiplexer_Hw_3_io_3_ready; // @[Router.scala 100:29:@350.4 Router.scala 100:29:@396.4]
  assign io_6_ready = Multiplexer_Hw_2_io_3_ready; // @[Router.scala 100:29:@330.4 Router.scala 100:29:@379.4]
  assign io_5_ready = Multiplexer_Hw_3_io_2_ready; // @[Router.scala 100:29:@347.4 Router.scala 100:29:@393.4]
  assign io_4_ready = Multiplexer_Hw_2_io_2_ready; // @[Router.scala 100:29:@327.4 Router.scala 100:29:@376.4]
  assign io_3_ready = Multiplexer_Hw_3_io_1_ready; // @[Router.scala 100:29:@359.4 Router.scala 100:29:@405.4]
  assign io_2_ready = Multiplexer_Hw_2_io_1_ready; // @[Router.scala 100:29:@324.4 Router.scala 100:29:@344.4 Router.scala 100:29:@373.4]
  assign io_1_ready = Multiplexer_Hw_3_io_0_ready; // @[Router.scala 100:29:@353.4 Router.scala 100:29:@399.4]
  assign io_0_ready = Multiplexer_Hw_2_io_0_ready; // @[Router.scala 100:29:@333.4 Router.scala 100:29:@382.4]
  assign Multiplexer_Hw_io_6 = config_registers_0[2:0]; // @[Router.scala 111:35:@338.4]
  assign Multiplexer_Hw_io_5_ready = io_20_ready; // @[Router.scala 104:25:@336.4]
  assign Multiplexer_Hw_io_4_valid = io_8_valid; // @[Router.scala 100:29:@320.4]
  assign Multiplexer_Hw_io_4_bits = io_8_bits; // @[Router.scala 100:29:@319.4]
  assign Multiplexer_Hw_io_3_valid = io_6_valid; // @[Router.scala 100:29:@329.4]
  assign Multiplexer_Hw_io_3_bits = io_6_bits; // @[Router.scala 100:29:@328.4]
  assign Multiplexer_Hw_io_2_valid = io_4_valid; // @[Router.scala 100:29:@326.4]
  assign Multiplexer_Hw_io_2_bits = io_4_bits; // @[Router.scala 100:29:@325.4]
  assign Multiplexer_Hw_io_1_valid = io_2_valid; // @[Router.scala 100:29:@323.4]
  assign Multiplexer_Hw_io_1_bits = io_2_bits; // @[Router.scala 100:29:@322.4]
  assign Multiplexer_Hw_io_0_valid = io_0_valid; // @[Router.scala 100:29:@332.4]
  assign Multiplexer_Hw_io_0_bits = io_0_bits; // @[Router.scala 100:29:@331.4]
  assign Multiplexer_Hw_1_io_7 = config_registers_0[5:3]; // @[Router.scala 111:35:@364.4]
  assign Multiplexer_Hw_1_io_5_valid = io_2_valid; // @[Router.scala 100:29:@343.4]
  assign Multiplexer_Hw_1_io_5_bits = io_2_bits; // @[Router.scala 100:29:@342.4]
  assign Multiplexer_Hw_1_io_4_valid = io_9_valid; // @[Router.scala 100:29:@355.4]
  assign Multiplexer_Hw_1_io_4_bits = io_9_bits; // @[Router.scala 100:29:@354.4]
  assign Multiplexer_Hw_1_io_3_valid = io_7_valid; // @[Router.scala 100:29:@349.4]
  assign Multiplexer_Hw_1_io_3_bits = io_7_bits; // @[Router.scala 100:29:@348.4]
  assign Multiplexer_Hw_1_io_2_valid = io_5_valid; // @[Router.scala 100:29:@346.4]
  assign Multiplexer_Hw_1_io_2_bits = io_5_bits; // @[Router.scala 100:29:@345.4]
  assign Multiplexer_Hw_1_io_1_valid = io_3_valid; // @[Router.scala 100:29:@358.4]
  assign Multiplexer_Hw_1_io_1_bits = io_3_bits; // @[Router.scala 100:29:@357.4]
  assign Multiplexer_Hw_1_io_0_valid = io_1_valid; // @[Router.scala 100:29:@352.4]
  assign Multiplexer_Hw_1_io_0_bits = io_1_bits; // @[Router.scala 100:29:@351.4]
  assign Multiplexer_Hw_2_io_6 = config_registers_0[8:6]; // @[Router.scala 111:35:@387.4]
  assign Multiplexer_Hw_2_io_5_ready = io_22_ready; // @[Router.scala 104:25:@385.4]
  assign Multiplexer_Hw_2_io_4_valid = io_8_valid; // @[Router.scala 100:29:@369.4]
  assign Multiplexer_Hw_2_io_4_bits = io_8_bits; // @[Router.scala 100:29:@368.4]
  assign Multiplexer_Hw_2_io_3_valid = io_6_valid; // @[Router.scala 100:29:@378.4]
  assign Multiplexer_Hw_2_io_3_bits = io_6_bits; // @[Router.scala 100:29:@377.4]
  assign Multiplexer_Hw_2_io_2_valid = io_4_valid; // @[Router.scala 100:29:@375.4]
  assign Multiplexer_Hw_2_io_2_bits = io_4_bits; // @[Router.scala 100:29:@374.4]
  assign Multiplexer_Hw_2_io_1_valid = io_2_valid; // @[Router.scala 100:29:@372.4]
  assign Multiplexer_Hw_2_io_1_bits = io_2_bits; // @[Router.scala 100:29:@371.4]
  assign Multiplexer_Hw_2_io_0_valid = io_0_valid; // @[Router.scala 100:29:@381.4]
  assign Multiplexer_Hw_2_io_0_bits = io_0_bits; // @[Router.scala 100:29:@380.4]
  assign Multiplexer_Hw_3_io_6 = config_registers_0[11:9]; // @[Router.scala 111:35:@410.4]
  assign Multiplexer_Hw_3_io_5_ready = io_23_ready; // @[Router.scala 104:25:@408.4]
  assign Multiplexer_Hw_3_io_4_valid = io_9_valid; // @[Router.scala 100:29:@401.4]
  assign Multiplexer_Hw_3_io_4_bits = io_9_bits; // @[Router.scala 100:29:@400.4]
  assign Multiplexer_Hw_3_io_3_valid = io_7_valid; // @[Router.scala 100:29:@395.4]
  assign Multiplexer_Hw_3_io_3_bits = io_7_bits; // @[Router.scala 100:29:@394.4]
  assign Multiplexer_Hw_3_io_2_valid = io_5_valid; // @[Router.scala 100:29:@392.4]
  assign Multiplexer_Hw_3_io_2_bits = io_5_bits; // @[Router.scala 100:29:@391.4]
  assign Multiplexer_Hw_3_io_1_valid = io_3_valid; // @[Router.scala 100:29:@404.4]
  assign Multiplexer_Hw_3_io_1_bits = io_3_bits; // @[Router.scala 100:29:@403.4]
  assign Multiplexer_Hw_3_io_0_valid = io_1_valid; // @[Router.scala 100:29:@398.4]
  assign Multiplexer_Hw_3_io_0_bits = io_1_bits; // @[Router.scala 100:29:@397.4]
  assign Multiplexer_Hw_4_io_3 = config_registers_0[13:12]; // @[Router.scala 111:35:@424.4]
  assign Multiplexer_Hw_4_io_2_ready = io_24_ready; // @[Router.scala 104:25:@422.4]
  assign Multiplexer_Hw_4_io_1_valid = io_19_valid; // @[Router.scala 100:29:@415.4]
  assign Multiplexer_Hw_4_io_1_bits = io_19_bits; // @[Router.scala 100:29:@414.4]
  assign Multiplexer_Hw_4_io_0_valid = io_18_valid; // @[Router.scala 100:29:@418.4]
  assign Multiplexer_Hw_4_io_0_bits = io_18_bits; // @[Router.scala 100:29:@417.4]
  assign Multiplexer_Hw_5_io_3 = config_registers_0[15:14]; // @[Router.scala 111:35:@438.4]
  assign Multiplexer_Hw_5_io_2_ready = io_25_ready; // @[Router.scala 104:25:@436.4]
  assign Multiplexer_Hw_5_io_1_valid = io_14_valid; // @[Router.scala 100:29:@429.4]
  assign Multiplexer_Hw_5_io_1_bits = io_14_bits; // @[Router.scala 100:29:@428.4]
  assign Multiplexer_Hw_5_io_0_valid = io_10_valid; // @[Router.scala 100:29:@432.4]
  assign Multiplexer_Hw_5_io_0_bits = io_10_bits; // @[Router.scala 100:29:@431.4]
  assign Multiplexer_Hw_6_io_3 = config_registers_1[1:0]; // @[Router.scala 111:35:@452.4]
  assign Multiplexer_Hw_6_io_2_ready = io_26_ready; // @[Router.scala 104:25:@450.4]
  assign Multiplexer_Hw_6_io_1_valid = io_15_valid; // @[Router.scala 100:29:@446.4]
  assign Multiplexer_Hw_6_io_1_bits = io_15_bits; // @[Router.scala 100:29:@445.4]
  assign Multiplexer_Hw_6_io_0_valid = io_11_valid; // @[Router.scala 100:29:@443.4]
  assign Multiplexer_Hw_6_io_0_bits = io_11_bits; // @[Router.scala 100:29:@442.4]
  assign Multiplexer_Hw_7_io_3 = config_registers_1[3:2]; // @[Router.scala 111:35:@466.4]
  assign Multiplexer_Hw_7_io_2_ready = io_27_ready; // @[Router.scala 104:25:@464.4]
  assign Multiplexer_Hw_7_io_1_valid = io_16_valid; // @[Router.scala 100:29:@457.4]
  assign Multiplexer_Hw_7_io_1_bits = io_16_bits; // @[Router.scala 100:29:@456.4]
  assign Multiplexer_Hw_7_io_0_valid = io_12_valid; // @[Router.scala 100:29:@460.4]
  assign Multiplexer_Hw_7_io_0_bits = io_12_bits; // @[Router.scala 100:29:@459.4]
  assign Multiplexer_Hw_8_io_3 = config_registers_1[5:4]; // @[Router.scala 111:35:@480.4]
  assign Multiplexer_Hw_8_io_2_ready = io_28_ready; // @[Router.scala 104:25:@478.4]
  assign Multiplexer_Hw_8_io_1_valid = io_17_valid; // @[Router.scala 100:29:@471.4]
  assign Multiplexer_Hw_8_io_1_bits = io_17_bits; // @[Router.scala 100:29:@470.4]
  assign Multiplexer_Hw_8_io_0_valid = io_13_valid; // @[Router.scala 100:29:@474.4]
  assign Multiplexer_Hw_8_io_0_bits = io_13_bits; // @[Router.scala 100:29:@473.4]
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
  config_registers_0 = _RAND_0[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  config_registers_1 = _RAND_1[15:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (io_29_write_req) begin
      if (3'h0 == _T_438) begin
        config_registers_0 <= _config_registers_T_438;
      end
    end
    if (io_29_write_req) begin
      if (3'h1 == _T_438) begin
        config_registers_1 <= _config_registers_T_438;
      end
    end
  end
endmodule
