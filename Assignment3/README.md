## LAMBDA FUN

# Critical Appraisal
Pseudo Code of Merge sort:  
function mergesort( Array ):  
&nbsp;&nbsp;if "length of Array less than or equal to 1"  
&nbsp;&nbsp;&nbsp;&nbsp;return Array  
    
&nbsp;&nbsp;split Array in half  
&nbsp;&nbsp;left_side = store left side of array  
&nbsp;&nbsp;right_side = store tight side of array  
  
&nbsp;&nbsp;left_side = recursively call mergesort function with the left half as argument  
&nbsp;&nbsp;right_side = recursively call mergesort function with the right half as argument  
  
&nbsp;&nbsp;return both halfs as two separate arrays, left_side and right_side  
  
function merge (Left_half, Right_half):  
&nbsp;&nbsp;check both of the first values in the right and left half, and which ever one is the smallest value, pop the value   
&nbsp;&nbsp;from that half and append to a new array and repeat process until both halves no longer contain any values.  

&nbsp;&nbsp;return the new array with the values from both the left and right halves.  
 
## Runtime Errors
* None

# Observations
An observation we found was that when traversing the linked list to insert the element at the correct position, we kept running into errors when trying to print and we realized it was because we weren't returning the actual pointer. 

Another observation that I found interestinf that was also described in The Memory Cycle was the use of creating a memory cell on the stack vs the heap. The stack is temporary memory space that references memory cells on the heap. As described in the Memory Cycle when we do:
```
λ val a = new [] ;;
```
We create a on the stack with a referential address in the memory cell on the heap. Running λ :env in our terminal will provide us with an explanation of our environment. Let us look at another example where we set a to a=10. Let's first allocate a to 10.
```
λ a:=10;;
```
Next, let's run our env command to see our virtual environment.
```
λ :env
```
The result we get back is:
```
Env:
a = <address 0>
Memory:
0 -> 10
```
This means that we have created an item "a" on the stack with an address reference of 0 on our heap. In our larger memory (the heap) we see that address 0 corresponds to our value of 10.
