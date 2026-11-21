
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use std.env.finish;
use std.textio.all;
use IEEE.NUMERIC_STD.all;

entity UART_tb is
end UART_tb;

architecture Behavioral of UART_tb is

component UART is
    Port( CLK       : in STD_LOGIC;
          DATA_IN   : in STD_LOGIC_VECTOR(7 downto 0);
          DATA_OUT  : out STD_LOGIC_VECTOR(7 downto 0);
          TX_SIG  : in STD_LOGIC;
          TX_RST  : in STD_LOGIC;
          TX_RDY  : inout STD_LOGIC;
          TX        : inout STD_LOGIC
        );
end component;

signal CLOCK        : STD_LOGIC := '0';
signal DATA_IN      : STD_LOGIC_VECTOR(7 downto 0);
signal DATA_OUT     : STD_LOGIC_VECTOR(7 downto 0);
signal TX_SIG       : STD_LOGIC;
signal TX_RST       : STD_LOGIC;
signal TX_RDY       : STD_LOGIC;
signal TX           : STD_LOGIC;


constant ClockFreq  : integer := 10e6;
constant ClockPeriod: time := 1000 ms / ClockFreq;

begin

uut: UART port map (
    CLK => CLOCK,
    DATA_IN => DATA_IN,
    DATA_OUT => DATA_OUT,
    TX_SIG => TX_SIG,
    TX_RST => TX_RST,
    TX_RDY => TX_RDY,
    TX => TX
    );
    
    CLOCK <= not CLOCK after ClockPeriod /2;
    
    stim_proc: process is
    variable outline : line; 
    begin
    
       DATA_IN <= x"68"; -- H
       TX_SIG <= '1';
       wait until TX_RDY = '0';
       TX_SIG <= '0';
       wait until TX_RDY = '1';
       report "" & character'val(to_integer(unsigned(DATA_OUT)));
       
       DATA_IN <= x"65"; -- E
       TX_SIG <= '1';
       wait until TX_RDY = '0';
       TX_SIG <= '0';
       wait until TX_RDY = '1';
       report "" & character'val(to_integer(unsigned(DATA_OUT)));
       
       DATA_IN <= x"6C"; -- L
       TX_SIG <= '1';
       wait until TX_RDY = '0';
       TX_SIG <= '0';    
       wait until TX_RDY = '1';
       report "" & character'val(to_integer(unsigned(DATA_OUT)));
       
       DATA_IN <= x"6C"; -- L
       TX_SIG <= '1';
       wait until TX_RDY = '0';
       TX_SIG <= '0'; 
       wait until TX_RDY = '1';
       report "" & character'val(to_integer(unsigned(DATA_OUT)));
       
       DATA_IN <= x"6F"; -- O
       TX_SIG <= '1';
       wait until TX_RDY = '0';
       TX_SIG <= '0'; 
       wait until TX_RDY = '1';
       report "" & character'val(to_integer(unsigned(DATA_OUT)));
       
       wait for 1ns;
       finish;
     end process;
     
--     uart_logger: process is
--        constant BAUD_RATE  : integer := 9600;
--        constant BIT_PERIOD : time := 1 sec / BAUD_RATE;
--        variable outline    : line;
--     begin
--        wait until TX = '0';
--        wait for BIT_PERIOD * 1.5;
        
--        for i in 0 to 7 loop
--            DATA_OUT(i) <= TX;
--            wait for BIT_PERIOD;
--        end loop;
        
--        if TX = '1' then
--            write(outline, character'val(to_integer(unsigned(DATA_OUT))));
--            if DATA_OUT = x"0A" then
--                writeline(output, outline);
--            end if;
--        end if;
--  end process uart_logger;
        
     
end Behavioral;
