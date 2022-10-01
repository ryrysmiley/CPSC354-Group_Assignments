# CPSC354-Group_Assignments
* Kai Itokazu
* Ryley Jue

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
The design influence is based on PEMDAS and haskell integer operations. The new operations not explicit put in PEMDAS are Modulus, Absolute Value, and Negative.

Modulus - Same order as multiplication and division. Follows how other languages and calculators would order modulus.
<br/>
1+2%3 = 3<br/>
1*2%3 = 2<br/>
1/2%3 = 0<br/>

Absolute Value - This operation can be seen as similar to parentheses and in this case it still acts as one. Within the bars of absolute value there will always be an expression that will eventually be converted to positive. Even though it seems odd to place it on the same level as exponents and negative, it properly functions as intended. Negative and Exponent on the outside of an absolute value function will always apply after it finishes because it still acts as a parentheses. The absolute value function also follows other calculators.
<br/>
|2-4| = 2<br/>
|2-4|^3 = 8<br/>
-|2-4| = -2<br/>


Negative - The negative sign for an integer works in simple cases and is simple to understand. Exponents properly interact with negatives as it will not apply the negative until after the exponent operation (unless there are parentheses with the negative). There are unexpected interactions with negative numbers and division which I investigated. After investigating haskell integer operations I found that they matched these odd cases. Overall negative works as intended.
<br/>
-5 = -5<br/>
1+2*-3 = -9<br/>
-4/10 = 0<br/>
(-4)/10 = -1<br/>
-4^2 = -16<br/>
(-4)^2 = 16<br/>

Parentheses - These are handled properly. In the details of the assignment specific examples were described to reference. Parentheses only cause a different result when they are overriding the order of operations. In this calculator it does output correctly for parentheses overriding operations. Some examples found in negative as well.
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