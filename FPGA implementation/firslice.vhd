library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;


entity firslice is
  
  port (
    clk   : in  std_logic;
    x_in  : in  std_logic_vector(15 downto 0);
    a_in  : in  std_logic_vector(12 downto 0);
    d_in  : in  std_logic_vector(32 downto 0);
    x_out : out std_logic_vector(15 downto 0);
    d_out : out std_logic_vector(32 downto 0));

end firslice;


architecture beh of firslice is

  signal x_int : std_logic_vector(15 downto 0);
  signal mul_int : std_logic_vector(32 downto 0);
  
begin  -- beh

  x_out <= x_int;

  process (clk)
  begin  -- process
    if clk'event and clk = '1' then  -- rising clock edge
      x_int <= x_in;
    end if;
  end process;

  mul_int(28 downto 0) <= a_in * x_int;

  gsignext: for i in 29 to 32 generate
    mul_int(i) <= mul_int(28);
  end generate gsignext;

  d_out <= d_in + mul_int;

  

end beh;
