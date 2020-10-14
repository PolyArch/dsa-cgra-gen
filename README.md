# Stream Specialization CGRA Generator

As a submodule of [ss-stack](https://github.com/PolyArch/ss-stack), *ss-cgra-gen* use *Yaml* to describe CGRA, see example IR in *sample-IR* directory.

In *ss-cgra-gen*, we also contains a some *tcl* files to synthesize 
hardware and get estimated Power and Area result. 

## Getting Started

1. Install [Scala](https://www.scala-lang.org/) and [sbt](https://www.scala-sbt.org/)
2. Make sure you have JDK from Oracle with version 1.8 or above.
3. Put the CGRA description file like "*fileNAME*.yaml" in model directory.
4. make sure you have an *IR* directory in ss-cgra-gen

### run ss-cgra-gen from terminal

 please run 
```
sbt "runMain CgraGen YamlFile VerilogOutputFolder"
```
For example:
```$xslt
sbt "runMain CgraGen cgra_3x3_new.yaml verilog-output"
```

If everything goes well, you will have a "*fileName*.xml" as *Hardware Configuration* in *IR*. The generated
verilog file will be in *VerilogOutputFolder*

### run ss-cgra-gen from sbt

Please start sbt first
```
sbt
```
Then run ss-cgra-gen
```
runMain CgraGen YamlFile VerilogOutputFolder
```