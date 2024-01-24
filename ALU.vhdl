library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU is 
  port (A : in STD_LOGIC_VECTOR (31 downto 0);
        B : in STD_LOGIC_VECTOR (31 downto 0);
        ALUcontrol : in STD_LOGIC_VECTOR (2 downto 0);
        ALUresult : out STD_LOGIC_VECTOR (31 downto 0);
        zero : out STD_LOGIC);
  end ALU;

  architecture Behavioral of ALU is
    signal tmp : STD_LOGIC_VECTOR (31 downto 0);

begin
  process (A, B, ALUcontrol);

begin
  case 
