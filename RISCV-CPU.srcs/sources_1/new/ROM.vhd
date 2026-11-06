library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity ROM is
  Port ( 
        ADDRESS     : in STD_LOGIC_VECTOR(31 downto 0);
        DATA_OUT    : out STD_LOGIC_VECTOR(31 downto 0)
        );
end ROM;

architecture Behavioral of ROM is
type t_ROM_BUFFER is array (0 to 256) of std_logic_vector(31 downto 0);
signal ROM_BUFFER : t_ROM_BUFFER;
begin

 -- lw
            ROM_BUFFER(0) <= x"0000a103";
                        
            -- addi
            ROM_BUFFER(1) <= x"3e800093";
                        
            --auipc
            ROM_BUFFER(2) <= x"00000097";
                        
            --sw
            ROM_BUFFER(3) <= x"0020a023";
                        
            --add
            ROM_BUFFER(4) <= x"003100b3";
                        
            --lui
            ROM_BUFFER(5) <= x"000000b7";
                        
            --beq
            ROM_BUFFER(6) <= x"00008063";
            
            
            --jalr
            ROM_BUFFER(7) <= x"000100e7";
            
            
            --jal
            ROM_BUFFER(8) <= x"000000ef";
                        
            --ECALL
            ROM_BUFFER(9) <= x"00000073";
            
            DATA_OUT <= ROM_BUFFER(to_integer(unsigned(ADDRESS)));
            


end Behavioral;
