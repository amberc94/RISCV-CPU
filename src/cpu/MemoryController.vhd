
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.config_pkg.all;


-- 0x0 to 0x1FFFFFFF - ROM
-- 0x20000000 - 0x3FFFFFFF - RAM
-- 0x40000000+  - reserved for IO 

entity MemoryController is
    Port (CLK           : in STD_LOGIC;
          RAM_ADDRESS   : in STD_LOGIC_VECTOR(31 downto 0);
          DATA_IN        : in STD_LOGIC_VECTOR(31 downto 0);
          ROM_ADDRESS   : in STD_LOGIC_VECTOR(31 downto 0);
          WIDTH         : in STD_LOGIC_VECTOR(2 downto 0);
          WRITE         : in STD_LOGIC;
          FLASH         : in STD_LOGIC;
          RAM_OUT       : out STD_LOGIC_VECTOR(31 downto 0);
          ROM_OUT       : out STD_LOGIC_VECTOR(31 downto 0)
          );
end MemoryController;

architecture Behavioral of MemoryController is
signal RAM_BUFFER           : STD_LOGIC_VECTOR(31 downto 0);
signal ROM_BUFFER           : STD_LOGIC_VECTOR(31 downto 0);
signal UART_WRITE_BUFFER    : STD_LOGIC_VECTOR(7 downto 0);
signal UART_READ_BUFFER     : STD_LOGIC_VECTOR(7 downto 0);
signal RAM_WRITE            : STD_LOGIC;
signal ROM_WRITE            : STD_LOGIC;
signal UART_WRITE           : STD_LOGIC;
signal UART_READ            : STD_LOGIC;
signal TX_RDY               : STD_LOGIC;
signal TX                   : STD_LOGIC;
signal RX_SIG               : STD_LOGIC;
signal RX                   : STD_LOGIC;
begin

RAM: entity work.RAM port map(CLK=>CLK, BYTE_ADD=>RAM_ADDRESS, DATA_IN => RAM_BUFFER, WRITE=>WRITE, WIDTH=>WIDTH, DATA_OUT=>RAM_OUT);
ROM: entity work.ROM port map(ADDRESS=>ROM_ADDRESS, DATA_OUT=>ROM_OUT, FLASH=>FLASH);
UART: entity work.UART port map(CLK=>CLK, RESET=>'0', DATA_IN => UART_WRITE_BUFFER, TX_SIG=>UART_WRITE, TX_RDY=>TX_RDY, TX => TX, RX =>RX, RX_EN => UART_READ, RX_DATA => UART_READ_BUFFER, RX_SIG=>RX_SIG);

process(RAM_ADDRESS, DATA_IN) is begin
    -- we don't want to be able to write to ROM, but we still want to be able to read from it
    if (unsigned(RAM_ADDRESS) < x"20000000") then
        RAM_BUFFER <= x"00000000";
        RAM_WRITE <= '0';
        UART_WRITE <= '0';
    elsif (unsigned(RAM_ADDRESS) < x"40000000") then
        RAM_BUFFER <= DATA_IN;
        RAM_WRITE <= '1';
        UART_WRITE <= '0';
    elsif (unsigned(RAM_ADDRESS) >= x"40000000") then
        UART_WRITE_BUFFER <= DATA_IN(7 downto 0);           -- for the current moment we're just going to assume we'll only be writing singluar bytes at a time
        RAM_WRITE <= '0';
        UART_WRITE <= '1';
   end if;
end process;



end Behavioral;
