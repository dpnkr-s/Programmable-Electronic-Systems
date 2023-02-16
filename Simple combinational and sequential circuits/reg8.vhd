LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY reg8 IS
    PORT(
        D                   :IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        Reset,Clock         :IN STD_LOGIC;
        Q                   :OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END reg8;
 
ARCHITECTURE behavioral OF reg8 IS
BEGIN
    PROCESS(Reset,Clock)
    BEGIN
        IF Reset ='1'THEN
            Q<="00000000";
        ELSIF rising_edge(Clock) THEN
            Q<=D;
        END IF;
    END PROCESS;
END behavioral;      
 
        