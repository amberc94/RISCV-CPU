
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity Reg_File_tb is
end Reg_File_tb;

architecture Behavioral of Reg_File_tb is

component Reg_File is
    port (
        CLK, WRITE  : in STD_LOGIC;
        ADDRESS     : in STD_LOGIC_VECTOR(4 downto 0);
        DATA_IN     : in STD_LOGIC_VECTOR(31 downto 0);
        DATA_OUT    : out STD_LOGIC_VECTOR(31 downto 0)
        );
end component;

constant ClockFreq : integer := 10e6; --10khz
constant ClockPeriod : time := 1000ms / ClockFreq;

signal CLK           : STD_LOGIC := '0';
signal WRITE         : STD_LOGIC := '0';
signal ADDRESS       : STD_LOGIC_VECTOR(4 downto 0);
signal DATA_IN       : STD_LOGIC_VECTOR(31 downto 0);
signal DATA_OUT      : STD_LOGIC_VECTOR(31 downto 0);


begin
    uut: Reg_File port map (
        CLK => CLK,
        WRITE => WRITE,
        ADDRESS => ADDRESS,
        DATA_IN => DATA_IN,
        DATA_OUT => DATA_OUT
        );
        
        CLK <= not CLK after ClockPeriod /2;
        
        stim_proc:process begin
        address <= std_logic_vector(to_unsigned(24,5));
        write <= '1';
        data_in <= x"DEADBEEF";
        wait for clockPeriod;
        
        address <= std_logic_vector(to_unsigned(12,5));
        write <= '1';
        data_in <= x"1111AAAA";
        wait for clockPeriod;
        
        address <= std_logic_vector(to_unsigned(16,5));
        write <= '0';
        data_in <= x"FFFFFFFF";
        
        wait for clockPeriod;
        
        address <= std_logic_vector(to_unsigned(24,5));
        
        wait for clockPeriod /2;
        
        address <= std_logic_vector(to_unsigned(12,5));
        
        wait for clockPeriod /4;
        
        address <= std_logic_vector(to_unsigned(16,5));
        
        wait for clockPeriod /4;
        
        end process;
end Behavioral;
