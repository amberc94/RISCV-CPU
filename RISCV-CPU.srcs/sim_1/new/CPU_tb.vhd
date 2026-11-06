
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_tb is
--  Port ( );
end CPU_tb;


architecture Behavioral of CPU_tb is

component CPU is port(
    CLOCK   : in STD_LOGIC;
    RESET   : in STD_LOGIC
    );
end component;

signal CLOCK    : STD_LOGIC := '0';
signal RESET    : STD_LOGIC := '0';

constant ClockFreq : integer := 10e3; --1khz
constant ClockPeriod : time := 1000ms / ClockFreq;


begin


    uut: CPU port map (
        CLOCK => CLOCK,
        RESET => RESET
    );
    
    CLOCK <= not CLOCK after ClockPeriod / 2;
    
    stim_proc:process begin
    
    RESET <= '1';
    
    wait for ClockPeriod * 10;
    
    RESET <= '0';
    
    end process;



end Behavioral;
