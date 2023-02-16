--THIS IS GIVEN BY PROFESSOR, WITHOUT ANY MODIFICATION.

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY adder IS
	GENERIC(
		N : INTEGER := 32);
	PORT(
	   	x1 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		x2 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	   	y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END adder;

ARCHITECTURE dataflow OF adder IS
BEGIN
	y <= x1 + x2;
END dataflow;
