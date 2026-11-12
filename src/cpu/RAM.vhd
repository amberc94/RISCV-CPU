
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;
library UNISIM;
use UNISIM.vcomponents.all;
library work;
use work.all;
use work.config_pkg.all;
use std.textio.all;
use ieee.std_logic_textio.all;


-- our ram will be using 8 x 16 x 256B blocks for 32kb
-- of our 32bit address, bits 12 to 10 will select the 4kb block
-- bits 9 to 6 will we used to select the 256-byte block
--  5 to 0 will be used in the block
-- 

entity RAM is
    Port (
        CLK     : in STD_LOGIC;
        WRITE   : in STD_LOGIC;
        READ_FLAG : in STD_LOGIC;
        BYTE_ADD : in STD_LOGIC_VECTOR(31 downto 0);
        WIDTH    : in STD_LOGIC_VECTOR(2 downto 0);
        DATA_IN : in STD_LOGIC_VECTOR(31 downto 0);
        DATA_OUT: out STD_LOGIC_VECTOR(31 downto 0)
         );
end RAM;

architecture Behavioral of RAM is

procedure hread(l: inout line; value: out std_logic_vector) is
  variable c : character;
  variable ok : boolean;
  variable i : integer := 0;
  variable hex_val : std_logic_vector(3 downto 0);
begin
  while i < value'high loop
    read(l, c);
    
    case c is
      when '0' => hex_val := "0000";
      when '1' => hex_val := "0001";
      when '2' => hex_val := "0010";
      when '3' => hex_val := "0011";
      when '4' => hex_val := "0100";
      when '5' => hex_val := "0101";
      when '6' => hex_val := "0110";
      when '7' => hex_val := "0111";
      when '8' => hex_val := "1000";
      when '9' => hex_val := "1001";
      when 'A' | 'a' => hex_val := "1010";
      when 'B' | 'b' => hex_val := "1011";
      when 'C' | 'c' => hex_val := "1100";
      when 'D' | 'd' => hex_val := "1101";
      when 'E' | 'e' => hex_val := "1110";
      when 'F' | 'f' => hex_val := "1111";
    
      when others =>
        hex_val := "XXXX";
        assert false report "Found non-hex character '" & c & "'";
    end case;
    
    value(value'high - i downto value'high - i - 3) := hex_val;
    i := i + 4;
  end loop;
end procedure;

constant RAM_DEPTH : natural := 400 * 1024; -- 256kb (64k words)
constant RAM_WIDTH : natural := 8;

type RAM_TYPE is array (0 to RAM_DEPTH -1) of STD_LOGIC_VECTOR(RAM_WIDTH -1 downto 0);

impure function init_ram_hex return ram_type is
  file text_file : text open read_mode is "ROM.txt";
  variable text_line : line;
  variable ram_content : ram_type;
begin
  for i in 0 to ram_depth - 1 loop
    if not endfile(text_file) then
        readline(text_file, text_line);
        hread(text_line, ram_content(i));
    else
        ram_content(i) := x"00";
    end if;
  end loop;
  
  return ram_content;
end function;

signal SRAM : RAM_TYPE := init_ram_hex;
--signal ADDRESS : STD_LOGIC_VECTOR(31 downto 0);
signal WRITE_MASK : STD_LOGIC_VECTOR(31 downto 0);

begin

WRITE_MASK <=
    x"0000FFFF" when WIDTH = "001" or WIDTH = "101" else -- half
    x"000000FF" when WIDTH = "000" or WIDTH = "100" else -- byte
    x"FFFFFFFF";


