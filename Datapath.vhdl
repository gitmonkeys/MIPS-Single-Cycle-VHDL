library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity singlecycle is
    Port (CLK: in STD_LOGIC;
          reset: in STD_LOGIC;
          writedata, dataadr : out STD_LOGIC_VECTOR (31 downto 0);
          ALUCtr : out STD_LOGIC_VECTOR (2 downto 0);
          instr: out STD_LOGIC_VECTOR (31 downto 0);
          BEQ_J : out STD_LOGIC_VECTOR (31 downto 0);
          memwr : out STD_LOGIC              
            );
end singlecycle;

architecture Behavioral of singlecycle is
component PC is
    Port (CLK : in STD_LOGIC;
          reset: IN STD_LOGIC;
          PCIN: IN STD_LOGIC_VECTOR (31 downto 0);
          PCOUT: OUT STD_LOGIC_VECTOR (31 downto 0)
        );
end component;

component ALUPlus4 is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           PCPlus4 : out STD_LOGIC_VECTOR (31 downto 0)
           );
end component;

component instructionmemory is
    Port (PC : in STD_LOGIC_VECTOR (31 downto 0);
          ins : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component controlunit is 
 Port (ins : in STD_LOGIC_VECTOR (31 downto 0);
           MemtoReg : out STD_LOGIC;
           MemWrite : out STD_LOGIC;
           Branch : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           RegDst : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           Jump : out STD_LOGIC;
           ALUControl : out STD_LOGIC_VECTOR (2 downto 0)
   );
end component;

component RegFileC is
    Port (
           RD1 : out STD_LOGIC_VECTOR (31 downto 0);
           RD2 : out STD_LOGIC_VECTOR (31 downto 0);
           CLK : in STD_LOGIC;
           A1 : in STD_LOGIC_VECTOR (4 downto 0);
           A2 : in STD_LOGIC_VECTOR (4 downto 0);
           A3 : in STD_LOGIC_VECTOR (4 downto 0);
           WE3 : in STD_LOGIC;
           WD3 : in STD_LOGIC_VECTOR (31 downto 0)
           );
end component;

component multiplexer2to1 is
    Port ( A : in STD_LOGIC_VECTOR (4 downto 0);
           B : in STD_LOGIC_VECTOR (4 downto 0);
           SEL : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component SignExtend is 
    Port ( A: in STD_LOGIC_VECTOR (15 downto 0);
           EX_OUT: out STD_LOGIC_VECTOR (31 downto 0));
end component;

component ALU is 
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           ALUcontrol : in STD_LOGIC_VECTOR (2 downto 0);
           ALUresult : out STD_LOGIC_VECTOR (31 downto 0);
           zero : out STD_LOGIC);
end component;

component multiplexer32b is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           SEL: in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (31 downto 0));
end component;

component andgate is
    Port ( zero : IN STD_LOGIC;
           branch : IN STD_LOGIC;
           pcsrc : OUT STD_LOGIC);
end component;

component shiftleft is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           Y : out STD_LOGIC_VECTOR (31 downto 0)
           );
end component;

component ALUPCBranch is
    Port ( signimm : in STD_LOGIC_VECTOR (31 downto 0);
           PCPlus4 : in STD_LOGIC_VECTOR (31 downto 0);
           PCBranch : out STD_LOGIC_VECTOR (31 downto 0)
           );
end component;

component DataMemory is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           WD : in STD_LOGIC_VECTOR (31 downto 0);
           CLK : in STD_LOGIC;
           WE :  in STD_LOGIC;
           MemRead : in STD_LOGIC;
           RD : out STD_LOGIC_VECTOR (31 downto 0)
           );
end component;

signal ins, PC_OUT ,RD1_SrcA, RD2, SrcB, WD3_Result, ALU_Result, EX_OUT, PCPlus4, signimm, PCBranch, PC1, PCJ, PC2 : STD_LOGIC_VECTOR (31 downto 0);
signal MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump, zero, pcsrc : STD_LOGIC;
signal ALUControl : STD_LOGIC_VECTOR (2 downto 0);
signal WriteReg : STD_LOGIC_VECTOR (4 downto 0);

begin
MIPS_PC : PC port map ( CLK => CLK,
                        reset => reset,
                        PCIN => PC2,
                        PCOUT => PC_OUT
                        );
                        
MIPS_PCPlus4 : ALUPlus4 port map ( A => PC_OUT,
                                   PCPlus4 => PCPlus4
                                   );                         
                                   
MIPS_IM : instructionmemory port map ( PC => PC_OUT,
                            ins => ins
                            );

MIPS_RegFile : RegFileC port map ( CLK => CLK,                                  
                                   WE3 => RegWrite,
                                   RD1 => RD1_SrcA,
                                   RD2 => RD2,
                                   A1 => ins(25 downto 21),
                                   A2 => ins(20 downto 16),
                                   A3 => WriteReg,
                                   WD3 => WD3_Result
                                   );                 

MIPS_MUX5B : multiplexer2to1 port map (A => ins(20 downto 16),
                                       B => ins(15 downto 11),
                                       SEL => RegDst,
                                       Y => WriteReg
                                       );

MIPS_SignEX : SignExtend  port map ( A => ins(15 downto 0),
                                    EX_OUT => EX_OUT
                                    );
                                    
MIPS_CUnit : controlunit port map ( ins => ins,
                                     MemtoReg => MemtoReg,
                                     MemWrite => MemWrite,
                                     RegWrite => RegWrite,
                                     Branch => Branch,
                                     ALUSrc => ALUSrc,
                                     RegDst => RegDst,
                                     Jump => Jump,
                                     ALUcontrol => ALUcontrol
                                     );
                                     
                                                            
MIPS_MUX_32b_RD2SignImm : multiplexer32b port map ( A => RD2,
                                                    B => EX_OUT,
                                                    SEL => ALUSrc,
                                                    Y => SrcB
                                                    );

MIPS_ALU : ALU port map ( A => RD1_SrcA,
                          B => SrcB,
                          ALUresult => ALU_Result,
                          zero => zero,
                          ALUcontrol => ALUcontrol
                          );

MIPS_BEQ : andgate port map ( zero => zero,
                              branch => branch,
                              pcsrc => pcsrc
                              );    
                              
 MIPS_shiftleft : shiftleft port map ( A => EX_OUT,
                                       Y => signimm
                                       );   
                                       
MIPS_PCBranch : ALUPCBranch port map (signimm => signimm,
                                      PCPlus4 => PCPlus4,
                                      PCBranch => PCBranch
                                      );  
                                      
MIPS_MuxBEQ : multiplexer32b port map (A =>PCPlus4,
                                       B => PCBranch,
                                       SEL => pcsrc,
                                       Y => PC1
                                       );
                                       
MIPS_DataMemory : DataMemory port map (A => ALU_Result,
                                       CLK => CLK,
                                       WD => RD2,
                                       WE => MemWrite,
                                       MemRead => MemtoReg,
                                       RD => WD3_Result
                                       );  
                                         
MIPS_PCJ : multiplexer32b port map (A => PC1, 
                                    B => PCJ,
                                    SEL => Jump,
                                    Y => PC2
                                    );
                                    
PCJ <= PCPlus4 (31 downto 28) & ins (25 downto 0) & "00";   
writedata <= rd2;
dataadr <= ALU_Result;
memwr <= MemWrite;  
ALUCtr <= ALUcontrol;
instr <= ins;  
BEQ_J <= PC2;                                                                                                                                 
end Behavioral;
