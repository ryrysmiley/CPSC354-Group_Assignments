module Interpreter ( execCBN ) where

-- search for "YOUR CODE" to quickly see where to add your changes

-------------------
-- AbsLambdaNat provides the interface with the grammar
-- and is automatically generated by bnfc
-------------------
import AbsLambdaNat -- defines "Program", "Exp", "EApp", "EAbs", etc
import ErrM
import PrintLambdaNat

import Data.Map ( Map )
import qualified Data.Map as M

-- execCBN is a function from type Program to type Exp, calling evalCBN
-- CBN is short for Call By Name, see the lectures
-- the types Program and Exp are defined in AbsLambdaNat.hs
execCBN :: Program -> Exp
execCBN (Prog e) = evalCBN e
-- evalCBN is the actual interpreter ("eval" for evaluate, "CBN" for call by name)
evalCBN :: Exp -> Exp
-- in lambda calculus everything is an expression, whether input, program or output
-- this interpreter only has one computation rule: the beta-reduction of lambda calculus
-- it uses the substitution function defined in class and also in Haskell below
evalCBN (EApp e1 e2) = case (evalCBN e1) of
    (EAbs i e3) -> evalCBN (subst i e2 e3)
    e3 -> EApp e3 e2
----------------------------------------------------
--- YOUR CODE goes here for extending the interpreter
----------------------------------------------------

evalCBN (EIf e1 e2 e3 e4) = if (evalCBN e1) == (evalCBN e2) then evalCBN e3 else evalCBN e4
evalCBN (ELet i e1 e2) = evalCBN (EApp (EAbs i e2) e1)
evalCBN (ERec i e1 e2) = evalCBN (EApp (EAbs i e2) (EFix (EAbs i e1)))
evalCBN (EFix e) = evalCBN (EApp e (EFix e))
evalCBN (EMinusOne e) = case (evalCBN e) of
  ENat0 -> ENat0
  (ENatS e) -> e
evalCBN ENat0 = ENat0
evalCBN (ENatS e) = ENatS (evalCBN e)
evalCBN x = x

-- fresh generates fresh names for substitutions, can be ignored for now
-- a quick and dirty way of getting fresh names. Rather inefficient for big terms...
fresh_aux :: Exp -> String
fresh_aux (EVar (Id i)) = i ++ "0"
fresh_aux (EApp e1 e2) = fresh_aux e1 ++ fresh_aux e2
fresh_aux (EAbs (Id i) e) = i ++ fresh_aux e
fresh_aux _ = "0"

fresh = Id . fresh_aux -- for Id see AbsLamdaNat.hs

-- subst implements the beta rule
-- (\x.e)e' reduces to subst x e' e
subst :: Id -> Exp -> Exp -> Exp
subst id s (EVar id1) | id == id1 = s
                      | otherwise = EVar id1
subst id s (EApp e1 e2) = EApp (subst id s e1) (subst id s e2)
subst id s (EAbs id1 e1) =
    -- to avoid variable capture, we first substitute id1 with a fresh name inside the body
    -- of the λ-abstraction, obtaining e2.
    -- Only then do we proceed to apply substitution of the original s for id in the body e2.
    let f = fresh (EAbs id1 e1)
        e2 = subst id1 (EVar f) e1 in
        EAbs f (subst id s e2)

----------------------------------------------------------------
--- YOUR CODE goes here if subst needs to be extended as well
----------------------------------------------------------------
subst id s ENat0 = ENat0
subst id s (ENatS e) = ENatS (subst id s e)
subst id s (EIf e1 e2 e3 e4) = EIf (subst id s e1) (subst id s e2) (subst id s e3) (subst id s e4)
subst id s (ELet i e1 e2) = subst id s (EApp (EAbs i e2) e1)
subst id s (ERec i e1 e2) = subst id s (EApp (EAbs i e2) (EFix (EAbs i e1)))
subst id s (EFix e) = EFix (subst id s e)
subst id s (EMinusOne e) = EMinusOne (subst id s e)
