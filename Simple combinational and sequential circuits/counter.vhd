LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY counter IS
  GENERIC(
                N : INTEGER := 8 );
        PORT(   INIT : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
                LOAD, INC, CLK, RST : IN STD_LOGIC;
                RESULT: OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) );
END counter;

ARCHITECTURE structural OF counter IS

SIGNAL M2R : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL R2A : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL A2M : STD_LOGIC_VECTOR(7 DOWNTO 0);

COMPONENT reg8 
 PORT(  D                 :IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        Reset,Clock       :IN STD_LOGIC;
        Q                 :OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
 END COMPONENT;

COMPONENT ripple_carry_adder 
        GENERIC(
                n :       INTEGER := 8 );
        PORT(   A,B :     IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
                Cn :      IN STD_LOGIC;
                Co :      OUT STD_LOGIC;
                S :       OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) );
END COMPONENT;

COMPONENT multiplexer 
        GENERIC(
              N: INTEGER :=8 );
        PORT(   
        
                A,B,C: IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
                S: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
                Y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) );
END COMPONENT;

BEGIN
  U_multiplexer: multiplexer PORT MAP (S(1)=>LOAD,S(0)=>INC,A=>R2A,B=>A2M,C=>INIT,Y=>M2R);
  U_reg8: reg8 PORT MAP (Clock => CLK, Reset=>RST,D=>M2R,Q=>R2A);
  U_ripple_carry_adder : ripple_carry_adder PORT MAP(Cn=>'0', A=>R2A, B => "00000001", S => A2M);

  RESULT <= A2M;       
END structural;

ARCHITECTURE behavioral OF counter IS
SIGNAL COUNT: STD_LOGIC_VECTOR(N-1 DOWNTO 0);
BEGIN
 	PROCESS(CLK, RST)
 	BEGIN
		IF RST ='1'THEN
			COUNT<="00000001";
		ELSIF rising_edge(CLK) THEN
			IF LOAD = '1' THEN
 	                       COUNT <= INIT+1;
			ELSIF INC = '1' THEN
				COUNT <= COUNT+1;
 	            END IF;
 		END IF;
 	END PROCESS;
	RESULT <= COUNT;
 END behavioral;   