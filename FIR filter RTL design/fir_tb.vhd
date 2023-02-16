-------------------------------------------------------------------------------
-- Title      : Testbench for design FIR filter
-- Project    : Laboratory 2
-------------------------------------------------------------------------------
-- File       : fir_tb.vhd
-- Author     : Mario R. Casu  <mario.casu@polito.it>
-- Company    : Politecnico di Torino.
-- Created    : 2011-10-11
-- Last update: 2011-10-11
-- Platform   : Windows whith Emacs and CygWin
-- Standard   : VHDL'87
-------------------------------------------------------------------------------
-- Description: fir testbench
-- Copy Right : Copyright (c) 2011 Mario R. Casu
--
-- Revisions  :
-- Date        Version      Author                      Description
-- 2011/10/11  1.0          Mario R. Casu               Created
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

library std;
use std.textio.all;

---------------------------------------------------------------------------------------------------

entity fir_tb is

end fir_tb;

---------------------------------------------------------------------------------------------------

architecture fir of fir_tb is

  component fir
    generic(
      word_size : integer
      );      
    port (
      clk, rst, clear      : in  std_logic;
      data_in              : in  std_logic_vector(word_size-1 downto 0);
      data_out             : out std_logic_vector(word_size-1 downto 0)
      );
  end component;


  -- period
  constant input_period : time    := 10 ns;
  constant period       : time    := 145 ns;
  constant word_size    : integer := 16;


  -- component ports
  signal rst, clear              : std_logic;
  signal data_in                 : std_logic_vector(word_size-1 downto 0);
  signal data_out                : std_logic_vector(word_size-1 downto 0);
  -- clock
  signal clk                     : std_logic := '1';



begin  -- fir


  -- instantiation
  ufir: fir
    generic map (
      word_size => word_size)
    port map (
      clk      => clk,
      rst      => rst,
      clear    => clear,
      data_in  => data_in,
      data_out => data_out);

  -- clock generation
  Clk <= not Clk after input_period/2;

  -- waveform generation
  WaveGen_Proc : process
    -- file input
    file sample : text is in "C:\Users\Qizhen\Dropbox\study\programmable electronic systems\labs\lab 2\fir_input.txt";
    file res    : text is out "C:\Users\Qizhen\Dropbox\study\programmable electronic systems\labs\lab 2\fir_output.txt";

    variable ptr  : line;
    variable data : integer;
    
  begin

    -- reset/clear
    rst <= '1';
    clear  <= '1';
    wait for period;
    rst <= '0';
    clear <= '0';

    -- samples uploading/downloading
    while not(endfile(sample)) loop
      readline(sample, ptr);
      read(ptr, data);
      -- assigning input
      data_in <= conv_std_logic_vector(data, word_size);
      -- writing output
      data    := conv_integer(data_out);
      write(ptr, data);
      writeline(res, ptr);
      wait for input_period;
    end loop;

    assert true report "Simulation Ended" severity note;
    -- that's all folks
    wait for period;


  end process WaveGen_Proc;

end fir;


