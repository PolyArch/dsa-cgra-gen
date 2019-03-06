;buildInfoPackage: chisel3, version: 3.1.6, scalaVersion: 2.11.12, sbtVersion: 1.1.1, builtAtString: 2018-12-21 23:42:51.273, builtAtMillis: 1545435771273
circuit Multiplexer_Hw : 
  module Multiplexer_Hw : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip 5 : UInt<3>, 4 : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<64>}, flip 3 : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<64>}, flip 2 : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<64>}, flip 1 : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<64>}, flip 0 : {flip ready : UInt<1>, valid : UInt<1>, bits : UInt<64>}}
    
    wire config : UInt<2> @[Multiplexer.scala 84:20]
    config <= io.5 @[Multiplexer.scala 85:10]
    io.4.bits <= UInt<1>("h00") @[Multiplexer.scala 91:13]
    io.4.valid <= UInt<1>("h00") @[Multiplexer.scala 91:28]
    io.0.ready <= UInt<1>("h00") @[Multiplexer.scala 93:53]
    io.1.ready <= UInt<1>("h00") @[Multiplexer.scala 93:53]
    io.2.ready <= UInt<1>("h00") @[Multiplexer.scala 93:53]
    io.3.ready <= UInt<1>("h00") @[Multiplexer.scala 93:53]
    node _T_83 = eq(config, UInt<2>("h02")) @[Multiplexer.scala 105:17]
    when _T_83 : @[Multiplexer.scala 105:30]
      io.4.bits <= io.2.bits @[Multiplexer.scala 106:24]
      io.4.valid <= io.2.valid @[Multiplexer.scala 106:24]
      io.2.ready <= io.4.ready @[Multiplexer.scala 106:24]
      skip @[Multiplexer.scala 105:30]
    node _T_85 = eq(config, UInt<1>("h01")) @[Multiplexer.scala 105:17]
    when _T_85 : @[Multiplexer.scala 105:30]
      io.4.bits <= io.1.bits @[Multiplexer.scala 106:24]
      io.4.valid <= io.1.valid @[Multiplexer.scala 106:24]
      io.1.ready <= io.4.ready @[Multiplexer.scala 106:24]
      skip @[Multiplexer.scala 105:30]
    node _T_87 = eq(config, UInt<2>("h03")) @[Multiplexer.scala 105:17]
    when _T_87 : @[Multiplexer.scala 105:30]
      io.4.bits <= io.3.bits @[Multiplexer.scala 106:24]
      io.4.valid <= io.3.valid @[Multiplexer.scala 106:24]
      io.3.ready <= io.4.ready @[Multiplexer.scala 106:24]
      skip @[Multiplexer.scala 105:30]
    node _T_89 = eq(config, UInt<1>("h00")) @[Multiplexer.scala 105:17]
    when _T_89 : @[Multiplexer.scala 105:30]
      io.4.bits <= io.0.bits @[Multiplexer.scala 106:24]
      io.4.valid <= io.0.valid @[Multiplexer.scala 106:24]
      io.0.ready <= io.4.ready @[Multiplexer.scala 106:24]
      skip @[Multiplexer.scala 105:30]
    
