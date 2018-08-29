
//Comment style : // or /**/
/*
Value
    definition:
        <alias:> name <:encode>
        A64 :   Add64   :   0
        M32x:   Mul32x2 :   1
    parser:
        opt(stringLiteral~":")~stringLiteral~opt(":"~"(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9]|)".r)
    description:
        alias is always optional. it is just for easy to call
        encode is necessary when it will actually be encode in compiler
        name is always necessary

Location
    example:(with quotes)
    "NE":[1,1]    "SE":[1,-1]
    "SW":[-1,-1]  "NW":[-1,1]
    "SW":[1,0]  "W":[-1,0]
    "SW":[0,-1]  "N":[0,1]

    example:(without quotes)
    NE:[1,1]    SE:[1,-1]
    SW:[-1,-1]  NW:[-1,1]
    SW:[1,0]    W:[-1,0]
    SW:[0,-1]   N:[0,1]

Set :

        "{"~> repsep(value, ",|"+whiteSpace) <~"}"

Assignment:
        name = value | Set
*/


ADD = new FU{
  Opcodes = {
    Add_64 Add_32x2 Add_16x4 Sub_64 Sub_32x2 Sub_16x4
  }
  Output_Routing = {
    NE:[1,1]    SE:[1,-1]
    SW:[-1,-1]  NW:[-1,1]
  }
  Mapping = Dedicated //(Single Instruction Only)
  Firing = InputArrival //(Fire on input arrival – no backpressure)
};

ADD_1 = ADD

MUL = new FU {
  Opcodes = {
    Mul_64 Mul_32x2 Mul_16x4
  }
  Output_Routing = {
    NE:[1,1]    SE:[1,-1]
    SW:[-1,-1]  NW:[-1,1]
  }
  Mapping = Dedicated
  Firing = InputArrival
};

SPC = new FU{
  Opcodes = {
    Add_64 Add_32x2 Add_16x4 Sub_64 Sub_32x2 Sub_16x4 Mul_64 Mul_32x2 Mul_16x4
  }
  Output_Routing = {
    NE:[1,1]    SE:[1,-1]
    SW:[-1,-1]  NW:[-1,1]
  }
  Mapping = Shared(8) //8 instructions in instruction buffer
  Firing = TriggeredInstructions //(Triggered-instructions dataflow execution)
  Size = [1,2]
};

SW = new Router{
  //(NE:0 SE:1 SW:2 NW:3 N:4 E:5 S:6 W:7)
  Output_Routing = {
    NE:[1,1]    SE:[1,-1]
    SW:1:[-1,-1]  NW:[-1,1]
    SW:[1,0]    W:[-1,0]
    SW:[0,-1]   N:[0,1]
  }
  Routing = CircuitSwitched
};

/*
Adas4(1) <-db- Adas4;


Adas4(1) = {Adas4(1) <-db- Adas4,
            Adas4(1) <-db- Adas4};


Adas4(1) = {[1,1]:0,[1,-1]:1,
 SW:[-1,-1]:2,[1,-1]:1
 [1,-1]:1 [1,-1]:1};

Output_Routing = {
    NE:[1,1]    SE:[1,-1]
    SW:[-1,-1]  NW:[-1,1]
     };
*/

simple_cgra = new CGRA{

  Router = SW

  // Topology defines FU and I/O locations, and connectivity

  Topology = grid2d(

    "    | Sw1 |     |      |    |   |Sw0|     |   |     |     ",
    "    | MUL |     |ADD_1 |    |MUL|   |ADD  |   |ADD  |     ",
    "    |     |     |      |    |   |   |     |   |     |     ",
    "    | MUL |     |ADD   |    |MUL|   |ADD  |   |ADD  |     ",
    " Sw2|     |     |      |    |   |   |     |   |     |Sw3  ",
    "    | MUL |     |ADD   |    |MUL|   |ADD  |   |ADD  |     ",
    "    |     |     |      |    |   |   |     |   |     |     ",
    "    | MUL |     |ADD   |    |MUL|   |ADD  |   |SPC_1|     ",
    "    |     |     |      |    |   |   |     |   |     |     "

  )

  Inputs = {
    {Sw1    Sw0}
    {ADD_1  Sw2}
  }

  Outputs = {
    {Sw3 SPC_1}
  }

  /*
  Inputs = {
    In0:{I1 --> db_0
      I2 --> db_1}
    In1:{I3 -b-> ADD_1
      I4 --> db_2}
  }

  Outputs = {
    Out0:{d_5 --> I1
      SPC_1 --> I2}
  }
  */
  //describes the logical inputs and outputs that come from scratchpad/memory/etc...
};

Sw1 = SW
Sw0 = SW
Sw2 = SW
Sw3 = SW