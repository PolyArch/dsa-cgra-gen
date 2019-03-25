SBT_JAVA_OPT=-J-Xss64m -J-Xms64m -J-Xmx512m -J-XX:MaxPermSize=256m

.PHONY: build-sbt
build-sbt:
	sbt ${SBT_JAVA_OPT}  compile
	sbt ${SBT_JAVA_OPT} assembly

.PHONY: clean
clean:
	sbt clean