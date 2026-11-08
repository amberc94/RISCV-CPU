
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
library UNISIM;
use UNISIM.vcomponents.all;
library work;
use work.all;
use work.config_pkg.all;

-- our ram will be using 16 x 256B blocks for 4kb
-- of our 32bit address, bits 9 to 6 will we used to select the block and  5 to 0 will be used in the block
-- 



entity Block4kb is
    Port (
        CLK     : in STD_LOGIC;
        WRITE   : in STD_LOGIC;
        ADDRESS : in STD_LOGIC_VECTOR(31 downto 0);
        DATA_IN : in STD_LOGIC_VECTOR(31 downto 0);
        WRITE_MASK  : in STD_LOGIC_VECTOR(31 downto 0);
        DATA_OUT: out STD_LOGIC_VECTOR(31 downto 0)
         );
end Block4kb;

architecture Behavioral of Block4kb is

signal BLOCK_ADD    : STD_LOGIC_VECTOR(5 downto 0);
signal TOP_ADD      : STD_LOGIC_VECTOR(3 downto 0);
signal WRITE_FLAG   : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
type t_RAM_BUFFER is array (0 to 15) of std_logic_vector(31 downto 0);
signal OUT_BUFFER   : t_RAM_BUFFER;
signal WRITE_BUFFER : STD_LOGIC_VECTOR(31 downto 0);


begin

BLOCK_ADD <= ADDRESS(5 downto 0);
TOP_ADD <= ADDRESS(9 downto 6);

x0: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(0), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(0), WRITE_MASK=>WRITE_MASK);
x1: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(1), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(1), WRITE_MASK=>WRITE_MASK);
x2: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(2), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(2), WRITE_MASK=>WRITE_MASK);
x3: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(3), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(3), WRITE_MASK=>WRITE_MASK);
x4: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(4), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(4), WRITE_MASK=>WRITE_MASK);
x5: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(5), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(5), WRITE_MASK=>WRITE_MASK);
x6: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(6), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(6), WRITE_MASK=>WRITE_MASK);
x7: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(7), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(7), WRITE_MASK=>WRITE_MASK);
x8: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(8), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(8), WRITE_MASK=>WRITE_MASK);
x9: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(9), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(9), WRITE_MASK=>WRITE_MASK);
x10: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(10), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(10), WRITE_MASK=>WRITE_MASK);
x11: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(11), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(11), WRITE_MASK=>WRITE_MASK);
x12: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(12), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(12), WRITE_MASK=>WRITE_MASK);
x13: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(13), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(13), WRITE_MASK=>WRITE_MASK);
x14: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(14), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(14), WRITE_MASK=>WRITE_MASK);
x15: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(15), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(15), WRITE_MASK=>WRITE_MASK);

DATA_OUT <= OUT_BUFFER(to_integer(unsigned(TOP_ADD)));
WRITE_BUFFER <= DATA_IN;

WRITE_FLAG <=
    x"0001" when unsigned(TOP_ADD) = 0 else
    x"0002" when unsigned(TOP_ADD) = 1 else 
    x"0004" when unsigned(TOP_ADD) = 2 else
    x"0008" when unsigned(TOP_ADD) = 3 else 
    x"0010" when unsigned(TOP_ADD) = 4 else
    x"0020" when unsigned(TOP_ADD) = 5 else 
    x"0040" when unsigned(TOP_ADD) = 6 else
    x"0080" when unsigned(TOP_ADD) = 7 else
    x"0100" when unsigned(TOP_ADD) = 8 else
    x"0200" when unsigned(TOP_ADD) = 9 else 
    x"0400" when unsigned(TOP_ADD) = 10 else
    x"0800" when unsigned(TOP_ADD) = 11 else 
    x"1000" when unsigned(TOP_ADD) = 12 else
    x"2000" when unsigned(TOP_ADD) = 13 else 
    x"4000" when unsigned(TOP_ADD) = 14 else
    x"8000" when unsigned(TOP_ADD) = 15 else
    x"0000";
    
end Behavioral;
