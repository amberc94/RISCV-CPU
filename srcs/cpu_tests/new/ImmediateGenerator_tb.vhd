
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ImmediateGenerator_tb is
end ImmediateGenerator_tb;

architecture Behavioral of ImmediateGenerator_tb is

component ImmediateGenerator is
    port ( Instructions : in STD_LOGIC_VECTOR(31 downto 0);
            IMM_SELECT  : in STD_LOGIC_VECTOR(2 downto 0);
            Immediate   : out STD_LOGIC_VECTOR(31 downto 0)
          );
end component;          
signal Instructions, Immediate : STD_LOGIC_VECTOR(31 downto 0);
signal IMM_SELECT : STD_LOGIC_VECTOR(2 downto 0);

begin

uut: ImmediateGenerator port map(
    Instructions => Instructions,
    IMM_SELECT => IMM_SELECT,
    Immediate => Immediate
    );

InstructionDecoder: entity work.InstructionDecoder port map(
                    Instructions => Instructions,
                    IMM_SELECT => IMM_SELECT
                    );




stim_proc:process begin

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
