
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity PC_NextMux is
  Generic(
        constant PC_4   : STD_LOGIC_VECTOR(1 downto 0) := "00";
        constant JAL    : STD_LOGIC_VECTOR(1 downto 0) := "01";
        constant JALR   : STD_LOGIC_VECTOR(1 downto 0) := "10";
        constant BRANCH : STD_LOGIC_VECTOR(1 downto 0) := "11"
        );
  Port ( JB_SELECT : in STD_LOGIC_VECTOR(1 downto 0);
          IMM      : in STD_LOGIC_VECTOR(31 downto 0);
          PC       : in STD_LOGIC_VECTOR(31 downto 0);
          ALU_OUT  : in STD_LOGIC_VECTOR(31 downto 0);
          B_LOGIC  : in STD_LOGIC;
          PC_NEXT  : out STD_LOGIC_VECTOR(31 downto 0)
       );
          
end PC_NextMux;

architecture Behavioral of PC_NextMux is
signal PC_INC : STD_LOGIC_VECTOR(31 downto 0);
signal PC_IMM : STD_LOGIC_VECTOR(31 downto 0);

begin
    PC_INC <= std_logic_vector(unsigned(PC) + 4);
    PC_IMM <= std_logic_vector(unsigned(PC) + unsigned(IMM));
    
    PC_NEXT <= PC_INC when JB_SELECT = PC_4 else
               PC_INC when (JB_SELECT = BRANCH and B_LOGIC = '0') else
               PC_IMM when (JB_SELECT = BRANCH and B_LOGIC = '1') else
               PC_IMM when JB_SELECT = JAL else
               ALU_OUT when JB_SELECT = JALR else
               PC_INC;
               
end Behavioral;
