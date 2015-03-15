## Build instructions

    $ make sandbox
    $ make all

## Pipeline structure
The project builds several executables which can be chained together to form a pipeline.
### Parser

    $ cat example/example01.txt | bin/parse-lang

### Todo...

## Language features
### Structures
The input file consists of one or more procedures along with any number of global variable names.

Procedures contain a comma-separated list of *value* variable names and a list of *result* variable names. The keywords `val` and `res` can be omitted in the case of an empty list.

Proc := `begin proc <PName>(val [<Name>], res [<Name>]) in <Stmt> end`

Statements can be one of the following:

Stmt := `(<Stmt>)`  
Stmt := `<Stmt> ; <Stmt>`  
Stmt := `skip`  
Stmt := `if <BoolExpr> then <Stmt> else <Stmt>`  
Stmt := `while <BoolExpr> do <Stmt>`  
Stmt := `<Name> := <IntExpr>`  
Stmt := `call <PName>([<IntExpr>], [<Name>])`

Expressions are defined as follows:

BoolExpr := `(<BoolExpr>)`  
BoolExpr := `true`  
BoolExpr := `false`  
BoolExpr := `not <BoolExpr>`  
BoolExpr := `<BoolExpr> <BoolOp> <BoolExpr>`  
BoolExpr := `<IntExpr> <IntComp> <IntExpr>`

IntExpr := `<#>`  
IntExpr := `<Name>`  
IntExpr := `<IntExpr> <IntOp> <IntExpr>`

BoolOp := `&&`  
BoolOp := `||`

IntComp := `==`  
IntComp := `<`  
IntComp := `<=`  
IntComp := `>`  
IntComp := `>=`

IntOp := `+`  
IntOp := `-`  
IntOp := `*`  
IntOp := `/`  
IntOp := `%`

### Example

    x, y

    begin proc foobar(val z, u, res v) is
      if z < 3 then v := 1
      else (
        call foobar(z - 2, 0, u) ;
        call foobar(z - 1, 0, v) ;
        v := v + u
      ) end ;
      call foobar(x, 0, y)
    end

    begin proc main(res rv) is
      x := 10 ;
      call foobar(3, y, rv)
    end
