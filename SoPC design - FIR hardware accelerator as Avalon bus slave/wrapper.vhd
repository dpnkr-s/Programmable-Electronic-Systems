library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity wrapper is 
    port(   address: in std_logic_vector(1 downto 0);
        writedata: in std_logic_vector(7 downto 0);
        readdata: out std_logic_vector(7 downto 0);
        
        write: in std_logic;
        read: in std_logic;
        chipselect: in std_logic;
        reset: in std_logic;
        clock: in std_logic);
end wrapper;

architecture behav of wrapper is
type ram_type is array(0 to 2) of std_logic_vector(7 downto 0);
signal ram: ram_type;
signal done: std_logic := '0';
component filter
    port(   
        clock: in std_logic;
        reset: in std_logic;
        clear: in std_logic;
        start: in std_logic;
        done: out std_logic);
end component;

begin
    u_filter: filter port map(clock => clock,reset => reset, clear => ram(0)(0),start =>ram(1)(0),done => done);

    process(clock,reset,chipselect)
    begin 
        if chipselect = '1' then
            if reset = '1' then
                for i in 0 to 2 loop
                    ram(i) <= (others => '0');
                end loop;
            elsif rising_edge(clock) then
                if write = '1' then
                    ram(conv_integer(address)) <= writedata;
                end if;
            end if;
            if read = '1' then
                ram(2)(0) <= done;
                readdata <= ram(conv_integer(address));
            end if;
        end if;
    end process;
end behav;
