entity multiplexer32b is
      Port ( A : in STD_LOGIC_VECTOR (31 downto 0);
           B : in STD_LOGIC_VECTOR (31 downto 0);
           SEL: in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (31 downto 0));
end multiplexer32b;

architecture Behavioral of multiplexer32b is

begin
Y <= A when SEL = '0' else B;

end Behavioral;
  
