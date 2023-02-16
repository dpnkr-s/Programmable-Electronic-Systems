LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY multiplexer IS
        GENERIC(
                N: INTEGER :=8 );
        PORT(   
                A,B,C: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
                S: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
                Y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) );
END multiplexer;

ARCHITECTURE dataflow OF multiplexer IS
BEGIN
        WITH S SELECT
        Y <=A WHEN "00",
            B WHEN "01",
            C WHEN OTHERS;
END dataflow;