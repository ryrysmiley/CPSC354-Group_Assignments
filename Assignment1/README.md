
## Overview
Our inital thought in this porject was that the logic behind each of the Arithmetic functions from a Discrete Mathematics point of view would be our best bet. As we continued onto the calculator portion, we found that our Discrete Math Background further aided us in determining what priority each function would get, and furthermore how to organize our functions.

## Part 1
We were able to get all of the requirements in the arithmetic section working. We defined all of the functions recurssively, and many of them relied on each other. We first started with addition and then moved to arithmetic functions using natural numbers. For example, our multiplication function recurssively calls the addition function. The biggest challenge was division function. The premise of our division function was that we would do:
> 1 + (n - m) / m

However one thing that we needed to take into account was if the number was not evenly divisible. Because we use substraction as a recurssive call, we wanted the recurssive call to stop when the denominator was smaller than then numerator. For example, 7 / 3 should yield 2. Because of this, we had to create a function that checked two numbers to see which number was bigger/smaller.
```haskell
divN :: NN -> PP -> NN
divN O m = O
divN (S n) I = S n
divN (n) (m) | less (nn_pp m) n = S (divN (subN n (nn_pp m)) m)
             | otherwise = O
```
Overall, we were able to learn a ton of how to utilize recurssion when making these functions. It made me realize how we can make use of other functions  to perform specific actions, and it makes me wonder how functional prorgramming would work on a larger scale that isn't just arithmetic. This also made me realize the importance of having good/correct foundation functions - as there were many times that an error wasn't necessarily caused by the function itself, but the function it was referring to. 
___

**Examples:** \
Natural Numbers Arithmetic - Addition 
```
addN :: NN -> NN -> NN
addN O m = m
addN (S n) m = S (addN n m)
```

## Part 2
