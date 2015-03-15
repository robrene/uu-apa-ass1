module Lang.Lang (
    Prog (..)
  , Proc (..), ProcL
  , Name
  , Stmt (..)
  , IntExpr (..), IntExprL
  , BoolExpr (..), BoolExprL
  , IntOp (..)
  , BoolOp (..)
  , IntComp (..)
) where

import Lang.AG
import Lang.TreeInstances
