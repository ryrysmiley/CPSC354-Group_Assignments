## LAMBDA FUN

##Critical Appraisal
*Pseudo Code of Merge sort:
function mergesort( Array ):
  if "length of Array less than or equal to 1"
    return Array
    
  split Array in half
  left_side = store left side of array
  right_side = store tight side of array
  
  left_side = recursively call mergesort function with the left half as argument 
  right_side = recursively call mergesort function with the right half as argument 
  
  return both halfs as two separate arrays, left_side and right_side
  
function merge (Left_half, Right_half):
  check both of the first values in the right and left half, and which ever one is the smallest value, pop the value 
  from that half and append to a new array and repeat process until both halves no longer contain any values. 
  
  return the new array with the values from both the left and right halves.
