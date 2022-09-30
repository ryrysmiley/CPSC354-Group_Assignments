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


    

-- modN O m = O
-- modN n I = O
-- modN n m = (modN (subN n (nn_pp m)) m)


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

-- Subtraction:
subtrI :: II -> II -> II
subtrI (II(a)(b))(II(c)(d)) = II(addN(a)(d))(addN(b)(c))

----------------
-- QQ Arithmetic
----------------
-- addQ :: QQ -> QQ -> QQ
-- addP I m = (T m)
-- addP (T n) m =  addP n (T m)

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
int_nn :: NN->Integer
int_nn (O) = 0
int_nn(S n) = 1 + int_nn(n)

int_ii :: II -> Integer
int_ii (II(m)(n)) = int_nn(m) - int_nn(n)

----------
-- Testing
----------
main = do
    -- print $ addN (S (S O)) (S O) -- S (S (S O))
    -- print $ multN (S (S O)) (S (S (S O))) -- S (S (S (S (S (S O)))))
    -- print $ subN (S (S (S O))) (S (S O)) -- S O
    -- print $ addI (II (S (S O)) (S O)) (II (S (S O)) (S O)) -- II (S (S (S (S O)))) (S (S O))
    -- print $ addP (T I) (T (T I)) -- T (T (T I))
    -- print $ multP (T (T I)) (T I) -- T (T (T (T (T (T I)))))
    -- print $ nn_pp (T (T (T I))) -- S (S (S O))
    -- print $ ii_pp (T(T I)) -- II (S (S O)) (S (S (S O)))
    -- print $ divN (S (S (S (S (S O))))) (T (T I)) --　(S O)
    -- print $ modN  (S (S (S (S (S O))))) (T (T I)) -- S (S (S O))
    -- print $ multN (divN (S (S (S (S (S O))))) (T (T I))) (nn_pp (T (T I)))
    print $ divN (S (S (S (S (S (S O)))))) (T (T I))   
    print $ divN (S (S (S (S (S (S (S O))))))) (T (T I))   
    print $ divN (S (S (S (S (S (S (S (S O)))))))) (T (T I))  
    print $ divN (S (S (S (S (S (S (S (S (S O))))))))) (T (T I))  


    print $ divN (S (S O)) (T (T I))     

    print $ modN (S (S O)) (T (T I)) 

    print $ less (S (S (S (S (S (S O))))))  (S (S (S (S (S (S (S O))))))) 

    print $ modN (S (S (S (S (S O))))) (T (T I))

    -- print $ int_ii (addI (II (S (S O)) (S O)) (II (S (S O)) (S O)))
    -- print $ negI (II (S O) O)
