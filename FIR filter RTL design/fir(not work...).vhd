LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_signed.all;

LIBRARY std;
USE std.textio.all;

entity fir is
	generic(word_size:	integer:=16);
	port(	clk,rst,clear:	in std_logic;
		data_in:	in std_logic_vector(word_size-1 downto 0);
		data_out:	out std_logic_vector(word_size-1 downto 0));
end fir;

ARCHITECTURE behavioral OF fir IS

constant L:	INTEGER:=17;
constant NF:	INTEGER:=13;

type f_type is 		array (L-1 DOWNTO 0) of STD_LOGIC_VECTOR(NF-1 DOWNTO 0);
type z_type is 		array (L-1 DOWNTO 0) of STD_LOGIC_VECTOR(word_size-1 DOWNTO 0);
type zf_type is 	array (L-1 DOWNTO 0) of STD_LOGIC_VECTOR(NF+word_size-1 DOWNTO 0);

signal f:	f_type;
signal z:	z_type;
signal zf:	zf_type;
signal sum_zf:	zf_type;

COMPONENT reg16
	GENERIC(N:	INTEGER:=16);
	PORT(	D 		:IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		Reset,Clock	:IN STD_LOGIC;
		Q		:OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END COMPONENT;

COMPONENT multiplier
  GENERIC (
	N :	integer:=16;
	NF:	INTEGER:=13);
  PORT(
	   	x1 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		x2 : IN STD_LOGIC_VECTOR(NF-1 DOWNTO 0);
	   	y : OUT STD_LOGIC_VECTOR(N+NF-1 DOWNTO 0));
END COMPONENT;

COMPONENT adder
	GENERIC(
		N : INTEGER := 29);
	PORT(
	   	x1 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		x2 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	   	y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END COMPONENT;

BEGIN
	z(0) <= DATA_IN;

	G_reg16: FOR i IN 1 TO 16 GENERATE
		U_reg16: reg16 PORT MAP(D=>z(i-1),Reset=>RST,Clock=>CLK,Q=>z(i));
	END GENERATE G_reg16;

	G_mult: FOR i IN 0 TO 16 GENERATE
		U_mult: multiplier PORT MAP(x1=>z(i),x2=>f(i),y=>zf(i));
	END GENERATE G_mult;

	sum_zf(0) <= zf(0);

	G_adder: FOR i IN 1 TO 16 GENERATE
		U_adder: adder PORT MAP(x1=>zf(i-1),x2=>zf(i),y=>sum_zf(i));
	END GENERATE G_adder;
	DATA_OUT<=SUM_ZF(16)(28 DOWNTO 13);
	read_f: process
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
	end process;
END behavioral;
