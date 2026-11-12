
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.config_pkg.all;
use work.all;

entity BranchLogic is
      
  Port ( BRANCH_TYPE    : in STD_LOGIC_VECTOR(2 downto 0);
         ZR             : in STD_LOGIC;
         NG             : in STD_LOGIC;
         GT             : in STD_LOGIC;
         BRANCH         : out STD_LOGIC
       );
end BranchLogic;

architecture Behavioral of BranchLogic is

begin

    BRANCH <=
        '1' when (BRANCH_TYPE = BEQ and ZR = '1') else -- a - b = 0 they are equal
        '1' when (BRANCH_TYPE = BNE and ZR = '0') else -- a - b != 0
        '1' when (BRANCH_TYPE = BLT and GT = '0' and ZR /= '1') else -- a is smaller than b and they aren't equal
        '1' when (BRANCH_TYPE = BGE and GT = '1') else -- a is larger than b, we don't care if it's equal
        '1' when (BRANCH_TYPE = BLTU and GT = '0' and ZR /= '1') else -- a is smaller than b and they aren't equal
        '1' when (BRANCH_TYPE = BGEU and GT = '1') else -- a is larger than b, we don't care if it's equal
        '0';

end Behavioral;
