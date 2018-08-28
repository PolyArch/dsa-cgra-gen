// See README.md for license details.

package dsl.compiler

import dsl.IR.CgraModel
import dsl.compiler.execute._
import dsl.lex.Item


trait execute extends Env
  with ExecClassInstantiate
  with ExecAssign
  with ExecConnection

