module SDF_System_Model where

import ForSyDe.Shallow

-- System Netlist
system s_in = s_out where
    s_1 = p_1 s_in s_6_delayed
    (s_2, s_3) = p_2 s_1
    s_6 = p_3 s_3 s_5
    (s_out, s_4) = p_4 s_2
    s_5 = p_5 s_4
    s_6_delayed = delaySDF [0,0] s_6

-- Process Specification
p_1 = actor21SDF (2,1) 1 f_1
    where f_1 [x1,x2] [y] = [x1+x2+y]
p_2 = actor12SDF 1 (1,1) f_2
    where f_2 [x] = ([x],[x+1])
p_3 = actor21SDF (2,2) 2 f_3
    where f_3 [x1,x2] [y1,y2] = [x1+x2,y1+y2]
p_4 = actor12SDF 1 (3,1) f_4
    where f_4 [x] = ([x,x+1,x+2],[x])
p_5 = actor11SDF 1 1 f_5
    where f_5 [x] = [x+1]

s = signal [1..10]

--main = system s

-- main = forM_ [0..45] $ \s ->
--             system s

-- gives a signal s as input to the system and prints the output signal
main = print $ system s
