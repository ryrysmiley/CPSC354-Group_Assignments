
--is_empty check if list is empty
is_empty :: [a] -> Int
is_empty [] = 1
is_empty _ = 0

--fib returns the nth fibonacci number
fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

--length returns the length of a list changed name because of conflict with Prelude
len :: [a] -> Int
len [] = 0
len (x:xs) = 1 + len xs

--even returns if list has even or odd number of elements
is_even :: [a] -> Int
is_even [] = 1
is_even (x:[]) = 0
is_even (x:y:xs) = is_even xs

--append appends two lists (for reverse)
append :: [a] -> [a] -> [a]
append [] ys = ys
append (x:xs) ys = x : append xs ys

--reverse (with append) reverses a list revert because it is already a function
revert :: [a] -> [a]
revert [] = []
revert [x] = [x]
revert (x:xs) = append (revert xs) [x]

--weave takes two lists and weaves them together (ordered)
weave :: Ord a => [a] -> [a] -> [a]
weave [] ys = ys
weave xs [] = xs
weave (x:xs) (y:ys) 
    | x < y = x : weave xs (y:ys)
    | otherwise = y : weave (x:xs) ys

--main to test functions
main = do
    print (is_empty [])
    print (is_empty [1])
    print (fib 6)
    print (len [1,2,3])
    print (is_even [1,2,3,4,5])
    print (is_even [1,2,3,4,5,6])
    print (revert ['a','b','c'])
    print (weave [0,1,4] [2,3,5])
