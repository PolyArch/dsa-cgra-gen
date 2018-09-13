# Stream Specialization CGRA Generator

As a submodule of [ss-stack](https://github.com/PolyArch/ss-stack), *ss-cgra-gen* use a 
domain-specific language, called *ReAL*:*Re*configurable *A*rchitecture *L*anguage to 
design CGRA quickly. 

In *ss-cgra-gen*, we also contains a some *tcl* files to synthesize 
hardware and get estimated Power and Area result. 

## Getting Started

1. Install [Scala](https://www.scala-lang.org/) and [sbt](https://www.scala-sbt.org/)
2. Make sure you have JDK from Oracle with version 1.8 or above.
3. Put the CGRA description file like "*fileNAME*.rea" in model directory.
4. make sure you have an *IRoutput* directory in ss-cgra-gen

### run ss-cgra-gen from terminal

 please run 
```
sbt "run fileName --target-dir DirectoryYouWantTheVerilogIn"
```

If everything goes well, you will have a "*fileName*.json" as Intermediate Representation in *./IROutput*. The generated
verilog file will be in *DirtoryYouWantTheVerilogIn*

### run ss-cgra-gen from sbt

Please start sbt first
```
sbt
```
Then run ss-cgra-gen
```
run fileName --target-dir DirectoryYouWantTheVerilogIn
```
If everything goes well, you will have a "*fileName*.json" as Intermediate Representation in *./IROutput*. The generated
verilog file will be in *DirtoryYouWantTheVerilogIn*