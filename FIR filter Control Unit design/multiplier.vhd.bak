LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_signed.all;

ENTITY multiplier IS
  GENERIC (
    N : integer := 16);
  PORT(
	   	x1 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		x2 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	   	y : OUT STD_LOGIC_VECTOR(2*N-1 DOWNTO 0));
END multiplier;

ARCHITECTURE dataflow OF multiplier IS
BEGIN
	y <= x1 * x2;
END dataflow;
