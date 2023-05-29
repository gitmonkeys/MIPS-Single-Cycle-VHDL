library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity ALUPlus4 is
    Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           PCPlus4 : out STD_LOGIC_VECTOR (31 downto 0)
           );
end ALUPlus4;

architecture Behavioral of ALUPlus4 is

begin
PCPlus4 <= A + x"00000001";

end Behavioral;
