library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;


entity RegFileC is
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
end RegFileC;

architecture Behavioral of RegFileC is

type reg_file is array (31 downto 0) of STD_LOGIC_VECTOR (31 downto 0);
signal mem : reg_file:=(x"00000031", x"00000030", x"00000029", x"00000028", x"00000027", x"00000026", x"00000025",
                        x"00000024", x"00000023", x"00000022", x"00000021", x"00000020", x"00000019", x"00000018",
                        x"00000017", x"00000016", x"00000015", x"00000014", x"00000013", x"00000012", x"00000011",
                        x"00000010", x"00000009", x"00000008", x"00000007", x"00000006", x"00000005", x"00000004",
                        x"00000003", x"00000002", x"00000001", x"00000000");
begin
	process(CLK)
	begin
		if(clk'event and clk= '1') then
				if (WE3 = '1') then
					mem(to_integer(unsigned(A3))) <= WD3;
				end if;
		end if;
		end process;
RD1 <= mem(to_integer(unsigned(A1)));
RD2 <= mem(to_integer(unsigned(A2)));

end Behavioral;
