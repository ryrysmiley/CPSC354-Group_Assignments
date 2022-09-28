-- A Virtual Machine (VM) for Arithmetic (specification)
-- Copyright: Alexander Kurz 2022

-----------------------
-- Data types of the VM
-----------------------

-- Natural numbers
data NN = O | S NN
  deriving (Eq,Show) -- for equality and printing

-- Integers
data II = II NN NN
  deriving Show -- for printing (define your own equality below)

-- Positive integers (to avoid dividing by 0)
data PP = I | T PP

-- Rational numbers
data QQ =  QQ II PP

------------------------
-- Arithmetic on the  VM
------------------------

----------------
-- PP Arithmetic
----------------

-- add positive numbers
addP :: PP -> PP -> PP

-- multiply positive numbers
multP :: PP -> PP -> PP

-- convert numbers of type PP to numbers of type NN
nn_pp :: PP -> NN

-- convert numbers of type PP to numbers of type II
ii_pp :: PP -> II

----------------
-- NN Arithmetic
----------------

-- add natural numbers
addN :: NN -> NN -> NN
addN O m = m
addN (S n) m = S (addN n m)

-- multiply natural numbers
multN :: NN -> NN -> NN
multN O m = O
multN (S n) m = addN (multN n m) m

-- division, eg 13 divided by 5 is 2 
divN :: NN -> PP -> NN

-- remainder, eg 13 modulo by 5 is 3
modN :: NN -> PP -> NN

----------------
-- II Arithmetic
----------------

-- Addition: (a-b)+(c-d)=(a+c)-(b+d)
addI :: II -> II -> II

-- Multiplication: (a-b)*(c-d)=(ac+bd)-(ad+bc)
multI :: II -> II -> II

-- Negation: -(a-b)=(b-a)
negI :: II -> II

-- Equality of integers
instance Eq II where
  (II a b) == (II c d) = <insert your code here>

----------------
-- QQ Arithmetic
----------------

-- Addition: (a/b)+(c/d)=(ad+bc)/(bd)
addQ :: QQ -> QQ -> QQ

-- Multiplication: (a/b)*(c/d)=(ac)/(bd)
multQ :: QQ -> QQ -> QQ

-- Equality of fractions
instance Eq QQ where
  (QQ a b) == (QQ c d) = <insert your code here>

----------------
-- Normalisation
----------------

normalizeI :: II -> II

----------------------------------------------------
-- Converting between VM-numbers and Haskell-numbers
----------------------------------------------------

-- Precondition: Inputs are non-negative
nn_int :: Integer -> NN

int_nn :: NN->Integer

ii_int :: Integer -> II

int_ii :: II -> Integer

-- Precondition: Inputs are positive
pp_int :: Integer -> PP

int_pp :: PP->Integer

float_qq :: QQ -> Float

------------------------------
-- Normalisation by Evaluation
------------------------------

nbe :: II -> II

----------
-- Testing
----------

main = do
    print $ int_nn (multN (nn_int 4) (nn_int 3)) -- 12
    -- design your own tests and add them to main 
    -- make sure that all relevant functionality is tested
    -- add expected test results as comments
    -- do not change the names of the functions in the specification, I will use them for testing