
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
         ZR             : out STD_LOGIC; -- 0 = the result is not zero (aka they are not the same)
         NG             : out STD_LOGIC; -- 0 = positive, 1 = negative
         GT             : out STD_LOGIC -- 0 = a < b, 1 = a > b
       );
end ALU;

architecture Behavioral of ALU is

begin

process(A,B,SIGN,ALU_CONTROL)

variable B_INT : integer:= 0;
variable SHIFT_BUFFER : STD_LOGIC_VECTOR(31 downto 0);
begin
case ALU_CONTROL is 
    when ALU_ADD =>
        ALU_RESULT <= std_logic_vector(signed(A) + signed(B));
    when ALU_SUB =>
        if(sign = '1') then
            ALU_RESULT <= std_logic_vector(signed(A) - signed(B));
            if(signed(A) >= signed(B)) then
                GT <= '1';
            else
                GT <= '0';
            end if;
        else
            ALU_RESULT <= std_logic_vector(unsigned(A) - unsigned(B));
            if(unsigned(A) >= unsigned(B)) then
                GT <= '1';
            else
                GT <= '0';
            end if;
        end if;
    when ALU_XOR =>
        ALU_RESULT <= (A XOR B);
    when ALU_AND =>
        ALU_RESULT <= (A AND B);
    when ALU_OR =>
        ALU_RESULT <= (A OR B);
    when ALU_SLT =>
        if sign = '1' then
           if(signed(A) < signed(B)) then
                ALU_RESULT <= x"00000001";
            else
                ALU_RESULT <= x"00000000";
            end if;
        else 
            if(unsigned(A) < unsigned(B)) then
                ALU_RESULT <= x"00000001";
            else
                ALU_RESULT <= x"00000000";
            end if;
        end if;
     -- we only ever care about shifting by up to 32, so just pull the bottom 5 bits (0 - 63 possible shifts)
     when ALU_SLL =>
        ALU_RESULT <= std_logic_vector(shift_left(unsigned(A),to_integer(unsigned(B(4 downto 0)))));
     when ALU_SRL =>
        ALU_RESULT <= std_logic_vector(shift_right(unsigned(A),to_integer(unsigned(B(4 downto 0)))));
     when ALU_SRA =>
         ALU_RESULT <= std_logic_vector(shift_right(signed(A), to_integer(unsigned(B(4 downto 0)))));
     when others =>
        ALU_RESULT <= x"00000000";
 end case;
end process;

ZR <=
    '1' when (signed(ALU_RESULT) = 0) else
    '0';
NG <=
    '1' when (signed(ALU_RESULT) < 0) else
    '0';
     
end Behavioral;
