# This is a deprecated repo of implementation of CGRA generator, most of work are done > 2 years ago. The lastest version will be released within two months.

# Stream Specialization CGRA Generator

As a submodule of [dsa-framework](https://github.com/PolyArch/dsa-framework), *dsa-cgra-gen* use *JSON* to describe CGRA, see example IR in *IR* directory.

## Getting Started

1. Install [Scala](https://www.scala-lang.org/) and [sbt](https://www.scala-sbt.org/)
2. Make sure you have JDK from Oracle with version 1.8 or above.

## Generate IR

Please add `<ssfabric>.printIR(<your_cgra_name>)` at the end of your CGRA description file.

### run ss-cgra-gen from terminal

 please run 
```
sbt "runMain <your_cgra_package>.<ssfabric>"
```
For example:
```
sbt "runMain real.micro_demo"
```

### run ss-cgra-gen from sbt

Please start sbt first
```
sbt
```
Then run ss-cgra-gen
```
runMain <your_cgra_package>.<ssfabric>
```

## Generate RTL (Verilog via Chisel)

### run ss-cgra-gen from terminal

 please run 
```
sbt "runMain cgra.driver.generator <your_cgra.json>"
```
For example:
```
sbt "runMain cgra.driver.generator <your_cgra.json>"
```

### run ss-cgra-gen from sbt

Please start sbt first
```
sbt
```
Then run ss-cgra-gen
```
runMain cgra.driver.generator <your_cgra.json>
```
