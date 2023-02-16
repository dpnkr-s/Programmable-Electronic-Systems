library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity adder is
  port (
    dataa  : in  std_logic_vector(31 downto 0);
    datab  : in  std_logic_vector(31 downto 0);
    result : out std_logic_vector(31 downto 0));
end adder;

architecture behav of adder is 
begin  -- behav
  process(dataa,datab)
    begin
      result <= dataa + datab;
    end process;
end behav;
