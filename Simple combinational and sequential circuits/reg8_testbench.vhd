LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg8_testbench IS	                
END reg8_testbench;

ARCHITECTURE behavioral OF reg8_testbench IS

SIGNAL test_d: STD_LOGIC_VECTOR(7 DOWNTO 0) :="00000000";
SIGNAL test_reset,test_clock: STD_LOGIC;
SIGNAL test_q: STD_LOGIC_VECTOR(7 DOWNTO 0) :="00000000";
CONSTANT n_case: integer := 5;

BEGIN
	U_reg8: entity work.reg8 (behavioral) PORT MAP(D=>test_d,Reset=>test_reset,Clock=>test_clock,Q=>test_q);

	test: PROCESS
	BEGIN
		test_d <="10101010";
		test_reset <='0';
		wait for 225 ns;
		test_d <="11110000";
		wait for 200 ns;
		test_reset <='1';
		wait for 200 ns;
		test_d <="10101010";
		wait for 200 ns;
		test_reset <='0';
		wait for 200 ns;
		wait;
	END PROCESS;
	
	clock: PROCESS
	BEGIN
		for i in 0 to n_case-1 loop
			test_clock <='1';
			wait for 50 ns;
			test_clock <='0';
			wait for 50 ns;
			test_clock <='1';
			wait for 50 ns;
			test_clock <='0';
			wait for 50 ns;
		end loop;
		wait;
	END PROCESS;
END behavioral;
