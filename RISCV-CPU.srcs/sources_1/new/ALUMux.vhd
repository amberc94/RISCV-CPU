
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity ALUMux is
  Port ( REG_A_IN   : in STD_LOGIC_VECTOR(31 downto 0);
         PC_IN      : in STD_LOGIC_VECTOR(31 downto 0);
         REG_B_IN   : in STD_LOGIC_VECTOR(31 downto 0);
         IMM        : in STD_LOGIC_VECTOR(31 downto 0);
         A_SEL      : in STD_LOGIC;
         B_SEL      : in STD_LOGIC;
         A_OUT      : out STD_LOGIC_VECTOR(31 downto 0);
         B_OUT      : out STD_LOGIC_VECTOR(31 downto 0)
         );
end ALUMux;

architecture Behavioral of ALUMux is

begin

A_OUT <=
    REG_A_IN when A_SEL = '0' else
    PC_IN;
    
B_OUT <=
    REG_B_IN when B_SEL = '0' else
    IMM;
    
end Behavioral;
