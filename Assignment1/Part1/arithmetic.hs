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
  deriving Show -- for printing

-- Positive integers (to avoid dividing by 0)
data PP = I | T PP
  deriving Show

-- Rational numbers
data QQ =  QQ II PP


------------------------
-- Arithmetic on the  VM
------------------------

----------------
-- PP Arithmetic
----------------
addP :: PP -> PP -> PP
addP I y = y
addP (T x) y = T (addP x y)

multP :: PP -> PP -> PP
multP I y = I
multP (T x) y = addP y (multP x y)


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

-- subtract natural numbers
subN :: NN -> NN -> NN
subN O m = O
subN (S n) O = S n
subN (S n) (S m) = subN n m

-- divide natural numbers
divN :: NN -> NN -> NN
divN O m = O
divN n O = O
divN n m = S (divN (subN n m) m)

----------------
-- II Arithmetic
----------------
addI :: II -> II -> II
addI (II a b) (II c d) = II (addN a c) (addN b d)

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
    print $ divN (S (S (S (S (S (S O)))))) (S (S O)) -- S (S (S O))
    print $ addI (II (S (S O)) (S O)) (II (S (S O)) (S O)) -- II (S (S (S (S O)))) (S (S O))
    print $ addP (T (T I)) (T I) -- T (T (T I))
    print $ multP (T (T (T I))) (T (T (T I))) -- T (T (T (T (T (T I)))))
