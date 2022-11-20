## Group Members
* Ryley Jue
* Kai Itokazu
* Cole Matsueda


# Critical Appraisal
The purpose of the assignment was to create a basic programming language, and create a syntax that parses the written code into abstract syntax trees. As a result, we used bnfc in order to parse our programming language grammer, filling out all the required caveats of our program. We also used Haskell to build an interpretter. Finally, we used to grammer we build to define functions in our programming language, and then used the interpretter to run the functions. When building out our functions, we took into account for certain edge cases when building. When given an empty list, our Fibinachi Sequence function will not handle the list as for our head and tail functions as those functions need values to inorder to process while our other functions handle empty lists without errors. Ultimately, we were aiming to create the simplest interpretter. The project was split into three parts - Part 0, Part 1, and Part 2. FIb, head and tail dont work when given an empty list.

## Personal Observations
There were many interesting observations as we were working through the project. One thing that we noticed is the importance of consistency across code. In the past, its easy to overcomplicating the interpreter when in reality, we should have been referencing the grammar for a better understadning as well as working through the syntax and computation before going to code. Although the consistency did not correlate completely for each case such as _ELE grammar_ and _evalCBN ELE_, there were still aspects that did and were important to note. 

Another interesting note is the similiarities and ease of translating from the _LambdaCalulus_ functions to the _Haskell_ functions. The basis of the functions and method behind them were the same with slightly differing execution in transcribing. Most notably, lambda calculus required the exact grammar in which we (the provided grammar for the class) had written such as the if equals then else statement whereas for haskell the == and = operators were able to compile. These little things were important to keep in mind. 



> **For example, #:# does not parse, but (#):# does. Why? Does that mean that it would make sense to change the grammar?**

To answer this question, we found that the use of parentheses made such a massive difference that it does not typically make in other more concrete programming languages. This example accurately illustrates how parantheses denotes association in Haskell. Lazy evaluation is a method to evaluate a Haskell program, and it means that expressions are not evaluated when they are bound to variables, but their evaluation is deferred until their results are needed by other computations. In consequence, arguments are not evaluated before they are passed to a function, but only when their values are actually used. As a reuslt, if no delimiters are specified, there is a specific syntax that our language will falls back onto. However, parentheses indicate a specified grouping that our language will follow. 

In many computer programming languages, parentheses have a special purpose. For example, they are frequently used to enclose arguments to functions and methods. 
```
// PYTHON EXAMPLE 
def echo(x):
    return x
```
In this example, we pass x is a parameter in a function. This definition of the function does not depend on whether or not x is in parentheses - the python interpretter will treat "x" and "(x)" as the same. The difference is that the language we constructed is abstracted to the point where the # in parantheses is a completely different data type. 

The example given (#:#) is a union between 2 sets, which is the same as {#} U {#}. We have {#} defined as a list and also is implied as the element after which no elements can be added, which is why it is unable to be parsed. The thing about the other example ((#):#) is that (#) and # is interpretted differently. Due to the lack of delimters and also the way we defined a list, (#) is defined s a list containing only the element #. In other words, (#):# is interpretteed as {{#}}U{#}. As a result, the union of these two sets is valid and can be parsed


## Discussion
_ANSWER THESE_

**Explain what changes where made in LambdaNat4 in order to accommodate multiple test cases (separated by ;;) in the same file.**

Now, a Prog would be able to be a list of expressions separated by ;;/ This allows a file to contain seberal expressions. The programming language, rather than taking a single test case, it takes a list of evaulations which is why we needed to make the changes.

**Reflect on the differences between LambdaNat5 and the Calculator. In LambdaNat5, why can't we implement arithmetic using the simple**
```evalCBN (EPlus e1 e2) = (evalCBN e1) + (evalCBN e2)```
__similar to what we have done in the calculator? Are +,-,* implemented using call by name or call by value? What could be a reason for this choice?__

While there are positives to having a programming language this open ended, rules are important to make communication clear. Adding some limitations to how flexible we can with our new programming language allows us a new level of precision oging forward. For example, Haskell has specified that something like evalCBN x1 x2 is the same thing as (evalCBN x1 x2) is the same thing as evalCBN (x1) (x2). By adding more specifications for the ways in which we want our language to be delomoted and adding some low level syntax clarification, we can make our program go a long way. Haskell is more strongly typed than our language so it only accepts Haskell integers which have specific properties while our language isn’t strongly typed and it will still try and parse like a+b and not give an error so we have to add more checks.


**Reflect on the differences between LambdaNat5 and Haskell. In your experience from this assignment, how does writing code in LambdaNat5 and Haskell compare? How far did we come in implementing a functional programming language? What is missing? What can you say about how one should go about extending LambdaNat5 to a more powerful functional language (such as Haskell)?**


**Did you notice that weave satisfies the invariant "the output-list is sorted if the input-lists are sorted"? Can you use it to prove the correctness of sort (that is, that sort actually does sort)?**
