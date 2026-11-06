
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.config_pkg.all;
use work.all;

entity WBMux is
    Port(
        ALU_RESULT  : in STD_LOGIC_VECTOR(31 downto 0);
        MEM_READ    : in STD_LOGIC_VECTOR(31 downto 0);
        PC_4        : in STD_LOGIC_VECTOR(31 downto 0);
        IMM         : in STD_LOGIC_VECTOR(31 downto 0);
        WB_SELECT   : in STD_LOGIC_VECTOR(1 downto 0);
        WB_OUT      : out STD_LOGIC_VECTOR(31 downto 0)
        );
end WBMux;

architecture Behavioral of WBMux is

begin

    WB_OUT <=
        ALU_RESULT when WB_SELECT = "00" else
        MEM_READ when WB_SELECT = "01" else
        PC_4 when WB_SELECT = "10" else
        IMM when WB_SELECT = "11";


end Behavioral;
