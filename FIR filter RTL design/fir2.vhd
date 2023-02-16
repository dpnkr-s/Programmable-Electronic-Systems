library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

use work.input_type.all;

entity fir2 is
	generic(word_size:	integer:=16);
	port(	clk,rst,clear:	in std_logic;
		data_in:	in std_logic_vector(word_size-1 downto 0);
		data_out:	out std_logic_vector(word_size-1 downto 0));
end fir2;

architecture structural of fir2 is
constant l: integer:=17;
signal data_mux: input_type;
signal mux0_mul0, mux1_mul1: std_logic_vector(word_size-1 downto 0);
signal rom0_mul0, rom1_mul1: std_logic_vector(word_size-1 downto 0);
signal mul0_reg0, mul1_reg1: std_logic_vector(2*word_size-1 downto 0);
signal reg0_adder0, reg1_adder0: std_logic_vector(2*word_size-1 downto 0);
signal adder0_reg2: std_logic_vector(2*word_size-1 downto 0);
signal reg2_adder1: std_logic_vector(2*word_size-1 downto 0);
signal adder1_reg3: std_logic_vector(2*word_size-1 downto 0);
signal reg3_adder1: std_logic_vector(2*word_size-1 downto 0);
signal final: std_logic_vector(word_size-1 downto 0);

signal inner_clk: std_logic;
signal cl_mux0,cl_mux1: std_logic_vector(5 downto 0);
signal cl_rom0,cl_rom1: std_logic_vector(5 downto 0);
signal cl_reg3: std_logic;

component reg16
	GENERIC(N:	INTEGER:=16);
	PORT(	D 		:IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		rst,clear,clk	:IN STD_LOGIC;
		Q		:OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END component;

component adder 
	GENERIC(
		N : INTEGER := 32);
	PORT(
	   	x1 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		x2 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	   	y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END component;

component multiplier
	GENERIC (
		N : integer := 16);
	PORT(
	   	x1 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		x2 : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
	   	y : OUT STD_LOGIC_VECTOR(2*N-1 DOWNTO 0));
END component;

component multiplexer
        GENERIC (
		log_L: integer:=6);
	PORT(
		CL: IN STD_LOGIC_VECTOR(log_L-1 DOWNTO 0);
	   	x : IN input_type;
	   	y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END component;

component rom 
	generic( data_bits:integer:=16;
		 addr_bits:integer:=6);
	port(	 address:in std_logic_vector(addr_bits-1 downto 0);
		 data_out:out std_logic_vector(data_bits-1 downto 0);
		 clk:in std_logic);
end component;

begin
	u_reg_in0: reg16 port map(D=>data_in,rst=>rst,clear=>clear,clk=>clk,Q=>data_mux(0));
	g_reg_in: for i in l-1 downto 1 generate
		u_reg_in: reg16 port map(D=>data_mux(i-1),rst=>rst,clear=>clear,clk=>clk,Q=>data_mux(i));
	end generate g_reg_in;

	u_mux0: multiplexer port map(CL=>cl_mux0,x=>data_mux,y=>mux0_mul0);
	u_mux1: multiplexer port map(CL=>cl_mux1,x=>data_mux,y=>mux1_mul1);

	u_rom0: rom port map(address=>cl_rom0,data_out=>rom0_mul0,clk=>inner_clk);
	u_rom1: rom port map(address=>cl_rom1,data_out=>rom1_mul1,clk=>inner_clk);

	u_mul0: multiplier port map(x1=>mux0_mul0,x2=>rom0_mul0,y=>mul0_reg0);
	u_mul1: multiplier port map(x1=>mux1_mul1,x2=>rom1_mul1,y=>mul1_reg1);

	u_reg0: reg16 generic map(32) port map(D=>mul0_reg0,rst=>rst,clear=>clear,clk=>inner_clk,Q=>reg0_adder0);
	u_reg1: reg16 generic map(32) port map(D=>mul1_reg1,rst=>rst,clear=>clear,clk=>inner_clk,Q=>reg1_adder0);

	u_adder0: adder port map(x1=>reg0_adder0,x2=>reg1_adder0,y=>adder0_reg2);

	u_reg2: reg16 generic map(32) port map(D=>adder0_reg2,rst=>rst,clear=>clear,clk=>inner_clk,Q=>reg2_adder1);

	u_adder1: adder port map(x1=>reg2_adder1,x2=>reg3_adder1,y=>adder1_reg3);

	u_reg3: reg16 generic map(32) port map(D=>adder1_reg3,rst=>rst,clear=>cl_reg3,clk=>inner_clk,Q=>reg3_adder1);
	
	final <= adder1_reg3(28 downto 13);
	
	u_reg_final: reg16 port map(D=>final,rst=>rst,clear=>clear,clk=>clk,Q=>data_out);

end structural;