-- code heavily HEAVILY inspired by Colin 'Domipheus' Riley at domipheus.com


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

-- default baud rate will be 9600 for rn
-- our cpu runs at 1Mhz rn
-- will read/write one char at a time


entity UART is
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
end UART;

architecture Behavioral of UART is
signal baud_rate        : integer := 9600;
signal SYS_CLOCK        : integer := 10416; -- the number of system clock pulses per baud (10mhz / 9600)
signal TX_CLK           : STD_LOGIC := '0';
signal TX_STATE         : integer := 0;
signal TX_BUFFER        : STD_LOGIC_VECTOR(7 downto 0);
signal int_TX           : std_logic;    -- internal to avoid inout
signal int_TX_RDY       : std_logic;    -- internal to avoid inout
signal TX_TICK_COUNT    : integer := 0;
signal RX_STATE         : integer := 0;
signal RX_CLK           : STD_LOGIC := '0';
signal RX_CLK_RESET     : STD_LOGIC := '0';
signal RX_TICK_COUNT    : integer := 0;
signal RX_SAMPLE_COUNT  : integer := 0;
signal RX_SAMPLE_OFFSET : integer := 7;
signal RX_BUFFER        : STD_LOGIC_VECTOR(7 downto 0);
begin


clk_gen: process(CLK) is begin
    if rising_edge(CLK) then
        -- first generate our rx baud ticks (16x faster than baud rate)
        if RX_TICK_COUNT = 0 then
            RX_TICK_COUNT <= (SYS_CLOCK/16);
            RX_CLK <= '1';
        else
            if RX_CLK_RESET = '1' then
                RX_TICK_COUNT <= (SYS_CLOCK/16);
                RX_CLK_RESET <= '0';
            else
                RX_TICK_COUNT <= RX_TICK_COUNT -1;
            end if;
            RX_CLK <= '0';
        end if;
        
        -- tx clock gen
        if TX_TICK_COUNT = 0 then
            TX_TICK_COUNT <= SYS_CLOCK/2;
            TX_CLK <= not TX_CLK;
        else
            TX_TICK_COUNT <= TX_TICK_COUNT -1;
        end if;
    end if;
end process;

-- we utilize tx_state as both our bit counter and our state checker

TX <= int_TX;
TX_RDY <= int_TX_RDY;

tx_proc:process(TX_CLK) is begin
    if rising_edge(TX_CLK) then
        -- check for a reset and set us to an idle state
        if  RESET = '1' then
            TX_BUFFER <= x"00";
            TX_STATE <= 0;
            int_TX_RDY <= '1';
            int_TX <= '1';
        else
        -- check for idle state & signal to transmit, start our transmit
            if (TX_STATE = 0 and TX_SIG = '1') then
                TX_STATE <= 1;
                TX_BUFFER <= DATA_IN;
                int_TX_RDY <= '0';
                int_TX <= '0';
        -- check for tx'ing state & that we're not at the end of our buffer
            elsif TX_STATE < 9 and int_TX_RDY = '0' then
                int_TX <= TX_BUFFER(TX_STATE-1);
                --OUT_BUFFER(TX_STATE-1) <= TX_BUFFER(TX_STATE-1); --temp for testing
                TX_STATE <= TX_STATE + 1;
        -- if we're at the end of our buffer, send our stop bit and reset to idle
            elsif TX_STATE = 9 and int_TX_RDY = '0' then
                int_TX <= '1';
                int_TX_RDY <= '1';
                TX_STATE <= 0;
            end if;
        end if;
    end if;
end process;



rx_proc:process(CLK, RESET, RX) is begin
    if rising_edge(CLK) then
        if RX = '0' and RX_STATE = 0 and RX_EN = '1' then
            rx_state <= 1;
            rx_sample_offset <= 7; -- start bit
            rx_sample_count <= 0;
            
            rx_clk_reset <= '1'; -- reset our tick count
        elsif rx_clk = '1' and rx = '0' and rx_state = 1 then
            rx_sample_count <= rx_sample_count +1;
            if rx_sample_count = rx_sample_offset then
                rx_sig <= '0';
                rx_state <= 2;
                rx_buffer <= x"00";
                rx_sample_offset <= 16; -- done with start bit, now we count by 16
                rx_sample_count <= 0;
             end if;
         elsif rx_clk = '1' and rx_state >= 2 and rx_state < 10 then -- cycle through our data bits
            if rx_sample_count = rx_sample_offset then
                rx_buffer(6 downto 0) <= rx_buffer(7 downto 1);
                rx_buffer(7) <= rx;
                rx_sample_count <= 0;
                rx_state <= rx_state +1;
            else
                rx_sample_count <= rx_sample_count +1;
            end if;
        elsif rx_clk = '1' and rx_state = 10 then
            if rx_sample_count = 7 then -- stop bit
                rx_state <= 0;
                rx_sig <= '1';
                rx_data <= rx_buffer;  -- actually send our data out
            else
                rx_sample_count <= rx_sample_count +1;
            end if;
        end if;
   end if;
end process;    
            
            
            
end Behavioral;
