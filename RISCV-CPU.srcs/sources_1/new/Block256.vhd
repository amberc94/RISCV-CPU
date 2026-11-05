-- 256 Byte block of RAM using RAM64X1S primitives
-- each is 64 bits deep and we stack 32 wide


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.vcomponents.all;
library work;
use work.all;
use work.config_pkg.all;




entity Block256 is
    Port ( CLK      : in STD_LOGIC;
           ADDRESS  : in STD_LOGIC_VECTOR(5 downto 0);
           DATA_IN  : in STD_LOGIC_VECTOR(31 downto 0);
           WRITE    : in STD_LOGIC;
           DATA_OUT : out STD_LOGIC_VECTOR(31 downto 0)
         );
end Block256;

architecture Behavioral of Block256 is

begin

x0 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(0),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(0),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x1 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(1),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(1),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x2 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(2),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(2),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);


x3 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(3),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(3),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x4 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(4),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(4),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x5 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(5),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(5),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x6 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(6),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(6),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x7 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(7),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(7),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x8: RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(8),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(8),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x9 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(9),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(9),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x10 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(10),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(10),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);


x11 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(11),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(11),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x12 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(12),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(12),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE      -- Write enable input
);

x13 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(13),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(13),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x14 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(14),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(14),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x15 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(15),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(15),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x16 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(16),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(16),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x17 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(17),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(17),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x18 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(18),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(18),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);


x19 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(19),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(19),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x20 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(20),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(20),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x21 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(21),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(21),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x22 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(22),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(22),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x23 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(23),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(23),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x24 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(24),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(24),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x25 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(25),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(25),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x26 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(26),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(26),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);


x27 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(27),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(27),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x28 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(28),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(28),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x29 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(29),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(29),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x30 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(30),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(30),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);

x31 : RAM64X1S 
generic map (INIT => X"0000000000000000")
port map (
   O => DATA_OUT(31),        -- 1-bit data output
   A0 => ADDRESS(0),      -- Address[0] input bit
   A1 => ADDRESS(1),      -- Address[1] input bit
   A2 => ADDRESS(2),      -- Address[2] input bit
   A3 => ADDRESS(3),      -- Address[3] input bit
   A4 => ADDRESS(4),      -- Address[4] input bit
   A5 => ADDRESS(5),      -- Address[5] input bit
   D => DATA_IN(31),        -- 1-bit data input
   WCLK => CLK,  -- Write clock input
   WE => WRITE       -- Write enable input
);




end Behavioral;
