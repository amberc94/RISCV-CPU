
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use work.config_pkg.all;
use work.all;

entity DataSlicer is
  Port ( 
        DATA_IN     : in STD_LOGIC_VECTOR(31 downto 0);
        WIDTH       : in STD_LOGIC_VECTOR(2 downto 0);
        DATA_OUT    : out STD_LOGIC_VECTOR(31 downto 0)
       );
end DataSlicer;

architecture Behavioral of DataSlicer is

begin

process(DATA_IN, WIDTH)

variable WORK_BUFFER: STD_LOGIC_VECTOR(31 downto 0);
variable SIGN_BIT:    STD_LOGIC;

begin

WORK_BUFFER := DATA_IN;
SIGN_BIT := WORK_BUFFER(31);

case WIDTH is
    when "000" => -- byte
        for i in 31 downto 8 loop
            WORK_BUFFER(i) := SIGN_BIT;
         end loop;
     when "001" => -- half
        for i in 31 downto 16 loop
            WORK_BUFFER(i) := SIGN_BIT;
        end loop;
     when "100" => -- byte unsigned
        for i in 31 downto 8 loop
            WORK_BUFFER(i) := '0';
        end loop;
     when "101" => -- half unsigned
        for i in 31 downto 16 loop
            WORK_BUFFER(i) := '1';
         end loop;
     when others =>
        --do nothing
end case;

DATA_OUT <= WORK_BUFFER; 

end process;           

end Behavioral;
