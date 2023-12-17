module SDF_System_Model where

import ForSyDe.Shallow
import Control.Parallel

-- system netlist using parallel evaluation
system :: Signal Int -> Signal Int
system s_ip = parEvalSignal s_out
  where
    s_1 = p_1 s_ip
    s_2 = p_2 s_1
    s_3 = p_3 s_2
    s_out = p_4 s_3

-- Evaluate a signal in parallel using Control.Parallel.Strategies
parEvalSignal :: Signal a -> Signal a
parEvalSignal NullS = NullS
parEvalSignal (a:-as) = a `par` (parEvalSignal as) `pseq` (a:-parEvalSignal as)

-- Function to multiply by -1 100000000 times and return the result
processInput :: Int -> Int
processInput in1 = iterate (* (-1)) in1 !! 1000000

-- Process Specification
p_1 = actor11SDF 1 1 f_1
    where f_1 [x] = [processInput x]
p_2 = actor11SDF 1 1 f_2
    where f_2 [x] = [processInput x]
p_3 = actor11SDF 1 1 f_3
    where f_3 [x] = [processInput x]
p_4 = actor11SDF 1 1 f_4
    where f_4 [x] = [processInput x]

s = signal [1..50]

-- gives a signal s as input to the system and prints the output signal
main = print $ system s
