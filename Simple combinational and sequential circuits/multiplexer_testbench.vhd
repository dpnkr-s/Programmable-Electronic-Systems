LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY multiplexer_testbench IS	                
END multiplexer_testbench;

ARCHITECTURE behavioral OF multiplexer_testbench IS

SIGNAL test_a,test_b,test_c: STD_LOGIC_VECTOR(7 DOWNTO 0) :="00000000";
SIGNAL test_s: STD_LOGIC_VECTOR(1 DOWNTO 0) :="00";
SIGNAL test_y: STD_LOGIC_VECTOR(7 DOWNTO 0) :="00000000";
      
BEGIN
	U_multiplexer: entity work.multiplexer (dataflow) PORT MAP(A=>test_a,B=>test_b,C=>test_c,S=>test_s, Y=>test_y);
    
    test: PROCESS
	BEGIN
	     	test_a <="00001111";
		test_b <="11110000";
		test_c <="01010101";
		test_s <="00";
		wait for 200 ns;
		test_a <="00001111";
		test_b <="11110000";
		test_c <="01010101";
		test_s <="01";
		wait for 200 ns;
		test_a <="00001111";
		test_b <="11110000";
		test_c <="01010101";
		test_s <="10";
		wait for 200 ns;
		test_a <="00001111";
		test_b <="11110000";
		test_c <="01010101";
		test_s <="11";
		wait for 200 ns;
		wait;
	END PROCESS;

END behavioral;