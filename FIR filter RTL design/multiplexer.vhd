library ieee;
use ieee.std_logic_1164.all;

package input_type is
constant L: integer:=17;
constant N: integer:=16;
type input_type is array(L-1 DOWNTO 0) OF STD_LOGIC_VECTOR(N-1 DOWNTO 0);
end package input_type;

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

use work.input_type.all;

ENTITY multiplexer IS
        GENERIC (
		log_L: integer:=6);
	PORT(
		CL: IN STD_LOGIC_VECTOR(log_L-1 DOWNTO 0);
	   	x : IN input_type;
	   	y : OUT STD_LOGIC_VECTOR(N-1 DOWNTO 0));
END multiplexer;

ARCHITECTURE dataflow OF multiplexer IS
BEGIN
	
	y <= (others=>'0') when CL = "10001" else
		x(conv_integer(unsigned(CL)));
END dataflow;