
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
use work.config_pkg.all;
use work.all;

entity Reg_File is
  Port ( DATA_IN    : in STD_LOGIC_VECTOR(31 downto 0);
         RS1_OUT    : out STD_LOGIC_VECTOR(31 downto 0);
         RS2_OUT    : out STD_LOGIC_VECTOR(31 downto 0);
         RS1_ADDR   : in STD_LOGIC_VECTOR(4 downto 0);
         RS2_ADDR   : in STD_LOGIC_VECTOR(4 downto 0);
         WRITE      : in STD_LOGIC;
         WRITE_ADDR : in STD_LOGIC_VECTOR(4 downto 0);
         CLK        : in STD_LOGIC;
         RESET      : in STD_LOGIC;
         DUMP_REG   : out STD_LOGIC_VECTOR(31 downto 0)          --temp way to dump our x1 reg values in the testbench for testing verification
       );
end Reg_File;


architecture Behavioral of Reg_File is
type t_REG_BUFFER is array (0 to 31) of std_logic_vector(31 downto 0);
signal IN_BUFFER    : STD_LOGIC_VECTOR(31 downto 0);
signal OUT_BUFFER   : t_reg_buffer;
signal WRITE_FLAG   : STD_LOGIC_VECTOR(31 downto 0) := x"00000000";

begin


X0: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(0), CLK => CLK, RESET => '0', WRITE => WRITE_FLAG(0));
X1: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(1), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(1));
X2: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(2), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(2));
X3: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(3), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(3));
X4: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(4), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(4));
X5: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(5), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(5));
X6: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(6), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(6));
X7: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(7), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(7));
X8: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(8), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(8));
X9: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(9), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(9));
X10: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(10), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(10));
X11: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(11), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(11));
X12: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(12), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(12));
X13: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(13), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(13));
X14: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(14), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(14));
X15: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(15), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(15));
X16: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(16), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(16));
X17: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(17), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(17));
X18: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(18), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(18));
X19: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(19), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(19));
X20: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(20), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(20));
X21: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(21), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(21));
X22: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(22), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(22));
X23: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(23), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(23));
X24: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(24), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(24));
X25: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(25), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(25));
X26: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(26), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(26));
X27: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(27), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(27));
X28: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(28), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(28));
X29: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(29), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(29));
X30: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(30), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(30));
X31: entity work.Reg_32bit port map(REG_IN => IN_BUFFER, REG_OUT => OUT_BUFFER(31), CLK => CLK, RESET => RESET, WRITE => WRITE_FLAG(31));
     
RS1_OUT <= OUT_BUFFER(to_integer(unsigned(RS1_ADDR)));
RS2_OUT <= OUT_BUFFER(to_integer(unsigned(RS2_ADDR)));
IN_BUFFER <= DATA_IN;
DUMP_REG <= OUT_BUFFER(1);
process(WRITE, CLK, WRITE_ADDR) begin
    if(WRITE = '1') then
        WRITE_FLAG <= x"00000000";
        WRITE_FLAG(to_integer(unsigned(WRITE_ADDR))) <= '1';
    elsif(WRITE = '0') then
        WRITE_FLAG <= x"00000000";
    end if;
end process;



end Behavioral;
