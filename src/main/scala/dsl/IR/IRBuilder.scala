// See README.md for license details.

package dsl.IR

import dsl.IR.build._
import dsl.compiler.Env

trait IRBuilder extends Env
  with CgraIRBuild
  with FUIRModuleBuild
  with RouterIRBuild
