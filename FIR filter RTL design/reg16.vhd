LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg16 IS
	GENERIC(N:	INTEGER:=16);
	PORT(	D 		:IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
		rst,clear,clk	:IN STD_LOGIC;
		Q		:OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END reg16;
 
ARCHITECTURE behavioral OF reg16 IS
BEGIN
    PROCESS(rst,clk)
    BEGIN
        if rst ='1'then
		Q<=(others=>'0');
        elsif rising_edge(clk) then
		if clear='1' then
			Q<=(others=>'0');
		end if;
		Q<=D;
        end if;
    END PROCESS;
END behavioral;      
 
        