-- 2023.12.15
module SY_example where

import ForSyDe.Shallow


-- function to multiply by -1 1000000 times 
processInput :: Int -> Int
processInput s_in = iterate (* (-1)) s_in !! 1000000

-- Netlist
system s_in = s_out where
    s_1 = p_1 s_in
    s_2 = p_2 s_1
    s_3 = p_3 s_2
    s_out = p_4 s_3

-- Processes
p_1 = mapSY processInput 

p_2 = mapSY processInput 

p_3 = mapSY processInput

p_4 = mapSY processInput


-- gives signal s as input to system and prints it
s = signal [1..50]

main = print $ system s