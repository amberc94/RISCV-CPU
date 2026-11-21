-- code heavily HEAVILY inspired by Colin 'Domipheus' Riley at domipheus.com


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

-- default baud rate will be 9600 for rn
-- our cpu runs at 1Mhz rn
-- will read/write one char at a time


entity UART is
  Port (CLK     : in STD_LOGIC;
        DATA_IN : in STD_LOGIC_VECTOR(7 downto 0);
        DATA_OUT: out STD_LOGIC_VECTOR(7 downto 0);
        TX_SIG  : in STD_LOGIC;
        TX_RST  : in STD_LOGIC;
        TX_RDY  : inout STD_LOGIC;
        TX      : inout STD_LOGIC := '1'
       );
end UART;

architecture Behavioral of UART is
signal baud_rate : integer := 9600;
signal UART_CLK   : STD_LOGIC := '0';
signal TX_STATE : integer := 0;
signal TX_BUFFER : STD_LOGIC_VECTOR(7 downto 0);
signal OUT_BUFFER : STD_LOGIC_VECTOR(7 downto 0);
begin

clk_baud:process(CLK) is 
    variable clock_count : integer := 0;
begin
    -- i'll make this adjustable later
    if(rising_edge(CLK) and clock_count < 104/2) then -- 1mhz / 9600 baud rate = 104 clock cycles per uart_clock
        clock_count := clock_count + 1;
    elsif(rising_edge(CLK) and clock_count >= 104/2) then
        clock_count := 0;
        UART_CLK <= not UART_CLK;
    end if;    
end process;

-- we utilize tx_state as both our bit counter and our state checker

tx_proc:process(UART_CLK) is begin
    if rising_edge(UART_CLK) then
        -- check for a reset and set us to an idle state
        if TX_RST = '1' then
            TX_BUFFER <= x"00";
            TX_STATE <= 0;
            TX_RDY <= '1';
            TX <= '1';
        else
        -- check for idle state & signal to transmit, start our transmit
            if (TX_STATE = 0 and TX_SIG = '1') then
                TX_STATE <= 1;
                TX_BUFFER <= DATA_IN;
                TX_RDY <= '0';
                TX <= '0';
        -- check for tx'ing state & that we're not at the end of our buffer
            elsif TX_STATE < 9 and TX_RDY = '0' then
                TX <= TX_BUFFER(TX_STATE-1);
                OUT_BUFFER(TX_STATE-1) <= TX_BUFFER(TX_STATE-1); --temp for testing
                TX_STATE <= TX_STATE + 1;
        -- if we're at the end of our buffer, send our stop bit and reset to idle
            elsif TX_STATE = 9 and TX_RDY = '0' then
                TX <= '1';
                TX_RDY <= '1';
                TX_STATE <= 0;
            end if;
        end if;
    end if;
end process;

DATA_OUT <= OUT_BUFFER;




end Behavioral;
