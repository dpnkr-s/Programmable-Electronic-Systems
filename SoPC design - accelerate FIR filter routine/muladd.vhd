library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity muladd is
	port(
		dataa: IN std_logic_vector(31 downto 0);
		datab: IN std_logic_vector(31 downto 0);
		result: OUT std_logic_vector(31 downto 0));
end muladd;

architecture behav of muladd is
begin
	process(dataa,datab)
	begin
		result <= dataa(31 downto 16) * dataa(15 downto 0) + datab;
	end process;
end behav;
	