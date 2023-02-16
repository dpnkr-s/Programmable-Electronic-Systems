LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY ripple_carry_adder_testbench IS
	                
END ripple_carry_adder_testbench;

ARCHITECTURE behavioral OF ripple_carry_adder_testbench IS

SIGNAL test_a,test_b: STD_LOGIC_VECTOR(7 DOWNTO 0) :="00000000";
SIGNAL test_cn: STD_LOGIC := '0';
SIGNAL test_s_structural: STD_LOGIC_VECTOR(7 DOWNTO 0) :="00000000";
SIGNAL test_co_structural: STD_LOGIC := '0';
SIGNAL test_s_dataflow: STD_LOGIC_VECTOR(7 DOWNTO 0) :="00000000";
SIGNAL test_co_dataflow: STD_LOGIC := '0';

BEGIN
	U_ripple_carry_adder_structural: entity work.ripple_carry_adder(structural) PORT MAP(A=>test_a,B=>test_b,Cn=>test_cn,S=>test_s_structural,Co=>test_co_structural);
	U_ripple_carry_adder_dataflow: entity work.ripple_carry_adder(dataflow) PORT MAP(A=>test_a,B=>test_b,Cn=>test_cn,S=>test_s_dataflow,Co=>test_co_dataflow);
        
        test: PROCESS
	BEGIN
		test_a <= "00000111";
		test_b <= "00011100";
		test_cn <= '0';
		wait for 200 ns;
		test_a <= "00000111";
		test_b <= "00011100";
		test_cn <= '1';
		wait for 200 ns;
		test_a <= "10000111";
		test_b <= "10011100";
		test_cn <= '0';
		wait for 200 ns;
		test_a <= "10000111";
		test_b <= "10011100";
		test_cn <= '1';
		wait for 200 ns;
		wait;
	END PROCESS;
	
END behavioral;
