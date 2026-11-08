
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity Reg_32bit_tb is
end Reg_32bit_tb;

architecture Behavioral of Reg_32bit_tb is

component Reg_32bit
    port ( CLK, RESET, WRITE    : in STD_LOGIC;
           REG_IN               : in STD_LOGIC_VECTOR(31 downto 0);
           REG_OUT              : out STD_LOGIC_VECTOR(31 downto 0)
          );
end component;

constant ClockFreq : integer := 10e6; --10khz
constant ClockPeriod : time := 1000ms / ClockFreq;

signal CLK          : STD_LOGIC := '0';
signal RESET        : STD_LOGIC := '0';
signal WRITE        : STD_LOGIC := '0';
signal REG_IN       : STD_LOGIC_VECTOR(31 downto 0);
signal REG_OUT      : STD_LOGIC_VECTOR(31 downto 0);

begin
    uut: Reg_32bit port map (
        CLK => CLK,
        RESET => RESET,
        WRITE => WRITE,
        REG_IN => REG_IN,
        REG_OUT => REG_OUT
        );
        
        CLK <= not CLK after ClockPeriod /2;
        
        stim_proc:process
        begin
        
        REG_IN <= x"01010101";
        wait for ClockPeriod * 2;
        
        RESET <= '1';
        wait for ClockPeriod * 2;
        
        WRITE <= '1';
        wait for ClockPeriod *2;
        
        REG_IN <= x"11111111";
        wait for ClockPeriod *2;
        
        WRITE <='0';
        wait for ClockPeriod *2;
        
        REG_IN <= x"00110011";
        wait for ClockPeriod *2;
        
        REG_IN <= x"01001000";
        wait for ClockPeriod *2;
        
        end process;
end Behavioral;
