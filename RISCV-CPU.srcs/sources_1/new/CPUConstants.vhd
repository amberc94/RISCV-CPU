
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

package config_pkg is 

    -- Instruction Decoer
    constant OP_IMM : STD_LOGIC_VECTOR(6 downto 0) := "0010011";
    constant OP     : STD_LOGIC_VECTOR(6 downto 0) := "0110011";
    constant BRANCH : STD_LOGIC_VECTOR(6 downto 0) := "1100011";
    constant JALR   : STD_LOGIC_VECTOR(6 downto 0) := "1100111";
    constant LOAD   : STD_LOGIC_VECTOR(6 downto 0) := "0000011";
    constant STORE  : STD_LOGIC_VECTOR(6 downto 0) := "0100011";
    constant JAL    : STD_LOGIC_VECTOR(6 downto 0) := "1101111";
    constant AUIPC  : STD_LOGIC_VECTOR(6 downto 0) := "0010111";
    constant LUI    : STD_LOGIC_VECTOR(6 downto 0) := "0110111";
    
    -- Immediate Generator
    constant R_TYPE : STD_LOGIC_VECTOR(2 downto 0) := "000";
    constant I_TYPE : STD_LOGIC_VECTOR(2 downto 0) := "001";
    constant S_TYPE : STD_LOGIC_VECTOR(2 downto 0) := "010";
    constant U_TYPE : STD_LOGIC_VECTOR(2 downto 0) := "011";
    constant B_TYPE : STD_LOGIC_VECTOR(2 downto 0) := "100";
    constant J_TYPE : STD_LOGIC_VECTOR(2 downto 0) := "101";
    
    -- Funct3/7 Decoder
    constant ADD : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant BRANCH_F : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant F3 : STD_LOGIC_VECTOR(1 downto 0) := "11";
    constant F7 : STD_LOGIC_VECTOR(1 downto 0) := "10";
    
    -- PC Next Mux
    constant PC_4   : STD_LOGIC_VECTOR(1 downto 0) := "00";
    constant PC_JAL    : STD_LOGIC_VECTOR(1 downto 0) := "01";
    constant PC_JALR   : STD_LOGIC_VECTOR(1 downto 0) := "10";
    constant PC_BRANCH : STD_LOGIC_VECTOR(1 downto 0) := "11";
    
    -- Branch Logic
    constant BEQ          : STD_LOGIC_VECTOR(2 downto 0) := "000";
    constant BNE          : STD_LOGIC_VECTOR(2 downto 0) := "001";
    constant BLT          : STD_LOGIC_VECTOR(2 downto 0) := "100";
    constant BGE          : STD_LOGIC_VECTOR(2 downto 0) := "101";
    constant BLTU         : STD_LOGIC_VECTOR(2 downto 0) := "110";
    constant BGEU         : STD_LOGIC_VECTOR(2 downto 0) := "111";
    
    -- ALU Controls
    constant ALU_ADD        : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    constant ALU_SUB        : STD_LOGIC_VECTOR(3 downto 0) := "0001";
    constant ALU_XOR        : STD_LOGIC_VECTOR(3 downto 0) := "0010";
    constant ALU_AND        : STD_LOGIC_VECTOR(3 downto 0) := "0011";
    constant ALU_OR         : STD_LOGIC_VECTOR(3 downto 0) := "0100";
    constant ALU_SLT        : STD_LOGIC_VECTOR(3 downto 0) := "0101";
    constant ALU_SLL        : STD_LOGIC_VECTOR(3 downto 0) := "0111";
    constant ALU_SRL        : STD_LOGIC_VECTOR(3 downto 0) := "1000";
    constant ALU_SRA        : STD_LOGIC_VECTOR(3 downto 0) := "1001";
end package config_pkg;
