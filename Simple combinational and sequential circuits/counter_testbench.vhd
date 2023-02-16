LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY counter_testbench IS
END counter_testbench;

ARCHITECTURE behavioral OF counter_testbench IS
SIGNAL INIT_test: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL LOAD_test,INC_test,RST_test,CLK_test: STD_LOGIC;
SIGNAL RESULT_test_structural: STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL RESULT_test_behavioral: STD_LOGIC_VECTOR(7 DOWNTO 0);
CONSTANT n_case: integer := 20;
BEGIN

	U_counter_structural: entity work.counter(structural) PORT MAP(INIT=>INIT_test,RST=>RST_test,CLK=>CLK_test,LOAD=>LOAD_test,INC=>INC_test,RESULT=>RESULT_test_structural);
	U_counter_behavioral: entity work.counter(behavioral) PORT MAP(INIT=>INIT_test,RST=>RST_test,CLK=>CLK_test,LOAD=>LOAD_test,INC=>INC_test,RESULT=>RESULT_test_behavioral);
	test: PROCESS
	BEGIN
		INIT_test<="10101100";
		LOAD_test<='1';
		INC_test<='1';
		RST_test<='0';
         	wait for 125 ns;

         	LOAD_test<='0';
         	wait for 400 ns;

         	INC_test<='0';
         	wait for 300 ns;
		
		RST_test<='1';
         	wait for 200 ns;

         	INC_test<='1';
         	wait for 200 ns;

         	RST_test<='0';
         	wait for 300 ns;

		LOAD_test<='1';		
         	wait for 100 ns;

         	LOAD_test<='0';
         	wait for 400 ns;
         	wait;
	END PROCESS;

     	clock: PROCESS
     	BEGIN
         	for i in 0 to n_case-1 loop
           		CLK_test <='1';
           		wait for 50 ns;  
           		CLK_test <='0';
           		wait for 50 ns;
         	end loop;
         	wait;
     	END PROCESS;
END behavioral;
