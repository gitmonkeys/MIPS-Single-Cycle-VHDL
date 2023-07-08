entity multiplexer2to1 is
    Port ( A : in STD_LOGIC_VECTOR (4 downto 0);
           B : in STD_LOGIC_VECTOR (4 downto 0);
           SEL : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (4 downto 0));
end multiplexer2to1;

architecture Behavioral of multiplexer2to1 is

begin
Y <= A when SEL = '0' else B;

end Behavioral;