process (BYTE_ADD, WIDTH) is 
   variable ADDRESS : integer;
   variable READ_BUFFER : STD_LOGIC_VECTOR(31 downto 0);
    begin
    ADDRESS := to_integer(unsigned(BYTE_ADD(30 downto 0)));
    if(ADDRESS > SRAM'length -1) then
        ADDRESS := 0;
    end if;
    case WIDTH is
        when "001" => READ_BUFFER (15 downto 8) := SRAM(ADDRESS);
                      READ_BUFFER (7 downto 0) := SRAM(ADDRESS+1);
                      READ_BUFFER (31 downto 16) := (others => READ_BUFFER(15));
        
        when "101" => READ_BUFFER (15 downto 8) := SRAM(ADDRESS);
                      READ_BUFFER (7 downto 0) := SRAM(ADDRESS+1);
                      READ_BUFFER (31 downto 16) := (others => '0');
                      
        when "000" => READ_BUFFER (7 downto 0) := SRAM(ADDRESS);
                      READ_BUFFER (31 downto 8) := (others => READ_BUFFER(7));
                      
        when "100" => READ_BUFFER (7 downto 0) := SRAM(ADDRESS);
                      READ_BUFFER (31 downto 8) := (others => '0');
        
        when others => READ_BUFFER(31 downto 24) := SRAM(ADDRESS);
                       READ_BUFFER(23 downto 16) := SRAM(ADDRESS+1);
                       READ_BUFFER(15 downto 8) := SRAM(ADDRESS+2);
                       READ_BUFFER(7 downto 0) := SRAM(ADDRESS+3);
    end case;
    DATA_OUT <= READ_BUFFER;
end process;



process(CLK, WRITE, WRITE_MASK) is
    variable ADDRESS : integer;
    begin
    ADDRESS := to_integer(unsigned(BYTE_ADD(30 downto 0)));
    if(ADDRESS > SRAM'length or ADDRESS < 0) then
        ADDRESS := 0;
    end if;
    if (WRITE = '1' and rising_edge(CLK)) then
        case WRITE_MASK is
            when x"000000FF" => SRAM(ADDRESS) <= DATA_IN(7 downto 0);
            when x"0000FFFF" => SRAM(ADDRESS) <= DATA_IN(15 downto 8); 
                                SRAM(ADDRESS+1) <= DATA_IN(7 downto 0);
            when x"FFFFFFFF" => SRAM(ADDRESS) <= DATA_IN(31 downto 24); 
                                SRAM(ADDRESS+1) <= DATA_IN(23 downto 16); 
                                SRAM(ADDRESS+2) <= DATA_IN(15 downto 8); 
                                SRAM(ADDRESS+3) <= DATA_IN(7 downto 0);
             when others => --do nothing
        end case;
    end if;
end process;


--signal BLOCK256_ADD    : STD_LOGIC_VECTOR(5 downto 0);
--signal BLOCK4KB_ADD    : STD_LOGIC_VECTOR(3 downto 0);
--signal TOP_ADD         : STD_LOGIC_VECTOR(2 downto 0);
--signal WRITE_FLAG      : STD_LOGIC_VECTOR(7 downto 0) := x"00";
--type t_RAM_BUFFER is array (0 to 15) of std_logic_vector(31 downto 0);
--signal OUT_BUFFER   : t_RAM_BUFFER;
--signal WRITE_BUFFER : STD_LOGIC_VECTOR(31 downto 0);
--signal WRITE_MASK   : STD_LOGIC_VECTOR(31 downto 0) := x"00000000";
--signal ADDRESS     : STD_LOGIC_VECTOR(31 downto 0);
--begin

 --addresses get handed to use as bytes but we use word addressing so divide by 4
--ADDRESS <= std_logic_vector(shift_right(unsigned(BYTE_ADD), 2));

--BLOCK256_ADD <= ADDRESS(5 downto 0);
--BLOCK4KB_ADD <= ADDRESS(9 downto 6);
--TOP_ADD      <= ADDRESS(12 downto 10);

--x0: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(0), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(0), WRITE_MASK=>WRITE_MASK);
--x1: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(1), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(1), WRITE_MASK=>WRITE_MASK);
--x2: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(2), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(2), WRITE_MASK=>WRITE_MASK);
--x3: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(3), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(3), WRITE_MASK=>WRITE_MASK);
--x4: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(4), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(4), WRITE_MASK=>WRITE_MASK);
--x5: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(5), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(5), WRITE_MASK=>WRITE_MASK);
--x6: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(6), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(6), WRITE_MASK=>WRITE_MASK);
--x7: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(7), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(7), WRITE_MASK=>WRITE_MASK);
--x8: entity work.Block4kb port map(CLK=>CLK, WRITE=>WRITE_FLAG(8), ADDRESS=>ADDRESS, DATA_IN=>WRITE_BUFFER, DATA_OUT=>OUT_BUFFER(8), WRITE_MASK=>WRITE_MASK);

--DATA_OUT <= OUT_BUFFER(to_integer(unsigned(TOP_ADD)));
--WRITE_BUFFER <= DATA_IN;

--WRITE_MASK <=
--    x"0000FFFF" when WIDTH = "001" or WIDTH = "101" else -- half
--    x"000000FF" when WIDTH = "000" or WIDTH = "100" else -- byte
--    x"FFFFFFFF";
    
--WRITE_FLAG <=
--    "00000001" when unsigned(TOP_ADD) = 0 else
--    "00000010" when unsigned(TOP_ADD) = 1 else 
--    "00000100" when unsigned(TOP_ADD) = 2 else
--    "00001000" when unsigned(TOP_ADD) = 3 else 
--    "00010000" when unsigned(TOP_ADD) = 4 else
--    "00100000" when unsigned(TOP_ADD) = 5 else 
--    "01000000" when unsigned(TOP_ADD) = 6 else
--    "10000000" when unsigned(TOP_ADD) = 7 else
--    "00000000";

 
       


end Behavioral;
