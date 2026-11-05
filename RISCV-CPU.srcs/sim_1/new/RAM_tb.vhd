library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.vcomponents.all;
library work;
use work.all;
use work.config_pkg.all;


entity RAM_tb is
end RAM_tb;

architecture Behavioral of RAM_tb is

component RAM is
    port (
        CLK, WRITE  : in STD_LOGIC;
        ADDRESS     : in STD_LOGIC_VECTOR(31 downto 0);
        DATA_IN     : in STD_LOGIC_VECTOR(31 downto 0);
        DATA_OUT    : out STD_LOGIC_VECTOR(31 downto 0);
        WIDTH       : in STD_LOGIC_VECTOR(2 downto 0)
        );
end component;


constant ClockFreq : integer := 10e6; --10khz
constant ClockPeriod : time := 1000ms / ClockFreq;

signal CLK           : STD_LOGIC := '0';
signal WRITE         : STD_LOGIC := '0';
signal ADDRESS       : STD_LOGIC_VECTOR(31 downto 0);
signal DATA_IN       : STD_LOGIC_VECTOR(31 downto 0);
signal DATA_OUT      : STD_LOGIC_VECTOR(31 downto 0);
signal WIDTH          : STD_LOGIC_VECTOR(2 downto 0);

begin

    uut: RAM port map (
        CLK => CLK,
        WRITE => WRITE,
        ADDRESS => ADDRESS,
        DATA_IN => DATA_IN,
        DATA_OUT => DATA_OUT,
        WIDTH => WIDTH
        );
        
        
        CLK <= not CLK after ClockPeriod /2;
        
        stim_proc:process begin
        width <= "010";
        address <= x"00000000";
        write <= '1';
        data_in <= x"DEADBEEF";
        wait for clockPeriod;
        
        address <= x"000001F0";
        write <= '1';
        data_in <= x"1111AAAA";
        wait for clockPeriod;
        
        address <= x"00000480";
        write <= '0';
        data_in <= x"FFFFFFFF";
        
        wait for clockPeriod;
        
        address <= x"0000001F";
        
        wait for clockPeriod /2;
        
        address <= x"FFFFFFFF";
        
        wait for clockPeriod /4;
        
        address <= x"00000B80";
        
        wait for clockPeriod /4;
        
        width <= "000";
        address <= x"00000000";
        
        wait for clockPeriod;
        
        write <= '1';
        data_in <= x"FFFFFFFF";
        
        
        end process;


end Behavioral;
