
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_tb is
--  Port ( );
end CPU_tb;


architecture Behavioral of CPU_tb is

component CPU is port(
    CLOCK   : in STD_LOGIC;
    RESET   : in STD_LOGIC;
    DEBUG_OUTPUT : out STD_LOGIC_VECTOR(31 downto 0)
    );
end component;

signal CLOCK    : STD_LOGIC := '0';
signal RESET    : STD_LOGIC := '0';
signal DEBUG_OUTPUT : STD_LOGIC_VECTOR(31 downto 0);

constant ClockFreq : integer := 10e6; --1Mhz
constant ClockPeriod : time := 1000 ms / ClockFreq;


begin
    uut: CPU port map (
        CLOCK => CLOCK,
        RESET => RESET,
        DEBUG_OUTPUT => DEBUG_OUTPUT
    );
    
    CLOCK <= not CLOCK after ClockPeriod / 2;
    
    stim_proc:process begin
    
    RESET <= '1';
    
    wait for ClockPeriod * 50;
    
    
    end process;



end Behavioral;
