module channel_buffer( // @[:@12.2]
  input         clock, // @[:@13.4]
  input         reset, // @[:@14.4]
  input         io_enable, // @[:@15.4]
  output [1:0]  io_sender_pack_tag, // @[:@15.4]
  output [31:0] io_sender_pack_data, // @[:@15.4]
  output [1:0]  io_sender_next_pack_tag, // @[:@15.4]
  input         io_sender_dequeue, // @[:@15.4]
  output        io_sender_empty, // @[:@15.4]
  input  [1:0]  io_receiver_pack_tag, // @[:@15.4]
  input  [31:0] io_receiver_pack_data, // @[:@15.4]
  input         io_receiver_enqueue, // @[:@15.4]
  output        io_receiver_full // @[:@15.4]
);
  reg [33:0] fifo_0; // @[channel_buffer.scala 15:21:@20.4]
  reg [63:0] _RAND_0;
  reg [33:0] fifo_1; // @[channel_buffer.scala 15:21:@20.4]
  reg [63:0] _RAND_1;
  reg [1:0] count; // @[channel_buffer.scala 18:22:@21.4]
  reg [31:0] _RAND_2;
  reg  head; // @[channel_buffer.scala 19:21:@22.4]
  reg [31:0] _RAND_3;
  wire [1:0] _T_58; // @[channel_buffer.scala 20:24:@23.4]
  wire  neck; // @[channel_buffer.scala 20:24:@24.4]
  reg  tail; // @[channel_buffer.scala 21:21:@25.4]
  reg [31:0] _RAND_4;
  wire  isEmpty; // @[channel_buffer.scala 23:28:@26.4]
  wire  isFull; // @[channel_buffer.scala 24:27:@27.4]
  wire [33:0] out_tag_data; // @[channel_buffer.scala 43:16:@42.4]
  wire  _T_77; // @[channel_buffer.scala 44:32:@43.4]
  wire [33:0] _GEN_3; // @[channel_buffer.scala 44:26:@44.4]
  wire [33:0] outNext_tag_data; // @[channel_buffer.scala 44:26:@44.4]
  wire [33:0] in_tag_data; // @[Cat.scala 30:58:@53.4]
  wire  _T_90; // @[channel_buffer.scala 65:12:@66.10]
  wire [33:0] _GEN_4; // @[channel_buffer.scala 67:22:@69.14]
  wire [33:0] _GEN_5; // @[channel_buffer.scala 67:22:@69.14]
  wire [1:0] _T_98; // @[channel_buffer.scala 69:24:@73.14]
  wire  _T_99; // @[channel_buffer.scala 69:24:@74.14]
  wire [2:0] _T_104; // @[channel_buffer.scala 72:26:@81.14]
  wire [2:0] _T_105; // @[channel_buffer.scala 72:26:@82.14]
  wire [1:0] _T_106; // @[channel_buffer.scala 72:26:@83.14]
  wire [33:0] _GEN_6; // @[channel_buffer.scala 66:18:@68.12]
  wire [33:0] _GEN_7; // @[channel_buffer.scala 66:18:@68.12]
  wire  _GEN_8; // @[channel_buffer.scala 66:18:@68.12]
  wire  _GEN_9; // @[channel_buffer.scala 66:18:@68.12]
  wire [1:0] _GEN_10; // @[channel_buffer.scala 66:18:@68.12]
  wire [33:0] _GEN_11; // @[channel_buffer.scala 65:21:@67.10]
  wire [33:0] _GEN_12; // @[channel_buffer.scala 65:21:@67.10]
  wire  _GEN_13; // @[channel_buffer.scala 65:21:@67.10]
  wire  _GEN_14; // @[channel_buffer.scala 65:21:@67.10]
  wire [1:0] _GEN_15; // @[channel_buffer.scala 65:21:@67.10]
  wire  _T_108; // @[channel_buffer.scala 75:23:@89.10]
  wire  _T_109; // @[channel_buffer.scala 75:20:@90.10]
  wire [2:0] _T_117; // @[channel_buffer.scala 78:22:@96.12]
  wire [1:0] _T_118; // @[channel_buffer.scala 78:22:@97.12]
  wire [33:0] _GEN_18; // @[channel_buffer.scala 75:31:@91.10]
  wire [33:0] _GEN_19; // @[channel_buffer.scala 75:31:@91.10]
  wire  _GEN_20; // @[channel_buffer.scala 75:31:@91.10]
  wire [1:0] _GEN_21; // @[channel_buffer.scala 75:31:@91.10]
  wire [33:0] _GEN_22; // @[channel_buffer.scala 64:14:@65.8]
  wire [33:0] _GEN_23; // @[channel_buffer.scala 64:14:@65.8]
  wire  _GEN_24; // @[channel_buffer.scala 64:14:@65.8]
  wire  _GEN_25; // @[channel_buffer.scala 64:14:@65.8]
  wire [1:0] _GEN_26; // @[channel_buffer.scala 64:14:@65.8]
  wire [33:0] _GEN_27; // @[channel_buffer.scala 63:24:@64.6]
  wire [33:0] _GEN_28; // @[channel_buffer.scala 63:24:@64.6]
  wire  _GEN_29; // @[channel_buffer.scala 63:24:@64.6]
  wire  _GEN_30; // @[channel_buffer.scala 63:24:@64.6]
  wire [1:0] _GEN_31; // @[channel_buffer.scala 63:24:@64.6]
  wire [1:0] _GEN_32; // @[channel_buffer.scala 59:23:@58.4]
  wire  _GEN_33; // @[channel_buffer.scala 59:23:@58.4]
  wire  _GEN_34; // @[channel_buffer.scala 59:23:@58.4]
  wire [33:0] _GEN_35; // @[channel_buffer.scala 59:23:@58.4]
  wire [33:0] _GEN_36; // @[channel_buffer.scala 59:23:@58.4]
  assign _T_58 = head + 1'h1; // @[channel_buffer.scala 20:24:@23.4]
  assign neck = head + 1'h1; // @[channel_buffer.scala 20:24:@24.4]
  assign isEmpty = count == 2'h0; // @[channel_buffer.scala 23:28:@26.4]
  assign isFull = count == 2'h2; // @[channel_buffer.scala 24:27:@27.4]
  assign out_tag_data = head ? fifo_1 : fifo_0; // @[channel_buffer.scala 43:16:@42.4]
  assign _T_77 = count > 2'h1; // @[channel_buffer.scala 44:32:@43.4]
  assign _GEN_3 = neck ? fifo_1 : fifo_0; // @[channel_buffer.scala 44:26:@44.4]
  assign outNext_tag_data = _T_77 ? _GEN_3 : 34'h0; // @[channel_buffer.scala 44:26:@44.4]
  assign in_tag_data = {io_receiver_pack_tag,io_receiver_pack_data}; // @[Cat.scala 30:58:@53.4]
  assign _T_90 = isEmpty == 1'h0; // @[channel_buffer.scala 65:12:@66.10]
  assign _GEN_4 = 1'h0 == tail ? in_tag_data : fifo_0; // @[channel_buffer.scala 67:22:@69.14]
  assign _GEN_5 = tail ? in_tag_data : fifo_1; // @[channel_buffer.scala 67:22:@69.14]
  assign _T_98 = tail + 1'h1; // @[channel_buffer.scala 69:24:@73.14]
  assign _T_99 = tail + 1'h1; // @[channel_buffer.scala 69:24:@74.14]
  assign _T_104 = count - 2'h1; // @[channel_buffer.scala 72:26:@81.14]
  assign _T_105 = $unsigned(_T_104); // @[channel_buffer.scala 72:26:@82.14]
  assign _T_106 = _T_105[1:0]; // @[channel_buffer.scala 72:26:@83.14]
  assign _GEN_6 = io_receiver_enqueue ? _GEN_4 : fifo_0; // @[channel_buffer.scala 66:18:@68.12]
  assign _GEN_7 = io_receiver_enqueue ? _GEN_5 : fifo_1; // @[channel_buffer.scala 66:18:@68.12]
  assign _GEN_8 = io_receiver_enqueue ? neck : neck; // @[channel_buffer.scala 66:18:@68.12]
  assign _GEN_9 = io_receiver_enqueue ? _T_99 : tail; // @[channel_buffer.scala 66:18:@68.12]
  assign _GEN_10 = io_receiver_enqueue ? count : _T_106; // @[channel_buffer.scala 66:18:@68.12]
  assign _GEN_11 = _T_90 ? _GEN_6 : fifo_0; // @[channel_buffer.scala 65:21:@67.10]
  assign _GEN_12 = _T_90 ? _GEN_7 : fifo_1; // @[channel_buffer.scala 65:21:@67.10]
  assign _GEN_13 = _T_90 ? _GEN_8 : head; // @[channel_buffer.scala 65:21:@67.10]
  assign _GEN_14 = _T_90 ? _GEN_9 : tail; // @[channel_buffer.scala 65:21:@67.10]
  assign _GEN_15 = _T_90 ? _GEN_10 : count; // @[channel_buffer.scala 65:21:@67.10]
  assign _T_108 = isFull == 1'h0; // @[channel_buffer.scala 75:23:@89.10]
  assign _T_109 = io_receiver_enqueue & _T_108; // @[channel_buffer.scala 75:20:@90.10]
  assign _T_117 = count + 2'h1; // @[channel_buffer.scala 78:22:@96.12]
  assign _T_118 = count + 2'h1; // @[channel_buffer.scala 78:22:@97.12]
  assign _GEN_18 = _T_109 ? _GEN_4 : fifo_0; // @[channel_buffer.scala 75:31:@91.10]
  assign _GEN_19 = _T_109 ? _GEN_5 : fifo_1; // @[channel_buffer.scala 75:31:@91.10]
  assign _GEN_20 = _T_109 ? _T_99 : tail; // @[channel_buffer.scala 75:31:@91.10]
  assign _GEN_21 = _T_109 ? _T_118 : count; // @[channel_buffer.scala 75:31:@91.10]
  assign _GEN_22 = io_sender_dequeue ? _GEN_11 : _GEN_18; // @[channel_buffer.scala 64:14:@65.8]
  assign _GEN_23 = io_sender_dequeue ? _GEN_12 : _GEN_19; // @[channel_buffer.scala 64:14:@65.8]
  assign _GEN_24 = io_sender_dequeue ? _GEN_13 : head; // @[channel_buffer.scala 64:14:@65.8]
  assign _GEN_25 = io_sender_dequeue ? _GEN_14 : _GEN_20; // @[channel_buffer.scala 64:14:@65.8]
  assign _GEN_26 = io_sender_dequeue ? _GEN_15 : _GEN_21; // @[channel_buffer.scala 64:14:@65.8]
  assign _GEN_27 = io_enable ? _GEN_22 : fifo_0; // @[channel_buffer.scala 63:24:@64.6]
  assign _GEN_28 = io_enable ? _GEN_23 : fifo_1; // @[channel_buffer.scala 63:24:@64.6]
  assign _GEN_29 = io_enable ? _GEN_24 : head; // @[channel_buffer.scala 63:24:@64.6]
  assign _GEN_30 = io_enable ? _GEN_25 : tail; // @[channel_buffer.scala 63:24:@64.6]
  assign _GEN_31 = io_enable ? _GEN_26 : count; // @[channel_buffer.scala 63:24:@64.6]
  assign _GEN_32 = reset ? 2'h0 : _GEN_31; // @[channel_buffer.scala 59:23:@58.4]
  assign _GEN_33 = reset ? 1'h0 : _GEN_29; // @[channel_buffer.scala 59:23:@58.4]
  assign _GEN_34 = reset ? 1'h0 : _GEN_30; // @[channel_buffer.scala 59:23:@58.4]
  assign _GEN_35 = reset ? fifo_0 : _GEN_27; // @[channel_buffer.scala 59:23:@58.4]
  assign _GEN_36 = reset ? fifo_1 : _GEN_28; // @[channel_buffer.scala 59:23:@58.4]
  assign io_sender_pack_tag = out_tag_data[33:32]; // @[channel_buffer.scala 45:22:@46.4]
  assign io_sender_pack_data = out_tag_data[31:0]; // @[channel_buffer.scala 46:23:@47.4]
  assign io_sender_next_pack_tag = outNext_tag_data[33:32]; // @[channel_buffer.scala 47:27:@48.4]
  assign io_sender_empty = count == 2'h0; // @[channel_buffer.scala 49:19:@50.4]
  assign io_receiver_full = count == 2'h2; // @[channel_buffer.scala 55:20:@55.4]
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
  _RAND_0 = {2{`RANDOM}};
  fifo_0 = _RAND_0[33:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {2{`RANDOM}};
  fifo_1 = _RAND_1[33:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  count = _RAND_2[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  head = _RAND_3[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  tail = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      fifo_0 <= 34'h0;
    end else begin
      if (!(reset)) begin
        if (io_enable) begin
          if (io_sender_dequeue) begin
            if (_T_90) begin
              if (io_receiver_enqueue) begin
                if (1'h0 == tail) begin
                  fifo_0 <= in_tag_data;
                end
              end
            end
          end else begin
            if (_T_109) begin
              if (1'h0 == tail) begin
                fifo_0 <= in_tag_data;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      fifo_1 <= 34'h0;
    end else begin
      if (!(reset)) begin
        if (io_enable) begin
          if (io_sender_dequeue) begin
            if (_T_90) begin
              if (io_receiver_enqueue) begin
                if (tail) begin
                  fifo_1 <= in_tag_data;
                end
              end
            end
          end else begin
            if (_T_109) begin
              if (tail) begin
                fifo_1 <= in_tag_data;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      count <= 2'h0;
    end else begin
      if (reset) begin
        count <= 2'h0;
      end else begin
        if (io_enable) begin
          if (io_sender_dequeue) begin
            if (_T_90) begin
              if (!(io_receiver_enqueue)) begin
                count <= _T_106;
              end
            end
          end else begin
            if (_T_109) begin
              count <= _T_118;
            end
          end
        end
      end
    end
    if (reset) begin
      head <= 1'h0;
    end else begin
      if (reset) begin
        head <= 1'h0;
      end else begin
        if (io_enable) begin
          if (io_sender_dequeue) begin
            if (_T_90) begin
              if (io_receiver_enqueue) begin
                head <= neck;
              end else begin
                head <= neck;
              end
            end
          end
        end
      end
    end
    if (reset) begin
      tail <= 1'h0;
    end else begin
      if (reset) begin
        tail <= 1'h0;
      end else begin
        if (io_enable) begin
          if (io_sender_dequeue) begin
            if (_T_90) begin
              if (io_receiver_enqueue) begin
                tail <= _T_99;
              end
            end
          end else begin
            if (_T_109) begin
              tail <= _T_99;
            end
          end
        end
      end
    end
  end
endmodule
module input_channel_buffer( // @[:@102.2]
  input         clock, // @[:@103.4]
  input         reset, // @[:@104.4]
  input         io_enable, // @[:@105.4]
  input         io_in_req, // @[:@105.4]
  output        io_in_ack, // @[:@105.4]
  input  [1:0]  io_in_packet_tag, // @[:@105.4]
  input  [31:0] io_in_packet_data, // @[:@105.4]
  output [1:0]  io_out_pack_tag, // @[:@105.4]
  output [31:0] io_out_pack_data, // @[:@105.4]
  output [1:0]  io_out_next_pack_tag, // @[:@105.4]
  input         io_out_dequeue, // @[:@105.4]
  output        io_out_empty, // @[:@105.4]
  output        io_quiescent // @[:@105.4]
);
  wire  channel_buffer_clock; // @[channel_buffer.scala 117:30:@107.4]
  wire  channel_buffer_reset; // @[channel_buffer.scala 117:30:@107.4]
  wire  channel_buffer_io_enable; // @[channel_buffer.scala 117:30:@107.4]
  wire [1:0] channel_buffer_io_sender_pack_tag; // @[channel_buffer.scala 117:30:@107.4]
  wire [31:0] channel_buffer_io_sender_pack_data; // @[channel_buffer.scala 117:30:@107.4]
  wire [1:0] channel_buffer_io_sender_next_pack_tag; // @[channel_buffer.scala 117:30:@107.4]
  wire  channel_buffer_io_sender_dequeue; // @[channel_buffer.scala 117:30:@107.4]
  wire  channel_buffer_io_sender_empty; // @[channel_buffer.scala 117:30:@107.4]
  wire [1:0] channel_buffer_io_receiver_pack_tag; // @[channel_buffer.scala 117:30:@107.4]
  wire [31:0] channel_buffer_io_receiver_pack_data; // @[channel_buffer.scala 117:30:@107.4]
  wire  channel_buffer_io_receiver_enqueue; // @[channel_buffer.scala 117:30:@107.4]
  wire  channel_buffer_io_receiver_full; // @[channel_buffer.scala 117:30:@107.4]
  channel_buffer channel_buffer ( // @[channel_buffer.scala 117:30:@107.4]
    .clock(channel_buffer_clock),
    .reset(channel_buffer_reset),
    .io_enable(channel_buffer_io_enable),
    .io_sender_pack_tag(channel_buffer_io_sender_pack_tag),
    .io_sender_pack_data(channel_buffer_io_sender_pack_data),
    .io_sender_next_pack_tag(channel_buffer_io_sender_next_pack_tag),
    .io_sender_dequeue(channel_buffer_io_sender_dequeue),
    .io_sender_empty(channel_buffer_io_sender_empty),
    .io_receiver_pack_tag(channel_buffer_io_receiver_pack_tag),
    .io_receiver_pack_data(channel_buffer_io_receiver_pack_data),
    .io_receiver_enqueue(channel_buffer_io_receiver_enqueue),
    .io_receiver_full(channel_buffer_io_receiver_full)
  );
  assign io_in_ack = channel_buffer_io_receiver_full == 1'h0; // @[channel_buffer.scala 123:13:@114.4]
  assign io_out_pack_tag = channel_buffer_io_sender_pack_tag; // @[channel_buffer.scala 127:10:@122.4]
  assign io_out_pack_data = channel_buffer_io_sender_pack_data; // @[channel_buffer.scala 127:10:@121.4]
  assign io_out_next_pack_tag = channel_buffer_io_sender_next_pack_tag; // @[channel_buffer.scala 127:10:@120.4]
  assign io_out_empty = channel_buffer_io_sender_empty; // @[channel_buffer.scala 127:10:@117.4]
  assign io_quiescent = channel_buffer_io_sender_empty; // @[channel_buffer.scala 128:16:@123.4]
  assign channel_buffer_clock = clock; // @[:@108.4]
  assign channel_buffer_reset = reset; // @[:@109.4]
  assign channel_buffer_io_enable = io_enable; // @[channel_buffer.scala 126:25:@115.4]
  assign channel_buffer_io_sender_dequeue = io_out_dequeue; // @[channel_buffer.scala 127:10:@118.4]
  assign channel_buffer_io_receiver_pack_tag = io_in_packet_tag; // @[channel_buffer.scala 121:36:@111.4]
  assign channel_buffer_io_receiver_pack_data = io_in_packet_data; // @[channel_buffer.scala 122:37:@112.4]
  assign channel_buffer_io_receiver_enqueue = io_in_req; // @[channel_buffer.scala 120:35:@110.4]
endmodule
module output_channel_buffer( // @[:@554.2]
  input         clock, // @[:@555.4]
  input         reset, // @[:@556.4]
  input         io_enable, // @[:@557.4]
  input  [1:0]  io_in_pack_tag, // @[:@557.4]
  input  [31:0] io_in_pack_data, // @[:@557.4]
  input         io_in_enqueue, // @[:@557.4]
  output        io_in_full, // @[:@557.4]
  input         io_out_req, // @[:@557.4]
  output        io_out_ack, // @[:@557.4]
  output [1:0]  io_out_packet_tag, // @[:@557.4]
  output [31:0] io_out_packet_data, // @[:@557.4]
  output        io_quiescent // @[:@557.4]
);
  wire  channel_buffer_clock; // @[channel_buffer.scala 93:30:@559.4]
  wire  channel_buffer_reset; // @[channel_buffer.scala 93:30:@559.4]
  wire  channel_buffer_io_enable; // @[channel_buffer.scala 93:30:@559.4]
  wire [1:0] channel_buffer_io_sender_pack_tag; // @[channel_buffer.scala 93:30:@559.4]
  wire [31:0] channel_buffer_io_sender_pack_data; // @[channel_buffer.scala 93:30:@559.4]
  wire [1:0] channel_buffer_io_sender_next_pack_tag; // @[channel_buffer.scala 93:30:@559.4]
  wire  channel_buffer_io_sender_dequeue; // @[channel_buffer.scala 93:30:@559.4]
  wire  channel_buffer_io_sender_empty; // @[channel_buffer.scala 93:30:@559.4]
  wire [1:0] channel_buffer_io_receiver_pack_tag; // @[channel_buffer.scala 93:30:@559.4]
  wire [31:0] channel_buffer_io_receiver_pack_data; // @[channel_buffer.scala 93:30:@559.4]
  wire  channel_buffer_io_receiver_enqueue; // @[channel_buffer.scala 93:30:@559.4]
  wire  channel_buffer_io_receiver_full; // @[channel_buffer.scala 93:30:@559.4]
  channel_buffer channel_buffer ( // @[channel_buffer.scala 93:30:@559.4]
    .clock(channel_buffer_clock),
    .reset(channel_buffer_reset),
    .io_enable(channel_buffer_io_enable),
    .io_sender_pack_tag(channel_buffer_io_sender_pack_tag),
    .io_sender_pack_data(channel_buffer_io_sender_pack_data),
    .io_sender_next_pack_tag(channel_buffer_io_sender_next_pack_tag),
    .io_sender_dequeue(channel_buffer_io_sender_dequeue),
    .io_sender_empty(channel_buffer_io_sender_empty),
    .io_receiver_pack_tag(channel_buffer_io_receiver_pack_tag),
    .io_receiver_pack_data(channel_buffer_io_receiver_pack_data),
    .io_receiver_enqueue(channel_buffer_io_receiver_enqueue),
    .io_receiver_full(channel_buffer_io_receiver_full)
  );
  assign io_in_full = channel_buffer_io_receiver_full; // @[channel_buffer.scala 103:27:@569.4]
  assign io_out_ack = channel_buffer_io_sender_empty == 1'h0; // @[channel_buffer.scala 99:14:@566.4]
  assign io_out_packet_tag = channel_buffer_io_sender_pack_tag; // @[channel_buffer.scala 96:21:@562.4]
  assign io_out_packet_data = channel_buffer_io_sender_pack_data; // @[channel_buffer.scala 97:22:@563.4]
  assign io_quiescent = channel_buffer_io_sender_empty; // @[channel_buffer.scala 104:16:@573.4]
  assign channel_buffer_clock = clock; // @[:@560.4]
  assign channel_buffer_reset = reset; // @[:@561.4]
  assign channel_buffer_io_enable = io_enable; // @[channel_buffer.scala 102:25:@567.4]
  assign channel_buffer_io_sender_dequeue = io_out_req; // @[channel_buffer.scala 98:33:@564.4]
  assign channel_buffer_io_receiver_pack_tag = io_in_pack_tag; // @[channel_buffer.scala 103:27:@572.4]
  assign channel_buffer_io_receiver_pack_data = io_in_pack_data; // @[channel_buffer.scala 103:27:@571.4]
  assign channel_buffer_io_receiver_enqueue = io_in_enqueue; // @[channel_buffer.scala 103:27:@570.4]
endmodule
module core_mapper( // @[:@925.2]
  input         io_host_interface_read_req, // @[:@928.4]
  output        io_host_interface_read_ack, // @[:@928.4]
  input  [29:0] io_host_interface_read_index, // @[:@928.4]
  input         io_host_interface_write_req, // @[:@928.4]
  output        io_host_interface_write_ack, // @[:@928.4]
  input  [29:0] io_host_interface_write_index, // @[:@928.4]
  input  [31:0] io_host_interface_write_data, // @[:@928.4]
  output        io_register_file_interface_read_req, // @[:@928.4]
  input         io_register_file_interface_read_ack, // @[:@928.4]
  output        io_register_file_interface_write_req, // @[:@928.4]
  input         io_register_file_interface_write_ack, // @[:@928.4]
  output [29:0] io_register_file_interface_write_index, // @[:@928.4]
  output [31:0] io_register_file_interface_write_data, // @[:@928.4]
  output        io_instruction_memory_interface_read_req, // @[:@928.4]
  input         io_instruction_memory_interface_read_ack, // @[:@928.4]
  output        io_instruction_memory_interface_write_req, // @[:@928.4]
  input         io_instruction_memory_interface_write_ack, // @[:@928.4]
  output [29:0] io_instruction_memory_interface_write_index, // @[:@928.4]
  output [31:0] io_instruction_memory_interface_write_data, // @[:@928.4]
  output        io_scratchpad_memory_interface_read_req, // @[:@928.4]
  input         io_scratchpad_memory_interface_read_ack, // @[:@928.4]
  output        io_scratchpad_memory_interface_write_req, // @[:@928.4]
  input         io_scratchpad_memory_interface_write_ack, // @[:@928.4]
  output [29:0] io_scratchpad_memory_interface_write_index, // @[:@928.4]
  output [31:0] io_scratchpad_memory_interface_write_data // @[:@928.4]
);
  wire  _T_231; // @[core_mapper.scala 71:36:@978.6]
  wire  _T_233; // @[core_mapper.scala 72:36:@979.6]
  wire  _T_234; // @[core_mapper.scala 72:7:@980.6]
  wire  _GEN_8; // @[core_mapper.scala 72:75:@981.6]
  wire  _GEN_10; // @[core_mapper.scala 72:75:@981.6]
  wire  _T_240; // @[core_mapper.scala 78:36:@990.6]
  wire  _T_242; // @[core_mapper.scala 79:36:@991.6]
  wire  _T_243; // @[core_mapper.scala 79:7:@992.6]
  wire  _GEN_12; // @[core_mapper.scala 79:80:@993.6]
  wire  _GEN_14; // @[core_mapper.scala 79:80:@993.6]
  wire  _T_245; // @[core_mapper.scala 86:36:@999.6]
  wire  _T_247; // @[core_mapper.scala 87:36:@1000.6]
  wire  _T_248; // @[core_mapper.scala 87:7:@1001.6]
  wire  _GEN_16; // @[core_mapper.scala 87:79:@1002.6]
  wire  _GEN_18; // @[core_mapper.scala 87:79:@1002.6]
  wire  _T_262; // @[core_mapper.scala 112:37:@1029.6]
  wire  _T_264; // @[core_mapper.scala 113:37:@1030.6]
  wire  _T_265; // @[core_mapper.scala 113:7:@1031.6]
  wire  _GEN_40; // @[core_mapper.scala 113:76:@1032.6]
  wire [29:0] _GEN_41; // @[core_mapper.scala 113:76:@1032.6]
  wire [31:0] _GEN_42; // @[core_mapper.scala 113:76:@1032.6]
  wire  _GEN_43; // @[core_mapper.scala 113:76:@1032.6]
  wire  _T_272; // @[core_mapper.scala 120:37:@1041.6]
  wire  _T_274; // @[core_mapper.scala 121:37:@1042.6]
  wire  _T_275; // @[core_mapper.scala 121:7:@1043.6]
  wire  _GEN_44; // @[core_mapper.scala 121:81:@1044.6]
  wire [29:0] _GEN_45; // @[core_mapper.scala 121:81:@1044.6]
  wire [31:0] _GEN_46; // @[core_mapper.scala 121:81:@1044.6]
  wire  _GEN_47; // @[core_mapper.scala 121:81:@1044.6]
  wire  _T_282; // @[core_mapper.scala 128:37:@1053.6]
  wire  _T_284; // @[core_mapper.scala 129:37:@1054.6]
  wire  _T_285; // @[core_mapper.scala 129:7:@1055.6]
  wire  _GEN_48; // @[core_mapper.scala 129:80:@1056.6]
  wire [29:0] _GEN_49; // @[core_mapper.scala 129:80:@1056.6]
  wire [31:0] _GEN_50; // @[core_mapper.scala 129:80:@1056.6]
  wire  _GEN_51; // @[core_mapper.scala 129:80:@1056.6]
  assign _T_231 = io_host_interface_read_index >= 30'h17; // @[core_mapper.scala 71:36:@978.6]
  assign _T_233 = io_host_interface_read_index < 30'h1f; // @[core_mapper.scala 72:36:@979.6]
  assign _T_234 = _T_231 & _T_233; // @[core_mapper.scala 72:7:@980.6]
  assign _GEN_8 = _T_234 ? io_host_interface_read_req : 1'h0; // @[core_mapper.scala 72:75:@981.6]
  assign _GEN_10 = _T_234 ? io_register_file_interface_read_ack : 1'h0; // @[core_mapper.scala 72:75:@981.6]
  assign _T_240 = io_host_interface_read_index >= 30'h1f; // @[core_mapper.scala 78:36:@990.6]
  assign _T_242 = io_host_interface_read_index < 30'h5f; // @[core_mapper.scala 79:36:@991.6]
  assign _T_243 = _T_240 & _T_242; // @[core_mapper.scala 79:7:@992.6]
  assign _GEN_12 = _T_243 ? io_host_interface_read_req : 1'h0; // @[core_mapper.scala 79:80:@993.6]
  assign _GEN_14 = _T_243 ? io_instruction_memory_interface_read_ack : _GEN_10; // @[core_mapper.scala 79:80:@993.6]
  assign _T_245 = io_host_interface_read_index >= 30'h5f; // @[core_mapper.scala 86:36:@999.6]
  assign _T_247 = io_host_interface_read_index < 30'h25f; // @[core_mapper.scala 87:36:@1000.6]
  assign _T_248 = _T_245 & _T_247; // @[core_mapper.scala 87:7:@1001.6]
  assign _GEN_16 = _T_248 ? io_host_interface_read_req : 1'h0; // @[core_mapper.scala 87:79:@1002.6]
  assign _GEN_18 = _T_248 ? io_scratchpad_memory_interface_read_ack : _GEN_14; // @[core_mapper.scala 87:79:@1002.6]
  assign _T_262 = io_host_interface_write_index >= 30'h17; // @[core_mapper.scala 112:37:@1029.6]
  assign _T_264 = io_host_interface_write_index < 30'h1f; // @[core_mapper.scala 113:37:@1030.6]
  assign _T_265 = _T_262 & _T_264; // @[core_mapper.scala 113:7:@1031.6]
  assign _GEN_40 = _T_265 ? io_host_interface_write_req : 1'h0; // @[core_mapper.scala 113:76:@1032.6]
  assign _GEN_41 = _T_265 ? io_host_interface_write_index : 30'h0; // @[core_mapper.scala 113:76:@1032.6]
  assign _GEN_42 = _T_265 ? io_host_interface_write_data : 32'h0; // @[core_mapper.scala 113:76:@1032.6]
  assign _GEN_43 = _T_265 ? io_register_file_interface_write_ack : 1'h0; // @[core_mapper.scala 113:76:@1032.6]
  assign _T_272 = io_host_interface_write_index >= 30'h1f; // @[core_mapper.scala 120:37:@1041.6]
  assign _T_274 = io_host_interface_write_index < 30'h5f; // @[core_mapper.scala 121:37:@1042.6]
  assign _T_275 = _T_272 & _T_274; // @[core_mapper.scala 121:7:@1043.6]
  assign _GEN_44 = _T_275 ? io_host_interface_write_req : 1'h0; // @[core_mapper.scala 121:81:@1044.6]
  assign _GEN_45 = _T_275 ? io_host_interface_write_index : 30'h0; // @[core_mapper.scala 121:81:@1044.6]
  assign _GEN_46 = _T_275 ? io_host_interface_write_data : 32'h0; // @[core_mapper.scala 121:81:@1044.6]
  assign _GEN_47 = _T_275 ? io_instruction_memory_interface_write_ack : _GEN_43; // @[core_mapper.scala 121:81:@1044.6]
  assign _T_282 = io_host_interface_write_index >= 30'h5f; // @[core_mapper.scala 128:37:@1053.6]
  assign _T_284 = io_host_interface_write_index < 30'h25f; // @[core_mapper.scala 129:37:@1054.6]
  assign _T_285 = _T_282 & _T_284; // @[core_mapper.scala 129:7:@1055.6]
  assign _GEN_48 = _T_285 ? io_host_interface_write_req : 1'h0; // @[core_mapper.scala 129:80:@1056.6]
  assign _GEN_49 = _T_285 ? io_host_interface_write_index : 30'h0; // @[core_mapper.scala 129:80:@1056.6]
  assign _GEN_50 = _T_285 ? io_host_interface_write_data : 32'h0; // @[core_mapper.scala 129:80:@1056.6]
  assign _GEN_51 = _T_285 ? io_scratchpad_memory_interface_write_ack : _GEN_47; // @[core_mapper.scala 129:80:@1056.6]
  assign io_host_interface_read_ack = io_host_interface_read_req ? _GEN_18 : 1'h0; // @[core_mapper.scala 25:27:@930.4 core_mapper.scala 61:31:@963.8 core_mapper.scala 68:31:@975.8 core_mapper.scala 75:31:@987.8 core_mapper.scala 83:31:@996.8 core_mapper.scala 91:31:@1005.8]
  assign io_host_interface_write_ack = io_host_interface_write_req ? _GEN_51 : 1'h0; // @[core_mapper.scala 39:28:@942.4 core_mapper.scala 102:32:@1015.8 core_mapper.scala 110:32:@1027.8 core_mapper.scala 118:32:@1039.8 core_mapper.scala 126:32:@1051.8 core_mapper.scala 134:32:@1063.8]
  assign io_register_file_interface_read_req = io_host_interface_read_req ? _GEN_8 : 1'h0; // @[core_mapper.scala 31:36:@936.4 core_mapper.scala 73:40:@982.8]
  assign io_register_file_interface_write_req = io_host_interface_write_req ? _GEN_40 : 1'h0; // @[core_mapper.scala 46:37:@949.4 core_mapper.scala 114:41:@1033.8]
  assign io_register_file_interface_write_index = io_host_interface_write_req ? _GEN_41 : 30'h0; // @[core_mapper.scala 47:39:@950.4 core_mapper.scala 115:43:@1034.8]
  assign io_register_file_interface_write_data = io_host_interface_write_req ? _GEN_42 : 32'h0; // @[core_mapper.scala 48:38:@951.4 core_mapper.scala 117:42:@1038.8]
  assign io_instruction_memory_interface_read_req = io_host_interface_read_req ? _GEN_12 : 1'h0; // @[core_mapper.scala 33:41:@938.4 core_mapper.scala 80:45:@994.8]
  assign io_instruction_memory_interface_write_req = io_host_interface_write_req ? _GEN_44 : 1'h0; // @[core_mapper.scala 49:42:@952.4 core_mapper.scala 122:46:@1045.8]
  assign io_instruction_memory_interface_write_index = io_host_interface_write_req ? _GEN_45 : 30'h0; // @[core_mapper.scala 50:44:@953.4 core_mapper.scala 123:48:@1046.8]
  assign io_instruction_memory_interface_write_data = io_host_interface_write_req ? _GEN_46 : 32'h0; // @[core_mapper.scala 51:43:@954.4 core_mapper.scala 125:47:@1050.8]
  assign io_scratchpad_memory_interface_read_req = io_host_interface_read_req ? _GEN_16 : 1'h0; // @[core_mapper.scala 35:40:@940.4 core_mapper.scala 88:44:@1003.8]
  assign io_scratchpad_memory_interface_write_req = io_host_interface_write_req ? _GEN_48 : 1'h0; // @[core_mapper.scala 52:41:@955.4 core_mapper.scala 130:45:@1057.8]
  assign io_scratchpad_memory_interface_write_index = io_host_interface_write_req ? _GEN_49 : 30'h0; // @[core_mapper.scala 53:43:@956.4 core_mapper.scala 131:47:@1058.8]
  assign io_scratchpad_memory_interface_write_data = io_host_interface_write_req ? _GEN_50 : 32'h0; // @[core_mapper.scala 54:42:@957.4 core_mapper.scala 133:46:@1062.8]
endmodule
module execution_control_unit( // @[:@1067.2]
  input        reset, // @[:@1069.4]
  input        io_enable, // @[:@1070.4]
  input        io_execute, // @[:@1070.4]
  input  [5:0] io_opcode, // @[:@1070.4]
  input  [3:0] io_input_channel_quiescent_status, // @[:@1070.4]
  input  [3:0] io_output_channel_quiescent_status, // @[:@1070.4]
  output       io_internal_reset, // @[:@1070.4]
  output       io_internal_enable, // @[:@1070.4]
  output       io_halted, // @[:@1070.4]
  output       io_channels_quiescent // @[:@1070.4]
);
  wire  _T_26; // @[execution_control.scala 30:36:@1076.4]
  wire  _T_32; // @[execution_control.scala 36:20:@1086.8]
  wire  _GEN_1; // @[execution_control.scala 35:38:@1085.6]
  wire  halted; // @[execution_control.scala 33:23:@1080.4]
  wire [7:0] _T_36; // @[Cat.scala 30:58:@1097.8]
  wire [7:0] _T_37; // @[execution_control.scala 45:108:@1098.8]
  wire  _T_39; // @[execution_control.scala 45:108:@1099.8]
  wire  _GEN_3; // @[execution_control.scala 44:24:@1096.6]
  assign _T_26 = io_enable & io_execute; // @[execution_control.scala 30:36:@1076.4]
  assign _T_32 = io_opcode == 6'h27; // @[execution_control.scala 36:20:@1086.8]
  assign _GEN_1 = _T_26 ? _T_32 : 1'h0; // @[execution_control.scala 35:38:@1085.6]
  assign halted = reset ? 1'h0 : _GEN_1; // @[execution_control.scala 33:23:@1080.4]
  assign _T_36 = {io_input_channel_quiescent_status,io_output_channel_quiescent_status}; // @[Cat.scala 30:58:@1097.8]
  assign _T_37 = ~ _T_36; // @[execution_control.scala 45:108:@1098.8]
  assign _T_39 = _T_37 == 8'h0; // @[execution_control.scala 45:108:@1099.8]
  assign _GEN_3 = io_enable ? _T_39 : 1'h0; // @[execution_control.scala 44:24:@1096.6]
  assign io_internal_reset = reset; // @[execution_control.scala 29:21:@1075.4]
  assign io_internal_enable = _T_26 & halted; // @[execution_control.scala 30:22:@1078.4]
  assign io_halted = reset ? 1'h0 : _GEN_1; // @[execution_control.scala 49:13:@1102.4]
  assign io_channels_quiescent = reset ? 1'h0 : _GEN_3; // @[execution_control.scala 26:25:@1074.4 execution_control.scala 43:27:@1093.6 execution_control.scala 45:27:@1100.8]
endmodule
module predicate_unit( // @[:@1104.2]
  input         clock, // @[:@1105.4]
  input         reset, // @[:@1106.4]
  input         io_enable, // @[:@1107.4]
  input  [1:0]  io_datapath_dt, // @[:@1107.4]
  input  [2:0]  io_datapath_di, // @[:@1107.4]
  input  [31:0] io_datapath_result, // @[:@1107.4]
  input  [15:0] io_instruction_pum, // @[:@1107.4]
  output [7:0]  io_predicates // @[:@1107.4]
);
  reg [7:0] predicates; // @[predicate_unit.scala 19:27:@1109.4]
  reg [31:0] _RAND_0;
  wire  _T_25; // @[predicate_unit.scala 26:23:@1115.4]
  wire  _T_27; // @[predicate_unit.scala 27:29:@1117.6]
  wire [7:0] _T_30; // @[OneHot.scala 52:12:@1120.8]
  wire [8:0] _T_33; // @[Cat.scala 30:58:@1122.8]
  wire [8:0] _T_39; // @[Cat.scala 30:58:@1129.8]
  wire [8:0] _GEN_0; // @[predicate_unit.scala 27:33:@1118.6]
  wire [8:0] _GEN_1; // @[predicate_unit.scala 26:60:@1116.4]
  wire [15:0] datapath_pum; // @[predicate_unit.scala 21:30:@1110.4 predicate_unit.scala 28:20:@1123.8 predicate_unit.scala 30:20:@1130.8 predicate_unit.scala 33:18:@1134.6]
  wire [15:0] pum; // @[predicate_unit.scala 36:29:@1136.4]
  wire [7:0] predicate_set_mask; // @[predicate_unit.scala 38:28:@1138.4]
  wire [7:0] predicate_unset_mask; // @[predicate_unit.scala 39:30:@1140.4]
  wire [7:0] _T_44; // @[predicate_unit.scala 40:33:@1142.4]
  wire [7:0] _T_45; // @[predicate_unit.scala 40:58:@1143.4]
  wire [7:0] next_predicate; // @[predicate_unit.scala 40:55:@1144.4]
  wire [7:0] _GEN_2; // @[predicate_unit.scala 42:18:@1146.4]
  assign _T_25 = io_datapath_dt == 2'h3; // @[predicate_unit.scala 26:23:@1115.4]
  assign _T_27 = io_datapath_result != 32'h0; // @[predicate_unit.scala 27:29:@1117.6]
  assign _T_30 = 8'h1 << io_datapath_di; // @[OneHot.scala 52:12:@1120.8]
  assign _T_33 = {_T_30,1'h0}; // @[Cat.scala 30:58:@1122.8]
  assign _T_39 = {1'h0,_T_30}; // @[Cat.scala 30:58:@1129.8]
  assign _GEN_0 = _T_27 ? _T_33 : _T_39; // @[predicate_unit.scala 27:33:@1118.6]
  assign _GEN_1 = _T_25 ? _GEN_0 : 9'h0; // @[predicate_unit.scala 26:60:@1116.4]
  assign datapath_pum = {{7'd0}, _GEN_1}; // @[predicate_unit.scala 21:30:@1110.4 predicate_unit.scala 28:20:@1123.8 predicate_unit.scala 30:20:@1130.8 predicate_unit.scala 33:18:@1134.6]
  assign pum = io_instruction_pum | datapath_pum; // @[predicate_unit.scala 36:29:@1136.4]
  assign predicate_set_mask = pum[15:8]; // @[predicate_unit.scala 38:28:@1138.4]
  assign predicate_unset_mask = pum[7:0]; // @[predicate_unit.scala 39:30:@1140.4]
  assign _T_44 = predicates | predicate_set_mask; // @[predicate_unit.scala 40:33:@1142.4]
  assign _T_45 = ~ predicate_unset_mask; // @[predicate_unit.scala 40:58:@1143.4]
  assign next_predicate = _T_44 & _T_45; // @[predicate_unit.scala 40:55:@1144.4]
  assign _GEN_2 = io_enable ? next_predicate : predicates; // @[predicate_unit.scala 42:18:@1146.4]
  assign io_predicates = predicates; // @[predicate_unit.scala 45:17:@1149.4]
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
  predicates = _RAND_0[7:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      predicates <= 8'h0;
    end else begin
      if (io_enable) begin
        predicates <= next_predicate;
      end
    end
  end
endmodule
module pessimistic_one_stage_input_channel_empty_status_updater( // @[:@1151.2]
  input  [3:0] io_input_channel_empty_status, // @[:@1154.4]
  input  [3:0] io_downstream_icd, // @[:@1154.4]
  output [3:0] io_updated_input_channel_empty_status // @[:@1154.4]
);
  assign io_updated_input_channel_empty_status = io_input_channel_empty_status | io_downstream_icd; // @[channel_input_empty_output_full_updater.scala 12:41:@1157.4]
endmodule
module pessimistic_two_stage_output_channel_full_status_updater( // @[:@1159.2]
  input  [3:0] io_output_channel_full_status, // @[:@1162.4]
  input  [3:0] io_first_downstream_oci, // @[:@1162.4]
  input  [3:0] io_second_downstream_oci, // @[:@1162.4]
  output [3:0] io_updated_output_channel_full_status // @[:@1162.4]
);
  wire [3:0] _T_13; // @[channel_input_empty_output_full_updater.scala 22:74:@1164.4]
  assign _T_13 = io_output_channel_full_status | io_first_downstream_oci; // @[channel_input_empty_output_full_updater.scala 22:74:@1164.4]
  assign io_updated_output_channel_full_status = _T_13 | io_second_downstream_oci; // @[channel_input_empty_output_full_updater.scala 22:41:@1166.4]
endmodule
module input_channel_tag_lookahead_unit( // @[:@1168.2]
  input  [3:0] io_pending_dequeue_signals, // @[:@1171.4]
  input  [1:0] io_original_tags_0, // @[:@1171.4]
  input  [1:0] io_original_tags_1, // @[:@1171.4]
  input  [1:0] io_original_tags_2, // @[:@1171.4]
  input  [1:0] io_original_tags_3, // @[:@1171.4]
  input  [1:0] io_next_tags_0, // @[:@1171.4]
  input  [1:0] io_next_tags_1, // @[:@1171.4]
  input  [1:0] io_next_tags_2, // @[:@1171.4]
  input  [1:0] io_next_tags_3, // @[:@1171.4]
  output [1:0] io_resolved_tags_0, // @[:@1171.4]
  output [1:0] io_resolved_tags_1, // @[:@1171.4]
  output [1:0] io_resolved_tags_2, // @[:@1171.4]
  output [1:0] io_resolved_tags_3 // @[:@1171.4]
);
  wire  _T_61; // @[input_channel_tag_lookahead_unit.scala 16:58:@1173.4]
  wire  _T_63; // @[input_channel_tag_lookahead_unit.scala 16:58:@1176.4]
  wire  _T_65; // @[input_channel_tag_lookahead_unit.scala 16:58:@1179.4]
  wire  _T_67; // @[input_channel_tag_lookahead_unit.scala 16:58:@1182.4]
  assign _T_61 = io_pending_dequeue_signals[0]; // @[input_channel_tag_lookahead_unit.scala 16:58:@1173.4]
  assign _T_63 = io_pending_dequeue_signals[1]; // @[input_channel_tag_lookahead_unit.scala 16:58:@1176.4]
  assign _T_65 = io_pending_dequeue_signals[2]; // @[input_channel_tag_lookahead_unit.scala 16:58:@1179.4]
  assign _T_67 = io_pending_dequeue_signals[3]; // @[input_channel_tag_lookahead_unit.scala 16:58:@1182.4]
  assign io_resolved_tags_0 = _T_61 ? io_next_tags_0 : io_original_tags_0; // @[input_channel_tag_lookahead_unit.scala 16:25:@1175.4]
  assign io_resolved_tags_1 = _T_63 ? io_next_tags_1 : io_original_tags_1; // @[input_channel_tag_lookahead_unit.scala 16:25:@1178.4]
  assign io_resolved_tags_2 = _T_65 ? io_next_tags_2 : io_original_tags_2; // @[input_channel_tag_lookahead_unit.scala 16:25:@1181.4]
  assign io_resolved_tags_3 = _T_67 ? io_next_tags_3 : io_original_tags_3; // @[input_channel_tag_lookahead_unit.scala 16:25:@1184.4]
endmodule
module trigger_resolver( // @[:@1186.2]
  input         io_trigger_vi, // @[:@1189.4]
  input  [15:0] io_trigger_ptm, // @[:@1189.4]
  input  [5:0]  io_trigger_ici, // @[:@1189.4]
  input  [1:0]  io_trigger_ictb, // @[:@1189.4]
  input  [3:0]  io_trigger_ictv, // @[:@1189.4]
  input  [1:0]  io_trigger_oci, // @[:@1189.4]
  input  [7:0]  io_predicates, // @[:@1189.4]
  input  [3:0]  io_input_channel_empty_status, // @[:@1189.4]
  input  [1:0]  io_input_channel_tags_0, // @[:@1189.4]
  input  [1:0]  io_input_channel_tags_1, // @[:@1189.4]
  input  [1:0]  io_input_channel_tags_2, // @[:@1189.4]
  input  [1:0]  io_input_channel_tags_3, // @[:@1189.4]
  input  [3:0]  io_output_channel_full_status, // @[:@1189.4]
  output        io_valid // @[:@1189.4]
);
  wire [7:0] true_ptm; // @[trigger_resolver.scala 42:29:@1203.4]
  wire [7:0] false_ptm; // @[trigger_resolver.scala 43:30:@1205.4]
  wire [7:0] _T_58; // @[trigger_resolver.scala 44:39:@1207.4]
  wire [7:0] true_predicates; // @[trigger_resolver.scala 44:36:@1208.4]
  wire [7:0] _T_60; // @[trigger_resolver.scala 45:24:@1210.4]
  wire [7:0] _T_61; // @[trigger_resolver.scala 45:52:@1211.4]
  wire [7:0] false_predicates; // @[trigger_resolver.scala 45:49:@1212.4]
  wire [15:0] _T_63; // @[Cat.scala 30:58:@1214.4]
  wire [15:0] _T_64; // @[trigger_resolver.scala 46:71:@1215.4]
  wire  valid_predicate_state; // @[trigger_resolver.scala 46:71:@1216.4]
  wire [2:0] _T_67; // @[trigger_resolver.scala 52:21:@1218.4]
  wire  _T_69; // @[trigger_resolver.scala 55:35:@1219.4]
  wire [3:0] _T_71; // @[trigger_resolver.scala 57:63:@1221.6]
  wire [3:0] _T_72; // @[trigger_resolver.scala 57:63:@1222.6]
  wire [2:0] _T_73; // @[trigger_resolver.scala 57:63:@1223.6]
  wire [3:0] _T_74; // @[trigger_resolver.scala 61:42:@1224.6]
  wire  _T_75; // @[trigger_resolver.scala 61:42:@1225.6]
  wire  _T_77; // @[trigger_resolver.scala 61:12:@1226.6]
  wire [1:0] _T_80; // @[trigger_resolver.scala 69:52:@1233.6]
  wire [1:0] _T_82; // @[:@1234.6]
  wire [1:0] _GEN_2; // @[trigger_resolver.scala 72:60:@1235.6]
  wire [1:0] _GEN_3; // @[trigger_resolver.scala 72:60:@1235.6]
  wire [1:0] _GEN_4; // @[trigger_resolver.scala 72:60:@1235.6]
  wire  _T_83; // @[trigger_resolver.scala 72:60:@1235.6]
  wire  _T_84; // @[trigger_resolver.scala 73:61:@1237.8]
  wire  _T_86; // @[trigger_resolver.scala 75:46:@1242.8]
  wire  _GEN_5; // @[trigger_resolver.scala 72:88:@1236.6]
  wire  valid_input_channel_empty_status_array_0; // @[trigger_resolver.scala 55:43:@1220.4]
  wire  valid_input_channel_tags_array_0; // @[trigger_resolver.scala 55:43:@1220.4]
  wire [2:0] _T_89; // @[trigger_resolver.scala 52:21:@1250.4]
  wire  _T_91; // @[trigger_resolver.scala 55:35:@1251.4]
  wire [3:0] _T_93; // @[trigger_resolver.scala 57:63:@1253.6]
  wire [3:0] _T_94; // @[trigger_resolver.scala 57:63:@1254.6]
  wire [2:0] _T_95; // @[trigger_resolver.scala 57:63:@1255.6]
  wire [3:0] _T_96; // @[trigger_resolver.scala 61:42:@1256.6]
  wire  _T_97; // @[trigger_resolver.scala 61:42:@1257.6]
  wire  _T_99; // @[trigger_resolver.scala 61:12:@1258.6]
  wire [1:0] _T_102; // @[trigger_resolver.scala 69:52:@1265.6]
  wire [1:0] _T_104; // @[:@1266.6]
  wire [1:0] _GEN_10; // @[trigger_resolver.scala 72:60:@1267.6]
  wire [1:0] _GEN_11; // @[trigger_resolver.scala 72:60:@1267.6]
  wire [1:0] _GEN_12; // @[trigger_resolver.scala 72:60:@1267.6]
  wire  _T_105; // @[trigger_resolver.scala 72:60:@1267.6]
  wire  _T_106; // @[trigger_resolver.scala 73:61:@1269.8]
  wire  _T_108; // @[trigger_resolver.scala 75:46:@1274.8]
  wire  _GEN_13; // @[trigger_resolver.scala 72:88:@1268.6]
  wire  valid_input_channel_empty_status_array_1; // @[trigger_resolver.scala 55:43:@1252.4]
  wire  valid_input_channel_tags_array_1; // @[trigger_resolver.scala 55:43:@1252.4]
  wire [1:0] _T_111; // @[trigger_resolver.scala 85:84:@1282.4]
  wire [1:0] _T_112; // @[trigger_resolver.scala 85:91:@1283.4]
  wire  valid_input_channel_empty_status; // @[trigger_resolver.scala 85:91:@1284.4]
  wire [1:0] _T_115; // @[trigger_resolver.scala 86:68:@1286.4]
  wire [1:0] _T_116; // @[trigger_resolver.scala 86:75:@1287.4]
  wire  valid_input_channel_tags; // @[trigger_resolver.scala 86:75:@1288.4]
  wire [3:0] _GEN_16; // @[trigger_resolver.scala 89:55:@1290.4]
  wire [3:0] _T_119; // @[trigger_resolver.scala 89:55:@1290.4]
  wire  valid_output_channel_full_status; // @[trigger_resolver.scala 89:88:@1291.4]
  wire  _T_122; // @[trigger_resolver.scala 91:29:@1293.4]
  wire  _T_123; // @[trigger_resolver.scala 91:53:@1294.4]
  wire  _T_124; // @[trigger_resolver.scala 91:88:@1295.4]
  assign true_ptm = io_trigger_ptm[15:8]; // @[trigger_resolver.scala 42:29:@1203.4]
  assign false_ptm = io_trigger_ptm[7:0]; // @[trigger_resolver.scala 43:30:@1205.4]
  assign _T_58 = ~ true_ptm; // @[trigger_resolver.scala 44:39:@1207.4]
  assign true_predicates = io_predicates | _T_58; // @[trigger_resolver.scala 44:36:@1208.4]
  assign _T_60 = ~ io_predicates; // @[trigger_resolver.scala 45:24:@1210.4]
  assign _T_61 = ~ false_ptm; // @[trigger_resolver.scala 45:52:@1211.4]
  assign false_predicates = _T_60 | _T_61; // @[trigger_resolver.scala 45:49:@1212.4]
  assign _T_63 = {true_predicates,false_predicates}; // @[Cat.scala 30:58:@1214.4]
  assign _T_64 = ~ _T_63; // @[trigger_resolver.scala 46:71:@1215.4]
  assign valid_predicate_state = _T_64 == 16'h0; // @[trigger_resolver.scala 46:71:@1216.4]
  assign _T_67 = io_trigger_ici[2:0]; // @[trigger_resolver.scala 52:21:@1218.4]
  assign _T_69 = _T_67 != 3'h0; // @[trigger_resolver.scala 55:35:@1219.4]
  assign _T_71 = _T_67 - 3'h1; // @[trigger_resolver.scala 57:63:@1221.6]
  assign _T_72 = $unsigned(_T_71); // @[trigger_resolver.scala 57:63:@1222.6]
  assign _T_73 = _T_72[2:0]; // @[trigger_resolver.scala 57:63:@1223.6]
  assign _T_74 = io_input_channel_empty_status >> _T_73; // @[trigger_resolver.scala 61:42:@1224.6]
  assign _T_75 = _T_74[0]; // @[trigger_resolver.scala 61:42:@1225.6]
  assign _T_77 = _T_75 == 1'h0; // @[trigger_resolver.scala 61:12:@1226.6]
  assign _T_80 = io_trigger_ictv[1:0]; // @[trigger_resolver.scala 69:52:@1233.6]
  assign _T_82 = _T_73[1:0]; // @[:@1234.6]
  assign _GEN_2 = 2'h1 == _T_82 ? io_input_channel_tags_1 : io_input_channel_tags_0; // @[trigger_resolver.scala 72:60:@1235.6]
  assign _GEN_3 = 2'h2 == _T_82 ? io_input_channel_tags_2 : _GEN_2; // @[trigger_resolver.scala 72:60:@1235.6]
  assign _GEN_4 = 2'h3 == _T_82 ? io_input_channel_tags_3 : _GEN_3; // @[trigger_resolver.scala 72:60:@1235.6]
  assign _T_83 = _GEN_4 == _T_80; // @[trigger_resolver.scala 72:60:@1235.6]
  assign _T_84 = io_trigger_ictb[0]; // @[trigger_resolver.scala 73:61:@1237.8]
  assign _T_86 = ~ _T_84; // @[trigger_resolver.scala 75:46:@1242.8]
  assign _GEN_5 = _T_83 ? _T_84 : _T_86; // @[trigger_resolver.scala 72:88:@1236.6]
  assign valid_input_channel_empty_status_array_0 = _T_69 ? _T_77 : 1'h1; // @[trigger_resolver.scala 55:43:@1220.4]
  assign valid_input_channel_tags_array_0 = _T_69 ? _GEN_5 : 1'h1; // @[trigger_resolver.scala 55:43:@1220.4]
  assign _T_89 = io_trigger_ici[5:3]; // @[trigger_resolver.scala 52:21:@1250.4]
  assign _T_91 = _T_89 != 3'h0; // @[trigger_resolver.scala 55:35:@1251.4]
  assign _T_93 = _T_89 - 3'h1; // @[trigger_resolver.scala 57:63:@1253.6]
  assign _T_94 = $unsigned(_T_93); // @[trigger_resolver.scala 57:63:@1254.6]
  assign _T_95 = _T_94[2:0]; // @[trigger_resolver.scala 57:63:@1255.6]
  assign _T_96 = io_input_channel_empty_status >> _T_95; // @[trigger_resolver.scala 61:42:@1256.6]
  assign _T_97 = _T_96[0]; // @[trigger_resolver.scala 61:42:@1257.6]
  assign _T_99 = _T_97 == 1'h0; // @[trigger_resolver.scala 61:12:@1258.6]
  assign _T_102 = io_trigger_ictv[3:2]; // @[trigger_resolver.scala 69:52:@1265.6]
  assign _T_104 = _T_95[1:0]; // @[:@1266.6]
  assign _GEN_10 = 2'h1 == _T_104 ? io_input_channel_tags_1 : io_input_channel_tags_0; // @[trigger_resolver.scala 72:60:@1267.6]
  assign _GEN_11 = 2'h2 == _T_104 ? io_input_channel_tags_2 : _GEN_10; // @[trigger_resolver.scala 72:60:@1267.6]
  assign _GEN_12 = 2'h3 == _T_104 ? io_input_channel_tags_3 : _GEN_11; // @[trigger_resolver.scala 72:60:@1267.6]
  assign _T_105 = _GEN_12 == _T_102; // @[trigger_resolver.scala 72:60:@1267.6]
  assign _T_106 = io_trigger_ictb[1]; // @[trigger_resolver.scala 73:61:@1269.8]
  assign _T_108 = ~ _T_106; // @[trigger_resolver.scala 75:46:@1274.8]
  assign _GEN_13 = _T_105 ? _T_106 : _T_108; // @[trigger_resolver.scala 72:88:@1268.6]
  assign valid_input_channel_empty_status_array_1 = _T_91 ? _T_99 : 1'h1; // @[trigger_resolver.scala 55:43:@1252.4]
  assign valid_input_channel_tags_array_1 = _T_91 ? _GEN_13 : 1'h1; // @[trigger_resolver.scala 55:43:@1252.4]
  assign _T_111 = {valid_input_channel_empty_status_array_1,valid_input_channel_empty_status_array_0}; // @[trigger_resolver.scala 85:84:@1282.4]
  assign _T_112 = ~ _T_111; // @[trigger_resolver.scala 85:91:@1283.4]
  assign valid_input_channel_empty_status = _T_112 == 2'h0; // @[trigger_resolver.scala 85:91:@1284.4]
  assign _T_115 = {valid_input_channel_tags_array_1,valid_input_channel_tags_array_0}; // @[trigger_resolver.scala 86:68:@1286.4]
  assign _T_116 = ~ _T_115; // @[trigger_resolver.scala 86:75:@1287.4]
  assign valid_input_channel_tags = _T_116 == 2'h0; // @[trigger_resolver.scala 86:75:@1288.4]
  assign _GEN_16 = {{2'd0}, io_trigger_oci}; // @[trigger_resolver.scala 89:55:@1290.4]
  assign _T_119 = _GEN_16 & io_output_channel_full_status; // @[trigger_resolver.scala 89:55:@1290.4]
  assign valid_output_channel_full_status = _T_119 == 4'h0; // @[trigger_resolver.scala 89:88:@1291.4]
  assign _T_122 = io_trigger_vi & valid_predicate_state; // @[trigger_resolver.scala 91:29:@1293.4]
  assign _T_123 = _T_122 & valid_input_channel_empty_status; // @[trigger_resolver.scala 91:53:@1294.4]
  assign _T_124 = _T_123 & valid_input_channel_tags; // @[trigger_resolver.scala 91:88:@1295.4]
  assign io_valid = _T_124 & valid_output_channel_full_status; // @[trigger_resolver.scala 91:12:@1297.4]
endmodule
module trigger_resolution_priority_encoder( // @[:@2994.2]
  input        clock, // @[:@2995.4]
  input        reset, // @[:@2996.4]
  input        io_trigger_states_0, // @[:@2997.4]
  input        io_trigger_states_1, // @[:@2997.4]
  input        io_trigger_states_2, // @[:@2997.4]
  input        io_trigger_states_3, // @[:@2997.4]
  input        io_trigger_states_4, // @[:@2997.4]
  input        io_trigger_states_5, // @[:@2997.4]
  input        io_trigger_states_6, // @[:@2997.4]
  input        io_trigger_states_7, // @[:@2997.4]
  input        io_trigger_states_8, // @[:@2997.4]
  input        io_trigger_states_9, // @[:@2997.4]
  input        io_trigger_states_10, // @[:@2997.4]
  input        io_trigger_states_11, // @[:@2997.4]
  input        io_trigger_states_12, // @[:@2997.4]
  input        io_trigger_states_13, // @[:@2997.4]
  input        io_trigger_states_14, // @[:@2997.4]
  input        io_trigger_states_15, // @[:@2997.4]
  output       io_trigger_inst_valid, // @[:@2997.4]
  output [3:0] io_triggered_inst_index // @[:@2997.4]
);
  wire [3:0] _T_68; // @[Mux.scala 31:69:@3000.4]
  wire [3:0] _T_69; // @[Mux.scala 31:69:@3001.4]
  wire [3:0] _T_70; // @[Mux.scala 31:69:@3002.4]
  wire [3:0] _T_71; // @[Mux.scala 31:69:@3003.4]
  wire [3:0] _T_72; // @[Mux.scala 31:69:@3004.4]
  wire [3:0] _T_73; // @[Mux.scala 31:69:@3005.4]
  wire [3:0] _T_74; // @[Mux.scala 31:69:@3006.4]
  wire [3:0] _T_75; // @[Mux.scala 31:69:@3007.4]
  wire [3:0] _T_76; // @[Mux.scala 31:69:@3008.4]
  wire [3:0] _T_77; // @[Mux.scala 31:69:@3009.4]
  wire [3:0] _T_78; // @[Mux.scala 31:69:@3010.4]
  wire [3:0] _T_79; // @[Mux.scala 31:69:@3011.4]
  wire [3:0] _T_80; // @[Mux.scala 31:69:@3012.4]
  wire [3:0] _T_81; // @[Mux.scala 31:69:@3013.4]
  wire [3:0] triggered_inst_index; // @[Mux.scala 31:69:@3014.4]
  wire [4:0] _GEN_4; // @[trigger_resolution_priority_encoder.scala 17:29:@3016.4]
  wire  _T_84; // @[trigger_resolution_priority_encoder.scala 17:29:@3016.4]
  wire [3:0] _GEN_1; // @[trigger_resolution_priority_encoder.scala 18:58:@3018.6]
  wire  _T_91; // @[trigger_resolution_priority_encoder.scala 29:9:@3032.4]
  assign _T_68 = io_trigger_states_14 ? 4'he : 4'hf; // @[Mux.scala 31:69:@3000.4]
  assign _T_69 = io_trigger_states_13 ? 4'hd : _T_68; // @[Mux.scala 31:69:@3001.4]
  assign _T_70 = io_trigger_states_12 ? 4'hc : _T_69; // @[Mux.scala 31:69:@3002.4]
  assign _T_71 = io_trigger_states_11 ? 4'hb : _T_70; // @[Mux.scala 31:69:@3003.4]
  assign _T_72 = io_trigger_states_10 ? 4'ha : _T_71; // @[Mux.scala 31:69:@3004.4]
  assign _T_73 = io_trigger_states_9 ? 4'h9 : _T_72; // @[Mux.scala 31:69:@3005.4]
  assign _T_74 = io_trigger_states_8 ? 4'h8 : _T_73; // @[Mux.scala 31:69:@3006.4]
  assign _T_75 = io_trigger_states_7 ? 4'h7 : _T_74; // @[Mux.scala 31:69:@3007.4]
  assign _T_76 = io_trigger_states_6 ? 4'h6 : _T_75; // @[Mux.scala 31:69:@3008.4]
  assign _T_77 = io_trigger_states_5 ? 4'h5 : _T_76; // @[Mux.scala 31:69:@3009.4]
  assign _T_78 = io_trigger_states_4 ? 4'h4 : _T_77; // @[Mux.scala 31:69:@3010.4]
  assign _T_79 = io_trigger_states_3 ? 4'h3 : _T_78; // @[Mux.scala 31:69:@3011.4]
  assign _T_80 = io_trigger_states_2 ? 4'h2 : _T_79; // @[Mux.scala 31:69:@3012.4]
  assign _T_81 = io_trigger_states_1 ? 4'h1 : _T_80; // @[Mux.scala 31:69:@3013.4]
  assign triggered_inst_index = io_trigger_states_0 ? 4'h0 : _T_81; // @[Mux.scala 31:69:@3014.4]
  assign _GEN_4 = {{1'd0}, triggered_inst_index}; // @[trigger_resolution_priority_encoder.scala 17:29:@3016.4]
  assign _T_84 = _GEN_4 == 5'h10; // @[trigger_resolution_priority_encoder.scala 17:29:@3016.4]
  assign _GEN_1 = io_trigger_states_15 ? triggered_inst_index : 4'h0; // @[trigger_resolution_priority_encoder.scala 18:58:@3018.6]
  assign _T_91 = reset == 1'h0; // @[trigger_resolution_priority_encoder.scala 29:9:@3032.4]
  assign io_trigger_inst_valid = _T_84 ? io_trigger_states_15 : 1'h1; // @[trigger_resolution_priority_encoder.scala 19:29:@3019.8 trigger_resolution_priority_encoder.scala 22:29:@3023.8 trigger_resolution_priority_encoder.scala 26:27:@3028.6]
  assign io_triggered_inst_index = _T_84 ? _GEN_1 : triggered_inst_index; // @[trigger_resolution_priority_encoder.scala 20:31:@3020.8 trigger_resolution_priority_encoder.scala 23:31:@3024.8 trigger_resolution_priority_encoder.scala 27:29:@3029.6]
  always @(posedge clock) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_91) begin
          $fwrite(32'h80000002,"trigger states = Vec(%d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)\n",io_trigger_states_0,io_trigger_states_1,io_trigger_states_2,io_trigger_states_3,io_trigger_states_4,io_trigger_states_5,io_trigger_states_6,io_trigger_states_7,io_trigger_states_8,io_trigger_states_9,io_trigger_states_10,io_trigger_states_11,io_trigger_states_12,io_trigger_states_13,io_trigger_states_14,io_trigger_states_15); // @[trigger_resolution_priority_encoder.scala 29:9:@3034.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_91) begin
          $fwrite(32'h80000002,"the triggered instruction index is = %d\n",triggered_inst_index); // @[trigger_resolution_priority_encoder.scala 30:9:@3039.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_91) begin
          $fwrite(32'h80000002,"-------------------------\n"); // @[trigger_resolution_priority_encoder.scala 31:9:@3044.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module trigger_resolution_unit( // @[:@3047.2]
  input         clock, // @[:@3048.4]
  input         reset, // @[:@3049.4]
  input         io_enable, // @[:@3050.4]
  input         io_execute, // @[:@3050.4]
  input         io_halted, // @[:@3050.4]
  input         io_triggers_0_vi, // @[:@3050.4]
  input  [15:0] io_triggers_0_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_0_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_0_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_0_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_0_oci, // @[:@3050.4]
  input         io_triggers_1_vi, // @[:@3050.4]
  input  [15:0] io_triggers_1_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_1_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_1_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_1_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_1_oci, // @[:@3050.4]
  input         io_triggers_2_vi, // @[:@3050.4]
  input  [15:0] io_triggers_2_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_2_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_2_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_2_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_2_oci, // @[:@3050.4]
  input         io_triggers_3_vi, // @[:@3050.4]
  input  [15:0] io_triggers_3_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_3_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_3_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_3_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_3_oci, // @[:@3050.4]
  input         io_triggers_4_vi, // @[:@3050.4]
  input  [15:0] io_triggers_4_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_4_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_4_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_4_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_4_oci, // @[:@3050.4]
  input         io_triggers_5_vi, // @[:@3050.4]
  input  [15:0] io_triggers_5_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_5_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_5_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_5_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_5_oci, // @[:@3050.4]
  input         io_triggers_6_vi, // @[:@3050.4]
  input  [15:0] io_triggers_6_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_6_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_6_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_6_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_6_oci, // @[:@3050.4]
  input         io_triggers_7_vi, // @[:@3050.4]
  input  [15:0] io_triggers_7_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_7_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_7_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_7_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_7_oci, // @[:@3050.4]
  input         io_triggers_8_vi, // @[:@3050.4]
  input  [15:0] io_triggers_8_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_8_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_8_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_8_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_8_oci, // @[:@3050.4]
  input         io_triggers_9_vi, // @[:@3050.4]
  input  [15:0] io_triggers_9_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_9_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_9_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_9_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_9_oci, // @[:@3050.4]
  input         io_triggers_10_vi, // @[:@3050.4]
  input  [15:0] io_triggers_10_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_10_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_10_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_10_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_10_oci, // @[:@3050.4]
  input         io_triggers_11_vi, // @[:@3050.4]
  input  [15:0] io_triggers_11_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_11_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_11_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_11_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_11_oci, // @[:@3050.4]
  input         io_triggers_12_vi, // @[:@3050.4]
  input  [15:0] io_triggers_12_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_12_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_12_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_12_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_12_oci, // @[:@3050.4]
  input         io_triggers_13_vi, // @[:@3050.4]
  input  [15:0] io_triggers_13_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_13_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_13_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_13_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_13_oci, // @[:@3050.4]
  input         io_triggers_14_vi, // @[:@3050.4]
  input  [15:0] io_triggers_14_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_14_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_14_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_14_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_14_oci, // @[:@3050.4]
  input         io_triggers_15_vi, // @[:@3050.4]
  input  [15:0] io_triggers_15_ptm, // @[:@3050.4]
  input  [5:0]  io_triggers_15_ici, // @[:@3050.4]
  input  [1:0]  io_triggers_15_ictb, // @[:@3050.4]
  input  [3:0]  io_triggers_15_ictv, // @[:@3050.4]
  input  [1:0]  io_triggers_15_oci, // @[:@3050.4]
  input  [7:0]  io_predicates, // @[:@3050.4]
  input  [3:0]  io_input_channel_empty_status, // @[:@3050.4]
  input  [1:0]  io_input_channel_tags_0, // @[:@3050.4]
  input  [1:0]  io_input_channel_tags_1, // @[:@3050.4]
  input  [1:0]  io_input_channel_tags_2, // @[:@3050.4]
  input  [1:0]  io_input_channel_tags_3, // @[:@3050.4]
  input  [3:0]  io_output_channel_full_status, // @[:@3050.4]
  output        io_triggered_instruction_valid, // @[:@3050.4]
  output [3:0]  io_triggered_instruction_index // @[:@3050.4]
);
  wire  trigger_resolver_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire [15:0] trigger_resolver_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire [5:0] trigger_resolver_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire [1:0] trigger_resolver_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire [3:0] trigger_resolver_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire [1:0] trigger_resolver_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire [7:0] trigger_resolver_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire [3:0] trigger_resolver_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire [1:0] trigger_resolver_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire [1:0] trigger_resolver_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire [1:0] trigger_resolver_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire [1:0] trigger_resolver_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire [3:0] trigger_resolver_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire  trigger_resolver_io_valid; // @[trigger_resolution_unit.scala 32:77:@3054.4]
  wire  trigger_resolver_1_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire [15:0] trigger_resolver_1_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire [5:0] trigger_resolver_1_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire [1:0] trigger_resolver_1_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire [3:0] trigger_resolver_1_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire [1:0] trigger_resolver_1_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire [7:0] trigger_resolver_1_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire [3:0] trigger_resolver_1_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire [1:0] trigger_resolver_1_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire [1:0] trigger_resolver_1_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire [1:0] trigger_resolver_1_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire [1:0] trigger_resolver_1_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire [3:0] trigger_resolver_1_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire  trigger_resolver_1_io_valid; // @[trigger_resolution_unit.scala 32:77:@3057.4]
  wire  trigger_resolver_2_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire [15:0] trigger_resolver_2_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire [5:0] trigger_resolver_2_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire [1:0] trigger_resolver_2_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire [3:0] trigger_resolver_2_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire [1:0] trigger_resolver_2_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire [7:0] trigger_resolver_2_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire [3:0] trigger_resolver_2_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire [1:0] trigger_resolver_2_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire [1:0] trigger_resolver_2_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire [1:0] trigger_resolver_2_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire [1:0] trigger_resolver_2_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire [3:0] trigger_resolver_2_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire  trigger_resolver_2_io_valid; // @[trigger_resolution_unit.scala 32:77:@3060.4]
  wire  trigger_resolver_3_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire [15:0] trigger_resolver_3_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire [5:0] trigger_resolver_3_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire [1:0] trigger_resolver_3_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire [3:0] trigger_resolver_3_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire [1:0] trigger_resolver_3_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire [7:0] trigger_resolver_3_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire [3:0] trigger_resolver_3_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire [1:0] trigger_resolver_3_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire [1:0] trigger_resolver_3_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire [1:0] trigger_resolver_3_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire [1:0] trigger_resolver_3_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire [3:0] trigger_resolver_3_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire  trigger_resolver_3_io_valid; // @[trigger_resolution_unit.scala 32:77:@3063.4]
  wire  trigger_resolver_4_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire [15:0] trigger_resolver_4_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire [5:0] trigger_resolver_4_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire [1:0] trigger_resolver_4_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire [3:0] trigger_resolver_4_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire [1:0] trigger_resolver_4_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire [7:0] trigger_resolver_4_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire [3:0] trigger_resolver_4_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire [1:0] trigger_resolver_4_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire [1:0] trigger_resolver_4_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire [1:0] trigger_resolver_4_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire [1:0] trigger_resolver_4_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire [3:0] trigger_resolver_4_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire  trigger_resolver_4_io_valid; // @[trigger_resolution_unit.scala 32:77:@3066.4]
  wire  trigger_resolver_5_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire [15:0] trigger_resolver_5_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire [5:0] trigger_resolver_5_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire [1:0] trigger_resolver_5_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire [3:0] trigger_resolver_5_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire [1:0] trigger_resolver_5_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire [7:0] trigger_resolver_5_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire [3:0] trigger_resolver_5_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire [1:0] trigger_resolver_5_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire [1:0] trigger_resolver_5_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire [1:0] trigger_resolver_5_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire [1:0] trigger_resolver_5_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire [3:0] trigger_resolver_5_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire  trigger_resolver_5_io_valid; // @[trigger_resolution_unit.scala 32:77:@3069.4]
  wire  trigger_resolver_6_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire [15:0] trigger_resolver_6_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire [5:0] trigger_resolver_6_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire [1:0] trigger_resolver_6_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire [3:0] trigger_resolver_6_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire [1:0] trigger_resolver_6_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire [7:0] trigger_resolver_6_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire [3:0] trigger_resolver_6_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire [1:0] trigger_resolver_6_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire [1:0] trigger_resolver_6_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire [1:0] trigger_resolver_6_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire [1:0] trigger_resolver_6_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire [3:0] trigger_resolver_6_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire  trigger_resolver_6_io_valid; // @[trigger_resolution_unit.scala 32:77:@3072.4]
  wire  trigger_resolver_7_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire [15:0] trigger_resolver_7_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire [5:0] trigger_resolver_7_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire [1:0] trigger_resolver_7_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire [3:0] trigger_resolver_7_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire [1:0] trigger_resolver_7_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire [7:0] trigger_resolver_7_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire [3:0] trigger_resolver_7_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire [1:0] trigger_resolver_7_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire [1:0] trigger_resolver_7_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire [1:0] trigger_resolver_7_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire [1:0] trigger_resolver_7_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire [3:0] trigger_resolver_7_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire  trigger_resolver_7_io_valid; // @[trigger_resolution_unit.scala 32:77:@3075.4]
  wire  trigger_resolver_8_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire [15:0] trigger_resolver_8_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire [5:0] trigger_resolver_8_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire [1:0] trigger_resolver_8_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire [3:0] trigger_resolver_8_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire [1:0] trigger_resolver_8_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire [7:0] trigger_resolver_8_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire [3:0] trigger_resolver_8_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire [1:0] trigger_resolver_8_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire [1:0] trigger_resolver_8_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire [1:0] trigger_resolver_8_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire [1:0] trigger_resolver_8_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire [3:0] trigger_resolver_8_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire  trigger_resolver_8_io_valid; // @[trigger_resolution_unit.scala 32:77:@3078.4]
  wire  trigger_resolver_9_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire [15:0] trigger_resolver_9_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire [5:0] trigger_resolver_9_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire [1:0] trigger_resolver_9_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire [3:0] trigger_resolver_9_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire [1:0] trigger_resolver_9_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire [7:0] trigger_resolver_9_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire [3:0] trigger_resolver_9_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire [1:0] trigger_resolver_9_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire [1:0] trigger_resolver_9_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire [1:0] trigger_resolver_9_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire [1:0] trigger_resolver_9_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire [3:0] trigger_resolver_9_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire  trigger_resolver_9_io_valid; // @[trigger_resolution_unit.scala 32:77:@3081.4]
  wire  trigger_resolver_10_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire [15:0] trigger_resolver_10_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire [5:0] trigger_resolver_10_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire [1:0] trigger_resolver_10_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire [3:0] trigger_resolver_10_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire [1:0] trigger_resolver_10_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire [7:0] trigger_resolver_10_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire [3:0] trigger_resolver_10_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire [1:0] trigger_resolver_10_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire [1:0] trigger_resolver_10_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire [1:0] trigger_resolver_10_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire [1:0] trigger_resolver_10_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire [3:0] trigger_resolver_10_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire  trigger_resolver_10_io_valid; // @[trigger_resolution_unit.scala 32:77:@3084.4]
  wire  trigger_resolver_11_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire [15:0] trigger_resolver_11_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire [5:0] trigger_resolver_11_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire [1:0] trigger_resolver_11_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire [3:0] trigger_resolver_11_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire [1:0] trigger_resolver_11_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire [7:0] trigger_resolver_11_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire [3:0] trigger_resolver_11_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire [1:0] trigger_resolver_11_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire [1:0] trigger_resolver_11_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire [1:0] trigger_resolver_11_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire [1:0] trigger_resolver_11_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire [3:0] trigger_resolver_11_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire  trigger_resolver_11_io_valid; // @[trigger_resolution_unit.scala 32:77:@3087.4]
  wire  trigger_resolver_12_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire [15:0] trigger_resolver_12_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire [5:0] trigger_resolver_12_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire [1:0] trigger_resolver_12_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire [3:0] trigger_resolver_12_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire [1:0] trigger_resolver_12_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire [7:0] trigger_resolver_12_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire [3:0] trigger_resolver_12_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire [1:0] trigger_resolver_12_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire [1:0] trigger_resolver_12_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire [1:0] trigger_resolver_12_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire [1:0] trigger_resolver_12_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire [3:0] trigger_resolver_12_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire  trigger_resolver_12_io_valid; // @[trigger_resolution_unit.scala 32:77:@3090.4]
  wire  trigger_resolver_13_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire [15:0] trigger_resolver_13_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire [5:0] trigger_resolver_13_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire [1:0] trigger_resolver_13_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire [3:0] trigger_resolver_13_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire [1:0] trigger_resolver_13_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire [7:0] trigger_resolver_13_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire [3:0] trigger_resolver_13_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire [1:0] trigger_resolver_13_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire [1:0] trigger_resolver_13_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire [1:0] trigger_resolver_13_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire [1:0] trigger_resolver_13_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire [3:0] trigger_resolver_13_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire  trigger_resolver_13_io_valid; // @[trigger_resolution_unit.scala 32:77:@3093.4]
  wire  trigger_resolver_14_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire [15:0] trigger_resolver_14_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire [5:0] trigger_resolver_14_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire [1:0] trigger_resolver_14_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire [3:0] trigger_resolver_14_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire [1:0] trigger_resolver_14_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire [7:0] trigger_resolver_14_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire [3:0] trigger_resolver_14_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire [1:0] trigger_resolver_14_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire [1:0] trigger_resolver_14_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire [1:0] trigger_resolver_14_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire [1:0] trigger_resolver_14_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire [3:0] trigger_resolver_14_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire  trigger_resolver_14_io_valid; // @[trigger_resolution_unit.scala 32:77:@3096.4]
  wire  trigger_resolver_15_io_trigger_vi; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire [15:0] trigger_resolver_15_io_trigger_ptm; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire [5:0] trigger_resolver_15_io_trigger_ici; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire [1:0] trigger_resolver_15_io_trigger_ictb; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire [3:0] trigger_resolver_15_io_trigger_ictv; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire [1:0] trigger_resolver_15_io_trigger_oci; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire [7:0] trigger_resolver_15_io_predicates; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire [3:0] trigger_resolver_15_io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire [1:0] trigger_resolver_15_io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire [1:0] trigger_resolver_15_io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire [1:0] trigger_resolver_15_io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire [1:0] trigger_resolver_15_io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire [3:0] trigger_resolver_15_io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire  trigger_resolver_15_io_valid; // @[trigger_resolution_unit.scala 32:77:@3099.4]
  wire  trigger_resolution_priority_encoder_clock; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_reset; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_0; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_1; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_2; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_3; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_4; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_5; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_6; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_7; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_8; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_9; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_10; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_11; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_12; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_13; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_14; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_states_15; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  trigger_resolution_priority_encoder_io_trigger_inst_valid; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire [3:0] trigger_resolution_priority_encoder_io_triggered_inst_index; // @[trigger_resolution_unit.scala 42:20:@3551.4]
  wire  _T_816; // @[trigger_resolution_unit.scala 47:47:@3572.4]
  wire  halt_insensitive_triggered_instruction_valid; // @[trigger_resolution_unit.scala 26:58:@3052.4 trigger_resolution_unit.scala 44:48:@3570.4]
  wire  _T_817; // @[trigger_resolution_unit.scala 47:61:@3573.4]
  wire  _T_819; // @[trigger_resolution_unit.scala 47:112:@3574.4]
  trigger_resolver trigger_resolver ( // @[trigger_resolution_unit.scala 32:77:@3054.4]
    .io_trigger_vi(trigger_resolver_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_io_trigger_oci),
    .io_predicates(trigger_resolver_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_io_output_channel_full_status),
    .io_valid(trigger_resolver_io_valid)
  );
  trigger_resolver trigger_resolver_1 ( // @[trigger_resolution_unit.scala 32:77:@3057.4]
    .io_trigger_vi(trigger_resolver_1_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_1_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_1_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_1_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_1_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_1_io_trigger_oci),
    .io_predicates(trigger_resolver_1_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_1_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_1_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_1_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_1_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_1_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_1_io_output_channel_full_status),
    .io_valid(trigger_resolver_1_io_valid)
  );
  trigger_resolver trigger_resolver_2 ( // @[trigger_resolution_unit.scala 32:77:@3060.4]
    .io_trigger_vi(trigger_resolver_2_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_2_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_2_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_2_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_2_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_2_io_trigger_oci),
    .io_predicates(trigger_resolver_2_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_2_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_2_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_2_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_2_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_2_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_2_io_output_channel_full_status),
    .io_valid(trigger_resolver_2_io_valid)
  );
  trigger_resolver trigger_resolver_3 ( // @[trigger_resolution_unit.scala 32:77:@3063.4]
    .io_trigger_vi(trigger_resolver_3_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_3_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_3_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_3_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_3_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_3_io_trigger_oci),
    .io_predicates(trigger_resolver_3_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_3_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_3_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_3_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_3_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_3_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_3_io_output_channel_full_status),
    .io_valid(trigger_resolver_3_io_valid)
  );
  trigger_resolver trigger_resolver_4 ( // @[trigger_resolution_unit.scala 32:77:@3066.4]
    .io_trigger_vi(trigger_resolver_4_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_4_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_4_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_4_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_4_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_4_io_trigger_oci),
    .io_predicates(trigger_resolver_4_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_4_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_4_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_4_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_4_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_4_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_4_io_output_channel_full_status),
    .io_valid(trigger_resolver_4_io_valid)
  );
  trigger_resolver trigger_resolver_5 ( // @[trigger_resolution_unit.scala 32:77:@3069.4]
    .io_trigger_vi(trigger_resolver_5_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_5_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_5_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_5_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_5_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_5_io_trigger_oci),
    .io_predicates(trigger_resolver_5_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_5_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_5_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_5_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_5_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_5_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_5_io_output_channel_full_status),
    .io_valid(trigger_resolver_5_io_valid)
  );
  trigger_resolver trigger_resolver_6 ( // @[trigger_resolution_unit.scala 32:77:@3072.4]
    .io_trigger_vi(trigger_resolver_6_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_6_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_6_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_6_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_6_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_6_io_trigger_oci),
    .io_predicates(trigger_resolver_6_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_6_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_6_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_6_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_6_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_6_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_6_io_output_channel_full_status),
    .io_valid(trigger_resolver_6_io_valid)
  );
  trigger_resolver trigger_resolver_7 ( // @[trigger_resolution_unit.scala 32:77:@3075.4]
    .io_trigger_vi(trigger_resolver_7_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_7_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_7_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_7_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_7_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_7_io_trigger_oci),
    .io_predicates(trigger_resolver_7_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_7_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_7_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_7_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_7_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_7_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_7_io_output_channel_full_status),
    .io_valid(trigger_resolver_7_io_valid)
  );
  trigger_resolver trigger_resolver_8 ( // @[trigger_resolution_unit.scala 32:77:@3078.4]
    .io_trigger_vi(trigger_resolver_8_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_8_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_8_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_8_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_8_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_8_io_trigger_oci),
    .io_predicates(trigger_resolver_8_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_8_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_8_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_8_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_8_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_8_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_8_io_output_channel_full_status),
    .io_valid(trigger_resolver_8_io_valid)
  );
  trigger_resolver trigger_resolver_9 ( // @[trigger_resolution_unit.scala 32:77:@3081.4]
    .io_trigger_vi(trigger_resolver_9_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_9_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_9_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_9_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_9_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_9_io_trigger_oci),
    .io_predicates(trigger_resolver_9_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_9_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_9_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_9_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_9_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_9_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_9_io_output_channel_full_status),
    .io_valid(trigger_resolver_9_io_valid)
  );
  trigger_resolver trigger_resolver_10 ( // @[trigger_resolution_unit.scala 32:77:@3084.4]
    .io_trigger_vi(trigger_resolver_10_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_10_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_10_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_10_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_10_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_10_io_trigger_oci),
    .io_predicates(trigger_resolver_10_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_10_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_10_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_10_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_10_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_10_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_10_io_output_channel_full_status),
    .io_valid(trigger_resolver_10_io_valid)
  );
  trigger_resolver trigger_resolver_11 ( // @[trigger_resolution_unit.scala 32:77:@3087.4]
    .io_trigger_vi(trigger_resolver_11_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_11_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_11_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_11_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_11_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_11_io_trigger_oci),
    .io_predicates(trigger_resolver_11_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_11_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_11_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_11_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_11_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_11_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_11_io_output_channel_full_status),
    .io_valid(trigger_resolver_11_io_valid)
  );
  trigger_resolver trigger_resolver_12 ( // @[trigger_resolution_unit.scala 32:77:@3090.4]
    .io_trigger_vi(trigger_resolver_12_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_12_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_12_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_12_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_12_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_12_io_trigger_oci),
    .io_predicates(trigger_resolver_12_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_12_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_12_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_12_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_12_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_12_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_12_io_output_channel_full_status),
    .io_valid(trigger_resolver_12_io_valid)
  );
  trigger_resolver trigger_resolver_13 ( // @[trigger_resolution_unit.scala 32:77:@3093.4]
    .io_trigger_vi(trigger_resolver_13_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_13_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_13_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_13_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_13_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_13_io_trigger_oci),
    .io_predicates(trigger_resolver_13_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_13_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_13_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_13_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_13_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_13_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_13_io_output_channel_full_status),
    .io_valid(trigger_resolver_13_io_valid)
  );
  trigger_resolver trigger_resolver_14 ( // @[trigger_resolution_unit.scala 32:77:@3096.4]
    .io_trigger_vi(trigger_resolver_14_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_14_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_14_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_14_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_14_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_14_io_trigger_oci),
    .io_predicates(trigger_resolver_14_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_14_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_14_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_14_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_14_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_14_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_14_io_output_channel_full_status),
    .io_valid(trigger_resolver_14_io_valid)
  );
  trigger_resolver trigger_resolver_15 ( // @[trigger_resolution_unit.scala 32:77:@3099.4]
    .io_trigger_vi(trigger_resolver_15_io_trigger_vi),
    .io_trigger_ptm(trigger_resolver_15_io_trigger_ptm),
    .io_trigger_ici(trigger_resolver_15_io_trigger_ici),
    .io_trigger_ictb(trigger_resolver_15_io_trigger_ictb),
    .io_trigger_ictv(trigger_resolver_15_io_trigger_ictv),
    .io_trigger_oci(trigger_resolver_15_io_trigger_oci),
    .io_predicates(trigger_resolver_15_io_predicates),
    .io_input_channel_empty_status(trigger_resolver_15_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolver_15_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolver_15_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolver_15_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolver_15_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolver_15_io_output_channel_full_status),
    .io_valid(trigger_resolver_15_io_valid)
  );
  trigger_resolution_priority_encoder trigger_resolution_priority_encoder ( // @[trigger_resolution_unit.scala 42:20:@3551.4]
    .clock(trigger_resolution_priority_encoder_clock),
    .reset(trigger_resolution_priority_encoder_reset),
    .io_trigger_states_0(trigger_resolution_priority_encoder_io_trigger_states_0),
    .io_trigger_states_1(trigger_resolution_priority_encoder_io_trigger_states_1),
    .io_trigger_states_2(trigger_resolution_priority_encoder_io_trigger_states_2),
    .io_trigger_states_3(trigger_resolution_priority_encoder_io_trigger_states_3),
    .io_trigger_states_4(trigger_resolution_priority_encoder_io_trigger_states_4),
    .io_trigger_states_5(trigger_resolution_priority_encoder_io_trigger_states_5),
    .io_trigger_states_6(trigger_resolution_priority_encoder_io_trigger_states_6),
    .io_trigger_states_7(trigger_resolution_priority_encoder_io_trigger_states_7),
    .io_trigger_states_8(trigger_resolution_priority_encoder_io_trigger_states_8),
    .io_trigger_states_9(trigger_resolution_priority_encoder_io_trigger_states_9),
    .io_trigger_states_10(trigger_resolution_priority_encoder_io_trigger_states_10),
    .io_trigger_states_11(trigger_resolution_priority_encoder_io_trigger_states_11),
    .io_trigger_states_12(trigger_resolution_priority_encoder_io_trigger_states_12),
    .io_trigger_states_13(trigger_resolution_priority_encoder_io_trigger_states_13),
    .io_trigger_states_14(trigger_resolution_priority_encoder_io_trigger_states_14),
    .io_trigger_states_15(trigger_resolution_priority_encoder_io_trigger_states_15),
    .io_trigger_inst_valid(trigger_resolution_priority_encoder_io_trigger_inst_valid),
    .io_triggered_inst_index(trigger_resolution_priority_encoder_io_triggered_inst_index)
  );
  assign _T_816 = io_enable & io_execute; // @[trigger_resolution_unit.scala 47:47:@3572.4]
  assign halt_insensitive_triggered_instruction_valid = trigger_resolution_priority_encoder_io_trigger_inst_valid; // @[trigger_resolution_unit.scala 26:58:@3052.4 trigger_resolution_unit.scala 44:48:@3570.4]
  assign _T_817 = _T_816 & halt_insensitive_triggered_instruction_valid; // @[trigger_resolution_unit.scala 47:61:@3573.4]
  assign _T_819 = io_halted == 1'h0; // @[trigger_resolution_unit.scala 47:112:@3574.4]
  assign io_triggered_instruction_valid = _T_817 & _T_819; // @[trigger_resolution_unit.scala 47:34:@3576.4]
  assign io_triggered_instruction_index = trigger_resolution_priority_encoder_io_triggered_inst_index; // @[trigger_resolution_unit.scala 45:34:@3571.4]
  assign trigger_resolver_io_trigger_vi = io_triggers_0_vi; // @[trigger_resolution_unit.scala 32:34:@3116.4]
  assign trigger_resolver_io_trigger_ptm = io_triggers_0_ptm; // @[trigger_resolution_unit.scala 32:34:@3115.4]
  assign trigger_resolver_io_trigger_ici = io_triggers_0_ici; // @[trigger_resolution_unit.scala 32:34:@3114.4]
  assign trigger_resolver_io_trigger_ictb = io_triggers_0_ictb; // @[trigger_resolution_unit.scala 32:34:@3113.4]
  assign trigger_resolver_io_trigger_ictv = io_triggers_0_ictv; // @[trigger_resolution_unit.scala 32:34:@3112.4]
  assign trigger_resolver_io_trigger_oci = io_triggers_0_oci; // @[trigger_resolution_unit.scala 32:34:@3111.4]
  assign trigger_resolver_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3110.4]
  assign trigger_resolver_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3109.4]
  assign trigger_resolver_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3105.4]
  assign trigger_resolver_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3106.4]
  assign trigger_resolver_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3107.4]
  assign trigger_resolver_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3108.4]
  assign trigger_resolver_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3104.4]
  assign trigger_resolver_1_io_trigger_vi = io_triggers_1_vi; // @[trigger_resolution_unit.scala 32:34:@3130.4]
  assign trigger_resolver_1_io_trigger_ptm = io_triggers_1_ptm; // @[trigger_resolution_unit.scala 32:34:@3129.4]
  assign trigger_resolver_1_io_trigger_ici = io_triggers_1_ici; // @[trigger_resolution_unit.scala 32:34:@3128.4]
  assign trigger_resolver_1_io_trigger_ictb = io_triggers_1_ictb; // @[trigger_resolution_unit.scala 32:34:@3127.4]
  assign trigger_resolver_1_io_trigger_ictv = io_triggers_1_ictv; // @[trigger_resolution_unit.scala 32:34:@3126.4]
  assign trigger_resolver_1_io_trigger_oci = io_triggers_1_oci; // @[trigger_resolution_unit.scala 32:34:@3125.4]
  assign trigger_resolver_1_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3124.4]
  assign trigger_resolver_1_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3123.4]
  assign trigger_resolver_1_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3119.4]
  assign trigger_resolver_1_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3120.4]
  assign trigger_resolver_1_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3121.4]
  assign trigger_resolver_1_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3122.4]
  assign trigger_resolver_1_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3118.4]
  assign trigger_resolver_2_io_trigger_vi = io_triggers_2_vi; // @[trigger_resolution_unit.scala 32:34:@3144.4]
  assign trigger_resolver_2_io_trigger_ptm = io_triggers_2_ptm; // @[trigger_resolution_unit.scala 32:34:@3143.4]
  assign trigger_resolver_2_io_trigger_ici = io_triggers_2_ici; // @[trigger_resolution_unit.scala 32:34:@3142.4]
  assign trigger_resolver_2_io_trigger_ictb = io_triggers_2_ictb; // @[trigger_resolution_unit.scala 32:34:@3141.4]
  assign trigger_resolver_2_io_trigger_ictv = io_triggers_2_ictv; // @[trigger_resolution_unit.scala 32:34:@3140.4]
  assign trigger_resolver_2_io_trigger_oci = io_triggers_2_oci; // @[trigger_resolution_unit.scala 32:34:@3139.4]
  assign trigger_resolver_2_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3138.4]
  assign trigger_resolver_2_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3137.4]
  assign trigger_resolver_2_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3133.4]
  assign trigger_resolver_2_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3134.4]
  assign trigger_resolver_2_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3135.4]
  assign trigger_resolver_2_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3136.4]
  assign trigger_resolver_2_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3132.4]
  assign trigger_resolver_3_io_trigger_vi = io_triggers_3_vi; // @[trigger_resolution_unit.scala 32:34:@3158.4]
  assign trigger_resolver_3_io_trigger_ptm = io_triggers_3_ptm; // @[trigger_resolution_unit.scala 32:34:@3157.4]
  assign trigger_resolver_3_io_trigger_ici = io_triggers_3_ici; // @[trigger_resolution_unit.scala 32:34:@3156.4]
  assign trigger_resolver_3_io_trigger_ictb = io_triggers_3_ictb; // @[trigger_resolution_unit.scala 32:34:@3155.4]
  assign trigger_resolver_3_io_trigger_ictv = io_triggers_3_ictv; // @[trigger_resolution_unit.scala 32:34:@3154.4]
  assign trigger_resolver_3_io_trigger_oci = io_triggers_3_oci; // @[trigger_resolution_unit.scala 32:34:@3153.4]
  assign trigger_resolver_3_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3152.4]
  assign trigger_resolver_3_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3151.4]
  assign trigger_resolver_3_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3147.4]
  assign trigger_resolver_3_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3148.4]
  assign trigger_resolver_3_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3149.4]
  assign trigger_resolver_3_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3150.4]
  assign trigger_resolver_3_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3146.4]
  assign trigger_resolver_4_io_trigger_vi = io_triggers_4_vi; // @[trigger_resolution_unit.scala 32:34:@3172.4]
  assign trigger_resolver_4_io_trigger_ptm = io_triggers_4_ptm; // @[trigger_resolution_unit.scala 32:34:@3171.4]
  assign trigger_resolver_4_io_trigger_ici = io_triggers_4_ici; // @[trigger_resolution_unit.scala 32:34:@3170.4]
  assign trigger_resolver_4_io_trigger_ictb = io_triggers_4_ictb; // @[trigger_resolution_unit.scala 32:34:@3169.4]
  assign trigger_resolver_4_io_trigger_ictv = io_triggers_4_ictv; // @[trigger_resolution_unit.scala 32:34:@3168.4]
  assign trigger_resolver_4_io_trigger_oci = io_triggers_4_oci; // @[trigger_resolution_unit.scala 32:34:@3167.4]
  assign trigger_resolver_4_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3166.4]
  assign trigger_resolver_4_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3165.4]
  assign trigger_resolver_4_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3161.4]
  assign trigger_resolver_4_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3162.4]
  assign trigger_resolver_4_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3163.4]
  assign trigger_resolver_4_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3164.4]
  assign trigger_resolver_4_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3160.4]
  assign trigger_resolver_5_io_trigger_vi = io_triggers_5_vi; // @[trigger_resolution_unit.scala 32:34:@3186.4]
  assign trigger_resolver_5_io_trigger_ptm = io_triggers_5_ptm; // @[trigger_resolution_unit.scala 32:34:@3185.4]
  assign trigger_resolver_5_io_trigger_ici = io_triggers_5_ici; // @[trigger_resolution_unit.scala 32:34:@3184.4]
  assign trigger_resolver_5_io_trigger_ictb = io_triggers_5_ictb; // @[trigger_resolution_unit.scala 32:34:@3183.4]
  assign trigger_resolver_5_io_trigger_ictv = io_triggers_5_ictv; // @[trigger_resolution_unit.scala 32:34:@3182.4]
  assign trigger_resolver_5_io_trigger_oci = io_triggers_5_oci; // @[trigger_resolution_unit.scala 32:34:@3181.4]
  assign trigger_resolver_5_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3180.4]
  assign trigger_resolver_5_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3179.4]
  assign trigger_resolver_5_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3175.4]
  assign trigger_resolver_5_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3176.4]
  assign trigger_resolver_5_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3177.4]
  assign trigger_resolver_5_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3178.4]
  assign trigger_resolver_5_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3174.4]
  assign trigger_resolver_6_io_trigger_vi = io_triggers_6_vi; // @[trigger_resolution_unit.scala 32:34:@3200.4]
  assign trigger_resolver_6_io_trigger_ptm = io_triggers_6_ptm; // @[trigger_resolution_unit.scala 32:34:@3199.4]
  assign trigger_resolver_6_io_trigger_ici = io_triggers_6_ici; // @[trigger_resolution_unit.scala 32:34:@3198.4]
  assign trigger_resolver_6_io_trigger_ictb = io_triggers_6_ictb; // @[trigger_resolution_unit.scala 32:34:@3197.4]
  assign trigger_resolver_6_io_trigger_ictv = io_triggers_6_ictv; // @[trigger_resolution_unit.scala 32:34:@3196.4]
  assign trigger_resolver_6_io_trigger_oci = io_triggers_6_oci; // @[trigger_resolution_unit.scala 32:34:@3195.4]
  assign trigger_resolver_6_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3194.4]
  assign trigger_resolver_6_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3193.4]
  assign trigger_resolver_6_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3189.4]
  assign trigger_resolver_6_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3190.4]
  assign trigger_resolver_6_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3191.4]
  assign trigger_resolver_6_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3192.4]
  assign trigger_resolver_6_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3188.4]
  assign trigger_resolver_7_io_trigger_vi = io_triggers_7_vi; // @[trigger_resolution_unit.scala 32:34:@3214.4]
  assign trigger_resolver_7_io_trigger_ptm = io_triggers_7_ptm; // @[trigger_resolution_unit.scala 32:34:@3213.4]
  assign trigger_resolver_7_io_trigger_ici = io_triggers_7_ici; // @[trigger_resolution_unit.scala 32:34:@3212.4]
  assign trigger_resolver_7_io_trigger_ictb = io_triggers_7_ictb; // @[trigger_resolution_unit.scala 32:34:@3211.4]
  assign trigger_resolver_7_io_trigger_ictv = io_triggers_7_ictv; // @[trigger_resolution_unit.scala 32:34:@3210.4]
  assign trigger_resolver_7_io_trigger_oci = io_triggers_7_oci; // @[trigger_resolution_unit.scala 32:34:@3209.4]
  assign trigger_resolver_7_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3208.4]
  assign trigger_resolver_7_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3207.4]
  assign trigger_resolver_7_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3203.4]
  assign trigger_resolver_7_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3204.4]
  assign trigger_resolver_7_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3205.4]
  assign trigger_resolver_7_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3206.4]
  assign trigger_resolver_7_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3202.4]
  assign trigger_resolver_8_io_trigger_vi = io_triggers_8_vi; // @[trigger_resolution_unit.scala 32:34:@3228.4]
  assign trigger_resolver_8_io_trigger_ptm = io_triggers_8_ptm; // @[trigger_resolution_unit.scala 32:34:@3227.4]
  assign trigger_resolver_8_io_trigger_ici = io_triggers_8_ici; // @[trigger_resolution_unit.scala 32:34:@3226.4]
  assign trigger_resolver_8_io_trigger_ictb = io_triggers_8_ictb; // @[trigger_resolution_unit.scala 32:34:@3225.4]
  assign trigger_resolver_8_io_trigger_ictv = io_triggers_8_ictv; // @[trigger_resolution_unit.scala 32:34:@3224.4]
  assign trigger_resolver_8_io_trigger_oci = io_triggers_8_oci; // @[trigger_resolution_unit.scala 32:34:@3223.4]
  assign trigger_resolver_8_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3222.4]
  assign trigger_resolver_8_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3221.4]
  assign trigger_resolver_8_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3217.4]
  assign trigger_resolver_8_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3218.4]
  assign trigger_resolver_8_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3219.4]
  assign trigger_resolver_8_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3220.4]
  assign trigger_resolver_8_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3216.4]
  assign trigger_resolver_9_io_trigger_vi = io_triggers_9_vi; // @[trigger_resolution_unit.scala 32:34:@3242.4]
  assign trigger_resolver_9_io_trigger_ptm = io_triggers_9_ptm; // @[trigger_resolution_unit.scala 32:34:@3241.4]
  assign trigger_resolver_9_io_trigger_ici = io_triggers_9_ici; // @[trigger_resolution_unit.scala 32:34:@3240.4]
  assign trigger_resolver_9_io_trigger_ictb = io_triggers_9_ictb; // @[trigger_resolution_unit.scala 32:34:@3239.4]
  assign trigger_resolver_9_io_trigger_ictv = io_triggers_9_ictv; // @[trigger_resolution_unit.scala 32:34:@3238.4]
  assign trigger_resolver_9_io_trigger_oci = io_triggers_9_oci; // @[trigger_resolution_unit.scala 32:34:@3237.4]
  assign trigger_resolver_9_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3236.4]
  assign trigger_resolver_9_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3235.4]
  assign trigger_resolver_9_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3231.4]
  assign trigger_resolver_9_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3232.4]
  assign trigger_resolver_9_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3233.4]
  assign trigger_resolver_9_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3234.4]
  assign trigger_resolver_9_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3230.4]
  assign trigger_resolver_10_io_trigger_vi = io_triggers_10_vi; // @[trigger_resolution_unit.scala 32:34:@3256.4]
  assign trigger_resolver_10_io_trigger_ptm = io_triggers_10_ptm; // @[trigger_resolution_unit.scala 32:34:@3255.4]
  assign trigger_resolver_10_io_trigger_ici = io_triggers_10_ici; // @[trigger_resolution_unit.scala 32:34:@3254.4]
  assign trigger_resolver_10_io_trigger_ictb = io_triggers_10_ictb; // @[trigger_resolution_unit.scala 32:34:@3253.4]
  assign trigger_resolver_10_io_trigger_ictv = io_triggers_10_ictv; // @[trigger_resolution_unit.scala 32:34:@3252.4]
  assign trigger_resolver_10_io_trigger_oci = io_triggers_10_oci; // @[trigger_resolution_unit.scala 32:34:@3251.4]
  assign trigger_resolver_10_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3250.4]
  assign trigger_resolver_10_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3249.4]
  assign trigger_resolver_10_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3245.4]
  assign trigger_resolver_10_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3246.4]
  assign trigger_resolver_10_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3247.4]
  assign trigger_resolver_10_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3248.4]
  assign trigger_resolver_10_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3244.4]
  assign trigger_resolver_11_io_trigger_vi = io_triggers_11_vi; // @[trigger_resolution_unit.scala 32:34:@3270.4]
  assign trigger_resolver_11_io_trigger_ptm = io_triggers_11_ptm; // @[trigger_resolution_unit.scala 32:34:@3269.4]
  assign trigger_resolver_11_io_trigger_ici = io_triggers_11_ici; // @[trigger_resolution_unit.scala 32:34:@3268.4]
  assign trigger_resolver_11_io_trigger_ictb = io_triggers_11_ictb; // @[trigger_resolution_unit.scala 32:34:@3267.4]
  assign trigger_resolver_11_io_trigger_ictv = io_triggers_11_ictv; // @[trigger_resolution_unit.scala 32:34:@3266.4]
  assign trigger_resolver_11_io_trigger_oci = io_triggers_11_oci; // @[trigger_resolution_unit.scala 32:34:@3265.4]
  assign trigger_resolver_11_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3264.4]
  assign trigger_resolver_11_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3263.4]
  assign trigger_resolver_11_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3259.4]
  assign trigger_resolver_11_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3260.4]
  assign trigger_resolver_11_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3261.4]
  assign trigger_resolver_11_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3262.4]
  assign trigger_resolver_11_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3258.4]
  assign trigger_resolver_12_io_trigger_vi = io_triggers_12_vi; // @[trigger_resolution_unit.scala 32:34:@3284.4]
  assign trigger_resolver_12_io_trigger_ptm = io_triggers_12_ptm; // @[trigger_resolution_unit.scala 32:34:@3283.4]
  assign trigger_resolver_12_io_trigger_ici = io_triggers_12_ici; // @[trigger_resolution_unit.scala 32:34:@3282.4]
  assign trigger_resolver_12_io_trigger_ictb = io_triggers_12_ictb; // @[trigger_resolution_unit.scala 32:34:@3281.4]
  assign trigger_resolver_12_io_trigger_ictv = io_triggers_12_ictv; // @[trigger_resolution_unit.scala 32:34:@3280.4]
  assign trigger_resolver_12_io_trigger_oci = io_triggers_12_oci; // @[trigger_resolution_unit.scala 32:34:@3279.4]
  assign trigger_resolver_12_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3278.4]
  assign trigger_resolver_12_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3277.4]
  assign trigger_resolver_12_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3273.4]
  assign trigger_resolver_12_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3274.4]
  assign trigger_resolver_12_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3275.4]
  assign trigger_resolver_12_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3276.4]
  assign trigger_resolver_12_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3272.4]
  assign trigger_resolver_13_io_trigger_vi = io_triggers_13_vi; // @[trigger_resolution_unit.scala 32:34:@3298.4]
  assign trigger_resolver_13_io_trigger_ptm = io_triggers_13_ptm; // @[trigger_resolution_unit.scala 32:34:@3297.4]
  assign trigger_resolver_13_io_trigger_ici = io_triggers_13_ici; // @[trigger_resolution_unit.scala 32:34:@3296.4]
  assign trigger_resolver_13_io_trigger_ictb = io_triggers_13_ictb; // @[trigger_resolution_unit.scala 32:34:@3295.4]
  assign trigger_resolver_13_io_trigger_ictv = io_triggers_13_ictv; // @[trigger_resolution_unit.scala 32:34:@3294.4]
  assign trigger_resolver_13_io_trigger_oci = io_triggers_13_oci; // @[trigger_resolution_unit.scala 32:34:@3293.4]
  assign trigger_resolver_13_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3292.4]
  assign trigger_resolver_13_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3291.4]
  assign trigger_resolver_13_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3287.4]
  assign trigger_resolver_13_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3288.4]
  assign trigger_resolver_13_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3289.4]
  assign trigger_resolver_13_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3290.4]
  assign trigger_resolver_13_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3286.4]
  assign trigger_resolver_14_io_trigger_vi = io_triggers_14_vi; // @[trigger_resolution_unit.scala 32:34:@3312.4]
  assign trigger_resolver_14_io_trigger_ptm = io_triggers_14_ptm; // @[trigger_resolution_unit.scala 32:34:@3311.4]
  assign trigger_resolver_14_io_trigger_ici = io_triggers_14_ici; // @[trigger_resolution_unit.scala 32:34:@3310.4]
  assign trigger_resolver_14_io_trigger_ictb = io_triggers_14_ictb; // @[trigger_resolution_unit.scala 32:34:@3309.4]
  assign trigger_resolver_14_io_trigger_ictv = io_triggers_14_ictv; // @[trigger_resolution_unit.scala 32:34:@3308.4]
  assign trigger_resolver_14_io_trigger_oci = io_triggers_14_oci; // @[trigger_resolution_unit.scala 32:34:@3307.4]
  assign trigger_resolver_14_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3306.4]
  assign trigger_resolver_14_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3305.4]
  assign trigger_resolver_14_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3301.4]
  assign trigger_resolver_14_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3302.4]
  assign trigger_resolver_14_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3303.4]
  assign trigger_resolver_14_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3304.4]
  assign trigger_resolver_14_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3300.4]
  assign trigger_resolver_15_io_trigger_vi = io_triggers_15_vi; // @[trigger_resolution_unit.scala 32:34:@3326.4]
  assign trigger_resolver_15_io_trigger_ptm = io_triggers_15_ptm; // @[trigger_resolution_unit.scala 32:34:@3325.4]
  assign trigger_resolver_15_io_trigger_ici = io_triggers_15_ici; // @[trigger_resolution_unit.scala 32:34:@3324.4]
  assign trigger_resolver_15_io_trigger_ictb = io_triggers_15_ictb; // @[trigger_resolution_unit.scala 32:34:@3323.4]
  assign trigger_resolver_15_io_trigger_ictv = io_triggers_15_ictv; // @[trigger_resolution_unit.scala 32:34:@3322.4]
  assign trigger_resolver_15_io_trigger_oci = io_triggers_15_oci; // @[trigger_resolution_unit.scala 32:34:@3321.4]
  assign trigger_resolver_15_io_predicates = io_predicates; // @[trigger_resolution_unit.scala 32:34:@3320.4]
  assign trigger_resolver_15_io_input_channel_empty_status = io_input_channel_empty_status; // @[trigger_resolution_unit.scala 32:34:@3319.4]
  assign trigger_resolver_15_io_input_channel_tags_0 = io_input_channel_tags_0; // @[trigger_resolution_unit.scala 32:34:@3315.4]
  assign trigger_resolver_15_io_input_channel_tags_1 = io_input_channel_tags_1; // @[trigger_resolution_unit.scala 32:34:@3316.4]
  assign trigger_resolver_15_io_input_channel_tags_2 = io_input_channel_tags_2; // @[trigger_resolution_unit.scala 32:34:@3317.4]
  assign trigger_resolver_15_io_input_channel_tags_3 = io_input_channel_tags_3; // @[trigger_resolution_unit.scala 32:34:@3318.4]
  assign trigger_resolver_15_io_output_channel_full_status = io_output_channel_full_status; // @[trigger_resolution_unit.scala 32:34:@3314.4]
  assign trigger_resolution_priority_encoder_clock = clock; // @[:@3552.4]
  assign trigger_resolution_priority_encoder_reset = reset; // @[:@3553.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_0 = trigger_resolver_io_valid; // @[trigger_resolution_unit.scala 43:23:@3554.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_1 = trigger_resolver_1_io_valid; // @[trigger_resolution_unit.scala 43:23:@3555.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_2 = trigger_resolver_2_io_valid; // @[trigger_resolution_unit.scala 43:23:@3556.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_3 = trigger_resolver_3_io_valid; // @[trigger_resolution_unit.scala 43:23:@3557.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_4 = trigger_resolver_4_io_valid; // @[trigger_resolution_unit.scala 43:23:@3558.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_5 = trigger_resolver_5_io_valid; // @[trigger_resolution_unit.scala 43:23:@3559.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_6 = trigger_resolver_6_io_valid; // @[trigger_resolution_unit.scala 43:23:@3560.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_7 = trigger_resolver_7_io_valid; // @[trigger_resolution_unit.scala 43:23:@3561.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_8 = trigger_resolver_8_io_valid; // @[trigger_resolution_unit.scala 43:23:@3562.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_9 = trigger_resolver_9_io_valid; // @[trigger_resolution_unit.scala 43:23:@3563.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_10 = trigger_resolver_10_io_valid; // @[trigger_resolution_unit.scala 43:23:@3564.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_11 = trigger_resolver_11_io_valid; // @[trigger_resolution_unit.scala 43:23:@3565.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_12 = trigger_resolver_12_io_valid; // @[trigger_resolution_unit.scala 43:23:@3566.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_13 = trigger_resolver_13_io_valid; // @[trigger_resolution_unit.scala 43:23:@3567.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_14 = trigger_resolver_14_io_valid; // @[trigger_resolution_unit.scala 43:23:@3568.4]
  assign trigger_resolution_priority_encoder_io_trigger_states_15 = trigger_resolver_15_io_valid; // @[trigger_resolution_unit.scala 43:23:@3569.4]
endmodule
module instruction( // @[:@3578.2]
  input         clock, // @[:@3579.4]
  input         io_enable, // @[:@3581.4]
  output        io_read_vi, // @[:@3581.4]
  output [5:0]  io_read_op, // @[:@3581.4]
  output [5:0]  io_read_st, // @[:@3581.4]
  output [8:0]  io_read_si, // @[:@3581.4]
  output [1:0]  io_read_dt, // @[:@3581.4]
  output [2:0]  io_read_di, // @[:@3581.4]
  output [3:0]  io_read_oci, // @[:@3581.4]
  output [1:0]  io_read_oct, // @[:@3581.4]
  output [3:0]  io_read_icd, // @[:@3581.4]
  output [15:0] io_read_pum, // @[:@3581.4]
  input  [52:0] io_write // @[:@3581.4]
);
  wire  _T_11; // @[instruction_t.scala 178:8:@3583.4]
  reg  vi; // @[Reg.scala 11:16:@3584.4]
  reg [31:0] _RAND_0;
  wire [5:0] _T_13; // @[instruction_t.scala 178:8:@3588.4]
  reg [5:0] op; // @[Reg.scala 11:16:@3589.4]
  reg [31:0] _RAND_1;
  wire [5:0] _T_15; // @[instruction_t.scala 178:8:@3593.4]
  reg [5:0] st; // @[Reg.scala 11:16:@3594.4]
  reg [31:0] _RAND_2;
  wire [8:0] _T_17; // @[instruction_t.scala 178:8:@3598.4]
  reg [8:0] si; // @[Reg.scala 11:16:@3599.4]
  reg [31:0] _RAND_3;
  wire [1:0] _T_19; // @[instruction_t.scala 178:8:@3603.4]
  reg [1:0] dt; // @[Reg.scala 11:16:@3604.4]
  reg [31:0] _RAND_4;
  wire [2:0] _T_21; // @[instruction_t.scala 178:8:@3608.4]
  reg [2:0] di; // @[Reg.scala 11:16:@3609.4]
  reg [31:0] _RAND_5;
  wire [1:0] _T_23; // @[instruction_t.scala 178:8:@3613.4]
  reg [1:0] oci; // @[Reg.scala 11:16:@3614.4]
  reg [31:0] _RAND_6;
  reg [1:0] oct; // @[Reg.scala 11:16:@3619.4]
  reg [31:0] _RAND_7;
  wire [3:0] _T_27; // @[instruction_t.scala 178:8:@3623.4]
  reg [3:0] icd; // @[Reg.scala 11:16:@3624.4]
  reg [31:0] _RAND_8;
  wire [15:0] _T_29; // @[instruction_t.scala 178:8:@3628.4]
  reg [15:0] pum; // @[Reg.scala 11:16:@3629.4]
  reg [31:0] _RAND_9;
  assign _T_11 = io_write[0]; // @[instruction_t.scala 178:8:@3583.4]
  assign _T_13 = io_write[6:1]; // @[instruction_t.scala 178:8:@3588.4]
  assign _T_15 = io_write[12:7]; // @[instruction_t.scala 178:8:@3593.4]
  assign _T_17 = io_write[21:13]; // @[instruction_t.scala 178:8:@3598.4]
  assign _T_19 = io_write[23:22]; // @[instruction_t.scala 178:8:@3603.4]
  assign _T_21 = io_write[26:24]; // @[instruction_t.scala 178:8:@3608.4]
  assign _T_23 = io_write[32:31]; // @[instruction_t.scala 178:8:@3613.4]
  assign _T_27 = io_write[36:33]; // @[instruction_t.scala 178:8:@3623.4]
  assign _T_29 = io_write[52:37]; // @[instruction_t.scala 178:8:@3628.4]
  assign io_read_vi = vi; // @[instruction_t.scala 71:14:@3633.4]
  assign io_read_op = op; // @[instruction_t.scala 72:14:@3634.4]
  assign io_read_st = st; // @[instruction_t.scala 73:14:@3635.4]
  assign io_read_si = si; // @[instruction_t.scala 74:14:@3636.4]
  assign io_read_dt = dt; // @[instruction_t.scala 75:14:@3637.4]
  assign io_read_di = di; // @[instruction_t.scala 76:14:@3638.4]
  assign io_read_oci = {{2'd0}, oci}; // @[instruction_t.scala 77:15:@3639.4]
  assign io_read_oct = oct; // @[instruction_t.scala 78:15:@3640.4]
  assign io_read_icd = icd; // @[instruction_t.scala 79:15:@3641.4]
  assign io_read_pum = pum; // @[instruction_t.scala 80:15:@3642.4]
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
  vi = _RAND_0[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  op = _RAND_1[5:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  st = _RAND_2[5:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  si = _RAND_3[8:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  dt = _RAND_4[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  di = _RAND_5[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  oci = _RAND_6[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  oct = _RAND_7[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  icd = _RAND_8[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  pum = _RAND_9[15:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (io_enable) begin
      vi <= _T_11;
    end
    if (io_enable) begin
      op <= _T_13;
    end
    if (io_enable) begin
      st <= _T_15;
    end
    if (io_enable) begin
      si <= _T_17;
    end
    if (io_enable) begin
      dt <= _T_19;
    end
    if (io_enable) begin
      di <= _T_21;
    end
    if (io_enable) begin
      oci <= _T_23;
    end
    if (io_enable) begin
      oct <= _T_23;
    end
    if (io_enable) begin
      icd <= _T_27;
    end
    if (io_enable) begin
      pum <= _T_29;
    end
  end
endmodule
module mm_instruction( // @[:@3644.2]
  input          clock, // @[:@3645.4]
  input          io_enable, // @[:@3647.4]
  output         io_read_vi, // @[:@3647.4]
  output [5:0]   io_read_op, // @[:@3647.4]
  output [5:0]   io_read_st, // @[:@3647.4]
  output [8:0]   io_read_si, // @[:@3647.4]
  output [1:0]   io_read_dt, // @[:@3647.4]
  output [2:0]   io_read_di, // @[:@3647.4]
  output [3:0]   io_read_oci, // @[:@3647.4]
  output [1:0]   io_read_oct, // @[:@3647.4]
  output [3:0]   io_read_icd, // @[:@3647.4]
  output [15:0]  io_read_pum, // @[:@3647.4]
  output [31:0]  io_read_immediate, // @[:@3647.4]
  output [15:0]  io_read_ptm, // @[:@3647.4]
  output [5:0]   io_read_ici, // @[:@3647.4]
  output [1:0]   io_read_ictb, // @[:@3647.4]
  output [3:0]   io_read_ictv, // @[:@3647.4]
  input  [127:0] io_write // @[:@3647.4]
);
  wire  instruction_clock; // @[instruction_t.scala 15:28:@3649.4]
  wire  instruction_io_enable; // @[instruction_t.scala 15:28:@3649.4]
  wire  instruction_io_read_vi; // @[instruction_t.scala 15:28:@3649.4]
  wire [5:0] instruction_io_read_op; // @[instruction_t.scala 15:28:@3649.4]
  wire [5:0] instruction_io_read_st; // @[instruction_t.scala 15:28:@3649.4]
  wire [8:0] instruction_io_read_si; // @[instruction_t.scala 15:28:@3649.4]
  wire [1:0] instruction_io_read_dt; // @[instruction_t.scala 15:28:@3649.4]
  wire [2:0] instruction_io_read_di; // @[instruction_t.scala 15:28:@3649.4]
  wire [3:0] instruction_io_read_oci; // @[instruction_t.scala 15:28:@3649.4]
  wire [1:0] instruction_io_read_oct; // @[instruction_t.scala 15:28:@3649.4]
  wire [3:0] instruction_io_read_icd; // @[instruction_t.scala 15:28:@3649.4]
  wire [15:0] instruction_io_read_pum; // @[instruction_t.scala 15:28:@3649.4]
  wire [52:0] instruction_io_write; // @[instruction_t.scala 15:28:@3649.4]
  wire [15:0] _T_12; // @[instruction_t.scala 178:8:@3655.4]
  reg [15:0] ptm; // @[Reg.scala 11:16:@3656.4]
  reg [31:0] _RAND_0;
  wire [5:0] _T_14; // @[instruction_t.scala 178:8:@3660.4]
  reg [5:0] ici; // @[Reg.scala 11:16:@3661.4]
  reg [31:0] _RAND_1;
  wire [1:0] _T_16; // @[instruction_t.scala 178:8:@3665.4]
  reg [1:0] ictb; // @[Reg.scala 11:16:@3666.4]
  reg [31:0] _RAND_2;
  wire [3:0] _T_18; // @[instruction_t.scala 178:8:@3670.4]
  reg [3:0] ictv; // @[Reg.scala 11:16:@3671.4]
  reg [31:0] _RAND_3;
  wire [31:0] _T_20; // @[instruction_t.scala 178:8:@3675.4]
  reg [31:0] immediate; // @[Reg.scala 11:16:@3676.4]
  reg [31:0] _RAND_4;
  instruction instruction ( // @[instruction_t.scala 15:28:@3649.4]
    .clock(instruction_clock),
    .io_enable(instruction_io_enable),
    .io_read_vi(instruction_io_read_vi),
    .io_read_op(instruction_io_read_op),
    .io_read_st(instruction_io_read_st),
    .io_read_si(instruction_io_read_si),
    .io_read_dt(instruction_io_read_dt),
    .io_read_di(instruction_io_read_di),
    .io_read_oci(instruction_io_read_oci),
    .io_read_oct(instruction_io_read_oct),
    .io_read_icd(instruction_io_read_icd),
    .io_read_pum(instruction_io_read_pum),
    .io_write(instruction_io_write)
  );
  assign _T_12 = io_write[68:53]; // @[instruction_t.scala 178:8:@3655.4]
  assign _T_14 = io_write[74:69]; // @[instruction_t.scala 178:8:@3660.4]
  assign _T_16 = io_write[76:75]; // @[instruction_t.scala 178:8:@3665.4]
  assign _T_18 = io_write[80:77]; // @[instruction_t.scala 178:8:@3670.4]
  assign _T_20 = io_write[112:81]; // @[instruction_t.scala 178:8:@3675.4]
  assign io_read_vi = instruction_io_read_vi; // @[instruction_t.scala 32:14:@3680.4]
  assign io_read_op = instruction_io_read_op; // @[instruction_t.scala 33:14:@3681.4]
  assign io_read_st = instruction_io_read_st; // @[instruction_t.scala 34:14:@3682.4]
  assign io_read_si = instruction_io_read_si; // @[instruction_t.scala 35:14:@3683.4]
  assign io_read_dt = instruction_io_read_dt; // @[instruction_t.scala 36:14:@3684.4]
  assign io_read_di = instruction_io_read_di; // @[instruction_t.scala 37:14:@3685.4]
  assign io_read_oci = instruction_io_read_oci; // @[instruction_t.scala 38:15:@3686.4]
  assign io_read_oct = instruction_io_read_oct; // @[instruction_t.scala 39:15:@3687.4]
  assign io_read_icd = instruction_io_read_icd; // @[instruction_t.scala 40:15:@3688.4]
  assign io_read_pum = instruction_io_read_pum; // @[instruction_t.scala 41:15:@3689.4]
  assign io_read_immediate = immediate; // @[instruction_t.scala 47:21:@3694.4]
  assign io_read_ptm = ptm; // @[instruction_t.scala 43:15:@3690.4]
  assign io_read_ici = ici; // @[instruction_t.scala 44:15:@3691.4]
  assign io_read_ictb = ictb; // @[instruction_t.scala 45:16:@3692.4]
  assign io_read_ictv = ictv; // @[instruction_t.scala 46:16:@3693.4]
  assign instruction_clock = clock; // @[:@3650.4]
  assign instruction_io_enable = io_enable; // @[instruction_t.scala 18:23:@3652.4]
  assign instruction_io_write = io_write[52:0]; // @[instruction_t.scala 23:22:@3654.4]
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
  ptm = _RAND_0[15:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  ici = _RAND_1[5:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  ictb = _RAND_2[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  ictv = _RAND_3[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  immediate = _RAND_4[31:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (io_enable) begin
      ptm <= _T_12;
    end
    if (io_enable) begin
      ici <= _T_14;
    end
    if (io_enable) begin
      ictb <= _T_16;
    end
    if (io_enable) begin
      ictv <= _T_18;
    end
    if (io_enable) begin
      immediate <= _T_20;
    end
  end
endmodule
module instruction_memory( // @[:@5504.2]
  input         clock, // @[:@5505.4]
  input         io_enable, // @[:@5507.4]
  input         io_host_interface_read_req, // @[:@5507.4]
  output        io_host_interface_read_ack, // @[:@5507.4]
  input         io_host_interface_write_req, // @[:@5507.4]
  output        io_host_interface_write_ack, // @[:@5507.4]
  input  [29:0] io_host_interface_write_index, // @[:@5507.4]
  input  [31:0] io_host_interface_write_data, // @[:@5507.4]
  output        io_triggers_0_vi, // @[:@5507.4]
  output [15:0] io_triggers_0_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_0_ici, // @[:@5507.4]
  output [1:0]  io_triggers_0_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_0_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_0_oci, // @[:@5507.4]
  output        io_triggers_1_vi, // @[:@5507.4]
  output [15:0] io_triggers_1_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_1_ici, // @[:@5507.4]
  output [1:0]  io_triggers_1_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_1_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_1_oci, // @[:@5507.4]
  output        io_triggers_2_vi, // @[:@5507.4]
  output [15:0] io_triggers_2_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_2_ici, // @[:@5507.4]
  output [1:0]  io_triggers_2_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_2_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_2_oci, // @[:@5507.4]
  output        io_triggers_3_vi, // @[:@5507.4]
  output [15:0] io_triggers_3_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_3_ici, // @[:@5507.4]
  output [1:0]  io_triggers_3_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_3_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_3_oci, // @[:@5507.4]
  output        io_triggers_4_vi, // @[:@5507.4]
  output [15:0] io_triggers_4_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_4_ici, // @[:@5507.4]
  output [1:0]  io_triggers_4_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_4_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_4_oci, // @[:@5507.4]
  output        io_triggers_5_vi, // @[:@5507.4]
  output [15:0] io_triggers_5_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_5_ici, // @[:@5507.4]
  output [1:0]  io_triggers_5_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_5_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_5_oci, // @[:@5507.4]
  output        io_triggers_6_vi, // @[:@5507.4]
  output [15:0] io_triggers_6_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_6_ici, // @[:@5507.4]
  output [1:0]  io_triggers_6_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_6_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_6_oci, // @[:@5507.4]
  output        io_triggers_7_vi, // @[:@5507.4]
  output [15:0] io_triggers_7_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_7_ici, // @[:@5507.4]
  output [1:0]  io_triggers_7_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_7_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_7_oci, // @[:@5507.4]
  output        io_triggers_8_vi, // @[:@5507.4]
  output [15:0] io_triggers_8_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_8_ici, // @[:@5507.4]
  output [1:0]  io_triggers_8_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_8_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_8_oci, // @[:@5507.4]
  output        io_triggers_9_vi, // @[:@5507.4]
  output [15:0] io_triggers_9_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_9_ici, // @[:@5507.4]
  output [1:0]  io_triggers_9_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_9_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_9_oci, // @[:@5507.4]
  output        io_triggers_10_vi, // @[:@5507.4]
  output [15:0] io_triggers_10_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_10_ici, // @[:@5507.4]
  output [1:0]  io_triggers_10_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_10_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_10_oci, // @[:@5507.4]
  output        io_triggers_11_vi, // @[:@5507.4]
  output [15:0] io_triggers_11_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_11_ici, // @[:@5507.4]
  output [1:0]  io_triggers_11_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_11_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_11_oci, // @[:@5507.4]
  output        io_triggers_12_vi, // @[:@5507.4]
  output [15:0] io_triggers_12_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_12_ici, // @[:@5507.4]
  output [1:0]  io_triggers_12_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_12_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_12_oci, // @[:@5507.4]
  output        io_triggers_13_vi, // @[:@5507.4]
  output [15:0] io_triggers_13_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_13_ici, // @[:@5507.4]
  output [1:0]  io_triggers_13_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_13_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_13_oci, // @[:@5507.4]
  output        io_triggers_14_vi, // @[:@5507.4]
  output [15:0] io_triggers_14_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_14_ici, // @[:@5507.4]
  output [1:0]  io_triggers_14_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_14_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_14_oci, // @[:@5507.4]
  output        io_triggers_15_vi, // @[:@5507.4]
  output [15:0] io_triggers_15_ptm, // @[:@5507.4]
  output [5:0]  io_triggers_15_ici, // @[:@5507.4]
  output [1:0]  io_triggers_15_ictb, // @[:@5507.4]
  output [3:0]  io_triggers_15_ictv, // @[:@5507.4]
  output [1:0]  io_triggers_15_oci, // @[:@5507.4]
  input         io_triggered_instruction_valid, // @[:@5507.4]
  input  [3:0]  io_triggered_instruction_index, // @[:@5507.4]
  output        io_triggered_datapath_instruction_vi, // @[:@5507.4]
  output [5:0]  io_triggered_datapath_instruction_op, // @[:@5507.4]
  output [5:0]  io_triggered_datapath_instruction_st, // @[:@5507.4]
  output [8:0]  io_triggered_datapath_instruction_si, // @[:@5507.4]
  output [1:0]  io_triggered_datapath_instruction_dt, // @[:@5507.4]
  output [2:0]  io_triggered_datapath_instruction_di, // @[:@5507.4]
  output [3:0]  io_triggered_datapath_instruction_oci, // @[:@5507.4]
  output [1:0]  io_triggered_datapath_instruction_oct, // @[:@5507.4]
  output [3:0]  io_triggered_datapath_instruction_icd, // @[:@5507.4]
  output [15:0] io_triggered_datapath_instruction_pum, // @[:@5507.4]
  output [31:0] io_triggered_datapath_instruction_immediate // @[:@5507.4]
);
  wire  mm_instruction_clock; // @[instruction_memory.scala 22:73:@5509.4]
  wire  mm_instruction_io_enable; // @[instruction_memory.scala 22:73:@5509.4]
  wire  mm_instruction_io_read_vi; // @[instruction_memory.scala 22:73:@5509.4]
  wire [5:0] mm_instruction_io_read_op; // @[instruction_memory.scala 22:73:@5509.4]
  wire [5:0] mm_instruction_io_read_st; // @[instruction_memory.scala 22:73:@5509.4]
  wire [8:0] mm_instruction_io_read_si; // @[instruction_memory.scala 22:73:@5509.4]
  wire [1:0] mm_instruction_io_read_dt; // @[instruction_memory.scala 22:73:@5509.4]
  wire [2:0] mm_instruction_io_read_di; // @[instruction_memory.scala 22:73:@5509.4]
  wire [3:0] mm_instruction_io_read_oci; // @[instruction_memory.scala 22:73:@5509.4]
  wire [1:0] mm_instruction_io_read_oct; // @[instruction_memory.scala 22:73:@5509.4]
  wire [3:0] mm_instruction_io_read_icd; // @[instruction_memory.scala 22:73:@5509.4]
  wire [15:0] mm_instruction_io_read_pum; // @[instruction_memory.scala 22:73:@5509.4]
  wire [31:0] mm_instruction_io_read_immediate; // @[instruction_memory.scala 22:73:@5509.4]
  wire [15:0] mm_instruction_io_read_ptm; // @[instruction_memory.scala 22:73:@5509.4]
  wire [5:0] mm_instruction_io_read_ici; // @[instruction_memory.scala 22:73:@5509.4]
  wire [1:0] mm_instruction_io_read_ictb; // @[instruction_memory.scala 22:73:@5509.4]
  wire [3:0] mm_instruction_io_read_ictv; // @[instruction_memory.scala 22:73:@5509.4]
  wire [127:0] mm_instruction_io_write; // @[instruction_memory.scala 22:73:@5509.4]
  wire  mm_instruction_1_clock; // @[instruction_memory.scala 22:73:@5512.4]
  wire  mm_instruction_1_io_enable; // @[instruction_memory.scala 22:73:@5512.4]
  wire  mm_instruction_1_io_read_vi; // @[instruction_memory.scala 22:73:@5512.4]
  wire [5:0] mm_instruction_1_io_read_op; // @[instruction_memory.scala 22:73:@5512.4]
  wire [5:0] mm_instruction_1_io_read_st; // @[instruction_memory.scala 22:73:@5512.4]
  wire [8:0] mm_instruction_1_io_read_si; // @[instruction_memory.scala 22:73:@5512.4]
  wire [1:0] mm_instruction_1_io_read_dt; // @[instruction_memory.scala 22:73:@5512.4]
  wire [2:0] mm_instruction_1_io_read_di; // @[instruction_memory.scala 22:73:@5512.4]
  wire [3:0] mm_instruction_1_io_read_oci; // @[instruction_memory.scala 22:73:@5512.4]
  wire [1:0] mm_instruction_1_io_read_oct; // @[instruction_memory.scala 22:73:@5512.4]
  wire [3:0] mm_instruction_1_io_read_icd; // @[instruction_memory.scala 22:73:@5512.4]
  wire [15:0] mm_instruction_1_io_read_pum; // @[instruction_memory.scala 22:73:@5512.4]
  wire [31:0] mm_instruction_1_io_read_immediate; // @[instruction_memory.scala 22:73:@5512.4]
  wire [15:0] mm_instruction_1_io_read_ptm; // @[instruction_memory.scala 22:73:@5512.4]
  wire [5:0] mm_instruction_1_io_read_ici; // @[instruction_memory.scala 22:73:@5512.4]
  wire [1:0] mm_instruction_1_io_read_ictb; // @[instruction_memory.scala 22:73:@5512.4]
  wire [3:0] mm_instruction_1_io_read_ictv; // @[instruction_memory.scala 22:73:@5512.4]
  wire [127:0] mm_instruction_1_io_write; // @[instruction_memory.scala 22:73:@5512.4]
  wire  mm_instruction_2_clock; // @[instruction_memory.scala 22:73:@5515.4]
  wire  mm_instruction_2_io_enable; // @[instruction_memory.scala 22:73:@5515.4]
  wire  mm_instruction_2_io_read_vi; // @[instruction_memory.scala 22:73:@5515.4]
  wire [5:0] mm_instruction_2_io_read_op; // @[instruction_memory.scala 22:73:@5515.4]
  wire [5:0] mm_instruction_2_io_read_st; // @[instruction_memory.scala 22:73:@5515.4]
  wire [8:0] mm_instruction_2_io_read_si; // @[instruction_memory.scala 22:73:@5515.4]
  wire [1:0] mm_instruction_2_io_read_dt; // @[instruction_memory.scala 22:73:@5515.4]
  wire [2:0] mm_instruction_2_io_read_di; // @[instruction_memory.scala 22:73:@5515.4]
  wire [3:0] mm_instruction_2_io_read_oci; // @[instruction_memory.scala 22:73:@5515.4]
  wire [1:0] mm_instruction_2_io_read_oct; // @[instruction_memory.scala 22:73:@5515.4]
  wire [3:0] mm_instruction_2_io_read_icd; // @[instruction_memory.scala 22:73:@5515.4]
  wire [15:0] mm_instruction_2_io_read_pum; // @[instruction_memory.scala 22:73:@5515.4]
  wire [31:0] mm_instruction_2_io_read_immediate; // @[instruction_memory.scala 22:73:@5515.4]
  wire [15:0] mm_instruction_2_io_read_ptm; // @[instruction_memory.scala 22:73:@5515.4]
  wire [5:0] mm_instruction_2_io_read_ici; // @[instruction_memory.scala 22:73:@5515.4]
  wire [1:0] mm_instruction_2_io_read_ictb; // @[instruction_memory.scala 22:73:@5515.4]
  wire [3:0] mm_instruction_2_io_read_ictv; // @[instruction_memory.scala 22:73:@5515.4]
  wire [127:0] mm_instruction_2_io_write; // @[instruction_memory.scala 22:73:@5515.4]
  wire  mm_instruction_3_clock; // @[instruction_memory.scala 22:73:@5518.4]
  wire  mm_instruction_3_io_enable; // @[instruction_memory.scala 22:73:@5518.4]
  wire  mm_instruction_3_io_read_vi; // @[instruction_memory.scala 22:73:@5518.4]
  wire [5:0] mm_instruction_3_io_read_op; // @[instruction_memory.scala 22:73:@5518.4]
  wire [5:0] mm_instruction_3_io_read_st; // @[instruction_memory.scala 22:73:@5518.4]
  wire [8:0] mm_instruction_3_io_read_si; // @[instruction_memory.scala 22:73:@5518.4]
  wire [1:0] mm_instruction_3_io_read_dt; // @[instruction_memory.scala 22:73:@5518.4]
  wire [2:0] mm_instruction_3_io_read_di; // @[instruction_memory.scala 22:73:@5518.4]
  wire [3:0] mm_instruction_3_io_read_oci; // @[instruction_memory.scala 22:73:@5518.4]
  wire [1:0] mm_instruction_3_io_read_oct; // @[instruction_memory.scala 22:73:@5518.4]
  wire [3:0] mm_instruction_3_io_read_icd; // @[instruction_memory.scala 22:73:@5518.4]
  wire [15:0] mm_instruction_3_io_read_pum; // @[instruction_memory.scala 22:73:@5518.4]
  wire [31:0] mm_instruction_3_io_read_immediate; // @[instruction_memory.scala 22:73:@5518.4]
  wire [15:0] mm_instruction_3_io_read_ptm; // @[instruction_memory.scala 22:73:@5518.4]
  wire [5:0] mm_instruction_3_io_read_ici; // @[instruction_memory.scala 22:73:@5518.4]
  wire [1:0] mm_instruction_3_io_read_ictb; // @[instruction_memory.scala 22:73:@5518.4]
  wire [3:0] mm_instruction_3_io_read_ictv; // @[instruction_memory.scala 22:73:@5518.4]
  wire [127:0] mm_instruction_3_io_write; // @[instruction_memory.scala 22:73:@5518.4]
  wire  mm_instruction_4_clock; // @[instruction_memory.scala 22:73:@5521.4]
  wire  mm_instruction_4_io_enable; // @[instruction_memory.scala 22:73:@5521.4]
  wire  mm_instruction_4_io_read_vi; // @[instruction_memory.scala 22:73:@5521.4]
  wire [5:0] mm_instruction_4_io_read_op; // @[instruction_memory.scala 22:73:@5521.4]
  wire [5:0] mm_instruction_4_io_read_st; // @[instruction_memory.scala 22:73:@5521.4]
  wire [8:0] mm_instruction_4_io_read_si; // @[instruction_memory.scala 22:73:@5521.4]
  wire [1:0] mm_instruction_4_io_read_dt; // @[instruction_memory.scala 22:73:@5521.4]
  wire [2:0] mm_instruction_4_io_read_di; // @[instruction_memory.scala 22:73:@5521.4]
  wire [3:0] mm_instruction_4_io_read_oci; // @[instruction_memory.scala 22:73:@5521.4]
  wire [1:0] mm_instruction_4_io_read_oct; // @[instruction_memory.scala 22:73:@5521.4]
  wire [3:0] mm_instruction_4_io_read_icd; // @[instruction_memory.scala 22:73:@5521.4]
  wire [15:0] mm_instruction_4_io_read_pum; // @[instruction_memory.scala 22:73:@5521.4]
  wire [31:0] mm_instruction_4_io_read_immediate; // @[instruction_memory.scala 22:73:@5521.4]
  wire [15:0] mm_instruction_4_io_read_ptm; // @[instruction_memory.scala 22:73:@5521.4]
  wire [5:0] mm_instruction_4_io_read_ici; // @[instruction_memory.scala 22:73:@5521.4]
  wire [1:0] mm_instruction_4_io_read_ictb; // @[instruction_memory.scala 22:73:@5521.4]
  wire [3:0] mm_instruction_4_io_read_ictv; // @[instruction_memory.scala 22:73:@5521.4]
  wire [127:0] mm_instruction_4_io_write; // @[instruction_memory.scala 22:73:@5521.4]
  wire  mm_instruction_5_clock; // @[instruction_memory.scala 22:73:@5524.4]
  wire  mm_instruction_5_io_enable; // @[instruction_memory.scala 22:73:@5524.4]
  wire  mm_instruction_5_io_read_vi; // @[instruction_memory.scala 22:73:@5524.4]
  wire [5:0] mm_instruction_5_io_read_op; // @[instruction_memory.scala 22:73:@5524.4]
  wire [5:0] mm_instruction_5_io_read_st; // @[instruction_memory.scala 22:73:@5524.4]
  wire [8:0] mm_instruction_5_io_read_si; // @[instruction_memory.scala 22:73:@5524.4]
  wire [1:0] mm_instruction_5_io_read_dt; // @[instruction_memory.scala 22:73:@5524.4]
  wire [2:0] mm_instruction_5_io_read_di; // @[instruction_memory.scala 22:73:@5524.4]
  wire [3:0] mm_instruction_5_io_read_oci; // @[instruction_memory.scala 22:73:@5524.4]
  wire [1:0] mm_instruction_5_io_read_oct; // @[instruction_memory.scala 22:73:@5524.4]
  wire [3:0] mm_instruction_5_io_read_icd; // @[instruction_memory.scala 22:73:@5524.4]
  wire [15:0] mm_instruction_5_io_read_pum; // @[instruction_memory.scala 22:73:@5524.4]
  wire [31:0] mm_instruction_5_io_read_immediate; // @[instruction_memory.scala 22:73:@5524.4]
  wire [15:0] mm_instruction_5_io_read_ptm; // @[instruction_memory.scala 22:73:@5524.4]
  wire [5:0] mm_instruction_5_io_read_ici; // @[instruction_memory.scala 22:73:@5524.4]
  wire [1:0] mm_instruction_5_io_read_ictb; // @[instruction_memory.scala 22:73:@5524.4]
  wire [3:0] mm_instruction_5_io_read_ictv; // @[instruction_memory.scala 22:73:@5524.4]
  wire [127:0] mm_instruction_5_io_write; // @[instruction_memory.scala 22:73:@5524.4]
  wire  mm_instruction_6_clock; // @[instruction_memory.scala 22:73:@5527.4]
  wire  mm_instruction_6_io_enable; // @[instruction_memory.scala 22:73:@5527.4]
  wire  mm_instruction_6_io_read_vi; // @[instruction_memory.scala 22:73:@5527.4]
  wire [5:0] mm_instruction_6_io_read_op; // @[instruction_memory.scala 22:73:@5527.4]
  wire [5:0] mm_instruction_6_io_read_st; // @[instruction_memory.scala 22:73:@5527.4]
  wire [8:0] mm_instruction_6_io_read_si; // @[instruction_memory.scala 22:73:@5527.4]
  wire [1:0] mm_instruction_6_io_read_dt; // @[instruction_memory.scala 22:73:@5527.4]
  wire [2:0] mm_instruction_6_io_read_di; // @[instruction_memory.scala 22:73:@5527.4]
  wire [3:0] mm_instruction_6_io_read_oci; // @[instruction_memory.scala 22:73:@5527.4]
  wire [1:0] mm_instruction_6_io_read_oct; // @[instruction_memory.scala 22:73:@5527.4]
  wire [3:0] mm_instruction_6_io_read_icd; // @[instruction_memory.scala 22:73:@5527.4]
  wire [15:0] mm_instruction_6_io_read_pum; // @[instruction_memory.scala 22:73:@5527.4]
  wire [31:0] mm_instruction_6_io_read_immediate; // @[instruction_memory.scala 22:73:@5527.4]
  wire [15:0] mm_instruction_6_io_read_ptm; // @[instruction_memory.scala 22:73:@5527.4]
  wire [5:0] mm_instruction_6_io_read_ici; // @[instruction_memory.scala 22:73:@5527.4]
  wire [1:0] mm_instruction_6_io_read_ictb; // @[instruction_memory.scala 22:73:@5527.4]
  wire [3:0] mm_instruction_6_io_read_ictv; // @[instruction_memory.scala 22:73:@5527.4]
  wire [127:0] mm_instruction_6_io_write; // @[instruction_memory.scala 22:73:@5527.4]
  wire  mm_instruction_7_clock; // @[instruction_memory.scala 22:73:@5530.4]
  wire  mm_instruction_7_io_enable; // @[instruction_memory.scala 22:73:@5530.4]
  wire  mm_instruction_7_io_read_vi; // @[instruction_memory.scala 22:73:@5530.4]
  wire [5:0] mm_instruction_7_io_read_op; // @[instruction_memory.scala 22:73:@5530.4]
  wire [5:0] mm_instruction_7_io_read_st; // @[instruction_memory.scala 22:73:@5530.4]
  wire [8:0] mm_instruction_7_io_read_si; // @[instruction_memory.scala 22:73:@5530.4]
  wire [1:0] mm_instruction_7_io_read_dt; // @[instruction_memory.scala 22:73:@5530.4]
  wire [2:0] mm_instruction_7_io_read_di; // @[instruction_memory.scala 22:73:@5530.4]
  wire [3:0] mm_instruction_7_io_read_oci; // @[instruction_memory.scala 22:73:@5530.4]
  wire [1:0] mm_instruction_7_io_read_oct; // @[instruction_memory.scala 22:73:@5530.4]
  wire [3:0] mm_instruction_7_io_read_icd; // @[instruction_memory.scala 22:73:@5530.4]
  wire [15:0] mm_instruction_7_io_read_pum; // @[instruction_memory.scala 22:73:@5530.4]
  wire [31:0] mm_instruction_7_io_read_immediate; // @[instruction_memory.scala 22:73:@5530.4]
  wire [15:0] mm_instruction_7_io_read_ptm; // @[instruction_memory.scala 22:73:@5530.4]
  wire [5:0] mm_instruction_7_io_read_ici; // @[instruction_memory.scala 22:73:@5530.4]
  wire [1:0] mm_instruction_7_io_read_ictb; // @[instruction_memory.scala 22:73:@5530.4]
  wire [3:0] mm_instruction_7_io_read_ictv; // @[instruction_memory.scala 22:73:@5530.4]
  wire [127:0] mm_instruction_7_io_write; // @[instruction_memory.scala 22:73:@5530.4]
  wire  mm_instruction_8_clock; // @[instruction_memory.scala 22:73:@5533.4]
  wire  mm_instruction_8_io_enable; // @[instruction_memory.scala 22:73:@5533.4]
  wire  mm_instruction_8_io_read_vi; // @[instruction_memory.scala 22:73:@5533.4]
  wire [5:0] mm_instruction_8_io_read_op; // @[instruction_memory.scala 22:73:@5533.4]
  wire [5:0] mm_instruction_8_io_read_st; // @[instruction_memory.scala 22:73:@5533.4]
  wire [8:0] mm_instruction_8_io_read_si; // @[instruction_memory.scala 22:73:@5533.4]
  wire [1:0] mm_instruction_8_io_read_dt; // @[instruction_memory.scala 22:73:@5533.4]
  wire [2:0] mm_instruction_8_io_read_di; // @[instruction_memory.scala 22:73:@5533.4]
  wire [3:0] mm_instruction_8_io_read_oci; // @[instruction_memory.scala 22:73:@5533.4]
  wire [1:0] mm_instruction_8_io_read_oct; // @[instruction_memory.scala 22:73:@5533.4]
  wire [3:0] mm_instruction_8_io_read_icd; // @[instruction_memory.scala 22:73:@5533.4]
  wire [15:0] mm_instruction_8_io_read_pum; // @[instruction_memory.scala 22:73:@5533.4]
  wire [31:0] mm_instruction_8_io_read_immediate; // @[instruction_memory.scala 22:73:@5533.4]
  wire [15:0] mm_instruction_8_io_read_ptm; // @[instruction_memory.scala 22:73:@5533.4]
  wire [5:0] mm_instruction_8_io_read_ici; // @[instruction_memory.scala 22:73:@5533.4]
  wire [1:0] mm_instruction_8_io_read_ictb; // @[instruction_memory.scala 22:73:@5533.4]
  wire [3:0] mm_instruction_8_io_read_ictv; // @[instruction_memory.scala 22:73:@5533.4]
  wire [127:0] mm_instruction_8_io_write; // @[instruction_memory.scala 22:73:@5533.4]
  wire  mm_instruction_9_clock; // @[instruction_memory.scala 22:73:@5536.4]
  wire  mm_instruction_9_io_enable; // @[instruction_memory.scala 22:73:@5536.4]
  wire  mm_instruction_9_io_read_vi; // @[instruction_memory.scala 22:73:@5536.4]
  wire [5:0] mm_instruction_9_io_read_op; // @[instruction_memory.scala 22:73:@5536.4]
  wire [5:0] mm_instruction_9_io_read_st; // @[instruction_memory.scala 22:73:@5536.4]
  wire [8:0] mm_instruction_9_io_read_si; // @[instruction_memory.scala 22:73:@5536.4]
  wire [1:0] mm_instruction_9_io_read_dt; // @[instruction_memory.scala 22:73:@5536.4]
  wire [2:0] mm_instruction_9_io_read_di; // @[instruction_memory.scala 22:73:@5536.4]
  wire [3:0] mm_instruction_9_io_read_oci; // @[instruction_memory.scala 22:73:@5536.4]
  wire [1:0] mm_instruction_9_io_read_oct; // @[instruction_memory.scala 22:73:@5536.4]
  wire [3:0] mm_instruction_9_io_read_icd; // @[instruction_memory.scala 22:73:@5536.4]
  wire [15:0] mm_instruction_9_io_read_pum; // @[instruction_memory.scala 22:73:@5536.4]
  wire [31:0] mm_instruction_9_io_read_immediate; // @[instruction_memory.scala 22:73:@5536.4]
  wire [15:0] mm_instruction_9_io_read_ptm; // @[instruction_memory.scala 22:73:@5536.4]
  wire [5:0] mm_instruction_9_io_read_ici; // @[instruction_memory.scala 22:73:@5536.4]
  wire [1:0] mm_instruction_9_io_read_ictb; // @[instruction_memory.scala 22:73:@5536.4]
  wire [3:0] mm_instruction_9_io_read_ictv; // @[instruction_memory.scala 22:73:@5536.4]
  wire [127:0] mm_instruction_9_io_write; // @[instruction_memory.scala 22:73:@5536.4]
  wire  mm_instruction_10_clock; // @[instruction_memory.scala 22:73:@5539.4]
  wire  mm_instruction_10_io_enable; // @[instruction_memory.scala 22:73:@5539.4]
  wire  mm_instruction_10_io_read_vi; // @[instruction_memory.scala 22:73:@5539.4]
  wire [5:0] mm_instruction_10_io_read_op; // @[instruction_memory.scala 22:73:@5539.4]
  wire [5:0] mm_instruction_10_io_read_st; // @[instruction_memory.scala 22:73:@5539.4]
  wire [8:0] mm_instruction_10_io_read_si; // @[instruction_memory.scala 22:73:@5539.4]
  wire [1:0] mm_instruction_10_io_read_dt; // @[instruction_memory.scala 22:73:@5539.4]
  wire [2:0] mm_instruction_10_io_read_di; // @[instruction_memory.scala 22:73:@5539.4]
  wire [3:0] mm_instruction_10_io_read_oci; // @[instruction_memory.scala 22:73:@5539.4]
  wire [1:0] mm_instruction_10_io_read_oct; // @[instruction_memory.scala 22:73:@5539.4]
  wire [3:0] mm_instruction_10_io_read_icd; // @[instruction_memory.scala 22:73:@5539.4]
  wire [15:0] mm_instruction_10_io_read_pum; // @[instruction_memory.scala 22:73:@5539.4]
  wire [31:0] mm_instruction_10_io_read_immediate; // @[instruction_memory.scala 22:73:@5539.4]
  wire [15:0] mm_instruction_10_io_read_ptm; // @[instruction_memory.scala 22:73:@5539.4]
  wire [5:0] mm_instruction_10_io_read_ici; // @[instruction_memory.scala 22:73:@5539.4]
  wire [1:0] mm_instruction_10_io_read_ictb; // @[instruction_memory.scala 22:73:@5539.4]
  wire [3:0] mm_instruction_10_io_read_ictv; // @[instruction_memory.scala 22:73:@5539.4]
  wire [127:0] mm_instruction_10_io_write; // @[instruction_memory.scala 22:73:@5539.4]
  wire  mm_instruction_11_clock; // @[instruction_memory.scala 22:73:@5542.4]
  wire  mm_instruction_11_io_enable; // @[instruction_memory.scala 22:73:@5542.4]
  wire  mm_instruction_11_io_read_vi; // @[instruction_memory.scala 22:73:@5542.4]
  wire [5:0] mm_instruction_11_io_read_op; // @[instruction_memory.scala 22:73:@5542.4]
  wire [5:0] mm_instruction_11_io_read_st; // @[instruction_memory.scala 22:73:@5542.4]
  wire [8:0] mm_instruction_11_io_read_si; // @[instruction_memory.scala 22:73:@5542.4]
  wire [1:0] mm_instruction_11_io_read_dt; // @[instruction_memory.scala 22:73:@5542.4]
  wire [2:0] mm_instruction_11_io_read_di; // @[instruction_memory.scala 22:73:@5542.4]
  wire [3:0] mm_instruction_11_io_read_oci; // @[instruction_memory.scala 22:73:@5542.4]
  wire [1:0] mm_instruction_11_io_read_oct; // @[instruction_memory.scala 22:73:@5542.4]
  wire [3:0] mm_instruction_11_io_read_icd; // @[instruction_memory.scala 22:73:@5542.4]
  wire [15:0] mm_instruction_11_io_read_pum; // @[instruction_memory.scala 22:73:@5542.4]
  wire [31:0] mm_instruction_11_io_read_immediate; // @[instruction_memory.scala 22:73:@5542.4]
  wire [15:0] mm_instruction_11_io_read_ptm; // @[instruction_memory.scala 22:73:@5542.4]
  wire [5:0] mm_instruction_11_io_read_ici; // @[instruction_memory.scala 22:73:@5542.4]
  wire [1:0] mm_instruction_11_io_read_ictb; // @[instruction_memory.scala 22:73:@5542.4]
  wire [3:0] mm_instruction_11_io_read_ictv; // @[instruction_memory.scala 22:73:@5542.4]
  wire [127:0] mm_instruction_11_io_write; // @[instruction_memory.scala 22:73:@5542.4]
  wire  mm_instruction_12_clock; // @[instruction_memory.scala 22:73:@5545.4]
  wire  mm_instruction_12_io_enable; // @[instruction_memory.scala 22:73:@5545.4]
  wire  mm_instruction_12_io_read_vi; // @[instruction_memory.scala 22:73:@5545.4]
  wire [5:0] mm_instruction_12_io_read_op; // @[instruction_memory.scala 22:73:@5545.4]
  wire [5:0] mm_instruction_12_io_read_st; // @[instruction_memory.scala 22:73:@5545.4]
  wire [8:0] mm_instruction_12_io_read_si; // @[instruction_memory.scala 22:73:@5545.4]
  wire [1:0] mm_instruction_12_io_read_dt; // @[instruction_memory.scala 22:73:@5545.4]
  wire [2:0] mm_instruction_12_io_read_di; // @[instruction_memory.scala 22:73:@5545.4]
  wire [3:0] mm_instruction_12_io_read_oci; // @[instruction_memory.scala 22:73:@5545.4]
  wire [1:0] mm_instruction_12_io_read_oct; // @[instruction_memory.scala 22:73:@5545.4]
  wire [3:0] mm_instruction_12_io_read_icd; // @[instruction_memory.scala 22:73:@5545.4]
  wire [15:0] mm_instruction_12_io_read_pum; // @[instruction_memory.scala 22:73:@5545.4]
  wire [31:0] mm_instruction_12_io_read_immediate; // @[instruction_memory.scala 22:73:@5545.4]
  wire [15:0] mm_instruction_12_io_read_ptm; // @[instruction_memory.scala 22:73:@5545.4]
  wire [5:0] mm_instruction_12_io_read_ici; // @[instruction_memory.scala 22:73:@5545.4]
  wire [1:0] mm_instruction_12_io_read_ictb; // @[instruction_memory.scala 22:73:@5545.4]
  wire [3:0] mm_instruction_12_io_read_ictv; // @[instruction_memory.scala 22:73:@5545.4]
  wire [127:0] mm_instruction_12_io_write; // @[instruction_memory.scala 22:73:@5545.4]
  wire  mm_instruction_13_clock; // @[instruction_memory.scala 22:73:@5548.4]
  wire  mm_instruction_13_io_enable; // @[instruction_memory.scala 22:73:@5548.4]
  wire  mm_instruction_13_io_read_vi; // @[instruction_memory.scala 22:73:@5548.4]
  wire [5:0] mm_instruction_13_io_read_op; // @[instruction_memory.scala 22:73:@5548.4]
  wire [5:0] mm_instruction_13_io_read_st; // @[instruction_memory.scala 22:73:@5548.4]
  wire [8:0] mm_instruction_13_io_read_si; // @[instruction_memory.scala 22:73:@5548.4]
  wire [1:0] mm_instruction_13_io_read_dt; // @[instruction_memory.scala 22:73:@5548.4]
  wire [2:0] mm_instruction_13_io_read_di; // @[instruction_memory.scala 22:73:@5548.4]
  wire [3:0] mm_instruction_13_io_read_oci; // @[instruction_memory.scala 22:73:@5548.4]
  wire [1:0] mm_instruction_13_io_read_oct; // @[instruction_memory.scala 22:73:@5548.4]
  wire [3:0] mm_instruction_13_io_read_icd; // @[instruction_memory.scala 22:73:@5548.4]
  wire [15:0] mm_instruction_13_io_read_pum; // @[instruction_memory.scala 22:73:@5548.4]
  wire [31:0] mm_instruction_13_io_read_immediate; // @[instruction_memory.scala 22:73:@5548.4]
  wire [15:0] mm_instruction_13_io_read_ptm; // @[instruction_memory.scala 22:73:@5548.4]
  wire [5:0] mm_instruction_13_io_read_ici; // @[instruction_memory.scala 22:73:@5548.4]
  wire [1:0] mm_instruction_13_io_read_ictb; // @[instruction_memory.scala 22:73:@5548.4]
  wire [3:0] mm_instruction_13_io_read_ictv; // @[instruction_memory.scala 22:73:@5548.4]
  wire [127:0] mm_instruction_13_io_write; // @[instruction_memory.scala 22:73:@5548.4]
  wire  mm_instruction_14_clock; // @[instruction_memory.scala 22:73:@5551.4]
  wire  mm_instruction_14_io_enable; // @[instruction_memory.scala 22:73:@5551.4]
  wire  mm_instruction_14_io_read_vi; // @[instruction_memory.scala 22:73:@5551.4]
  wire [5:0] mm_instruction_14_io_read_op; // @[instruction_memory.scala 22:73:@5551.4]
  wire [5:0] mm_instruction_14_io_read_st; // @[instruction_memory.scala 22:73:@5551.4]
  wire [8:0] mm_instruction_14_io_read_si; // @[instruction_memory.scala 22:73:@5551.4]
  wire [1:0] mm_instruction_14_io_read_dt; // @[instruction_memory.scala 22:73:@5551.4]
  wire [2:0] mm_instruction_14_io_read_di; // @[instruction_memory.scala 22:73:@5551.4]
  wire [3:0] mm_instruction_14_io_read_oci; // @[instruction_memory.scala 22:73:@5551.4]
  wire [1:0] mm_instruction_14_io_read_oct; // @[instruction_memory.scala 22:73:@5551.4]
  wire [3:0] mm_instruction_14_io_read_icd; // @[instruction_memory.scala 22:73:@5551.4]
  wire [15:0] mm_instruction_14_io_read_pum; // @[instruction_memory.scala 22:73:@5551.4]
  wire [31:0] mm_instruction_14_io_read_immediate; // @[instruction_memory.scala 22:73:@5551.4]
  wire [15:0] mm_instruction_14_io_read_ptm; // @[instruction_memory.scala 22:73:@5551.4]
  wire [5:0] mm_instruction_14_io_read_ici; // @[instruction_memory.scala 22:73:@5551.4]
  wire [1:0] mm_instruction_14_io_read_ictb; // @[instruction_memory.scala 22:73:@5551.4]
  wire [3:0] mm_instruction_14_io_read_ictv; // @[instruction_memory.scala 22:73:@5551.4]
  wire [127:0] mm_instruction_14_io_write; // @[instruction_memory.scala 22:73:@5551.4]
  wire  mm_instruction_15_clock; // @[instruction_memory.scala 22:73:@5554.4]
  wire  mm_instruction_15_io_enable; // @[instruction_memory.scala 22:73:@5554.4]
  wire  mm_instruction_15_io_read_vi; // @[instruction_memory.scala 22:73:@5554.4]
  wire [5:0] mm_instruction_15_io_read_op; // @[instruction_memory.scala 22:73:@5554.4]
  wire [5:0] mm_instruction_15_io_read_st; // @[instruction_memory.scala 22:73:@5554.4]
  wire [8:0] mm_instruction_15_io_read_si; // @[instruction_memory.scala 22:73:@5554.4]
  wire [1:0] mm_instruction_15_io_read_dt; // @[instruction_memory.scala 22:73:@5554.4]
  wire [2:0] mm_instruction_15_io_read_di; // @[instruction_memory.scala 22:73:@5554.4]
  wire [3:0] mm_instruction_15_io_read_oci; // @[instruction_memory.scala 22:73:@5554.4]
  wire [1:0] mm_instruction_15_io_read_oct; // @[instruction_memory.scala 22:73:@5554.4]
  wire [3:0] mm_instruction_15_io_read_icd; // @[instruction_memory.scala 22:73:@5554.4]
  wire [15:0] mm_instruction_15_io_read_pum; // @[instruction_memory.scala 22:73:@5554.4]
  wire [31:0] mm_instruction_15_io_read_immediate; // @[instruction_memory.scala 22:73:@5554.4]
  wire [15:0] mm_instruction_15_io_read_ptm; // @[instruction_memory.scala 22:73:@5554.4]
  wire [5:0] mm_instruction_15_io_read_ici; // @[instruction_memory.scala 22:73:@5554.4]
  wire [1:0] mm_instruction_15_io_read_ictb; // @[instruction_memory.scala 22:73:@5554.4]
  wire [3:0] mm_instruction_15_io_read_ictv; // @[instruction_memory.scala 22:73:@5554.4]
  wire [127:0] mm_instruction_15_io_write; // @[instruction_memory.scala 22:73:@5554.4]
  wire [27:0] _T_214; // @[instruction_memory.scala 38:35:@5944.4]
  wire [1:0] word_write_index; // @[instruction_memory.scala 41:34:@5946.4]
  wire  _T_237; // @[instruction_memory.scala 71:43:@5986.4]
  wire [3:0] instruction_write_index; // @[instruction_memory.scala 24:37:@5846.4 instruction_memory.scala 37:27:@5945.4]
  wire  _T_239; // @[instruction_memory.scala 71:81:@5987.4]
  wire  mm_instruction_16_0_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5574.4]
  wire [5:0] mm_instruction_16_0_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5573.4]
  wire [5:0] mm_instruction_16_0_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5572.4]
  wire [8:0] mm_instruction_16_0_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5571.4]
  wire [1:0] mm_instruction_16_0_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5570.4]
  wire [2:0] mm_instruction_16_0_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5569.4]
  wire [3:0] mm_instruction_16_0_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5568.4]
  wire [1:0] mm_instruction_16_0_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5567.4]
  wire [3:0] mm_instruction_16_0_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5566.4]
  wire [15:0] mm_instruction_16_0_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5565.4]
  wire [31:0] mm_instruction_16_0_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5564.4]
  wire [15:0] mm_instruction_16_0_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5563.4]
  wire [5:0] mm_instruction_16_0_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5562.4]
  wire [1:0] mm_instruction_16_0_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5561.4]
  wire [3:0] mm_instruction_16_0_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5560.4]
  wire  _T_325; // @[instruction_memory.scala 79:51:@6068.6]
  wire [31:0] mm_instruction_16_15_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5834.4]
  wire [31:0] mm_instruction_16_14_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5816.4]
  wire [31:0] mm_instruction_16_13_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5798.4]
  wire [31:0] mm_instruction_16_12_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5780.4]
  wire [31:0] mm_instruction_16_11_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5762.4]
  wire [31:0] mm_instruction_16_10_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5744.4]
  wire [31:0] mm_instruction_16_9_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5726.4]
  wire [31:0] mm_instruction_16_8_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5708.4]
  wire [31:0] mm_instruction_16_7_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5690.4]
  wire [31:0] mm_instruction_16_6_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5672.4]
  wire [31:0] mm_instruction_16_5_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5654.4]
  wire [31:0] mm_instruction_16_4_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5636.4]
  wire [31:0] mm_instruction_16_3_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5618.4]
  wire [31:0] mm_instruction_16_2_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5600.4]
  wire [31:0] mm_instruction_16_1_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5582.4]
  wire [31:0] _GEN_328; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_346; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_364; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_382; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_400; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_418; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_436; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_454; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_472; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_490; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_508; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_526; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_544; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_562; // @[Cat.scala 30:58:@6052.6]
  wire [31:0] _GEN_580; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] mm_instruction_16_15_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5830.4]
  wire [3:0] mm_instruction_16_14_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5812.4]
  wire [3:0] mm_instruction_16_13_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5794.4]
  wire [3:0] mm_instruction_16_12_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5776.4]
  wire [3:0] mm_instruction_16_11_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5758.4]
  wire [3:0] mm_instruction_16_10_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5740.4]
  wire [3:0] mm_instruction_16_9_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5722.4]
  wire [3:0] mm_instruction_16_8_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5704.4]
  wire [3:0] mm_instruction_16_7_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5686.4]
  wire [3:0] mm_instruction_16_6_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5668.4]
  wire [3:0] mm_instruction_16_5_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5650.4]
  wire [3:0] mm_instruction_16_4_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5632.4]
  wire [3:0] mm_instruction_16_3_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5614.4]
  wire [3:0] mm_instruction_16_2_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5596.4]
  wire [3:0] mm_instruction_16_1_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5578.4]
  wire [3:0] _GEN_332; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_350; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_368; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_386; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_404; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_422; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_440; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_458; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_476; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_494; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_512; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_530; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_548; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_566; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_584; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] mm_instruction_16_15_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5831.4]
  wire [1:0] mm_instruction_16_14_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5813.4]
  wire [1:0] mm_instruction_16_13_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5795.4]
  wire [1:0] mm_instruction_16_12_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5777.4]
  wire [1:0] mm_instruction_16_11_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5759.4]
  wire [1:0] mm_instruction_16_10_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5741.4]
  wire [1:0] mm_instruction_16_9_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5723.4]
  wire [1:0] mm_instruction_16_8_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5705.4]
  wire [1:0] mm_instruction_16_7_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5687.4]
  wire [1:0] mm_instruction_16_6_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5669.4]
  wire [1:0] mm_instruction_16_5_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5651.4]
  wire [1:0] mm_instruction_16_4_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5633.4]
  wire [1:0] mm_instruction_16_3_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5615.4]
  wire [1:0] mm_instruction_16_2_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5597.4]
  wire [1:0] mm_instruction_16_1_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5579.4]
  wire [1:0] _GEN_331; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_349; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_367; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_385; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_403; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_421; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_439; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_457; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_475; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_493; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_511; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_529; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_547; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_565; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_583; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] mm_instruction_16_15_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5832.4]
  wire [5:0] mm_instruction_16_14_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5814.4]
  wire [5:0] mm_instruction_16_13_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5796.4]
  wire [5:0] mm_instruction_16_12_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5778.4]
  wire [5:0] mm_instruction_16_11_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5760.4]
  wire [5:0] mm_instruction_16_10_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5742.4]
  wire [5:0] mm_instruction_16_9_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5724.4]
  wire [5:0] mm_instruction_16_8_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5706.4]
  wire [5:0] mm_instruction_16_7_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5688.4]
  wire [5:0] mm_instruction_16_6_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5670.4]
  wire [5:0] mm_instruction_16_5_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5652.4]
  wire [5:0] mm_instruction_16_4_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5634.4]
  wire [5:0] mm_instruction_16_3_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5616.4]
  wire [5:0] mm_instruction_16_2_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5598.4]
  wire [5:0] mm_instruction_16_1_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5580.4]
  wire [5:0] _GEN_330; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_348; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_366; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_384; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_402; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_420; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_438; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_456; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_474; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_492; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_510; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_528; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_546; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_564; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_582; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] mm_instruction_16_15_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5833.4]
  wire [15:0] mm_instruction_16_14_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5815.4]
  wire [15:0] mm_instruction_16_13_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5797.4]
  wire [15:0] mm_instruction_16_12_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5779.4]
  wire [15:0] mm_instruction_16_11_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5761.4]
  wire [15:0] mm_instruction_16_10_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5743.4]
  wire [15:0] mm_instruction_16_9_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5725.4]
  wire [15:0] mm_instruction_16_8_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5707.4]
  wire [15:0] mm_instruction_16_7_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5689.4]
  wire [15:0] mm_instruction_16_6_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5671.4]
  wire [15:0] mm_instruction_16_5_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5653.4]
  wire [15:0] mm_instruction_16_4_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5635.4]
  wire [15:0] mm_instruction_16_3_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5617.4]
  wire [15:0] mm_instruction_16_2_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5599.4]
  wire [15:0] mm_instruction_16_1_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5581.4]
  wire [15:0] _GEN_329; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_347; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_365; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_383; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_401; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_419; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_437; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_455; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_473; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_491; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_509; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_527; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_545; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_563; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_581; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] mm_instruction_16_15_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5835.4]
  wire [15:0] mm_instruction_16_14_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5817.4]
  wire [15:0] mm_instruction_16_13_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5799.4]
  wire [15:0] mm_instruction_16_12_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5781.4]
  wire [15:0] mm_instruction_16_11_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5763.4]
  wire [15:0] mm_instruction_16_10_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5745.4]
  wire [15:0] mm_instruction_16_9_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5727.4]
  wire [15:0] mm_instruction_16_8_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5709.4]
  wire [15:0] mm_instruction_16_7_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5691.4]
  wire [15:0] mm_instruction_16_6_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5673.4]
  wire [15:0] mm_instruction_16_5_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5655.4]
  wire [15:0] mm_instruction_16_4_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5637.4]
  wire [15:0] mm_instruction_16_3_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5619.4]
  wire [15:0] mm_instruction_16_2_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5601.4]
  wire [15:0] mm_instruction_16_1_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5583.4]
  wire [15:0] _GEN_327; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_345; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_363; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_381; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_399; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_417; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_435; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_453; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_471; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_489; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_507; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_525; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_543; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_561; // @[Cat.scala 30:58:@6052.6]
  wire [15:0] _GEN_579; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] mm_instruction_16_15_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5836.4]
  wire [3:0] mm_instruction_16_14_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5818.4]
  wire [3:0] mm_instruction_16_13_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5800.4]
  wire [3:0] mm_instruction_16_12_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5782.4]
  wire [3:0] mm_instruction_16_11_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5764.4]
  wire [3:0] mm_instruction_16_10_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5746.4]
  wire [3:0] mm_instruction_16_9_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5728.4]
  wire [3:0] mm_instruction_16_8_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5710.4]
  wire [3:0] mm_instruction_16_7_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5692.4]
  wire [3:0] mm_instruction_16_6_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5674.4]
  wire [3:0] mm_instruction_16_5_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5656.4]
  wire [3:0] mm_instruction_16_4_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5638.4]
  wire [3:0] mm_instruction_16_3_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5620.4]
  wire [3:0] mm_instruction_16_2_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5602.4]
  wire [3:0] mm_instruction_16_1_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5584.4]
  wire [3:0] _GEN_326; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_344; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_362; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_380; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_398; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_416; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_434; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_452; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_470; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_488; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_506; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_524; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_542; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_560; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_578; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] mm_instruction_16_15_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5837.4]
  wire [1:0] mm_instruction_16_14_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5819.4]
  wire [1:0] mm_instruction_16_13_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5801.4]
  wire [1:0] mm_instruction_16_12_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5783.4]
  wire [1:0] mm_instruction_16_11_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5765.4]
  wire [1:0] mm_instruction_16_10_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5747.4]
  wire [1:0] mm_instruction_16_9_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5729.4]
  wire [1:0] mm_instruction_16_8_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5711.4]
  wire [1:0] mm_instruction_16_7_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5693.4]
  wire [1:0] mm_instruction_16_6_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5675.4]
  wire [1:0] mm_instruction_16_5_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5657.4]
  wire [1:0] mm_instruction_16_4_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5639.4]
  wire [1:0] mm_instruction_16_3_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5621.4]
  wire [1:0] mm_instruction_16_2_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5603.4]
  wire [1:0] mm_instruction_16_1_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5585.4]
  wire [1:0] _GEN_325; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_343; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_361; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_379; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_397; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_415; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_433; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_451; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_469; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_487; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_505; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_523; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_541; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_559; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_577; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] mm_instruction_16_15_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5838.4]
  wire [3:0] mm_instruction_16_14_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5820.4]
  wire [3:0] mm_instruction_16_13_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5802.4]
  wire [3:0] mm_instruction_16_12_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5784.4]
  wire [3:0] mm_instruction_16_11_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5766.4]
  wire [3:0] mm_instruction_16_10_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5748.4]
  wire [3:0] mm_instruction_16_9_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5730.4]
  wire [3:0] mm_instruction_16_8_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5712.4]
  wire [3:0] mm_instruction_16_7_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5694.4]
  wire [3:0] mm_instruction_16_6_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5676.4]
  wire [3:0] mm_instruction_16_5_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5658.4]
  wire [3:0] mm_instruction_16_4_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5640.4]
  wire [3:0] mm_instruction_16_3_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5622.4]
  wire [3:0] mm_instruction_16_2_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5604.4]
  wire [3:0] mm_instruction_16_1_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5586.4]
  wire [3:0] _GEN_324; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_342; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_360; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_378; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_396; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_414; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_432; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_450; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_468; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_486; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_504; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_522; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_540; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_558; // @[Cat.scala 30:58:@6052.6]
  wire [3:0] _GEN_576; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] mm_instruction_16_15_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5839.4]
  wire [2:0] mm_instruction_16_14_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5821.4]
  wire [2:0] mm_instruction_16_13_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5803.4]
  wire [2:0] mm_instruction_16_12_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5785.4]
  wire [2:0] mm_instruction_16_11_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5767.4]
  wire [2:0] mm_instruction_16_10_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5749.4]
  wire [2:0] mm_instruction_16_9_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5731.4]
  wire [2:0] mm_instruction_16_8_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5713.4]
  wire [2:0] mm_instruction_16_7_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5695.4]
  wire [2:0] mm_instruction_16_6_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5677.4]
  wire [2:0] mm_instruction_16_5_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5659.4]
  wire [2:0] mm_instruction_16_4_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5641.4]
  wire [2:0] mm_instruction_16_3_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5623.4]
  wire [2:0] mm_instruction_16_2_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5605.4]
  wire [2:0] mm_instruction_16_1_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5587.4]
  wire [2:0] _GEN_323; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_341; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_359; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_377; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_395; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_413; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_431; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_449; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_467; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_485; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_503; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_521; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_539; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_557; // @[Cat.scala 30:58:@6052.6]
  wire [2:0] _GEN_575; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] mm_instruction_16_15_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5840.4]
  wire [1:0] mm_instruction_16_14_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5822.4]
  wire [1:0] mm_instruction_16_13_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5804.4]
  wire [1:0] mm_instruction_16_12_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5786.4]
  wire [1:0] mm_instruction_16_11_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5768.4]
  wire [1:0] mm_instruction_16_10_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5750.4]
  wire [1:0] mm_instruction_16_9_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5732.4]
  wire [1:0] mm_instruction_16_8_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5714.4]
  wire [1:0] mm_instruction_16_7_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5696.4]
  wire [1:0] mm_instruction_16_6_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5678.4]
  wire [1:0] mm_instruction_16_5_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5660.4]
  wire [1:0] mm_instruction_16_4_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5642.4]
  wire [1:0] mm_instruction_16_3_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5624.4]
  wire [1:0] mm_instruction_16_2_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5606.4]
  wire [1:0] mm_instruction_16_1_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5588.4]
  wire [1:0] _GEN_322; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_340; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_358; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_376; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_394; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_412; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_430; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_448; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_466; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_484; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_502; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_520; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_538; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_556; // @[Cat.scala 30:58:@6052.6]
  wire [1:0] _GEN_574; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] mm_instruction_16_15_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5841.4]
  wire [8:0] mm_instruction_16_14_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5823.4]
  wire [8:0] mm_instruction_16_13_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5805.4]
  wire [8:0] mm_instruction_16_12_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5787.4]
  wire [8:0] mm_instruction_16_11_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5769.4]
  wire [8:0] mm_instruction_16_10_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5751.4]
  wire [8:0] mm_instruction_16_9_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5733.4]
  wire [8:0] mm_instruction_16_8_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5715.4]
  wire [8:0] mm_instruction_16_7_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5697.4]
  wire [8:0] mm_instruction_16_6_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5679.4]
  wire [8:0] mm_instruction_16_5_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5661.4]
  wire [8:0] mm_instruction_16_4_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5643.4]
  wire [8:0] mm_instruction_16_3_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5625.4]
  wire [8:0] mm_instruction_16_2_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5607.4]
  wire [8:0] mm_instruction_16_1_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5589.4]
  wire [8:0] _GEN_321; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_339; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_357; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_375; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_393; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_411; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_429; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_447; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_465; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_483; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_501; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_519; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_537; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_555; // @[Cat.scala 30:58:@6052.6]
  wire [8:0] _GEN_573; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] mm_instruction_16_15_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5842.4]
  wire [5:0] mm_instruction_16_14_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5824.4]
  wire [5:0] mm_instruction_16_13_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5806.4]
  wire [5:0] mm_instruction_16_12_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5788.4]
  wire [5:0] mm_instruction_16_11_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5770.4]
  wire [5:0] mm_instruction_16_10_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5752.4]
  wire [5:0] mm_instruction_16_9_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5734.4]
  wire [5:0] mm_instruction_16_8_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5716.4]
  wire [5:0] mm_instruction_16_7_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5698.4]
  wire [5:0] mm_instruction_16_6_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5680.4]
  wire [5:0] mm_instruction_16_5_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5662.4]
  wire [5:0] mm_instruction_16_4_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5644.4]
  wire [5:0] mm_instruction_16_3_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5626.4]
  wire [5:0] mm_instruction_16_2_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5608.4]
  wire [5:0] mm_instruction_16_1_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5590.4]
  wire [5:0] _GEN_320; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_338; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_356; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_374; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_392; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_410; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_428; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_446; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_464; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_482; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_500; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_518; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_536; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_554; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_572; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] mm_instruction_16_15_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5843.4]
  wire [5:0] mm_instruction_16_14_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5825.4]
  wire [5:0] mm_instruction_16_13_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5807.4]
  wire [5:0] mm_instruction_16_12_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5789.4]
  wire [5:0] mm_instruction_16_11_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5771.4]
  wire [5:0] mm_instruction_16_10_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5753.4]
  wire [5:0] mm_instruction_16_9_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5735.4]
  wire [5:0] mm_instruction_16_8_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5717.4]
  wire [5:0] mm_instruction_16_7_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5699.4]
  wire [5:0] mm_instruction_16_6_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5681.4]
  wire [5:0] mm_instruction_16_5_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5663.4]
  wire [5:0] mm_instruction_16_4_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5645.4]
  wire [5:0] mm_instruction_16_3_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5627.4]
  wire [5:0] mm_instruction_16_2_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5609.4]
  wire [5:0] mm_instruction_16_1_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5591.4]
  wire [5:0] _GEN_319; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_337; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_355; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_373; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_391; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_409; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_427; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_445; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_463; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_481; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_499; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_517; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_535; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_553; // @[Cat.scala 30:58:@6052.6]
  wire [5:0] _GEN_571; // @[Cat.scala 30:58:@6052.6]
  wire  mm_instruction_16_15_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5844.4]
  wire  mm_instruction_16_14_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5826.4]
  wire  mm_instruction_16_13_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5808.4]
  wire  mm_instruction_16_12_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5790.4]
  wire  mm_instruction_16_11_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5772.4]
  wire  mm_instruction_16_10_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5754.4]
  wire  mm_instruction_16_9_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5736.4]
  wire  mm_instruction_16_8_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5718.4]
  wire  mm_instruction_16_7_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5700.4]
  wire  mm_instruction_16_6_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5682.4]
  wire  mm_instruction_16_5_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5664.4]
  wire  mm_instruction_16_4_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5646.4]
  wire  mm_instruction_16_3_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5628.4]
  wire  mm_instruction_16_2_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5610.4]
  wire  mm_instruction_16_1_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5592.4]
  wire  _GEN_318; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_336; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_354; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_372; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_390; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_408; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_426; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_444; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_462; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_480; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_498; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_516; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_534; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_552; // @[Cat.scala 30:58:@6052.6]
  wire  _GEN_570; // @[Cat.scala 30:58:@6052.6]
  wire [32:0] _T_315; // @[Cat.scala 30:58:@6058.6]
  wire [127:0] _T_323; // @[Cat.scala 30:58:@6066.6]
  wire [127:0] read_instruction; // @[instruction_memory.scala 75:49:@6051.4]
  wire [31:0] _T_326; // @[instruction_memory.scala 81:25:@6069.6]
  wire [31:0] _T_327; // @[instruction_memory.scala 79:40:@6070.6]
  wire [31:0] instruction_words_0; // @[instruction_memory.scala 75:49:@6051.4]
  wire  _T_329; // @[instruction_memory.scala 79:51:@6072.6]
  wire [31:0] _T_330; // @[instruction_memory.scala 81:25:@6073.6]
  wire [31:0] _T_331; // @[instruction_memory.scala 79:40:@6074.6]
  wire [31:0] instruction_words_1; // @[instruction_memory.scala 75:49:@6051.4]
  wire [63:0] _T_236; // @[Cat.scala 30:58:@5984.4]
  wire [127:0] updated_instruction; // @[instruction_memory.scala 66:33:@5983.4 instruction_memory.scala 67:23:@5985.4]
  wire [127:0] _T_335; // @[instruction_memory.scala 84:43:@6077.6]
  wire  _T_243; // @[instruction_memory.scala 71:81:@5991.4]
  wire  _GEN_19; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_20; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_21; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_22; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_23; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_24; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_25; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_26; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_27; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_28; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_29; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_339; // @[instruction_memory.scala 84:43:@6080.6]
  wire  _T_247; // @[instruction_memory.scala 71:81:@5995.4]
  wire  _GEN_37; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_38; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_39; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_40; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_41; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_42; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_43; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_44; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_45; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_46; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_47; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_343; // @[instruction_memory.scala 84:43:@6083.6]
  wire  _T_251; // @[instruction_memory.scala 71:81:@5999.4]
  wire  _GEN_55; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_56; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_57; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_58; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_59; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_60; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_61; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_62; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_63; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_64; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_65; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_347; // @[instruction_memory.scala 84:43:@6086.6]
  wire  _T_255; // @[instruction_memory.scala 71:81:@6003.4]
  wire  _GEN_73; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_74; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_75; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_76; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_77; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_78; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_79; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_80; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_81; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_82; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_83; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_351; // @[instruction_memory.scala 84:43:@6089.6]
  wire  _T_259; // @[instruction_memory.scala 71:81:@6007.4]
  wire  _GEN_91; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_92; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_93; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_94; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_95; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_96; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_97; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_98; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_99; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_100; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_101; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_355; // @[instruction_memory.scala 84:43:@6092.6]
  wire  _T_263; // @[instruction_memory.scala 71:81:@6011.4]
  wire  _GEN_109; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_110; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_111; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_112; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_113; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_114; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_115; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_116; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_117; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_118; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_119; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_359; // @[instruction_memory.scala 84:43:@6095.6]
  wire  _T_267; // @[instruction_memory.scala 71:81:@6015.4]
  wire  _GEN_127; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_128; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_129; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_130; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_131; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_132; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_133; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_134; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_135; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_136; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_137; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_363; // @[instruction_memory.scala 84:43:@6098.6]
  wire  _T_271; // @[instruction_memory.scala 71:81:@6019.4]
  wire  _GEN_145; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_146; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_147; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_148; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_149; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_150; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_151; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_152; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_153; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_154; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_155; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_367; // @[instruction_memory.scala 84:43:@6101.6]
  wire  _T_275; // @[instruction_memory.scala 71:81:@6023.4]
  wire  _GEN_163; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_164; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_165; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_166; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_167; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_168; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_169; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_170; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_171; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_172; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_173; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_371; // @[instruction_memory.scala 84:43:@6104.6]
  wire  _T_279; // @[instruction_memory.scala 71:81:@6027.4]
  wire  _GEN_181; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_182; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_183; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_184; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_185; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_186; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_187; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_188; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_189; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_190; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_191; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_375; // @[instruction_memory.scala 84:43:@6107.6]
  wire  _T_283; // @[instruction_memory.scala 71:81:@6031.4]
  wire  _GEN_199; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_200; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_201; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_202; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_203; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_204; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_205; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_206; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_207; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_208; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_209; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_379; // @[instruction_memory.scala 84:43:@6110.6]
  wire  _T_287; // @[instruction_memory.scala 71:81:@6035.4]
  wire  _GEN_217; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_218; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_219; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_220; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_221; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_222; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_223; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_224; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_225; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_226; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_227; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_383; // @[instruction_memory.scala 84:43:@6113.6]
  wire  _T_291; // @[instruction_memory.scala 71:81:@6039.4]
  wire  _GEN_235; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_236; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_237; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_238; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_239; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_240; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_241; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_242; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_243; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_244; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_245; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_387; // @[instruction_memory.scala 84:43:@6116.6]
  wire  _T_295; // @[instruction_memory.scala 71:81:@6043.4]
  wire  _GEN_253; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_254; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_255; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_256; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_257; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_258; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_259; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_260; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_261; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_262; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_263; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_391; // @[instruction_memory.scala 84:43:@6119.6]
  wire  _T_299; // @[instruction_memory.scala 71:81:@6047.4]
  wire  _GEN_271; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_272; // @[instruction_memory.scala 54:39:@5966.6]
  wire [5:0] _GEN_273; // @[instruction_memory.scala 54:39:@5966.6]
  wire [8:0] _GEN_274; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_275; // @[instruction_memory.scala 54:39:@5966.6]
  wire [2:0] _GEN_276; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_277; // @[instruction_memory.scala 54:39:@5966.6]
  wire [1:0] _GEN_278; // @[instruction_memory.scala 54:39:@5966.6]
  wire [3:0] _GEN_279; // @[instruction_memory.scala 54:39:@5966.6]
  wire [15:0] _GEN_280; // @[instruction_memory.scala 54:39:@5966.6]
  wire [31:0] _GEN_281; // @[instruction_memory.scala 54:39:@5966.6]
  wire [127:0] _T_395; // @[instruction_memory.scala 84:43:@6122.6]
  mm_instruction mm_instruction ( // @[instruction_memory.scala 22:73:@5509.4]
    .clock(mm_instruction_clock),
    .io_enable(mm_instruction_io_enable),
    .io_read_vi(mm_instruction_io_read_vi),
    .io_read_op(mm_instruction_io_read_op),
    .io_read_st(mm_instruction_io_read_st),
    .io_read_si(mm_instruction_io_read_si),
    .io_read_dt(mm_instruction_io_read_dt),
    .io_read_di(mm_instruction_io_read_di),
    .io_read_oci(mm_instruction_io_read_oci),
    .io_read_oct(mm_instruction_io_read_oct),
    .io_read_icd(mm_instruction_io_read_icd),
    .io_read_pum(mm_instruction_io_read_pum),
    .io_read_immediate(mm_instruction_io_read_immediate),
    .io_read_ptm(mm_instruction_io_read_ptm),
    .io_read_ici(mm_instruction_io_read_ici),
    .io_read_ictb(mm_instruction_io_read_ictb),
    .io_read_ictv(mm_instruction_io_read_ictv),
    .io_write(mm_instruction_io_write)
  );
  mm_instruction mm_instruction_1 ( // @[instruction_memory.scala 22:73:@5512.4]
    .clock(mm_instruction_1_clock),
    .io_enable(mm_instruction_1_io_enable),
    .io_read_vi(mm_instruction_1_io_read_vi),
    .io_read_op(mm_instruction_1_io_read_op),
    .io_read_st(mm_instruction_1_io_read_st),
    .io_read_si(mm_instruction_1_io_read_si),
    .io_read_dt(mm_instruction_1_io_read_dt),
    .io_read_di(mm_instruction_1_io_read_di),
    .io_read_oci(mm_instruction_1_io_read_oci),
    .io_read_oct(mm_instruction_1_io_read_oct),
    .io_read_icd(mm_instruction_1_io_read_icd),
    .io_read_pum(mm_instruction_1_io_read_pum),
    .io_read_immediate(mm_instruction_1_io_read_immediate),
    .io_read_ptm(mm_instruction_1_io_read_ptm),
    .io_read_ici(mm_instruction_1_io_read_ici),
    .io_read_ictb(mm_instruction_1_io_read_ictb),
    .io_read_ictv(mm_instruction_1_io_read_ictv),
    .io_write(mm_instruction_1_io_write)
  );
  mm_instruction mm_instruction_2 ( // @[instruction_memory.scala 22:73:@5515.4]
    .clock(mm_instruction_2_clock),
    .io_enable(mm_instruction_2_io_enable),
    .io_read_vi(mm_instruction_2_io_read_vi),
    .io_read_op(mm_instruction_2_io_read_op),
    .io_read_st(mm_instruction_2_io_read_st),
    .io_read_si(mm_instruction_2_io_read_si),
    .io_read_dt(mm_instruction_2_io_read_dt),
    .io_read_di(mm_instruction_2_io_read_di),
    .io_read_oci(mm_instruction_2_io_read_oci),
    .io_read_oct(mm_instruction_2_io_read_oct),
    .io_read_icd(mm_instruction_2_io_read_icd),
    .io_read_pum(mm_instruction_2_io_read_pum),
    .io_read_immediate(mm_instruction_2_io_read_immediate),
    .io_read_ptm(mm_instruction_2_io_read_ptm),
    .io_read_ici(mm_instruction_2_io_read_ici),
    .io_read_ictb(mm_instruction_2_io_read_ictb),
    .io_read_ictv(mm_instruction_2_io_read_ictv),
    .io_write(mm_instruction_2_io_write)
  );
  mm_instruction mm_instruction_3 ( // @[instruction_memory.scala 22:73:@5518.4]
    .clock(mm_instruction_3_clock),
    .io_enable(mm_instruction_3_io_enable),
    .io_read_vi(mm_instruction_3_io_read_vi),
    .io_read_op(mm_instruction_3_io_read_op),
    .io_read_st(mm_instruction_3_io_read_st),
    .io_read_si(mm_instruction_3_io_read_si),
    .io_read_dt(mm_instruction_3_io_read_dt),
    .io_read_di(mm_instruction_3_io_read_di),
    .io_read_oci(mm_instruction_3_io_read_oci),
    .io_read_oct(mm_instruction_3_io_read_oct),
    .io_read_icd(mm_instruction_3_io_read_icd),
    .io_read_pum(mm_instruction_3_io_read_pum),
    .io_read_immediate(mm_instruction_3_io_read_immediate),
    .io_read_ptm(mm_instruction_3_io_read_ptm),
    .io_read_ici(mm_instruction_3_io_read_ici),
    .io_read_ictb(mm_instruction_3_io_read_ictb),
    .io_read_ictv(mm_instruction_3_io_read_ictv),
    .io_write(mm_instruction_3_io_write)
  );
  mm_instruction mm_instruction_4 ( // @[instruction_memory.scala 22:73:@5521.4]
    .clock(mm_instruction_4_clock),
    .io_enable(mm_instruction_4_io_enable),
    .io_read_vi(mm_instruction_4_io_read_vi),
    .io_read_op(mm_instruction_4_io_read_op),
    .io_read_st(mm_instruction_4_io_read_st),
    .io_read_si(mm_instruction_4_io_read_si),
    .io_read_dt(mm_instruction_4_io_read_dt),
    .io_read_di(mm_instruction_4_io_read_di),
    .io_read_oci(mm_instruction_4_io_read_oci),
    .io_read_oct(mm_instruction_4_io_read_oct),
    .io_read_icd(mm_instruction_4_io_read_icd),
    .io_read_pum(mm_instruction_4_io_read_pum),
    .io_read_immediate(mm_instruction_4_io_read_immediate),
    .io_read_ptm(mm_instruction_4_io_read_ptm),
    .io_read_ici(mm_instruction_4_io_read_ici),
    .io_read_ictb(mm_instruction_4_io_read_ictb),
    .io_read_ictv(mm_instruction_4_io_read_ictv),
    .io_write(mm_instruction_4_io_write)
  );
  mm_instruction mm_instruction_5 ( // @[instruction_memory.scala 22:73:@5524.4]
    .clock(mm_instruction_5_clock),
    .io_enable(mm_instruction_5_io_enable),
    .io_read_vi(mm_instruction_5_io_read_vi),
    .io_read_op(mm_instruction_5_io_read_op),
    .io_read_st(mm_instruction_5_io_read_st),
    .io_read_si(mm_instruction_5_io_read_si),
    .io_read_dt(mm_instruction_5_io_read_dt),
    .io_read_di(mm_instruction_5_io_read_di),
    .io_read_oci(mm_instruction_5_io_read_oci),
    .io_read_oct(mm_instruction_5_io_read_oct),
    .io_read_icd(mm_instruction_5_io_read_icd),
    .io_read_pum(mm_instruction_5_io_read_pum),
    .io_read_immediate(mm_instruction_5_io_read_immediate),
    .io_read_ptm(mm_instruction_5_io_read_ptm),
    .io_read_ici(mm_instruction_5_io_read_ici),
    .io_read_ictb(mm_instruction_5_io_read_ictb),
    .io_read_ictv(mm_instruction_5_io_read_ictv),
    .io_write(mm_instruction_5_io_write)
  );
  mm_instruction mm_instruction_6 ( // @[instruction_memory.scala 22:73:@5527.4]
    .clock(mm_instruction_6_clock),
    .io_enable(mm_instruction_6_io_enable),
    .io_read_vi(mm_instruction_6_io_read_vi),
    .io_read_op(mm_instruction_6_io_read_op),
    .io_read_st(mm_instruction_6_io_read_st),
    .io_read_si(mm_instruction_6_io_read_si),
    .io_read_dt(mm_instruction_6_io_read_dt),
    .io_read_di(mm_instruction_6_io_read_di),
    .io_read_oci(mm_instruction_6_io_read_oci),
    .io_read_oct(mm_instruction_6_io_read_oct),
    .io_read_icd(mm_instruction_6_io_read_icd),
    .io_read_pum(mm_instruction_6_io_read_pum),
    .io_read_immediate(mm_instruction_6_io_read_immediate),
    .io_read_ptm(mm_instruction_6_io_read_ptm),
    .io_read_ici(mm_instruction_6_io_read_ici),
    .io_read_ictb(mm_instruction_6_io_read_ictb),
    .io_read_ictv(mm_instruction_6_io_read_ictv),
    .io_write(mm_instruction_6_io_write)
  );
  mm_instruction mm_instruction_7 ( // @[instruction_memory.scala 22:73:@5530.4]
    .clock(mm_instruction_7_clock),
    .io_enable(mm_instruction_7_io_enable),
    .io_read_vi(mm_instruction_7_io_read_vi),
    .io_read_op(mm_instruction_7_io_read_op),
    .io_read_st(mm_instruction_7_io_read_st),
    .io_read_si(mm_instruction_7_io_read_si),
    .io_read_dt(mm_instruction_7_io_read_dt),
    .io_read_di(mm_instruction_7_io_read_di),
    .io_read_oci(mm_instruction_7_io_read_oci),
    .io_read_oct(mm_instruction_7_io_read_oct),
    .io_read_icd(mm_instruction_7_io_read_icd),
    .io_read_pum(mm_instruction_7_io_read_pum),
    .io_read_immediate(mm_instruction_7_io_read_immediate),
    .io_read_ptm(mm_instruction_7_io_read_ptm),
    .io_read_ici(mm_instruction_7_io_read_ici),
    .io_read_ictb(mm_instruction_7_io_read_ictb),
    .io_read_ictv(mm_instruction_7_io_read_ictv),
    .io_write(mm_instruction_7_io_write)
  );
  mm_instruction mm_instruction_8 ( // @[instruction_memory.scala 22:73:@5533.4]
    .clock(mm_instruction_8_clock),
    .io_enable(mm_instruction_8_io_enable),
    .io_read_vi(mm_instruction_8_io_read_vi),
    .io_read_op(mm_instruction_8_io_read_op),
    .io_read_st(mm_instruction_8_io_read_st),
    .io_read_si(mm_instruction_8_io_read_si),
    .io_read_dt(mm_instruction_8_io_read_dt),
    .io_read_di(mm_instruction_8_io_read_di),
    .io_read_oci(mm_instruction_8_io_read_oci),
    .io_read_oct(mm_instruction_8_io_read_oct),
    .io_read_icd(mm_instruction_8_io_read_icd),
    .io_read_pum(mm_instruction_8_io_read_pum),
    .io_read_immediate(mm_instruction_8_io_read_immediate),
    .io_read_ptm(mm_instruction_8_io_read_ptm),
    .io_read_ici(mm_instruction_8_io_read_ici),
    .io_read_ictb(mm_instruction_8_io_read_ictb),
    .io_read_ictv(mm_instruction_8_io_read_ictv),
    .io_write(mm_instruction_8_io_write)
  );
  mm_instruction mm_instruction_9 ( // @[instruction_memory.scala 22:73:@5536.4]
    .clock(mm_instruction_9_clock),
    .io_enable(mm_instruction_9_io_enable),
    .io_read_vi(mm_instruction_9_io_read_vi),
    .io_read_op(mm_instruction_9_io_read_op),
    .io_read_st(mm_instruction_9_io_read_st),
    .io_read_si(mm_instruction_9_io_read_si),
    .io_read_dt(mm_instruction_9_io_read_dt),
    .io_read_di(mm_instruction_9_io_read_di),
    .io_read_oci(mm_instruction_9_io_read_oci),
    .io_read_oct(mm_instruction_9_io_read_oct),
    .io_read_icd(mm_instruction_9_io_read_icd),
    .io_read_pum(mm_instruction_9_io_read_pum),
    .io_read_immediate(mm_instruction_9_io_read_immediate),
    .io_read_ptm(mm_instruction_9_io_read_ptm),
    .io_read_ici(mm_instruction_9_io_read_ici),
    .io_read_ictb(mm_instruction_9_io_read_ictb),
    .io_read_ictv(mm_instruction_9_io_read_ictv),
    .io_write(mm_instruction_9_io_write)
  );
  mm_instruction mm_instruction_10 ( // @[instruction_memory.scala 22:73:@5539.4]
    .clock(mm_instruction_10_clock),
    .io_enable(mm_instruction_10_io_enable),
    .io_read_vi(mm_instruction_10_io_read_vi),
    .io_read_op(mm_instruction_10_io_read_op),
    .io_read_st(mm_instruction_10_io_read_st),
    .io_read_si(mm_instruction_10_io_read_si),
    .io_read_dt(mm_instruction_10_io_read_dt),
    .io_read_di(mm_instruction_10_io_read_di),
    .io_read_oci(mm_instruction_10_io_read_oci),
    .io_read_oct(mm_instruction_10_io_read_oct),
    .io_read_icd(mm_instruction_10_io_read_icd),
    .io_read_pum(mm_instruction_10_io_read_pum),
    .io_read_immediate(mm_instruction_10_io_read_immediate),
    .io_read_ptm(mm_instruction_10_io_read_ptm),
    .io_read_ici(mm_instruction_10_io_read_ici),
    .io_read_ictb(mm_instruction_10_io_read_ictb),
    .io_read_ictv(mm_instruction_10_io_read_ictv),
    .io_write(mm_instruction_10_io_write)
  );
  mm_instruction mm_instruction_11 ( // @[instruction_memory.scala 22:73:@5542.4]
    .clock(mm_instruction_11_clock),
    .io_enable(mm_instruction_11_io_enable),
    .io_read_vi(mm_instruction_11_io_read_vi),
    .io_read_op(mm_instruction_11_io_read_op),
    .io_read_st(mm_instruction_11_io_read_st),
    .io_read_si(mm_instruction_11_io_read_si),
    .io_read_dt(mm_instruction_11_io_read_dt),
    .io_read_di(mm_instruction_11_io_read_di),
    .io_read_oci(mm_instruction_11_io_read_oci),
    .io_read_oct(mm_instruction_11_io_read_oct),
    .io_read_icd(mm_instruction_11_io_read_icd),
    .io_read_pum(mm_instruction_11_io_read_pum),
    .io_read_immediate(mm_instruction_11_io_read_immediate),
    .io_read_ptm(mm_instruction_11_io_read_ptm),
    .io_read_ici(mm_instruction_11_io_read_ici),
    .io_read_ictb(mm_instruction_11_io_read_ictb),
    .io_read_ictv(mm_instruction_11_io_read_ictv),
    .io_write(mm_instruction_11_io_write)
  );
  mm_instruction mm_instruction_12 ( // @[instruction_memory.scala 22:73:@5545.4]
    .clock(mm_instruction_12_clock),
    .io_enable(mm_instruction_12_io_enable),
    .io_read_vi(mm_instruction_12_io_read_vi),
    .io_read_op(mm_instruction_12_io_read_op),
    .io_read_st(mm_instruction_12_io_read_st),
    .io_read_si(mm_instruction_12_io_read_si),
    .io_read_dt(mm_instruction_12_io_read_dt),
    .io_read_di(mm_instruction_12_io_read_di),
    .io_read_oci(mm_instruction_12_io_read_oci),
    .io_read_oct(mm_instruction_12_io_read_oct),
    .io_read_icd(mm_instruction_12_io_read_icd),
    .io_read_pum(mm_instruction_12_io_read_pum),
    .io_read_immediate(mm_instruction_12_io_read_immediate),
    .io_read_ptm(mm_instruction_12_io_read_ptm),
    .io_read_ici(mm_instruction_12_io_read_ici),
    .io_read_ictb(mm_instruction_12_io_read_ictb),
    .io_read_ictv(mm_instruction_12_io_read_ictv),
    .io_write(mm_instruction_12_io_write)
  );
  mm_instruction mm_instruction_13 ( // @[instruction_memory.scala 22:73:@5548.4]
    .clock(mm_instruction_13_clock),
    .io_enable(mm_instruction_13_io_enable),
    .io_read_vi(mm_instruction_13_io_read_vi),
    .io_read_op(mm_instruction_13_io_read_op),
    .io_read_st(mm_instruction_13_io_read_st),
    .io_read_si(mm_instruction_13_io_read_si),
    .io_read_dt(mm_instruction_13_io_read_dt),
    .io_read_di(mm_instruction_13_io_read_di),
    .io_read_oci(mm_instruction_13_io_read_oci),
    .io_read_oct(mm_instruction_13_io_read_oct),
    .io_read_icd(mm_instruction_13_io_read_icd),
    .io_read_pum(mm_instruction_13_io_read_pum),
    .io_read_immediate(mm_instruction_13_io_read_immediate),
    .io_read_ptm(mm_instruction_13_io_read_ptm),
    .io_read_ici(mm_instruction_13_io_read_ici),
    .io_read_ictb(mm_instruction_13_io_read_ictb),
    .io_read_ictv(mm_instruction_13_io_read_ictv),
    .io_write(mm_instruction_13_io_write)
  );
  mm_instruction mm_instruction_14 ( // @[instruction_memory.scala 22:73:@5551.4]
    .clock(mm_instruction_14_clock),
    .io_enable(mm_instruction_14_io_enable),
    .io_read_vi(mm_instruction_14_io_read_vi),
    .io_read_op(mm_instruction_14_io_read_op),
    .io_read_st(mm_instruction_14_io_read_st),
    .io_read_si(mm_instruction_14_io_read_si),
    .io_read_dt(mm_instruction_14_io_read_dt),
    .io_read_di(mm_instruction_14_io_read_di),
    .io_read_oci(mm_instruction_14_io_read_oci),
    .io_read_oct(mm_instruction_14_io_read_oct),
    .io_read_icd(mm_instruction_14_io_read_icd),
    .io_read_pum(mm_instruction_14_io_read_pum),
    .io_read_immediate(mm_instruction_14_io_read_immediate),
    .io_read_ptm(mm_instruction_14_io_read_ptm),
    .io_read_ici(mm_instruction_14_io_read_ici),
    .io_read_ictb(mm_instruction_14_io_read_ictb),
    .io_read_ictv(mm_instruction_14_io_read_ictv),
    .io_write(mm_instruction_14_io_write)
  );
  mm_instruction mm_instruction_15 ( // @[instruction_memory.scala 22:73:@5554.4]
    .clock(mm_instruction_15_clock),
    .io_enable(mm_instruction_15_io_enable),
    .io_read_vi(mm_instruction_15_io_read_vi),
    .io_read_op(mm_instruction_15_io_read_op),
    .io_read_st(mm_instruction_15_io_read_st),
    .io_read_si(mm_instruction_15_io_read_si),
    .io_read_dt(mm_instruction_15_io_read_dt),
    .io_read_di(mm_instruction_15_io_read_di),
    .io_read_oci(mm_instruction_15_io_read_oci),
    .io_read_oct(mm_instruction_15_io_read_oct),
    .io_read_icd(mm_instruction_15_io_read_icd),
    .io_read_pum(mm_instruction_15_io_read_pum),
    .io_read_immediate(mm_instruction_15_io_read_immediate),
    .io_read_ptm(mm_instruction_15_io_read_ptm),
    .io_read_ici(mm_instruction_15_io_read_ici),
    .io_read_ictb(mm_instruction_15_io_read_ictb),
    .io_read_ictv(mm_instruction_15_io_read_ictv),
    .io_write(mm_instruction_15_io_write)
  );
  assign _T_214 = io_host_interface_write_index[29:2]; // @[instruction_memory.scala 38:35:@5944.4]
  assign word_write_index = io_host_interface_write_index[1:0]; // @[instruction_memory.scala 41:34:@5946.4]
  assign _T_237 = io_enable & io_host_interface_write_req; // @[instruction_memory.scala 71:43:@5986.4]
  assign instruction_write_index = _T_214[3:0]; // @[instruction_memory.scala 24:37:@5846.4 instruction_memory.scala 37:27:@5945.4]
  assign _T_239 = 4'h0 == instruction_write_index; // @[instruction_memory.scala 71:81:@5987.4]
  assign mm_instruction_16_0_read_vi = mm_instruction_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5574.4]
  assign mm_instruction_16_0_read_op = mm_instruction_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5573.4]
  assign mm_instruction_16_0_read_st = mm_instruction_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5572.4]
  assign mm_instruction_16_0_read_si = mm_instruction_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5571.4]
  assign mm_instruction_16_0_read_dt = mm_instruction_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5570.4]
  assign mm_instruction_16_0_read_di = mm_instruction_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5569.4]
  assign mm_instruction_16_0_read_oci = mm_instruction_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5568.4]
  assign mm_instruction_16_0_read_oct = mm_instruction_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5567.4]
  assign mm_instruction_16_0_read_icd = mm_instruction_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5566.4]
  assign mm_instruction_16_0_read_pum = mm_instruction_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5565.4]
  assign mm_instruction_16_0_read_immediate = mm_instruction_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5564.4]
  assign mm_instruction_16_0_read_ptm = mm_instruction_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5563.4]
  assign mm_instruction_16_0_read_ici = mm_instruction_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5562.4]
  assign mm_instruction_16_0_read_ictb = mm_instruction_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5561.4]
  assign mm_instruction_16_0_read_ictv = mm_instruction_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5560.4]
  assign _T_325 = 2'h0 == word_write_index; // @[instruction_memory.scala 79:51:@6068.6]
  assign mm_instruction_16_15_read_immediate = mm_instruction_15_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5834.4]
  assign mm_instruction_16_14_read_immediate = mm_instruction_14_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5816.4]
  assign mm_instruction_16_13_read_immediate = mm_instruction_13_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5798.4]
  assign mm_instruction_16_12_read_immediate = mm_instruction_12_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5780.4]
  assign mm_instruction_16_11_read_immediate = mm_instruction_11_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5762.4]
  assign mm_instruction_16_10_read_immediate = mm_instruction_10_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5744.4]
  assign mm_instruction_16_9_read_immediate = mm_instruction_9_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5726.4]
  assign mm_instruction_16_8_read_immediate = mm_instruction_8_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5708.4]
  assign mm_instruction_16_7_read_immediate = mm_instruction_7_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5690.4]
  assign mm_instruction_16_6_read_immediate = mm_instruction_6_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5672.4]
  assign mm_instruction_16_5_read_immediate = mm_instruction_5_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5654.4]
  assign mm_instruction_16_4_read_immediate = mm_instruction_4_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5636.4]
  assign mm_instruction_16_3_read_immediate = mm_instruction_3_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5618.4]
  assign mm_instruction_16_2_read_immediate = mm_instruction_2_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5600.4]
  assign mm_instruction_16_1_read_immediate = mm_instruction_1_io_read_immediate; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5582.4]
  assign _GEN_328 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_immediate : mm_instruction_16_0_read_immediate; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_346 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_immediate : _GEN_328; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_364 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_immediate : _GEN_346; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_382 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_immediate : _GEN_364; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_400 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_immediate : _GEN_382; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_418 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_immediate : _GEN_400; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_436 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_immediate : _GEN_418; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_454 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_immediate : _GEN_436; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_472 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_immediate : _GEN_454; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_490 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_immediate : _GEN_472; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_508 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_immediate : _GEN_490; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_526 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_immediate : _GEN_508; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_544 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_immediate : _GEN_526; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_562 = 4'he == instruction_write_index ? mm_instruction_16_14_read_immediate : _GEN_544; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_580 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_immediate : _GEN_562; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_ictv = mm_instruction_15_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5830.4]
  assign mm_instruction_16_14_read_ictv = mm_instruction_14_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5812.4]
  assign mm_instruction_16_13_read_ictv = mm_instruction_13_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5794.4]
  assign mm_instruction_16_12_read_ictv = mm_instruction_12_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5776.4]
  assign mm_instruction_16_11_read_ictv = mm_instruction_11_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5758.4]
  assign mm_instruction_16_10_read_ictv = mm_instruction_10_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5740.4]
  assign mm_instruction_16_9_read_ictv = mm_instruction_9_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5722.4]
  assign mm_instruction_16_8_read_ictv = mm_instruction_8_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5704.4]
  assign mm_instruction_16_7_read_ictv = mm_instruction_7_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5686.4]
  assign mm_instruction_16_6_read_ictv = mm_instruction_6_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5668.4]
  assign mm_instruction_16_5_read_ictv = mm_instruction_5_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5650.4]
  assign mm_instruction_16_4_read_ictv = mm_instruction_4_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5632.4]
  assign mm_instruction_16_3_read_ictv = mm_instruction_3_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5614.4]
  assign mm_instruction_16_2_read_ictv = mm_instruction_2_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5596.4]
  assign mm_instruction_16_1_read_ictv = mm_instruction_1_io_read_ictv; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5578.4]
  assign _GEN_332 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_ictv : mm_instruction_16_0_read_ictv; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_350 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_ictv : _GEN_332; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_368 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_ictv : _GEN_350; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_386 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_ictv : _GEN_368; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_404 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_ictv : _GEN_386; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_422 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_ictv : _GEN_404; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_440 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_ictv : _GEN_422; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_458 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_ictv : _GEN_440; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_476 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_ictv : _GEN_458; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_494 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_ictv : _GEN_476; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_512 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_ictv : _GEN_494; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_530 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_ictv : _GEN_512; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_548 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_ictv : _GEN_530; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_566 = 4'he == instruction_write_index ? mm_instruction_16_14_read_ictv : _GEN_548; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_584 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_ictv : _GEN_566; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_ictb = mm_instruction_15_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5831.4]
  assign mm_instruction_16_14_read_ictb = mm_instruction_14_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5813.4]
  assign mm_instruction_16_13_read_ictb = mm_instruction_13_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5795.4]
  assign mm_instruction_16_12_read_ictb = mm_instruction_12_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5777.4]
  assign mm_instruction_16_11_read_ictb = mm_instruction_11_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5759.4]
  assign mm_instruction_16_10_read_ictb = mm_instruction_10_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5741.4]
  assign mm_instruction_16_9_read_ictb = mm_instruction_9_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5723.4]
  assign mm_instruction_16_8_read_ictb = mm_instruction_8_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5705.4]
  assign mm_instruction_16_7_read_ictb = mm_instruction_7_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5687.4]
  assign mm_instruction_16_6_read_ictb = mm_instruction_6_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5669.4]
  assign mm_instruction_16_5_read_ictb = mm_instruction_5_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5651.4]
  assign mm_instruction_16_4_read_ictb = mm_instruction_4_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5633.4]
  assign mm_instruction_16_3_read_ictb = mm_instruction_3_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5615.4]
  assign mm_instruction_16_2_read_ictb = mm_instruction_2_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5597.4]
  assign mm_instruction_16_1_read_ictb = mm_instruction_1_io_read_ictb; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5579.4]
  assign _GEN_331 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_ictb : mm_instruction_16_0_read_ictb; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_349 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_ictb : _GEN_331; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_367 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_ictb : _GEN_349; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_385 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_ictb : _GEN_367; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_403 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_ictb : _GEN_385; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_421 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_ictb : _GEN_403; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_439 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_ictb : _GEN_421; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_457 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_ictb : _GEN_439; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_475 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_ictb : _GEN_457; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_493 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_ictb : _GEN_475; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_511 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_ictb : _GEN_493; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_529 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_ictb : _GEN_511; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_547 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_ictb : _GEN_529; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_565 = 4'he == instruction_write_index ? mm_instruction_16_14_read_ictb : _GEN_547; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_583 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_ictb : _GEN_565; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_ici = mm_instruction_15_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5832.4]
  assign mm_instruction_16_14_read_ici = mm_instruction_14_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5814.4]
  assign mm_instruction_16_13_read_ici = mm_instruction_13_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5796.4]
  assign mm_instruction_16_12_read_ici = mm_instruction_12_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5778.4]
  assign mm_instruction_16_11_read_ici = mm_instruction_11_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5760.4]
  assign mm_instruction_16_10_read_ici = mm_instruction_10_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5742.4]
  assign mm_instruction_16_9_read_ici = mm_instruction_9_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5724.4]
  assign mm_instruction_16_8_read_ici = mm_instruction_8_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5706.4]
  assign mm_instruction_16_7_read_ici = mm_instruction_7_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5688.4]
  assign mm_instruction_16_6_read_ici = mm_instruction_6_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5670.4]
  assign mm_instruction_16_5_read_ici = mm_instruction_5_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5652.4]
  assign mm_instruction_16_4_read_ici = mm_instruction_4_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5634.4]
  assign mm_instruction_16_3_read_ici = mm_instruction_3_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5616.4]
  assign mm_instruction_16_2_read_ici = mm_instruction_2_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5598.4]
  assign mm_instruction_16_1_read_ici = mm_instruction_1_io_read_ici; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5580.4]
  assign _GEN_330 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_ici : mm_instruction_16_0_read_ici; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_348 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_ici : _GEN_330; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_366 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_ici : _GEN_348; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_384 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_ici : _GEN_366; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_402 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_ici : _GEN_384; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_420 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_ici : _GEN_402; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_438 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_ici : _GEN_420; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_456 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_ici : _GEN_438; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_474 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_ici : _GEN_456; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_492 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_ici : _GEN_474; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_510 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_ici : _GEN_492; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_528 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_ici : _GEN_510; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_546 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_ici : _GEN_528; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_564 = 4'he == instruction_write_index ? mm_instruction_16_14_read_ici : _GEN_546; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_582 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_ici : _GEN_564; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_ptm = mm_instruction_15_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5833.4]
  assign mm_instruction_16_14_read_ptm = mm_instruction_14_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5815.4]
  assign mm_instruction_16_13_read_ptm = mm_instruction_13_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5797.4]
  assign mm_instruction_16_12_read_ptm = mm_instruction_12_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5779.4]
  assign mm_instruction_16_11_read_ptm = mm_instruction_11_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5761.4]
  assign mm_instruction_16_10_read_ptm = mm_instruction_10_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5743.4]
  assign mm_instruction_16_9_read_ptm = mm_instruction_9_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5725.4]
  assign mm_instruction_16_8_read_ptm = mm_instruction_8_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5707.4]
  assign mm_instruction_16_7_read_ptm = mm_instruction_7_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5689.4]
  assign mm_instruction_16_6_read_ptm = mm_instruction_6_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5671.4]
  assign mm_instruction_16_5_read_ptm = mm_instruction_5_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5653.4]
  assign mm_instruction_16_4_read_ptm = mm_instruction_4_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5635.4]
  assign mm_instruction_16_3_read_ptm = mm_instruction_3_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5617.4]
  assign mm_instruction_16_2_read_ptm = mm_instruction_2_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5599.4]
  assign mm_instruction_16_1_read_ptm = mm_instruction_1_io_read_ptm; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5581.4]
  assign _GEN_329 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_ptm : mm_instruction_16_0_read_ptm; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_347 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_ptm : _GEN_329; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_365 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_ptm : _GEN_347; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_383 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_ptm : _GEN_365; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_401 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_ptm : _GEN_383; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_419 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_ptm : _GEN_401; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_437 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_ptm : _GEN_419; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_455 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_ptm : _GEN_437; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_473 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_ptm : _GEN_455; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_491 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_ptm : _GEN_473; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_509 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_ptm : _GEN_491; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_527 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_ptm : _GEN_509; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_545 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_ptm : _GEN_527; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_563 = 4'he == instruction_write_index ? mm_instruction_16_14_read_ptm : _GEN_545; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_581 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_ptm : _GEN_563; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_pum = mm_instruction_15_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5835.4]
  assign mm_instruction_16_14_read_pum = mm_instruction_14_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5817.4]
  assign mm_instruction_16_13_read_pum = mm_instruction_13_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5799.4]
  assign mm_instruction_16_12_read_pum = mm_instruction_12_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5781.4]
  assign mm_instruction_16_11_read_pum = mm_instruction_11_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5763.4]
  assign mm_instruction_16_10_read_pum = mm_instruction_10_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5745.4]
  assign mm_instruction_16_9_read_pum = mm_instruction_9_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5727.4]
  assign mm_instruction_16_8_read_pum = mm_instruction_8_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5709.4]
  assign mm_instruction_16_7_read_pum = mm_instruction_7_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5691.4]
  assign mm_instruction_16_6_read_pum = mm_instruction_6_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5673.4]
  assign mm_instruction_16_5_read_pum = mm_instruction_5_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5655.4]
  assign mm_instruction_16_4_read_pum = mm_instruction_4_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5637.4]
  assign mm_instruction_16_3_read_pum = mm_instruction_3_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5619.4]
  assign mm_instruction_16_2_read_pum = mm_instruction_2_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5601.4]
  assign mm_instruction_16_1_read_pum = mm_instruction_1_io_read_pum; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5583.4]
  assign _GEN_327 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_pum : mm_instruction_16_0_read_pum; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_345 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_pum : _GEN_327; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_363 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_pum : _GEN_345; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_381 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_pum : _GEN_363; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_399 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_pum : _GEN_381; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_417 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_pum : _GEN_399; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_435 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_pum : _GEN_417; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_453 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_pum : _GEN_435; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_471 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_pum : _GEN_453; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_489 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_pum : _GEN_471; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_507 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_pum : _GEN_489; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_525 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_pum : _GEN_507; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_543 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_pum : _GEN_525; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_561 = 4'he == instruction_write_index ? mm_instruction_16_14_read_pum : _GEN_543; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_579 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_pum : _GEN_561; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_icd = mm_instruction_15_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5836.4]
  assign mm_instruction_16_14_read_icd = mm_instruction_14_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5818.4]
  assign mm_instruction_16_13_read_icd = mm_instruction_13_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5800.4]
  assign mm_instruction_16_12_read_icd = mm_instruction_12_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5782.4]
  assign mm_instruction_16_11_read_icd = mm_instruction_11_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5764.4]
  assign mm_instruction_16_10_read_icd = mm_instruction_10_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5746.4]
  assign mm_instruction_16_9_read_icd = mm_instruction_9_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5728.4]
  assign mm_instruction_16_8_read_icd = mm_instruction_8_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5710.4]
  assign mm_instruction_16_7_read_icd = mm_instruction_7_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5692.4]
  assign mm_instruction_16_6_read_icd = mm_instruction_6_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5674.4]
  assign mm_instruction_16_5_read_icd = mm_instruction_5_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5656.4]
  assign mm_instruction_16_4_read_icd = mm_instruction_4_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5638.4]
  assign mm_instruction_16_3_read_icd = mm_instruction_3_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5620.4]
  assign mm_instruction_16_2_read_icd = mm_instruction_2_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5602.4]
  assign mm_instruction_16_1_read_icd = mm_instruction_1_io_read_icd; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5584.4]
  assign _GEN_326 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_icd : mm_instruction_16_0_read_icd; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_344 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_icd : _GEN_326; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_362 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_icd : _GEN_344; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_380 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_icd : _GEN_362; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_398 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_icd : _GEN_380; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_416 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_icd : _GEN_398; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_434 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_icd : _GEN_416; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_452 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_icd : _GEN_434; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_470 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_icd : _GEN_452; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_488 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_icd : _GEN_470; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_506 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_icd : _GEN_488; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_524 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_icd : _GEN_506; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_542 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_icd : _GEN_524; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_560 = 4'he == instruction_write_index ? mm_instruction_16_14_read_icd : _GEN_542; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_578 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_icd : _GEN_560; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_oct = mm_instruction_15_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5837.4]
  assign mm_instruction_16_14_read_oct = mm_instruction_14_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5819.4]
  assign mm_instruction_16_13_read_oct = mm_instruction_13_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5801.4]
  assign mm_instruction_16_12_read_oct = mm_instruction_12_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5783.4]
  assign mm_instruction_16_11_read_oct = mm_instruction_11_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5765.4]
  assign mm_instruction_16_10_read_oct = mm_instruction_10_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5747.4]
  assign mm_instruction_16_9_read_oct = mm_instruction_9_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5729.4]
  assign mm_instruction_16_8_read_oct = mm_instruction_8_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5711.4]
  assign mm_instruction_16_7_read_oct = mm_instruction_7_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5693.4]
  assign mm_instruction_16_6_read_oct = mm_instruction_6_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5675.4]
  assign mm_instruction_16_5_read_oct = mm_instruction_5_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5657.4]
  assign mm_instruction_16_4_read_oct = mm_instruction_4_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5639.4]
  assign mm_instruction_16_3_read_oct = mm_instruction_3_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5621.4]
  assign mm_instruction_16_2_read_oct = mm_instruction_2_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5603.4]
  assign mm_instruction_16_1_read_oct = mm_instruction_1_io_read_oct; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5585.4]
  assign _GEN_325 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_oct : mm_instruction_16_0_read_oct; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_343 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_oct : _GEN_325; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_361 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_oct : _GEN_343; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_379 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_oct : _GEN_361; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_397 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_oct : _GEN_379; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_415 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_oct : _GEN_397; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_433 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_oct : _GEN_415; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_451 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_oct : _GEN_433; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_469 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_oct : _GEN_451; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_487 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_oct : _GEN_469; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_505 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_oct : _GEN_487; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_523 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_oct : _GEN_505; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_541 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_oct : _GEN_523; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_559 = 4'he == instruction_write_index ? mm_instruction_16_14_read_oct : _GEN_541; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_577 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_oct : _GEN_559; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_oci = mm_instruction_15_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5838.4]
  assign mm_instruction_16_14_read_oci = mm_instruction_14_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5820.4]
  assign mm_instruction_16_13_read_oci = mm_instruction_13_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5802.4]
  assign mm_instruction_16_12_read_oci = mm_instruction_12_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5784.4]
  assign mm_instruction_16_11_read_oci = mm_instruction_11_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5766.4]
  assign mm_instruction_16_10_read_oci = mm_instruction_10_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5748.4]
  assign mm_instruction_16_9_read_oci = mm_instruction_9_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5730.4]
  assign mm_instruction_16_8_read_oci = mm_instruction_8_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5712.4]
  assign mm_instruction_16_7_read_oci = mm_instruction_7_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5694.4]
  assign mm_instruction_16_6_read_oci = mm_instruction_6_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5676.4]
  assign mm_instruction_16_5_read_oci = mm_instruction_5_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5658.4]
  assign mm_instruction_16_4_read_oci = mm_instruction_4_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5640.4]
  assign mm_instruction_16_3_read_oci = mm_instruction_3_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5622.4]
  assign mm_instruction_16_2_read_oci = mm_instruction_2_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5604.4]
  assign mm_instruction_16_1_read_oci = mm_instruction_1_io_read_oci; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5586.4]
  assign _GEN_324 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_oci : mm_instruction_16_0_read_oci; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_342 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_oci : _GEN_324; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_360 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_oci : _GEN_342; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_378 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_oci : _GEN_360; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_396 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_oci : _GEN_378; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_414 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_oci : _GEN_396; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_432 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_oci : _GEN_414; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_450 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_oci : _GEN_432; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_468 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_oci : _GEN_450; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_486 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_oci : _GEN_468; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_504 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_oci : _GEN_486; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_522 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_oci : _GEN_504; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_540 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_oci : _GEN_522; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_558 = 4'he == instruction_write_index ? mm_instruction_16_14_read_oci : _GEN_540; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_576 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_oci : _GEN_558; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_di = mm_instruction_15_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5839.4]
  assign mm_instruction_16_14_read_di = mm_instruction_14_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5821.4]
  assign mm_instruction_16_13_read_di = mm_instruction_13_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5803.4]
  assign mm_instruction_16_12_read_di = mm_instruction_12_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5785.4]
  assign mm_instruction_16_11_read_di = mm_instruction_11_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5767.4]
  assign mm_instruction_16_10_read_di = mm_instruction_10_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5749.4]
  assign mm_instruction_16_9_read_di = mm_instruction_9_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5731.4]
  assign mm_instruction_16_8_read_di = mm_instruction_8_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5713.4]
  assign mm_instruction_16_7_read_di = mm_instruction_7_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5695.4]
  assign mm_instruction_16_6_read_di = mm_instruction_6_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5677.4]
  assign mm_instruction_16_5_read_di = mm_instruction_5_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5659.4]
  assign mm_instruction_16_4_read_di = mm_instruction_4_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5641.4]
  assign mm_instruction_16_3_read_di = mm_instruction_3_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5623.4]
  assign mm_instruction_16_2_read_di = mm_instruction_2_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5605.4]
  assign mm_instruction_16_1_read_di = mm_instruction_1_io_read_di; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5587.4]
  assign _GEN_323 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_di : mm_instruction_16_0_read_di; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_341 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_di : _GEN_323; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_359 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_di : _GEN_341; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_377 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_di : _GEN_359; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_395 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_di : _GEN_377; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_413 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_di : _GEN_395; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_431 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_di : _GEN_413; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_449 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_di : _GEN_431; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_467 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_di : _GEN_449; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_485 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_di : _GEN_467; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_503 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_di : _GEN_485; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_521 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_di : _GEN_503; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_539 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_di : _GEN_521; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_557 = 4'he == instruction_write_index ? mm_instruction_16_14_read_di : _GEN_539; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_575 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_di : _GEN_557; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_dt = mm_instruction_15_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5840.4]
  assign mm_instruction_16_14_read_dt = mm_instruction_14_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5822.4]
  assign mm_instruction_16_13_read_dt = mm_instruction_13_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5804.4]
  assign mm_instruction_16_12_read_dt = mm_instruction_12_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5786.4]
  assign mm_instruction_16_11_read_dt = mm_instruction_11_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5768.4]
  assign mm_instruction_16_10_read_dt = mm_instruction_10_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5750.4]
  assign mm_instruction_16_9_read_dt = mm_instruction_9_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5732.4]
  assign mm_instruction_16_8_read_dt = mm_instruction_8_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5714.4]
  assign mm_instruction_16_7_read_dt = mm_instruction_7_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5696.4]
  assign mm_instruction_16_6_read_dt = mm_instruction_6_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5678.4]
  assign mm_instruction_16_5_read_dt = mm_instruction_5_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5660.4]
  assign mm_instruction_16_4_read_dt = mm_instruction_4_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5642.4]
  assign mm_instruction_16_3_read_dt = mm_instruction_3_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5624.4]
  assign mm_instruction_16_2_read_dt = mm_instruction_2_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5606.4]
  assign mm_instruction_16_1_read_dt = mm_instruction_1_io_read_dt; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5588.4]
  assign _GEN_322 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_dt : mm_instruction_16_0_read_dt; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_340 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_dt : _GEN_322; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_358 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_dt : _GEN_340; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_376 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_dt : _GEN_358; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_394 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_dt : _GEN_376; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_412 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_dt : _GEN_394; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_430 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_dt : _GEN_412; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_448 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_dt : _GEN_430; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_466 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_dt : _GEN_448; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_484 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_dt : _GEN_466; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_502 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_dt : _GEN_484; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_520 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_dt : _GEN_502; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_538 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_dt : _GEN_520; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_556 = 4'he == instruction_write_index ? mm_instruction_16_14_read_dt : _GEN_538; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_574 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_dt : _GEN_556; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_si = mm_instruction_15_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5841.4]
  assign mm_instruction_16_14_read_si = mm_instruction_14_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5823.4]
  assign mm_instruction_16_13_read_si = mm_instruction_13_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5805.4]
  assign mm_instruction_16_12_read_si = mm_instruction_12_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5787.4]
  assign mm_instruction_16_11_read_si = mm_instruction_11_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5769.4]
  assign mm_instruction_16_10_read_si = mm_instruction_10_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5751.4]
  assign mm_instruction_16_9_read_si = mm_instruction_9_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5733.4]
  assign mm_instruction_16_8_read_si = mm_instruction_8_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5715.4]
  assign mm_instruction_16_7_read_si = mm_instruction_7_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5697.4]
  assign mm_instruction_16_6_read_si = mm_instruction_6_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5679.4]
  assign mm_instruction_16_5_read_si = mm_instruction_5_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5661.4]
  assign mm_instruction_16_4_read_si = mm_instruction_4_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5643.4]
  assign mm_instruction_16_3_read_si = mm_instruction_3_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5625.4]
  assign mm_instruction_16_2_read_si = mm_instruction_2_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5607.4]
  assign mm_instruction_16_1_read_si = mm_instruction_1_io_read_si; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5589.4]
  assign _GEN_321 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_si : mm_instruction_16_0_read_si; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_339 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_si : _GEN_321; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_357 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_si : _GEN_339; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_375 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_si : _GEN_357; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_393 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_si : _GEN_375; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_411 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_si : _GEN_393; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_429 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_si : _GEN_411; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_447 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_si : _GEN_429; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_465 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_si : _GEN_447; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_483 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_si : _GEN_465; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_501 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_si : _GEN_483; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_519 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_si : _GEN_501; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_537 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_si : _GEN_519; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_555 = 4'he == instruction_write_index ? mm_instruction_16_14_read_si : _GEN_537; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_573 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_si : _GEN_555; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_st = mm_instruction_15_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5842.4]
  assign mm_instruction_16_14_read_st = mm_instruction_14_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5824.4]
  assign mm_instruction_16_13_read_st = mm_instruction_13_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5806.4]
  assign mm_instruction_16_12_read_st = mm_instruction_12_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5788.4]
  assign mm_instruction_16_11_read_st = mm_instruction_11_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5770.4]
  assign mm_instruction_16_10_read_st = mm_instruction_10_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5752.4]
  assign mm_instruction_16_9_read_st = mm_instruction_9_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5734.4]
  assign mm_instruction_16_8_read_st = mm_instruction_8_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5716.4]
  assign mm_instruction_16_7_read_st = mm_instruction_7_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5698.4]
  assign mm_instruction_16_6_read_st = mm_instruction_6_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5680.4]
  assign mm_instruction_16_5_read_st = mm_instruction_5_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5662.4]
  assign mm_instruction_16_4_read_st = mm_instruction_4_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5644.4]
  assign mm_instruction_16_3_read_st = mm_instruction_3_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5626.4]
  assign mm_instruction_16_2_read_st = mm_instruction_2_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5608.4]
  assign mm_instruction_16_1_read_st = mm_instruction_1_io_read_st; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5590.4]
  assign _GEN_320 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_st : mm_instruction_16_0_read_st; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_338 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_st : _GEN_320; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_356 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_st : _GEN_338; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_374 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_st : _GEN_356; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_392 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_st : _GEN_374; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_410 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_st : _GEN_392; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_428 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_st : _GEN_410; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_446 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_st : _GEN_428; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_464 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_st : _GEN_446; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_482 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_st : _GEN_464; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_500 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_st : _GEN_482; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_518 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_st : _GEN_500; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_536 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_st : _GEN_518; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_554 = 4'he == instruction_write_index ? mm_instruction_16_14_read_st : _GEN_536; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_572 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_st : _GEN_554; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_op = mm_instruction_15_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5843.4]
  assign mm_instruction_16_14_read_op = mm_instruction_14_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5825.4]
  assign mm_instruction_16_13_read_op = mm_instruction_13_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5807.4]
  assign mm_instruction_16_12_read_op = mm_instruction_12_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5789.4]
  assign mm_instruction_16_11_read_op = mm_instruction_11_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5771.4]
  assign mm_instruction_16_10_read_op = mm_instruction_10_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5753.4]
  assign mm_instruction_16_9_read_op = mm_instruction_9_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5735.4]
  assign mm_instruction_16_8_read_op = mm_instruction_8_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5717.4]
  assign mm_instruction_16_7_read_op = mm_instruction_7_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5699.4]
  assign mm_instruction_16_6_read_op = mm_instruction_6_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5681.4]
  assign mm_instruction_16_5_read_op = mm_instruction_5_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5663.4]
  assign mm_instruction_16_4_read_op = mm_instruction_4_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5645.4]
  assign mm_instruction_16_3_read_op = mm_instruction_3_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5627.4]
  assign mm_instruction_16_2_read_op = mm_instruction_2_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5609.4]
  assign mm_instruction_16_1_read_op = mm_instruction_1_io_read_op; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5591.4]
  assign _GEN_319 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_op : mm_instruction_16_0_read_op; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_337 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_op : _GEN_319; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_355 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_op : _GEN_337; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_373 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_op : _GEN_355; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_391 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_op : _GEN_373; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_409 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_op : _GEN_391; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_427 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_op : _GEN_409; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_445 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_op : _GEN_427; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_463 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_op : _GEN_445; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_481 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_op : _GEN_463; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_499 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_op : _GEN_481; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_517 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_op : _GEN_499; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_535 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_op : _GEN_517; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_553 = 4'he == instruction_write_index ? mm_instruction_16_14_read_op : _GEN_535; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_571 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_op : _GEN_553; // @[Cat.scala 30:58:@6052.6]
  assign mm_instruction_16_15_read_vi = mm_instruction_15_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5844.4]
  assign mm_instruction_16_14_read_vi = mm_instruction_14_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5826.4]
  assign mm_instruction_16_13_read_vi = mm_instruction_13_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5808.4]
  assign mm_instruction_16_12_read_vi = mm_instruction_12_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5790.4]
  assign mm_instruction_16_11_read_vi = mm_instruction_11_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5772.4]
  assign mm_instruction_16_10_read_vi = mm_instruction_10_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5754.4]
  assign mm_instruction_16_9_read_vi = mm_instruction_9_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5736.4]
  assign mm_instruction_16_8_read_vi = mm_instruction_8_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5718.4]
  assign mm_instruction_16_7_read_vi = mm_instruction_7_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5700.4]
  assign mm_instruction_16_6_read_vi = mm_instruction_6_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5682.4]
  assign mm_instruction_16_5_read_vi = mm_instruction_5_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5664.4]
  assign mm_instruction_16_4_read_vi = mm_instruction_4_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5646.4]
  assign mm_instruction_16_3_read_vi = mm_instruction_3_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5628.4]
  assign mm_instruction_16_2_read_vi = mm_instruction_2_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5610.4]
  assign mm_instruction_16_1_read_vi = mm_instruction_1_io_read_vi; // @[instruction_memory.scala 22:31:@5557.4 instruction_memory.scala 22:31:@5592.4]
  assign _GEN_318 = 4'h1 == instruction_write_index ? mm_instruction_16_1_read_vi : mm_instruction_16_0_read_vi; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_336 = 4'h2 == instruction_write_index ? mm_instruction_16_2_read_vi : _GEN_318; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_354 = 4'h3 == instruction_write_index ? mm_instruction_16_3_read_vi : _GEN_336; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_372 = 4'h4 == instruction_write_index ? mm_instruction_16_4_read_vi : _GEN_354; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_390 = 4'h5 == instruction_write_index ? mm_instruction_16_5_read_vi : _GEN_372; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_408 = 4'h6 == instruction_write_index ? mm_instruction_16_6_read_vi : _GEN_390; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_426 = 4'h7 == instruction_write_index ? mm_instruction_16_7_read_vi : _GEN_408; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_444 = 4'h8 == instruction_write_index ? mm_instruction_16_8_read_vi : _GEN_426; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_462 = 4'h9 == instruction_write_index ? mm_instruction_16_9_read_vi : _GEN_444; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_480 = 4'ha == instruction_write_index ? mm_instruction_16_10_read_vi : _GEN_462; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_498 = 4'hb == instruction_write_index ? mm_instruction_16_11_read_vi : _GEN_480; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_516 = 4'hc == instruction_write_index ? mm_instruction_16_12_read_vi : _GEN_498; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_534 = 4'hd == instruction_write_index ? mm_instruction_16_13_read_vi : _GEN_516; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_552 = 4'he == instruction_write_index ? mm_instruction_16_14_read_vi : _GEN_534; // @[Cat.scala 30:58:@6052.6]
  assign _GEN_570 = 4'hf == instruction_write_index ? mm_instruction_16_15_read_vi : _GEN_552; // @[Cat.scala 30:58:@6052.6]
  assign _T_315 = {_GEN_577,_GEN_576,_GEN_575,_GEN_574,_GEN_573,_GEN_572,_GEN_571,_GEN_570}; // @[Cat.scala 30:58:@6058.6]
  assign _T_323 = {15'h0,_GEN_580,_GEN_584,_GEN_583,_GEN_582,_GEN_581,_GEN_579,_GEN_578,_T_315}; // @[Cat.scala 30:58:@6066.6]
  assign read_instruction = _T_237 ? _T_323 : 128'h0; // @[instruction_memory.scala 75:49:@6051.4]
  assign _T_326 = read_instruction[31:0]; // @[instruction_memory.scala 81:25:@6069.6]
  assign _T_327 = _T_325 ? io_host_interface_write_data : _T_326; // @[instruction_memory.scala 79:40:@6070.6]
  assign instruction_words_0 = _T_237 ? _T_327 : 32'h0; // @[instruction_memory.scala 75:49:@6051.4]
  assign _T_329 = 2'h1 == word_write_index; // @[instruction_memory.scala 79:51:@6072.6]
  assign _T_330 = read_instruction[63:32]; // @[instruction_memory.scala 81:25:@6073.6]
  assign _T_331 = _T_329 ? io_host_interface_write_data : _T_330; // @[instruction_memory.scala 79:40:@6074.6]
  assign instruction_words_1 = _T_237 ? _T_331 : 32'h0; // @[instruction_memory.scala 75:49:@6051.4]
  assign _T_236 = {instruction_words_0,instruction_words_1}; // @[Cat.scala 30:58:@5984.4]
  assign updated_instruction = {{64'd0}, _T_236}; // @[instruction_memory.scala 66:33:@5983.4 instruction_memory.scala 67:23:@5985.4]
  assign _T_335 = _T_239 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6077.6]
  assign _T_243 = 4'h1 == instruction_write_index; // @[instruction_memory.scala 71:81:@5991.4]
  assign _GEN_19 = 4'h1 == io_triggered_instruction_index ? mm_instruction_16_1_read_vi : mm_instruction_16_0_read_vi; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_20 = 4'h1 == io_triggered_instruction_index ? mm_instruction_16_1_read_op : mm_instruction_16_0_read_op; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_21 = 4'h1 == io_triggered_instruction_index ? mm_instruction_16_1_read_st : mm_instruction_16_0_read_st; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_22 = 4'h1 == io_triggered_instruction_index ? mm_instruction_16_1_read_si : mm_instruction_16_0_read_si; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_23 = 4'h1 == io_triggered_instruction_index ? mm_instruction_16_1_read_dt : mm_instruction_16_0_read_dt; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_24 = 4'h1 == io_triggered_instruction_index ? mm_instruction_16_1_read_di : mm_instruction_16_0_read_di; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_25 = 4'h1 == io_triggered_instruction_index ? mm_instruction_16_1_read_oci : mm_instruction_16_0_read_oci; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_26 = 4'h1 == io_triggered_instruction_index ? mm_instruction_16_1_read_oct : mm_instruction_16_0_read_oct; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_27 = 4'h1 == io_triggered_instruction_index ? mm_instruction_16_1_read_icd : mm_instruction_16_0_read_icd; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_28 = 4'h1 == io_triggered_instruction_index ? mm_instruction_16_1_read_pum : mm_instruction_16_0_read_pum; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_29 = 4'h1 == io_triggered_instruction_index ? mm_instruction_16_1_read_immediate : mm_instruction_16_0_read_immediate; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_339 = _T_243 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6080.6]
  assign _T_247 = 4'h2 == instruction_write_index; // @[instruction_memory.scala 71:81:@5995.4]
  assign _GEN_37 = 4'h2 == io_triggered_instruction_index ? mm_instruction_16_2_read_vi : _GEN_19; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_38 = 4'h2 == io_triggered_instruction_index ? mm_instruction_16_2_read_op : _GEN_20; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_39 = 4'h2 == io_triggered_instruction_index ? mm_instruction_16_2_read_st : _GEN_21; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_40 = 4'h2 == io_triggered_instruction_index ? mm_instruction_16_2_read_si : _GEN_22; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_41 = 4'h2 == io_triggered_instruction_index ? mm_instruction_16_2_read_dt : _GEN_23; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_42 = 4'h2 == io_triggered_instruction_index ? mm_instruction_16_2_read_di : _GEN_24; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_43 = 4'h2 == io_triggered_instruction_index ? mm_instruction_16_2_read_oci : _GEN_25; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_44 = 4'h2 == io_triggered_instruction_index ? mm_instruction_16_2_read_oct : _GEN_26; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_45 = 4'h2 == io_triggered_instruction_index ? mm_instruction_16_2_read_icd : _GEN_27; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_46 = 4'h2 == io_triggered_instruction_index ? mm_instruction_16_2_read_pum : _GEN_28; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_47 = 4'h2 == io_triggered_instruction_index ? mm_instruction_16_2_read_immediate : _GEN_29; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_343 = _T_247 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6083.6]
  assign _T_251 = 4'h3 == instruction_write_index; // @[instruction_memory.scala 71:81:@5999.4]
  assign _GEN_55 = 4'h3 == io_triggered_instruction_index ? mm_instruction_16_3_read_vi : _GEN_37; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_56 = 4'h3 == io_triggered_instruction_index ? mm_instruction_16_3_read_op : _GEN_38; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_57 = 4'h3 == io_triggered_instruction_index ? mm_instruction_16_3_read_st : _GEN_39; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_58 = 4'h3 == io_triggered_instruction_index ? mm_instruction_16_3_read_si : _GEN_40; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_59 = 4'h3 == io_triggered_instruction_index ? mm_instruction_16_3_read_dt : _GEN_41; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_60 = 4'h3 == io_triggered_instruction_index ? mm_instruction_16_3_read_di : _GEN_42; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_61 = 4'h3 == io_triggered_instruction_index ? mm_instruction_16_3_read_oci : _GEN_43; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_62 = 4'h3 == io_triggered_instruction_index ? mm_instruction_16_3_read_oct : _GEN_44; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_63 = 4'h3 == io_triggered_instruction_index ? mm_instruction_16_3_read_icd : _GEN_45; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_64 = 4'h3 == io_triggered_instruction_index ? mm_instruction_16_3_read_pum : _GEN_46; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_65 = 4'h3 == io_triggered_instruction_index ? mm_instruction_16_3_read_immediate : _GEN_47; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_347 = _T_251 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6086.6]
  assign _T_255 = 4'h4 == instruction_write_index; // @[instruction_memory.scala 71:81:@6003.4]
  assign _GEN_73 = 4'h4 == io_triggered_instruction_index ? mm_instruction_16_4_read_vi : _GEN_55; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_74 = 4'h4 == io_triggered_instruction_index ? mm_instruction_16_4_read_op : _GEN_56; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_75 = 4'h4 == io_triggered_instruction_index ? mm_instruction_16_4_read_st : _GEN_57; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_76 = 4'h4 == io_triggered_instruction_index ? mm_instruction_16_4_read_si : _GEN_58; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_77 = 4'h4 == io_triggered_instruction_index ? mm_instruction_16_4_read_dt : _GEN_59; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_78 = 4'h4 == io_triggered_instruction_index ? mm_instruction_16_4_read_di : _GEN_60; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_79 = 4'h4 == io_triggered_instruction_index ? mm_instruction_16_4_read_oci : _GEN_61; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_80 = 4'h4 == io_triggered_instruction_index ? mm_instruction_16_4_read_oct : _GEN_62; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_81 = 4'h4 == io_triggered_instruction_index ? mm_instruction_16_4_read_icd : _GEN_63; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_82 = 4'h4 == io_triggered_instruction_index ? mm_instruction_16_4_read_pum : _GEN_64; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_83 = 4'h4 == io_triggered_instruction_index ? mm_instruction_16_4_read_immediate : _GEN_65; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_351 = _T_255 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6089.6]
  assign _T_259 = 4'h5 == instruction_write_index; // @[instruction_memory.scala 71:81:@6007.4]
  assign _GEN_91 = 4'h5 == io_triggered_instruction_index ? mm_instruction_16_5_read_vi : _GEN_73; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_92 = 4'h5 == io_triggered_instruction_index ? mm_instruction_16_5_read_op : _GEN_74; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_93 = 4'h5 == io_triggered_instruction_index ? mm_instruction_16_5_read_st : _GEN_75; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_94 = 4'h5 == io_triggered_instruction_index ? mm_instruction_16_5_read_si : _GEN_76; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_95 = 4'h5 == io_triggered_instruction_index ? mm_instruction_16_5_read_dt : _GEN_77; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_96 = 4'h5 == io_triggered_instruction_index ? mm_instruction_16_5_read_di : _GEN_78; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_97 = 4'h5 == io_triggered_instruction_index ? mm_instruction_16_5_read_oci : _GEN_79; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_98 = 4'h5 == io_triggered_instruction_index ? mm_instruction_16_5_read_oct : _GEN_80; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_99 = 4'h5 == io_triggered_instruction_index ? mm_instruction_16_5_read_icd : _GEN_81; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_100 = 4'h5 == io_triggered_instruction_index ? mm_instruction_16_5_read_pum : _GEN_82; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_101 = 4'h5 == io_triggered_instruction_index ? mm_instruction_16_5_read_immediate : _GEN_83; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_355 = _T_259 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6092.6]
  assign _T_263 = 4'h6 == instruction_write_index; // @[instruction_memory.scala 71:81:@6011.4]
  assign _GEN_109 = 4'h6 == io_triggered_instruction_index ? mm_instruction_16_6_read_vi : _GEN_91; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_110 = 4'h6 == io_triggered_instruction_index ? mm_instruction_16_6_read_op : _GEN_92; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_111 = 4'h6 == io_triggered_instruction_index ? mm_instruction_16_6_read_st : _GEN_93; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_112 = 4'h6 == io_triggered_instruction_index ? mm_instruction_16_6_read_si : _GEN_94; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_113 = 4'h6 == io_triggered_instruction_index ? mm_instruction_16_6_read_dt : _GEN_95; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_114 = 4'h6 == io_triggered_instruction_index ? mm_instruction_16_6_read_di : _GEN_96; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_115 = 4'h6 == io_triggered_instruction_index ? mm_instruction_16_6_read_oci : _GEN_97; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_116 = 4'h6 == io_triggered_instruction_index ? mm_instruction_16_6_read_oct : _GEN_98; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_117 = 4'h6 == io_triggered_instruction_index ? mm_instruction_16_6_read_icd : _GEN_99; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_118 = 4'h6 == io_triggered_instruction_index ? mm_instruction_16_6_read_pum : _GEN_100; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_119 = 4'h6 == io_triggered_instruction_index ? mm_instruction_16_6_read_immediate : _GEN_101; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_359 = _T_263 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6095.6]
  assign _T_267 = 4'h7 == instruction_write_index; // @[instruction_memory.scala 71:81:@6015.4]
  assign _GEN_127 = 4'h7 == io_triggered_instruction_index ? mm_instruction_16_7_read_vi : _GEN_109; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_128 = 4'h7 == io_triggered_instruction_index ? mm_instruction_16_7_read_op : _GEN_110; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_129 = 4'h7 == io_triggered_instruction_index ? mm_instruction_16_7_read_st : _GEN_111; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_130 = 4'h7 == io_triggered_instruction_index ? mm_instruction_16_7_read_si : _GEN_112; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_131 = 4'h7 == io_triggered_instruction_index ? mm_instruction_16_7_read_dt : _GEN_113; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_132 = 4'h7 == io_triggered_instruction_index ? mm_instruction_16_7_read_di : _GEN_114; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_133 = 4'h7 == io_triggered_instruction_index ? mm_instruction_16_7_read_oci : _GEN_115; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_134 = 4'h7 == io_triggered_instruction_index ? mm_instruction_16_7_read_oct : _GEN_116; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_135 = 4'h7 == io_triggered_instruction_index ? mm_instruction_16_7_read_icd : _GEN_117; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_136 = 4'h7 == io_triggered_instruction_index ? mm_instruction_16_7_read_pum : _GEN_118; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_137 = 4'h7 == io_triggered_instruction_index ? mm_instruction_16_7_read_immediate : _GEN_119; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_363 = _T_267 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6098.6]
  assign _T_271 = 4'h8 == instruction_write_index; // @[instruction_memory.scala 71:81:@6019.4]
  assign _GEN_145 = 4'h8 == io_triggered_instruction_index ? mm_instruction_16_8_read_vi : _GEN_127; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_146 = 4'h8 == io_triggered_instruction_index ? mm_instruction_16_8_read_op : _GEN_128; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_147 = 4'h8 == io_triggered_instruction_index ? mm_instruction_16_8_read_st : _GEN_129; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_148 = 4'h8 == io_triggered_instruction_index ? mm_instruction_16_8_read_si : _GEN_130; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_149 = 4'h8 == io_triggered_instruction_index ? mm_instruction_16_8_read_dt : _GEN_131; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_150 = 4'h8 == io_triggered_instruction_index ? mm_instruction_16_8_read_di : _GEN_132; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_151 = 4'h8 == io_triggered_instruction_index ? mm_instruction_16_8_read_oci : _GEN_133; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_152 = 4'h8 == io_triggered_instruction_index ? mm_instruction_16_8_read_oct : _GEN_134; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_153 = 4'h8 == io_triggered_instruction_index ? mm_instruction_16_8_read_icd : _GEN_135; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_154 = 4'h8 == io_triggered_instruction_index ? mm_instruction_16_8_read_pum : _GEN_136; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_155 = 4'h8 == io_triggered_instruction_index ? mm_instruction_16_8_read_immediate : _GEN_137; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_367 = _T_271 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6101.6]
  assign _T_275 = 4'h9 == instruction_write_index; // @[instruction_memory.scala 71:81:@6023.4]
  assign _GEN_163 = 4'h9 == io_triggered_instruction_index ? mm_instruction_16_9_read_vi : _GEN_145; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_164 = 4'h9 == io_triggered_instruction_index ? mm_instruction_16_9_read_op : _GEN_146; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_165 = 4'h9 == io_triggered_instruction_index ? mm_instruction_16_9_read_st : _GEN_147; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_166 = 4'h9 == io_triggered_instruction_index ? mm_instruction_16_9_read_si : _GEN_148; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_167 = 4'h9 == io_triggered_instruction_index ? mm_instruction_16_9_read_dt : _GEN_149; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_168 = 4'h9 == io_triggered_instruction_index ? mm_instruction_16_9_read_di : _GEN_150; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_169 = 4'h9 == io_triggered_instruction_index ? mm_instruction_16_9_read_oci : _GEN_151; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_170 = 4'h9 == io_triggered_instruction_index ? mm_instruction_16_9_read_oct : _GEN_152; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_171 = 4'h9 == io_triggered_instruction_index ? mm_instruction_16_9_read_icd : _GEN_153; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_172 = 4'h9 == io_triggered_instruction_index ? mm_instruction_16_9_read_pum : _GEN_154; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_173 = 4'h9 == io_triggered_instruction_index ? mm_instruction_16_9_read_immediate : _GEN_155; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_371 = _T_275 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6104.6]
  assign _T_279 = 4'ha == instruction_write_index; // @[instruction_memory.scala 71:81:@6027.4]
  assign _GEN_181 = 4'ha == io_triggered_instruction_index ? mm_instruction_16_10_read_vi : _GEN_163; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_182 = 4'ha == io_triggered_instruction_index ? mm_instruction_16_10_read_op : _GEN_164; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_183 = 4'ha == io_triggered_instruction_index ? mm_instruction_16_10_read_st : _GEN_165; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_184 = 4'ha == io_triggered_instruction_index ? mm_instruction_16_10_read_si : _GEN_166; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_185 = 4'ha == io_triggered_instruction_index ? mm_instruction_16_10_read_dt : _GEN_167; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_186 = 4'ha == io_triggered_instruction_index ? mm_instruction_16_10_read_di : _GEN_168; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_187 = 4'ha == io_triggered_instruction_index ? mm_instruction_16_10_read_oci : _GEN_169; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_188 = 4'ha == io_triggered_instruction_index ? mm_instruction_16_10_read_oct : _GEN_170; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_189 = 4'ha == io_triggered_instruction_index ? mm_instruction_16_10_read_icd : _GEN_171; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_190 = 4'ha == io_triggered_instruction_index ? mm_instruction_16_10_read_pum : _GEN_172; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_191 = 4'ha == io_triggered_instruction_index ? mm_instruction_16_10_read_immediate : _GEN_173; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_375 = _T_279 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6107.6]
  assign _T_283 = 4'hb == instruction_write_index; // @[instruction_memory.scala 71:81:@6031.4]
  assign _GEN_199 = 4'hb == io_triggered_instruction_index ? mm_instruction_16_11_read_vi : _GEN_181; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_200 = 4'hb == io_triggered_instruction_index ? mm_instruction_16_11_read_op : _GEN_182; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_201 = 4'hb == io_triggered_instruction_index ? mm_instruction_16_11_read_st : _GEN_183; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_202 = 4'hb == io_triggered_instruction_index ? mm_instruction_16_11_read_si : _GEN_184; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_203 = 4'hb == io_triggered_instruction_index ? mm_instruction_16_11_read_dt : _GEN_185; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_204 = 4'hb == io_triggered_instruction_index ? mm_instruction_16_11_read_di : _GEN_186; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_205 = 4'hb == io_triggered_instruction_index ? mm_instruction_16_11_read_oci : _GEN_187; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_206 = 4'hb == io_triggered_instruction_index ? mm_instruction_16_11_read_oct : _GEN_188; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_207 = 4'hb == io_triggered_instruction_index ? mm_instruction_16_11_read_icd : _GEN_189; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_208 = 4'hb == io_triggered_instruction_index ? mm_instruction_16_11_read_pum : _GEN_190; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_209 = 4'hb == io_triggered_instruction_index ? mm_instruction_16_11_read_immediate : _GEN_191; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_379 = _T_283 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6110.6]
  assign _T_287 = 4'hc == instruction_write_index; // @[instruction_memory.scala 71:81:@6035.4]
  assign _GEN_217 = 4'hc == io_triggered_instruction_index ? mm_instruction_16_12_read_vi : _GEN_199; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_218 = 4'hc == io_triggered_instruction_index ? mm_instruction_16_12_read_op : _GEN_200; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_219 = 4'hc == io_triggered_instruction_index ? mm_instruction_16_12_read_st : _GEN_201; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_220 = 4'hc == io_triggered_instruction_index ? mm_instruction_16_12_read_si : _GEN_202; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_221 = 4'hc == io_triggered_instruction_index ? mm_instruction_16_12_read_dt : _GEN_203; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_222 = 4'hc == io_triggered_instruction_index ? mm_instruction_16_12_read_di : _GEN_204; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_223 = 4'hc == io_triggered_instruction_index ? mm_instruction_16_12_read_oci : _GEN_205; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_224 = 4'hc == io_triggered_instruction_index ? mm_instruction_16_12_read_oct : _GEN_206; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_225 = 4'hc == io_triggered_instruction_index ? mm_instruction_16_12_read_icd : _GEN_207; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_226 = 4'hc == io_triggered_instruction_index ? mm_instruction_16_12_read_pum : _GEN_208; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_227 = 4'hc == io_triggered_instruction_index ? mm_instruction_16_12_read_immediate : _GEN_209; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_383 = _T_287 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6113.6]
  assign _T_291 = 4'hd == instruction_write_index; // @[instruction_memory.scala 71:81:@6039.4]
  assign _GEN_235 = 4'hd == io_triggered_instruction_index ? mm_instruction_16_13_read_vi : _GEN_217; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_236 = 4'hd == io_triggered_instruction_index ? mm_instruction_16_13_read_op : _GEN_218; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_237 = 4'hd == io_triggered_instruction_index ? mm_instruction_16_13_read_st : _GEN_219; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_238 = 4'hd == io_triggered_instruction_index ? mm_instruction_16_13_read_si : _GEN_220; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_239 = 4'hd == io_triggered_instruction_index ? mm_instruction_16_13_read_dt : _GEN_221; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_240 = 4'hd == io_triggered_instruction_index ? mm_instruction_16_13_read_di : _GEN_222; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_241 = 4'hd == io_triggered_instruction_index ? mm_instruction_16_13_read_oci : _GEN_223; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_242 = 4'hd == io_triggered_instruction_index ? mm_instruction_16_13_read_oct : _GEN_224; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_243 = 4'hd == io_triggered_instruction_index ? mm_instruction_16_13_read_icd : _GEN_225; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_244 = 4'hd == io_triggered_instruction_index ? mm_instruction_16_13_read_pum : _GEN_226; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_245 = 4'hd == io_triggered_instruction_index ? mm_instruction_16_13_read_immediate : _GEN_227; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_387 = _T_291 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6116.6]
  assign _T_295 = 4'he == instruction_write_index; // @[instruction_memory.scala 71:81:@6043.4]
  assign _GEN_253 = 4'he == io_triggered_instruction_index ? mm_instruction_16_14_read_vi : _GEN_235; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_254 = 4'he == io_triggered_instruction_index ? mm_instruction_16_14_read_op : _GEN_236; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_255 = 4'he == io_triggered_instruction_index ? mm_instruction_16_14_read_st : _GEN_237; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_256 = 4'he == io_triggered_instruction_index ? mm_instruction_16_14_read_si : _GEN_238; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_257 = 4'he == io_triggered_instruction_index ? mm_instruction_16_14_read_dt : _GEN_239; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_258 = 4'he == io_triggered_instruction_index ? mm_instruction_16_14_read_di : _GEN_240; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_259 = 4'he == io_triggered_instruction_index ? mm_instruction_16_14_read_oci : _GEN_241; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_260 = 4'he == io_triggered_instruction_index ? mm_instruction_16_14_read_oct : _GEN_242; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_261 = 4'he == io_triggered_instruction_index ? mm_instruction_16_14_read_icd : _GEN_243; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_262 = 4'he == io_triggered_instruction_index ? mm_instruction_16_14_read_pum : _GEN_244; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_263 = 4'he == io_triggered_instruction_index ? mm_instruction_16_14_read_immediate : _GEN_245; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_391 = _T_295 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6119.6]
  assign _T_299 = 4'hf == instruction_write_index; // @[instruction_memory.scala 71:81:@6047.4]
  assign _GEN_271 = 4'hf == io_triggered_instruction_index ? mm_instruction_16_15_read_vi : _GEN_253; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_272 = 4'hf == io_triggered_instruction_index ? mm_instruction_16_15_read_op : _GEN_254; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_273 = 4'hf == io_triggered_instruction_index ? mm_instruction_16_15_read_st : _GEN_255; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_274 = 4'hf == io_triggered_instruction_index ? mm_instruction_16_15_read_si : _GEN_256; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_275 = 4'hf == io_triggered_instruction_index ? mm_instruction_16_15_read_dt : _GEN_257; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_276 = 4'hf == io_triggered_instruction_index ? mm_instruction_16_15_read_di : _GEN_258; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_277 = 4'hf == io_triggered_instruction_index ? mm_instruction_16_15_read_oci : _GEN_259; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_278 = 4'hf == io_triggered_instruction_index ? mm_instruction_16_15_read_oct : _GEN_260; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_279 = 4'hf == io_triggered_instruction_index ? mm_instruction_16_15_read_icd : _GEN_261; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_280 = 4'hf == io_triggered_instruction_index ? mm_instruction_16_15_read_pum : _GEN_262; // @[instruction_memory.scala 54:39:@5966.6]
  assign _GEN_281 = 4'hf == io_triggered_instruction_index ? mm_instruction_16_15_read_immediate : _GEN_263; // @[instruction_memory.scala 54:39:@5966.6]
  assign _T_395 = _T_299 ? updated_instruction : 128'h0; // @[instruction_memory.scala 84:43:@6122.6]
  assign io_host_interface_read_ack = io_host_interface_read_req; // @[instruction_memory.scala 45:30:@5949.4]
  assign io_host_interface_write_ack = io_host_interface_write_req; // @[instruction_memory.scala 48:31:@5950.4]
  assign io_triggers_0_vi = mm_instruction_io_read_vi; // @[instruction_memory.scala 28:23:@5848.4]
  assign io_triggers_0_ptm = mm_instruction_io_read_ptm; // @[instruction_memory.scala 29:24:@5849.4]
  assign io_triggers_0_ici = mm_instruction_io_read_ici; // @[instruction_memory.scala 30:24:@5850.4]
  assign io_triggers_0_ictb = mm_instruction_io_read_ictb; // @[instruction_memory.scala 31:25:@5851.4]
  assign io_triggers_0_ictv = mm_instruction_io_read_ictv; // @[instruction_memory.scala 32:25:@5852.4]
  assign io_triggers_0_oci = mm_instruction_16_0_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5853.4]
  assign io_triggers_1_vi = mm_instruction_1_io_read_vi; // @[instruction_memory.scala 28:23:@5854.4]
  assign io_triggers_1_ptm = mm_instruction_1_io_read_ptm; // @[instruction_memory.scala 29:24:@5855.4]
  assign io_triggers_1_ici = mm_instruction_1_io_read_ici; // @[instruction_memory.scala 30:24:@5856.4]
  assign io_triggers_1_ictb = mm_instruction_1_io_read_ictb; // @[instruction_memory.scala 31:25:@5857.4]
  assign io_triggers_1_ictv = mm_instruction_1_io_read_ictv; // @[instruction_memory.scala 32:25:@5858.4]
  assign io_triggers_1_oci = mm_instruction_16_1_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5859.4]
  assign io_triggers_2_vi = mm_instruction_2_io_read_vi; // @[instruction_memory.scala 28:23:@5860.4]
  assign io_triggers_2_ptm = mm_instruction_2_io_read_ptm; // @[instruction_memory.scala 29:24:@5861.4]
  assign io_triggers_2_ici = mm_instruction_2_io_read_ici; // @[instruction_memory.scala 30:24:@5862.4]
  assign io_triggers_2_ictb = mm_instruction_2_io_read_ictb; // @[instruction_memory.scala 31:25:@5863.4]
  assign io_triggers_2_ictv = mm_instruction_2_io_read_ictv; // @[instruction_memory.scala 32:25:@5864.4]
  assign io_triggers_2_oci = mm_instruction_16_2_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5865.4]
  assign io_triggers_3_vi = mm_instruction_3_io_read_vi; // @[instruction_memory.scala 28:23:@5866.4]
  assign io_triggers_3_ptm = mm_instruction_3_io_read_ptm; // @[instruction_memory.scala 29:24:@5867.4]
  assign io_triggers_3_ici = mm_instruction_3_io_read_ici; // @[instruction_memory.scala 30:24:@5868.4]
  assign io_triggers_3_ictb = mm_instruction_3_io_read_ictb; // @[instruction_memory.scala 31:25:@5869.4]
  assign io_triggers_3_ictv = mm_instruction_3_io_read_ictv; // @[instruction_memory.scala 32:25:@5870.4]
  assign io_triggers_3_oci = mm_instruction_16_3_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5871.4]
  assign io_triggers_4_vi = mm_instruction_4_io_read_vi; // @[instruction_memory.scala 28:23:@5872.4]
  assign io_triggers_4_ptm = mm_instruction_4_io_read_ptm; // @[instruction_memory.scala 29:24:@5873.4]
  assign io_triggers_4_ici = mm_instruction_4_io_read_ici; // @[instruction_memory.scala 30:24:@5874.4]
  assign io_triggers_4_ictb = mm_instruction_4_io_read_ictb; // @[instruction_memory.scala 31:25:@5875.4]
  assign io_triggers_4_ictv = mm_instruction_4_io_read_ictv; // @[instruction_memory.scala 32:25:@5876.4]
  assign io_triggers_4_oci = mm_instruction_16_4_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5877.4]
  assign io_triggers_5_vi = mm_instruction_5_io_read_vi; // @[instruction_memory.scala 28:23:@5878.4]
  assign io_triggers_5_ptm = mm_instruction_5_io_read_ptm; // @[instruction_memory.scala 29:24:@5879.4]
  assign io_triggers_5_ici = mm_instruction_5_io_read_ici; // @[instruction_memory.scala 30:24:@5880.4]
  assign io_triggers_5_ictb = mm_instruction_5_io_read_ictb; // @[instruction_memory.scala 31:25:@5881.4]
  assign io_triggers_5_ictv = mm_instruction_5_io_read_ictv; // @[instruction_memory.scala 32:25:@5882.4]
  assign io_triggers_5_oci = mm_instruction_16_5_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5883.4]
  assign io_triggers_6_vi = mm_instruction_6_io_read_vi; // @[instruction_memory.scala 28:23:@5884.4]
  assign io_triggers_6_ptm = mm_instruction_6_io_read_ptm; // @[instruction_memory.scala 29:24:@5885.4]
  assign io_triggers_6_ici = mm_instruction_6_io_read_ici; // @[instruction_memory.scala 30:24:@5886.4]
  assign io_triggers_6_ictb = mm_instruction_6_io_read_ictb; // @[instruction_memory.scala 31:25:@5887.4]
  assign io_triggers_6_ictv = mm_instruction_6_io_read_ictv; // @[instruction_memory.scala 32:25:@5888.4]
  assign io_triggers_6_oci = mm_instruction_16_6_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5889.4]
  assign io_triggers_7_vi = mm_instruction_7_io_read_vi; // @[instruction_memory.scala 28:23:@5890.4]
  assign io_triggers_7_ptm = mm_instruction_7_io_read_ptm; // @[instruction_memory.scala 29:24:@5891.4]
  assign io_triggers_7_ici = mm_instruction_7_io_read_ici; // @[instruction_memory.scala 30:24:@5892.4]
  assign io_triggers_7_ictb = mm_instruction_7_io_read_ictb; // @[instruction_memory.scala 31:25:@5893.4]
  assign io_triggers_7_ictv = mm_instruction_7_io_read_ictv; // @[instruction_memory.scala 32:25:@5894.4]
  assign io_triggers_7_oci = mm_instruction_16_7_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5895.4]
  assign io_triggers_8_vi = mm_instruction_8_io_read_vi; // @[instruction_memory.scala 28:23:@5896.4]
  assign io_triggers_8_ptm = mm_instruction_8_io_read_ptm; // @[instruction_memory.scala 29:24:@5897.4]
  assign io_triggers_8_ici = mm_instruction_8_io_read_ici; // @[instruction_memory.scala 30:24:@5898.4]
  assign io_triggers_8_ictb = mm_instruction_8_io_read_ictb; // @[instruction_memory.scala 31:25:@5899.4]
  assign io_triggers_8_ictv = mm_instruction_8_io_read_ictv; // @[instruction_memory.scala 32:25:@5900.4]
  assign io_triggers_8_oci = mm_instruction_16_8_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5901.4]
  assign io_triggers_9_vi = mm_instruction_9_io_read_vi; // @[instruction_memory.scala 28:23:@5902.4]
  assign io_triggers_9_ptm = mm_instruction_9_io_read_ptm; // @[instruction_memory.scala 29:24:@5903.4]
  assign io_triggers_9_ici = mm_instruction_9_io_read_ici; // @[instruction_memory.scala 30:24:@5904.4]
  assign io_triggers_9_ictb = mm_instruction_9_io_read_ictb; // @[instruction_memory.scala 31:25:@5905.4]
  assign io_triggers_9_ictv = mm_instruction_9_io_read_ictv; // @[instruction_memory.scala 32:25:@5906.4]
  assign io_triggers_9_oci = mm_instruction_16_9_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5907.4]
  assign io_triggers_10_vi = mm_instruction_10_io_read_vi; // @[instruction_memory.scala 28:23:@5908.4]
  assign io_triggers_10_ptm = mm_instruction_10_io_read_ptm; // @[instruction_memory.scala 29:24:@5909.4]
  assign io_triggers_10_ici = mm_instruction_10_io_read_ici; // @[instruction_memory.scala 30:24:@5910.4]
  assign io_triggers_10_ictb = mm_instruction_10_io_read_ictb; // @[instruction_memory.scala 31:25:@5911.4]
  assign io_triggers_10_ictv = mm_instruction_10_io_read_ictv; // @[instruction_memory.scala 32:25:@5912.4]
  assign io_triggers_10_oci = mm_instruction_16_10_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5913.4]
  assign io_triggers_11_vi = mm_instruction_11_io_read_vi; // @[instruction_memory.scala 28:23:@5914.4]
  assign io_triggers_11_ptm = mm_instruction_11_io_read_ptm; // @[instruction_memory.scala 29:24:@5915.4]
  assign io_triggers_11_ici = mm_instruction_11_io_read_ici; // @[instruction_memory.scala 30:24:@5916.4]
  assign io_triggers_11_ictb = mm_instruction_11_io_read_ictb; // @[instruction_memory.scala 31:25:@5917.4]
  assign io_triggers_11_ictv = mm_instruction_11_io_read_ictv; // @[instruction_memory.scala 32:25:@5918.4]
  assign io_triggers_11_oci = mm_instruction_16_11_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5919.4]
  assign io_triggers_12_vi = mm_instruction_12_io_read_vi; // @[instruction_memory.scala 28:23:@5920.4]
  assign io_triggers_12_ptm = mm_instruction_12_io_read_ptm; // @[instruction_memory.scala 29:24:@5921.4]
  assign io_triggers_12_ici = mm_instruction_12_io_read_ici; // @[instruction_memory.scala 30:24:@5922.4]
  assign io_triggers_12_ictb = mm_instruction_12_io_read_ictb; // @[instruction_memory.scala 31:25:@5923.4]
  assign io_triggers_12_ictv = mm_instruction_12_io_read_ictv; // @[instruction_memory.scala 32:25:@5924.4]
  assign io_triggers_12_oci = mm_instruction_16_12_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5925.4]
  assign io_triggers_13_vi = mm_instruction_13_io_read_vi; // @[instruction_memory.scala 28:23:@5926.4]
  assign io_triggers_13_ptm = mm_instruction_13_io_read_ptm; // @[instruction_memory.scala 29:24:@5927.4]
  assign io_triggers_13_ici = mm_instruction_13_io_read_ici; // @[instruction_memory.scala 30:24:@5928.4]
  assign io_triggers_13_ictb = mm_instruction_13_io_read_ictb; // @[instruction_memory.scala 31:25:@5929.4]
  assign io_triggers_13_ictv = mm_instruction_13_io_read_ictv; // @[instruction_memory.scala 32:25:@5930.4]
  assign io_triggers_13_oci = mm_instruction_16_13_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5931.4]
  assign io_triggers_14_vi = mm_instruction_14_io_read_vi; // @[instruction_memory.scala 28:23:@5932.4]
  assign io_triggers_14_ptm = mm_instruction_14_io_read_ptm; // @[instruction_memory.scala 29:24:@5933.4]
  assign io_triggers_14_ici = mm_instruction_14_io_read_ici; // @[instruction_memory.scala 30:24:@5934.4]
  assign io_triggers_14_ictb = mm_instruction_14_io_read_ictb; // @[instruction_memory.scala 31:25:@5935.4]
  assign io_triggers_14_ictv = mm_instruction_14_io_read_ictv; // @[instruction_memory.scala 32:25:@5936.4]
  assign io_triggers_14_oci = mm_instruction_16_14_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5937.4]
  assign io_triggers_15_vi = mm_instruction_15_io_read_vi; // @[instruction_memory.scala 28:23:@5938.4]
  assign io_triggers_15_ptm = mm_instruction_15_io_read_ptm; // @[instruction_memory.scala 29:24:@5939.4]
  assign io_triggers_15_ici = mm_instruction_15_io_read_ici; // @[instruction_memory.scala 30:24:@5940.4]
  assign io_triggers_15_ictb = mm_instruction_15_io_read_ictb; // @[instruction_memory.scala 31:25:@5941.4]
  assign io_triggers_15_ictv = mm_instruction_15_io_read_ictv; // @[instruction_memory.scala 32:25:@5942.4]
  assign io_triggers_15_oci = mm_instruction_16_15_read_oci[1:0]; // @[instruction_memory.scala 33:24:@5943.4]
  assign io_triggered_datapath_instruction_vi = io_triggered_instruction_valid ? _GEN_271 : 1'h0; // @[instruction_memory.scala 51:37:@5964.4 instruction_memory.scala 54:39:@5976.6]
  assign io_triggered_datapath_instruction_op = io_triggered_instruction_valid ? _GEN_272 : 6'h0; // @[instruction_memory.scala 51:37:@5963.4 instruction_memory.scala 54:39:@5975.6]
  assign io_triggered_datapath_instruction_st = io_triggered_instruction_valid ? _GEN_273 : 6'h0; // @[instruction_memory.scala 51:37:@5962.4 instruction_memory.scala 54:39:@5974.6]
  assign io_triggered_datapath_instruction_si = io_triggered_instruction_valid ? _GEN_274 : 9'h0; // @[instruction_memory.scala 51:37:@5961.4 instruction_memory.scala 54:39:@5973.6]
  assign io_triggered_datapath_instruction_dt = io_triggered_instruction_valid ? _GEN_275 : 2'h0; // @[instruction_memory.scala 51:37:@5960.4 instruction_memory.scala 54:39:@5972.6]
  assign io_triggered_datapath_instruction_di = io_triggered_instruction_valid ? _GEN_276 : 3'h0; // @[instruction_memory.scala 51:37:@5959.4 instruction_memory.scala 54:39:@5971.6]
  assign io_triggered_datapath_instruction_oci = io_triggered_instruction_valid ? _GEN_277 : 4'h0; // @[instruction_memory.scala 51:37:@5958.4 instruction_memory.scala 54:39:@5970.6]
  assign io_triggered_datapath_instruction_oct = io_triggered_instruction_valid ? _GEN_278 : 2'h0; // @[instruction_memory.scala 51:37:@5957.4 instruction_memory.scala 54:39:@5969.6]
  assign io_triggered_datapath_instruction_icd = io_triggered_instruction_valid ? _GEN_279 : 4'h0; // @[instruction_memory.scala 51:37:@5956.4 instruction_memory.scala 54:39:@5968.6]
  assign io_triggered_datapath_instruction_pum = io_triggered_instruction_valid ? _GEN_280 : 16'h0; // @[instruction_memory.scala 51:37:@5955.4 instruction_memory.scala 54:39:@5967.6]
  assign io_triggered_datapath_instruction_immediate = io_triggered_instruction_valid ? _GEN_281 : 32'h0; // @[instruction_memory.scala 51:37:@5954.4 instruction_memory.scala 54:39:@5966.6]
  assign mm_instruction_clock = clock; // @[:@5510.4]
  assign mm_instruction_io_enable = _T_237 & _T_239; // @[instruction_memory.scala 22:31:@5575.4]
  assign mm_instruction_io_write = _T_237 ? _T_335 : 128'h0; // @[instruction_memory.scala 22:31:@5558.4]
  assign mm_instruction_1_clock = clock; // @[:@5513.4]
  assign mm_instruction_1_io_enable = _T_237 & _T_243; // @[instruction_memory.scala 22:31:@5593.4]
  assign mm_instruction_1_io_write = _T_237 ? _T_339 : 128'h0; // @[instruction_memory.scala 22:31:@5576.4]
  assign mm_instruction_2_clock = clock; // @[:@5516.4]
  assign mm_instruction_2_io_enable = _T_237 & _T_247; // @[instruction_memory.scala 22:31:@5611.4]
  assign mm_instruction_2_io_write = _T_237 ? _T_343 : 128'h0; // @[instruction_memory.scala 22:31:@5594.4]
  assign mm_instruction_3_clock = clock; // @[:@5519.4]
  assign mm_instruction_3_io_enable = _T_237 & _T_251; // @[instruction_memory.scala 22:31:@5629.4]
  assign mm_instruction_3_io_write = _T_237 ? _T_347 : 128'h0; // @[instruction_memory.scala 22:31:@5612.4]
  assign mm_instruction_4_clock = clock; // @[:@5522.4]
  assign mm_instruction_4_io_enable = _T_237 & _T_255; // @[instruction_memory.scala 22:31:@5647.4]
  assign mm_instruction_4_io_write = _T_237 ? _T_351 : 128'h0; // @[instruction_memory.scala 22:31:@5630.4]
  assign mm_instruction_5_clock = clock; // @[:@5525.4]
  assign mm_instruction_5_io_enable = _T_237 & _T_259; // @[instruction_memory.scala 22:31:@5665.4]
  assign mm_instruction_5_io_write = _T_237 ? _T_355 : 128'h0; // @[instruction_memory.scala 22:31:@5648.4]
  assign mm_instruction_6_clock = clock; // @[:@5528.4]
  assign mm_instruction_6_io_enable = _T_237 & _T_263; // @[instruction_memory.scala 22:31:@5683.4]
  assign mm_instruction_6_io_write = _T_237 ? _T_359 : 128'h0; // @[instruction_memory.scala 22:31:@5666.4]
  assign mm_instruction_7_clock = clock; // @[:@5531.4]
  assign mm_instruction_7_io_enable = _T_237 & _T_267; // @[instruction_memory.scala 22:31:@5701.4]
  assign mm_instruction_7_io_write = _T_237 ? _T_363 : 128'h0; // @[instruction_memory.scala 22:31:@5684.4]
  assign mm_instruction_8_clock = clock; // @[:@5534.4]
  assign mm_instruction_8_io_enable = _T_237 & _T_271; // @[instruction_memory.scala 22:31:@5719.4]
  assign mm_instruction_8_io_write = _T_237 ? _T_367 : 128'h0; // @[instruction_memory.scala 22:31:@5702.4]
  assign mm_instruction_9_clock = clock; // @[:@5537.4]
  assign mm_instruction_9_io_enable = _T_237 & _T_275; // @[instruction_memory.scala 22:31:@5737.4]
  assign mm_instruction_9_io_write = _T_237 ? _T_371 : 128'h0; // @[instruction_memory.scala 22:31:@5720.4]
  assign mm_instruction_10_clock = clock; // @[:@5540.4]
  assign mm_instruction_10_io_enable = _T_237 & _T_279; // @[instruction_memory.scala 22:31:@5755.4]
  assign mm_instruction_10_io_write = _T_237 ? _T_375 : 128'h0; // @[instruction_memory.scala 22:31:@5738.4]
  assign mm_instruction_11_clock = clock; // @[:@5543.4]
  assign mm_instruction_11_io_enable = _T_237 & _T_283; // @[instruction_memory.scala 22:31:@5773.4]
  assign mm_instruction_11_io_write = _T_237 ? _T_379 : 128'h0; // @[instruction_memory.scala 22:31:@5756.4]
  assign mm_instruction_12_clock = clock; // @[:@5546.4]
  assign mm_instruction_12_io_enable = _T_237 & _T_287; // @[instruction_memory.scala 22:31:@5791.4]
  assign mm_instruction_12_io_write = _T_237 ? _T_383 : 128'h0; // @[instruction_memory.scala 22:31:@5774.4]
  assign mm_instruction_13_clock = clock; // @[:@5549.4]
  assign mm_instruction_13_io_enable = _T_237 & _T_291; // @[instruction_memory.scala 22:31:@5809.4]
  assign mm_instruction_13_io_write = _T_237 ? _T_387 : 128'h0; // @[instruction_memory.scala 22:31:@5792.4]
  assign mm_instruction_14_clock = clock; // @[:@5552.4]
  assign mm_instruction_14_io_enable = _T_237 & _T_295; // @[instruction_memory.scala 22:31:@5827.4]
  assign mm_instruction_14_io_write = _T_237 ? _T_391 : 128'h0; // @[instruction_memory.scala 22:31:@5810.4]
  assign mm_instruction_15_clock = clock; // @[:@5555.4]
  assign mm_instruction_15_io_enable = _T_237 & _T_299; // @[instruction_memory.scala 22:31:@5845.4]
  assign mm_instruction_15_io_write = _T_237 ? _T_395 : 128'h0; // @[instruction_memory.scala 22:31:@5828.4]
endmodule
module integer_collision_detector( // @[:@6144.2]
  input  [5:0] io_triggered_instruction_op, // @[:@6147.4]
  input  [2:0] io_dx1_instruction_retiring_stage, // @[:@6147.4]
  output       io_collision // @[:@6147.4]
);
  wire  _T_288; // @[integer_collision_detector.scala 16:30:@6274.4]
  wire  _T_289; // @[integer_collision_detector.scala 16:30:@6275.4]
  wire  _T_290; // @[integer_collision_detector.scala 16:30:@6276.4]
  wire  _T_291; // @[integer_collision_detector.scala 16:30:@6277.4]
  wire  _T_292; // @[integer_collision_detector.scala 16:30:@6278.4]
  wire  _T_293; // @[integer_collision_detector.scala 16:30:@6279.4]
  wire  _T_294; // @[integer_collision_detector.scala 16:30:@6280.4]
  wire  _T_295; // @[integer_collision_detector.scala 16:30:@6281.4]
  wire  _T_296; // @[integer_collision_detector.scala 16:30:@6282.4]
  wire  _T_297; // @[integer_collision_detector.scala 16:30:@6283.4]
  wire  _T_298; // @[integer_collision_detector.scala 16:30:@6284.4]
  wire  _T_299; // @[integer_collision_detector.scala 16:30:@6285.4]
  wire  _T_300; // @[integer_collision_detector.scala 16:30:@6286.4]
  wire  _T_301; // @[integer_collision_detector.scala 16:30:@6287.4]
  wire  _T_302; // @[integer_collision_detector.scala 16:30:@6288.4]
  wire  _T_303; // @[integer_collision_detector.scala 16:30:@6289.4]
  wire  _T_304; // @[integer_collision_detector.scala 16:30:@6290.4]
  wire  _T_305; // @[integer_collision_detector.scala 16:30:@6291.4]
  wire  _T_306; // @[integer_collision_detector.scala 16:30:@6292.4]
  wire  _T_307; // @[integer_collision_detector.scala 16:30:@6293.4]
  wire  _T_308; // @[integer_collision_detector.scala 16:30:@6294.4]
  wire  _T_309; // @[integer_collision_detector.scala 16:30:@6295.4]
  wire  _T_310; // @[integer_collision_detector.scala 16:30:@6296.4]
  wire  _T_311; // @[integer_collision_detector.scala 16:30:@6297.4]
  wire  _T_312; // @[integer_collision_detector.scala 16:30:@6298.4]
  wire  _T_313; // @[integer_collision_detector.scala 16:30:@6299.4]
  wire  _T_314; // @[integer_collision_detector.scala 16:30:@6300.4]
  wire  _T_315; // @[integer_collision_detector.scala 16:30:@6301.4]
  wire  _T_316; // @[integer_collision_detector.scala 16:30:@6302.4]
  wire  _T_317; // @[integer_collision_detector.scala 16:30:@6303.4]
  wire  _T_318; // @[integer_collision_detector.scala 16:30:@6304.4]
  wire  _T_319; // @[integer_collision_detector.scala 16:30:@6305.4]
  wire  _T_320; // @[integer_collision_detector.scala 16:30:@6306.4]
  wire  _T_321; // @[integer_collision_detector.scala 16:30:@6307.4]
  wire  _T_322; // @[integer_collision_detector.scala 16:30:@6308.4]
  wire  _T_323; // @[integer_collision_detector.scala 16:30:@6309.4]
  wire  _T_324; // @[integer_collision_detector.scala 16:30:@6310.4]
  wire  _T_325; // @[integer_collision_detector.scala 16:30:@6311.4]
  wire  _T_326; // @[integer_collision_detector.scala 16:30:@6312.4]
  wire  _T_327; // @[integer_collision_detector.scala 16:30:@6313.4]
  wire  _T_330; // @[integer_collision_detector.scala 16:26:@6315.4]
  wire  _T_331; // @[integer_collision_detector.scala 16:26:@6316.4]
  wire  _T_332; // @[integer_collision_detector.scala 16:26:@6317.4]
  wire  _T_333; // @[integer_collision_detector.scala 16:26:@6318.4]
  wire  _T_334; // @[integer_collision_detector.scala 16:26:@6319.4]
  wire  _T_335; // @[integer_collision_detector.scala 16:26:@6320.4]
  wire  _T_336; // @[integer_collision_detector.scala 16:26:@6321.4]
  wire  _T_337; // @[integer_collision_detector.scala 16:26:@6322.4]
  wire  _T_338; // @[integer_collision_detector.scala 16:26:@6323.4]
  wire  _T_339; // @[integer_collision_detector.scala 16:26:@6324.4]
  wire  _T_340; // @[integer_collision_detector.scala 16:26:@6325.4]
  wire  _T_341; // @[integer_collision_detector.scala 16:26:@6326.4]
  wire  _T_342; // @[integer_collision_detector.scala 16:26:@6327.4]
  wire  _T_343; // @[integer_collision_detector.scala 16:26:@6328.4]
  wire  _T_344; // @[integer_collision_detector.scala 16:26:@6329.4]
  wire  _T_345; // @[integer_collision_detector.scala 16:26:@6330.4]
  wire  _T_346; // @[integer_collision_detector.scala 16:26:@6331.4]
  wire  _T_347; // @[integer_collision_detector.scala 16:26:@6332.4]
  wire  _T_348; // @[integer_collision_detector.scala 16:26:@6333.4]
  wire  _T_349; // @[integer_collision_detector.scala 16:26:@6334.4]
  wire  _T_350; // @[integer_collision_detector.scala 16:26:@6335.4]
  wire  _T_351; // @[integer_collision_detector.scala 16:26:@6336.4]
  wire  _T_352; // @[integer_collision_detector.scala 16:26:@6337.4]
  wire  _T_353; // @[integer_collision_detector.scala 16:26:@6338.4]
  wire  _T_354; // @[integer_collision_detector.scala 16:26:@6339.4]
  wire  _T_355; // @[integer_collision_detector.scala 16:26:@6340.4]
  wire  _T_356; // @[integer_collision_detector.scala 16:26:@6341.4]
  wire  _T_357; // @[integer_collision_detector.scala 16:26:@6342.4]
  wire  _T_358; // @[integer_collision_detector.scala 16:26:@6343.4]
  wire  _T_359; // @[integer_collision_detector.scala 16:26:@6344.4]
  wire  _T_360; // @[integer_collision_detector.scala 16:26:@6345.4]
  wire  _T_361; // @[integer_collision_detector.scala 16:26:@6346.4]
  wire  _T_362; // @[integer_collision_detector.scala 16:26:@6347.4]
  wire  _T_363; // @[integer_collision_detector.scala 16:26:@6348.4]
  wire  _T_364; // @[integer_collision_detector.scala 16:26:@6349.4]
  wire  _T_365; // @[integer_collision_detector.scala 16:26:@6350.4]
  wire  _T_366; // @[integer_collision_detector.scala 16:26:@6351.4]
  wire  _T_367; // @[integer_collision_detector.scala 16:26:@6352.4]
  wire  _T_368; // @[integer_collision_detector.scala 16:26:@6353.4]
  wire  _T_370; // @[integer_collision_detector.scala 17:59:@6355.6]
  assign _T_288 = 6'h0 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6274.4]
  assign _T_289 = 6'h1 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6275.4]
  assign _T_290 = 6'h2 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6276.4]
  assign _T_291 = 6'h3 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6277.4]
  assign _T_292 = 6'h4 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6278.4]
  assign _T_293 = 6'h5 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6279.4]
  assign _T_294 = 6'h6 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6280.4]
  assign _T_295 = 6'h7 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6281.4]
  assign _T_296 = 6'h8 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6282.4]
  assign _T_297 = 6'h9 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6283.4]
  assign _T_298 = 6'ha == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6284.4]
  assign _T_299 = 6'hb == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6285.4]
  assign _T_300 = 6'hc == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6286.4]
  assign _T_301 = 6'hd == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6287.4]
  assign _T_302 = 6'he == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6288.4]
  assign _T_303 = 6'hf == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6289.4]
  assign _T_304 = 6'h10 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6290.4]
  assign _T_305 = 6'h11 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6291.4]
  assign _T_306 = 6'h12 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6292.4]
  assign _T_307 = 6'h13 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6293.4]
  assign _T_308 = 6'h14 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6294.4]
  assign _T_309 = 6'h15 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6295.4]
  assign _T_310 = 6'h16 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6296.4]
  assign _T_311 = 6'h17 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6297.4]
  assign _T_312 = 6'h18 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6298.4]
  assign _T_313 = 6'h19 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6299.4]
  assign _T_314 = 6'h1a == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6300.4]
  assign _T_315 = 6'h1b == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6301.4]
  assign _T_316 = 6'h1c == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6302.4]
  assign _T_317 = 6'h1d == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6303.4]
  assign _T_318 = 6'h1e == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6304.4]
  assign _T_319 = 6'h1f == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6305.4]
  assign _T_320 = 6'h20 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6306.4]
  assign _T_321 = 6'h21 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6307.4]
  assign _T_322 = 6'h22 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6308.4]
  assign _T_323 = 6'h23 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6309.4]
  assign _T_324 = 6'h24 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6310.4]
  assign _T_325 = 6'h25 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6311.4]
  assign _T_326 = 6'h26 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6312.4]
  assign _T_327 = 6'h27 == io_triggered_instruction_op; // @[integer_collision_detector.scala 16:30:@6313.4]
  assign _T_330 = _T_288 | _T_289; // @[integer_collision_detector.scala 16:26:@6315.4]
  assign _T_331 = _T_330 | _T_290; // @[integer_collision_detector.scala 16:26:@6316.4]
  assign _T_332 = _T_331 | _T_291; // @[integer_collision_detector.scala 16:26:@6317.4]
  assign _T_333 = _T_332 | _T_292; // @[integer_collision_detector.scala 16:26:@6318.4]
  assign _T_334 = _T_333 | _T_293; // @[integer_collision_detector.scala 16:26:@6319.4]
  assign _T_335 = _T_334 | _T_294; // @[integer_collision_detector.scala 16:26:@6320.4]
  assign _T_336 = _T_335 | _T_295; // @[integer_collision_detector.scala 16:26:@6321.4]
  assign _T_337 = _T_336 | _T_296; // @[integer_collision_detector.scala 16:26:@6322.4]
  assign _T_338 = _T_337 | _T_297; // @[integer_collision_detector.scala 16:26:@6323.4]
  assign _T_339 = _T_338 | _T_298; // @[integer_collision_detector.scala 16:26:@6324.4]
  assign _T_340 = _T_339 | _T_299; // @[integer_collision_detector.scala 16:26:@6325.4]
  assign _T_341 = _T_340 | _T_300; // @[integer_collision_detector.scala 16:26:@6326.4]
  assign _T_342 = _T_341 | _T_301; // @[integer_collision_detector.scala 16:26:@6327.4]
  assign _T_343 = _T_342 | _T_302; // @[integer_collision_detector.scala 16:26:@6328.4]
  assign _T_344 = _T_343 | _T_303; // @[integer_collision_detector.scala 16:26:@6329.4]
  assign _T_345 = _T_344 | _T_304; // @[integer_collision_detector.scala 16:26:@6330.4]
  assign _T_346 = _T_345 | _T_305; // @[integer_collision_detector.scala 16:26:@6331.4]
  assign _T_347 = _T_346 | _T_306; // @[integer_collision_detector.scala 16:26:@6332.4]
  assign _T_348 = _T_347 | _T_307; // @[integer_collision_detector.scala 16:26:@6333.4]
  assign _T_349 = _T_348 | _T_308; // @[integer_collision_detector.scala 16:26:@6334.4]
  assign _T_350 = _T_349 | _T_309; // @[integer_collision_detector.scala 16:26:@6335.4]
  assign _T_351 = _T_350 | _T_310; // @[integer_collision_detector.scala 16:26:@6336.4]
  assign _T_352 = _T_351 | _T_311; // @[integer_collision_detector.scala 16:26:@6337.4]
  assign _T_353 = _T_352 | _T_312; // @[integer_collision_detector.scala 16:26:@6338.4]
  assign _T_354 = _T_353 | _T_313; // @[integer_collision_detector.scala 16:26:@6339.4]
  assign _T_355 = _T_354 | _T_314; // @[integer_collision_detector.scala 16:26:@6340.4]
  assign _T_356 = _T_355 | _T_315; // @[integer_collision_detector.scala 16:26:@6341.4]
  assign _T_357 = _T_356 | _T_316; // @[integer_collision_detector.scala 16:26:@6342.4]
  assign _T_358 = _T_357 | _T_317; // @[integer_collision_detector.scala 16:26:@6343.4]
  assign _T_359 = _T_358 | _T_318; // @[integer_collision_detector.scala 16:26:@6344.4]
  assign _T_360 = _T_359 | _T_319; // @[integer_collision_detector.scala 16:26:@6345.4]
  assign _T_361 = _T_360 | _T_320; // @[integer_collision_detector.scala 16:26:@6346.4]
  assign _T_362 = _T_361 | _T_321; // @[integer_collision_detector.scala 16:26:@6347.4]
  assign _T_363 = _T_362 | _T_322; // @[integer_collision_detector.scala 16:26:@6348.4]
  assign _T_364 = _T_363 | _T_323; // @[integer_collision_detector.scala 16:26:@6349.4]
  assign _T_365 = _T_364 | _T_324; // @[integer_collision_detector.scala 16:26:@6350.4]
  assign _T_366 = _T_365 | _T_325; // @[integer_collision_detector.scala 16:26:@6351.4]
  assign _T_367 = _T_366 | _T_326; // @[integer_collision_detector.scala 16:26:@6352.4]
  assign _T_368 = _T_367 | _T_327; // @[integer_collision_detector.scala 16:26:@6353.4]
  assign _T_370 = io_dx1_instruction_retiring_stage == 3'h2; // @[integer_collision_detector.scala 17:59:@6355.6]
  assign io_collision = _T_368 ? _T_370 : 1'h0; // @[integer_collision_detector.scala 17:18:@6357.6 integer_collision_detector.scala 19:18:@6360.6]
endmodule
module integer_issue_unit( // @[:@6363.2]
  input  [5:0] io_dx1_instruction_op, // @[:@6366.4]
  output [2:0] io_retiring_stage, // @[:@6366.4]
  output [2:0] io_functional_unit // @[:@6366.4]
);
  wire  _T_288; // @[integer_issue_unit.scala 17:29:@6493.4]
  wire  _T_289; // @[integer_issue_unit.scala 17:29:@6494.4]
  wire  _T_290; // @[integer_issue_unit.scala 17:29:@6495.4]
  wire  _T_291; // @[integer_issue_unit.scala 17:29:@6496.4]
  wire  _T_292; // @[integer_issue_unit.scala 17:29:@6497.4]
  wire  _T_293; // @[integer_issue_unit.scala 17:29:@6498.4]
  wire  _T_294; // @[integer_issue_unit.scala 17:29:@6499.4]
  wire  _T_295; // @[integer_issue_unit.scala 17:29:@6500.4]
  wire  _T_296; // @[integer_issue_unit.scala 17:29:@6501.4]
  wire  _T_297; // @[integer_issue_unit.scala 17:29:@6502.4]
  wire  _T_298; // @[integer_issue_unit.scala 17:29:@6503.4]
  wire  _T_299; // @[integer_issue_unit.scala 17:29:@6504.4]
  wire  _T_300; // @[integer_issue_unit.scala 17:29:@6505.4]
  wire  _T_301; // @[integer_issue_unit.scala 17:29:@6506.4]
  wire  _T_302; // @[integer_issue_unit.scala 17:29:@6507.4]
  wire  _T_303; // @[integer_issue_unit.scala 17:29:@6508.4]
  wire  _T_304; // @[integer_issue_unit.scala 17:29:@6509.4]
  wire  _T_305; // @[integer_issue_unit.scala 17:29:@6510.4]
  wire  _T_306; // @[integer_issue_unit.scala 17:29:@6511.4]
  wire  _T_307; // @[integer_issue_unit.scala 17:29:@6512.4]
  wire  _T_308; // @[integer_issue_unit.scala 17:29:@6513.4]
  wire  _T_309; // @[integer_issue_unit.scala 17:29:@6514.4]
  wire  _T_310; // @[integer_issue_unit.scala 17:29:@6515.4]
  wire  _T_311; // @[integer_issue_unit.scala 17:29:@6516.4]
  wire  _T_312; // @[integer_issue_unit.scala 17:29:@6517.4]
  wire  _T_313; // @[integer_issue_unit.scala 17:29:@6518.4]
  wire  _T_314; // @[integer_issue_unit.scala 17:29:@6519.4]
  wire  _T_315; // @[integer_issue_unit.scala 17:29:@6520.4]
  wire  _T_316; // @[integer_issue_unit.scala 17:29:@6521.4]
  wire  _T_317; // @[integer_issue_unit.scala 17:29:@6522.4]
  wire  _T_318; // @[integer_issue_unit.scala 17:29:@6523.4]
  wire  _T_319; // @[integer_issue_unit.scala 17:29:@6524.4]
  wire  _T_320; // @[integer_issue_unit.scala 17:29:@6525.4]
  wire  _T_321; // @[integer_issue_unit.scala 17:29:@6526.4]
  wire  _T_322; // @[integer_issue_unit.scala 17:29:@6527.4]
  wire  _T_323; // @[integer_issue_unit.scala 17:29:@6528.4]
  wire  _T_324; // @[integer_issue_unit.scala 17:29:@6529.4]
  wire  _T_325; // @[integer_issue_unit.scala 17:29:@6530.4]
  wire  _T_326; // @[integer_issue_unit.scala 17:29:@6531.4]
  wire  _T_327; // @[integer_issue_unit.scala 17:29:@6532.4]
  wire  _T_330; // @[integer_issue_unit.scala 17:26:@6534.4]
  wire  _T_331; // @[integer_issue_unit.scala 17:26:@6535.4]
  wire  _T_332; // @[integer_issue_unit.scala 17:26:@6536.4]
  wire  _T_333; // @[integer_issue_unit.scala 17:26:@6537.4]
  wire  _T_334; // @[integer_issue_unit.scala 17:26:@6538.4]
  wire  _T_335; // @[integer_issue_unit.scala 17:26:@6539.4]
  wire  _T_336; // @[integer_issue_unit.scala 17:26:@6540.4]
  wire  _T_337; // @[integer_issue_unit.scala 17:26:@6541.4]
  wire  _T_338; // @[integer_issue_unit.scala 17:26:@6542.4]
  wire  _T_339; // @[integer_issue_unit.scala 17:26:@6543.4]
  wire  _T_340; // @[integer_issue_unit.scala 17:26:@6544.4]
  wire  _T_341; // @[integer_issue_unit.scala 17:26:@6545.4]
  wire  _T_342; // @[integer_issue_unit.scala 17:26:@6546.4]
  wire  _T_343; // @[integer_issue_unit.scala 17:26:@6547.4]
  wire  _T_344; // @[integer_issue_unit.scala 17:26:@6548.4]
  wire  _T_345; // @[integer_issue_unit.scala 17:26:@6549.4]
  wire  _T_346; // @[integer_issue_unit.scala 17:26:@6550.4]
  wire  _T_347; // @[integer_issue_unit.scala 17:26:@6551.4]
  wire  _T_348; // @[integer_issue_unit.scala 17:26:@6552.4]
  wire  _T_349; // @[integer_issue_unit.scala 17:26:@6553.4]
  wire  _T_350; // @[integer_issue_unit.scala 17:26:@6554.4]
  wire  _T_351; // @[integer_issue_unit.scala 17:26:@6555.4]
  wire  _T_352; // @[integer_issue_unit.scala 17:26:@6556.4]
  wire  _T_353; // @[integer_issue_unit.scala 17:26:@6557.4]
  wire  _T_354; // @[integer_issue_unit.scala 17:26:@6558.4]
  wire  _T_355; // @[integer_issue_unit.scala 17:26:@6559.4]
  wire  _T_356; // @[integer_issue_unit.scala 17:26:@6560.4]
  wire  _T_357; // @[integer_issue_unit.scala 17:26:@6561.4]
  wire  _T_358; // @[integer_issue_unit.scala 17:26:@6562.4]
  wire  _T_359; // @[integer_issue_unit.scala 17:26:@6563.4]
  wire  _T_360; // @[integer_issue_unit.scala 17:26:@6564.4]
  wire  _T_361; // @[integer_issue_unit.scala 17:26:@6565.4]
  wire  _T_362; // @[integer_issue_unit.scala 17:26:@6566.4]
  wire  _T_363; // @[integer_issue_unit.scala 17:26:@6567.4]
  wire  _T_364; // @[integer_issue_unit.scala 17:26:@6568.4]
  wire  _T_365; // @[integer_issue_unit.scala 17:26:@6569.4]
  wire  _T_366; // @[integer_issue_unit.scala 17:26:@6570.4]
  wire  _T_367; // @[integer_issue_unit.scala 17:26:@6571.4]
  wire  _T_368; // @[integer_issue_unit.scala 17:26:@6572.4]
  wire  _T_371; // @[integer_issue_unit.scala 20:40:@6578.6]
  wire  _T_372; // @[integer_issue_unit.scala 20:40:@6579.6]
  wire  _T_375; // @[integer_issue_unit.scala 20:37:@6581.6]
  wire  _T_378; // @[integer_issue_unit.scala 23:42:@6587.8]
  wire  _T_379; // @[integer_issue_unit.scala 23:42:@6588.8]
  wire  _T_380; // @[integer_issue_unit.scala 23:42:@6589.8]
  wire  _T_381; // @[integer_issue_unit.scala 23:42:@6590.8]
  wire  _T_384; // @[integer_issue_unit.scala 23:39:@6592.8]
  wire  _T_385; // @[integer_issue_unit.scala 23:39:@6593.8]
  wire  _T_386; // @[integer_issue_unit.scala 23:39:@6594.8]
  wire [1:0] _GEN_0; // @[integer_issue_unit.scala 23:69:@6595.8]
  wire [1:0] _GEN_1; // @[integer_issue_unit.scala 23:69:@6595.8]
  wire [1:0] _GEN_2; // @[integer_issue_unit.scala 20:67:@6582.6]
  wire [1:0] _GEN_3; // @[integer_issue_unit.scala 20:67:@6582.6]
  wire [1:0] _GEN_4; // @[integer_issue_unit.scala 17:56:@6573.4]
  wire [1:0] _GEN_5; // @[integer_issue_unit.scala 17:56:@6573.4]
  assign _T_288 = 6'h0 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6493.4]
  assign _T_289 = 6'h1 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6494.4]
  assign _T_290 = 6'h2 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6495.4]
  assign _T_291 = 6'h3 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6496.4]
  assign _T_292 = 6'h4 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6497.4]
  assign _T_293 = 6'h5 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6498.4]
  assign _T_294 = 6'h6 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6499.4]
  assign _T_295 = 6'h7 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6500.4]
  assign _T_296 = 6'h8 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6501.4]
  assign _T_297 = 6'h9 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6502.4]
  assign _T_298 = 6'ha == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6503.4]
  assign _T_299 = 6'hb == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6504.4]
  assign _T_300 = 6'hc == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6505.4]
  assign _T_301 = 6'hd == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6506.4]
  assign _T_302 = 6'he == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6507.4]
  assign _T_303 = 6'hf == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6508.4]
  assign _T_304 = 6'h10 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6509.4]
  assign _T_305 = 6'h11 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6510.4]
  assign _T_306 = 6'h12 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6511.4]
  assign _T_307 = 6'h13 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6512.4]
  assign _T_308 = 6'h14 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6513.4]
  assign _T_309 = 6'h15 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6514.4]
  assign _T_310 = 6'h16 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6515.4]
  assign _T_311 = 6'h17 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6516.4]
  assign _T_312 = 6'h18 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6517.4]
  assign _T_313 = 6'h19 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6518.4]
  assign _T_314 = 6'h1a == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6519.4]
  assign _T_315 = 6'h1b == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6520.4]
  assign _T_316 = 6'h1c == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6521.4]
  assign _T_317 = 6'h1d == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6522.4]
  assign _T_318 = 6'h1e == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6523.4]
  assign _T_319 = 6'h1f == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6524.4]
  assign _T_320 = 6'h20 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6525.4]
  assign _T_321 = 6'h21 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6526.4]
  assign _T_322 = 6'h22 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6527.4]
  assign _T_323 = 6'h23 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6528.4]
  assign _T_324 = 6'h24 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6529.4]
  assign _T_325 = 6'h25 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6530.4]
  assign _T_326 = 6'h26 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6531.4]
  assign _T_327 = 6'h27 == io_dx1_instruction_op; // @[integer_issue_unit.scala 17:29:@6532.4]
  assign _T_330 = _T_288 | _T_289; // @[integer_issue_unit.scala 17:26:@6534.4]
  assign _T_331 = _T_330 | _T_290; // @[integer_issue_unit.scala 17:26:@6535.4]
  assign _T_332 = _T_331 | _T_291; // @[integer_issue_unit.scala 17:26:@6536.4]
  assign _T_333 = _T_332 | _T_292; // @[integer_issue_unit.scala 17:26:@6537.4]
  assign _T_334 = _T_333 | _T_293; // @[integer_issue_unit.scala 17:26:@6538.4]
  assign _T_335 = _T_334 | _T_294; // @[integer_issue_unit.scala 17:26:@6539.4]
  assign _T_336 = _T_335 | _T_295; // @[integer_issue_unit.scala 17:26:@6540.4]
  assign _T_337 = _T_336 | _T_296; // @[integer_issue_unit.scala 17:26:@6541.4]
  assign _T_338 = _T_337 | _T_297; // @[integer_issue_unit.scala 17:26:@6542.4]
  assign _T_339 = _T_338 | _T_298; // @[integer_issue_unit.scala 17:26:@6543.4]
  assign _T_340 = _T_339 | _T_299; // @[integer_issue_unit.scala 17:26:@6544.4]
  assign _T_341 = _T_340 | _T_300; // @[integer_issue_unit.scala 17:26:@6545.4]
  assign _T_342 = _T_341 | _T_301; // @[integer_issue_unit.scala 17:26:@6546.4]
  assign _T_343 = _T_342 | _T_302; // @[integer_issue_unit.scala 17:26:@6547.4]
  assign _T_344 = _T_343 | _T_303; // @[integer_issue_unit.scala 17:26:@6548.4]
  assign _T_345 = _T_344 | _T_304; // @[integer_issue_unit.scala 17:26:@6549.4]
  assign _T_346 = _T_345 | _T_305; // @[integer_issue_unit.scala 17:26:@6550.4]
  assign _T_347 = _T_346 | _T_306; // @[integer_issue_unit.scala 17:26:@6551.4]
  assign _T_348 = _T_347 | _T_307; // @[integer_issue_unit.scala 17:26:@6552.4]
  assign _T_349 = _T_348 | _T_308; // @[integer_issue_unit.scala 17:26:@6553.4]
  assign _T_350 = _T_349 | _T_309; // @[integer_issue_unit.scala 17:26:@6554.4]
  assign _T_351 = _T_350 | _T_310; // @[integer_issue_unit.scala 17:26:@6555.4]
  assign _T_352 = _T_351 | _T_311; // @[integer_issue_unit.scala 17:26:@6556.4]
  assign _T_353 = _T_352 | _T_312; // @[integer_issue_unit.scala 17:26:@6557.4]
  assign _T_354 = _T_353 | _T_313; // @[integer_issue_unit.scala 17:26:@6558.4]
  assign _T_355 = _T_354 | _T_314; // @[integer_issue_unit.scala 17:26:@6559.4]
  assign _T_356 = _T_355 | _T_315; // @[integer_issue_unit.scala 17:26:@6560.4]
  assign _T_357 = _T_356 | _T_316; // @[integer_issue_unit.scala 17:26:@6561.4]
  assign _T_358 = _T_357 | _T_317; // @[integer_issue_unit.scala 17:26:@6562.4]
  assign _T_359 = _T_358 | _T_318; // @[integer_issue_unit.scala 17:26:@6563.4]
  assign _T_360 = _T_359 | _T_319; // @[integer_issue_unit.scala 17:26:@6564.4]
  assign _T_361 = _T_360 | _T_320; // @[integer_issue_unit.scala 17:26:@6565.4]
  assign _T_362 = _T_361 | _T_321; // @[integer_issue_unit.scala 17:26:@6566.4]
  assign _T_363 = _T_362 | _T_322; // @[integer_issue_unit.scala 17:26:@6567.4]
  assign _T_364 = _T_363 | _T_323; // @[integer_issue_unit.scala 17:26:@6568.4]
  assign _T_365 = _T_364 | _T_324; // @[integer_issue_unit.scala 17:26:@6569.4]
  assign _T_366 = _T_365 | _T_325; // @[integer_issue_unit.scala 17:26:@6570.4]
  assign _T_367 = _T_366 | _T_326; // @[integer_issue_unit.scala 17:26:@6571.4]
  assign _T_368 = _T_367 | _T_327; // @[integer_issue_unit.scala 17:26:@6572.4]
  assign _T_371 = 6'h28 == io_dx1_instruction_op; // @[integer_issue_unit.scala 20:40:@6578.6]
  assign _T_372 = 6'h29 == io_dx1_instruction_op; // @[integer_issue_unit.scala 20:40:@6579.6]
  assign _T_375 = _T_371 | _T_372; // @[integer_issue_unit.scala 20:37:@6581.6]
  assign _T_378 = 6'h2d == io_dx1_instruction_op; // @[integer_issue_unit.scala 23:42:@6587.8]
  assign _T_379 = 6'h2e == io_dx1_instruction_op; // @[integer_issue_unit.scala 23:42:@6588.8]
  assign _T_380 = 6'h2f == io_dx1_instruction_op; // @[integer_issue_unit.scala 23:42:@6589.8]
  assign _T_381 = 6'h30 == io_dx1_instruction_op; // @[integer_issue_unit.scala 23:42:@6590.8]
  assign _T_384 = _T_378 | _T_379; // @[integer_issue_unit.scala 23:39:@6592.8]
  assign _T_385 = _T_384 | _T_380; // @[integer_issue_unit.scala 23:39:@6593.8]
  assign _T_386 = _T_385 | _T_381; // @[integer_issue_unit.scala 23:39:@6594.8]
  assign _GEN_0 = _T_386 ? 2'h3 : 2'h1; // @[integer_issue_unit.scala 23:69:@6595.8]
  assign _GEN_1 = _T_386 ? 2'h2 : 2'h0; // @[integer_issue_unit.scala 23:69:@6595.8]
  assign _GEN_2 = _T_375 ? 2'h2 : _GEN_0; // @[integer_issue_unit.scala 20:67:@6582.6]
  assign _GEN_3 = _T_375 ? 2'h1 : _GEN_1; // @[integer_issue_unit.scala 20:67:@6582.6]
  assign _GEN_4 = _T_368 ? 2'h1 : _GEN_2; // @[integer_issue_unit.scala 17:56:@6573.4]
  assign _GEN_5 = _T_368 ? 2'h0 : _GEN_3; // @[integer_issue_unit.scala 17:56:@6573.4]
  assign io_retiring_stage = {{1'd0}, _GEN_4}; // @[integer_issue_unit.scala 18:23:@6574.6 integer_issue_unit.scala 21:23:@6583.8 integer_issue_unit.scala 24:23:@6596.10 integer_issue_unit.scala 27:23:@6600.10]
  assign io_functional_unit = {{1'd0}, _GEN_5}; // @[integer_issue_unit.scala 19:24:@6575.6 integer_issue_unit.scala 22:24:@6584.8 integer_issue_unit.scala 25:24:@6597.10 integer_issue_unit.scala 28:24:@6601.10]
endmodule
module register_file( // @[:@6604.2]
  input         clock, // @[:@6605.4]
  input         reset, // @[:@6606.4]
  input         io_enable, // @[:@6607.4]
  input         io_host_interface_read_req, // @[:@6607.4]
  output        io_host_interface_read_ack, // @[:@6607.4]
  input         io_host_interface_write_req, // @[:@6607.4]
  output        io_host_interface_write_ack, // @[:@6607.4]
  input  [29:0] io_host_interface_write_index, // @[:@6607.4]
  input  [31:0] io_host_interface_write_data, // @[:@6607.4]
  input  [2:0]  io_read_indexes_0, // @[:@6607.4]
  input  [2:0]  io_read_indexes_1, // @[:@6607.4]
  input  [2:0]  io_read_indexes_2, // @[:@6607.4]
  output [31:0] io_read_data_0, // @[:@6607.4]
  output [31:0] io_read_data_1, // @[:@6607.4]
  output [31:0] io_read_data_2, // @[:@6607.4]
  input         io_write_enable, // @[:@6607.4]
  input  [2:0]  io_write_index, // @[:@6607.4]
  input  [31:0] io_write_data // @[:@6607.4]
);
  reg [31:0] registers [0:7]; // @[register_file.scala 23:22:@6609.4]
  reg [31:0] _RAND_0;
  wire [31:0] registers__T_64_data; // @[register_file.scala 23:22:@6609.4]
  wire [2:0] registers__T_64_addr; // @[register_file.scala 23:22:@6609.4]
  wire [31:0] registers__T_65_data; // @[register_file.scala 23:22:@6609.4]
  wire [2:0] registers__T_65_addr; // @[register_file.scala 23:22:@6609.4]
  wire [31:0] registers__T_66_data; // @[register_file.scala 23:22:@6609.4]
  wire [2:0] registers__T_66_addr; // @[register_file.scala 23:22:@6609.4]
  wire [31:0] registers__T_71_data; // @[register_file.scala 23:22:@6609.4]
  wire [2:0] registers__T_71_addr; // @[register_file.scala 23:22:@6609.4]
  wire [31:0] registers__T_76_data; // @[register_file.scala 23:22:@6609.4]
  wire [2:0] registers__T_76_addr; // @[register_file.scala 23:22:@6609.4]
  wire [31:0] registers__T_81_data; // @[register_file.scala 23:22:@6609.4]
  wire [2:0] registers__T_81_addr; // @[register_file.scala 23:22:@6609.4]
  wire [31:0] registers__T_86_data; // @[register_file.scala 23:22:@6609.4]
  wire [2:0] registers__T_86_addr; // @[register_file.scala 23:22:@6609.4]
  wire [31:0] registers__T_91_data; // @[register_file.scala 23:22:@6609.4]
  wire [2:0] registers__T_91_addr; // @[register_file.scala 23:22:@6609.4]
  wire [31:0] registers__T_96_data; // @[register_file.scala 23:22:@6609.4]
  wire [2:0] registers__T_96_addr; // @[register_file.scala 23:22:@6609.4]
  wire [31:0] registers__T_101_data; // @[register_file.scala 23:22:@6609.4]
  wire [2:0] registers__T_101_addr; // @[register_file.scala 23:22:@6609.4]
  wire [31:0] registers__T_106_data; // @[register_file.scala 23:22:@6609.4]
  wire [2:0] registers__T_106_addr; // @[register_file.scala 23:22:@6609.4]
  wire [31:0] registers__T_68_data; // @[register_file.scala 23:22:@6609.4]
  wire [2:0] registers__T_68_addr; // @[register_file.scala 23:22:@6609.4]
  wire  registers__T_68_mask; // @[register_file.scala 23:22:@6609.4]
  wire  registers__T_68_en; // @[register_file.scala 23:22:@6609.4]
  wire [31:0] registers__T_69_data; // @[register_file.scala 23:22:@6609.4]
  wire [2:0] registers__T_69_addr; // @[register_file.scala 23:22:@6609.4]
  wire  registers__T_69_mask; // @[register_file.scala 23:22:@6609.4]
  wire  registers__T_69_en; // @[register_file.scala 23:22:@6609.4]
  wire  _GEN_12; // @[register_file.scala 37:38:@6620.6]
  wire  _T_74; // @[register_file.scala 47:11:@6633.4]
  assign registers__T_64_addr = io_read_indexes_0;
  assign registers__T_64_data = registers[registers__T_64_addr]; // @[register_file.scala 23:22:@6609.4]
  assign registers__T_65_addr = io_read_indexes_1;
  assign registers__T_65_data = registers[registers__T_65_addr]; // @[register_file.scala 23:22:@6609.4]
  assign registers__T_66_addr = io_read_indexes_2;
  assign registers__T_66_data = registers[registers__T_66_addr]; // @[register_file.scala 23:22:@6609.4]
  assign registers__T_71_addr = 3'h0;
  assign registers__T_71_data = registers[registers__T_71_addr]; // @[register_file.scala 23:22:@6609.4]
  assign registers__T_76_addr = 3'h1;
  assign registers__T_76_data = registers[registers__T_76_addr]; // @[register_file.scala 23:22:@6609.4]
  assign registers__T_81_addr = 3'h2;
  assign registers__T_81_data = registers[registers__T_81_addr]; // @[register_file.scala 23:22:@6609.4]
  assign registers__T_86_addr = 3'h3;
  assign registers__T_86_data = registers[registers__T_86_addr]; // @[register_file.scala 23:22:@6609.4]
  assign registers__T_91_addr = 3'h4;
  assign registers__T_91_data = registers[registers__T_91_addr]; // @[register_file.scala 23:22:@6609.4]
  assign registers__T_96_addr = 3'h5;
  assign registers__T_96_data = registers[registers__T_96_addr]; // @[register_file.scala 23:22:@6609.4]
  assign registers__T_101_addr = 3'h6;
  assign registers__T_101_data = registers[registers__T_101_addr]; // @[register_file.scala 23:22:@6609.4]
  assign registers__T_106_addr = 3'h7;
  assign registers__T_106_data = registers[registers__T_106_addr]; // @[register_file.scala 23:22:@6609.4]
  assign registers__T_68_data = io_host_interface_write_data;
  assign registers__T_68_addr = io_host_interface_write_index[2:0];
  assign registers__T_68_mask = 1'h1;
  assign registers__T_68_en = io_enable ? io_host_interface_write_req : 1'h0;
  assign registers__T_69_data = io_write_data;
  assign registers__T_69_addr = io_write_index;
  assign registers__T_69_mask = 1'h1;
  assign registers__T_69_en = io_enable ? _GEN_12 : 1'h0;
  assign _GEN_12 = io_host_interface_write_req ? 1'h0 : io_write_enable; // @[register_file.scala 37:38:@6620.6]
  assign _T_74 = reset == 1'h0; // @[register_file.scala 47:11:@6633.4]
  assign io_host_interface_read_ack = io_host_interface_read_req; // @[register_file.scala 27:30:@6611.4]
  assign io_host_interface_write_ack = io_host_interface_write_req; // @[register_file.scala 30:31:@6612.4]
  assign io_read_data_0 = registers__T_64_data; // @[register_file.scala 34:21:@6614.4]
  assign io_read_data_1 = registers__T_65_data; // @[register_file.scala 34:21:@6616.4]
  assign io_read_data_2 = registers__T_66_data; // @[register_file.scala 34:21:@6618.4]
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
  _RAND_0 = {1{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 8; initvar = initvar+1)
    registers[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(registers__T_68_en & registers__T_68_mask) begin
      registers[registers__T_68_addr] <= registers__T_68_data; // @[register_file.scala 23:22:@6609.4]
    end
    if(registers__T_69_en & registers__T_69_mask) begin
      registers[registers__T_69_addr] <= registers__T_69_data; // @[register_file.scala 23:22:@6609.4]
    end
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_74) begin
          $fwrite(32'h80000002,"Memory 0 data is = %d\n",registers__T_71_data); // @[register_file.scala 47:11:@6635.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_74) begin
          $fwrite(32'h80000002,"Memory 1 data is = %d\n",registers__T_76_data); // @[register_file.scala 47:11:@6641.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_74) begin
          $fwrite(32'h80000002,"Memory 2 data is = %d\n",registers__T_81_data); // @[register_file.scala 47:11:@6647.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_74) begin
          $fwrite(32'h80000002,"Memory 3 data is = %d\n",registers__T_86_data); // @[register_file.scala 47:11:@6653.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_74) begin
          $fwrite(32'h80000002,"Memory 4 data is = %d\n",registers__T_91_data); // @[register_file.scala 47:11:@6659.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_74) begin
          $fwrite(32'h80000002,"Memory 5 data is = %d\n",registers__T_96_data); // @[register_file.scala 47:11:@6665.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_74) begin
          $fwrite(32'h80000002,"Memory 6 data is = %d\n",registers__T_101_data); // @[register_file.scala 47:11:@6671.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_74) begin
          $fwrite(32'h80000002,"Memory 7 data is = %d\n",registers__T_106_data); // @[register_file.scala 47:11:@6677.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_74) begin
          $fwrite(32'h80000002,"--------------------------------\n"); // @[register_file.scala 48:9:@6682.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module source_fetching_unit( // @[:@6685.2]
  input  [5:0]  io_st, // @[:@6688.4]
  input  [8:0]  io_si, // @[:@6688.4]
  input  [31:0] io_immediate, // @[:@6688.4]
  input  [31:0] io_input_channel_data_0, // @[:@6688.4]
  input  [31:0] io_input_channel_data_1, // @[:@6688.4]
  input  [31:0] io_input_channel_data_2, // @[:@6688.4]
  input  [31:0] io_input_channel_data_3, // @[:@6688.4]
  output [2:0]  io_register_read_indexes_0, // @[:@6688.4]
  output [2:0]  io_register_read_indexes_1, // @[:@6688.4]
  output [2:0]  io_register_read_indexes_2, // @[:@6688.4]
  input  [31:0] io_register_read_data_0, // @[:@6688.4]
  input  [31:0] io_register_read_data_1, // @[:@6688.4]
  input  [31:0] io_register_read_data_2, // @[:@6688.4]
  output [31:0] io_operands_0, // @[:@6688.4]
  output [31:0] io_operands_1, // @[:@6688.4]
  output [31:0] io_operands_2 // @[:@6688.4]
);
  wire [1:0] source_types_0; // @[source_fetching_unit.scala 24:29:@6692.4]
  wire [2:0] source_indices_0; // @[source_fetching_unit.scala 25:31:@6694.4]
  wire [1:0] source_types_1; // @[source_fetching_unit.scala 24:29:@6696.4]
  wire [2:0] source_indices_1; // @[source_fetching_unit.scala 25:31:@6698.4]
  wire [1:0] source_types_2; // @[source_fetching_unit.scala 24:29:@6700.4]
  wire [2:0] source_indices_2; // @[source_fetching_unit.scala 25:31:@6702.4]
  wire  _T_102; // @[Conditional.scala 37:30:@6706.4]
  wire  _T_106; // @[Conditional.scala 37:30:@6712.6]
  wire  _T_109; // @[Conditional.scala 37:30:@6718.8]
  wire [1:0] _T_112; // @[:@6721.10]
  wire [31:0] _GEN_1; // @[source_fetching_unit.scala 44:24:@6722.10]
  wire [31:0] _GEN_2; // @[source_fetching_unit.scala 44:24:@6722.10]
  wire [31:0] _GEN_3; // @[source_fetching_unit.scala 44:24:@6722.10]
  wire  _T_114; // @[Conditional.scala 37:30:@6725.10]
  wire [2:0] _GEN_4; // @[Conditional.scala 39:67:@6726.10]
  wire [31:0] _GEN_5; // @[Conditional.scala 39:67:@6726.10]
  wire [2:0] _GEN_6; // @[Conditional.scala 39:67:@6719.8]
  wire [31:0] _GEN_7; // @[Conditional.scala 39:67:@6719.8]
  wire [2:0] _GEN_8; // @[Conditional.scala 39:67:@6713.6]
  wire [31:0] _GEN_9; // @[Conditional.scala 39:67:@6713.6]
  wire  _T_118; // @[Conditional.scala 37:30:@6732.4]
  wire  _T_122; // @[Conditional.scala 37:30:@6738.6]
  wire  _T_125; // @[Conditional.scala 37:30:@6744.8]
  wire [1:0] _T_128; // @[:@6747.10]
  wire [31:0] _GEN_13; // @[source_fetching_unit.scala 44:24:@6748.10]
  wire [31:0] _GEN_14; // @[source_fetching_unit.scala 44:24:@6748.10]
  wire [31:0] _GEN_15; // @[source_fetching_unit.scala 44:24:@6748.10]
  wire  _T_130; // @[Conditional.scala 37:30:@6751.10]
  wire [2:0] _GEN_16; // @[Conditional.scala 39:67:@6752.10]
  wire [31:0] _GEN_17; // @[Conditional.scala 39:67:@6752.10]
  wire [2:0] _GEN_18; // @[Conditional.scala 39:67:@6745.8]
  wire [31:0] _GEN_19; // @[Conditional.scala 39:67:@6745.8]
  wire [2:0] _GEN_20; // @[Conditional.scala 39:67:@6739.6]
  wire [31:0] _GEN_21; // @[Conditional.scala 39:67:@6739.6]
  wire  _T_134; // @[Conditional.scala 37:30:@6758.4]
  wire  _T_138; // @[Conditional.scala 37:30:@6764.6]
  wire  _T_141; // @[Conditional.scala 37:30:@6770.8]
  wire [1:0] _T_144; // @[:@6773.10]
  wire [31:0] _GEN_25; // @[source_fetching_unit.scala 44:24:@6774.10]
  wire [31:0] _GEN_26; // @[source_fetching_unit.scala 44:24:@6774.10]
  wire [31:0] _GEN_27; // @[source_fetching_unit.scala 44:24:@6774.10]
  wire  _T_146; // @[Conditional.scala 37:30:@6777.10]
  wire [2:0] _GEN_28; // @[Conditional.scala 39:67:@6778.10]
  wire [31:0] _GEN_29; // @[Conditional.scala 39:67:@6778.10]
  wire [2:0] _GEN_30; // @[Conditional.scala 39:67:@6771.8]
  wire [31:0] _GEN_31; // @[Conditional.scala 39:67:@6771.8]
  wire [2:0] _GEN_32; // @[Conditional.scala 39:67:@6765.6]
  wire [31:0] _GEN_33; // @[Conditional.scala 39:67:@6765.6]
  assign source_types_0 = io_st[1:0]; // @[source_fetching_unit.scala 24:29:@6692.4]
  assign source_indices_0 = io_si[2:0]; // @[source_fetching_unit.scala 25:31:@6694.4]
  assign source_types_1 = io_st[3:2]; // @[source_fetching_unit.scala 24:29:@6696.4]
  assign source_indices_1 = io_si[5:3]; // @[source_fetching_unit.scala 25:31:@6698.4]
  assign source_types_2 = io_st[5:4]; // @[source_fetching_unit.scala 24:29:@6700.4]
  assign source_indices_2 = io_si[8:6]; // @[source_fetching_unit.scala 25:31:@6702.4]
  assign _T_102 = 2'h0 == source_types_0; // @[Conditional.scala 37:30:@6706.4]
  assign _T_106 = 2'h1 == source_types_0; // @[Conditional.scala 37:30:@6712.6]
  assign _T_109 = 2'h2 == source_types_0; // @[Conditional.scala 37:30:@6718.8]
  assign _T_112 = source_indices_0[1:0]; // @[:@6721.10]
  assign _GEN_1 = 2'h1 == _T_112 ? io_input_channel_data_1 : io_input_channel_data_0; // @[source_fetching_unit.scala 44:24:@6722.10]
  assign _GEN_2 = 2'h2 == _T_112 ? io_input_channel_data_2 : _GEN_1; // @[source_fetching_unit.scala 44:24:@6722.10]
  assign _GEN_3 = 2'h3 == _T_112 ? io_input_channel_data_3 : _GEN_2; // @[source_fetching_unit.scala 44:24:@6722.10]
  assign _T_114 = 2'h3 == source_types_0; // @[Conditional.scala 37:30:@6725.10]
  assign _GEN_4 = _T_114 ? source_indices_0 : 3'h0; // @[Conditional.scala 39:67:@6726.10]
  assign _GEN_5 = _T_114 ? io_register_read_data_0 : 32'h0; // @[Conditional.scala 39:67:@6726.10]
  assign _GEN_6 = _T_109 ? 3'h0 : _GEN_4; // @[Conditional.scala 39:67:@6719.8]
  assign _GEN_7 = _T_109 ? _GEN_3 : _GEN_5; // @[Conditional.scala 39:67:@6719.8]
  assign _GEN_8 = _T_106 ? 3'h0 : _GEN_6; // @[Conditional.scala 39:67:@6713.6]
  assign _GEN_9 = _T_106 ? io_immediate : _GEN_7; // @[Conditional.scala 39:67:@6713.6]
  assign _T_118 = 2'h0 == source_types_1; // @[Conditional.scala 37:30:@6732.4]
  assign _T_122 = 2'h1 == source_types_1; // @[Conditional.scala 37:30:@6738.6]
  assign _T_125 = 2'h2 == source_types_1; // @[Conditional.scala 37:30:@6744.8]
  assign _T_128 = source_indices_1[1:0]; // @[:@6747.10]
  assign _GEN_13 = 2'h1 == _T_128 ? io_input_channel_data_1 : io_input_channel_data_0; // @[source_fetching_unit.scala 44:24:@6748.10]
  assign _GEN_14 = 2'h2 == _T_128 ? io_input_channel_data_2 : _GEN_13; // @[source_fetching_unit.scala 44:24:@6748.10]
  assign _GEN_15 = 2'h3 == _T_128 ? io_input_channel_data_3 : _GEN_14; // @[source_fetching_unit.scala 44:24:@6748.10]
  assign _T_130 = 2'h3 == source_types_1; // @[Conditional.scala 37:30:@6751.10]
  assign _GEN_16 = _T_130 ? source_indices_1 : 3'h0; // @[Conditional.scala 39:67:@6752.10]
  assign _GEN_17 = _T_130 ? io_register_read_data_1 : 32'h0; // @[Conditional.scala 39:67:@6752.10]
  assign _GEN_18 = _T_125 ? 3'h0 : _GEN_16; // @[Conditional.scala 39:67:@6745.8]
  assign _GEN_19 = _T_125 ? _GEN_15 : _GEN_17; // @[Conditional.scala 39:67:@6745.8]
  assign _GEN_20 = _T_122 ? 3'h0 : _GEN_18; // @[Conditional.scala 39:67:@6739.6]
  assign _GEN_21 = _T_122 ? io_immediate : _GEN_19; // @[Conditional.scala 39:67:@6739.6]
  assign _T_134 = 2'h0 == source_types_2; // @[Conditional.scala 37:30:@6758.4]
  assign _T_138 = 2'h1 == source_types_2; // @[Conditional.scala 37:30:@6764.6]
  assign _T_141 = 2'h2 == source_types_2; // @[Conditional.scala 37:30:@6770.8]
  assign _T_144 = source_indices_2[1:0]; // @[:@6773.10]
  assign _GEN_25 = 2'h1 == _T_144 ? io_input_channel_data_1 : io_input_channel_data_0; // @[source_fetching_unit.scala 44:24:@6774.10]
  assign _GEN_26 = 2'h2 == _T_144 ? io_input_channel_data_2 : _GEN_25; // @[source_fetching_unit.scala 44:24:@6774.10]
  assign _GEN_27 = 2'h3 == _T_144 ? io_input_channel_data_3 : _GEN_26; // @[source_fetching_unit.scala 44:24:@6774.10]
  assign _T_146 = 2'h3 == source_types_2; // @[Conditional.scala 37:30:@6777.10]
  assign _GEN_28 = _T_146 ? source_indices_2 : 3'h0; // @[Conditional.scala 39:67:@6778.10]
  assign _GEN_29 = _T_146 ? io_register_read_data_2 : 32'h0; // @[Conditional.scala 39:67:@6778.10]
  assign _GEN_30 = _T_141 ? 3'h0 : _GEN_28; // @[Conditional.scala 39:67:@6771.8]
  assign _GEN_31 = _T_141 ? _GEN_27 : _GEN_29; // @[Conditional.scala 39:67:@6771.8]
  assign _GEN_32 = _T_138 ? 3'h0 : _GEN_30; // @[Conditional.scala 39:67:@6765.6]
  assign _GEN_33 = _T_138 ? io_immediate : _GEN_31; // @[Conditional.scala 39:67:@6765.6]
  assign io_register_read_indexes_0 = _T_102 ? 3'h0 : _GEN_8; // @[source_fetching_unit.scala 30:33:@6704.4 source_fetching_unit.scala 35:37:@6708.6 source_fetching_unit.scala 39:37:@6714.8 source_fetching_unit.scala 43:37:@6720.10 source_fetching_unit.scala 47:37:@6727.12]
  assign io_register_read_indexes_1 = _T_118 ? 3'h0 : _GEN_20; // @[source_fetching_unit.scala 30:33:@6730.4 source_fetching_unit.scala 35:37:@6734.6 source_fetching_unit.scala 39:37:@6740.8 source_fetching_unit.scala 43:37:@6746.10 source_fetching_unit.scala 47:37:@6753.12]
  assign io_register_read_indexes_2 = _T_134 ? 3'h0 : _GEN_32; // @[source_fetching_unit.scala 30:33:@6756.4 source_fetching_unit.scala 35:37:@6760.6 source_fetching_unit.scala 39:37:@6766.8 source_fetching_unit.scala 43:37:@6772.10 source_fetching_unit.scala 47:37:@6779.12]
  assign io_operands_0 = _T_102 ? 32'h0 : _GEN_9; // @[source_fetching_unit.scala 31:20:@6705.4 source_fetching_unit.scala 36:24:@6709.6 source_fetching_unit.scala 40:24:@6715.8 source_fetching_unit.scala 44:24:@6722.10 source_fetching_unit.scala 48:24:@6728.12]
  assign io_operands_1 = _T_118 ? 32'h0 : _GEN_21; // @[source_fetching_unit.scala 31:20:@6731.4 source_fetching_unit.scala 36:24:@6735.6 source_fetching_unit.scala 40:24:@6741.8 source_fetching_unit.scala 44:24:@6748.10 source_fetching_unit.scala 48:24:@6754.12]
  assign io_operands_2 = _T_134 ? 32'h0 : _GEN_33; // @[source_fetching_unit.scala 31:20:@6757.4 source_fetching_unit.scala 36:24:@6761.6 source_fetching_unit.scala 40:24:@6767.8 source_fetching_unit.scala 44:24:@6774.10 source_fetching_unit.scala 48:24:@6780.12]
endmodule
module operand_forwarding_unit( // @[:@6783.2]
  input         io_enable, // @[:@6786.4]
  input  [5:0]  io_source_types, // @[:@6786.4]
  input  [8:0]  io_source_indices, // @[:@6786.4]
  input  [1:0]  io_downstream_dt, // @[:@6786.4]
  input  [2:0]  io_downstream_di, // @[:@6786.4]
  input  [31:0] io_downstream_result, // @[:@6786.4]
  input  [31:0] io_pre_ofu_operands_0, // @[:@6786.4]
  input  [31:0] io_pre_ofu_operands_1, // @[:@6786.4]
  output [31:0] io_post_ofu_operands_0, // @[:@6786.4]
  output [31:0] io_post_ofu_operands_1 // @[:@6786.4]
);
  wire [1:0] source_types_0; // @[operand_forwarding_unit.scala 26:39:@6790.4]
  wire [2:0] source_indices_0; // @[operand_forwarding_unit.scala 27:43:@6792.4]
  wire [1:0] source_types_1; // @[operand_forwarding_unit.scala 26:39:@6794.4]
  wire [2:0] source_indices_1; // @[operand_forwarding_unit.scala 27:43:@6796.4]
  wire  _T_72; // @[operand_forwarding_unit.scala 32:28:@6803.6]
  wire  _T_74; // @[operand_forwarding_unit.scala 33:26:@6804.6]
  wire  _T_75; // @[operand_forwarding_unit.scala 32:59:@6805.6]
  wire  _T_76; // @[operand_forwarding_unit.scala 34:27:@6806.6]
  wire  _T_77; // @[operand_forwarding_unit.scala 33:62:@6807.6]
  wire [31:0] _GEN_0; // @[operand_forwarding_unit.scala 34:48:@6808.6]
  wire  _T_79; // @[operand_forwarding_unit.scala 32:28:@6819.6]
  wire  _T_82; // @[operand_forwarding_unit.scala 32:59:@6821.6]
  wire  _T_83; // @[operand_forwarding_unit.scala 34:27:@6822.6]
  wire  _T_84; // @[operand_forwarding_unit.scala 33:62:@6823.6]
  wire [31:0] _GEN_2; // @[operand_forwarding_unit.scala 34:48:@6824.6]
  assign source_types_0 = io_source_types[1:0]; // @[operand_forwarding_unit.scala 26:39:@6790.4]
  assign source_indices_0 = io_source_indices[2:0]; // @[operand_forwarding_unit.scala 27:43:@6792.4]
  assign source_types_1 = io_source_types[3:2]; // @[operand_forwarding_unit.scala 26:39:@6794.4]
  assign source_indices_1 = io_source_indices[5:3]; // @[operand_forwarding_unit.scala 27:43:@6796.4]
  assign _T_72 = source_types_0 == 2'h3; // @[operand_forwarding_unit.scala 32:28:@6803.6]
  assign _T_74 = io_downstream_dt == 2'h2; // @[operand_forwarding_unit.scala 33:26:@6804.6]
  assign _T_75 = _T_72 & _T_74; // @[operand_forwarding_unit.scala 32:59:@6805.6]
  assign _T_76 = source_indices_0 == io_downstream_di; // @[operand_forwarding_unit.scala 34:27:@6806.6]
  assign _T_77 = _T_75 & _T_76; // @[operand_forwarding_unit.scala 33:62:@6807.6]
  assign _GEN_0 = _T_77 ? io_downstream_result : io_pre_ofu_operands_0; // @[operand_forwarding_unit.scala 34:48:@6808.6]
  assign _T_79 = source_types_1 == 2'h3; // @[operand_forwarding_unit.scala 32:28:@6819.6]
  assign _T_82 = _T_79 & _T_74; // @[operand_forwarding_unit.scala 32:59:@6821.6]
  assign _T_83 = source_indices_1 == io_downstream_di; // @[operand_forwarding_unit.scala 34:27:@6822.6]
  assign _T_84 = _T_82 & _T_83; // @[operand_forwarding_unit.scala 33:62:@6823.6]
  assign _GEN_2 = _T_84 ? io_downstream_result : io_pre_ofu_operands_1; // @[operand_forwarding_unit.scala 34:48:@6824.6]
  assign io_post_ofu_operands_0 = io_enable ? _GEN_0 : io_pre_ofu_operands_0; // @[operand_forwarding_unit.scala 35:33:@6809.8 operand_forwarding_unit.scala 37:33:@6812.8 operand_forwarding_unit.scala 40:31:@6816.6]
  assign io_post_ofu_operands_1 = io_enable ? _GEN_2 : io_pre_ofu_operands_1; // @[operand_forwarding_unit.scala 35:33:@6825.8 operand_forwarding_unit.scala 37:33:@6828.8 operand_forwarding_unit.scala 40:31:@6832.6]
endmodule
module arithmetic_logic_unit( // @[:@6851.2]
  input         clock, // @[:@6852.4]
  input         reset, // @[:@6853.4]
  input  [3:0]  io_opcode, // @[:@6854.4]
  input  [31:0] io_operands_0, // @[:@6854.4]
  input  [31:0] io_operands_1, // @[:@6854.4]
  input  [31:0] io_operands_2, // @[:@6854.4]
  output [31:0] io_result // @[:@6854.4]
);
  wire [31:0] operand0_signed; // @[arithmetic_logic_unit.scala 45:43:@6996.4]
  wire [31:0] operand1_signed; // @[arithmetic_logic_unit.scala 46:43:@6998.4]
  wire  _T_319; // @[arithmetic_logic_unit.scala 55:49:@7004.4]
  wire [31:0] _T_320; // @[arithmetic_logic_unit.scala 55:100:@7006.6]
  wire [31:0] _GEN_0; // @[arithmetic_logic_unit.scala 55:66:@7005.4]
  wire  _T_322; // @[arithmetic_logic_unit.scala 56:49:@7009.4]
  wire  _T_323; // @[arithmetic_logic_unit.scala 56:101:@7011.6]
  wire  _T_324; // @[arithmetic_logic_unit.scala 56:126:@7012.6]
  wire [31:0] result_signed; // @[arithmetic_logic_unit.scala 56:66:@7010.4]
  wire  _T_329; // @[arithmetic_logic_unit.scala 69:49:@7018.4]
  wire [31:0] _GEN_2; // @[arithmetic_logic_unit.scala 69:65:@7019.4]
  wire  _T_331; // @[arithmetic_logic_unit.scala 70:49:@7022.4]
  wire [32:0] _T_332; // @[arithmetic_logic_unit.scala 70:103:@7024.6]
  wire [31:0] _T_333; // @[arithmetic_logic_unit.scala 70:103:@7025.6]
  wire [31:0] _GEN_3; // @[arithmetic_logic_unit.scala 70:65:@7023.4]
  wire  _T_335; // @[arithmetic_logic_unit.scala 71:49:@7028.4]
  wire [32:0] _T_336; // @[arithmetic_logic_unit.scala 71:103:@7030.6]
  wire [32:0] _T_337; // @[arithmetic_logic_unit.scala 71:103:@7031.6]
  wire [31:0] _T_338; // @[arithmetic_logic_unit.scala 71:103:@7032.6]
  wire [31:0] _GEN_4; // @[arithmetic_logic_unit.scala 71:65:@7029.4]
  wire  _T_340; // @[arithmetic_logic_unit.scala 72:49:@7035.4]
  wire [18:0] _T_341; // @[arithmetic_logic_unit.scala 72:123:@7037.6]
  wire [524318:0] _GEN_12; // @[arithmetic_logic_unit.scala 72:103:@7038.6]
  wire [524318:0] _T_342; // @[arithmetic_logic_unit.scala 72:103:@7038.6]
  wire [524318:0] _GEN_5; // @[arithmetic_logic_unit.scala 72:65:@7036.4]
  wire  _T_344; // @[arithmetic_logic_unit.scala 73:49:@7041.4]
  wire [31:0] _T_345; // @[arithmetic_logic_unit.scala 73:103:@7043.6]
  wire [524318:0] _GEN_6; // @[arithmetic_logic_unit.scala 73:65:@7042.4]
  wire  _T_347; // @[arithmetic_logic_unit.scala 74:48:@7046.4]
  wire  _T_348; // @[arithmetic_logic_unit.scala 74:101:@7048.6]
  wire [524318:0] _GEN_7; // @[arithmetic_logic_unit.scala 74:63:@7047.4]
  wire  _T_350; // @[arithmetic_logic_unit.scala 75:48:@7051.4]
  wire  _T_351; // @[arithmetic_logic_unit.scala 75:101:@7053.6]
  wire [524318:0] _GEN_8; // @[arithmetic_logic_unit.scala 75:63:@7052.4]
  wire [5:0] _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7058.4]
  wire  _T_354; // @[arithmetic_logic_unit.scala 144:32:@7058.4]
  wire  _T_355; // @[arithmetic_logic_unit.scala 144:32:@7059.4]
  wire  _T_356; // @[arithmetic_logic_unit.scala 144:32:@7060.4]
  wire  _T_357; // @[arithmetic_logic_unit.scala 144:32:@7061.4]
  wire  _T_358; // @[arithmetic_logic_unit.scala 144:32:@7062.4]
  wire  _T_359; // @[arithmetic_logic_unit.scala 144:32:@7063.4]
  wire  _T_360; // @[arithmetic_logic_unit.scala 144:32:@7064.4]
  wire  _T_361; // @[arithmetic_logic_unit.scala 144:32:@7065.4]
  wire  _T_362; // @[arithmetic_logic_unit.scala 144:32:@7066.4]
  wire  _T_363; // @[arithmetic_logic_unit.scala 144:32:@7067.4]
  wire  _T_364; // @[arithmetic_logic_unit.scala 144:32:@7068.4]
  wire  _T_365; // @[arithmetic_logic_unit.scala 144:32:@7069.4]
  wire  _T_366; // @[arithmetic_logic_unit.scala 144:32:@7070.4]
  wire  _T_367; // @[arithmetic_logic_unit.scala 144:32:@7071.4]
  wire  _T_368; // @[arithmetic_logic_unit.scala 144:32:@7072.4]
  wire  _T_369; // @[arithmetic_logic_unit.scala 144:32:@7073.4]
  wire  _T_370; // @[arithmetic_logic_unit.scala 144:32:@7074.4]
  wire  _T_371; // @[arithmetic_logic_unit.scala 144:32:@7075.4]
  wire  _T_372; // @[arithmetic_logic_unit.scala 144:32:@7076.4]
  wire  _T_373; // @[arithmetic_logic_unit.scala 144:32:@7077.4]
  wire  _T_374; // @[arithmetic_logic_unit.scala 144:32:@7078.4]
  wire  _T_375; // @[arithmetic_logic_unit.scala 144:32:@7079.4]
  wire  _T_376; // @[arithmetic_logic_unit.scala 144:32:@7080.4]
  wire  _T_377; // @[arithmetic_logic_unit.scala 144:32:@7081.4]
  wire  _T_378; // @[arithmetic_logic_unit.scala 144:32:@7082.4]
  wire  _T_379; // @[arithmetic_logic_unit.scala 144:32:@7083.4]
  wire  _T_380; // @[arithmetic_logic_unit.scala 144:32:@7084.4]
  wire  _T_381; // @[arithmetic_logic_unit.scala 144:32:@7085.4]
  wire  _T_382; // @[arithmetic_logic_unit.scala 144:32:@7086.4]
  wire  _T_383; // @[arithmetic_logic_unit.scala 144:32:@7087.4]
  wire  _T_384; // @[arithmetic_logic_unit.scala 144:32:@7088.4]
  wire  _T_387; // @[arithmetic_logic_unit.scala 144:29:@7090.4]
  wire  _T_388; // @[arithmetic_logic_unit.scala 144:29:@7091.4]
  wire  _T_389; // @[arithmetic_logic_unit.scala 144:29:@7092.4]
  wire  _T_390; // @[arithmetic_logic_unit.scala 144:29:@7093.4]
  wire  _T_391; // @[arithmetic_logic_unit.scala 144:29:@7094.4]
  wire  _T_392; // @[arithmetic_logic_unit.scala 144:29:@7095.4]
  wire  _T_393; // @[arithmetic_logic_unit.scala 144:29:@7096.4]
  wire  _T_394; // @[arithmetic_logic_unit.scala 144:29:@7097.4]
  wire  _T_395; // @[arithmetic_logic_unit.scala 144:29:@7098.4]
  wire  _T_396; // @[arithmetic_logic_unit.scala 144:29:@7099.4]
  wire  _T_397; // @[arithmetic_logic_unit.scala 144:29:@7100.4]
  wire  _T_398; // @[arithmetic_logic_unit.scala 144:29:@7101.4]
  wire  _T_399; // @[arithmetic_logic_unit.scala 144:29:@7102.4]
  wire  _T_400; // @[arithmetic_logic_unit.scala 144:29:@7103.4]
  wire  _T_401; // @[arithmetic_logic_unit.scala 144:29:@7104.4]
  wire  _T_402; // @[arithmetic_logic_unit.scala 144:29:@7105.4]
  wire  _T_403; // @[arithmetic_logic_unit.scala 144:29:@7106.4]
  wire  _T_404; // @[arithmetic_logic_unit.scala 144:29:@7107.4]
  wire  _T_405; // @[arithmetic_logic_unit.scala 144:29:@7108.4]
  wire  _T_406; // @[arithmetic_logic_unit.scala 144:29:@7109.4]
  wire  _T_407; // @[arithmetic_logic_unit.scala 144:29:@7110.4]
  wire  _T_408; // @[arithmetic_logic_unit.scala 144:29:@7111.4]
  wire  _T_409; // @[arithmetic_logic_unit.scala 144:29:@7112.4]
  wire  _T_410; // @[arithmetic_logic_unit.scala 144:29:@7113.4]
  wire  _T_411; // @[arithmetic_logic_unit.scala 144:29:@7114.4]
  wire  _T_412; // @[arithmetic_logic_unit.scala 144:29:@7115.4]
  wire  _T_413; // @[arithmetic_logic_unit.scala 144:29:@7116.4]
  wire  _T_414; // @[arithmetic_logic_unit.scala 144:29:@7117.4]
  wire  _T_415; // @[arithmetic_logic_unit.scala 144:29:@7118.4]
  wire  _T_416; // @[arithmetic_logic_unit.scala 144:29:@7119.4]
  wire  _T_417; // @[arithmetic_logic_unit.scala 146:39:@7124.6]
  wire  _T_418; // @[arithmetic_logic_unit.scala 146:39:@7125.6]
  wire  _T_419; // @[arithmetic_logic_unit.scala 146:39:@7126.6]
  wire  _T_420; // @[arithmetic_logic_unit.scala 146:39:@7127.6]
  wire  _T_421; // @[arithmetic_logic_unit.scala 146:39:@7128.6]
  wire  _T_424; // @[arithmetic_logic_unit.scala 146:35:@7130.6]
  wire  _T_425; // @[arithmetic_logic_unit.scala 146:35:@7131.6]
  wire  _T_426; // @[arithmetic_logic_unit.scala 146:35:@7132.6]
  wire  _T_427; // @[arithmetic_logic_unit.scala 146:35:@7133.6]
  wire [31:0] _T_428; // @[arithmetic_logic_unit.scala 147:38:@7135.8]
  wire [31:0] _GEN_10; // @[arithmetic_logic_unit.scala 146:47:@7134.6]
  wire [31:0] result_unsigned; // @[arithmetic_logic_unit.scala 38:29:@6990.4 arithmetic_logic_unit.scala 39:40:@6992.4 arithmetic_logic_unit.scala 51:19:@7003.4 arithmetic_logic_unit.scala 69:82:@7020.6 arithmetic_logic_unit.scala 70:82:@7026.6 arithmetic_logic_unit.scala 71:82:@7033.6 arithmetic_logic_unit.scala 72:82:@7039.6 arithmetic_logic_unit.scala 73:82:@7044.6 arithmetic_logic_unit.scala 74:80:@7049.6 arithmetic_logic_unit.scala 75:80:@7054.6]
  wire  _T_459; // @[arithmetic_logic_unit.scala 154:9:@7172.4]
  assign operand0_signed = $signed(io_operands_0); // @[arithmetic_logic_unit.scala 45:43:@6996.4]
  assign operand1_signed = $signed(io_operands_1); // @[arithmetic_logic_unit.scala 46:43:@6998.4]
  assign _T_319 = io_opcode == 4'h5; // @[arithmetic_logic_unit.scala 55:49:@7004.4]
  assign _T_320 = $signed(operand0_signed) >>> io_operands_1; // @[arithmetic_logic_unit.scala 55:100:@7006.6]
  assign _GEN_0 = _T_319 ? $signed(_T_320) : $signed(32'sh0); // @[arithmetic_logic_unit.scala 55:66:@7005.4]
  assign _T_322 = io_opcode == 4'h9; // @[arithmetic_logic_unit.scala 56:49:@7009.4]
  assign _T_323 = $signed(operand0_signed) > $signed(operand1_signed); // @[arithmetic_logic_unit.scala 56:101:@7011.6]
  assign _T_324 = $signed(_T_323); // @[arithmetic_logic_unit.scala 56:126:@7012.6]
  assign result_signed = _T_322 ? $signed({32{_T_324}}) : $signed(_GEN_0); // @[arithmetic_logic_unit.scala 56:66:@7010.4]
  assign _T_329 = io_opcode == 4'h1; // @[arithmetic_logic_unit.scala 69:49:@7018.4]
  assign _GEN_2 = _T_329 ? io_operands_0 : 32'h0; // @[arithmetic_logic_unit.scala 69:65:@7019.4]
  assign _T_331 = io_opcode == 4'h2; // @[arithmetic_logic_unit.scala 70:49:@7022.4]
  assign _T_332 = io_operands_0 + io_operands_1; // @[arithmetic_logic_unit.scala 70:103:@7024.6]
  assign _T_333 = io_operands_0 + io_operands_1; // @[arithmetic_logic_unit.scala 70:103:@7025.6]
  assign _GEN_3 = _T_331 ? _T_333 : _GEN_2; // @[arithmetic_logic_unit.scala 70:65:@7023.4]
  assign _T_335 = io_opcode == 4'h3; // @[arithmetic_logic_unit.scala 71:49:@7028.4]
  assign _T_336 = io_operands_0 - io_operands_1; // @[arithmetic_logic_unit.scala 71:103:@7030.6]
  assign _T_337 = $unsigned(_T_336); // @[arithmetic_logic_unit.scala 71:103:@7031.6]
  assign _T_338 = _T_337[31:0]; // @[arithmetic_logic_unit.scala 71:103:@7032.6]
  assign _GEN_4 = _T_335 ? _T_338 : _GEN_3; // @[arithmetic_logic_unit.scala 71:65:@7029.4]
  assign _T_340 = io_opcode == 4'h4; // @[arithmetic_logic_unit.scala 72:49:@7035.4]
  assign _T_341 = io_operands_1[18:0]; // @[arithmetic_logic_unit.scala 72:123:@7037.6]
  assign _GEN_12 = {{524287'd0}, io_operands_0}; // @[arithmetic_logic_unit.scala 72:103:@7038.6]
  assign _T_342 = _GEN_12 << _T_341; // @[arithmetic_logic_unit.scala 72:103:@7038.6]
  assign _GEN_5 = _T_340 ? _T_342 : {{524287'd0}, _GEN_4}; // @[arithmetic_logic_unit.scala 72:65:@7036.4]
  assign _T_344 = io_opcode == 4'h6; // @[arithmetic_logic_unit.scala 73:49:@7041.4]
  assign _T_345 = io_operands_0 >> io_operands_1; // @[arithmetic_logic_unit.scala 73:103:@7043.6]
  assign _GEN_6 = _T_344 ? {{524287'd0}, _T_345} : _GEN_5; // @[arithmetic_logic_unit.scala 73:65:@7042.4]
  assign _T_347 = io_opcode == 4'h7; // @[arithmetic_logic_unit.scala 74:48:@7046.4]
  assign _T_348 = io_operands_0 == io_operands_1; // @[arithmetic_logic_unit.scala 74:101:@7048.6]
  assign _GEN_7 = _T_347 ? {{524318'd0}, _T_348} : _GEN_6; // @[arithmetic_logic_unit.scala 74:63:@7047.4]
  assign _T_350 = io_opcode == 4'h8; // @[arithmetic_logic_unit.scala 75:48:@7051.4]
  assign _T_351 = io_operands_0 != io_operands_1; // @[arithmetic_logic_unit.scala 75:101:@7053.6]
  assign _GEN_8 = _T_350 ? {{524318'd0}, _T_351} : _GEN_7; // @[arithmetic_logic_unit.scala 75:63:@7052.4]
  assign _GEN_13 = {{2'd0}, io_opcode}; // @[arithmetic_logic_unit.scala 144:32:@7058.4]
  assign _T_354 = 6'h0 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7058.4]
  assign _T_355 = 6'h1 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7059.4]
  assign _T_356 = 6'h2 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7060.4]
  assign _T_357 = 6'h3 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7061.4]
  assign _T_358 = 6'h4 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7062.4]
  assign _T_359 = 6'h6 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7063.4]
  assign _T_360 = 6'h7 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7064.4]
  assign _T_361 = 6'h8 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7065.4]
  assign _T_362 = 6'ha == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7066.4]
  assign _T_363 = 6'hc == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7067.4]
  assign _T_364 = 6'he == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7068.4]
  assign _T_365 = 6'h10 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7069.4]
  assign _T_366 = 6'h11 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7070.4]
  assign _T_367 = 6'h12 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7071.4]
  assign _T_368 = 6'h13 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7072.4]
  assign _T_369 = 6'h14 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7073.4]
  assign _T_370 = 6'h15 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7074.4]
  assign _T_371 = 6'h16 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7075.4]
  assign _T_372 = 6'h17 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7076.4]
  assign _T_373 = 6'h18 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7077.4]
  assign _T_374 = 6'h19 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7078.4]
  assign _T_375 = 6'h1a == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7079.4]
  assign _T_376 = 6'h1b == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7080.4]
  assign _T_377 = 6'h1c == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7081.4]
  assign _T_378 = 6'h21 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7082.4]
  assign _T_379 = 6'h22 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7083.4]
  assign _T_380 = 6'h23 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7084.4]
  assign _T_381 = 6'h24 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7085.4]
  assign _T_382 = 6'h25 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7086.4]
  assign _T_383 = 6'h26 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7087.4]
  assign _T_384 = 6'h27 == _GEN_13; // @[arithmetic_logic_unit.scala 144:32:@7088.4]
  assign _T_387 = _T_354 | _T_355; // @[arithmetic_logic_unit.scala 144:29:@7090.4]
  assign _T_388 = _T_387 | _T_356; // @[arithmetic_logic_unit.scala 144:29:@7091.4]
  assign _T_389 = _T_388 | _T_357; // @[arithmetic_logic_unit.scala 144:29:@7092.4]
  assign _T_390 = _T_389 | _T_358; // @[arithmetic_logic_unit.scala 144:29:@7093.4]
  assign _T_391 = _T_390 | _T_359; // @[arithmetic_logic_unit.scala 144:29:@7094.4]
  assign _T_392 = _T_391 | _T_360; // @[arithmetic_logic_unit.scala 144:29:@7095.4]
  assign _T_393 = _T_392 | _T_361; // @[arithmetic_logic_unit.scala 144:29:@7096.4]
  assign _T_394 = _T_393 | _T_362; // @[arithmetic_logic_unit.scala 144:29:@7097.4]
  assign _T_395 = _T_394 | _T_363; // @[arithmetic_logic_unit.scala 144:29:@7098.4]
  assign _T_396 = _T_395 | _T_364; // @[arithmetic_logic_unit.scala 144:29:@7099.4]
  assign _T_397 = _T_396 | _T_365; // @[arithmetic_logic_unit.scala 144:29:@7100.4]
  assign _T_398 = _T_397 | _T_366; // @[arithmetic_logic_unit.scala 144:29:@7101.4]
  assign _T_399 = _T_398 | _T_367; // @[arithmetic_logic_unit.scala 144:29:@7102.4]
  assign _T_400 = _T_399 | _T_368; // @[arithmetic_logic_unit.scala 144:29:@7103.4]
  assign _T_401 = _T_400 | _T_369; // @[arithmetic_logic_unit.scala 144:29:@7104.4]
  assign _T_402 = _T_401 | _T_370; // @[arithmetic_logic_unit.scala 144:29:@7105.4]
  assign _T_403 = _T_402 | _T_371; // @[arithmetic_logic_unit.scala 144:29:@7106.4]
  assign _T_404 = _T_403 | _T_372; // @[arithmetic_logic_unit.scala 144:29:@7107.4]
  assign _T_405 = _T_404 | _T_373; // @[arithmetic_logic_unit.scala 144:29:@7108.4]
  assign _T_406 = _T_405 | _T_374; // @[arithmetic_logic_unit.scala 144:29:@7109.4]
  assign _T_407 = _T_406 | _T_375; // @[arithmetic_logic_unit.scala 144:29:@7110.4]
  assign _T_408 = _T_407 | _T_376; // @[arithmetic_logic_unit.scala 144:29:@7111.4]
  assign _T_409 = _T_408 | _T_377; // @[arithmetic_logic_unit.scala 144:29:@7112.4]
  assign _T_410 = _T_409 | _T_378; // @[arithmetic_logic_unit.scala 144:29:@7113.4]
  assign _T_411 = _T_410 | _T_379; // @[arithmetic_logic_unit.scala 144:29:@7114.4]
  assign _T_412 = _T_411 | _T_380; // @[arithmetic_logic_unit.scala 144:29:@7115.4]
  assign _T_413 = _T_412 | _T_381; // @[arithmetic_logic_unit.scala 144:29:@7116.4]
  assign _T_414 = _T_413 | _T_382; // @[arithmetic_logic_unit.scala 144:29:@7117.4]
  assign _T_415 = _T_414 | _T_383; // @[arithmetic_logic_unit.scala 144:29:@7118.4]
  assign _T_416 = _T_415 | _T_384; // @[arithmetic_logic_unit.scala 144:29:@7119.4]
  assign _T_417 = 4'h5 == io_opcode; // @[arithmetic_logic_unit.scala 146:39:@7124.6]
  assign _T_418 = 4'h9 == io_opcode; // @[arithmetic_logic_unit.scala 146:39:@7125.6]
  assign _T_419 = 4'hb == io_opcode; // @[arithmetic_logic_unit.scala 146:39:@7126.6]
  assign _T_420 = 4'hd == io_opcode; // @[arithmetic_logic_unit.scala 146:39:@7127.6]
  assign _T_421 = 4'hf == io_opcode; // @[arithmetic_logic_unit.scala 146:39:@7128.6]
  assign _T_424 = _T_417 | _T_418; // @[arithmetic_logic_unit.scala 146:35:@7130.6]
  assign _T_425 = _T_424 | _T_419; // @[arithmetic_logic_unit.scala 146:35:@7131.6]
  assign _T_426 = _T_425 | _T_420; // @[arithmetic_logic_unit.scala 146:35:@7132.6]
  assign _T_427 = _T_426 | _T_421; // @[arithmetic_logic_unit.scala 146:35:@7133.6]
  assign _T_428 = $unsigned(result_signed); // @[arithmetic_logic_unit.scala 147:38:@7135.8]
  assign _GEN_10 = _T_427 ? _T_428 : 32'h0; // @[arithmetic_logic_unit.scala 146:47:@7134.6]
  assign result_unsigned = _GEN_8[31:0]; // @[arithmetic_logic_unit.scala 38:29:@6990.4 arithmetic_logic_unit.scala 39:40:@6992.4 arithmetic_logic_unit.scala 51:19:@7003.4 arithmetic_logic_unit.scala 69:82:@7020.6 arithmetic_logic_unit.scala 70:82:@7026.6 arithmetic_logic_unit.scala 71:82:@7033.6 arithmetic_logic_unit.scala 72:82:@7039.6 arithmetic_logic_unit.scala 73:82:@7044.6 arithmetic_logic_unit.scala 74:80:@7049.6 arithmetic_logic_unit.scala 75:80:@7054.6]
  assign _T_459 = reset == 1'h0; // @[arithmetic_logic_unit.scala 154:9:@7172.4]
  assign io_result = _T_416 ? result_unsigned : _GEN_10; // @[arithmetic_logic_unit.scala 145:15:@7121.6 arithmetic_logic_unit.scala 147:15:@7136.8 arithmetic_logic_unit.scala 149:15:@7166.10 arithmetic_logic_unit.scala 151:15:@7169.10]
  always @(posedge clock) begin
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_459) begin
          $fwrite(32'h80000002,"opcode = %d\n",io_opcode); // @[arithmetic_logic_unit.scala 154:9:@7174.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_459) begin
          $fwrite(32'h80000002,"operand 0 = %d\n",io_operands_0); // @[arithmetic_logic_unit.scala 155:9:@7179.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_459) begin
          $fwrite(32'h80000002,"operand 1 = %d\n",io_operands_1); // @[arithmetic_logic_unit.scala 156:9:@7184.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_459) begin
          $fwrite(32'h80000002,"operand 2 = %d\n",io_operands_2); // @[arithmetic_logic_unit.scala 157:9:@7189.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_459) begin
          $fwrite(32'h80000002,"result = %d\n",io_result); // @[arithmetic_logic_unit.scala 158:9:@7194.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
    `ifndef SYNTHESIS
    `ifdef PRINTF_COND
      if (`PRINTF_COND) begin
    `endif
        if (_T_459) begin
          $fwrite(32'h80000002,"-----------------------------------\n"); // @[arithmetic_logic_unit.scala 159:9:@7199.6]
        end
    `ifdef PRINTF_COND
      end
    `endif
    `endif // SYNTHESIS
  end
endmodule
module single_port_ram( // @[:@7202.2]
  input         clock, // @[:@7203.4]
  input         io_read_enable, // @[:@7205.4]
  input         io_write_enable, // @[:@7205.4]
  input  [9:0]  io_index, // @[:@7205.4]
  output [31:0] io_read_data, // @[:@7205.4]
  input  [31:0] io_write_data // @[:@7205.4]
);
  reg [31:0] mem [0:1023]; // @[single_port_ram.scala 17:24:@7207.4]
  reg [31:0] _RAND_0;
  wire [31:0] mem__T_23_data; // @[single_port_ram.scala 17:24:@7207.4]
  wire [9:0] mem__T_23_addr; // @[single_port_ram.scala 17:24:@7207.4]
  wire [31:0] mem__T_17_data; // @[single_port_ram.scala 17:24:@7207.4]
  wire [9:0] mem__T_17_addr; // @[single_port_ram.scala 17:24:@7207.4]
  wire  mem__T_17_mask; // @[single_port_ram.scala 17:24:@7207.4]
  wire  mem__T_17_en; // @[single_port_ram.scala 17:24:@7207.4]
  wire  _GEN_6; // @[single_port_ram.scala 22:27:@7214.4]
  reg [9:0] mem__T_23_addr_pipe_0;
  reg [31:0] _RAND_1;
  assign mem__T_23_addr = mem__T_23_addr_pipe_0;
  assign mem__T_23_data = mem[mem__T_23_addr]; // @[single_port_ram.scala 17:24:@7207.4]
  assign mem__T_17_data = io_write_data;
  assign mem__T_17_addr = io_index;
  assign mem__T_17_mask = 1'h1;
  assign mem__T_17_en = io_write_enable;
  assign _GEN_6 = io_read_enable; // @[single_port_ram.scala 22:27:@7214.4]
  assign io_read_data = mem__T_23_data; // @[single_port_ram.scala 22:16:@7220.4]
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
  _RAND_0 = {1{`RANDOM}};
  `ifdef RANDOMIZE_MEM_INIT
  for (initvar = 0; initvar < 1024; initvar = initvar+1)
    mem[initvar] = _RAND_0[31:0];
  `endif // RANDOMIZE_MEM_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  mem__T_23_addr_pipe_0 = _RAND_1[9:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if(mem__T_17_en & mem__T_17_mask) begin
      mem[mem__T_17_addr] <= mem__T_17_data; // @[single_port_ram.scala 17:24:@7207.4]
    end
    if (_GEN_6) begin
      mem__T_23_addr_pipe_0 <= io_index;
    end
  end
endmodule
module scratchpad( // @[:@7222.2]
  input         clock, // @[:@7223.4]
  input  [5:0]  io_opcode, // @[:@7225.4]
  input         io_hostInterface_read_req, // @[:@7225.4]
  output        io_hostInterface_read_ack, // @[:@7225.4]
  input         io_hostInterface_write_req, // @[:@7225.4]
  output        io_hostInterface_write_ack, // @[:@7225.4]
  input  [29:0] io_hostInterface_write_index, // @[:@7225.4]
  input  [31:0] io_hostInterface_write_data, // @[:@7225.4]
  input  [31:0] io_operand0, // @[:@7225.4]
  input  [31:0] io_operand1, // @[:@7225.4]
  output [31:0] io_result // @[:@7225.4]
);
  wire  spram_clock; // @[scratchpad.scala 25:21:@7231.4]
  wire  spram_io_read_enable; // @[scratchpad.scala 25:21:@7231.4]
  wire  spram_io_write_enable; // @[scratchpad.scala 25:21:@7231.4]
  wire [9:0] spram_io_index; // @[scratchpad.scala 25:21:@7231.4]
  wire [31:0] spram_io_read_data; // @[scratchpad.scala 25:21:@7231.4]
  wire [31:0] spram_io_write_data; // @[scratchpad.scala 25:21:@7231.4]
  wire [9:0] _T_40; // @[scratchpad.scala 49:42:@7253.8]
  wire  _T_42; // @[scratchpad.scala 51:20:@7257.8]
  wire [9:0] _T_45; // @[scratchpad.scala 54:27:@7261.10]
  wire  _T_47; // @[scratchpad.scala 55:26:@7265.10]
  wire [9:0] _T_50; // @[scratchpad.scala 58:27:@7269.12]
  wire [9:0] _GEN_2; // @[scratchpad.scala 55:43:@7266.10]
  wire  _GEN_4; // @[scratchpad.scala 51:37:@7258.8]
  wire [9:0] _GEN_5; // @[scratchpad.scala 51:37:@7258.8]
  wire  _GEN_6; // @[scratchpad.scala 46:41:@7250.6]
  wire  _GEN_7; // @[scratchpad.scala 46:41:@7250.6]
  wire [9:0] _GEN_8; // @[scratchpad.scala 46:41:@7250.6]
  single_port_ram spram ( // @[scratchpad.scala 25:21:@7231.4]
    .clock(spram_clock),
    .io_read_enable(spram_io_read_enable),
    .io_write_enable(spram_io_write_enable),
    .io_index(spram_io_index),
    .io_read_data(spram_io_read_data),
    .io_write_data(spram_io_write_data)
  );
  assign _T_40 = io_hostInterface_write_index[9:0]; // @[scratchpad.scala 49:42:@7253.8]
  assign _T_42 = io_opcode == 6'h28; // @[scratchpad.scala 51:20:@7257.8]
  assign _T_45 = io_operand0[9:0]; // @[scratchpad.scala 54:27:@7261.10]
  assign _T_47 = io_opcode == 6'h29; // @[scratchpad.scala 55:26:@7265.10]
  assign _T_50 = io_operand1[9:0]; // @[scratchpad.scala 58:27:@7269.12]
  assign _GEN_2 = _T_47 ? _T_50 : 10'h0; // @[scratchpad.scala 55:43:@7266.10]
  assign _GEN_4 = _T_42 ? 1'h0 : _T_47; // @[scratchpad.scala 51:37:@7258.8]
  assign _GEN_5 = _T_42 ? _T_45 : _GEN_2; // @[scratchpad.scala 51:37:@7258.8]
  assign _GEN_6 = io_hostInterface_write_req ? 1'h0 : _T_42; // @[scratchpad.scala 46:41:@7250.6]
  assign _GEN_7 = io_hostInterface_write_req ? 1'h1 : _GEN_4; // @[scratchpad.scala 46:41:@7250.6]
  assign _GEN_8 = io_hostInterface_write_req ? _T_40 : _GEN_5; // @[scratchpad.scala 46:41:@7250.6]
  assign io_hostInterface_read_ack = io_hostInterface_read_req; // @[scratchpad.scala 34:29:@7240.4]
  assign io_hostInterface_write_ack = io_hostInterface_write_req; // @[scratchpad.scala 37:30:@7241.4]
  assign io_result = spram_io_read_data; // @[scratchpad.scala 29:13:@7237.4]
  assign spram_clock = clock; // @[:@7232.4]
  assign spram_io_read_enable = io_hostInterface_read_req ? 1'h0 : _GEN_6; // @[scratchpad.scala 26:24:@7234.4]
  assign spram_io_write_enable = io_hostInterface_read_req ? 1'h0 : _GEN_7; // @[scratchpad.scala 27:25:@7235.4]
  assign spram_io_index = io_hostInterface_read_req ? 10'h0 : _GEN_8; // @[scratchpad.scala 28:18:@7236.4]
  assign spram_io_write_data = io_hostInterface_write_req ? io_hostInterface_write_data : io_operand0; // @[scratchpad.scala 30:23:@7238.4]
endmodule
module integer_retirement_unit( // @[:@7296.2]
  input  [2:0]  io_dx1_instruction_retiring_stage, // @[:@7299.4]
  input  [2:0]  io_x2_instruction_retiring_stage, // @[:@7299.4]
  input  [2:0]  io_x2_functional_unit, // @[:@7299.4]
  input         io_dx1_datapath_instruction_vi, // @[:@7299.4]
  input  [5:0]  io_dx1_datapath_instruction_op, // @[:@7299.4]
  input  [1:0]  io_dx1_datapath_instruction_dt, // @[:@7299.4]
  input  [2:0]  io_dx1_datapath_instruction_di, // @[:@7299.4]
  input  [3:0]  io_dx1_datapath_instruction_oci, // @[:@7299.4]
  input  [1:0]  io_dx1_datapath_instruction_oct, // @[:@7299.4]
  input         io_x2_datapath_instruction_vi, // @[:@7299.4]
  input  [5:0]  io_x2_datapath_instruction_op, // @[:@7299.4]
  input  [1:0]  io_x2_datapath_instruction_dt, // @[:@7299.4]
  input  [2:0]  io_x2_datapath_instruction_di, // @[:@7299.4]
  input  [3:0]  io_x2_datapath_instruction_oci, // @[:@7299.4]
  input  [1:0]  io_x2_datapath_instruction_oct, // @[:@7299.4]
  input  [31:0] io_alu_result, // @[:@7299.4]
  input  [31:0] io_sm_result, // @[:@7299.4]
  output        io_retiring_datapath_instruction_vi, // @[:@7299.4]
  output [5:0]  io_retiring_datapath_instruction_op, // @[:@7299.4]
  output [1:0]  io_retiring_datapath_instruction_dt, // @[:@7299.4]
  output [2:0]  io_retiring_datapath_instruction_di, // @[:@7299.4]
  output [3:0]  io_retiring_datapath_instruction_oci, // @[:@7299.4]
  output [1:0]  io_retiring_datapath_instruction_oct, // @[:@7299.4]
  output [31:0] io_datapath_result // @[:@7299.4]
);
  wire  _T_28; // @[integer_retirement_unit.scala 23:41:@7301.4]
  wire  _T_30; // @[Conditional.scala 37:30:@7315.6]
  wire  _T_32; // @[Conditional.scala 37:30:@7320.8]
  wire [31:0] _GEN_0; // @[Conditional.scala 39:67:@7321.8]
  wire [31:0] _GEN_1; // @[Conditional.scala 40:58:@7316.6]
  wire  _T_34; // @[integer_retirement_unit.scala 30:48:@7326.6]
  wire [1:0] _GEN_5; // @[integer_retirement_unit.scala 30:56:@7327.6]
  wire [3:0] _GEN_6; // @[integer_retirement_unit.scala 30:56:@7327.6]
  wire [2:0] _GEN_7; // @[integer_retirement_unit.scala 30:56:@7327.6]
  wire [1:0] _GEN_8; // @[integer_retirement_unit.scala 30:56:@7327.6]
  wire [5:0] _GEN_11; // @[integer_retirement_unit.scala 30:56:@7327.6]
  wire  _GEN_12; // @[integer_retirement_unit.scala 30:56:@7327.6]
  assign _T_28 = io_x2_instruction_retiring_stage == 3'h2; // @[integer_retirement_unit.scala 23:41:@7301.4]
  assign _T_30 = 3'h1 == io_x2_functional_unit; // @[Conditional.scala 37:30:@7315.6]
  assign _T_32 = 3'h2 == io_x2_functional_unit; // @[Conditional.scala 37:30:@7320.8]
  assign _GEN_0 = _T_32 ? 32'h0 : io_alu_result; // @[Conditional.scala 39:67:@7321.8]
  assign _GEN_1 = _T_30 ? io_sm_result : _GEN_0; // @[Conditional.scala 40:58:@7316.6]
  assign _T_34 = io_dx1_instruction_retiring_stage == 3'h1; // @[integer_retirement_unit.scala 30:48:@7326.6]
  assign _GEN_5 = _T_34 ? io_dx1_datapath_instruction_oct : 2'h0; // @[integer_retirement_unit.scala 30:56:@7327.6]
  assign _GEN_6 = _T_34 ? io_dx1_datapath_instruction_oci : 4'h0; // @[integer_retirement_unit.scala 30:56:@7327.6]
  assign _GEN_7 = _T_34 ? io_dx1_datapath_instruction_di : 3'h0; // @[integer_retirement_unit.scala 30:56:@7327.6]
  assign _GEN_8 = _T_34 ? io_dx1_datapath_instruction_dt : 2'h0; // @[integer_retirement_unit.scala 30:56:@7327.6]
  assign _GEN_11 = _T_34 ? io_dx1_datapath_instruction_op : 6'h0; // @[integer_retirement_unit.scala 30:56:@7327.6]
  assign _GEN_12 = _T_34 ? io_dx1_datapath_instruction_vi : 1'h0; // @[integer_retirement_unit.scala 30:56:@7327.6]
  assign io_retiring_datapath_instruction_vi = _T_28 ? io_x2_datapath_instruction_vi : _GEN_12; // @[integer_retirement_unit.scala 24:38:@7313.6 integer_retirement_unit.scala 31:38:@7338.8 integer_retirement_unit.scala 34:38:@7355.8]
  assign io_retiring_datapath_instruction_op = _T_28 ? io_x2_datapath_instruction_op : _GEN_11; // @[integer_retirement_unit.scala 24:38:@7312.6 integer_retirement_unit.scala 31:38:@7337.8 integer_retirement_unit.scala 34:38:@7354.8]
  assign io_retiring_datapath_instruction_dt = _T_28 ? io_x2_datapath_instruction_dt : _GEN_8; // @[integer_retirement_unit.scala 24:38:@7309.6 integer_retirement_unit.scala 31:38:@7334.8 integer_retirement_unit.scala 34:38:@7351.8]
  assign io_retiring_datapath_instruction_di = _T_28 ? io_x2_datapath_instruction_di : _GEN_7; // @[integer_retirement_unit.scala 24:38:@7308.6 integer_retirement_unit.scala 31:38:@7333.8 integer_retirement_unit.scala 34:38:@7350.8]
  assign io_retiring_datapath_instruction_oci = _T_28 ? io_x2_datapath_instruction_oci : _GEN_6; // @[integer_retirement_unit.scala 24:38:@7307.6 integer_retirement_unit.scala 31:38:@7332.8 integer_retirement_unit.scala 34:38:@7349.8]
  assign io_retiring_datapath_instruction_oct = _T_28 ? io_x2_datapath_instruction_oct : _GEN_5; // @[integer_retirement_unit.scala 24:38:@7306.6 integer_retirement_unit.scala 31:38:@7331.8 integer_retirement_unit.scala 34:38:@7348.8]
  assign io_datapath_result = _T_28 ? _GEN_1 : io_alu_result; // @[integer_retirement_unit.scala 25:24:@7314.6 integer_retirement_unit.scala 27:35:@7317.8 integer_retirement_unit.scala 28:36:@7322.10 integer_retirement_unit.scala 32:24:@7339.8 integer_retirement_unit.scala 35:24:@7356.8]
endmodule
module destination_routing_unit( // @[:@7359.2]
  input  [31:0] io_datapath_result, // @[:@7362.4]
  input  [1:0]  io_dt, // @[:@7362.4]
  input  [2:0]  io_di, // @[:@7362.4]
  input  [3:0]  io_oci, // @[:@7362.4]
  output        io_register_write_enable, // @[:@7362.4]
  output [2:0]  io_register_write_index, // @[:@7362.4]
  output [31:0] io_register_write_data, // @[:@7362.4]
  output [31:0] io_output_channel_data_0, // @[:@7362.4]
  output [31:0] io_output_channel_data_1, // @[:@7362.4]
  output [31:0] io_output_channel_data_2, // @[:@7362.4]
  output [31:0] io_output_channel_data_3 // @[:@7362.4]
);
  wire  _T_37; // @[destination_routing_unit.scala 20:16:@7364.4]
  wire  _T_39; // @[destination_routing_unit.scala 20:16:@7371.4]
  wire  _T_41; // @[destination_routing_unit.scala 20:16:@7378.4]
  wire  _T_43; // @[destination_routing_unit.scala 20:16:@7385.4]
  wire  _T_46; // @[destination_routing_unit.scala 26:15:@7392.4]
  assign _T_37 = io_oci[0]; // @[destination_routing_unit.scala 20:16:@7364.4]
  assign _T_39 = io_oci[1]; // @[destination_routing_unit.scala 20:16:@7371.4]
  assign _T_41 = io_oci[2]; // @[destination_routing_unit.scala 20:16:@7378.4]
  assign _T_43 = io_oci[3]; // @[destination_routing_unit.scala 20:16:@7385.4]
  assign _T_46 = io_dt == 2'h2; // @[destination_routing_unit.scala 26:15:@7392.4]
  assign io_register_write_enable = io_dt == 2'h2; // @[destination_routing_unit.scala 29:30:@7396.6 destination_routing_unit.scala 33:30:@7401.6]
  assign io_register_write_index = _T_46 ? io_di : 3'h0; // @[destination_routing_unit.scala 28:29:@7395.6 destination_routing_unit.scala 32:29:@7400.6]
  assign io_register_write_data = _T_46 ? io_datapath_result : 32'h0; // @[destination_routing_unit.scala 27:28:@7394.6 destination_routing_unit.scala 31:28:@7399.6]
  assign io_output_channel_data_0 = _T_37 ? io_datapath_result : 32'h0; // @[destination_routing_unit.scala 21:33:@7366.6 destination_routing_unit.scala 23:33:@7369.6]
  assign io_output_channel_data_1 = _T_39 ? io_datapath_result : 32'h0; // @[destination_routing_unit.scala 21:33:@7373.6 destination_routing_unit.scala 23:33:@7376.6]
  assign io_output_channel_data_2 = _T_41 ? io_datapath_result : 32'h0; // @[destination_routing_unit.scala 21:33:@7380.6 destination_routing_unit.scala 23:33:@7383.6]
  assign io_output_channel_data_3 = _T_43 ? io_datapath_result : 32'h0; // @[destination_routing_unit.scala 21:33:@7387.6 destination_routing_unit.scala 23:33:@7390.6]
endmodule
module dequeueing_unit( // @[:@7404.2]
  input        io_enable, // @[:@7407.4]
  input  [3:0] io_icd, // @[:@7407.4]
  output [3:0] io_dequeue_signals // @[:@7407.4]
);
  assign io_dequeue_signals = io_enable ? io_icd : 4'h0; // @[dequeueing_unit.scala 12:22:@7410.4]
endmodule
module enqueueing_unit( // @[:@7412.2]
  input        io_enable, // @[:@7415.4]
  input  [3:0] io_oci, // @[:@7415.4]
  input  [1:0] io_oct, // @[:@7415.4]
  output [3:0] io_enqueue_signals, // @[:@7415.4]
  output [1:0] io_outout_channel_tags_0, // @[:@7415.4]
  output [1:0] io_outout_channel_tags_1, // @[:@7415.4]
  output [1:0] io_outout_channel_tags_2, // @[:@7415.4]
  output [1:0] io_outout_channel_tags_3 // @[:@7415.4]
);
  wire  _T_33; // @[enqueueing_unit.scala 17:58:@7420.6]
  wire [1:0] _T_35; // @[enqueueing_unit.scala 17:39:@7421.6]
  wire  _T_36; // @[enqueueing_unit.scala 17:58:@7423.6]
  wire [1:0] _T_38; // @[enqueueing_unit.scala 17:39:@7424.6]
  wire  _T_39; // @[enqueueing_unit.scala 17:58:@7426.6]
  wire [1:0] _T_41; // @[enqueueing_unit.scala 17:39:@7427.6]
  wire  _T_42; // @[enqueueing_unit.scala 17:58:@7429.6]
  wire [1:0] _T_44; // @[enqueueing_unit.scala 17:39:@7430.6]
  assign _T_33 = io_enqueue_signals[0]; // @[enqueueing_unit.scala 17:58:@7420.6]
  assign _T_35 = _T_33 ? io_oct : 2'h0; // @[enqueueing_unit.scala 17:39:@7421.6]
  assign _T_36 = io_enqueue_signals[1]; // @[enqueueing_unit.scala 17:58:@7423.6]
  assign _T_38 = _T_36 ? io_oct : 2'h0; // @[enqueueing_unit.scala 17:39:@7424.6]
  assign _T_39 = io_enqueue_signals[2]; // @[enqueueing_unit.scala 17:58:@7426.6]
  assign _T_41 = _T_39 ? io_oct : 2'h0; // @[enqueueing_unit.scala 17:39:@7427.6]
  assign _T_42 = io_enqueue_signals[3]; // @[enqueueing_unit.scala 17:58:@7429.6]
  assign _T_44 = _T_42 ? io_oct : 2'h0; // @[enqueueing_unit.scala 17:39:@7430.6]
  assign io_enqueue_signals = io_enable ? io_oci : 4'h0; // @[enqueueing_unit.scala 14:22:@7418.4]
  assign io_outout_channel_tags_0 = io_enable ? _T_35 : 2'h0; // @[enqueueing_unit.scala 17:33:@7422.6 enqueueing_unit.scala 21:33:@7434.6]
  assign io_outout_channel_tags_1 = io_enable ? _T_38 : 2'h0; // @[enqueueing_unit.scala 17:33:@7425.6 enqueueing_unit.scala 21:33:@7435.6]
  assign io_outout_channel_tags_2 = io_enable ? _T_41 : 2'h0; // @[enqueueing_unit.scala 17:33:@7428.6 enqueueing_unit.scala 21:33:@7436.6]
  assign io_outout_channel_tags_3 = io_enable ? _T_44 : 2'h0; // @[enqueueing_unit.scala 17:33:@7431.6 enqueueing_unit.scala 21:33:@7437.6]
endmodule
module integer_core( // @[:@7440.2]
  input         clock, // @[:@7441.4]
  input         reset, // @[:@7442.4]
  input         io_enable, // @[:@7443.4]
  input         io_execute, // @[:@7443.4]
  output        io_halted, // @[:@7443.4]
  output        io_channels_quiescent, // @[:@7443.4]
  input         io_host_interface_read_req, // @[:@7443.4]
  output        io_host_interface_read_ack, // @[:@7443.4]
  input  [29:0] io_host_interface_read_index, // @[:@7443.4]
  output [31:0] io_host_interface_read_data, // @[:@7443.4]
  input         io_host_interface_write_req, // @[:@7443.4]
  output        io_host_interface_write_ack, // @[:@7443.4]
  input  [29:0] io_host_interface_write_index, // @[:@7443.4]
  input  [31:0] io_host_interface_write_data, // @[:@7443.4]
  input         io_input_channel_links_0_req, // @[:@7443.4]
  output        io_input_channel_links_0_ack, // @[:@7443.4]
  input  [1:0]  io_input_channel_links_0_packet_tag, // @[:@7443.4]
  input  [31:0] io_input_channel_links_0_packet_data, // @[:@7443.4]
  input         io_input_channel_links_1_req, // @[:@7443.4]
  output        io_input_channel_links_1_ack, // @[:@7443.4]
  input  [1:0]  io_input_channel_links_1_packet_tag, // @[:@7443.4]
  input  [31:0] io_input_channel_links_1_packet_data, // @[:@7443.4]
  input         io_input_channel_links_2_req, // @[:@7443.4]
  output        io_input_channel_links_2_ack, // @[:@7443.4]
  input  [1:0]  io_input_channel_links_2_packet_tag, // @[:@7443.4]
  input  [31:0] io_input_channel_links_2_packet_data, // @[:@7443.4]
  input         io_input_channel_links_3_req, // @[:@7443.4]
  output        io_input_channel_links_3_ack, // @[:@7443.4]
  input  [1:0]  io_input_channel_links_3_packet_tag, // @[:@7443.4]
  input  [31:0] io_input_channel_links_3_packet_data, // @[:@7443.4]
  input         io_output_channel_links_0_req, // @[:@7443.4]
  output        io_output_channel_links_0_ack, // @[:@7443.4]
  output [1:0]  io_output_channel_links_0_packet_tag, // @[:@7443.4]
  output [31:0] io_output_channel_links_0_packet_data, // @[:@7443.4]
  input         io_output_channel_links_1_req, // @[:@7443.4]
  output        io_output_channel_links_1_ack, // @[:@7443.4]
  output [1:0]  io_output_channel_links_1_packet_tag, // @[:@7443.4]
  output [31:0] io_output_channel_links_1_packet_data, // @[:@7443.4]
  input         io_output_channel_links_2_req, // @[:@7443.4]
  output        io_output_channel_links_2_ack, // @[:@7443.4]
  output [1:0]  io_output_channel_links_2_packet_tag, // @[:@7443.4]
  output [31:0] io_output_channel_links_2_packet_data, // @[:@7443.4]
  input         io_output_channel_links_3_req, // @[:@7443.4]
  output        io_output_channel_links_3_ack, // @[:@7443.4]
  output [1:0]  io_output_channel_links_3_packet_tag, // @[:@7443.4]
  output [31:0] io_output_channel_links_3_packet_data // @[:@7443.4]
);
  wire  input_channel_buffer_clock; // @[integer_core.scala 41:11:@7578.4]
  wire  input_channel_buffer_reset; // @[integer_core.scala 41:11:@7578.4]
  wire  input_channel_buffer_io_enable; // @[integer_core.scala 41:11:@7578.4]
  wire  input_channel_buffer_io_in_req; // @[integer_core.scala 41:11:@7578.4]
  wire  input_channel_buffer_io_in_ack; // @[integer_core.scala 41:11:@7578.4]
  wire [1:0] input_channel_buffer_io_in_packet_tag; // @[integer_core.scala 41:11:@7578.4]
  wire [31:0] input_channel_buffer_io_in_packet_data; // @[integer_core.scala 41:11:@7578.4]
  wire [1:0] input_channel_buffer_io_out_pack_tag; // @[integer_core.scala 41:11:@7578.4]
  wire [31:0] input_channel_buffer_io_out_pack_data; // @[integer_core.scala 41:11:@7578.4]
  wire [1:0] input_channel_buffer_io_out_next_pack_tag; // @[integer_core.scala 41:11:@7578.4]
  wire  input_channel_buffer_io_out_dequeue; // @[integer_core.scala 41:11:@7578.4]
  wire  input_channel_buffer_io_out_empty; // @[integer_core.scala 41:11:@7578.4]
  wire  input_channel_buffer_io_quiescent; // @[integer_core.scala 41:11:@7578.4]
  wire  input_channel_buffer_1_clock; // @[integer_core.scala 41:11:@7581.4]
  wire  input_channel_buffer_1_reset; // @[integer_core.scala 41:11:@7581.4]
  wire  input_channel_buffer_1_io_enable; // @[integer_core.scala 41:11:@7581.4]
  wire  input_channel_buffer_1_io_in_req; // @[integer_core.scala 41:11:@7581.4]
  wire  input_channel_buffer_1_io_in_ack; // @[integer_core.scala 41:11:@7581.4]
  wire [1:0] input_channel_buffer_1_io_in_packet_tag; // @[integer_core.scala 41:11:@7581.4]
  wire [31:0] input_channel_buffer_1_io_in_packet_data; // @[integer_core.scala 41:11:@7581.4]
  wire [1:0] input_channel_buffer_1_io_out_pack_tag; // @[integer_core.scala 41:11:@7581.4]
  wire [31:0] input_channel_buffer_1_io_out_pack_data; // @[integer_core.scala 41:11:@7581.4]
  wire [1:0] input_channel_buffer_1_io_out_next_pack_tag; // @[integer_core.scala 41:11:@7581.4]
  wire  input_channel_buffer_1_io_out_dequeue; // @[integer_core.scala 41:11:@7581.4]
  wire  input_channel_buffer_1_io_out_empty; // @[integer_core.scala 41:11:@7581.4]
  wire  input_channel_buffer_1_io_quiescent; // @[integer_core.scala 41:11:@7581.4]
  wire  input_channel_buffer_2_clock; // @[integer_core.scala 41:11:@7584.4]
  wire  input_channel_buffer_2_reset; // @[integer_core.scala 41:11:@7584.4]
  wire  input_channel_buffer_2_io_enable; // @[integer_core.scala 41:11:@7584.4]
  wire  input_channel_buffer_2_io_in_req; // @[integer_core.scala 41:11:@7584.4]
  wire  input_channel_buffer_2_io_in_ack; // @[integer_core.scala 41:11:@7584.4]
  wire [1:0] input_channel_buffer_2_io_in_packet_tag; // @[integer_core.scala 41:11:@7584.4]
  wire [31:0] input_channel_buffer_2_io_in_packet_data; // @[integer_core.scala 41:11:@7584.4]
  wire [1:0] input_channel_buffer_2_io_out_pack_tag; // @[integer_core.scala 41:11:@7584.4]
  wire [31:0] input_channel_buffer_2_io_out_pack_data; // @[integer_core.scala 41:11:@7584.4]
  wire [1:0] input_channel_buffer_2_io_out_next_pack_tag; // @[integer_core.scala 41:11:@7584.4]
  wire  input_channel_buffer_2_io_out_dequeue; // @[integer_core.scala 41:11:@7584.4]
  wire  input_channel_buffer_2_io_out_empty; // @[integer_core.scala 41:11:@7584.4]
  wire  input_channel_buffer_2_io_quiescent; // @[integer_core.scala 41:11:@7584.4]
  wire  input_channel_buffer_3_clock; // @[integer_core.scala 41:11:@7587.4]
  wire  input_channel_buffer_3_reset; // @[integer_core.scala 41:11:@7587.4]
  wire  input_channel_buffer_3_io_enable; // @[integer_core.scala 41:11:@7587.4]
  wire  input_channel_buffer_3_io_in_req; // @[integer_core.scala 41:11:@7587.4]
  wire  input_channel_buffer_3_io_in_ack; // @[integer_core.scala 41:11:@7587.4]
  wire [1:0] input_channel_buffer_3_io_in_packet_tag; // @[integer_core.scala 41:11:@7587.4]
  wire [31:0] input_channel_buffer_3_io_in_packet_data; // @[integer_core.scala 41:11:@7587.4]
  wire [1:0] input_channel_buffer_3_io_out_pack_tag; // @[integer_core.scala 41:11:@7587.4]
  wire [31:0] input_channel_buffer_3_io_out_pack_data; // @[integer_core.scala 41:11:@7587.4]
  wire [1:0] input_channel_buffer_3_io_out_next_pack_tag; // @[integer_core.scala 41:11:@7587.4]
  wire  input_channel_buffer_3_io_out_dequeue; // @[integer_core.scala 41:11:@7587.4]
  wire  input_channel_buffer_3_io_out_empty; // @[integer_core.scala 41:11:@7587.4]
  wire  input_channel_buffer_3_io_quiescent; // @[integer_core.scala 41:11:@7587.4]
  wire  output_channel_buffer_clock; // @[integer_core.scala 44:11:@7590.4]
  wire  output_channel_buffer_reset; // @[integer_core.scala 44:11:@7590.4]
  wire  output_channel_buffer_io_enable; // @[integer_core.scala 44:11:@7590.4]
  wire [1:0] output_channel_buffer_io_in_pack_tag; // @[integer_core.scala 44:11:@7590.4]
  wire [31:0] output_channel_buffer_io_in_pack_data; // @[integer_core.scala 44:11:@7590.4]
  wire  output_channel_buffer_io_in_enqueue; // @[integer_core.scala 44:11:@7590.4]
  wire  output_channel_buffer_io_in_full; // @[integer_core.scala 44:11:@7590.4]
  wire  output_channel_buffer_io_out_req; // @[integer_core.scala 44:11:@7590.4]
  wire  output_channel_buffer_io_out_ack; // @[integer_core.scala 44:11:@7590.4]
  wire [1:0] output_channel_buffer_io_out_packet_tag; // @[integer_core.scala 44:11:@7590.4]
  wire [31:0] output_channel_buffer_io_out_packet_data; // @[integer_core.scala 44:11:@7590.4]
  wire  output_channel_buffer_io_quiescent; // @[integer_core.scala 44:11:@7590.4]
  wire  output_channel_buffer_1_clock; // @[integer_core.scala 44:11:@7593.4]
  wire  output_channel_buffer_1_reset; // @[integer_core.scala 44:11:@7593.4]
  wire  output_channel_buffer_1_io_enable; // @[integer_core.scala 44:11:@7593.4]
  wire [1:0] output_channel_buffer_1_io_in_pack_tag; // @[integer_core.scala 44:11:@7593.4]
  wire [31:0] output_channel_buffer_1_io_in_pack_data; // @[integer_core.scala 44:11:@7593.4]
  wire  output_channel_buffer_1_io_in_enqueue; // @[integer_core.scala 44:11:@7593.4]
  wire  output_channel_buffer_1_io_in_full; // @[integer_core.scala 44:11:@7593.4]
  wire  output_channel_buffer_1_io_out_req; // @[integer_core.scala 44:11:@7593.4]
  wire  output_channel_buffer_1_io_out_ack; // @[integer_core.scala 44:11:@7593.4]
  wire [1:0] output_channel_buffer_1_io_out_packet_tag; // @[integer_core.scala 44:11:@7593.4]
  wire [31:0] output_channel_buffer_1_io_out_packet_data; // @[integer_core.scala 44:11:@7593.4]
  wire  output_channel_buffer_1_io_quiescent; // @[integer_core.scala 44:11:@7593.4]
  wire  output_channel_buffer_2_clock; // @[integer_core.scala 44:11:@7596.4]
  wire  output_channel_buffer_2_reset; // @[integer_core.scala 44:11:@7596.4]
  wire  output_channel_buffer_2_io_enable; // @[integer_core.scala 44:11:@7596.4]
  wire [1:0] output_channel_buffer_2_io_in_pack_tag; // @[integer_core.scala 44:11:@7596.4]
  wire [31:0] output_channel_buffer_2_io_in_pack_data; // @[integer_core.scala 44:11:@7596.4]
  wire  output_channel_buffer_2_io_in_enqueue; // @[integer_core.scala 44:11:@7596.4]
  wire  output_channel_buffer_2_io_in_full; // @[integer_core.scala 44:11:@7596.4]
  wire  output_channel_buffer_2_io_out_req; // @[integer_core.scala 44:11:@7596.4]
  wire  output_channel_buffer_2_io_out_ack; // @[integer_core.scala 44:11:@7596.4]
  wire [1:0] output_channel_buffer_2_io_out_packet_tag; // @[integer_core.scala 44:11:@7596.4]
  wire [31:0] output_channel_buffer_2_io_out_packet_data; // @[integer_core.scala 44:11:@7596.4]
  wire  output_channel_buffer_2_io_quiescent; // @[integer_core.scala 44:11:@7596.4]
  wire  output_channel_buffer_3_clock; // @[integer_core.scala 44:11:@7599.4]
  wire  output_channel_buffer_3_reset; // @[integer_core.scala 44:11:@7599.4]
  wire  output_channel_buffer_3_io_enable; // @[integer_core.scala 44:11:@7599.4]
  wire [1:0] output_channel_buffer_3_io_in_pack_tag; // @[integer_core.scala 44:11:@7599.4]
  wire [31:0] output_channel_buffer_3_io_in_pack_data; // @[integer_core.scala 44:11:@7599.4]
  wire  output_channel_buffer_3_io_in_enqueue; // @[integer_core.scala 44:11:@7599.4]
  wire  output_channel_buffer_3_io_in_full; // @[integer_core.scala 44:11:@7599.4]
  wire  output_channel_buffer_3_io_out_req; // @[integer_core.scala 44:11:@7599.4]
  wire  output_channel_buffer_3_io_out_ack; // @[integer_core.scala 44:11:@7599.4]
  wire [1:0] output_channel_buffer_3_io_out_packet_tag; // @[integer_core.scala 44:11:@7599.4]
  wire [31:0] output_channel_buffer_3_io_out_packet_data; // @[integer_core.scala 44:11:@7599.4]
  wire  output_channel_buffer_3_io_quiescent; // @[integer_core.scala 44:11:@7599.4]
  wire  core_mapper_io_host_interface_read_req; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_host_interface_read_ack; // @[integer_core.scala 98:20:@7738.4]
  wire [29:0] core_mapper_io_host_interface_read_index; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_host_interface_write_req; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_host_interface_write_ack; // @[integer_core.scala 98:20:@7738.4]
  wire [29:0] core_mapper_io_host_interface_write_index; // @[integer_core.scala 98:20:@7738.4]
  wire [31:0] core_mapper_io_host_interface_write_data; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_register_file_interface_read_req; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_register_file_interface_read_ack; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_register_file_interface_write_req; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_register_file_interface_write_ack; // @[integer_core.scala 98:20:@7738.4]
  wire [29:0] core_mapper_io_register_file_interface_write_index; // @[integer_core.scala 98:20:@7738.4]
  wire [31:0] core_mapper_io_register_file_interface_write_data; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_instruction_memory_interface_read_req; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_instruction_memory_interface_read_ack; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_instruction_memory_interface_write_req; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_instruction_memory_interface_write_ack; // @[integer_core.scala 98:20:@7738.4]
  wire [29:0] core_mapper_io_instruction_memory_interface_write_index; // @[integer_core.scala 98:20:@7738.4]
  wire [31:0] core_mapper_io_instruction_memory_interface_write_data; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_scratchpad_memory_interface_read_req; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_scratchpad_memory_interface_read_ack; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_scratchpad_memory_interface_write_req; // @[integer_core.scala 98:20:@7738.4]
  wire  core_mapper_io_scratchpad_memory_interface_write_ack; // @[integer_core.scala 98:20:@7738.4]
  wire [29:0] core_mapper_io_scratchpad_memory_interface_write_index; // @[integer_core.scala 98:20:@7738.4]
  wire [31:0] core_mapper_io_scratchpad_memory_interface_write_data; // @[integer_core.scala 98:20:@7738.4]
  wire  execution_control_unit_reset; // @[integer_core.scala 115:19:@7805.4]
  wire  execution_control_unit_io_enable; // @[integer_core.scala 115:19:@7805.4]
  wire  execution_control_unit_io_execute; // @[integer_core.scala 115:19:@7805.4]
  wire [5:0] execution_control_unit_io_opcode; // @[integer_core.scala 115:19:@7805.4]
  wire [3:0] execution_control_unit_io_input_channel_quiescent_status; // @[integer_core.scala 115:19:@7805.4]
  wire [3:0] execution_control_unit_io_output_channel_quiescent_status; // @[integer_core.scala 115:19:@7805.4]
  wire  execution_control_unit_io_internal_reset; // @[integer_core.scala 115:19:@7805.4]
  wire  execution_control_unit_io_internal_enable; // @[integer_core.scala 115:19:@7805.4]
  wire  execution_control_unit_io_halted; // @[integer_core.scala 115:19:@7805.4]
  wire  execution_control_unit_io_channels_quiescent; // @[integer_core.scala 115:19:@7805.4]
  wire  pu_clock; // @[integer_core.scala 127:18:@7833.4]
  wire  pu_reset; // @[integer_core.scala 127:18:@7833.4]
  wire  pu_io_enable; // @[integer_core.scala 127:18:@7833.4]
  wire [1:0] pu_io_datapath_dt; // @[integer_core.scala 127:18:@7833.4]
  wire [2:0] pu_io_datapath_di; // @[integer_core.scala 127:18:@7833.4]
  wire [31:0] pu_io_datapath_result; // @[integer_core.scala 127:18:@7833.4]
  wire [15:0] pu_io_instruction_pum; // @[integer_core.scala 127:18:@7833.4]
  wire [7:0] pu_io_predicates; // @[integer_core.scala 127:18:@7833.4]
  wire [3:0] pessimistic_one_stage_input_channel_empty_status_updater_io_input_channel_empty_status; // @[integer_core.scala 137:32:@7843.4]
  wire [3:0] pessimistic_one_stage_input_channel_empty_status_updater_io_downstream_icd; // @[integer_core.scala 137:32:@7843.4]
  wire [3:0] pessimistic_one_stage_input_channel_empty_status_updater_io_updated_input_channel_empty_status; // @[integer_core.scala 137:32:@7843.4]
  wire [3:0] pessimistic_two_stage_output_channel_full_status_updater_io_output_channel_full_status; // @[integer_core.scala 143:31:@7857.4]
  wire [3:0] pessimistic_two_stage_output_channel_full_status_updater_io_first_downstream_oci; // @[integer_core.scala 143:31:@7857.4]
  wire [3:0] pessimistic_two_stage_output_channel_full_status_updater_io_second_downstream_oci; // @[integer_core.scala 143:31:@7857.4]
  wire [3:0] pessimistic_two_stage_output_channel_full_status_updater_io_updated_output_channel_full_status; // @[integer_core.scala 143:31:@7857.4]
  wire [3:0] input_channel_tag_lookahead_unit_io_pending_dequeue_signals; // @[integer_core.scala 150:28:@7872.4]
  wire [1:0] input_channel_tag_lookahead_unit_io_original_tags_0; // @[integer_core.scala 150:28:@7872.4]
  wire [1:0] input_channel_tag_lookahead_unit_io_original_tags_1; // @[integer_core.scala 150:28:@7872.4]
  wire [1:0] input_channel_tag_lookahead_unit_io_original_tags_2; // @[integer_core.scala 150:28:@7872.4]
  wire [1:0] input_channel_tag_lookahead_unit_io_original_tags_3; // @[integer_core.scala 150:28:@7872.4]
  wire [1:0] input_channel_tag_lookahead_unit_io_next_tags_0; // @[integer_core.scala 150:28:@7872.4]
  wire [1:0] input_channel_tag_lookahead_unit_io_next_tags_1; // @[integer_core.scala 150:28:@7872.4]
  wire [1:0] input_channel_tag_lookahead_unit_io_next_tags_2; // @[integer_core.scala 150:28:@7872.4]
  wire [1:0] input_channel_tag_lookahead_unit_io_next_tags_3; // @[integer_core.scala 150:28:@7872.4]
  wire [1:0] input_channel_tag_lookahead_unit_io_resolved_tags_0; // @[integer_core.scala 150:28:@7872.4]
  wire [1:0] input_channel_tag_lookahead_unit_io_resolved_tags_1; // @[integer_core.scala 150:28:@7872.4]
  wire [1:0] input_channel_tag_lookahead_unit_io_resolved_tags_2; // @[integer_core.scala 150:28:@7872.4]
  wire [1:0] input_channel_tag_lookahead_unit_io_resolved_tags_3; // @[integer_core.scala 150:28:@7872.4]
  wire  trigger_resolution_unit_clock; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_reset; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_enable; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_execute; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_halted; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_0_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_0_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_0_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_0_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_0_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_0_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_1_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_1_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_1_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_1_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_1_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_1_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_2_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_2_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_2_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_2_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_2_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_2_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_3_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_3_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_3_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_3_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_3_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_3_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_4_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_4_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_4_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_4_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_4_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_4_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_5_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_5_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_5_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_5_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_5_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_5_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_6_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_6_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_6_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_6_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_6_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_6_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_7_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_7_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_7_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_7_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_7_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_7_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_8_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_8_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_8_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_8_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_8_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_8_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_9_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_9_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_9_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_9_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_9_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_9_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_10_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_10_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_10_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_10_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_10_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_10_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_11_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_11_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_11_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_11_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_11_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_11_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_12_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_12_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_12_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_12_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_12_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_12_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_13_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_13_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_13_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_13_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_13_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_13_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_14_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_14_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_14_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_14_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_14_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_14_oci; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggers_15_vi; // @[integer_core.scala 157:19:@7906.4]
  wire [15:0] trigger_resolution_unit_io_triggers_15_ptm; // @[integer_core.scala 157:19:@7906.4]
  wire [5:0] trigger_resolution_unit_io_triggers_15_ici; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_15_ictb; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggers_15_ictv; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_triggers_15_oci; // @[integer_core.scala 157:19:@7906.4]
  wire [7:0] trigger_resolution_unit_io_predicates; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_input_channel_empty_status; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_input_channel_tags_0; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_input_channel_tags_1; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_input_channel_tags_2; // @[integer_core.scala 157:19:@7906.4]
  wire [1:0] trigger_resolution_unit_io_input_channel_tags_3; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_output_channel_full_status; // @[integer_core.scala 157:19:@7906.4]
  wire  trigger_resolution_unit_io_triggered_instruction_valid; // @[integer_core.scala 157:19:@7906.4]
  wire [3:0] trigger_resolution_unit_io_triggered_instruction_index; // @[integer_core.scala 157:19:@7906.4]
  wire  instruction_memory_clock; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_enable; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_host_interface_read_req; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_host_interface_read_ack; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_host_interface_write_req; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_host_interface_write_ack; // @[integer_core.scala 170:18:@8017.4]
  wire [29:0] instruction_memory_io_host_interface_write_index; // @[integer_core.scala 170:18:@8017.4]
  wire [31:0] instruction_memory_io_host_interface_write_data; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_0_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_0_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_0_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_0_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_0_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_0_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_1_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_1_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_1_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_1_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_1_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_1_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_2_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_2_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_2_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_2_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_2_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_2_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_3_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_3_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_3_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_3_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_3_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_3_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_4_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_4_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_4_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_4_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_4_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_4_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_5_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_5_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_5_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_5_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_5_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_5_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_6_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_6_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_6_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_6_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_6_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_6_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_7_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_7_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_7_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_7_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_7_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_7_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_8_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_8_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_8_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_8_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_8_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_8_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_9_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_9_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_9_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_9_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_9_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_9_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_10_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_10_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_10_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_10_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_10_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_10_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_11_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_11_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_11_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_11_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_11_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_11_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_12_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_12_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_12_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_12_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_12_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_12_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_13_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_13_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_13_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_13_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_13_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_13_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_14_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_14_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_14_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_14_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_14_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_14_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggers_15_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggers_15_ptm; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggers_15_ici; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_15_ictb; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggers_15_ictv; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggers_15_oci; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggered_instruction_valid; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggered_instruction_index; // @[integer_core.scala 170:18:@8017.4]
  wire  instruction_memory_io_triggered_datapath_instruction_vi; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggered_datapath_instruction_op; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] instruction_memory_io_triggered_datapath_instruction_st; // @[integer_core.scala 170:18:@8017.4]
  wire [8:0] instruction_memory_io_triggered_datapath_instruction_si; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggered_datapath_instruction_dt; // @[integer_core.scala 170:18:@8017.4]
  wire [2:0] instruction_memory_io_triggered_datapath_instruction_di; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggered_datapath_instruction_oci; // @[integer_core.scala 170:18:@8017.4]
  wire [1:0] instruction_memory_io_triggered_datapath_instruction_oct; // @[integer_core.scala 170:18:@8017.4]
  wire [3:0] instruction_memory_io_triggered_datapath_instruction_icd; // @[integer_core.scala 170:18:@8017.4]
  wire [15:0] instruction_memory_io_triggered_datapath_instruction_pum; // @[integer_core.scala 170:18:@8017.4]
  wire [31:0] instruction_memory_io_triggered_datapath_instruction_immediate; // @[integer_core.scala 170:18:@8017.4]
  wire [5:0] integer_collision_detector_io_triggered_instruction_op; // @[integer_core.scala 180:19:@8139.4]
  wire [2:0] integer_collision_detector_io_dx1_instruction_retiring_stage; // @[integer_core.scala 180:19:@8139.4]
  wire  integer_collision_detector_io_collision; // @[integer_core.scala 180:19:@8139.4]
  wire [5:0] integer_issue_unit_io_dx1_instruction_op; // @[integer_core.scala 205:19:@8215.4]
  wire [2:0] integer_issue_unit_io_retiring_stage; // @[integer_core.scala 205:19:@8215.4]
  wire [2:0] integer_issue_unit_io_functional_unit; // @[integer_core.scala 205:19:@8215.4]
  wire  register_file_clock; // @[integer_core.scala 211:18:@8221.4]
  wire  register_file_reset; // @[integer_core.scala 211:18:@8221.4]
  wire  register_file_io_enable; // @[integer_core.scala 211:18:@8221.4]
  wire  register_file_io_host_interface_read_req; // @[integer_core.scala 211:18:@8221.4]
  wire  register_file_io_host_interface_read_ack; // @[integer_core.scala 211:18:@8221.4]
  wire  register_file_io_host_interface_write_req; // @[integer_core.scala 211:18:@8221.4]
  wire  register_file_io_host_interface_write_ack; // @[integer_core.scala 211:18:@8221.4]
  wire [29:0] register_file_io_host_interface_write_index; // @[integer_core.scala 211:18:@8221.4]
  wire [31:0] register_file_io_host_interface_write_data; // @[integer_core.scala 211:18:@8221.4]
  wire [2:0] register_file_io_read_indexes_0; // @[integer_core.scala 211:18:@8221.4]
  wire [2:0] register_file_io_read_indexes_1; // @[integer_core.scala 211:18:@8221.4]
  wire [2:0] register_file_io_read_indexes_2; // @[integer_core.scala 211:18:@8221.4]
  wire [31:0] register_file_io_read_data_0; // @[integer_core.scala 211:18:@8221.4]
  wire [31:0] register_file_io_read_data_1; // @[integer_core.scala 211:18:@8221.4]
  wire [31:0] register_file_io_read_data_2; // @[integer_core.scala 211:18:@8221.4]
  wire  register_file_io_write_enable; // @[integer_core.scala 211:18:@8221.4]
  wire [2:0] register_file_io_write_index; // @[integer_core.scala 211:18:@8221.4]
  wire [31:0] register_file_io_write_data; // @[integer_core.scala 211:18:@8221.4]
  wire [5:0] source_fetching_unit_io_st; // @[integer_core.scala 221:19:@8242.4]
  wire [8:0] source_fetching_unit_io_si; // @[integer_core.scala 221:19:@8242.4]
  wire [31:0] source_fetching_unit_io_immediate; // @[integer_core.scala 221:19:@8242.4]
  wire [31:0] source_fetching_unit_io_input_channel_data_0; // @[integer_core.scala 221:19:@8242.4]
  wire [31:0] source_fetching_unit_io_input_channel_data_1; // @[integer_core.scala 221:19:@8242.4]
  wire [31:0] source_fetching_unit_io_input_channel_data_2; // @[integer_core.scala 221:19:@8242.4]
  wire [31:0] source_fetching_unit_io_input_channel_data_3; // @[integer_core.scala 221:19:@8242.4]
  wire [2:0] source_fetching_unit_io_register_read_indexes_0; // @[integer_core.scala 221:19:@8242.4]
  wire [2:0] source_fetching_unit_io_register_read_indexes_1; // @[integer_core.scala 221:19:@8242.4]
  wire [2:0] source_fetching_unit_io_register_read_indexes_2; // @[integer_core.scala 221:19:@8242.4]
  wire [31:0] source_fetching_unit_io_register_read_data_0; // @[integer_core.scala 221:19:@8242.4]
  wire [31:0] source_fetching_unit_io_register_read_data_1; // @[integer_core.scala 221:19:@8242.4]
  wire [31:0] source_fetching_unit_io_register_read_data_2; // @[integer_core.scala 221:19:@8242.4]
  wire [31:0] source_fetching_unit_io_operands_0; // @[integer_core.scala 221:19:@8242.4]
  wire [31:0] source_fetching_unit_io_operands_1; // @[integer_core.scala 221:19:@8242.4]
  wire [31:0] source_fetching_unit_io_operands_2; // @[integer_core.scala 221:19:@8242.4]
  wire  operand_forwarding_unit_io_enable; // @[integer_core.scala 231:19:@8266.4]
  wire [5:0] operand_forwarding_unit_io_source_types; // @[integer_core.scala 231:19:@8266.4]
  wire [8:0] operand_forwarding_unit_io_source_indices; // @[integer_core.scala 231:19:@8266.4]
  wire [1:0] operand_forwarding_unit_io_downstream_dt; // @[integer_core.scala 231:19:@8266.4]
  wire [2:0] operand_forwarding_unit_io_downstream_di; // @[integer_core.scala 231:19:@8266.4]
  wire [31:0] operand_forwarding_unit_io_downstream_result; // @[integer_core.scala 231:19:@8266.4]
  wire [31:0] operand_forwarding_unit_io_pre_ofu_operands_0; // @[integer_core.scala 231:19:@8266.4]
  wire [31:0] operand_forwarding_unit_io_pre_ofu_operands_1; // @[integer_core.scala 231:19:@8266.4]
  wire [31:0] operand_forwarding_unit_io_post_ofu_operands_0; // @[integer_core.scala 231:19:@8266.4]
  wire [31:0] operand_forwarding_unit_io_post_ofu_operands_1; // @[integer_core.scala 231:19:@8266.4]
  wire  arithmetic_logic_unit_clock; // @[integer_core.scala 243:19:@8286.4]
  wire  arithmetic_logic_unit_reset; // @[integer_core.scala 243:19:@8286.4]
  wire [3:0] arithmetic_logic_unit_io_opcode; // @[integer_core.scala 243:19:@8286.4]
  wire [31:0] arithmetic_logic_unit_io_operands_0; // @[integer_core.scala 243:19:@8286.4]
  wire [31:0] arithmetic_logic_unit_io_operands_1; // @[integer_core.scala 243:19:@8286.4]
  wire [31:0] arithmetic_logic_unit_io_operands_2; // @[integer_core.scala 243:19:@8286.4]
  wire [31:0] arithmetic_logic_unit_io_result; // @[integer_core.scala 243:19:@8286.4]
  wire  scratchpad_clock; // @[integer_core.scala 250:20:@8294.4]
  wire [5:0] scratchpad_io_opcode; // @[integer_core.scala 250:20:@8294.4]
  wire  scratchpad_io_hostInterface_read_req; // @[integer_core.scala 250:20:@8294.4]
  wire  scratchpad_io_hostInterface_read_ack; // @[integer_core.scala 250:20:@8294.4]
  wire  scratchpad_io_hostInterface_write_req; // @[integer_core.scala 250:20:@8294.4]
  wire  scratchpad_io_hostInterface_write_ack; // @[integer_core.scala 250:20:@8294.4]
  wire [29:0] scratchpad_io_hostInterface_write_index; // @[integer_core.scala 250:20:@8294.4]
  wire [31:0] scratchpad_io_hostInterface_write_data; // @[integer_core.scala 250:20:@8294.4]
  wire [31:0] scratchpad_io_operand0; // @[integer_core.scala 250:20:@8294.4]
  wire [31:0] scratchpad_io_operand1; // @[integer_core.scala 250:20:@8294.4]
  wire [31:0] scratchpad_io_result; // @[integer_core.scala 250:20:@8294.4]
  wire [2:0] integer_retirement_unit_io_dx1_instruction_retiring_stage; // @[integer_core.scala 282:19:@8361.4]
  wire [2:0] integer_retirement_unit_io_x2_instruction_retiring_stage; // @[integer_core.scala 282:19:@8361.4]
  wire [2:0] integer_retirement_unit_io_x2_functional_unit; // @[integer_core.scala 282:19:@8361.4]
  wire  integer_retirement_unit_io_dx1_datapath_instruction_vi; // @[integer_core.scala 282:19:@8361.4]
  wire [5:0] integer_retirement_unit_io_dx1_datapath_instruction_op; // @[integer_core.scala 282:19:@8361.4]
  wire [1:0] integer_retirement_unit_io_dx1_datapath_instruction_dt; // @[integer_core.scala 282:19:@8361.4]
  wire [2:0] integer_retirement_unit_io_dx1_datapath_instruction_di; // @[integer_core.scala 282:19:@8361.4]
  wire [3:0] integer_retirement_unit_io_dx1_datapath_instruction_oci; // @[integer_core.scala 282:19:@8361.4]
  wire [1:0] integer_retirement_unit_io_dx1_datapath_instruction_oct; // @[integer_core.scala 282:19:@8361.4]
  wire  integer_retirement_unit_io_x2_datapath_instruction_vi; // @[integer_core.scala 282:19:@8361.4]
  wire [5:0] integer_retirement_unit_io_x2_datapath_instruction_op; // @[integer_core.scala 282:19:@8361.4]
  wire [1:0] integer_retirement_unit_io_x2_datapath_instruction_dt; // @[integer_core.scala 282:19:@8361.4]
  wire [2:0] integer_retirement_unit_io_x2_datapath_instruction_di; // @[integer_core.scala 282:19:@8361.4]
  wire [3:0] integer_retirement_unit_io_x2_datapath_instruction_oci; // @[integer_core.scala 282:19:@8361.4]
  wire [1:0] integer_retirement_unit_io_x2_datapath_instruction_oct; // @[integer_core.scala 282:19:@8361.4]
  wire [31:0] integer_retirement_unit_io_alu_result; // @[integer_core.scala 282:19:@8361.4]
  wire [31:0] integer_retirement_unit_io_sm_result; // @[integer_core.scala 282:19:@8361.4]
  wire  integer_retirement_unit_io_retiring_datapath_instruction_vi; // @[integer_core.scala 282:19:@8361.4]
  wire [5:0] integer_retirement_unit_io_retiring_datapath_instruction_op; // @[integer_core.scala 282:19:@8361.4]
  wire [1:0] integer_retirement_unit_io_retiring_datapath_instruction_dt; // @[integer_core.scala 282:19:@8361.4]
  wire [2:0] integer_retirement_unit_io_retiring_datapath_instruction_di; // @[integer_core.scala 282:19:@8361.4]
  wire [3:0] integer_retirement_unit_io_retiring_datapath_instruction_oci; // @[integer_core.scala 282:19:@8361.4]
  wire [1:0] integer_retirement_unit_io_retiring_datapath_instruction_oct; // @[integer_core.scala 282:19:@8361.4]
  wire [31:0] integer_retirement_unit_io_datapath_result; // @[integer_core.scala 282:19:@8361.4]
  wire [31:0] destination_routing_unit_io_datapath_result; // @[integer_core.scala 296:19:@8405.4]
  wire [1:0] destination_routing_unit_io_dt; // @[integer_core.scala 296:19:@8405.4]
  wire [2:0] destination_routing_unit_io_di; // @[integer_core.scala 296:19:@8405.4]
  wire [3:0] destination_routing_unit_io_oci; // @[integer_core.scala 296:19:@8405.4]
  wire  destination_routing_unit_io_register_write_enable; // @[integer_core.scala 296:19:@8405.4]
  wire [2:0] destination_routing_unit_io_register_write_index; // @[integer_core.scala 296:19:@8405.4]
  wire [31:0] destination_routing_unit_io_register_write_data; // @[integer_core.scala 296:19:@8405.4]
  wire [31:0] destination_routing_unit_io_output_channel_data_0; // @[integer_core.scala 296:19:@8405.4]
  wire [31:0] destination_routing_unit_io_output_channel_data_1; // @[integer_core.scala 296:19:@8405.4]
  wire [31:0] destination_routing_unit_io_output_channel_data_2; // @[integer_core.scala 296:19:@8405.4]
  wire [31:0] destination_routing_unit_io_output_channel_data_3; // @[integer_core.scala 296:19:@8405.4]
  wire  dequeueing_unit_io_enable; // @[integer_core.scala 307:18:@8419.4]
  wire [3:0] dequeueing_unit_io_icd; // @[integer_core.scala 307:18:@8419.4]
  wire [3:0] dequeueing_unit_io_dequeue_signals; // @[integer_core.scala 307:18:@8419.4]
  wire  enqueueing_unit_io_enable; // @[integer_core.scala 313:18:@8436.4]
  wire [3:0] enqueueing_unit_io_oci; // @[integer_core.scala 313:18:@8436.4]
  wire [1:0] enqueueing_unit_io_oct; // @[integer_core.scala 313:18:@8436.4]
  wire [3:0] enqueueing_unit_io_enqueue_signals; // @[integer_core.scala 313:18:@8436.4]
  wire [1:0] enqueueing_unit_io_outout_channel_tags_0; // @[integer_core.scala 313:18:@8436.4]
  wire [1:0] enqueueing_unit_io_outout_channel_tags_1; // @[integer_core.scala 313:18:@8436.4]
  wire [1:0] enqueueing_unit_io_outout_channel_tags_2; // @[integer_core.scala 313:18:@8436.4]
  wire [1:0] enqueueing_unit_io_outout_channel_tags_3; // @[integer_core.scala 313:18:@8436.4]
  reg [2:0] dx1_instruction_retiring_stage; // @[integer_core.scala 92:78:@7732.4]
  reg [31:0] _RAND_0;
  reg [2:0] x2_instruction_retiring_stage; // @[integer_core.scala 92:78:@7733.4]
  reg [31:0] _RAND_1;
  reg [2:0] dx1_functional_unit; // @[integer_core.scala 93:56:@7734.4]
  reg [31:0] _RAND_2;
  reg [2:0] x2_functional_unit; // @[integer_core.scala 93:56:@7735.4]
  reg [31:0] _RAND_3;
  reg  dx1_triggered_datapath_instruction_vi; // @[integer_core.scala 94:86:@7736.4]
  reg [31:0] _RAND_4;
  reg [5:0] dx1_triggered_datapath_instruction_op; // @[integer_core.scala 94:86:@7736.4]
  reg [31:0] _RAND_5;
  reg [5:0] dx1_triggered_datapath_instruction_st; // @[integer_core.scala 94:86:@7736.4]
  reg [31:0] _RAND_6;
  reg [8:0] dx1_triggered_datapath_instruction_si; // @[integer_core.scala 94:86:@7736.4]
  reg [31:0] _RAND_7;
  reg [1:0] dx1_triggered_datapath_instruction_dt; // @[integer_core.scala 94:86:@7736.4]
  reg [31:0] _RAND_8;
  reg [2:0] dx1_triggered_datapath_instruction_di; // @[integer_core.scala 94:86:@7736.4]
  reg [31:0] _RAND_9;
  reg [3:0] dx1_triggered_datapath_instruction_oci; // @[integer_core.scala 94:86:@7736.4]
  reg [31:0] _RAND_10;
  reg [1:0] dx1_triggered_datapath_instruction_oct; // @[integer_core.scala 94:86:@7736.4]
  reg [31:0] _RAND_11;
  reg [3:0] dx1_triggered_datapath_instruction_icd; // @[integer_core.scala 94:86:@7736.4]
  reg [31:0] _RAND_12;
  reg [31:0] dx1_triggered_datapath_instruction_immediate; // @[integer_core.scala 94:86:@7736.4]
  reg [31:0] _RAND_13;
  reg  x2_triggered_datapath_instruction_vi; // @[integer_core.scala 94:86:@7737.4]
  reg [31:0] _RAND_14;
  reg [5:0] x2_triggered_datapath_instruction_op; // @[integer_core.scala 94:86:@7737.4]
  reg [31:0] _RAND_15;
  reg [1:0] x2_triggered_datapath_instruction_dt; // @[integer_core.scala 94:86:@7737.4]
  reg [31:0] _RAND_16;
  reg [2:0] x2_triggered_datapath_instruction_di; // @[integer_core.scala 94:86:@7737.4]
  reg [31:0] _RAND_17;
  reg [3:0] x2_triggered_datapath_instruction_oci; // @[integer_core.scala 94:86:@7737.4]
  reg [31:0] _RAND_18;
  reg [1:0] x2_triggered_datapath_instruction_oct; // @[integer_core.scala 94:86:@7737.4]
  reg [31:0] _RAND_19;
  wire  _T_522_1; // @[integer_core.scala 119:44:@7811.4 integer_core.scala 119:44:@7813.4]
  wire  _T_522_0; // @[integer_core.scala 119:44:@7811.4 integer_core.scala 119:44:@7812.4]
  wire [1:0] _T_529; // @[integer_core.scala 119:98:@7816.4]
  wire  _T_522_3; // @[integer_core.scala 119:44:@7811.4 integer_core.scala 119:44:@7815.4]
  wire  _T_522_2; // @[integer_core.scala 119:44:@7811.4 integer_core.scala 119:44:@7814.4]
  wire [1:0] _T_530; // @[integer_core.scala 119:98:@7817.4]
  wire  _T_535_1; // @[integer_core.scala 120:45:@7820.4 integer_core.scala 120:45:@7822.4]
  wire  _T_535_0; // @[integer_core.scala 120:45:@7820.4 integer_core.scala 120:45:@7821.4]
  wire [1:0] _T_542; // @[integer_core.scala 120:100:@7825.4]
  wire  _T_535_3; // @[integer_core.scala 120:45:@7820.4 integer_core.scala 120:45:@7824.4]
  wire  _T_535_2; // @[integer_core.scala 120:45:@7820.4 integer_core.scala 120:45:@7823.4]
  wire [1:0] _T_543; // @[integer_core.scala 120:100:@7826.4]
  wire  input_channels_1_empty; // @[integer_core.scala 48:28:@7602.4 integer_core.scala 53:23:@7618.4]
  wire  input_channels_0_empty; // @[integer_core.scala 48:28:@7602.4 integer_core.scala 53:23:@7606.4]
  wire [1:0] _T_555; // @[integer_core.scala 138:92:@7851.4]
  wire  input_channels_3_empty; // @[integer_core.scala 48:28:@7602.4 integer_core.scala 53:23:@7642.4]
  wire  input_channels_2_empty; // @[integer_core.scala 48:28:@7602.4 integer_core.scala 53:23:@7630.4]
  wire [1:0] _T_556; // @[integer_core.scala 138:92:@7852.4]
  wire  output_channels_1_full; // @[integer_core.scala 49:29:@7603.4 integer_core.scala 59:41:@7664.4]
  wire  output_channels_0_full; // @[integer_core.scala 49:29:@7603.4 integer_core.scala 59:41:@7654.4]
  wire [1:0] _T_568; // @[integer_core.scala 144:91:@7865.4]
  wire  output_channels_3_full; // @[integer_core.scala 49:29:@7603.4 integer_core.scala 59:41:@7684.4]
  wire  output_channels_2_full; // @[integer_core.scala 49:29:@7603.4 integer_core.scala 59:41:@7674.4]
  wire [1:0] _T_569; // @[integer_core.scala 144:91:@7866.4]
  wire  input_channels_1_dequeue; // @[integer_core.scala 310:76:@8430.4]
  wire  input_channels_0_dequeue; // @[integer_core.scala 310:76:@8428.4]
  wire [1:0] _T_601; // @[integer_core.scala 153:84:@7898.4]
  wire  input_channels_3_dequeue; // @[integer_core.scala 310:76:@8434.4]
  wire  input_channels_2_dequeue; // @[integer_core.scala 310:76:@8432.4]
  wire [1:0] _T_602; // @[integer_core.scala 153:84:@7899.4]
  wire  collision; // @[integer_core.scala 66:9:@7701.4 integer_core.scala 183:13:@8144.4]
  wire [31:0] triggered_datapath_instruction_immediate; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8127.4]
  wire [31:0] hazard_free_datapath_instruction_immediate; // @[integer_core.scala 185:15:@8147.4]
  wire [15:0] triggered_datapath_instruction_pum; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8128.4]
  wire [3:0] triggered_datapath_instruction_icd; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8129.4]
  wire [3:0] hazard_free_datapath_instruction_icd; // @[integer_core.scala 185:15:@8147.4]
  wire [1:0] triggered_datapath_instruction_oct; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8130.4]
  wire [1:0] hazard_free_datapath_instruction_oct; // @[integer_core.scala 185:15:@8147.4]
  wire [3:0] triggered_datapath_instruction_oci; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8131.4]
  wire [3:0] hazard_free_datapath_instruction_oci; // @[integer_core.scala 185:15:@8147.4]
  wire [2:0] triggered_datapath_instruction_di; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8132.4]
  wire [2:0] hazard_free_datapath_instruction_di; // @[integer_core.scala 185:15:@8147.4]
  wire [1:0] triggered_datapath_instruction_dt; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8133.4]
  wire [1:0] hazard_free_datapath_instruction_dt; // @[integer_core.scala 185:15:@8147.4]
  wire [8:0] triggered_datapath_instruction_si; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8134.4]
  wire [8:0] hazard_free_datapath_instruction_si; // @[integer_core.scala 185:15:@8147.4]
  wire [5:0] triggered_datapath_instruction_st; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8135.4]
  wire [5:0] hazard_free_datapath_instruction_st; // @[integer_core.scala 185:15:@8147.4]
  wire [5:0] triggered_datapath_instruction_op; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8136.4]
  wire [5:0] hazard_free_datapath_instruction_op; // @[integer_core.scala 185:15:@8147.4]
  wire  triggered_datapath_instruction_vi; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8137.4]
  wire  hazard_free_datapath_instruction_vi; // @[integer_core.scala 185:15:@8147.4]
  wire [31:0] _GEN_11; // @[integer_core.scala 197:24:@8200.6]
  wire [3:0] _GEN_13; // @[integer_core.scala 197:24:@8200.6]
  wire [1:0] _GEN_14; // @[integer_core.scala 197:24:@8200.6]
  wire [3:0] _GEN_15; // @[integer_core.scala 197:24:@8200.6]
  wire [2:0] _GEN_16; // @[integer_core.scala 197:24:@8200.6]
  wire [1:0] _GEN_17; // @[integer_core.scala 197:24:@8200.6]
  wire [8:0] _GEN_18; // @[integer_core.scala 197:24:@8200.6]
  wire [5:0] _GEN_19; // @[integer_core.scala 197:24:@8200.6]
  wire [5:0] _GEN_20; // @[integer_core.scala 197:24:@8200.6]
  wire  _GEN_21; // @[integer_core.scala 197:24:@8200.6]
  wire [31:0] _GEN_22; // @[integer_core.scala 195:52:@8186.4]
  wire [3:0] _GEN_24; // @[integer_core.scala 195:52:@8186.4]
  wire [1:0] _GEN_25; // @[integer_core.scala 195:52:@8186.4]
  wire [3:0] _GEN_26; // @[integer_core.scala 195:52:@8186.4]
  wire [2:0] _GEN_27; // @[integer_core.scala 195:52:@8186.4]
  wire [1:0] _GEN_28; // @[integer_core.scala 195:52:@8186.4]
  wire [8:0] _GEN_29; // @[integer_core.scala 195:52:@8186.4]
  wire [5:0] _GEN_30; // @[integer_core.scala 195:52:@8186.4]
  wire [5:0] _GEN_31; // @[integer_core.scala 195:52:@8186.4]
  wire  _GEN_32; // @[integer_core.scala 195:52:@8186.4]
  wire  _T_619; // @[integer_core.scala 232:49:@8269.4]
  wire  _T_621; // @[integer_core.scala 232:90:@8270.4]
  wire  _T_622; // @[integer_core.scala 232:57:@8271.4]
  wire  _T_624; // @[integer_core.scala 233:25:@8272.4]
  wire [1:0] _GEN_36; // @[integer_core.scala 270:49:@8330.8]
  wire [3:0] _GEN_37; // @[integer_core.scala 270:49:@8330.8]
  wire [2:0] _GEN_38; // @[integer_core.scala 270:49:@8330.8]
  wire [1:0] _GEN_39; // @[integer_core.scala 270:49:@8330.8]
  wire [5:0] _GEN_42; // @[integer_core.scala 270:49:@8330.8]
  wire  _GEN_43; // @[integer_core.scala 270:49:@8330.8]
  wire [2:0] _GEN_44; // @[integer_core.scala 270:49:@8330.8]
  wire [2:0] _GEN_45; // @[integer_core.scala 270:49:@8330.8]
  wire [1:0] _GEN_49; // @[integer_core.scala 269:24:@8328.6]
  wire [3:0] _GEN_50; // @[integer_core.scala 269:24:@8328.6]
  wire [2:0] _GEN_51; // @[integer_core.scala 269:24:@8328.6]
  wire [1:0] _GEN_52; // @[integer_core.scala 269:24:@8328.6]
  wire [5:0] _GEN_55; // @[integer_core.scala 269:24:@8328.6]
  wire  _GEN_56; // @[integer_core.scala 269:24:@8328.6]
  wire [2:0] _GEN_57; // @[integer_core.scala 269:24:@8328.6]
  wire [2:0] _GEN_58; // @[integer_core.scala 269:24:@8328.6]
  wire [1:0] _GEN_62; // @[integer_core.scala 265:53:@8312.4]
  wire [3:0] _GEN_63; // @[integer_core.scala 265:53:@8312.4]
  wire [2:0] _GEN_64; // @[integer_core.scala 265:53:@8312.4]
  wire [1:0] _GEN_65; // @[integer_core.scala 265:53:@8312.4]
  wire [5:0] _GEN_68; // @[integer_core.scala 265:53:@8312.4]
  wire  _GEN_69; // @[integer_core.scala 265:53:@8312.4]
  wire [2:0] _GEN_70; // @[integer_core.scala 265:53:@8312.4]
  wire [2:0] _GEN_71; // @[integer_core.scala 265:53:@8312.4]
  wire  _T_635; // @[integer_core.scala 308:27:@8422.4]
  wire  halted; // @[integer_core.scala 64:28:@7692.4 integer_core.scala 123:10:@7831.4]
  wire  _T_637; // @[integer_core.scala 308:41:@8423.4]
  wire  _T_638; // @[integer_core.scala 308:38:@8424.4]
  wire  retiring_datapath_instruction_vi; // @[integer_core.scala 72:9:@7708.4 integer_core.scala 292:33:@8403.4]
  input_channel_buffer input_channel_buffer ( // @[integer_core.scala 41:11:@7578.4]
    .clock(input_channel_buffer_clock),
    .reset(input_channel_buffer_reset),
    .io_enable(input_channel_buffer_io_enable),
    .io_in_req(input_channel_buffer_io_in_req),
    .io_in_ack(input_channel_buffer_io_in_ack),
    .io_in_packet_tag(input_channel_buffer_io_in_packet_tag),
    .io_in_packet_data(input_channel_buffer_io_in_packet_data),
    .io_out_pack_tag(input_channel_buffer_io_out_pack_tag),
    .io_out_pack_data(input_channel_buffer_io_out_pack_data),
    .io_out_next_pack_tag(input_channel_buffer_io_out_next_pack_tag),
    .io_out_dequeue(input_channel_buffer_io_out_dequeue),
    .io_out_empty(input_channel_buffer_io_out_empty),
    .io_quiescent(input_channel_buffer_io_quiescent)
  );
  input_channel_buffer input_channel_buffer_1 ( // @[integer_core.scala 41:11:@7581.4]
    .clock(input_channel_buffer_1_clock),
    .reset(input_channel_buffer_1_reset),
    .io_enable(input_channel_buffer_1_io_enable),
    .io_in_req(input_channel_buffer_1_io_in_req),
    .io_in_ack(input_channel_buffer_1_io_in_ack),
    .io_in_packet_tag(input_channel_buffer_1_io_in_packet_tag),
    .io_in_packet_data(input_channel_buffer_1_io_in_packet_data),
    .io_out_pack_tag(input_channel_buffer_1_io_out_pack_tag),
    .io_out_pack_data(input_channel_buffer_1_io_out_pack_data),
    .io_out_next_pack_tag(input_channel_buffer_1_io_out_next_pack_tag),
    .io_out_dequeue(input_channel_buffer_1_io_out_dequeue),
    .io_out_empty(input_channel_buffer_1_io_out_empty),
    .io_quiescent(input_channel_buffer_1_io_quiescent)
  );
  input_channel_buffer input_channel_buffer_2 ( // @[integer_core.scala 41:11:@7584.4]
    .clock(input_channel_buffer_2_clock),
    .reset(input_channel_buffer_2_reset),
    .io_enable(input_channel_buffer_2_io_enable),
    .io_in_req(input_channel_buffer_2_io_in_req),
    .io_in_ack(input_channel_buffer_2_io_in_ack),
    .io_in_packet_tag(input_channel_buffer_2_io_in_packet_tag),
    .io_in_packet_data(input_channel_buffer_2_io_in_packet_data),
    .io_out_pack_tag(input_channel_buffer_2_io_out_pack_tag),
    .io_out_pack_data(input_channel_buffer_2_io_out_pack_data),
    .io_out_next_pack_tag(input_channel_buffer_2_io_out_next_pack_tag),
    .io_out_dequeue(input_channel_buffer_2_io_out_dequeue),
    .io_out_empty(input_channel_buffer_2_io_out_empty),
    .io_quiescent(input_channel_buffer_2_io_quiescent)
  );
  input_channel_buffer input_channel_buffer_3 ( // @[integer_core.scala 41:11:@7587.4]
    .clock(input_channel_buffer_3_clock),
    .reset(input_channel_buffer_3_reset),
    .io_enable(input_channel_buffer_3_io_enable),
    .io_in_req(input_channel_buffer_3_io_in_req),
    .io_in_ack(input_channel_buffer_3_io_in_ack),
    .io_in_packet_tag(input_channel_buffer_3_io_in_packet_tag),
    .io_in_packet_data(input_channel_buffer_3_io_in_packet_data),
    .io_out_pack_tag(input_channel_buffer_3_io_out_pack_tag),
    .io_out_pack_data(input_channel_buffer_3_io_out_pack_data),
    .io_out_next_pack_tag(input_channel_buffer_3_io_out_next_pack_tag),
    .io_out_dequeue(input_channel_buffer_3_io_out_dequeue),
    .io_out_empty(input_channel_buffer_3_io_out_empty),
    .io_quiescent(input_channel_buffer_3_io_quiescent)
  );
  output_channel_buffer output_channel_buffer ( // @[integer_core.scala 44:11:@7590.4]
    .clock(output_channel_buffer_clock),
    .reset(output_channel_buffer_reset),
    .io_enable(output_channel_buffer_io_enable),
    .io_in_pack_tag(output_channel_buffer_io_in_pack_tag),
    .io_in_pack_data(output_channel_buffer_io_in_pack_data),
    .io_in_enqueue(output_channel_buffer_io_in_enqueue),
    .io_in_full(output_channel_buffer_io_in_full),
    .io_out_req(output_channel_buffer_io_out_req),
    .io_out_ack(output_channel_buffer_io_out_ack),
    .io_out_packet_tag(output_channel_buffer_io_out_packet_tag),
    .io_out_packet_data(output_channel_buffer_io_out_packet_data),
    .io_quiescent(output_channel_buffer_io_quiescent)
  );
  output_channel_buffer output_channel_buffer_1 ( // @[integer_core.scala 44:11:@7593.4]
    .clock(output_channel_buffer_1_clock),
    .reset(output_channel_buffer_1_reset),
    .io_enable(output_channel_buffer_1_io_enable),
    .io_in_pack_tag(output_channel_buffer_1_io_in_pack_tag),
    .io_in_pack_data(output_channel_buffer_1_io_in_pack_data),
    .io_in_enqueue(output_channel_buffer_1_io_in_enqueue),
    .io_in_full(output_channel_buffer_1_io_in_full),
    .io_out_req(output_channel_buffer_1_io_out_req),
    .io_out_ack(output_channel_buffer_1_io_out_ack),
    .io_out_packet_tag(output_channel_buffer_1_io_out_packet_tag),
    .io_out_packet_data(output_channel_buffer_1_io_out_packet_data),
    .io_quiescent(output_channel_buffer_1_io_quiescent)
  );
  output_channel_buffer output_channel_buffer_2 ( // @[integer_core.scala 44:11:@7596.4]
    .clock(output_channel_buffer_2_clock),
    .reset(output_channel_buffer_2_reset),
    .io_enable(output_channel_buffer_2_io_enable),
    .io_in_pack_tag(output_channel_buffer_2_io_in_pack_tag),
    .io_in_pack_data(output_channel_buffer_2_io_in_pack_data),
    .io_in_enqueue(output_channel_buffer_2_io_in_enqueue),
    .io_in_full(output_channel_buffer_2_io_in_full),
    .io_out_req(output_channel_buffer_2_io_out_req),
    .io_out_ack(output_channel_buffer_2_io_out_ack),
    .io_out_packet_tag(output_channel_buffer_2_io_out_packet_tag),
    .io_out_packet_data(output_channel_buffer_2_io_out_packet_data),
    .io_quiescent(output_channel_buffer_2_io_quiescent)
  );
  output_channel_buffer output_channel_buffer_3 ( // @[integer_core.scala 44:11:@7599.4]
    .clock(output_channel_buffer_3_clock),
    .reset(output_channel_buffer_3_reset),
    .io_enable(output_channel_buffer_3_io_enable),
    .io_in_pack_tag(output_channel_buffer_3_io_in_pack_tag),
    .io_in_pack_data(output_channel_buffer_3_io_in_pack_data),
    .io_in_enqueue(output_channel_buffer_3_io_in_enqueue),
    .io_in_full(output_channel_buffer_3_io_in_full),
    .io_out_req(output_channel_buffer_3_io_out_req),
    .io_out_ack(output_channel_buffer_3_io_out_ack),
    .io_out_packet_tag(output_channel_buffer_3_io_out_packet_tag),
    .io_out_packet_data(output_channel_buffer_3_io_out_packet_data),
    .io_quiescent(output_channel_buffer_3_io_quiescent)
  );
  core_mapper core_mapper ( // @[integer_core.scala 98:20:@7738.4]
    .io_host_interface_read_req(core_mapper_io_host_interface_read_req),
    .io_host_interface_read_ack(core_mapper_io_host_interface_read_ack),
    .io_host_interface_read_index(core_mapper_io_host_interface_read_index),
    .io_host_interface_write_req(core_mapper_io_host_interface_write_req),
    .io_host_interface_write_ack(core_mapper_io_host_interface_write_ack),
    .io_host_interface_write_index(core_mapper_io_host_interface_write_index),
    .io_host_interface_write_data(core_mapper_io_host_interface_write_data),
    .io_register_file_interface_read_req(core_mapper_io_register_file_interface_read_req),
    .io_register_file_interface_read_ack(core_mapper_io_register_file_interface_read_ack),
    .io_register_file_interface_write_req(core_mapper_io_register_file_interface_write_req),
    .io_register_file_interface_write_ack(core_mapper_io_register_file_interface_write_ack),
    .io_register_file_interface_write_index(core_mapper_io_register_file_interface_write_index),
    .io_register_file_interface_write_data(core_mapper_io_register_file_interface_write_data),
    .io_instruction_memory_interface_read_req(core_mapper_io_instruction_memory_interface_read_req),
    .io_instruction_memory_interface_read_ack(core_mapper_io_instruction_memory_interface_read_ack),
    .io_instruction_memory_interface_write_req(core_mapper_io_instruction_memory_interface_write_req),
    .io_instruction_memory_interface_write_ack(core_mapper_io_instruction_memory_interface_write_ack),
    .io_instruction_memory_interface_write_index(core_mapper_io_instruction_memory_interface_write_index),
    .io_instruction_memory_interface_write_data(core_mapper_io_instruction_memory_interface_write_data),
    .io_scratchpad_memory_interface_read_req(core_mapper_io_scratchpad_memory_interface_read_req),
    .io_scratchpad_memory_interface_read_ack(core_mapper_io_scratchpad_memory_interface_read_ack),
    .io_scratchpad_memory_interface_write_req(core_mapper_io_scratchpad_memory_interface_write_req),
    .io_scratchpad_memory_interface_write_ack(core_mapper_io_scratchpad_memory_interface_write_ack),
    .io_scratchpad_memory_interface_write_index(core_mapper_io_scratchpad_memory_interface_write_index),
    .io_scratchpad_memory_interface_write_data(core_mapper_io_scratchpad_memory_interface_write_data)
  );
  execution_control_unit execution_control_unit ( // @[integer_core.scala 115:19:@7805.4]
    .reset(execution_control_unit_reset),
    .io_enable(execution_control_unit_io_enable),
    .io_execute(execution_control_unit_io_execute),
    .io_opcode(execution_control_unit_io_opcode),
    .io_input_channel_quiescent_status(execution_control_unit_io_input_channel_quiescent_status),
    .io_output_channel_quiescent_status(execution_control_unit_io_output_channel_quiescent_status),
    .io_internal_reset(execution_control_unit_io_internal_reset),
    .io_internal_enable(execution_control_unit_io_internal_enable),
    .io_halted(execution_control_unit_io_halted),
    .io_channels_quiescent(execution_control_unit_io_channels_quiescent)
  );
  predicate_unit pu ( // @[integer_core.scala 127:18:@7833.4]
    .clock(pu_clock),
    .reset(pu_reset),
    .io_enable(pu_io_enable),
    .io_datapath_dt(pu_io_datapath_dt),
    .io_datapath_di(pu_io_datapath_di),
    .io_datapath_result(pu_io_datapath_result),
    .io_instruction_pum(pu_io_instruction_pum),
    .io_predicates(pu_io_predicates)
  );
  pessimistic_one_stage_input_channel_empty_status_updater pessimistic_one_stage_input_channel_empty_status_updater ( // @[integer_core.scala 137:32:@7843.4]
    .io_input_channel_empty_status(pessimistic_one_stage_input_channel_empty_status_updater_io_input_channel_empty_status),
    .io_downstream_icd(pessimistic_one_stage_input_channel_empty_status_updater_io_downstream_icd),
    .io_updated_input_channel_empty_status(pessimistic_one_stage_input_channel_empty_status_updater_io_updated_input_channel_empty_status)
  );
  pessimistic_two_stage_output_channel_full_status_updater pessimistic_two_stage_output_channel_full_status_updater ( // @[integer_core.scala 143:31:@7857.4]
    .io_output_channel_full_status(pessimistic_two_stage_output_channel_full_status_updater_io_output_channel_full_status),
    .io_first_downstream_oci(pessimistic_two_stage_output_channel_full_status_updater_io_first_downstream_oci),
    .io_second_downstream_oci(pessimistic_two_stage_output_channel_full_status_updater_io_second_downstream_oci),
    .io_updated_output_channel_full_status(pessimistic_two_stage_output_channel_full_status_updater_io_updated_output_channel_full_status)
  );
  input_channel_tag_lookahead_unit input_channel_tag_lookahead_unit ( // @[integer_core.scala 150:28:@7872.4]
    .io_pending_dequeue_signals(input_channel_tag_lookahead_unit_io_pending_dequeue_signals),
    .io_original_tags_0(input_channel_tag_lookahead_unit_io_original_tags_0),
    .io_original_tags_1(input_channel_tag_lookahead_unit_io_original_tags_1),
    .io_original_tags_2(input_channel_tag_lookahead_unit_io_original_tags_2),
    .io_original_tags_3(input_channel_tag_lookahead_unit_io_original_tags_3),
    .io_next_tags_0(input_channel_tag_lookahead_unit_io_next_tags_0),
    .io_next_tags_1(input_channel_tag_lookahead_unit_io_next_tags_1),
    .io_next_tags_2(input_channel_tag_lookahead_unit_io_next_tags_2),
    .io_next_tags_3(input_channel_tag_lookahead_unit_io_next_tags_3),
    .io_resolved_tags_0(input_channel_tag_lookahead_unit_io_resolved_tags_0),
    .io_resolved_tags_1(input_channel_tag_lookahead_unit_io_resolved_tags_1),
    .io_resolved_tags_2(input_channel_tag_lookahead_unit_io_resolved_tags_2),
    .io_resolved_tags_3(input_channel_tag_lookahead_unit_io_resolved_tags_3)
  );
  trigger_resolution_unit trigger_resolution_unit ( // @[integer_core.scala 157:19:@7906.4]
    .clock(trigger_resolution_unit_clock),
    .reset(trigger_resolution_unit_reset),
    .io_enable(trigger_resolution_unit_io_enable),
    .io_execute(trigger_resolution_unit_io_execute),
    .io_halted(trigger_resolution_unit_io_halted),
    .io_triggers_0_vi(trigger_resolution_unit_io_triggers_0_vi),
    .io_triggers_0_ptm(trigger_resolution_unit_io_triggers_0_ptm),
    .io_triggers_0_ici(trigger_resolution_unit_io_triggers_0_ici),
    .io_triggers_0_ictb(trigger_resolution_unit_io_triggers_0_ictb),
    .io_triggers_0_ictv(trigger_resolution_unit_io_triggers_0_ictv),
    .io_triggers_0_oci(trigger_resolution_unit_io_triggers_0_oci),
    .io_triggers_1_vi(trigger_resolution_unit_io_triggers_1_vi),
    .io_triggers_1_ptm(trigger_resolution_unit_io_triggers_1_ptm),
    .io_triggers_1_ici(trigger_resolution_unit_io_triggers_1_ici),
    .io_triggers_1_ictb(trigger_resolution_unit_io_triggers_1_ictb),
    .io_triggers_1_ictv(trigger_resolution_unit_io_triggers_1_ictv),
    .io_triggers_1_oci(trigger_resolution_unit_io_triggers_1_oci),
    .io_triggers_2_vi(trigger_resolution_unit_io_triggers_2_vi),
    .io_triggers_2_ptm(trigger_resolution_unit_io_triggers_2_ptm),
    .io_triggers_2_ici(trigger_resolution_unit_io_triggers_2_ici),
    .io_triggers_2_ictb(trigger_resolution_unit_io_triggers_2_ictb),
    .io_triggers_2_ictv(trigger_resolution_unit_io_triggers_2_ictv),
    .io_triggers_2_oci(trigger_resolution_unit_io_triggers_2_oci),
    .io_triggers_3_vi(trigger_resolution_unit_io_triggers_3_vi),
    .io_triggers_3_ptm(trigger_resolution_unit_io_triggers_3_ptm),
    .io_triggers_3_ici(trigger_resolution_unit_io_triggers_3_ici),
    .io_triggers_3_ictb(trigger_resolution_unit_io_triggers_3_ictb),
    .io_triggers_3_ictv(trigger_resolution_unit_io_triggers_3_ictv),
    .io_triggers_3_oci(trigger_resolution_unit_io_triggers_3_oci),
    .io_triggers_4_vi(trigger_resolution_unit_io_triggers_4_vi),
    .io_triggers_4_ptm(trigger_resolution_unit_io_triggers_4_ptm),
    .io_triggers_4_ici(trigger_resolution_unit_io_triggers_4_ici),
    .io_triggers_4_ictb(trigger_resolution_unit_io_triggers_4_ictb),
    .io_triggers_4_ictv(trigger_resolution_unit_io_triggers_4_ictv),
    .io_triggers_4_oci(trigger_resolution_unit_io_triggers_4_oci),
    .io_triggers_5_vi(trigger_resolution_unit_io_triggers_5_vi),
    .io_triggers_5_ptm(trigger_resolution_unit_io_triggers_5_ptm),
    .io_triggers_5_ici(trigger_resolution_unit_io_triggers_5_ici),
    .io_triggers_5_ictb(trigger_resolution_unit_io_triggers_5_ictb),
    .io_triggers_5_ictv(trigger_resolution_unit_io_triggers_5_ictv),
    .io_triggers_5_oci(trigger_resolution_unit_io_triggers_5_oci),
    .io_triggers_6_vi(trigger_resolution_unit_io_triggers_6_vi),
    .io_triggers_6_ptm(trigger_resolution_unit_io_triggers_6_ptm),
    .io_triggers_6_ici(trigger_resolution_unit_io_triggers_6_ici),
    .io_triggers_6_ictb(trigger_resolution_unit_io_triggers_6_ictb),
    .io_triggers_6_ictv(trigger_resolution_unit_io_triggers_6_ictv),
    .io_triggers_6_oci(trigger_resolution_unit_io_triggers_6_oci),
    .io_triggers_7_vi(trigger_resolution_unit_io_triggers_7_vi),
    .io_triggers_7_ptm(trigger_resolution_unit_io_triggers_7_ptm),
    .io_triggers_7_ici(trigger_resolution_unit_io_triggers_7_ici),
    .io_triggers_7_ictb(trigger_resolution_unit_io_triggers_7_ictb),
    .io_triggers_7_ictv(trigger_resolution_unit_io_triggers_7_ictv),
    .io_triggers_7_oci(trigger_resolution_unit_io_triggers_7_oci),
    .io_triggers_8_vi(trigger_resolution_unit_io_triggers_8_vi),
    .io_triggers_8_ptm(trigger_resolution_unit_io_triggers_8_ptm),
    .io_triggers_8_ici(trigger_resolution_unit_io_triggers_8_ici),
    .io_triggers_8_ictb(trigger_resolution_unit_io_triggers_8_ictb),
    .io_triggers_8_ictv(trigger_resolution_unit_io_triggers_8_ictv),
    .io_triggers_8_oci(trigger_resolution_unit_io_triggers_8_oci),
    .io_triggers_9_vi(trigger_resolution_unit_io_triggers_9_vi),
    .io_triggers_9_ptm(trigger_resolution_unit_io_triggers_9_ptm),
    .io_triggers_9_ici(trigger_resolution_unit_io_triggers_9_ici),
    .io_triggers_9_ictb(trigger_resolution_unit_io_triggers_9_ictb),
    .io_triggers_9_ictv(trigger_resolution_unit_io_triggers_9_ictv),
    .io_triggers_9_oci(trigger_resolution_unit_io_triggers_9_oci),
    .io_triggers_10_vi(trigger_resolution_unit_io_triggers_10_vi),
    .io_triggers_10_ptm(trigger_resolution_unit_io_triggers_10_ptm),
    .io_triggers_10_ici(trigger_resolution_unit_io_triggers_10_ici),
    .io_triggers_10_ictb(trigger_resolution_unit_io_triggers_10_ictb),
    .io_triggers_10_ictv(trigger_resolution_unit_io_triggers_10_ictv),
    .io_triggers_10_oci(trigger_resolution_unit_io_triggers_10_oci),
    .io_triggers_11_vi(trigger_resolution_unit_io_triggers_11_vi),
    .io_triggers_11_ptm(trigger_resolution_unit_io_triggers_11_ptm),
    .io_triggers_11_ici(trigger_resolution_unit_io_triggers_11_ici),
    .io_triggers_11_ictb(trigger_resolution_unit_io_triggers_11_ictb),
    .io_triggers_11_ictv(trigger_resolution_unit_io_triggers_11_ictv),
    .io_triggers_11_oci(trigger_resolution_unit_io_triggers_11_oci),
    .io_triggers_12_vi(trigger_resolution_unit_io_triggers_12_vi),
    .io_triggers_12_ptm(trigger_resolution_unit_io_triggers_12_ptm),
    .io_triggers_12_ici(trigger_resolution_unit_io_triggers_12_ici),
    .io_triggers_12_ictb(trigger_resolution_unit_io_triggers_12_ictb),
    .io_triggers_12_ictv(trigger_resolution_unit_io_triggers_12_ictv),
    .io_triggers_12_oci(trigger_resolution_unit_io_triggers_12_oci),
    .io_triggers_13_vi(trigger_resolution_unit_io_triggers_13_vi),
    .io_triggers_13_ptm(trigger_resolution_unit_io_triggers_13_ptm),
    .io_triggers_13_ici(trigger_resolution_unit_io_triggers_13_ici),
    .io_triggers_13_ictb(trigger_resolution_unit_io_triggers_13_ictb),
    .io_triggers_13_ictv(trigger_resolution_unit_io_triggers_13_ictv),
    .io_triggers_13_oci(trigger_resolution_unit_io_triggers_13_oci),
    .io_triggers_14_vi(trigger_resolution_unit_io_triggers_14_vi),
    .io_triggers_14_ptm(trigger_resolution_unit_io_triggers_14_ptm),
    .io_triggers_14_ici(trigger_resolution_unit_io_triggers_14_ici),
    .io_triggers_14_ictb(trigger_resolution_unit_io_triggers_14_ictb),
    .io_triggers_14_ictv(trigger_resolution_unit_io_triggers_14_ictv),
    .io_triggers_14_oci(trigger_resolution_unit_io_triggers_14_oci),
    .io_triggers_15_vi(trigger_resolution_unit_io_triggers_15_vi),
    .io_triggers_15_ptm(trigger_resolution_unit_io_triggers_15_ptm),
    .io_triggers_15_ici(trigger_resolution_unit_io_triggers_15_ici),
    .io_triggers_15_ictb(trigger_resolution_unit_io_triggers_15_ictb),
    .io_triggers_15_ictv(trigger_resolution_unit_io_triggers_15_ictv),
    .io_triggers_15_oci(trigger_resolution_unit_io_triggers_15_oci),
    .io_predicates(trigger_resolution_unit_io_predicates),
    .io_input_channel_empty_status(trigger_resolution_unit_io_input_channel_empty_status),
    .io_input_channel_tags_0(trigger_resolution_unit_io_input_channel_tags_0),
    .io_input_channel_tags_1(trigger_resolution_unit_io_input_channel_tags_1),
    .io_input_channel_tags_2(trigger_resolution_unit_io_input_channel_tags_2),
    .io_input_channel_tags_3(trigger_resolution_unit_io_input_channel_tags_3),
    .io_output_channel_full_status(trigger_resolution_unit_io_output_channel_full_status),
    .io_triggered_instruction_valid(trigger_resolution_unit_io_triggered_instruction_valid),
    .io_triggered_instruction_index(trigger_resolution_unit_io_triggered_instruction_index)
  );
  instruction_memory instruction_memory ( // @[integer_core.scala 170:18:@8017.4]
    .clock(instruction_memory_clock),
    .io_enable(instruction_memory_io_enable),
    .io_host_interface_read_req(instruction_memory_io_host_interface_read_req),
    .io_host_interface_read_ack(instruction_memory_io_host_interface_read_ack),
    .io_host_interface_write_req(instruction_memory_io_host_interface_write_req),
    .io_host_interface_write_ack(instruction_memory_io_host_interface_write_ack),
    .io_host_interface_write_index(instruction_memory_io_host_interface_write_index),
    .io_host_interface_write_data(instruction_memory_io_host_interface_write_data),
    .io_triggers_0_vi(instruction_memory_io_triggers_0_vi),
    .io_triggers_0_ptm(instruction_memory_io_triggers_0_ptm),
    .io_triggers_0_ici(instruction_memory_io_triggers_0_ici),
    .io_triggers_0_ictb(instruction_memory_io_triggers_0_ictb),
    .io_triggers_0_ictv(instruction_memory_io_triggers_0_ictv),
    .io_triggers_0_oci(instruction_memory_io_triggers_0_oci),
    .io_triggers_1_vi(instruction_memory_io_triggers_1_vi),
    .io_triggers_1_ptm(instruction_memory_io_triggers_1_ptm),
    .io_triggers_1_ici(instruction_memory_io_triggers_1_ici),
    .io_triggers_1_ictb(instruction_memory_io_triggers_1_ictb),
    .io_triggers_1_ictv(instruction_memory_io_triggers_1_ictv),
    .io_triggers_1_oci(instruction_memory_io_triggers_1_oci),
    .io_triggers_2_vi(instruction_memory_io_triggers_2_vi),
    .io_triggers_2_ptm(instruction_memory_io_triggers_2_ptm),
    .io_triggers_2_ici(instruction_memory_io_triggers_2_ici),
    .io_triggers_2_ictb(instruction_memory_io_triggers_2_ictb),
    .io_triggers_2_ictv(instruction_memory_io_triggers_2_ictv),
    .io_triggers_2_oci(instruction_memory_io_triggers_2_oci),
    .io_triggers_3_vi(instruction_memory_io_triggers_3_vi),
    .io_triggers_3_ptm(instruction_memory_io_triggers_3_ptm),
    .io_triggers_3_ici(instruction_memory_io_triggers_3_ici),
    .io_triggers_3_ictb(instruction_memory_io_triggers_3_ictb),
    .io_triggers_3_ictv(instruction_memory_io_triggers_3_ictv),
    .io_triggers_3_oci(instruction_memory_io_triggers_3_oci),
    .io_triggers_4_vi(instruction_memory_io_triggers_4_vi),
    .io_triggers_4_ptm(instruction_memory_io_triggers_4_ptm),
    .io_triggers_4_ici(instruction_memory_io_triggers_4_ici),
    .io_triggers_4_ictb(instruction_memory_io_triggers_4_ictb),
    .io_triggers_4_ictv(instruction_memory_io_triggers_4_ictv),
    .io_triggers_4_oci(instruction_memory_io_triggers_4_oci),
    .io_triggers_5_vi(instruction_memory_io_triggers_5_vi),
    .io_triggers_5_ptm(instruction_memory_io_triggers_5_ptm),
    .io_triggers_5_ici(instruction_memory_io_triggers_5_ici),
    .io_triggers_5_ictb(instruction_memory_io_triggers_5_ictb),
    .io_triggers_5_ictv(instruction_memory_io_triggers_5_ictv),
    .io_triggers_5_oci(instruction_memory_io_triggers_5_oci),
    .io_triggers_6_vi(instruction_memory_io_triggers_6_vi),
    .io_triggers_6_ptm(instruction_memory_io_triggers_6_ptm),
    .io_triggers_6_ici(instruction_memory_io_triggers_6_ici),
    .io_triggers_6_ictb(instruction_memory_io_triggers_6_ictb),
    .io_triggers_6_ictv(instruction_memory_io_triggers_6_ictv),
    .io_triggers_6_oci(instruction_memory_io_triggers_6_oci),
    .io_triggers_7_vi(instruction_memory_io_triggers_7_vi),
    .io_triggers_7_ptm(instruction_memory_io_triggers_7_ptm),
    .io_triggers_7_ici(instruction_memory_io_triggers_7_ici),
    .io_triggers_7_ictb(instruction_memory_io_triggers_7_ictb),
    .io_triggers_7_ictv(instruction_memory_io_triggers_7_ictv),
    .io_triggers_7_oci(instruction_memory_io_triggers_7_oci),
    .io_triggers_8_vi(instruction_memory_io_triggers_8_vi),
    .io_triggers_8_ptm(instruction_memory_io_triggers_8_ptm),
    .io_triggers_8_ici(instruction_memory_io_triggers_8_ici),
    .io_triggers_8_ictb(instruction_memory_io_triggers_8_ictb),
    .io_triggers_8_ictv(instruction_memory_io_triggers_8_ictv),
    .io_triggers_8_oci(instruction_memory_io_triggers_8_oci),
    .io_triggers_9_vi(instruction_memory_io_triggers_9_vi),
    .io_triggers_9_ptm(instruction_memory_io_triggers_9_ptm),
    .io_triggers_9_ici(instruction_memory_io_triggers_9_ici),
    .io_triggers_9_ictb(instruction_memory_io_triggers_9_ictb),
    .io_triggers_9_ictv(instruction_memory_io_triggers_9_ictv),
    .io_triggers_9_oci(instruction_memory_io_triggers_9_oci),
    .io_triggers_10_vi(instruction_memory_io_triggers_10_vi),
    .io_triggers_10_ptm(instruction_memory_io_triggers_10_ptm),
    .io_triggers_10_ici(instruction_memory_io_triggers_10_ici),
    .io_triggers_10_ictb(instruction_memory_io_triggers_10_ictb),
    .io_triggers_10_ictv(instruction_memory_io_triggers_10_ictv),
    .io_triggers_10_oci(instruction_memory_io_triggers_10_oci),
    .io_triggers_11_vi(instruction_memory_io_triggers_11_vi),
    .io_triggers_11_ptm(instruction_memory_io_triggers_11_ptm),
    .io_triggers_11_ici(instruction_memory_io_triggers_11_ici),
    .io_triggers_11_ictb(instruction_memory_io_triggers_11_ictb),
    .io_triggers_11_ictv(instruction_memory_io_triggers_11_ictv),
    .io_triggers_11_oci(instruction_memory_io_triggers_11_oci),
    .io_triggers_12_vi(instruction_memory_io_triggers_12_vi),
    .io_triggers_12_ptm(instruction_memory_io_triggers_12_ptm),
    .io_triggers_12_ici(instruction_memory_io_triggers_12_ici),
    .io_triggers_12_ictb(instruction_memory_io_triggers_12_ictb),
    .io_triggers_12_ictv(instruction_memory_io_triggers_12_ictv),
    .io_triggers_12_oci(instruction_memory_io_triggers_12_oci),
    .io_triggers_13_vi(instruction_memory_io_triggers_13_vi),
    .io_triggers_13_ptm(instruction_memory_io_triggers_13_ptm),
    .io_triggers_13_ici(instruction_memory_io_triggers_13_ici),
    .io_triggers_13_ictb(instruction_memory_io_triggers_13_ictb),
    .io_triggers_13_ictv(instruction_memory_io_triggers_13_ictv),
    .io_triggers_13_oci(instruction_memory_io_triggers_13_oci),
    .io_triggers_14_vi(instruction_memory_io_triggers_14_vi),
    .io_triggers_14_ptm(instruction_memory_io_triggers_14_ptm),
    .io_triggers_14_ici(instruction_memory_io_triggers_14_ici),
    .io_triggers_14_ictb(instruction_memory_io_triggers_14_ictb),
    .io_triggers_14_ictv(instruction_memory_io_triggers_14_ictv),
    .io_triggers_14_oci(instruction_memory_io_triggers_14_oci),
    .io_triggers_15_vi(instruction_memory_io_triggers_15_vi),
    .io_triggers_15_ptm(instruction_memory_io_triggers_15_ptm),
    .io_triggers_15_ici(instruction_memory_io_triggers_15_ici),
    .io_triggers_15_ictb(instruction_memory_io_triggers_15_ictb),
    .io_triggers_15_ictv(instruction_memory_io_triggers_15_ictv),
    .io_triggers_15_oci(instruction_memory_io_triggers_15_oci),
    .io_triggered_instruction_valid(instruction_memory_io_triggered_instruction_valid),
    .io_triggered_instruction_index(instruction_memory_io_triggered_instruction_index),
    .io_triggered_datapath_instruction_vi(instruction_memory_io_triggered_datapath_instruction_vi),
    .io_triggered_datapath_instruction_op(instruction_memory_io_triggered_datapath_instruction_op),
    .io_triggered_datapath_instruction_st(instruction_memory_io_triggered_datapath_instruction_st),
    .io_triggered_datapath_instruction_si(instruction_memory_io_triggered_datapath_instruction_si),
    .io_triggered_datapath_instruction_dt(instruction_memory_io_triggered_datapath_instruction_dt),
    .io_triggered_datapath_instruction_di(instruction_memory_io_triggered_datapath_instruction_di),
    .io_triggered_datapath_instruction_oci(instruction_memory_io_triggered_datapath_instruction_oci),
    .io_triggered_datapath_instruction_oct(instruction_memory_io_triggered_datapath_instruction_oct),
    .io_triggered_datapath_instruction_icd(instruction_memory_io_triggered_datapath_instruction_icd),
    .io_triggered_datapath_instruction_pum(instruction_memory_io_triggered_datapath_instruction_pum),
    .io_triggered_datapath_instruction_immediate(instruction_memory_io_triggered_datapath_instruction_immediate)
  );
  integer_collision_detector integer_collision_detector ( // @[integer_core.scala 180:19:@8139.4]
    .io_triggered_instruction_op(integer_collision_detector_io_triggered_instruction_op),
    .io_dx1_instruction_retiring_stage(integer_collision_detector_io_dx1_instruction_retiring_stage),
    .io_collision(integer_collision_detector_io_collision)
  );
  integer_issue_unit integer_issue_unit ( // @[integer_core.scala 205:19:@8215.4]
    .io_dx1_instruction_op(integer_issue_unit_io_dx1_instruction_op),
    .io_retiring_stage(integer_issue_unit_io_retiring_stage),
    .io_functional_unit(integer_issue_unit_io_functional_unit)
  );
  register_file register_file ( // @[integer_core.scala 211:18:@8221.4]
    .clock(register_file_clock),
    .reset(register_file_reset),
    .io_enable(register_file_io_enable),
    .io_host_interface_read_req(register_file_io_host_interface_read_req),
    .io_host_interface_read_ack(register_file_io_host_interface_read_ack),
    .io_host_interface_write_req(register_file_io_host_interface_write_req),
    .io_host_interface_write_ack(register_file_io_host_interface_write_ack),
    .io_host_interface_write_index(register_file_io_host_interface_write_index),
    .io_host_interface_write_data(register_file_io_host_interface_write_data),
    .io_read_indexes_0(register_file_io_read_indexes_0),
    .io_read_indexes_1(register_file_io_read_indexes_1),
    .io_read_indexes_2(register_file_io_read_indexes_2),
    .io_read_data_0(register_file_io_read_data_0),
    .io_read_data_1(register_file_io_read_data_1),
    .io_read_data_2(register_file_io_read_data_2),
    .io_write_enable(register_file_io_write_enable),
    .io_write_index(register_file_io_write_index),
    .io_write_data(register_file_io_write_data)
  );
  source_fetching_unit source_fetching_unit ( // @[integer_core.scala 221:19:@8242.4]
    .io_st(source_fetching_unit_io_st),
    .io_si(source_fetching_unit_io_si),
    .io_immediate(source_fetching_unit_io_immediate),
    .io_input_channel_data_0(source_fetching_unit_io_input_channel_data_0),
    .io_input_channel_data_1(source_fetching_unit_io_input_channel_data_1),
    .io_input_channel_data_2(source_fetching_unit_io_input_channel_data_2),
    .io_input_channel_data_3(source_fetching_unit_io_input_channel_data_3),
    .io_register_read_indexes_0(source_fetching_unit_io_register_read_indexes_0),
    .io_register_read_indexes_1(source_fetching_unit_io_register_read_indexes_1),
    .io_register_read_indexes_2(source_fetching_unit_io_register_read_indexes_2),
    .io_register_read_data_0(source_fetching_unit_io_register_read_data_0),
    .io_register_read_data_1(source_fetching_unit_io_register_read_data_1),
    .io_register_read_data_2(source_fetching_unit_io_register_read_data_2),
    .io_operands_0(source_fetching_unit_io_operands_0),
    .io_operands_1(source_fetching_unit_io_operands_1),
    .io_operands_2(source_fetching_unit_io_operands_2)
  );
  operand_forwarding_unit operand_forwarding_unit ( // @[integer_core.scala 231:19:@8266.4]
    .io_enable(operand_forwarding_unit_io_enable),
    .io_source_types(operand_forwarding_unit_io_source_types),
    .io_source_indices(operand_forwarding_unit_io_source_indices),
    .io_downstream_dt(operand_forwarding_unit_io_downstream_dt),
    .io_downstream_di(operand_forwarding_unit_io_downstream_di),
    .io_downstream_result(operand_forwarding_unit_io_downstream_result),
    .io_pre_ofu_operands_0(operand_forwarding_unit_io_pre_ofu_operands_0),
    .io_pre_ofu_operands_1(operand_forwarding_unit_io_pre_ofu_operands_1),
    .io_post_ofu_operands_0(operand_forwarding_unit_io_post_ofu_operands_0),
    .io_post_ofu_operands_1(operand_forwarding_unit_io_post_ofu_operands_1)
  );
  arithmetic_logic_unit arithmetic_logic_unit ( // @[integer_core.scala 243:19:@8286.4]
    .clock(arithmetic_logic_unit_clock),
    .reset(arithmetic_logic_unit_reset),
    .io_opcode(arithmetic_logic_unit_io_opcode),
    .io_operands_0(arithmetic_logic_unit_io_operands_0),
    .io_operands_1(arithmetic_logic_unit_io_operands_1),
    .io_operands_2(arithmetic_logic_unit_io_operands_2),
    .io_result(arithmetic_logic_unit_io_result)
  );
  scratchpad scratchpad ( // @[integer_core.scala 250:20:@8294.4]
    .clock(scratchpad_clock),
    .io_opcode(scratchpad_io_opcode),
    .io_hostInterface_read_req(scratchpad_io_hostInterface_read_req),
    .io_hostInterface_read_ack(scratchpad_io_hostInterface_read_ack),
    .io_hostInterface_write_req(scratchpad_io_hostInterface_write_req),
    .io_hostInterface_write_ack(scratchpad_io_hostInterface_write_ack),
    .io_hostInterface_write_index(scratchpad_io_hostInterface_write_index),
    .io_hostInterface_write_data(scratchpad_io_hostInterface_write_data),
    .io_operand0(scratchpad_io_operand0),
    .io_operand1(scratchpad_io_operand1),
    .io_result(scratchpad_io_result)
  );
  integer_retirement_unit integer_retirement_unit ( // @[integer_core.scala 282:19:@8361.4]
    .io_dx1_instruction_retiring_stage(integer_retirement_unit_io_dx1_instruction_retiring_stage),
    .io_x2_instruction_retiring_stage(integer_retirement_unit_io_x2_instruction_retiring_stage),
    .io_x2_functional_unit(integer_retirement_unit_io_x2_functional_unit),
    .io_dx1_datapath_instruction_vi(integer_retirement_unit_io_dx1_datapath_instruction_vi),
    .io_dx1_datapath_instruction_op(integer_retirement_unit_io_dx1_datapath_instruction_op),
    .io_dx1_datapath_instruction_dt(integer_retirement_unit_io_dx1_datapath_instruction_dt),
    .io_dx1_datapath_instruction_di(integer_retirement_unit_io_dx1_datapath_instruction_di),
    .io_dx1_datapath_instruction_oci(integer_retirement_unit_io_dx1_datapath_instruction_oci),
    .io_dx1_datapath_instruction_oct(integer_retirement_unit_io_dx1_datapath_instruction_oct),
    .io_x2_datapath_instruction_vi(integer_retirement_unit_io_x2_datapath_instruction_vi),
    .io_x2_datapath_instruction_op(integer_retirement_unit_io_x2_datapath_instruction_op),
    .io_x2_datapath_instruction_dt(integer_retirement_unit_io_x2_datapath_instruction_dt),
    .io_x2_datapath_instruction_di(integer_retirement_unit_io_x2_datapath_instruction_di),
    .io_x2_datapath_instruction_oci(integer_retirement_unit_io_x2_datapath_instruction_oci),
    .io_x2_datapath_instruction_oct(integer_retirement_unit_io_x2_datapath_instruction_oct),
    .io_alu_result(integer_retirement_unit_io_alu_result),
    .io_sm_result(integer_retirement_unit_io_sm_result),
    .io_retiring_datapath_instruction_vi(integer_retirement_unit_io_retiring_datapath_instruction_vi),
    .io_retiring_datapath_instruction_op(integer_retirement_unit_io_retiring_datapath_instruction_op),
    .io_retiring_datapath_instruction_dt(integer_retirement_unit_io_retiring_datapath_instruction_dt),
    .io_retiring_datapath_instruction_di(integer_retirement_unit_io_retiring_datapath_instruction_di),
    .io_retiring_datapath_instruction_oci(integer_retirement_unit_io_retiring_datapath_instruction_oci),
    .io_retiring_datapath_instruction_oct(integer_retirement_unit_io_retiring_datapath_instruction_oct),
    .io_datapath_result(integer_retirement_unit_io_datapath_result)
  );
  destination_routing_unit destination_routing_unit ( // @[integer_core.scala 296:19:@8405.4]
    .io_datapath_result(destination_routing_unit_io_datapath_result),
    .io_dt(destination_routing_unit_io_dt),
    .io_di(destination_routing_unit_io_di),
    .io_oci(destination_routing_unit_io_oci),
    .io_register_write_enable(destination_routing_unit_io_register_write_enable),
    .io_register_write_index(destination_routing_unit_io_register_write_index),
    .io_register_write_data(destination_routing_unit_io_register_write_data),
    .io_output_channel_data_0(destination_routing_unit_io_output_channel_data_0),
    .io_output_channel_data_1(destination_routing_unit_io_output_channel_data_1),
    .io_output_channel_data_2(destination_routing_unit_io_output_channel_data_2),
    .io_output_channel_data_3(destination_routing_unit_io_output_channel_data_3)
  );
  dequeueing_unit dequeueing_unit ( // @[integer_core.scala 307:18:@8419.4]
    .io_enable(dequeueing_unit_io_enable),
    .io_icd(dequeueing_unit_io_icd),
    .io_dequeue_signals(dequeueing_unit_io_dequeue_signals)
  );
  enqueueing_unit enqueueing_unit ( // @[integer_core.scala 313:18:@8436.4]
    .io_enable(enqueueing_unit_io_enable),
    .io_oci(enqueueing_unit_io_oci),
    .io_oct(enqueueing_unit_io_oct),
    .io_enqueue_signals(enqueueing_unit_io_enqueue_signals),
    .io_outout_channel_tags_0(enqueueing_unit_io_outout_channel_tags_0),
    .io_outout_channel_tags_1(enqueueing_unit_io_outout_channel_tags_1),
    .io_outout_channel_tags_2(enqueueing_unit_io_outout_channel_tags_2),
    .io_outout_channel_tags_3(enqueueing_unit_io_outout_channel_tags_3)
  );
  assign _T_522_1 = input_channel_buffer_1_io_quiescent; // @[integer_core.scala 119:44:@7811.4 integer_core.scala 119:44:@7813.4]
  assign _T_522_0 = input_channel_buffer_io_quiescent; // @[integer_core.scala 119:44:@7811.4 integer_core.scala 119:44:@7812.4]
  assign _T_529 = {_T_522_1,_T_522_0}; // @[integer_core.scala 119:98:@7816.4]
  assign _T_522_3 = input_channel_buffer_3_io_quiescent; // @[integer_core.scala 119:44:@7811.4 integer_core.scala 119:44:@7815.4]
  assign _T_522_2 = input_channel_buffer_2_io_quiescent; // @[integer_core.scala 119:44:@7811.4 integer_core.scala 119:44:@7814.4]
  assign _T_530 = {_T_522_3,_T_522_2}; // @[integer_core.scala 119:98:@7817.4]
  assign _T_535_1 = output_channel_buffer_1_io_quiescent; // @[integer_core.scala 120:45:@7820.4 integer_core.scala 120:45:@7822.4]
  assign _T_535_0 = output_channel_buffer_io_quiescent; // @[integer_core.scala 120:45:@7820.4 integer_core.scala 120:45:@7821.4]
  assign _T_542 = {_T_535_1,_T_535_0}; // @[integer_core.scala 120:100:@7825.4]
  assign _T_535_3 = output_channel_buffer_3_io_quiescent; // @[integer_core.scala 120:45:@7820.4 integer_core.scala 120:45:@7824.4]
  assign _T_535_2 = output_channel_buffer_2_io_quiescent; // @[integer_core.scala 120:45:@7820.4 integer_core.scala 120:45:@7823.4]
  assign _T_543 = {_T_535_3,_T_535_2}; // @[integer_core.scala 120:100:@7826.4]
  assign input_channels_1_empty = input_channel_buffer_1_io_out_empty; // @[integer_core.scala 48:28:@7602.4 integer_core.scala 53:23:@7618.4]
  assign input_channels_0_empty = input_channel_buffer_io_out_empty; // @[integer_core.scala 48:28:@7602.4 integer_core.scala 53:23:@7606.4]
  assign _T_555 = {input_channels_1_empty,input_channels_0_empty}; // @[integer_core.scala 138:92:@7851.4]
  assign input_channels_3_empty = input_channel_buffer_3_io_out_empty; // @[integer_core.scala 48:28:@7602.4 integer_core.scala 53:23:@7642.4]
  assign input_channels_2_empty = input_channel_buffer_2_io_out_empty; // @[integer_core.scala 48:28:@7602.4 integer_core.scala 53:23:@7630.4]
  assign _T_556 = {input_channels_3_empty,input_channels_2_empty}; // @[integer_core.scala 138:92:@7852.4]
  assign output_channels_1_full = output_channel_buffer_1_io_in_full; // @[integer_core.scala 49:29:@7603.4 integer_core.scala 59:41:@7664.4]
  assign output_channels_0_full = output_channel_buffer_io_in_full; // @[integer_core.scala 49:29:@7603.4 integer_core.scala 59:41:@7654.4]
  assign _T_568 = {output_channels_1_full,output_channels_0_full}; // @[integer_core.scala 144:91:@7865.4]
  assign output_channels_3_full = output_channel_buffer_3_io_in_full; // @[integer_core.scala 49:29:@7603.4 integer_core.scala 59:41:@7684.4]
  assign output_channels_2_full = output_channel_buffer_2_io_in_full; // @[integer_core.scala 49:29:@7603.4 integer_core.scala 59:41:@7674.4]
  assign _T_569 = {output_channels_3_full,output_channels_2_full}; // @[integer_core.scala 144:91:@7866.4]
  assign input_channels_1_dequeue = dequeueing_unit_io_dequeue_signals[1]; // @[integer_core.scala 310:76:@8430.4]
  assign input_channels_0_dequeue = dequeueing_unit_io_dequeue_signals[0]; // @[integer_core.scala 310:76:@8428.4]
  assign _T_601 = {input_channels_1_dequeue,input_channels_0_dequeue}; // @[integer_core.scala 153:84:@7898.4]
  assign input_channels_3_dequeue = dequeueing_unit_io_dequeue_signals[3]; // @[integer_core.scala 310:76:@8434.4]
  assign input_channels_2_dequeue = dequeueing_unit_io_dequeue_signals[2]; // @[integer_core.scala 310:76:@8432.4]
  assign _T_602 = {input_channels_3_dequeue,input_channels_2_dequeue}; // @[integer_core.scala 153:84:@7899.4]
  assign collision = integer_collision_detector_io_collision; // @[integer_core.scala 66:9:@7701.4 integer_core.scala 183:13:@8144.4]
  assign triggered_datapath_instruction_immediate = instruction_memory_io_triggered_datapath_instruction_immediate; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8127.4]
  assign hazard_free_datapath_instruction_immediate = collision ? 32'h0 : triggered_datapath_instruction_immediate; // @[integer_core.scala 185:15:@8147.4]
  assign triggered_datapath_instruction_pum = instruction_memory_io_triggered_datapath_instruction_pum; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8128.4]
  assign triggered_datapath_instruction_icd = instruction_memory_io_triggered_datapath_instruction_icd; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8129.4]
  assign hazard_free_datapath_instruction_icd = collision ? 4'h0 : triggered_datapath_instruction_icd; // @[integer_core.scala 185:15:@8147.4]
  assign triggered_datapath_instruction_oct = instruction_memory_io_triggered_datapath_instruction_oct; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8130.4]
  assign hazard_free_datapath_instruction_oct = collision ? 2'h0 : triggered_datapath_instruction_oct; // @[integer_core.scala 185:15:@8147.4]
  assign triggered_datapath_instruction_oci = instruction_memory_io_triggered_datapath_instruction_oci; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8131.4]
  assign hazard_free_datapath_instruction_oci = collision ? 4'h0 : triggered_datapath_instruction_oci; // @[integer_core.scala 185:15:@8147.4]
  assign triggered_datapath_instruction_di = instruction_memory_io_triggered_datapath_instruction_di; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8132.4]
  assign hazard_free_datapath_instruction_di = collision ? 3'h0 : triggered_datapath_instruction_di; // @[integer_core.scala 185:15:@8147.4]
  assign triggered_datapath_instruction_dt = instruction_memory_io_triggered_datapath_instruction_dt; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8133.4]
  assign hazard_free_datapath_instruction_dt = collision ? 2'h0 : triggered_datapath_instruction_dt; // @[integer_core.scala 185:15:@8147.4]
  assign triggered_datapath_instruction_si = instruction_memory_io_triggered_datapath_instruction_si; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8134.4]
  assign hazard_free_datapath_instruction_si = collision ? 9'h0 : triggered_datapath_instruction_si; // @[integer_core.scala 185:15:@8147.4]
  assign triggered_datapath_instruction_st = instruction_memory_io_triggered_datapath_instruction_st; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8135.4]
  assign hazard_free_datapath_instruction_st = collision ? 6'h0 : triggered_datapath_instruction_st; // @[integer_core.scala 185:15:@8147.4]
  assign triggered_datapath_instruction_op = instruction_memory_io_triggered_datapath_instruction_op; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8136.4]
  assign hazard_free_datapath_instruction_op = collision ? 6'h0 : triggered_datapath_instruction_op; // @[integer_core.scala 185:15:@8147.4]
  assign triggered_datapath_instruction_vi = instruction_memory_io_triggered_datapath_instruction_vi; // @[integer_core.scala 72:9:@7705.4 integer_core.scala 176:34:@8137.4]
  assign hazard_free_datapath_instruction_vi = collision ? 1'h0 : triggered_datapath_instruction_vi; // @[integer_core.scala 185:15:@8147.4]
  assign _GEN_11 = io_enable ? hazard_free_datapath_instruction_immediate : dx1_triggered_datapath_instruction_immediate; // @[integer_core.scala 197:24:@8200.6]
  assign _GEN_13 = io_enable ? hazard_free_datapath_instruction_icd : dx1_triggered_datapath_instruction_icd; // @[integer_core.scala 197:24:@8200.6]
  assign _GEN_14 = io_enable ? hazard_free_datapath_instruction_oct : dx1_triggered_datapath_instruction_oct; // @[integer_core.scala 197:24:@8200.6]
  assign _GEN_15 = io_enable ? hazard_free_datapath_instruction_oci : dx1_triggered_datapath_instruction_oci; // @[integer_core.scala 197:24:@8200.6]
  assign _GEN_16 = io_enable ? hazard_free_datapath_instruction_di : dx1_triggered_datapath_instruction_di; // @[integer_core.scala 197:24:@8200.6]
  assign _GEN_17 = io_enable ? hazard_free_datapath_instruction_dt : dx1_triggered_datapath_instruction_dt; // @[integer_core.scala 197:24:@8200.6]
  assign _GEN_18 = io_enable ? hazard_free_datapath_instruction_si : dx1_triggered_datapath_instruction_si; // @[integer_core.scala 197:24:@8200.6]
  assign _GEN_19 = io_enable ? hazard_free_datapath_instruction_st : dx1_triggered_datapath_instruction_st; // @[integer_core.scala 197:24:@8200.6]
  assign _GEN_20 = io_enable ? hazard_free_datapath_instruction_op : dx1_triggered_datapath_instruction_op; // @[integer_core.scala 197:24:@8200.6]
  assign _GEN_21 = io_enable ? hazard_free_datapath_instruction_vi : dx1_triggered_datapath_instruction_vi; // @[integer_core.scala 197:24:@8200.6]
  assign _GEN_22 = reset ? 32'h0 : _GEN_11; // @[integer_core.scala 195:52:@8186.4]
  assign _GEN_24 = reset ? 4'h0 : _GEN_13; // @[integer_core.scala 195:52:@8186.4]
  assign _GEN_25 = reset ? 2'h0 : _GEN_14; // @[integer_core.scala 195:52:@8186.4]
  assign _GEN_26 = reset ? 4'h0 : _GEN_15; // @[integer_core.scala 195:52:@8186.4]
  assign _GEN_27 = reset ? 3'h0 : _GEN_16; // @[integer_core.scala 195:52:@8186.4]
  assign _GEN_28 = reset ? 2'h0 : _GEN_17; // @[integer_core.scala 195:52:@8186.4]
  assign _GEN_29 = reset ? 9'h0 : _GEN_18; // @[integer_core.scala 195:52:@8186.4]
  assign _GEN_30 = reset ? 6'h0 : _GEN_19; // @[integer_core.scala 195:52:@8186.4]
  assign _GEN_31 = reset ? 6'h0 : _GEN_20; // @[integer_core.scala 195:52:@8186.4]
  assign _GEN_32 = reset ? 1'h0 : _GEN_21; // @[integer_core.scala 195:52:@8186.4]
  assign _T_619 = dx1_instruction_retiring_stage == 3'h2; // @[integer_core.scala 232:49:@8269.4]
  assign _T_621 = x2_instruction_retiring_stage == 3'h2; // @[integer_core.scala 232:90:@8270.4]
  assign _T_622 = _T_619 & _T_621; // @[integer_core.scala 232:57:@8271.4]
  assign _T_624 = dx1_functional_unit != 3'h0; // @[integer_core.scala 233:25:@8272.4]
  assign _GEN_36 = _T_619 ? dx1_triggered_datapath_instruction_oct : 2'h0; // @[integer_core.scala 270:49:@8330.8]
  assign _GEN_37 = _T_619 ? dx1_triggered_datapath_instruction_oci : 4'h0; // @[integer_core.scala 270:49:@8330.8]
  assign _GEN_38 = _T_619 ? dx1_triggered_datapath_instruction_di : 3'h0; // @[integer_core.scala 270:49:@8330.8]
  assign _GEN_39 = _T_619 ? dx1_triggered_datapath_instruction_dt : 2'h0; // @[integer_core.scala 270:49:@8330.8]
  assign _GEN_42 = _T_619 ? dx1_triggered_datapath_instruction_op : 6'h0; // @[integer_core.scala 270:49:@8330.8]
  assign _GEN_43 = _T_619 ? dx1_triggered_datapath_instruction_vi : 1'h0; // @[integer_core.scala 270:49:@8330.8]
  assign _GEN_44 = _T_619 ? dx1_instruction_retiring_stage : 3'h0; // @[integer_core.scala 270:49:@8330.8]
  assign _GEN_45 = _T_619 ? dx1_functional_unit : 3'h0; // @[integer_core.scala 270:49:@8330.8]
  assign _GEN_49 = io_enable ? _GEN_36 : x2_triggered_datapath_instruction_oct; // @[integer_core.scala 269:24:@8328.6]
  assign _GEN_50 = io_enable ? _GEN_37 : x2_triggered_datapath_instruction_oci; // @[integer_core.scala 269:24:@8328.6]
  assign _GEN_51 = io_enable ? _GEN_38 : x2_triggered_datapath_instruction_di; // @[integer_core.scala 269:24:@8328.6]
  assign _GEN_52 = io_enable ? _GEN_39 : x2_triggered_datapath_instruction_dt; // @[integer_core.scala 269:24:@8328.6]
  assign _GEN_55 = io_enable ? _GEN_42 : x2_triggered_datapath_instruction_op; // @[integer_core.scala 269:24:@8328.6]
  assign _GEN_56 = io_enable ? _GEN_43 : x2_triggered_datapath_instruction_vi; // @[integer_core.scala 269:24:@8328.6]
  assign _GEN_57 = io_enable ? _GEN_44 : x2_instruction_retiring_stage; // @[integer_core.scala 269:24:@8328.6]
  assign _GEN_58 = io_enable ? _GEN_45 : x2_functional_unit; // @[integer_core.scala 269:24:@8328.6]
  assign _GEN_62 = reset ? 2'h0 : _GEN_49; // @[integer_core.scala 265:53:@8312.4]
  assign _GEN_63 = reset ? 4'h0 : _GEN_50; // @[integer_core.scala 265:53:@8312.4]
  assign _GEN_64 = reset ? 3'h0 : _GEN_51; // @[integer_core.scala 265:53:@8312.4]
  assign _GEN_65 = reset ? 2'h0 : _GEN_52; // @[integer_core.scala 265:53:@8312.4]
  assign _GEN_68 = reset ? 6'h0 : _GEN_55; // @[integer_core.scala 265:53:@8312.4]
  assign _GEN_69 = reset ? 1'h0 : _GEN_56; // @[integer_core.scala 265:53:@8312.4]
  assign _GEN_70 = reset ? 3'h0 : _GEN_57; // @[integer_core.scala 265:53:@8312.4]
  assign _GEN_71 = reset ? 3'h0 : _GEN_58; // @[integer_core.scala 265:53:@8312.4]
  assign _T_635 = io_enable & io_execute; // @[integer_core.scala 308:27:@8422.4]
  assign halted = execution_control_unit_io_halted; // @[integer_core.scala 64:28:@7692.4 integer_core.scala 123:10:@7831.4]
  assign _T_637 = halted == 1'h0; // @[integer_core.scala 308:41:@8423.4]
  assign _T_638 = _T_635 & _T_637; // @[integer_core.scala 308:38:@8424.4]
  assign retiring_datapath_instruction_vi = integer_retirement_unit_io_retiring_datapath_instruction_vi; // @[integer_core.scala 72:9:@7708.4 integer_core.scala 292:33:@8403.4]
  assign io_halted = execution_control_unit_io_halted; // @[integer_core.scala 64:69:@7695.4]
  assign io_channels_quiescent = execution_control_unit_io_channels_quiescent; // @[integer_core.scala 124:25:@7832.4]
  assign io_host_interface_read_ack = core_mapper_io_host_interface_read_ack; // @[integer_core.scala 99:23:@7747.4]
  assign io_host_interface_read_data = 32'h0; // @[integer_core.scala 99:23:@7745.4]
  assign io_host_interface_write_ack = core_mapper_io_host_interface_write_ack; // @[integer_core.scala 99:23:@7743.4]
  assign io_input_channel_links_0_ack = input_channel_buffer_io_in_ack; // @[integer_core.scala 54:40:@7614.4]
  assign io_input_channel_links_1_ack = input_channel_buffer_1_io_in_ack; // @[integer_core.scala 54:40:@7626.4]
  assign io_input_channel_links_2_ack = input_channel_buffer_2_io_in_ack; // @[integer_core.scala 54:40:@7638.4]
  assign io_input_channel_links_3_ack = input_channel_buffer_3_io_in_ack; // @[integer_core.scala 54:40:@7650.4]
  assign io_output_channel_links_0_ack = output_channel_buffer_io_out_ack; // @[integer_core.scala 60:32:@7660.4]
  assign io_output_channel_links_0_packet_tag = output_channel_buffer_io_out_packet_tag; // @[integer_core.scala 60:32:@7659.4]
  assign io_output_channel_links_0_packet_data = output_channel_buffer_io_out_packet_data; // @[integer_core.scala 60:32:@7658.4]
  assign io_output_channel_links_1_ack = output_channel_buffer_1_io_out_ack; // @[integer_core.scala 60:32:@7670.4]
  assign io_output_channel_links_1_packet_tag = output_channel_buffer_1_io_out_packet_tag; // @[integer_core.scala 60:32:@7669.4]
  assign io_output_channel_links_1_packet_data = output_channel_buffer_1_io_out_packet_data; // @[integer_core.scala 60:32:@7668.4]
  assign io_output_channel_links_2_ack = output_channel_buffer_2_io_out_ack; // @[integer_core.scala 60:32:@7680.4]
  assign io_output_channel_links_2_packet_tag = output_channel_buffer_2_io_out_packet_tag; // @[integer_core.scala 60:32:@7679.4]
  assign io_output_channel_links_2_packet_data = output_channel_buffer_2_io_out_packet_data; // @[integer_core.scala 60:32:@7678.4]
  assign io_output_channel_links_3_ack = output_channel_buffer_3_io_out_ack; // @[integer_core.scala 60:32:@7690.4]
  assign io_output_channel_links_3_packet_tag = output_channel_buffer_3_io_out_packet_tag; // @[integer_core.scala 60:32:@7689.4]
  assign io_output_channel_links_3_packet_data = output_channel_buffer_3_io_out_packet_data; // @[integer_core.scala 60:32:@7688.4]
  assign input_channel_buffer_clock = clock; // @[:@7579.4]
  assign input_channel_buffer_reset = reset; // @[:@7580.4]
  assign input_channel_buffer_io_enable = io_enable; // @[integer_core.scala 52:44:@7604.4]
  assign input_channel_buffer_io_in_req = io_input_channel_links_0_req; // @[integer_core.scala 54:40:@7615.4]
  assign input_channel_buffer_io_in_packet_tag = io_input_channel_links_0_packet_tag; // @[integer_core.scala 54:40:@7613.4]
  assign input_channel_buffer_io_in_packet_data = io_input_channel_links_0_packet_data; // @[integer_core.scala 54:40:@7612.4]
  assign input_channel_buffer_io_out_dequeue = dequeueing_unit_io_dequeue_signals[0]; // @[integer_core.scala 53:23:@7607.4]
  assign input_channel_buffer_1_clock = clock; // @[:@7582.4]
  assign input_channel_buffer_1_reset = reset; // @[:@7583.4]
  assign input_channel_buffer_1_io_enable = io_enable; // @[integer_core.scala 52:44:@7616.4]
  assign input_channel_buffer_1_io_in_req = io_input_channel_links_1_req; // @[integer_core.scala 54:40:@7627.4]
  assign input_channel_buffer_1_io_in_packet_tag = io_input_channel_links_1_packet_tag; // @[integer_core.scala 54:40:@7625.4]
  assign input_channel_buffer_1_io_in_packet_data = io_input_channel_links_1_packet_data; // @[integer_core.scala 54:40:@7624.4]
  assign input_channel_buffer_1_io_out_dequeue = dequeueing_unit_io_dequeue_signals[1]; // @[integer_core.scala 53:23:@7619.4]
  assign input_channel_buffer_2_clock = clock; // @[:@7585.4]
  assign input_channel_buffer_2_reset = reset; // @[:@7586.4]
  assign input_channel_buffer_2_io_enable = io_enable; // @[integer_core.scala 52:44:@7628.4]
  assign input_channel_buffer_2_io_in_req = io_input_channel_links_2_req; // @[integer_core.scala 54:40:@7639.4]
  assign input_channel_buffer_2_io_in_packet_tag = io_input_channel_links_2_packet_tag; // @[integer_core.scala 54:40:@7637.4]
  assign input_channel_buffer_2_io_in_packet_data = io_input_channel_links_2_packet_data; // @[integer_core.scala 54:40:@7636.4]
  assign input_channel_buffer_2_io_out_dequeue = dequeueing_unit_io_dequeue_signals[2]; // @[integer_core.scala 53:23:@7631.4]
  assign input_channel_buffer_3_clock = clock; // @[:@7588.4]
  assign input_channel_buffer_3_reset = reset; // @[:@7589.4]
  assign input_channel_buffer_3_io_enable = io_enable; // @[integer_core.scala 52:44:@7640.4]
  assign input_channel_buffer_3_io_in_req = io_input_channel_links_3_req; // @[integer_core.scala 54:40:@7651.4]
  assign input_channel_buffer_3_io_in_packet_tag = io_input_channel_links_3_packet_tag; // @[integer_core.scala 54:40:@7649.4]
  assign input_channel_buffer_3_io_in_packet_data = io_input_channel_links_3_packet_data; // @[integer_core.scala 54:40:@7648.4]
  assign input_channel_buffer_3_io_out_dequeue = dequeueing_unit_io_dequeue_signals[3]; // @[integer_core.scala 53:23:@7643.4]
  assign output_channel_buffer_clock = clock; // @[:@7591.4]
  assign output_channel_buffer_reset = reset; // @[:@7592.4]
  assign output_channel_buffer_io_enable = io_enable; // @[integer_core.scala 58:45:@7652.4]
  assign output_channel_buffer_io_in_pack_tag = enqueueing_unit_io_outout_channel_tags_0; // @[integer_core.scala 59:41:@7657.4]
  assign output_channel_buffer_io_in_pack_data = destination_routing_unit_io_output_channel_data_0; // @[integer_core.scala 59:41:@7656.4]
  assign output_channel_buffer_io_in_enqueue = enqueueing_unit_io_enqueue_signals[0]; // @[integer_core.scala 59:41:@7655.4]
  assign output_channel_buffer_io_out_req = io_output_channel_links_0_req; // @[integer_core.scala 60:32:@7661.4]
  assign output_channel_buffer_1_clock = clock; // @[:@7594.4]
  assign output_channel_buffer_1_reset = reset; // @[:@7595.4]
  assign output_channel_buffer_1_io_enable = io_enable; // @[integer_core.scala 58:45:@7662.4]
  assign output_channel_buffer_1_io_in_pack_tag = enqueueing_unit_io_outout_channel_tags_1; // @[integer_core.scala 59:41:@7667.4]
  assign output_channel_buffer_1_io_in_pack_data = destination_routing_unit_io_output_channel_data_1; // @[integer_core.scala 59:41:@7666.4]
  assign output_channel_buffer_1_io_in_enqueue = enqueueing_unit_io_enqueue_signals[1]; // @[integer_core.scala 59:41:@7665.4]
  assign output_channel_buffer_1_io_out_req = io_output_channel_links_1_req; // @[integer_core.scala 60:32:@7671.4]
  assign output_channel_buffer_2_clock = clock; // @[:@7597.4]
  assign output_channel_buffer_2_reset = reset; // @[:@7598.4]
  assign output_channel_buffer_2_io_enable = io_enable; // @[integer_core.scala 58:45:@7672.4]
  assign output_channel_buffer_2_io_in_pack_tag = enqueueing_unit_io_outout_channel_tags_2; // @[integer_core.scala 59:41:@7677.4]
  assign output_channel_buffer_2_io_in_pack_data = destination_routing_unit_io_output_channel_data_2; // @[integer_core.scala 59:41:@7676.4]
  assign output_channel_buffer_2_io_in_enqueue = enqueueing_unit_io_enqueue_signals[2]; // @[integer_core.scala 59:41:@7675.4]
  assign output_channel_buffer_2_io_out_req = io_output_channel_links_2_req; // @[integer_core.scala 60:32:@7681.4]
  assign output_channel_buffer_3_clock = clock; // @[:@7600.4]
  assign output_channel_buffer_3_reset = reset; // @[:@7601.4]
  assign output_channel_buffer_3_io_enable = io_enable; // @[integer_core.scala 58:45:@7682.4]
  assign output_channel_buffer_3_io_in_pack_tag = enqueueing_unit_io_outout_channel_tags_3; // @[integer_core.scala 59:41:@7687.4]
  assign output_channel_buffer_3_io_in_pack_data = destination_routing_unit_io_output_channel_data_3; // @[integer_core.scala 59:41:@7686.4]
  assign output_channel_buffer_3_io_in_enqueue = enqueueing_unit_io_enqueue_signals[3]; // @[integer_core.scala 59:41:@7685.4]
  assign output_channel_buffer_3_io_out_req = io_output_channel_links_3_req; // @[integer_core.scala 60:32:@7691.4]
  assign core_mapper_io_host_interface_read_req = io_host_interface_read_req; // @[integer_core.scala 99:23:@7748.4]
  assign core_mapper_io_host_interface_read_index = io_host_interface_read_index; // @[integer_core.scala 99:23:@7746.4]
  assign core_mapper_io_host_interface_write_req = io_host_interface_write_req; // @[integer_core.scala 99:23:@7744.4]
  assign core_mapper_io_host_interface_write_index = io_host_interface_write_index; // @[integer_core.scala 99:23:@7742.4]
  assign core_mapper_io_host_interface_write_data = io_host_interface_write_data; // @[integer_core.scala 99:23:@7741.4]
  assign core_mapper_io_register_file_interface_read_ack = register_file_io_host_interface_read_ack; // @[integer_core.scala 102:32:@7771.4]
  assign core_mapper_io_register_file_interface_write_ack = register_file_io_host_interface_write_ack; // @[integer_core.scala 102:32:@7767.4]
  assign core_mapper_io_instruction_memory_interface_read_ack = instruction_memory_io_host_interface_read_ack; // @[integer_core.scala 103:37:@7779.4]
  assign core_mapper_io_instruction_memory_interface_write_ack = instruction_memory_io_host_interface_write_ack; // @[integer_core.scala 103:37:@7775.4]
  assign core_mapper_io_scratchpad_memory_interface_read_ack = scratchpad_io_hostInterface_read_ack; // @[integer_core.scala 104:36:@7787.4]
  assign core_mapper_io_scratchpad_memory_interface_write_ack = scratchpad_io_hostInterface_write_ack; // @[integer_core.scala 104:36:@7783.4]
  assign execution_control_unit_reset = reset; // @[:@7807.4]
  assign execution_control_unit_io_enable = io_enable; // @[integer_core.scala 116:14:@7808.4]
  assign execution_control_unit_io_execute = io_execute; // @[integer_core.scala 117:15:@7809.4]
  assign execution_control_unit_io_opcode = integer_retirement_unit_io_retiring_datapath_instruction_op; // @[integer_core.scala 118:14:@7810.4]
  assign execution_control_unit_io_input_channel_quiescent_status = {_T_530,_T_529}; // @[integer_core.scala 119:38:@7819.4]
  assign execution_control_unit_io_output_channel_quiescent_status = {_T_543,_T_542}; // @[integer_core.scala 120:39:@7828.4]
  assign pu_clock = clock; // @[:@7834.4]
  assign pu_reset = execution_control_unit_io_internal_reset; // @[:@7835.4 integer_core.scala 128:12:@7836.4]
  assign pu_io_enable = execution_control_unit_io_internal_enable; // @[integer_core.scala 129:16:@7837.4]
  assign pu_io_datapath_dt = integer_retirement_unit_io_retiring_datapath_instruction_dt; // @[integer_core.scala 130:21:@7838.4]
  assign pu_io_datapath_di = integer_retirement_unit_io_retiring_datapath_instruction_di; // @[integer_core.scala 131:21:@7839.4]
  assign pu_io_datapath_result = integer_retirement_unit_io_datapath_result; // @[integer_core.scala 132:25:@7840.4]
  assign pu_io_instruction_pum = collision ? 16'h0 : triggered_datapath_instruction_pum; // @[integer_core.scala 133:25:@7841.4]
  assign pessimistic_one_stage_input_channel_empty_status_updater_io_input_channel_empty_status = {_T_556,_T_555}; // @[integer_core.scala 138:47:@7854.4]
  assign pessimistic_one_stage_input_channel_empty_status_updater_io_downstream_icd = dx1_triggered_datapath_instruction_icd; // @[integer_core.scala 139:35:@7855.4]
  assign pessimistic_two_stage_output_channel_full_status_updater_io_output_channel_full_status = {_T_569,_T_568}; // @[integer_core.scala 144:46:@7868.4]
  assign pessimistic_two_stage_output_channel_full_status_updater_io_first_downstream_oci = dx1_triggered_datapath_instruction_oci; // @[integer_core.scala 145:40:@7869.4]
  assign pessimistic_two_stage_output_channel_full_status_updater_io_second_downstream_oci = x2_triggered_datapath_instruction_oci; // @[integer_core.scala 146:41:@7870.4]
  assign input_channel_tag_lookahead_unit_io_pending_dequeue_signals = {_T_602,_T_601}; // @[integer_core.scala 153:40:@7901.4]
  assign input_channel_tag_lookahead_unit_io_original_tags_0 = input_channel_buffer_io_out_pack_tag; // @[integer_core.scala 151:30:@7880.4]
  assign input_channel_tag_lookahead_unit_io_original_tags_1 = input_channel_buffer_1_io_out_pack_tag; // @[integer_core.scala 151:30:@7881.4]
  assign input_channel_tag_lookahead_unit_io_original_tags_2 = input_channel_buffer_2_io_out_pack_tag; // @[integer_core.scala 151:30:@7882.4]
  assign input_channel_tag_lookahead_unit_io_original_tags_3 = input_channel_buffer_3_io_out_pack_tag; // @[integer_core.scala 151:30:@7883.4]
  assign input_channel_tag_lookahead_unit_io_next_tags_0 = input_channel_buffer_io_out_next_pack_tag; // @[integer_core.scala 152:26:@7889.4]
  assign input_channel_tag_lookahead_unit_io_next_tags_1 = input_channel_buffer_1_io_out_next_pack_tag; // @[integer_core.scala 152:26:@7890.4]
  assign input_channel_tag_lookahead_unit_io_next_tags_2 = input_channel_buffer_2_io_out_next_pack_tag; // @[integer_core.scala 152:26:@7891.4]
  assign input_channel_tag_lookahead_unit_io_next_tags_3 = input_channel_buffer_3_io_out_next_pack_tag; // @[integer_core.scala 152:26:@7892.4]
  assign trigger_resolution_unit_clock = clock; // @[:@7907.4]
  assign trigger_resolution_unit_reset = reset; // @[:@7908.4]
  assign trigger_resolution_unit_io_enable = execution_control_unit_io_internal_enable; // @[integer_core.scala 158:14:@7909.4]
  assign trigger_resolution_unit_io_execute = io_execute; // @[integer_core.scala 159:15:@7910.4]
  assign trigger_resolution_unit_io_halted = execution_control_unit_io_halted; // @[integer_core.scala 160:14:@7911.4]
  assign trigger_resolution_unit_io_triggers_0_vi = instruction_memory_io_triggers_0_vi; // @[integer_core.scala 161:16:@7917.4]
  assign trigger_resolution_unit_io_triggers_0_ptm = instruction_memory_io_triggers_0_ptm; // @[integer_core.scala 161:16:@7916.4]
  assign trigger_resolution_unit_io_triggers_0_ici = instruction_memory_io_triggers_0_ici; // @[integer_core.scala 161:16:@7915.4]
  assign trigger_resolution_unit_io_triggers_0_ictb = instruction_memory_io_triggers_0_ictb; // @[integer_core.scala 161:16:@7914.4]
  assign trigger_resolution_unit_io_triggers_0_ictv = instruction_memory_io_triggers_0_ictv; // @[integer_core.scala 161:16:@7913.4]
  assign trigger_resolution_unit_io_triggers_0_oci = instruction_memory_io_triggers_0_oci; // @[integer_core.scala 161:16:@7912.4]
  assign trigger_resolution_unit_io_triggers_1_vi = instruction_memory_io_triggers_1_vi; // @[integer_core.scala 161:16:@7923.4]
  assign trigger_resolution_unit_io_triggers_1_ptm = instruction_memory_io_triggers_1_ptm; // @[integer_core.scala 161:16:@7922.4]
  assign trigger_resolution_unit_io_triggers_1_ici = instruction_memory_io_triggers_1_ici; // @[integer_core.scala 161:16:@7921.4]
  assign trigger_resolution_unit_io_triggers_1_ictb = instruction_memory_io_triggers_1_ictb; // @[integer_core.scala 161:16:@7920.4]
  assign trigger_resolution_unit_io_triggers_1_ictv = instruction_memory_io_triggers_1_ictv; // @[integer_core.scala 161:16:@7919.4]
  assign trigger_resolution_unit_io_triggers_1_oci = instruction_memory_io_triggers_1_oci; // @[integer_core.scala 161:16:@7918.4]
  assign trigger_resolution_unit_io_triggers_2_vi = instruction_memory_io_triggers_2_vi; // @[integer_core.scala 161:16:@7929.4]
  assign trigger_resolution_unit_io_triggers_2_ptm = instruction_memory_io_triggers_2_ptm; // @[integer_core.scala 161:16:@7928.4]
  assign trigger_resolution_unit_io_triggers_2_ici = instruction_memory_io_triggers_2_ici; // @[integer_core.scala 161:16:@7927.4]
  assign trigger_resolution_unit_io_triggers_2_ictb = instruction_memory_io_triggers_2_ictb; // @[integer_core.scala 161:16:@7926.4]
  assign trigger_resolution_unit_io_triggers_2_ictv = instruction_memory_io_triggers_2_ictv; // @[integer_core.scala 161:16:@7925.4]
  assign trigger_resolution_unit_io_triggers_2_oci = instruction_memory_io_triggers_2_oci; // @[integer_core.scala 161:16:@7924.4]
  assign trigger_resolution_unit_io_triggers_3_vi = instruction_memory_io_triggers_3_vi; // @[integer_core.scala 161:16:@7935.4]
  assign trigger_resolution_unit_io_triggers_3_ptm = instruction_memory_io_triggers_3_ptm; // @[integer_core.scala 161:16:@7934.4]
  assign trigger_resolution_unit_io_triggers_3_ici = instruction_memory_io_triggers_3_ici; // @[integer_core.scala 161:16:@7933.4]
  assign trigger_resolution_unit_io_triggers_3_ictb = instruction_memory_io_triggers_3_ictb; // @[integer_core.scala 161:16:@7932.4]
  assign trigger_resolution_unit_io_triggers_3_ictv = instruction_memory_io_triggers_3_ictv; // @[integer_core.scala 161:16:@7931.4]
  assign trigger_resolution_unit_io_triggers_3_oci = instruction_memory_io_triggers_3_oci; // @[integer_core.scala 161:16:@7930.4]
  assign trigger_resolution_unit_io_triggers_4_vi = instruction_memory_io_triggers_4_vi; // @[integer_core.scala 161:16:@7941.4]
  assign trigger_resolution_unit_io_triggers_4_ptm = instruction_memory_io_triggers_4_ptm; // @[integer_core.scala 161:16:@7940.4]
  assign trigger_resolution_unit_io_triggers_4_ici = instruction_memory_io_triggers_4_ici; // @[integer_core.scala 161:16:@7939.4]
  assign trigger_resolution_unit_io_triggers_4_ictb = instruction_memory_io_triggers_4_ictb; // @[integer_core.scala 161:16:@7938.4]
  assign trigger_resolution_unit_io_triggers_4_ictv = instruction_memory_io_triggers_4_ictv; // @[integer_core.scala 161:16:@7937.4]
  assign trigger_resolution_unit_io_triggers_4_oci = instruction_memory_io_triggers_4_oci; // @[integer_core.scala 161:16:@7936.4]
  assign trigger_resolution_unit_io_triggers_5_vi = instruction_memory_io_triggers_5_vi; // @[integer_core.scala 161:16:@7947.4]
  assign trigger_resolution_unit_io_triggers_5_ptm = instruction_memory_io_triggers_5_ptm; // @[integer_core.scala 161:16:@7946.4]
  assign trigger_resolution_unit_io_triggers_5_ici = instruction_memory_io_triggers_5_ici; // @[integer_core.scala 161:16:@7945.4]
  assign trigger_resolution_unit_io_triggers_5_ictb = instruction_memory_io_triggers_5_ictb; // @[integer_core.scala 161:16:@7944.4]
  assign trigger_resolution_unit_io_triggers_5_ictv = instruction_memory_io_triggers_5_ictv; // @[integer_core.scala 161:16:@7943.4]
  assign trigger_resolution_unit_io_triggers_5_oci = instruction_memory_io_triggers_5_oci; // @[integer_core.scala 161:16:@7942.4]
  assign trigger_resolution_unit_io_triggers_6_vi = instruction_memory_io_triggers_6_vi; // @[integer_core.scala 161:16:@7953.4]
  assign trigger_resolution_unit_io_triggers_6_ptm = instruction_memory_io_triggers_6_ptm; // @[integer_core.scala 161:16:@7952.4]
  assign trigger_resolution_unit_io_triggers_6_ici = instruction_memory_io_triggers_6_ici; // @[integer_core.scala 161:16:@7951.4]
  assign trigger_resolution_unit_io_triggers_6_ictb = instruction_memory_io_triggers_6_ictb; // @[integer_core.scala 161:16:@7950.4]
  assign trigger_resolution_unit_io_triggers_6_ictv = instruction_memory_io_triggers_6_ictv; // @[integer_core.scala 161:16:@7949.4]
  assign trigger_resolution_unit_io_triggers_6_oci = instruction_memory_io_triggers_6_oci; // @[integer_core.scala 161:16:@7948.4]
  assign trigger_resolution_unit_io_triggers_7_vi = instruction_memory_io_triggers_7_vi; // @[integer_core.scala 161:16:@7959.4]
  assign trigger_resolution_unit_io_triggers_7_ptm = instruction_memory_io_triggers_7_ptm; // @[integer_core.scala 161:16:@7958.4]
  assign trigger_resolution_unit_io_triggers_7_ici = instruction_memory_io_triggers_7_ici; // @[integer_core.scala 161:16:@7957.4]
  assign trigger_resolution_unit_io_triggers_7_ictb = instruction_memory_io_triggers_7_ictb; // @[integer_core.scala 161:16:@7956.4]
  assign trigger_resolution_unit_io_triggers_7_ictv = instruction_memory_io_triggers_7_ictv; // @[integer_core.scala 161:16:@7955.4]
  assign trigger_resolution_unit_io_triggers_7_oci = instruction_memory_io_triggers_7_oci; // @[integer_core.scala 161:16:@7954.4]
  assign trigger_resolution_unit_io_triggers_8_vi = instruction_memory_io_triggers_8_vi; // @[integer_core.scala 161:16:@7965.4]
  assign trigger_resolution_unit_io_triggers_8_ptm = instruction_memory_io_triggers_8_ptm; // @[integer_core.scala 161:16:@7964.4]
  assign trigger_resolution_unit_io_triggers_8_ici = instruction_memory_io_triggers_8_ici; // @[integer_core.scala 161:16:@7963.4]
  assign trigger_resolution_unit_io_triggers_8_ictb = instruction_memory_io_triggers_8_ictb; // @[integer_core.scala 161:16:@7962.4]
  assign trigger_resolution_unit_io_triggers_8_ictv = instruction_memory_io_triggers_8_ictv; // @[integer_core.scala 161:16:@7961.4]
  assign trigger_resolution_unit_io_triggers_8_oci = instruction_memory_io_triggers_8_oci; // @[integer_core.scala 161:16:@7960.4]
  assign trigger_resolution_unit_io_triggers_9_vi = instruction_memory_io_triggers_9_vi; // @[integer_core.scala 161:16:@7971.4]
  assign trigger_resolution_unit_io_triggers_9_ptm = instruction_memory_io_triggers_9_ptm; // @[integer_core.scala 161:16:@7970.4]
  assign trigger_resolution_unit_io_triggers_9_ici = instruction_memory_io_triggers_9_ici; // @[integer_core.scala 161:16:@7969.4]
  assign trigger_resolution_unit_io_triggers_9_ictb = instruction_memory_io_triggers_9_ictb; // @[integer_core.scala 161:16:@7968.4]
  assign trigger_resolution_unit_io_triggers_9_ictv = instruction_memory_io_triggers_9_ictv; // @[integer_core.scala 161:16:@7967.4]
  assign trigger_resolution_unit_io_triggers_9_oci = instruction_memory_io_triggers_9_oci; // @[integer_core.scala 161:16:@7966.4]
  assign trigger_resolution_unit_io_triggers_10_vi = instruction_memory_io_triggers_10_vi; // @[integer_core.scala 161:16:@7977.4]
  assign trigger_resolution_unit_io_triggers_10_ptm = instruction_memory_io_triggers_10_ptm; // @[integer_core.scala 161:16:@7976.4]
  assign trigger_resolution_unit_io_triggers_10_ici = instruction_memory_io_triggers_10_ici; // @[integer_core.scala 161:16:@7975.4]
  assign trigger_resolution_unit_io_triggers_10_ictb = instruction_memory_io_triggers_10_ictb; // @[integer_core.scala 161:16:@7974.4]
  assign trigger_resolution_unit_io_triggers_10_ictv = instruction_memory_io_triggers_10_ictv; // @[integer_core.scala 161:16:@7973.4]
  assign trigger_resolution_unit_io_triggers_10_oci = instruction_memory_io_triggers_10_oci; // @[integer_core.scala 161:16:@7972.4]
  assign trigger_resolution_unit_io_triggers_11_vi = instruction_memory_io_triggers_11_vi; // @[integer_core.scala 161:16:@7983.4]
  assign trigger_resolution_unit_io_triggers_11_ptm = instruction_memory_io_triggers_11_ptm; // @[integer_core.scala 161:16:@7982.4]
  assign trigger_resolution_unit_io_triggers_11_ici = instruction_memory_io_triggers_11_ici; // @[integer_core.scala 161:16:@7981.4]
  assign trigger_resolution_unit_io_triggers_11_ictb = instruction_memory_io_triggers_11_ictb; // @[integer_core.scala 161:16:@7980.4]
  assign trigger_resolution_unit_io_triggers_11_ictv = instruction_memory_io_triggers_11_ictv; // @[integer_core.scala 161:16:@7979.4]
  assign trigger_resolution_unit_io_triggers_11_oci = instruction_memory_io_triggers_11_oci; // @[integer_core.scala 161:16:@7978.4]
  assign trigger_resolution_unit_io_triggers_12_vi = instruction_memory_io_triggers_12_vi; // @[integer_core.scala 161:16:@7989.4]
  assign trigger_resolution_unit_io_triggers_12_ptm = instruction_memory_io_triggers_12_ptm; // @[integer_core.scala 161:16:@7988.4]
  assign trigger_resolution_unit_io_triggers_12_ici = instruction_memory_io_triggers_12_ici; // @[integer_core.scala 161:16:@7987.4]
  assign trigger_resolution_unit_io_triggers_12_ictb = instruction_memory_io_triggers_12_ictb; // @[integer_core.scala 161:16:@7986.4]
  assign trigger_resolution_unit_io_triggers_12_ictv = instruction_memory_io_triggers_12_ictv; // @[integer_core.scala 161:16:@7985.4]
  assign trigger_resolution_unit_io_triggers_12_oci = instruction_memory_io_triggers_12_oci; // @[integer_core.scala 161:16:@7984.4]
  assign trigger_resolution_unit_io_triggers_13_vi = instruction_memory_io_triggers_13_vi; // @[integer_core.scala 161:16:@7995.4]
  assign trigger_resolution_unit_io_triggers_13_ptm = instruction_memory_io_triggers_13_ptm; // @[integer_core.scala 161:16:@7994.4]
  assign trigger_resolution_unit_io_triggers_13_ici = instruction_memory_io_triggers_13_ici; // @[integer_core.scala 161:16:@7993.4]
  assign trigger_resolution_unit_io_triggers_13_ictb = instruction_memory_io_triggers_13_ictb; // @[integer_core.scala 161:16:@7992.4]
  assign trigger_resolution_unit_io_triggers_13_ictv = instruction_memory_io_triggers_13_ictv; // @[integer_core.scala 161:16:@7991.4]
  assign trigger_resolution_unit_io_triggers_13_oci = instruction_memory_io_triggers_13_oci; // @[integer_core.scala 161:16:@7990.4]
  assign trigger_resolution_unit_io_triggers_14_vi = instruction_memory_io_triggers_14_vi; // @[integer_core.scala 161:16:@8001.4]
  assign trigger_resolution_unit_io_triggers_14_ptm = instruction_memory_io_triggers_14_ptm; // @[integer_core.scala 161:16:@8000.4]
  assign trigger_resolution_unit_io_triggers_14_ici = instruction_memory_io_triggers_14_ici; // @[integer_core.scala 161:16:@7999.4]
  assign trigger_resolution_unit_io_triggers_14_ictb = instruction_memory_io_triggers_14_ictb; // @[integer_core.scala 161:16:@7998.4]
  assign trigger_resolution_unit_io_triggers_14_ictv = instruction_memory_io_triggers_14_ictv; // @[integer_core.scala 161:16:@7997.4]
  assign trigger_resolution_unit_io_triggers_14_oci = instruction_memory_io_triggers_14_oci; // @[integer_core.scala 161:16:@7996.4]
  assign trigger_resolution_unit_io_triggers_15_vi = instruction_memory_io_triggers_15_vi; // @[integer_core.scala 161:16:@8007.4]
  assign trigger_resolution_unit_io_triggers_15_ptm = instruction_memory_io_triggers_15_ptm; // @[integer_core.scala 161:16:@8006.4]
  assign trigger_resolution_unit_io_triggers_15_ici = instruction_memory_io_triggers_15_ici; // @[integer_core.scala 161:16:@8005.4]
  assign trigger_resolution_unit_io_triggers_15_ictb = instruction_memory_io_triggers_15_ictb; // @[integer_core.scala 161:16:@8004.4]
  assign trigger_resolution_unit_io_triggers_15_ictv = instruction_memory_io_triggers_15_ictv; // @[integer_core.scala 161:16:@8003.4]
  assign trigger_resolution_unit_io_triggers_15_oci = instruction_memory_io_triggers_15_oci; // @[integer_core.scala 161:16:@8002.4]
  assign trigger_resolution_unit_io_predicates = pu_io_predicates; // @[integer_core.scala 162:18:@8008.4]
  assign trigger_resolution_unit_io_input_channel_empty_status = pessimistic_one_stage_input_channel_empty_status_updater_io_updated_input_channel_empty_status; // @[integer_core.scala 163:34:@8009.4]
  assign trigger_resolution_unit_io_input_channel_tags_0 = input_channel_tag_lookahead_unit_io_resolved_tags_0; // @[integer_core.scala 164:26:@8010.4]
  assign trigger_resolution_unit_io_input_channel_tags_1 = input_channel_tag_lookahead_unit_io_resolved_tags_1; // @[integer_core.scala 164:26:@8011.4]
  assign trigger_resolution_unit_io_input_channel_tags_2 = input_channel_tag_lookahead_unit_io_resolved_tags_2; // @[integer_core.scala 164:26:@8012.4]
  assign trigger_resolution_unit_io_input_channel_tags_3 = input_channel_tag_lookahead_unit_io_resolved_tags_3; // @[integer_core.scala 164:26:@8013.4]
  assign trigger_resolution_unit_io_output_channel_full_status = pessimistic_two_stage_output_channel_full_status_updater_io_updated_output_channel_full_status; // @[integer_core.scala 165:34:@8014.4]
  assign instruction_memory_clock = clock; // @[:@8018.4]
  assign instruction_memory_io_enable = io_enable; // @[integer_core.scala 171:13:@8020.4]
  assign instruction_memory_io_host_interface_read_req = core_mapper_io_instruction_memory_interface_read_req; // @[integer_core.scala 172:21:@8028.4]
  assign instruction_memory_io_host_interface_write_req = core_mapper_io_instruction_memory_interface_write_req; // @[integer_core.scala 172:21:@8024.4]
  assign instruction_memory_io_host_interface_write_index = core_mapper_io_instruction_memory_interface_write_index; // @[integer_core.scala 172:21:@8022.4]
  assign instruction_memory_io_host_interface_write_data = core_mapper_io_instruction_memory_interface_write_data; // @[integer_core.scala 172:21:@8021.4]
  assign instruction_memory_io_triggered_instruction_valid = trigger_resolution_unit_io_triggered_instruction_valid; // @[integer_core.scala 174:34:@8125.4]
  assign instruction_memory_io_triggered_instruction_index = trigger_resolution_unit_io_triggered_instruction_index; // @[integer_core.scala 175:34:@8126.4]
  assign integer_collision_detector_io_triggered_instruction_op = instruction_memory_io_triggered_datapath_instruction_op; // @[integer_core.scala 181:32:@8142.4]
  assign integer_collision_detector_io_dx1_instruction_retiring_stage = dx1_instruction_retiring_stage; // @[integer_core.scala 182:38:@8143.4]
  assign integer_issue_unit_io_dx1_instruction_op = dx1_triggered_datapath_instruction_op; // @[integer_core.scala 206:26:@8218.4]
  assign register_file_clock = clock; // @[:@8222.4]
  assign register_file_reset = reset; // @[:@8223.4]
  assign register_file_io_enable = io_enable; // @[integer_core.scala 212:13:@8224.4]
  assign register_file_io_host_interface_read_req = core_mapper_io_register_file_interface_read_req; // @[integer_core.scala 213:21:@8232.4]
  assign register_file_io_host_interface_write_req = core_mapper_io_register_file_interface_write_req; // @[integer_core.scala 213:21:@8228.4]
  assign register_file_io_host_interface_write_index = core_mapper_io_register_file_interface_write_index; // @[integer_core.scala 213:21:@8226.4]
  assign register_file_io_host_interface_write_data = core_mapper_io_register_file_interface_write_data; // @[integer_core.scala 213:21:@8225.4]
  assign register_file_io_read_indexes_0 = source_fetching_unit_io_register_read_indexes_0; // @[integer_core.scala 214:19:@8233.4]
  assign register_file_io_read_indexes_1 = source_fetching_unit_io_register_read_indexes_1; // @[integer_core.scala 214:19:@8234.4]
  assign register_file_io_read_indexes_2 = source_fetching_unit_io_register_read_indexes_2; // @[integer_core.scala 214:19:@8235.4]
  assign register_file_io_write_enable = destination_routing_unit_io_register_write_enable; // @[integer_core.scala 216:19:@8239.4]
  assign register_file_io_write_index = destination_routing_unit_io_register_write_index; // @[integer_core.scala 217:18:@8240.4]
  assign register_file_io_write_data = destination_routing_unit_io_register_write_data; // @[integer_core.scala 218:17:@8241.4]
  assign source_fetching_unit_io_st = dx1_triggered_datapath_instruction_st; // @[integer_core.scala 222:10:@8245.4]
  assign source_fetching_unit_io_si = dx1_triggered_datapath_instruction_si; // @[integer_core.scala 223:10:@8246.4]
  assign source_fetching_unit_io_immediate = dx1_triggered_datapath_instruction_immediate; // @[integer_core.scala 224:17:@8247.4]
  assign source_fetching_unit_io_input_channel_data_0 = input_channel_buffer_io_out_pack_data; // @[integer_core.scala 225:26:@8253.4]
  assign source_fetching_unit_io_input_channel_data_1 = input_channel_buffer_1_io_out_pack_data; // @[integer_core.scala 225:26:@8254.4]
  assign source_fetching_unit_io_input_channel_data_2 = input_channel_buffer_2_io_out_pack_data; // @[integer_core.scala 225:26:@8255.4]
  assign source_fetching_unit_io_input_channel_data_3 = input_channel_buffer_3_io_out_pack_data; // @[integer_core.scala 225:26:@8256.4]
  assign source_fetching_unit_io_register_read_data_0 = register_file_io_read_data_0; // @[integer_core.scala 227:26:@8260.4]
  assign source_fetching_unit_io_register_read_data_1 = register_file_io_read_data_1; // @[integer_core.scala 227:26:@8261.4]
  assign source_fetching_unit_io_register_read_data_2 = register_file_io_read_data_2; // @[integer_core.scala 227:26:@8262.4]
  assign operand_forwarding_unit_io_enable = _T_622 & _T_624; // @[integer_core.scala 232:14:@8274.4]
  assign operand_forwarding_unit_io_source_types = dx1_triggered_datapath_instruction_st; // @[integer_core.scala 234:20:@8275.4]
  assign operand_forwarding_unit_io_source_indices = dx1_triggered_datapath_instruction_si; // @[integer_core.scala 235:22:@8276.4]
  assign operand_forwarding_unit_io_downstream_dt = dx1_triggered_datapath_instruction_dt; // @[integer_core.scala 236:21:@8277.4]
  assign operand_forwarding_unit_io_downstream_di = dx1_triggered_datapath_instruction_di; // @[integer_core.scala 237:21:@8278.4]
  assign operand_forwarding_unit_io_downstream_result = integer_retirement_unit_io_datapath_result; // @[integer_core.scala 238:25:@8279.4]
  assign operand_forwarding_unit_io_pre_ofu_operands_0 = source_fetching_unit_io_operands_0; // @[integer_core.scala 239:24:@8280.4]
  assign operand_forwarding_unit_io_pre_ofu_operands_1 = source_fetching_unit_io_operands_1; // @[integer_core.scala 239:24:@8281.4]
  assign arithmetic_logic_unit_clock = clock; // @[:@8287.4]
  assign arithmetic_logic_unit_reset = reset; // @[:@8288.4]
  assign arithmetic_logic_unit_io_opcode = dx1_triggered_datapath_instruction_op[3:0]; // @[integer_core.scala 244:14:@8289.4]
  assign arithmetic_logic_unit_io_operands_0 = source_fetching_unit_io_operands_0; // @[integer_core.scala 245:16:@8290.4]
  assign arithmetic_logic_unit_io_operands_1 = source_fetching_unit_io_operands_1; // @[integer_core.scala 245:16:@8291.4]
  assign arithmetic_logic_unit_io_operands_2 = source_fetching_unit_io_operands_2; // @[integer_core.scala 245:16:@8292.4]
  assign scratchpad_clock = clock; // @[:@8295.4]
  assign scratchpad_io_opcode = dx1_triggered_datapath_instruction_op; // @[integer_core.scala 252:15:@8305.4]
  assign scratchpad_io_hostInterface_read_req = core_mapper_io_scratchpad_memory_interface_read_req; // @[integer_core.scala 251:22:@8304.4]
  assign scratchpad_io_hostInterface_write_req = core_mapper_io_scratchpad_memory_interface_write_req; // @[integer_core.scala 251:22:@8300.4]
  assign scratchpad_io_hostInterface_write_index = core_mapper_io_scratchpad_memory_interface_write_index; // @[integer_core.scala 251:22:@8298.4]
  assign scratchpad_io_hostInterface_write_data = core_mapper_io_scratchpad_memory_interface_write_data; // @[integer_core.scala 251:22:@8297.4]
  assign scratchpad_io_operand0 = operand_forwarding_unit_io_post_ofu_operands_0; // @[integer_core.scala 253:17:@8306.4]
  assign scratchpad_io_operand1 = operand_forwarding_unit_io_post_ofu_operands_1; // @[integer_core.scala 254:17:@8307.4]
  assign integer_retirement_unit_io_dx1_instruction_retiring_stage = dx1_instruction_retiring_stage; // @[integer_core.scala 285:38:@8376.4]
  assign integer_retirement_unit_io_x2_instruction_retiring_stage = x2_instruction_retiring_stage; // @[integer_core.scala 288:37:@8389.4]
  assign integer_retirement_unit_io_x2_functional_unit = x2_functional_unit; // @[integer_core.scala 287:26:@8388.4]
  assign integer_retirement_unit_io_dx1_datapath_instruction_vi = dx1_triggered_datapath_instruction_vi; // @[integer_core.scala 283:32:@8374.4]
  assign integer_retirement_unit_io_dx1_datapath_instruction_op = dx1_triggered_datapath_instruction_op; // @[integer_core.scala 283:32:@8373.4]
  assign integer_retirement_unit_io_dx1_datapath_instruction_dt = dx1_triggered_datapath_instruction_dt; // @[integer_core.scala 283:32:@8370.4]
  assign integer_retirement_unit_io_dx1_datapath_instruction_di = dx1_triggered_datapath_instruction_di; // @[integer_core.scala 283:32:@8369.4]
  assign integer_retirement_unit_io_dx1_datapath_instruction_oci = dx1_triggered_datapath_instruction_oci; // @[integer_core.scala 283:32:@8368.4]
  assign integer_retirement_unit_io_dx1_datapath_instruction_oct = dx1_triggered_datapath_instruction_oct; // @[integer_core.scala 283:32:@8367.4]
  assign integer_retirement_unit_io_x2_datapath_instruction_vi = x2_triggered_datapath_instruction_vi; // @[integer_core.scala 286:31:@8387.4]
  assign integer_retirement_unit_io_x2_datapath_instruction_op = x2_triggered_datapath_instruction_op; // @[integer_core.scala 286:31:@8386.4]
  assign integer_retirement_unit_io_x2_datapath_instruction_dt = x2_triggered_datapath_instruction_dt; // @[integer_core.scala 286:31:@8383.4]
  assign integer_retirement_unit_io_x2_datapath_instruction_di = x2_triggered_datapath_instruction_di; // @[integer_core.scala 286:31:@8382.4]
  assign integer_retirement_unit_io_x2_datapath_instruction_oci = x2_triggered_datapath_instruction_oci; // @[integer_core.scala 286:31:@8381.4]
  assign integer_retirement_unit_io_x2_datapath_instruction_oct = x2_triggered_datapath_instruction_oct; // @[integer_core.scala 286:31:@8380.4]
  assign integer_retirement_unit_io_alu_result = arithmetic_logic_unit_io_result; // @[integer_core.scala 289:18:@8390.4]
  assign integer_retirement_unit_io_sm_result = scratchpad_io_result; // @[integer_core.scala 290:17:@8391.4]
  assign destination_routing_unit_io_datapath_result = integer_retirement_unit_io_datapath_result; // @[integer_core.scala 297:23:@8408.4]
  assign destination_routing_unit_io_dt = integer_retirement_unit_io_retiring_datapath_instruction_dt; // @[integer_core.scala 298:10:@8409.4]
  assign destination_routing_unit_io_di = integer_retirement_unit_io_retiring_datapath_instruction_di; // @[integer_core.scala 299:10:@8410.4]
  assign destination_routing_unit_io_oci = integer_retirement_unit_io_retiring_datapath_instruction_oci; // @[integer_core.scala 300:11:@8411.4]
  assign dequeueing_unit_io_enable = _T_638 & dx1_triggered_datapath_instruction_vi; // @[integer_core.scala 308:13:@8426.4]
  assign dequeueing_unit_io_icd = dx1_triggered_datapath_instruction_icd; // @[integer_core.scala 309:10:@8427.4]
  assign enqueueing_unit_io_enable = _T_638 & retiring_datapath_instruction_vi; // @[integer_core.scala 314:13:@8443.4]
  assign enqueueing_unit_io_oci = integer_retirement_unit_io_retiring_datapath_instruction_oci; // @[integer_core.scala 315:10:@8444.4]
  assign enqueueing_unit_io_oct = integer_retirement_unit_io_retiring_datapath_instruction_oct; // @[integer_core.scala 316:10:@8445.4]
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
  dx1_instruction_retiring_stage = _RAND_0[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  x2_instruction_retiring_stage = _RAND_1[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_2 = {1{`RANDOM}};
  dx1_functional_unit = _RAND_2[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_3 = {1{`RANDOM}};
  x2_functional_unit = _RAND_3[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_4 = {1{`RANDOM}};
  dx1_triggered_datapath_instruction_vi = _RAND_4[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_5 = {1{`RANDOM}};
  dx1_triggered_datapath_instruction_op = _RAND_5[5:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_6 = {1{`RANDOM}};
  dx1_triggered_datapath_instruction_st = _RAND_6[5:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_7 = {1{`RANDOM}};
  dx1_triggered_datapath_instruction_si = _RAND_7[8:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_8 = {1{`RANDOM}};
  dx1_triggered_datapath_instruction_dt = _RAND_8[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_9 = {1{`RANDOM}};
  dx1_triggered_datapath_instruction_di = _RAND_9[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_10 = {1{`RANDOM}};
  dx1_triggered_datapath_instruction_oci = _RAND_10[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_11 = {1{`RANDOM}};
  dx1_triggered_datapath_instruction_oct = _RAND_11[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_12 = {1{`RANDOM}};
  dx1_triggered_datapath_instruction_icd = _RAND_12[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_13 = {1{`RANDOM}};
  dx1_triggered_datapath_instruction_immediate = _RAND_13[31:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_14 = {1{`RANDOM}};
  x2_triggered_datapath_instruction_vi = _RAND_14[0:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_15 = {1{`RANDOM}};
  x2_triggered_datapath_instruction_op = _RAND_15[5:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_16 = {1{`RANDOM}};
  x2_triggered_datapath_instruction_dt = _RAND_16[1:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_17 = {1{`RANDOM}};
  x2_triggered_datapath_instruction_di = _RAND_17[2:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_18 = {1{`RANDOM}};
  x2_triggered_datapath_instruction_oci = _RAND_18[3:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_19 = {1{`RANDOM}};
  x2_triggered_datapath_instruction_oct = _RAND_19[1:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (reset) begin
      dx1_instruction_retiring_stage <= 3'h0;
    end else begin
      dx1_instruction_retiring_stage <= integer_issue_unit_io_retiring_stage;
    end
    if (reset) begin
      x2_instruction_retiring_stage <= 3'h0;
    end else begin
      if (reset) begin
        x2_instruction_retiring_stage <= 3'h0;
      end else begin
        if (io_enable) begin
          if (_T_619) begin
            x2_instruction_retiring_stage <= dx1_instruction_retiring_stage;
          end else begin
            x2_instruction_retiring_stage <= 3'h0;
          end
        end
      end
    end
    if (reset) begin
      dx1_functional_unit <= 3'h0;
    end else begin
      dx1_functional_unit <= integer_issue_unit_io_functional_unit;
    end
    if (reset) begin
      x2_functional_unit <= 3'h0;
    end else begin
      if (reset) begin
        x2_functional_unit <= 3'h0;
      end else begin
        if (io_enable) begin
          if (_T_619) begin
            x2_functional_unit <= dx1_functional_unit;
          end else begin
            x2_functional_unit <= 3'h0;
          end
        end
      end
    end
    if (reset) begin
      dx1_triggered_datapath_instruction_vi <= 1'h0;
    end else begin
      if (reset) begin
        dx1_triggered_datapath_instruction_vi <= 1'h0;
      end else begin
        if (io_enable) begin
          if (collision) begin
            dx1_triggered_datapath_instruction_vi <= 1'h0;
          end else begin
            dx1_triggered_datapath_instruction_vi <= triggered_datapath_instruction_vi;
          end
        end
      end
    end
    if (reset) begin
      dx1_triggered_datapath_instruction_op <= 6'h0;
    end else begin
      if (reset) begin
        dx1_triggered_datapath_instruction_op <= 6'h0;
      end else begin
        if (io_enable) begin
          if (collision) begin
            dx1_triggered_datapath_instruction_op <= 6'h0;
          end else begin
            dx1_triggered_datapath_instruction_op <= triggered_datapath_instruction_op;
          end
        end
      end
    end
    if (reset) begin
      dx1_triggered_datapath_instruction_st <= 6'h0;
    end else begin
      if (reset) begin
        dx1_triggered_datapath_instruction_st <= 6'h0;
      end else begin
        if (io_enable) begin
          if (collision) begin
            dx1_triggered_datapath_instruction_st <= 6'h0;
          end else begin
            dx1_triggered_datapath_instruction_st <= triggered_datapath_instruction_st;
          end
        end
      end
    end
    if (reset) begin
      dx1_triggered_datapath_instruction_si <= 9'h0;
    end else begin
      if (reset) begin
        dx1_triggered_datapath_instruction_si <= 9'h0;
      end else begin
        if (io_enable) begin
          if (collision) begin
            dx1_triggered_datapath_instruction_si <= 9'h0;
          end else begin
            dx1_triggered_datapath_instruction_si <= triggered_datapath_instruction_si;
          end
        end
      end
    end
    if (reset) begin
      dx1_triggered_datapath_instruction_dt <= 2'h0;
    end else begin
      if (reset) begin
        dx1_triggered_datapath_instruction_dt <= 2'h0;
      end else begin
        if (io_enable) begin
          if (collision) begin
            dx1_triggered_datapath_instruction_dt <= 2'h0;
          end else begin
            dx1_triggered_datapath_instruction_dt <= triggered_datapath_instruction_dt;
          end
        end
      end
    end
    if (reset) begin
      dx1_triggered_datapath_instruction_di <= 3'h0;
    end else begin
      if (reset) begin
        dx1_triggered_datapath_instruction_di <= 3'h0;
      end else begin
        if (io_enable) begin
          if (collision) begin
            dx1_triggered_datapath_instruction_di <= 3'h0;
          end else begin
            dx1_triggered_datapath_instruction_di <= triggered_datapath_instruction_di;
          end
        end
      end
    end
    if (reset) begin
      dx1_triggered_datapath_instruction_oci <= 4'h0;
    end else begin
      if (reset) begin
        dx1_triggered_datapath_instruction_oci <= 4'h0;
      end else begin
        if (io_enable) begin
          if (collision) begin
            dx1_triggered_datapath_instruction_oci <= 4'h0;
          end else begin
            dx1_triggered_datapath_instruction_oci <= triggered_datapath_instruction_oci;
          end
        end
      end
    end
    if (reset) begin
      dx1_triggered_datapath_instruction_oct <= 2'h0;
    end else begin
      if (reset) begin
        dx1_triggered_datapath_instruction_oct <= 2'h0;
      end else begin
        if (io_enable) begin
          if (collision) begin
            dx1_triggered_datapath_instruction_oct <= 2'h0;
          end else begin
            dx1_triggered_datapath_instruction_oct <= triggered_datapath_instruction_oct;
          end
        end
      end
    end
    if (reset) begin
      dx1_triggered_datapath_instruction_icd <= 4'h0;
    end else begin
      if (reset) begin
        dx1_triggered_datapath_instruction_icd <= 4'h0;
      end else begin
        if (io_enable) begin
          if (collision) begin
            dx1_triggered_datapath_instruction_icd <= 4'h0;
          end else begin
            dx1_triggered_datapath_instruction_icd <= triggered_datapath_instruction_icd;
          end
        end
      end
    end
    if (reset) begin
      dx1_triggered_datapath_instruction_immediate <= 32'h0;
    end else begin
      if (reset) begin
        dx1_triggered_datapath_instruction_immediate <= 32'h0;
      end else begin
        if (io_enable) begin
          if (collision) begin
            dx1_triggered_datapath_instruction_immediate <= 32'h0;
          end else begin
            dx1_triggered_datapath_instruction_immediate <= triggered_datapath_instruction_immediate;
          end
        end
      end
    end
    if (reset) begin
      x2_triggered_datapath_instruction_vi <= 1'h0;
    end else begin
      if (reset) begin
        x2_triggered_datapath_instruction_vi <= 1'h0;
      end else begin
        if (io_enable) begin
          if (_T_619) begin
            x2_triggered_datapath_instruction_vi <= dx1_triggered_datapath_instruction_vi;
          end else begin
            x2_triggered_datapath_instruction_vi <= 1'h0;
          end
        end
      end
    end
    if (reset) begin
      x2_triggered_datapath_instruction_op <= 6'h0;
    end else begin
      if (reset) begin
        x2_triggered_datapath_instruction_op <= 6'h0;
      end else begin
        if (io_enable) begin
          if (_T_619) begin
            x2_triggered_datapath_instruction_op <= dx1_triggered_datapath_instruction_op;
          end else begin
            x2_triggered_datapath_instruction_op <= 6'h0;
          end
        end
      end
    end
    if (reset) begin
      x2_triggered_datapath_instruction_dt <= 2'h0;
    end else begin
      if (reset) begin
        x2_triggered_datapath_instruction_dt <= 2'h0;
      end else begin
        if (io_enable) begin
          if (_T_619) begin
            x2_triggered_datapath_instruction_dt <= dx1_triggered_datapath_instruction_dt;
          end else begin
            x2_triggered_datapath_instruction_dt <= 2'h0;
          end
        end
      end
    end
    if (reset) begin
      x2_triggered_datapath_instruction_di <= 3'h0;
    end else begin
      if (reset) begin
        x2_triggered_datapath_instruction_di <= 3'h0;
      end else begin
        if (io_enable) begin
          if (_T_619) begin
            x2_triggered_datapath_instruction_di <= dx1_triggered_datapath_instruction_di;
          end else begin
            x2_triggered_datapath_instruction_di <= 3'h0;
          end
        end
      end
    end
    if (reset) begin
      x2_triggered_datapath_instruction_oci <= 4'h0;
    end else begin
      if (reset) begin
        x2_triggered_datapath_instruction_oci <= 4'h0;
      end else begin
        if (io_enable) begin
          if (_T_619) begin
            x2_triggered_datapath_instruction_oci <= dx1_triggered_datapath_instruction_oci;
          end else begin
            x2_triggered_datapath_instruction_oci <= 4'h0;
          end
        end
      end
    end
    if (reset) begin
      x2_triggered_datapath_instruction_oct <= 2'h0;
    end else begin
      if (reset) begin
        x2_triggered_datapath_instruction_oct <= 2'h0;
      end else begin
        if (io_enable) begin
          if (_T_619) begin
            x2_triggered_datapath_instruction_oct <= dx1_triggered_datapath_instruction_oct;
          end else begin
            x2_triggered_datapath_instruction_oct <= 2'h0;
          end
        end
      end
    end
  end
endmodule
