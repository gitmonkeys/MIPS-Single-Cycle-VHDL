library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;

entity PC is
    Port (CLK : in STD_LOGIC;
          reset: IN STD_LOGIC;
          PCIN: IN STD_LOGIC_VECTOR (31 downto 0);
          PCOUT: OUT STD_LOGIC_VECTOR (31 downto 0)
        );
end PC;

architecture Behavioral of PC is

begin
process (CLK, reset)
begin
   if reset = '1' then
    PCOUT <= (others => '0');
  elsif clk'event and CLK = '1' then
    PCOUT <= PCIN;
   end if;

end process;   
end Behavioral;
