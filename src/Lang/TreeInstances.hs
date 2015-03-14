module Lang.TreeInstances where

import Lang.AG
import CCO.Tree                 (Tree (fromTree, toTree))
import qualified CCO.Tree as T  (ATerm (App, String, Integer))
import CCO.Tree.Parser          (parseTree, app, arg)
import Control.Applicative      (Applicative ((<*>)), (<$>), pure)

instance Tree Prog where
  fromTree (Prog name valL resL body) = T.App "Prog" [fromTree name, fromTree valL, fromTree resL, fromTree body]
  toTree = parseTree [ app "Prog" (Prog <$> arg <*> arg <*> arg <*> arg) ]

instance Tree Stmt where
  fromTree (Seq s1 s2)             = T.App "Seq" [fromTree s1, fromTree s2]
  fromTree (Skip)                  = T.App "Skip" []
  fromTree (IfThenElse cond sT sF) = T.App "IfThenElse" [fromTree cond, fromTree sT, fromTree sF]
  fromTree (While cond s)          = T.App "While" [fromTree cond, fromTree s]
  fromTree (Assign x e)            = T.App "Assign" [fromTree x, fromTree e]
  fromTree (Call name valL resL)   = T.App "Call" [fromTree name, fromTree valL, fromTree resL]
  toTree = parseTree [ app "Seq" (Seq <$> arg <*> arg)
                     , app "Skip" (pure Skip)
                     , app "IfThenElse" (IfThenElse <$> arg <*> arg <*> arg)
                     , app "While" (While <$> arg <*> arg)
                     , app "Assign" (Assign <$> arg <*> arg)
                     , app "Call" (Call <$> arg <*> arg <*> arg)
                     ]

instance Tree IntExpr where
  fromTree (Num i)          = T.App "Num" [fromTree i]
  fromTree (Ref x)          = T.App "Ref" [fromTree x]
  fromTree (IntOp op e1 e2) = T.App "IntOp" [fromTree op, fromTree e1, fromTree e2]
  toTree = parseTree [ app "Num" (Num <$> arg)
                     , app "Ref" (Ref <$> arg)
                     , app "IntOp" (IntOp <$> arg <*> arg <*> arg)
                     ]

instance Tree BoolExpr where
  fromTree (Literal b)        = T.App "Literal" [fromTree b]
  fromTree (Not e)            = T.App "Not" [fromTree e]
  fromTree (BoolOp op e1 e2)  = T.App "BoolOp" [fromTree op, fromTree e1, fromTree e2]
  fromTree (IntComp op e1 e2) = T.App "IntComp" [fromTree op, fromTree e1, fromTree e2]
  toTree = parseTree [ app "Literal" (Literal <$> arg)
                     , app "Not" (Not <$> arg)
                     , app "BoolOp" (BoolOp <$> arg <*> arg <*> arg)
                     , app "IntComp" (IntComp <$> arg <*> arg <*> arg)
                     ]

instance Tree IntOp where
  fromTree OpPlus = T.App "+" []
  fromTree OpMin  = T.App "-" []
  fromTree OpMul  = T.App "*" []
  fromTree OpDiv  = T.App "/" []
  fromTree OpMod  = T.App "%" []
  toTree = parseTree [ app "+" $ pure OpPlus
                     , app "-" $ pure OpMin
                     , app "*" $ pure OpMul
                     , app "/" $ pure OpDiv
                     , app "%" $ pure OpMod
                     ]


instance Tree BoolOp where
  fromTree OpAnd = T.App "and" []
  fromTree OpOr  = T.App "or" []
  toTree = parseTree [ app "and" $ pure OpAnd
                     , app "or" $ pure OpOr
                     ]

instance Tree IntComp where
  fromTree OpEq  = T.App "==" []
  fromTree OpLT  = T.App "<" []
  fromTree OpLTE = T.App "<=" []
  fromTree OpGT  = T.App ">" []
  fromTree OpGTE = T.App ">=" []
  toTree = parseTree [ app "==" $ pure OpEq
                     , app "<" $ pure OpLT
                     , app "<=" $ pure OpLTE
                     , app ">" $ pure OpGT
                     , app ">=" $ pure OpGTE
                     ]
