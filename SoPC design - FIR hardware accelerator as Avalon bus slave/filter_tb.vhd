library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

library std;
use std.textio.all;

entity filter_tb is
end filter_tb;

architecture behav of filter_tb is

component filter
    port(   
        clock: in std_logic;
        reset: in std_logic;
        clear: in std_logic;
        start: in std_logic;
        done: out std_logic);
end component;

signal reset,clear,start: std_logic:='0';
signal done: std_logic:='0';
constant input_period : time    := 10 ns;
signal clock: std_logic:='1';
begin
    u_filter: filter port map(clock => clock, reset => reset, clear => clear, start => start, done => done);
    clock <= not clock after input_period/2;
    process
    begin
    reset <= '1';
    clear <= '1';
    wait for 100 ns;
    reset <= '0';
    clear <= '0';
    wait for 100 ns;
    start <='1';
    wait for 100 ns;
    start <= '0';
    wait until done = '1';
    clear <= '1';
    end process;
end behav;

