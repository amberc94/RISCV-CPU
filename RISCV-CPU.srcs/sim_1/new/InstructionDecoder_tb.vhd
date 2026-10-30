
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity InstructionDecoder_tb is
end InstructionDecoder_tb;

architecture Behavioral of InstructionDecoder_tb is

component InstructionDecoder is
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
end component;

signal Instructions : STD_LOGIC_VECTOR(31 downto 0);
signal IMM_SELECT : STD_LOGIC_VECTOR(2 downto 0);
signal ALU_TYPE, WB_SELECT, JB_SELECT : STD_LOGIC_VECTOR(1 downto 0);
signal ALU_A, ALU_B, REG_WRITE, MEM_WRITE, MEM_READ : STD_LOGIC;
begin
    uut: InstructionDecoder port map (
        Instructions => Instructions, 
        ALU_A => ALU_A,
        ALU_B => ALU_B,
        ALU_TYPE => ALU_TYPE, 
        REG_WRITE => REG_WRITE,
        WB_SELECT => WB_SELECT,
        MEM_WRITE => MEM_WRITE,
        MEM_READ => MEM_READ,
        JB_SELECT => JB_SELECT,
        IMM_SELECt => IMM_SELECT
        );
        
        stim_proc:process
        begin
            -- lw
            Instructions <= x"0000a103";
            wait for 100ns;
            
            -- addi
            Instructions <= x"3e800093";
            wait for 100ns;
            
            --auipc
            Instructions <= x"00000097";
            wait for 100ns;
            
            --sw
            Instructions <= x"0020a023";
            wait for 100ns;
            
            --add
            Instructions <= x"003100b3";
            wait for 100ns;
            
            --lui
            Instructions <= x"000000b7";
            wait for 100ns;
            
            --beq
            Instructions <= x"00008063";
            wait for 100ns;
            
            --jalr
            Instructions <= x"000100e7";
            wait for 100ns;
            
            --jal
            Instructions <= x"000000ef";
            wait for 100ns;
            
            --ECALL
            Instructions <= x"00000073";
            wait for 100ns;
        end process;
end Behavioral;
