
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.config_pkg.all;
use work.all;

entity ALU is
  Port ( A              : in STD_LOGIC_VECTOR(31 downto 0);
         B              : in STD_LOGIC_VECTOR(31 downto 0);
         SIGN           : in STD_LOGIC; -- 0 = unsigned, --1 = signed
         ALU_CONTROL    : in STD_LOGIC_VECTOR(3 downto 0);
         ALU_RESULT     : inout STD_LOGIC_VECTOR(31 downto 0);
         ZR             : out STD_LOGIC;
         NG             : out STD_LOGIC
       );
end ALU;

architecture Behavioral of ALU is
signal SHIFT_BUFFER     : STD_LOGIC_VECTOR(31 downto 0);

begin

process(A,B,SIGN,ALU_CONTROL) begin

case ALU_CONTROL is
    when ALU_ADD =>
        ALU_RESULT <= std_logic_vector(signed(A) + signed(B));
    when ALU_SUB =>
        ALU_RESULT <= std_logic_vector(signed(A) - signed(B));
    when ALU_XOR =>
        ALU_RESULT <= (A XOR B);
    when ALU_AND =>
        ALU_RESULT <= (A AND B);
    when ALU_OR =>
        ALU_RESULT <= (A OR B);
    when ALU_SLT =>
        if sign = '0' then
            SHIFT_BUFFER <= std_logic_vector(signed(A) - signed(B));
        else
            SHIFT_BUFFER <= std_logic_vector(unsigned(A) - unsigned(B));
        end if;
        if(unsigned(SHIFT_BUFFER) < 0) then
            ALU_RESULT <= x"00000001";
        else
            ALU_RESULT <= x"00000000";
        end if;
     when ALU_SLL =>
        ALU_RESULT <= std_logic_vector(shift_left(signed(A),to_integer(signed(B))));
     when ALU_SRL =>
        ALU_RESULT <= std_logic_vector(shift_right(signed(A),to_integer(signed(B))));
     when ALU_SRA =>
         SHIFT_BUFFER <= A;
         for i in 0 to to_integer(unsigned(B)) loop
            SHIFT_BUFFER <= std_logic_vector(shift_right(signed(SHIFT_BUFFER),1));
            SHIFT_BUFFER(31) <= B(31);
         end loop;
         ALU_RESULT <= SHIFT_BUFFER;
 end case;
 
 if(signed(ALU_RESULT) = 0) then
    ZR <= '1';
 else
    ZR <= '0';
end if;

if(signed(ALU_RESULT) < 0) then
    NG <= '1';
else
    NG <= '0';
end if;
 
end process;
end Behavioral;
