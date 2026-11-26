
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.finish;
use std.textio.all;
use IEEE.NUMERIC_STD.all;

entity UART_tb is
end UART_tb;

architecture Behavioral of UART_tb is

component UART is
   Port ( CLK           : in STD_LOGIC; -- SYS CLOCK
          RESET         : in STD_LOGIC; -- reset
          DATA_IN       : in STD_LOGIC_VECTOR(7 downto 0);-- data to send
          TX_SIG        : in STD_LOGIC; -- signal to tx
          TX_RDY        : out STD_LOGIC; -- signal we are ready to tx
          TX            : out STD_LOGIC;  -- actual serial output
          RX            : in STD_LOGIC;   -- actual serial input
          RX_EN         : in STD_LOGIC;   -- enable rx
          RX_DATA       : out STD_LOGIC_VECTOR(7 downto 0);  -- the data we've recived
          RX_SIG        : out STD_LOGIC    -- signal that we have data available
       );
end component;

signal CLOCK        : STD_LOGIC := '0';
signal DATA_IN      : STD_LOGIC_VECTOR(7 downto 0);
signal DATA_OUT     : STD_LOGIC_VECTOR(7 downto 0);
signal TX_SIG       : STD_LOGIC;
signal TX_RDY       : STD_LOGIC;
signal TX           : STD_LOGIC;
signal RX           : STD_LOGIC;
signal RX_EN        : STD_LOGIC;
signal RX_SIG       : STD_LOGIC;
signal RESET        : STD_LOGIC;


constant ClockFreq  : integer := 10e8;
constant ClockPeriod: time := 1000 ms / ClockFreq;

begin

uut: UART port map (
    CLK => CLOCK,
    RESET => RESET,
    DATA_IN => DATA_IN,
    TX_SIG => TX_SIG,
    TX_RDY => TX_RDY,
    TX => TX,
    RX => RX,
    RX_EN => RX_EN,
    RX_DATA => DATA_OUT,
    RX_SIG => RX_SIG
    );
    
    RX <= TX;
    RX_EN <= '1';
    
    CLOCK <= not CLOCK after ClockPeriod /2;
    
    stim_proc:process begin
        RESET <= '1';
        wait for 100ns;
        RESET <= '0';
        
        wait for ClockPeriod*10;
        
        DATA_IN <= x"48";
        TX_SIG <= '1';
        wait until TX_RDY = '0';
        TX_SIG <= '0';
        
        wait until TX_RDY = '1';
        DATA_IN <= x"45";
        TX_SIG <= '1';
        wait until TX_RDY = '0';
        TX_SIG <= '0';
        
        wait until TX_RDY = '1';
        DATA_IN <= x"4c";
        TX_SIG <= '1';
        wait until TX_RDY = '0';
        TX_SIG <= '0';
        
        wait until TX_RDY = '1';
        DATA_IN <= x"4c";
        TX_SIG <= '1';
        wait until TX_RDY = '0';
        TX_SIG <= '0';
        
        wait until TX_RDY = '1';
        DATA_IN <= x"4f";
        TX_SIG <= '1';
        wait until TX_RDY = '0';
        TX_SIG <= '0';
        
        
        wait until TX_RDY = '1';
        
        finish;
    end process;
 
end Behavioral;
