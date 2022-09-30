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
    deriving Show


------------------------
-- Arithmetic on the  VM
------------------------

----------------
-- PP Arithmetic
----------------
addP :: PP -> PP -> PP
addP I y = T y
addP (T x) y = T (addP x y)

multP :: PP -> PP -> PP
multP I y = y
multP (T x) y = addP y (multP x y)

nn_pp :: PP -> NN
nn_pp I = (S O)
nn_pp (T x) = S (nn_pp x)

ii_pp :: PP -> II
ii_pp I = II (S O) O
ii_pp (T x) = II (S (nn_pp x)) O

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

--- check is the first number is less than the second number
less :: NN -> NN -> Bool
less O m = True
less n O = False
less (S n) (S m) = less n m

-- divide natural numbers --NOTE: CHANGE CONDITION AND WILL BE SIMILAR TO %
divN :: NN -> PP -> NN
divN O m = O
divN (S n) I = S n
divN (n) (m) | less (nn_pp m) n = S (divN (subN n (nn_pp m)) m)
             | otherwise = O
                  
-- remainder natural numbers
modN :: NN -> PP -> NN
modN O m = O
modN (S n) I = O
modN (n) (m) | less (nn_pp m) n = modN (subN n (nn_pp m)) m
             | otherwise = n

----------------
-- II Arithmetic
----------------
-- Addition: (a-b)+(c-d)=(a+c)-(b+d)
addI :: II -> II -> II
addI (II a b) (II c d) = II (addN a c) (addN b d)

-- Multiplication: (a-b)*(c-d)=(ac+bd)-(ad+bc)
multI :: II -> II -> II
multI (II a b) (II c d) = II (addN (multN a c) (multN b d)) (addN (multN a d) (multN b c))

-- Negation:
negI :: II -> II
negI (II a b) = (II b a)

-- Equality of integers
instance Eq II where
  (II a b) == (II c d) = (a == c) && (b == d)

----------------
-- QQ Arithmetic
----------------

-- QQ Addition (a/b)+(c/d)=(ad+bc)/(bd)
addQ :: QQ -> QQ -> QQ
addQ (QQ(a)(b)) (QQ(c)(d)) = QQ (addI (multI a (ii_pp(d))) (multI (ii_pp(b)) (c))) (multP b d)

-- QQ Multiplication: (a/b)*(c/d)=(ac)/(bd)
multQ :: QQ -> QQ -> QQ
multQ (QQ(a)(b)) (QQ(c)(d)) = QQ (multI a c) (multP b d)

-- Equality of fractions
instance Eq QQ where
  (QQ a b) == (QQ c d) = (multI a (ii_pp d)) == (multI c (ii_pp b))

----------------
-- Normalisation
----------------
normalizeI :: II -> II
normalizeI (II n O) = (II n O)
normalizeI (II O m) = (II O m)
normalizeI (II (S n) (S m)) = normalizeI (II n m)


----------------
-- Normalisation
----------------
-- normalizeI :: II -> II
-- normalizeI (II (m O)) = II (m O)
-- normalizeI II (S m) (S n) = II m n

-- normalizeI :: II -> II
-- normalizeI II(m)(O) = II(m)(O)
-- normalizeI (II(S m)(S n)) = II(m)(n)


----------------------------------------------------
-- Converting between VM-numbers and Haskell-numbers
----------------------------------------------------
nn_int :: Integer -> NN
nn_int (0) = O
nn_int (n) = S (nn_int (n-1))

int_nn :: NN -> Integer
int_nn (O) = 0
int_nn(S n) = 1 + int_nn(n)

ii_int :: Integer -> II
ii_int 0 = II O O
ii_int (n) 
    | 0 > n = negI (II (nn_int (negate n)) O)
    | otherwise = II (nn_int n) O

int_ii :: II -> Integer
int_ii (II O O) = 0
int_ii (II (n) m) = int_nn(n) - int_nn(m)

-- Precondition: Inputs are positive
pp_int :: Integer -> PP
pp_int 1 = I
pp_int n = addP I (pp_int (n - 1))

int_pp :: PP -> Integer
int_pp I = 1
int_pp (T n) = 1 + int_pp (n)

float_qq :: QQ -> Float
float_qq (QQ(a)(b)) = fromIntegral(int_ii(a)) / fromIntegral(int_pp(b))

------------------------------
-- Normalisation by Evaluation
------------------------------
nbv :: II -> II



----------
-- Testing
----------
main = do
    print $ ii_int(-1)
    print $ float_qq(addQ (QQ (ii_int 2) (pp_int 4)) (QQ (ii_int 1) (pp_int 2)))
    print $ ii_int(5) == ii_int(-5)
    print $ nbv (II (S (S O)) (S O))

