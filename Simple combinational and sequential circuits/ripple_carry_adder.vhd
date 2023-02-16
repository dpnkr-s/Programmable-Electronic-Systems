LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY ripple_carry_adder IS
        GENERIC(
                n : INTEGER := 8 );
        PORT(   A,B : IN STD_LOGIC_VECTOR(N-1 DOWNTO 0);
                Cn : IN STD_LOGIC;
                Co : OUT STD_LOGIC;
                S : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0) );
                
END ripple_carry_adder;

ARCHITECTURE structural OF ripple_carry_adder IS
SIGNAL C : STD_LOGIC_VECTOR(8 DOWNTO 0);

COMPONENT full_adder
        PORT(
                A,B,Ci : IN STD_LOGIC;
                S,Co : OUT STD_LOGIC );
END COMPONENT;

BEGIN
        C(0) <= Cn;
        
        G2: FOR i IN 0 TO 7 GENERATE
                U_full_adder : full_adder PORT MAP(A=>A(i), B=>B(i), Ci=>C(i), Co=>C(i+1), S=>S(i));
        END GENERATE;
        
        Co <= C(8);
        
END structural;

ARCHITECTURE dataflow OF ripple_carry_adder IS
SIGNAL RESULT: STD_LOGIC_VECTOR(N-1 DOWNTO 0);

BEGIN
	RESULT <= A + B + Cn;
	Co <= '0' WHEN ('0'&RESULT) = (('0'&A) + ('0'&B) + Cn) ELSE '1' ;
	S <= RESULT;
        
END dataflow;