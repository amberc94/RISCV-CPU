library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use std.textio.all;
use work.all;

entity ROM is
  Port ( 
        ADDRESS     : in STD_LOGIC_VECTOR(31 downto 0);
        DATA_OUT    : out STD_LOGIC_VECTOR(31 downto 0)
        );
end ROM;

architecture Behavioral of ROM is

-- i stole all this code from vhdlwhiz to be perfectly honest

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

constant ROM_DEPTH : natural := 1024;
constant ROM_WIDTH : natural := 32;

type ROM_TYPE is array (0 to ROM_DEPTH -1) of STD_LOGIC_VECTOR(ROM_WIDTH -1 downto 0);

impure function init_rom_hex return rom_type is
  file text_file : text open read_mode is "ROM.txt";
  variable text_line : line;
  variable rom_content : rom_type;
begin
  for i in 0 to rom_depth - 1 loop
    readline(text_file, text_line);
    hread(text_line, rom_content(i));
  end loop;
  
  return rom_content;
end function;

signal ROM_HEX : ROM_TYPE := init_rom_hex;

begin

    DATA_OUT <= ROM_HEX( to_integer(unsigned(ADDRESS)));   

end Behavioral;
