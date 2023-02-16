library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

library std;
use std.textio.all;

entity wrapper_tb is
end wrapper_tb;

architecture behav of wrapper_tb is

component wrapper
    port(   address: in std_logic_vector(1 downto 0);
        writedata: in std_logic_vector(7 downto 0);
        readdata: out std_logic_vector(7 downto 0);
        
        write: in std_logic;
        read: in std_logic;
        chipselect: in std_logic;
        reset: in std_logic;
        clock: in std_logic);
end component;

signal address: std_logic_vector(1 downto 0):=(others=>'0');
signal writedata,readdata: std_logic_vector(7 downto 0):=(others=>'0');
signal write,read,chipselect,reset: std_logic:='0';
constant input_period : time    := 10 ns;
signal clock: std_logic:='1';
begin

    u_wrapper: wrapper port map(address,writedata,readdata,write,read,chipselect,reset,clock);
    clock <= not clock after input_period/2;
    process
    begin
    chipselect <= '1';
    reset <= '1';
    wait for 100 ns;
    reset <= '0';
    wait for 100 ns;
    write <= '1';
    address <= "00";
    writedata <= "00000001";
    wait for 100 ns;
    writedata <= "00000000";
    wait for 100 ns;
    address <= "01";
    writedata <= "00000001";
    wait for 100 ns;
    writedata <= "00000000";
    wait for 100 ns;
    write <= '0';
    wait for 100 ns;
    read <= '1';
    address <= "10";
    wait until readdata = "00000001";
    read <= '0';

    end process;

end behav;

