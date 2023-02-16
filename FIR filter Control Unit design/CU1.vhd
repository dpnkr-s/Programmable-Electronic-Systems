--THIS FILE IS CORRECT NOW! DON'T DO ANY MODIFICATION! BY LU QIZHEN
--THE MOST IMPORTANT FILE OF LAB 3!

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity CU1 is
	generic(nAddr: integer:=5);
	port(clk,rst,enable: in std_logic;
		output: out std_logic_vector((nAddr-1)+3 downto 0));
end CU1;

architecture cu1 of CU1 is

constant nState: integer:= 13;
signal present_state,next_state: integer;
constant initial_state: integer:=0;
signal out_address: integer;
signal out_rst_regin,out_rst_reg,out_clk: std_logic;
begin
	process1: process(clk,rst)
	begin
		if (rst = '1') then
			present_state <= initial_state;
		elsif rising_edge(clk) then
			if (enable = '1') then
				present_state <= next_state;
			end if;
		end if;
	end process;
	
	process2: process(present_state)
	begin
		case present_state is
			when initial_state|12 =>
				next_state <= 1;
			when 1 =>
				next_state <= 2;
			when 2 =>
				next_state <= 3;
			when 3 =>
				next_state <= 4;
			when 4 =>
				next_state <= 5;
			when 5 =>
				next_state <= 6;
			when 6 =>
				next_state <= 7;
			when 7 =>
				next_state <= 8;
			when 8 =>
				next_state <= 9;
			when 9 =>
				next_state <= 10;
			when 10 =>
				next_state <= 11;
			when 11 =>
				next_state <= 12;
			when others =>
				next_state <= initial_state;
		end case;
	end process;

	process3: process(present_state)
	begin
		case present_state is
			when initial_state =>
				out_rst_reg <= '1';
				out_rst_regin <= '1';
				out_address <= 0;
				out_clk <= '0';
			when 1 to 11=>
				out_rst_reg <= '0';
				out_rst_regin <= '0';
				out_address <= 2*(present_state-1);
				out_clk <= '0';
			when 12=>
				out_rst_reg <= '1';
				out_rst_regin <= '0';
				out_address <= 18;
				out_clk <= '1';
			when others =>
				out_rst_reg <= '1';
				out_rst_regin <= '1';
				out_address <= 18;
				out_clk <= '0';
			end case;
		
	end process;
	output(nAddr-1 downto 0) <= conv_std_logic_vector(out_address,nAddr);
	output(nAddr) <= out_rst_reg;
	output(nAddr+1) <= out_rst_regin;
	output(nAddr+2) <= out_clk;
end cu1;