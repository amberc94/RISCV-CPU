
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity InstructionDecoder is
    Generic (
        constant OP_IMM : STD_LOGIC_VECTOR := "0010011";
        constant OP     : STD_LOGIC_VECTOR := "0110011";
        constant BRANCH : STD_LOGIC_VECTOR := "1100011";
        constant JALR   : STD_LOGIC_VECTOR := "1100111";
        constant LOAD   : STD_LOGIC_VECTOR := "0000011";
        constant STORE  : STD_LOGIC_VECTOR := "0100011";
        constant JAL    : STD_LOGIC_VECTOR := "1101111";
        constant AUIPC  : STD_LOGIC_VECTOR := "0010111";
        constant LUI    : STD_LOGIC_VECTOR := "0110111"
     );  
    
    Port ( 
           Instructions : in STD_LOGIC_VECTOR(31 downto 0);     -- 32 bit instruction
           ALU_A        : out STD_LOGIC;                        -- ALU A input selector
           ALU_B        : out STD_LOGIC;                        -- ALU B input selector
           ALU_TYPE     : out STD_LOGIC_VECTOR(1 downto 0);     -- ALU Control, will be handled by FunctDecoder 
           REG_WRITE    : out STD_LOGIC;                        -- Register write
           WB_SELECT    : out STD_LOGIC_VECTOR(1 downto 0);     -- WB Mux selector
           MEM_WRITE    : out STD_LOGIC;                        -- LUT Ram write
           MEM_READ     : out STD_LOGIC;                        -- LUT Ram read
           JB_SELECT    : out STD_LOGIC_VECTOR(1 downto 0);     -- PC Next mux selector
           IMM_SELECT   : out STD_LOGIC_VECTOR(2 downto 0)      -- Immediate Generator Logic
     );
end InstructionDecoder;

architecture Behavioral of InstructionDecoder is
    signal OPCODE : STD_LOGIC_VECTOR(6 downto 0);
begin
    
     OPCODE <= Instructions(6 downto 0);
     
     with OPCODE select ALU_A <=
        '0' when OP_IMM,
        '0' when OP,
        '0' when BRANCH,
        '0' when JALR,
        '0' when LOAD,
        '0' when STORE,
        '1' when JAL,
        '1' when AUIPC,
        '0' when LUI,
        '0' when others;
        
    with OPCODE select ALU_B <=
        '1' when OP_IMM,
        '0' when OP,
        '0' when BRANCH,
        '1' when JALR,
        '1' when LOAD,
        '1' when STORE,
        '1' when JAL,
        '1' when AUIPC,
        '0' when LUI,
        '0' when others;
        
     with OPCODE select ALU_TYPE <=
        "11" when OP_IMM,
        "10" when OP,
        "01" when BRANCH,
        "00" when JALR,
        "00" when LOAD,
        "00" when STORE,
        "00" when JAL,
        "00" when AUIPC,
        "00" when LUI,
        "00" when others;
        
     with OPCODE select REG_WRITE <=
        '1' when OP_IMM,
        '1' when OP,
        '0' when BRANCH,
        '1' when JALR,
        '1' when LOAD,
        '0' when STORE,
        '1' when JAL,
        '1' when AUIPC,
        '0' when LUI,
        '0' when others;
        
     with OPCODE select WB_SELECT <=
        "00" when OP_IMM,
        "00" when OP,
        "00" when BRANCH,
        "10" when JALR,
        "01" when LOAD,
        "00" when STORE,
        "10" when JAL,
        "00" when AUIPC,
        "11" when LUI,
        "00" when others;
        
    with OPCODE select MEM_WRITE <=
        '0' when OP_IMM,
        '0' when OP,
        '0' when BRANCH,
        '0' when JALR,
        '0' when LOAD,
        '1' when STORE,
        '0' when JAL,
        '0' when AUIPC,
        '0' when LUI,
        '0' when others;    
        
    with OPCODE select MEM_READ <=
        '0' when OP_IMM,
        '0' when OP,
        '0' when BRANCH,
        '0' when JALR,
        '1' when LOAD,
        '0' when STORE,
        '0' when JAL,
        '0' when AUIPC,
        '0' when LUI,
        '0' when others;
        
    with OPCODE select JB_SELECT <=
        "00" when OP_IMM,
        "00" when OP,
        "11" when BRANCH,
        "10" when JALR,
        "00" when LOAD,
        "00" when STORE,
        "01" when JAL,
        "00" when AUIPC,
        "00" when LUI,
        "00" when others;
        
    with OPCODE select IMM_SELECT <=
        "001" when OP_IMM,
        "000" when OP,
        "100" when BRANCH,
        "001" when JALR,
        "001" when LOAD,
        "010" when STORE,
        "101" when JAL,
        "011" when AUIPC,
        "011" when LUI,
        "000" when others;
    
end Behavioral;
