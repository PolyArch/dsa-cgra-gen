#!/bin/bash

BASEDIR=$(dirname "$0")
echo "Start Cgra Generator"
java -jar $BASEDIR/../target/scala-2.12/ss-cgra-gen-assembly-0.0.1.jar $1 $2
