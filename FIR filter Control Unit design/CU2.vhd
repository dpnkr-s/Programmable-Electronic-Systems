--THIS FILE IS CORRECT NOW! PLEASE DON'T DO ANY MODIFICATION! BY LU QIZHEN
--THE MOST IMPORTANT FILE OF LAB 3!

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

entity CU2 is
	generic(nAddr: integer:=6);
	port(clk,rst,enable: in std_logic;
		output: out std_logic_vector((nAddr-1)+3 downto 0));
end CU2;

architecture cu2 of CU2 is

component rom_fsm
	generic( data_bits:integer:=8;
		 addr_bits:integer:=4);
	port(	 address:in std_logic_vector(addr_bits-1 downto 0);
		 data_out:out std_logic_vector(data_bits-1 downto 0));
end component;

constant nState: integer:= 13;
constant nBitState: integer:= 4;
signal present_state,next_state: std_logic_vector(nBitState-1 downto 0);
constant initial_state: std_logic_vector(nBitState-1 downto 0):=(others=>'0');
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
		if (present_state = "1100") then
			next_state <= "0001";
		elsif (present_state(3 downto 2) /= "11") then
			next_state <= present_state + 1;
		else
			next_state <= initial_state;
		end if;
	end process;

	u_rom_fsm: rom_fsm port map(address=>present_state,data_out=>output);
end cu2;