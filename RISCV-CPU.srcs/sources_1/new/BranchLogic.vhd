
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BranchLogic is
  Generic( constant BEQ          : STD_LOGIC_VECTOR(2 downto 0) := "000";
           constant BNE          : STD_LOGIC_VECTOR(2 downto 0) := "001";
           constant BLT          : STD_LOGIC_VECTOR(2 downto 0) := "100";
           constant BGE          : STD_LOGIC_VECTOR(2 downto 0) := "101";
           constant BLTU         : STD_LOGIC_VECTOR(2 downto 0) := "110";
           constant BGEU         : STD_LOGIC_VECTOR(2 downto 0) := "111"
         );
           
  Port ( BRANCH_TYPE    : in STD_LOGIC_VECTOR(2 downto 0);
         ZR             : in STD_LOGIC;
         NG             : in STD_LOGIC;
         BRANCH         : out STD_LOGIC
       );
end BranchLogic;

architecture Behavioral of BranchLogic is

begin

    BRANCH <=
        '1' when (BRANCH_TYPE = BEQ and ZR = '1') else -- a - b = 0 they are equal
        '1' when (BRANCH_TYPE = BNE and ZR = '0') else -- a - b != 0
        '1' when (BRANCH_TYPE = BLT and NG = '1') else -- a - b < 0
        '1' when (BRANCH_TYPE = BGE and NG = '0') else -- a - b >= 0
        '1' when (BRANCH_TYPE = BLTU and NG = '1') else -- a - b < 0 but treat a/b as unsigned
        '1' when (BRANCH_TYPE = BGEU and NG = '0') else -- a - b >= 0 but treat a/b as unsigned
        '0';

end Behavioral;
