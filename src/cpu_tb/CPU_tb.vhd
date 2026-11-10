
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.finish;
use std.textio.all;
use IEEE.std_logic_textio.all;

entity CPU_tb is
--  Port ( );
end CPU_tb;


architecture Behavioral of CPU_tb is

component CPU is port(
    CLOCK   : in STD_LOGIC;
    RESET   : in STD_LOGIC;
    PC_RESET : in STD_LOGIC;
    DEBUG_OUTPUT : out STD_LOGIC_VECTOR(31 downto 0);
    EBREAK  : out STD_LOGIC
    );
end component;

signal CLOCK    : STD_LOGIC := '0';
signal RESET    : STD_LOGIC := '0';
signal PC_RESET : STD_LOGIC := '0';
signal DEBUG_OUTPUT : STD_LOGIC_VECTOR(31 downto 0);
signal EBREAK   : STD_LOGIC := '0';

constant ClockFreq : integer := 10e6; --1Mhz
constant ClockPeriod : time := 1000 ms / ClockFreq;


begin
    uut: CPU port map (
        CLOCK => CLOCK,
        RESET => RESET,
        PC_RESET => PC_RESET,
        DEBUG_OUTPUT => DEBUG_OUTPUT,
        EBREAK => EBREAK
    );
    
    CLOCK <= not CLOCK after ClockPeriod / 2;
    
    stim_proc:process
    
    file test_out : text open append_mode is ("test.txt");
    variable lineout : line;
    
    begin

    RESET <= '1';
    PC_RESET <= '1';
    
   while(EBREAK /= '1') loop
        wait for ClockPeriod;
    end loop;
        
    write(lineout, DEBUG_OUTPUT);
    writeline(test_out, lineout);
    
    finish;
    
    end process;    

end Behavioral;
