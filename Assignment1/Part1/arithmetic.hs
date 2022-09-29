-- A Virtual Machine (VM) for Arithmetic (template)
-- Copyright: Alexander Kurz 2022

-----------------------
-- Data types of the VM
-----------------------

-- Natural numbers
data NN = O | S NN
    deriving (Eq,Show) -- for equality and printing

-- Integers
data II = II NN NN
    deriving (Eq,Show) -- for printing

-- Positive integers (to avoid dividing by 0)
data PP = I | T PP
    deriving (Eq,Show)

-- Rational numbers
data QQ =  QQ II PP

------------------------
-- Arithmetic on the  VM
------------------------

----------------
-- PP Arithmetic
----------------
addP :: PP -> PP -> PP

multP :: PP -> PP -> PP

nn_pp :: PP -> NN

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

-- subtract natural numbers THIS NOT REQUIRED
subN :: NN -> NN -> NN
subN O m = O
subN (S n) O = S n
subN (S n) (S m) = subN n m

-- divide natural numbers --NOTE: CHANGE CONDITION AND WILL BE SIMILAR TO %
divN :: NN -> PP -> NN
divN O m = O
divN n 0 = O
divN n m = S (divN (subN n m) m)

-- remainder natural numbers


----------------
-- II Arithmetic
----------------


----------------
-- QQ Arithmetic
----------------



----------------
-- Normalisation
----------------


----------------------------------------------------
-- Converting between VM-numbers and Haskell-numbers
----------------------------------------------------


----------
-- Testing
----------
main = do
    print $ addN (S (S O)) (S O) -- S (S (S O))
    print $ multN (S (S O)) (S (S (S O))) -- S (S (S (S (S (S O)))))
    print $ subN (S (S (S O))) (S (S O)) -- S O
    print $ divN (S (S (S (S (S O))))) (T (T I)) -- 
    
