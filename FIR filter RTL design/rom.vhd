library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library std;
use std.textio.all;

entity rom is 
	generic( data_bits:integer:=16;
		 addr_bits:integer:=6);
	port(	 address:in std_logic_vector(addr_bits-1 downto 0);
		 data_out:out std_logic_vector(data_bits-1 downto 0);
		 clk:in std_logic);
end rom;

architecture behavioral of rom is

constant l: integer:=17;
type rom_type is array((l+1)-1 downto 0) of std_logic_vector(data_bits-1 downto 0);
signal rom: rom_type;

begin
	read_data: process(clk)
	file sample:	text is in "C:\Users\Qizhen\Dropbox\study\programmable electronic systems\labs\lab 2\fir_coeff.txt";
	variable ptr:	line;
	variable data:	integer;
	variable i_rd:	integer:=0;
	begin
		while not(endfile(sample)) loop
			readline(sample, ptr);
			read(ptr, data);
			rom(i_rd) <= conv_std_logic_vector(data, data_bits);
			i_rd:=i_rd+1;
		end loop;
		rom(l) <= (others=>'0');
        	if rising_edge(clk) then
            		data_out<=rom(conv_integer(address));
        	end if;
	end process;
end behavioral;