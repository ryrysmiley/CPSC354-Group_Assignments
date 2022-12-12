## LAMBDA FUN

# Critical Appraisal
### Pseudo Code of Insertion sort:

1. Iterate over the elements of the array, starting at the second element (index 1).
2. For each element, save it as the "key" element.
3. Initialize a "j" variable to the index of the previous element (i - 1).
4. While "j" is greater than or equal to 0 and the "j"th element is greater than the key:
      Move the "j"th element to the next position (j + 1).
      Decrement "j" by 1.
5. Insert the key element into the correct position (j + 1).

This algorithm works by iterating over the elements of the array, and for each element, inserting it into its correct position in the sorted subarray to the left of the element. This is done by shifting elements to the right as needed to make space for the element to be inserted. This process continues until all elements have been inserted into the correct position in the sorted subarray.
#### Memory Explanation
Given the list [4,3,2,1]
a = <address 0>
b = <address 1>
c = <address 2>
d = <address 3>
a -> 4
b -> 3
c -> 2
d -> 1

starting at address b
compare number at address a and address b and because 3 < 4
a -> 3
b -> 4
result list [3,4,2,1]

now address c
compare number at address b and address c and because 2 < 4
b -> 2
c -> 4
compare number at address a and address b and because 2 < 3
a -> 2
b -> 3
result list [2,3,4,1]

now address d
compare number at address c and address d and because 1 < 4
c -> 1
d -> 4
compare number at address b and address c and because 1 < 3
b -> 1
c -> 3
compare number at address a and address b and because 1 < 2
a -> 1
b -> 2
result list [1,2,3,4]

Note that if the comparisons made were greater than instead of less than then the algorithm would have moved to the next address and stopped switching.

### Pseudo Code of Merge sort:  
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

Insertion sort works by iterating over the elements of the list, and for each element, inserting it into its correct position in the sorted subarray to the left of the element.
This is done by shifting elements to the right as needed to make space for the element to be inserted, and the process continues until all elements have been inserted into the correct position in the sorted subarray.

## Runtime Errors
* None

## Observations
An observation we found was that when traversing the linked list to insert the element at the correct position, we kept running into errors when trying to print and we realized it was because we weren't returning the actual pointer. Another thing interesting was that when we were trying to print the list, we kept getting an error that said "unbound value". We realized that we were trying to print the pointer to the list, but we needed to print the actual list. This was a problem with our insert and sort function, the functions returned the list themselves but not the address to them. In the beginning, our insert function was:
```
let rec insert (x, l) = 
  match l with
  | [] -> [x]
  | h::t -> if x < h then x::l else h::(insert (x, t))
```
Furthermore, when debugging I realized that you can only change the content of pointers/addresses and cannot change the addresses themselves. I realized our insert function initially did not work since if you want to insert 7 between 2 and 1 in 2->1->nil the following should work. However, it did not work because we were trying to change the address of the pointer, which is not possible. We had to change the content of the pointer instead. 
```
λ val a = new [2, new [1, nil]] ;;
λ val b = new [7, a] ;;
```
The result we get back is:
```
val a = <address 0>
val b = <address 1>
Memory:
0 -> [2, <address 2>]
1 -> [7, <address 0>]
2 -> [1, nil]
```
This means that we have created an item "a" on the stack with an address reference of 0 on our heap. In our larger memory (the heap) we see that address 0 corresponds to our value of 10. We realized that we needed to return the pointer to the list, so we changed it to:
```
rec insert = \n. \list.
    case !list of {
        "NULL" -> cons n nil,
        [e, a'] ->
            case n <= e of {
                true -> cons n list,
                _ -> cons e (insert n a')
            }
    } ;;
```
We also had a problem with our sort function. The beginning of our sort function was:
```
let rec sort l = 
  match l with
  | [] -> []
  | h::t -> insert (h, sort t)
```
We realized that we needed to return the pointer to the list, so we changed it to:
```
rec sort = \list.
    case !list of {
        "NULL" -> nil,
        [e, a'] -> insert e (sort a')
    } ;;
```
Another observation that I found interesting that was also described in The Memory Cycle was the use of creating a memory cell on the stack vs the heap. The stack is temporary memory space that references memory cells on the heap. As described in the Memory Cycle when we do:
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

