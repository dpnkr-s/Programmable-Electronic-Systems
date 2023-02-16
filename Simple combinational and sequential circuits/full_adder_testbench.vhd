LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY full_adder_testbench IS
	                
END full_adder_testbench;

ARCHITECTURE behavioral OF full_adder_testbench IS

SIGNAL test_a,test_b,test_ci,test_s,test_co: STD_LOGIC := '0';

BEGIN
	U_full_adder: entity work.full_adder(dataflow) PORT MAP(A=>test_a,B=>test_b,Ci=>test_ci,S=>test_s,Co=>test_co);
        test: PROCESS
	BEGIN
		test_a <= '0';
		test_b <= '0';
		test_ci <= '0';
		wait for 200 ns;
		test_a <= '1';
		test_b <= '0';
		test_ci <= '0';
		wait for 200 ns;
		test_a <= '1';
		test_b <= '1';
		test_ci <= '0';
		wait for 200 ns;
		test_a <= '1';
		test_b <= '0';
		test_ci <= '1';
		wait for 200 ns;
		test_a <= '1';
		test_b <= '1';
		test_ci <= '1';
		wait for 200 ns;
		test_a <= '0';
		test_b <= '1';
		test_ci <= '0';
		wait for 200 ns;
		test_a <= '0';
		test_b <= '1';
		test_ci <= '1';
		wait for 200 ns;
		test_a <= '0';
		test_b <= '0';
		test_ci <= '1';
		wait for 200 ns;
		wait;
	END PROCESS;
	
END behavioral;
