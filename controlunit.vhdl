
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controlunit is
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
           
end controlunit;

architecture Behavioral of controlunit is
component maindecoder
    Port  (Opcode : in STD_LOGIC_VECTOR (5 downto 0);
           MemtoReg : out STD_LOGIC;
           MemWrite : out STD_LOGIC;
           Branch : out STD_LOGIC;
           ALUSrc : out STD_LOGIC;
           RegDst : out STD_LOGIC;
           RegWrite : out STD_LOGIC;
           Jump : out STD_LOGIC;
           ALUOp : out STD_LOGIC_VECTOR (1 downto 0)
           );
end component;

component aludecoder
    Port (Funct : in STD_LOGIC_VECTOR (5 downto 0);
          ALUOp: in STD_LOGIC_VECTOR (1 downto 0);
          ALUControl : out STD_LOGIC_VECTOR (2 downto 0)
          );
end component;
signal opout : STD_LOGIC_VECTOR (1 downto 0);

begin

maindecoder1: maindecoder port map (ALUOp => opout, Opcode  => ins (31 downto 26), MemtoReg => MemtoReg, MemWrite => MemWrite,
                                    Branch => Branch, ALUSrc => ALUSrc, RegDst => RegDst, RegWrite => RegWrite, Jump => Jump
                                     );
aludecoder1: aludecoder port map (ALUop => opout, Funct => ins (5 downto 0), ALUControl => ALUControl);
end Behavioral;
