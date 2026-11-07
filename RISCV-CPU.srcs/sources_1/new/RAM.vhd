
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
library UNISIM;
use UNISIM.vcomponents.all;
library work;
use work.all;
use work.config_pkg.all;

-- our ram will be using 8 x 16 x 256B blocks for 32kb
-- of our 32bit address, bits 12 to 10 will select the 4kb block
-- bits 9 to 6 will we used to select the 256-byte block
--  5 to 0 will be used in the block
-- 



entity RAM is
    Port (
        CLK     : in STD_LOGIC;
        WRITE   : in STD_LOGIC;
        ADDRESS : in STD_LOGIC_VECTOR(31 downto 0);
        WIDTH    : in STD_LOGIC_VECTOR(2 downto 0);
        DATA_IN : in STD_LOGIC_VECTOR(31 downto 0);
        DATA_OUT: out STD_LOGIC_VECTOR(31 downto 0)
         );
end RAM;

architecture Behavioral of RAM is

signal BLOCK256_ADD    : STD_LOGIC_VECTOR(5 downto 0);
signal BLOCK4KB_ADD    : STD_LOGIC_VECTOR(3 downto 0);
signal TOP_ADD         : STD_LOGIC_VECTOR(2 downto 0);
signal WRITE_FLAG      : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
type t_RAM_BUFFER is array (0 to 15) of std_logic_vector(31 downto 0);
signal OUT_BUFFER   : t_RAM_BUFFER;
signal WRITE_BUFFER : STD_LOGIC_VECTOR(31 downto 0);
signal WRITE_MASK   : STD_LOGIC_VECTOR(31 downto 0);

begin

BLOCK256_ADD <= ADDRESS(5 downto 0);
BLOCK4KB_ADD <= ADDRESS(9 downto 6);
TOP_ADD      <= ADDRESS(12 downto 10);

x0: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(0), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(0), WRITE_MASK=>WRITE_MASK);
x1: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(1), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(1), WRITE_MASK=>WRITE_MASK);
x2: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(2), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(2), WRITE_MASK=>WRITE_MASK);
x3: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(3), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(3), WRITE_MASK=>WRITE_MASK);
x4: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(4), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(4), WRITE_MASK=>WRITE_MASK);
x5: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(5), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(5), WRITE_MASK=>WRITE_MASK);
x6: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(6), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(6), WRITE_MASK=>WRITE_MASK);
x7: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(7), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(7), WRITE_MASK=>WRITE_MASK);
x8: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(8), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(8), WRITE_MASK=>WRITE_MASK);

DATA_OUT <= OUT_BUFFER(to_integer(unsigned(TOP_ADD)));
WRITE_BUFFER <= DATA_IN;

WRITE_MASK <=
    x"0000FFFF" when WIDTH = "001" or WIDTH = "101" else -- half
    x"000000FF" when WIDTH = "000" or WIDTH = "100" else -- byte
    x"FFFFFFFF";
       
process(WRITE, ADDRESS, CLK) begin
    if(WRITE = '1') then
        WRITE_FLAG <= x"0000";
        WRITE_FLAG(to_integer(unsigned(ADDRESS(9 downto 6)))) <= '1';
    elsif(WRITE = '0') then
        WRITE_FLAG <= x"0000";
    end if;
end process;

end Behavioral;
