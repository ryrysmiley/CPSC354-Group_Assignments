module Interpreter where

import AbsNumbers

eval :: Exp -> Integer
eval (Num n) = n
eval (Neg n) = negate (eval n)
eval (Abs n) = abs (eval n)
eval (Paren n) = (eval n)
eval (Plus n m) = (eval n) + (eval m)
eval (Minus n m) = (eval n) - (eval m)
eval (Times n m) = (eval n) * (eval m)
eval (Divide n m) = (eval n) `div` (eval m)
eval (Mod n m) = (eval n) `mod` (eval m)
eval (Expo n m) = (eval n) ^ (eval m)