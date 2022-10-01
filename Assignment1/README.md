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
<u>Natural Numbers Arithmetic - Addition</u>
> 2 + 3

*Function*
```
addN :: NN -> NN -> NN
addN O m = m
addN (S n) m = S (addN n m)
```
*Example*
```
addN (S (S O)) (S (S (S O))) = S (addN (S 0) (S (S (S O))))
                             = S (S (S (addN 0 (S (S (S O))))))
                             = (S (S (S O)))
                             = S (S (S (S (S O))))
                             = 5
```

<u>Natural Numbers Arithmetic - Division (Conversion to Int from NN)</u>
> 3 / 2

*Function*
```
-- Division -- 
divN :: NN -> PP -> NN
divN O m = O
divN (S n) I = S n
divN (n) (m) | less (nn_pp m) n = S (divN (subN n (nn_pp m)) m)
             | otherwise = O
             
-- subtract natural numbers THIS NOT REQUIRED
subN :: NN -> NN -> NN
subN O m = O
subN (S n) O = S n
subN (S n) (S m) = subN n m
             
-- Natural Number to Integer --
int_nn :: NN -> Integer
int_nn (O) = 0
int_nn(S n) = 1 + int_nn(n)

-- Integer to Natural Number -- 
nn_int :: Integer -> NN
nn_int (0) = O
nn_int (n) = S (nn_int (n-1))

-- Integer to Positive Number -- 
pp_int :: Integer -> PP
pp_int 1 = I
pp_int n = addP I (pp_int (n - 1))


```

*Example*
```
int_nn (divN (nn_int 3) (pp_int 2)) 
= int_nn (divN (S (S (S (O)))) (T I)) 
= int_nn (divN (S (S (S (O)))) nn_pp(T I)) | less (T I) (S (S (S (O))) 
    = S (divN (subN (S (S (S (O))) (S (S (O)))) (T I))
        = subN (S (S (O))) (S (O))
            = subN (S (O)) (O)
                = (S (O))
        = S (divN (S (O)) (T I)) | otherwise
            = 0
    = S O
```

<u>Negation of Integers</u>
> -1

*Function*
```
-- Negation:
negI :: II -> II
negI (II a b) = (II b a)
```

*Example*
```
negI (II (nn_int 1) (nn_int 2)
= (II (S O) (S (S O)))
= (II (S (S O)) (S O))
= 1
```

<u>Equality of Fractions</u>
> 1/2 == 2/4

*Function*
```
instance Eq QQ where
  (QQ a b) == (QQ c d) = (multI a (ii_pp d)) == (multI c (ii_pp b))
 
ii_int :: Integer -> II
ii_int 0 = II O O
ii_int (n) 
    | 0 > n = negI (II (nn_int (negate n)) O)
    | otherwise = II (nn_int n) O

pp_int :: Integer -> PP
pp_int 1 = I
pp_int n = addP I (pp_int (n - 1))

```

*Example*
```
(QQ (ii_int 1) (pp_int 2)) == (QQ (ii_int 2) (pp_int 4))
= QQ (II (S O) O) (T I) == QQ (II (S (S O)) O) (T(T(T I)))
= (multI (II (S O) O) (ii_pp (T(T(T I))))) == (multI II (S (S O))) (ii_pp (T I)))
= (multI (II (S O) O) (II (S (S (S (S O)))) O) == (multI (II (S (S O)) O) (II (S (S O)) O)
    = II (addN (multN (S O) (S (S (S (S O))))) (multN (S (S O)) (S (S O)))) (addN (multN (S O) (S (S O))) (multN (S (S (S (S O)))) (S (S O))))
    = II (addN (S (S (S (S O)))) (S (S (S (S O))))) (addN (S (S O)) (S (S (S (S (S (S O)))))))
    = II (S (S (S (S (S (S (S (S O)))))))) (S (S (S (S (S (S (S (S O))))))))
    = O
= True

```

<u>Conversion from Natural Number to Integer</u>
> (S (S O))

*Function*
```
int_nn :: NN -> Integer
int_nn (O) = 0
int_nn(S n) = 1 + int_nn(n)
```

*Example*
```
int_nn (S (S O))
= S ((S O))
= 1 + int_nn(S O)
= 1 + 1 (int_nn(O))
= 1 + 1 + 0
= 2
```

# Part 2
## Interesting Points:
1. Giving freedom of design within reason has benefits:
    <br/>
    -Heavy consideration of edge cases
    <br/>
    -Forces one to justify and understand every design decision
    <br/>
    -Encourages researching what others implemented for inspiration and learning
2. Although not many edge cases I found the negative operations interesting in how it does floor division.
3. This assignment forced me to justify my decisions while I still felt like I was just following PEMDAS and previously done interpreters. When I tried to explain what I implemented, it did not feel totally correct to just reference how it functions the same as other calculators. Perhaps that is something to look into.

## Order of Operations Design:
1. Parentheses
2. Exponents, Absolute Value, Negative
3. Modulus, Multiplication, Division
4. Addition, Subtraction

## Reasoning:
The design influence is based on PEMDAS and haskell integer operations. The new operations not explicit put in PEMDAS are Modulus, Absolute Value, and Negative. Parentheses will also be explained to specify its functionality.

### Modulus
Same order as multiplication and division. Follows how other languages and calculators would order modulus.
<br/>
1+2%3 = 3<br/>
1*2%3 = 2<br/>
1/2%3 = 0<br/>

### Absolute Value
This operation can be seen as similar to parentheses and in this case it still acts as one. Within the bars of absolute value there will always be an expression that will eventually be converted to positive. Even though it seems odd to place it on the same level as exponents and negative, it properly functions as intended. Negative and Exponent on the outside of an absolute value function will always apply after it finishes because it still acts as a parentheses. The absolute value function also follows other calculators.
<br/>
|2-4| = 2<br/>
|2-4|^3 = 8<br/>
-|2-4| = -2<br/>


### Negative
The negative sign for an integer works in simple cases and is simple to understand. Exponents properly interact with negatives as it will not apply the negative until after the exponent operation (unless there are parentheses with the negative). There are unexpected interactions with negative numbers and division which I investigated. After investigating haskell integer operations I found that they matched these odd cases. Overall negative works as intended.
<br/>
-5 = -5<br/>
1+2*-3 = -9<br/>
-4/10 = 0<br/>
(-4)/10 = -1<br/>
-4^2 = -16<br/>
(-4)^2 = 16<br/>

### Parentheses
These are handled properly. In the details of the assignment specific examples were described to reference. Parentheses only cause a different result when they are overriding the order of operations. In this calculator it does output correctly for parentheses overriding operations. Some examples found in negative as well.
<br/>
Cases that don't need parentheses<br/>
1+2*3 = 1+(2*3) <br/>
2^3+4 = (2^3)+4 <br/>
2^3/4^5 = (2^3)/(4^5) <br/> 

Cases that parentheses have an impact<br/>
1+2*3 = 7<br/>
(1+2)*3 = 9<br/>
4+4^2 = 20<br/>
(4+4)^2 = 64<br/>

<br/>
Overall most of the new grammar decisions were based around how haskell handles integer operations. There were few special and unexpected cases to handle. 

## Known Errors:
- Incorrect syntax like multiple operations in a row or incorrect parentheses and bars
- Negative Exponents do not work because these are integer operations