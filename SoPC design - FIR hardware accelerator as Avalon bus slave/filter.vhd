library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

library std;
use std.textio.all;

entity filter is
  port( 
    clock: in std_logic;
    reset: in std_logic;
    clear: in std_logic;
    start: in std_logic;
    done: out std_logic);
end filter;
 
architecture behavioral of filter is



subtype datatype is integer range -65536 to 65535;
type ioarray is array (0 to 84) of datatype;
type rom is array (0 to 16) of datatype;

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


constant inputdata : ioarray := (0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  1,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  0,
                                  -6754,
                                  -15687,
                                  -31716,
                                  -6518,
                                  7301,
                                  -10850,
                                  31710,
                                  -2341,
                                  999,
                                  -30678,
                                  24927,
                                  6725,
                                  -12612,
                                  -7333,
                                  2755,
                                  25075,
                                  24101,
                                  -7305,
                                  10859,
                                  26998,
                                  26665,
                                  152,
                                  -6149,
                                  -17218,
                                  -7584,
                                  16591,
                                  -31878,
                                  32457,
                                  23096,
                                  26618,
                                  27595,
                                  -16927,
                                  -16990,
                                  29897,
                                  24311,
                                  -3735,
                                  -10177,
                                  23941,
                                  -16392,
                                  -11137,
                                  29304,
                                  -5486,
                                  19224,
                                  12300,
                                  -28414,
                                  -24613,
                                  -18685,
                                  11771,
                                  -13118,
                                  -7813,
                                  -25070);

signal z: rom;
signal io: integer;
signal state: std_logic:='0';
begin
  process(clock,reset,start)
  variable result: datatype;
  file res    : text is out "C:\Users\Qizhen\Dropbox\study\programmable electronic systems\labs\lab 6\fir_output.txt";
  variable ptr  : line;
  variable data : integer;
  variable sum: integer;
  variable sum_bit: std_logic_vector(31 downto 0);
  begin
    done <= '0';
    sum :=0;
    if reset='1' then
      for i in 0 to 16 loop
        z(i)<=0;
      end loop;
      io <= 0;
      state <= '0';
    elsif rising_edge(clock) then
      if start = '1' then
        state <= '1';
      end if;
      if clear='1' then
        for i in 0 to 16 loop
          z(i)<=0;
        end loop;
        io <= 0;
        state <= '0';
      elsif (state = '1') and (io < 85) then
        z(0) <= inputdata(io);
        io <= io +1;
        for i in 1 to 16 loop
          z(i) <=z(i-1);
        end loop;
        for i_muladd in 0 to 16 loop
          sum :=sum + z(i_muladd)*coeff(i_muladd);
        end loop;
        sum_bit := conv_std_logic_vector(sum,32);
        data := conv_integer(sum_bit(28 downto 13));
        write(ptr, data);
        writeline(res, ptr);
      end if;
    end if;
    if io = 85 then
      done <= '1';
    end if;
  end process;

end behavioral;
