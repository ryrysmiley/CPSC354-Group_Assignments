# CPSC354-Group_Assignments
* Kai Itokazu
* Ryley Jue

# Part 2
## Interesting Points:
1. Giving freedom of design within reason has benefits:
    -Heavy consideration of edge cases
    -Forces one to justify and understand every design decision
    -Encourages researching what others implemented for inspiration and learning
2. Although not many edge cases I found the negative operations interesting in how it does floor division.
3. This assignment forced me to justify my decisions while I still felt like I was just following PEMDAS and previously done interpreters. When I tried to explain what I implemented, it did not feel totally correct to just reference how it functions the same as other calculators. Perhaps that is something to look into.

## Order of Operations Design:
1. Parentheses
2. Exponents, Absolute Value, Negative
3. Modulus, Multiplication, Division
4. Addition, Subtraction

## Reasoning:
The design influence is based on PEMDAS and haskell integer operations. The new operations not explicit put in PEMDAS are Modulus, Absolute Value, and Negative.

Modulus - Same order as multiplication and division. Follows how other languages and calculators would order modulus.
1+2%3 = 3
1*2%3 = 2
1/2%3 = 0

Absolute Value - This operation can be seen as similar to parentheses and in this case it still acts as one. Within the bars of absolute value there will always be an expression that will eventually be converted to positive. Even though it seems odd to place it on the same level as exponents and negative, it properly functions as intended. Negative and Exponent on the outside of an absolute value function will always apply after it finishes because it still acts as a parentheses. The absolute value function also follows other calculators.
ex.
|2-4| = 2
|2-4|^3 = 8
-|2-4| = -2


Negative - The negative sign for an integer works in simple cases and is simple to understand. Exponents properly interact with negatives as it will not apply the negative until after the exponent operation (unless there are parentheses with the negative). There are unexpected interactions with negative numbers and division which I investigated. After investigating haskell integer operations I found that they matched these odd cases. Overall negative works as intended.

-5 = -5
1+2*-3 = -9
-4/10 = 0
(-4)/10 = -1
-4^2 = -16
(-4)^2 = 16

Overall most of the new grammar decisions were based around how haskell handles integer operations. There were few special and unexpected cases to handle. 

## Known Errors:
- Incorrect syntax like multiple operations in a row or incorrect parentheses and bars
- Negative Exponents do not work because these are integer operations