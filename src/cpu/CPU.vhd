
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity CPU is
  Port ( CLOCK, RESET, PC_RESET   : in STD_LOGIC;
         DEBUG_OUTPUT             : out STD_LOGIC_VECTOR(31 downto 0);
         EBREAK                   : out STD_LOGIC
        );
end CPU;

architecture Behavioral of CPU is

signal Instructions : STD_LOGIC_VECTOR(31 downto 0);
signal ALU_A        : STD_LOGIC;
signal ALU_B        : STD_LOGIC;
signal ALU_TYPE     : STD_LOGIC_VECTOR(1 downto 0);
signal REG_WRITE    : STD_LOGIC;
signal WB_SELECT    : STD_LOGIC_VECTOR(1 downto 0);
signal MEM_WRITE    : STD_LOGIC;
signal MEM_READ     : STD_LOGIC;
signal JB_SELECT    : STD_LOGIC_VECTOR(1 downto 0);
signal IMM_SELECT   : STD_LOGIC_VECTOR(2 downto 0);
signal RS1          : STD_LOGIC_VECTOR(4 downto 0);
signal RS2          : STD_LOGIC_VECTOR(4 downto 0);
signal RD           : STD_LOGIC_VECTOR(4 downto 0);

signal REG_A_OUT    : STD_LOGIC_VECTOR(31 downto 0);
signal REG_B_OUT    : STD_LOGIC_VECTOR(31 downto 0);
signal DUMP_REG     : STD_LOGIC_VECTOR(31 downto 0);

signal Immediate    : STD_LOGIC_VECTOR(31 downto 0);

signal PC_OUT       : STD_LOGIC_VECTOR(31 downto 0);
signal PC_NEXT      : STD_LOGIC_VECTOR(31 downto 0);
signal PC_4         : STD_LOGIC_VECTOR(31 downto 0);

signal ALU_A_IN     : STD_LOGIC_VECTOR(31 downto 0);
signal ALU_B_IN     : STD_LOGIC_VECTOR(31 downto 0);
signal ALU_OUT      : STD_LOGIC_VECTOR(31 downto 0);
signal ALU_CONTROL  : STD_LOGIC_VECTOR(3 downto 0);
signal ZR           : STD_LOGIC;
signal NG           : STD_LOGIC;
signal SIGN         : STD_LOGIC;

signal BRANCH_TYPE  : STD_LOGIC_VECTOR(2 downto 0);
signal B_LOGIC      : STD_LOGIC;

signal WIDTH        : STD_LOGIC_VECTOR(2 downto 0);
signal MEM_ADDRESS  : STD_LOGIC_VECTOR(31 downto 0);
signal MEM_OUT      : STD_LOGIC_VECTOR(31 downto 0);
signal SLICE_OUT    : STD_LOGIC_VECTOR(31 downto 0);

signal WB_OUT       : STD_LOGIC_VECTOR(31 downto 0);


begin
-- in: 32-bit instructions
-- out: ALU A selector -> ALU
--      ALU B selector -> ALU
--      ALU Type -> ALU
--      Reg Write -> Reg File A, B
--      WB Selector -> WB Mux
--      Mem Write -> RAM
--      Mem Read -> RAM
--      JB Select -> PC next mux
--      IMM select -> Imm Generator     
InstructionDecoder: entity work.InstructionDecoder port map(
    Instructions => Instructions,
    ALU_A => ALU_A,
    ALU_B => ALU_B,
    ALU_TYPE => ALU_TYPE,
    REG_WRITE => REG_WRITE,
    WB_SELECT => WB_SELECT,
    MEM_WRITE => MEM_WRITE,
    MEM_READ => MEM_READ,
    JB_SELECT => JB_SELECT,
    IMM_SELECT => IMM_SELECT,
    RS1 => RS1,
    RS2 => RS2,
    RD => RD,
    EBREAK => EBREAK
    );   

-- in: clock, reset, address, write flag
-- out: data out
--      a -> ALU A input
--      b -> ALU B input
Reg_File: entity work.Reg_File port map(
    CLK => CLOCK,
    RESET => RESET,
    WRITE => REG_WRITE,
    RS1_OUT => REG_A_OUT,
    RS1_ADDR => RS1,
    RS2_OUT => REG_B_OUT,
    RS2_ADDR => RS2,
    WRITE_ADDR => RD,
    DATA_IN => WB_OUT,
    DUMP_REG => DUMP_REG   
    );


