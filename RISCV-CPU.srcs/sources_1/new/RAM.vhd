
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

signal BLOCK_ADD    : STD_LOGIC_VECTOR(5 downto 0);
signal TOP_ADD      : STD_LOGIC_VECTOR(3 downto 0);
signal WRITE_FLAG   : STD_LOGIC_VECTOR(15 downto 0) := x"0000";
type t_RAM_BUFFER is array (0 to 15) of std_logic_vector(31 downto 0);
signal OUT_BUFFER   : t_RAM_BUFFER;
signal WRITE_BUFFER : STD_LOGIC_VECTOR(31 downto 0);
signal SIGN_BIT     : STD_LOGIC;


begin

BLOCK_ADD <= ADDRESS(5 downto 0);
TOP_ADD <= ADDRESS(9 downto 6);

x0: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(0), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(0));
x1: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(1), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(1));
x2: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(2), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(2));
x3: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(3), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(3));
x4: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(4), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(4));
x5: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(5), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(5));
x6: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(6), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(6));
x7: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(7), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(7));
x8: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(8), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(8));
x9: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(9), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(9));
x10: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(10), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(10));
x11: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(11), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(11));
x12: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(12), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(12));
x13: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(13), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(13));
x14: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(14), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(14));
x15: entity work.Block256 port map(CLK=>CLK, WRITE=>WRITE_FLAG(15), ADDRESS=>BLOCK_ADD, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(15));


process(ADDRESS, WIDTH) begin
    case WIDTH is
        when "010" => -- lw, sw
            DATA_OUT <= OUT_BUFFER(to_integer(unsigned(TOP_ADD)));
            WRITE_BUFFER <= DATA_IN;
        when "001" => -- lh, sh
            DATA_OUT <= OUT_BUFFER(to_integer(unsigned(TOP_ADD)));
            SIGN_BIT <= OUT_BUFFER(to_integer(unsigned(TOP_ADD)))(31); 
            for i in 31 downto 16 loop
                DATA_OUT(i) <= SIGN_BIT;
            end loop;
            WRITE_BUFFER <= OUT_BUFFER(to_integer(unsigned(TOP_ADD)));
            WRITE_BUFFER(15 downto 0) <= DATA_IN(15 downto 0);
        when "000" => --lb, sb
            DATA_OUT <= OUT_BUFFER(to_integer(unsigned(TOP_ADD)));
            SIGN_BIT <= OUT_BUFFER(to_integer(unsigned(TOP_ADD)))(31);
            for i in 31 downto 8 loop
                DATA_OUT(i) <= SIGN_BIT;
            end loop;
            WRITE_BUFFER <= OUT_BUFFER(to_integer(unsigned(TOP_ADD)));
            WRITE_BUFFER(7 downto 0) <= DATA_IN(7 downto 0);
        when "100" => -- lbu
            DATA_OUT <= OUT_BUFFER(to_integer(unsigned(TOP_ADD)));
            SIGN_BIT <= '0';
            for i in 31 downto 8 loop
                DATA_OUT(i) <= SIGN_BIT;
            end loop;
        when "101" => -- lhu
            DATA_OUT <= OUT_BUFFER(to_integer(unsigned(TOP_ADD)));
            SIGN_BIT <= '0';
            for i in 31 downto 16 loop
                DATA_OUT(i) <= SIGN_BIT;
            end loop;
        when others =>
            DATA_OUT <= OUT_BUFFER(to_integer(unsigned(TOP_ADD)));
            WRITE_BUFFER <= DATA_IN;
       end case;
 end process;
       
process(WRITE, CLK, ADDRESS) begin
    if(WRITE = '1') then
        WRITE_FLAG <= x"0000";
        WRITE_FLAG(to_integer(unsigned(TOP_ADD))) <= '1';
    elsif(WRITE = '0') then
        WRITE_FLAG <= x"0000";
    end if;
end process;

end Behavioral;
