library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

entity fir is
  
  port (
    clk  : in std_logic;
    x_in : in std_logic_vector(15 downto 0);
    y_out : out std_logic_vector(15 downto 0));

end fir;

architecture str of fir is

  component firslice
    port (
      clk   : in  std_logic;
      x_in  : in  std_logic_vector(15 downto 0);
      a_in  : in  std_logic_vector(12 downto 0);
      d_in  : in  std_logic_vector(32 downto 0);
      x_out : out std_logic_vector(15 downto 0);
      d_out : out std_logic_vector(32 downto 0));
  end component;

  type rom is array (0 to 16) of integer;
  constant coeff : rom := (-282,
                           -369,
                           -307,
                           -67,
                           326,
                           803,
                           1259,
                           1587,
                           1706,
                           1587,
                           1259,
                           803,
                           326,
                           -67,
                           -307,
                           -369,
                           -282
                           );

  type delays is array (0 to 17) of std_logic_vector(15 downto 0);
  signal xdly : delays;
  type addinputs is array (0 to 17) of std_logic_vector(32 downto 0);
  signal addin : addinputs;
  type rom_std is array (0 to 16) of std_logic_vector(12 downto 0);
  signal a_in : rom_std;

begin  -- str

  xdly(0) <= x_in;
  addin(0) <= (others => '0');

  gslices: for i in 0 to 16 generate
    a_in(i) <= conv_std_logic_vector(coeff(i),13);
    ufirslice: firslice
      port map (
        clk   => clk,
        x_in  => xdly(i),
        a_in  => a_in(i),
        d_in  => addin(i),
        x_out => xdly(i+1),
        d_out => addin(i+1));
  end generate gslices;


  -- output register
  pout: process (clk)
  begin  -- process pout
    if clk'event and clk = '1' then  -- rising clock edge
      y_out <= addin(17)(28 downto 13);
    end if;
  end process pout;

    

end str;
