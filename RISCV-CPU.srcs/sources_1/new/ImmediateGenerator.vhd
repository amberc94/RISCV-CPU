
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity ImmediateGenerator is
  Generic(
         constant R_TYPE : STD_LOGIC_VECTOR := "000";
         constant I_TYPE : STD_LOGIC_VECTOR := "001";
         constant S_TYPE : STD_LOGIC_VECTOR := "010";
         constant U_TYPE : STD_LOGIC_VECTOR := "011";
         constant B_TYPE : STD_LOGIC_VECTOR := "100";
         constant J_TYPE : STD_LOGIC_VECTOR := "101"
         );
  Port ( Instructions : in STD_LOGIC_VECTOR(31 downto 0);
         IMM_SELECT   : in STD_LOGIC_VECTOR(2 downto 0);
         Immediate    : out STD_LOGIC_VECTOR(31 downto 0)
         );
end ImmediateGenerator;

architecture Behavioral of ImmediateGenerator is

begin

process(IMM_SELECT, Instructions) begin
    case IMM_SELECT is
        when R_TYPE =>
            Immediate <= x"00000000";
        when I_TYPE =>
            for i in 31 downto 11 loop
                Immediate(i) <= Instructions(31);
            end loop;
            Immediate(10 downto 0) <= Instructions(30 downto 20);
            
        when S_TYPE =>
            for i in 31 downto 11 loop
                Immediate(i) <= Instructions(31);
            end loop;
            Immediate(10 downto 5) <= Instructions(30 downto 25);
            Immediate(4 downto 1) <= Instructions (11 downto 8);
            Immediate(0) <= Instructions(7);
        
        when U_TYPE =>
            Immediate <= Instructions;
            for i in 11 downto 0 loop
                Immediate(i) <= '0';
            end loop;
                   
        when B_TYPE =>
            for i in 31 downto 12 loop
                Immediate(i) <= Instructions(31);
            end loop;
            Immediate(11) <= Instructions(7);
            Immediate(10 downto 5) <= Instructions(30 downto 25);
            Immediate(4 downto 1) <= Instructions (11 downto 8);
            Immediate(0) <= '0';
        when J_TYPE =>
            for i in 31 downto 20 loop
                Immediate(i) <= Instructions(31);
            end loop;
            Immediate(19 downto 12) <= Instructions(19 downto 12);
            Immediate(11) <= Instructions(20);
            Immediate(10 downto 1) <= Instructions(30 downto 21);
            Immediate(0) <= '0';
        when others =>
            Immediate <= x"00000000";
    end case;
end process;
end Behavioral;
