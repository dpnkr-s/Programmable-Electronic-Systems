library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

library std;
use std.textio.all;

entity fir is
	generic(word_size:	integer:=16);
	port(	clk,rst,clear:	in std_logic;
		data_in:	in std_logic_vector(word_size-1 downto 0);
		data_out:	out std_logic_vector(word_size-1 downto 0));
end fir;
 
architecture behavioral of fir is

constant l:	integer:=17;
constant nf:	integer:=13;

type f_type is	array(l-1 downto 0) of std_logic_vector(nf-1 downto 0);
signal f:	f_type;

type z_type is	array(l-1 downto 0) of std_logic_vector(word_size-1 downto 0);
signal z:	z_type;
begin
	process(clk,rst,data_in)
	variable sum:	std_logic_vector(word_size+nf+l-1 downto 0):=(others=>'0');

	file sample:	text is in "C:\Users\Qizhen\Dropbox\study\programmable electronic systems\labs\lab 2\fir_coeff.txt";
	variable ptr:	line;
	variable data:	integer;
	variable i_rd:	integer:=0;
	begin
		while not(endfile(sample)) loop
			readline(sample, ptr);
			read(ptr, data);
			f(i_rd) <= conv_std_logic_vector(data, nf);
			i_rd:=i_rd+1;
		end loop;
		if rst='1' then
			for i in l-1 downto 1 loop
				z(i)<=(others=>'0');
			end loop;
		elsif rising_edge(clk) then
			if clear='1' then
				for i in l-1 downto 1 loop
					z(i)<=(others=>'0');
				end loop;
			end if;
			for i in l-1 downto 1 loop
				z(i)<=z(i-1);
			end loop;
		end if;
		sum:=(others=>'0');
		z(0)<=data_in;
		for i in l-1 downto 0 loop
			sum:=sum+z(i)*f(i);
		end loop;
		data_out<=sum(word_size+nf-1 downto nf);
	end process;
end behavioral;