-- in: clock, reset, write always set to 1
-- out: data out -> RAM -> Instruction Register -> Instruction Decoder
PC: entity work.Reg_32bit port map(
    CLK => CLOCK,
    RESET => PC_RESET,
    WRITE => '1',
    REG_IN => PC_NEXT,
    REG_OUT => PC_OUT
    );

-- in: instructions, IMM_Select
-- out: Immediate -> ALU, WB MUX, PC next mux
ImmediateGenerator: entity work.ImmediateGenerator port map(
    Instructions => Instructions,
    IMM_SELECT => IMM_SELECT,
    Immediate => Immediate
);

-- in: REG_A, REG_B, PC, IMM, selectors
-- out: ALU_A, ALU_B
ALUMux: entity work.ALUMux port map(
         REG_A_IN => REG_A_OUT,
         PC_IN => PC_OUT,
         REG_B_IN => REG_B_OUT,
         IMM => Immediate,
         A_SEL => ALU_A,
         B_SEL => ALU_B,
         A_OUT => ALU_A_IN,
         B_OUT => ALU_B_IN
);
    

-- in: A input, B input, control bits
-- out: ZR flag, NG flag, computation result
-- will go to WB Mux, Branch logic, 
ALU: entity work.ALU port map(
    A => ALU_A_IN,
    B => ALU_B_IN,
    SIGN => SIGN,
    ALU_CONTROL => ALU_CONTROL,
    ALU_RESULT => ALU_OUT,
    ZR => ZR,
    NG => NG
);

-- in: ALU Type, instructions
-- out ALU control bits -> ALU
funct37: entity work.funct37 port map(
    Instructions => Instructions,
    ALU_TYPE => ALU_TYPE,
    ALU_CONTROL => ALU_CONTROL,
    BRANCH_TYPE => BRANCH_TYPE,
    WIDTH => WIDTH,
    SIGN => SIGN);

-- in: JB Select, ALU output
-- out: PC next load -> PC 
PC_NextMux: entity work.PC_NextMux port map(
    JB_SELECT => JB_SELECT,
    IMM => Immediate,
    PC => PC_OUT,
    ALU_OUT => ALU_OUT,
    B_LOGIC => B_LOGIC,
    PC_NEXT => PC_NEXT,
    PC_4_OUT => PC_4
);

--in: Mem write, mem read, address
--out: data out -> WB_mux
RAM: entity work.RAM port map(
    CLK => CLOCK,
    WRITE => MEM_WRITE,
    READ_FLAG => MEM_READ,
    BYTE_ADD => ALU_OUT,
    WIDTH => WIDTH,
    DATA_IN => REG_B_OUT,
    DATA_OUT => MEM_OUT
    );

-- in: width, mem_out
-- out: slice_out => WB_MEM_IN
DataSlicer : entity work.DataSlicer port map(
    DATA_IN => MEM_OUT,
    WIDTH => WIDTH,
    DATA_OUT => SLICE_OUT
    );

-- in: PC
-- out: instructions
ROM: entity work.ROM port map(
    ADDRESS => PC_OUT,
    DATA_OUT => Instructions
);

-- 010 is the only func3 that doesn't branch so we'll use that as a disable
-- in: Branch Type
-- out: B_Logic
BranchLogic: entity work.BranchLogic port map(
    BRANCH_TYPE => BRANCH_TYPE,
    ZR => ZR,
    NG => NG,
    BRANCH => B_LOGIC
    );
    
 -- in: ALU out, PC+4, Mem out, IMM
 -- out WB_out
 WBMux: entity work.WBMux port map(
    ALU_RESULT => ALU_OUT,
    MEM_READ => SLICE_OUT,
    PC_4 => PC_4,
    IMM => Immediate,
    WB_SELECT => WB_SELECT,
    WB_OUT => WB_OUT
 );
 
 DEBUG_OUTPUT <= DUMP_REG;
 
end Behavioral;
