
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.config_pkg.all;
use work.all;

entity Reg_32bit is
  Port (REG_IN  : in STD_LOGIC_VECTOR(31 downto 0);
        REG_OUT : out STD_LOGIC_VECTOR(31 downto 0);
        CLK     : in STD_LOGIC;
        RESET   : in STD_LOGIC;
        WRITE   : in STD_LOGIC
        );
end Reg_32bit;

architecture Behavioral of Reg_32bit is

signal REG_DATA : STD_LOGIC_VECTOR(31 downto 0);

begin
     REG_OUT <= REG_DATA;
    process(CLK, reset) begin
        if (reset = '0') then
            REG_DATA <= x"00000000";
        elsif rising_edge(CLK) and WRITE = '1' then
            REG_DATA <= REG_IN;
        end if;
    end process; 
end Behavioral;
