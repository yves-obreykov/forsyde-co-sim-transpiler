module SY_parallel_example where

import ForSyDe.Shallow

-- function to multiply by -1 1000000 times 
processInput :: Int -> Int
processInput s_in = iterate (* (-1)) s_in !! 1000000

v1 = vector [1..50]
v2 = vector [1..50]
v3 = vector [1..50]
v4 = vector [1..50]

sv = signal [v1, v2, v3, v4]

system = (zipxSY . mapV (mapSY (processInput)). unzipxSY)

main = print $ system sv
