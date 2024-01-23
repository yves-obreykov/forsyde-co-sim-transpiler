-- 2023.12.15
module SY_example where

import ForSyDe.Shallow
import Control.Parallel

-- function to multiply by -1 1000000 times 
processInput :: Int -> Int
processInput s_in = iterate (* (-1)) s_in !! 1000000

-- Netlist
system s_in = s_out where
    s_out = p_4 `par` (p_3 `par` (p_2 `par` (p_1 s_in)))

-- Processes
p_1 = mapSY processInput 

p_2 = mapSY processInput 

p_3 = mapSY processInput

p_4 = mapSY processInput


-- gives signal s as input to system and prints it
s = signal [1..50]

main = print $ system s
