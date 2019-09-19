module Interpreter ( execCBN ) where

import AbsLambdaNat
import ErrM
import PrintLambdaNat

import Data.Map ( Map )
import qualified Data.Map as M


execCBN :: Program -> Exp
execCBN (Prog e) = evalCBN e


evalCBN :: Exp -> Exp
evalCBN (EApp e1 e2) = case (evalCBN e1) of
    (EAbs i e3) -> evalCBN (subst i e2 e3)
    e3 -> EApp e3 e2
evalCBN x = x


-- A quick and dirty way of getting fresh names. Rather inefficient for big terms...
fresh_ :: Exp -> String
fresh_ (EVar (Id i)) = i ++ "0"
fresh_ (EApp e1 e2) = fresh_ e1 ++ fresh_ e2
fresh_ (EAbs (Id i) e) = i ++ fresh_ e
--fresh_ _ = "0"

fresh = Id . fresh_

subst :: Id -> Exp -> Exp -> Exp
subst id s (EVar id1) | id == id1 = s
                      | otherwise = EVar id1
subst id s (EApp e1 e2) = EApp (subst id s e1) (subst id s e2)
subst id s (EAbs id1 e1) = 
    -- to avoid variable capture, we first substitute id1 with a fresh name inside the body
    -- of the λ-abstraction, obtaining e2. 
    -- Only then do we proceed to apply substitution of the original s for id in the 
    -- body e2.
    let f = fresh (EAbs id1 e1)
        e2 = subst id1 (EVar f) e1 in 
        EAbs f (subst id s e2)

