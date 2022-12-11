## LAMBDA FUN

# Critical Appraisal
Pseudo Code of Merge sort:\
function mergesort( Array ):\
&nbsp;&nbsp;if "length of Array less than or equal to 1"\
&nbsp;&nbsp;&nbsp;&nbsp;return Array\
    
&nbsp;&nbsp;split Array in half\
&nbsp;&nbsp;left_side = store left side of array
&nbsp;&nbsp;right_side = store tight side of array
  
&nbsp;&nbsp;left_side = recursively call mergesort function with the left half as argument \ 
&nbsp;&nbsp;right_side = recursively call mergesort function with the right half as argument 
  
&nbsp;&nbsp;return both halfs as two separate arrays, left_side and right_side
  
function merge (Left_half, Right_half):
&nbsp;&nbsp;check both of the first values in the right and left half, and which ever one is the smallest value, pop the value \ 
&nbsp;&nbsp;from that half and append to a new array and repeat process until both halves no longer contain any values. 

&nbsp;&nbsp;return the new array with the values from both the left and right halves. \
 
## Runtime Errors
* None

# Observations

