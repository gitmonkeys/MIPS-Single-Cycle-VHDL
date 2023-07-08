library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity SignExtend is
    Port ( A: in STD_LOGIC_VECTOR (15 downto 0);
           EX_OUT: out STD_LOGIC_VECTOR (31 downto 0));
end SignExtend;

architecture Behavioral of SignExtend is

begin
EX_OUT <= x"0000" & A when A(15) = '0' else x"ffff" & A;

end Behavioral;

