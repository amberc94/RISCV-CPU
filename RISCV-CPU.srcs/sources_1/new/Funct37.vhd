library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity Funct37 is
  Generic(
         constant ADD : STD_LOGIC_VECTOR(1 downto 0) := "00";
         constant BRANCH : STD_LOGIC_VECTOR(1 downto 0) := "01";
         constant F3 : STD_LOGIC_VECTOR(1 downto 0) := "11";
         constant F7 : STD_LOGIC_VECTOR(1 downto 0) := "10"
         );
  Port ( ALU_TYPE       : in STD_LOGIC_VECTOR(1 downto 0);
         Instructions   : in STD_LOGIC_VECTOR(31 downto 0);
         ALU_CONTROL    : out STD_LOGIC_VECTOR(3 downto 0);
         WIDTH          : out STD_LOGIC_VECTOR(2 downto 0);
         BRANCH_TYPE    : out STD_LOGIC_VECTOR(2 downto 0);
         SIGN           : out STD_LOGIC
       );
end Funct37;

architecture Behavioral of Funct37 is

signal FUNC3 : STD_LOGIC_VECTOR(2 downto 0);
signal FUNC7 : STD_LOGIC_VECTOR(6 downto 0);

begin
    FUNC3 <= Instructions(14 downto 12);
    FUNC7 <= Instructions(31 downto 26);
    WIDTH <= FUNC3;
    BRANCH_TYPE <=
        FUNC3 when ALU_TYPE = BRANCH else
        "010";
    
    -- this should really be reworked to just have a sign/unsign flag    
    ALU_CONTROL <= 
        "0000" when ALU_TYPE = ADD else -- most functions
        "0001" when (ALU_TYPE = BRANCH and not(FUNC3 = "110" or FUNC3 = "111"))  else -- all branch options are simply going to rs1 - rs2 and check the ALU zr/ng flags (except unsigned checks)
        "0000" when(FUNC3 = "000" and ((ALU_TYPE = F3) or (ALU_TYPE = F7 and FUNC7(5) = '0'))) else -- ADD
        "0001" when(FUNC3 = "000" and ALU_TYPE = F7 and FUNC7(5) = '1') else                        -- SUB
        "0010" when(FUNC3 = "100" and ((ALU_TYPE = F3) or (ALU_TYPE = F7)))else                     -- XOR
        "0011" when(FUNC3 = "111" and (ALU_TYPE = F3 or ALU_TYPE = F7)) else                        -- AND
        "0100" when(FUNC3 = "110" and (ALU_TYPE = F3 or ALU_TYPE = F7)) else                        -- OR
        "0101" when(FUNC3 = "010" and (ALU_TYPE = F3 or ALU_TYPE = F7)) else                        -- SLT(I) Set Less Than
        "0101" when(FUNC3 = "011" and (ALU_TYPE = F3 or ALU_TYPE = F7)) else                        -- SLT(I)U Set Less Than Unsigned
        "0111" when(FUNC3 = "001" and (ALU_TYPE = F3 or ALU_TYPE = F7)) else                        -- SLL(I) Shift Left
        "1000" when(FUNC3 = "101" and ((ALU_TYPE = F3) or (ALU_TYPE = F7 and FUNC7(5) = '0'))) else -- SRL(I) Shift Right
        "1001" when(FUNC3 = "101" and ((ALU_TYPE = F3) or (ALU_TYPE = F7 and FUNC7(5) = '1'))) else -- SRAI Shift Right Arithmatic
        "0001" when(ALU_TYPE = BRANCH and (FUNC3 = "110" or FUNC3 = "111")) else                    -- SUBU     
        "0000"; -- fail to add
        
    SIGN <=
        '0' when(FUNC3 = "011" and (ALU_TYPE = F3 or ALU_TYPE = F7)) else                        -- SLT(I)U Set Less Than Unsigned
        '0' when(ALU_TYPE = BRANCH and (FUNC3 = "110" or FUNC3 = "111")) else                    -- SUBU
        '1';
    

end Behavioral;
