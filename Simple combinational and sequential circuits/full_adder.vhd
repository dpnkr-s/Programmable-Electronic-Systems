LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY full_adder IS
        PORT(   A,B,Ci : IN STD_LOGIC;
                S,Co : OUT STD_LOGIC );
                
END full_adder;

ARCHITECTURE dataflow OF full_adder IS

BEGIN
        S <= A XOR B XOR Ci;
        Co <= (A AND B) OR (Ci AND (A XOR B));
END dataflow;