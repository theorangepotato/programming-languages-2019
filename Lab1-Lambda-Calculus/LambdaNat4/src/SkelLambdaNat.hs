module SkelLambdaNat where

-- Haskell module generated by the BNF converter

import AbsLambdaNat
import ErrM
type Result = Err String

failure :: Show a => a -> Result
failure x = Bad $ "Undefined case: " ++ show x

transId :: Id -> Result
transId x = case x of
  Id string -> failure x
transProgram :: Program -> Result
transProgram x = case x of
  Prog exp -> failure x
transExp :: Exp -> Result
transExp x = case x of
  EAbs id exp -> failure x
  EIf exp1 exp2 exp3 exp4 -> failure x
  ELet id exp1 exp2 -> failure x
  ERec id exp1 exp2 -> failure x
  EFix exp -> failure x
  EMinusOne exp -> failure x
  EApp exp1 exp2 -> failure x
  ENat0 -> failure x
  ENatS exp -> failure x
  EVar id -> failure x

