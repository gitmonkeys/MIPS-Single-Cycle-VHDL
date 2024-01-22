library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity instructionmemory is
  port (PC : in STD_LOGIC_VECTOR (31 downto 0);
        ins : out STD_LOGIC_VECTOR (31 downto 0);
end instructionmemory;

architecture Behavioral of instructionmemory is
        type IM is array (0 to 9) of STD_LOGIC_VECTOR (31 downto 0); --user-defined 9 instructions in 32-bit architecture
        signal mem : IM:=(x"214a0002", --addi $t2, $t2, 2
                          x"02328020", --add $s0, $s1, $s2
                          x"016D4022", --sub $s0, $t3, $t5
                          x"8c130001", --lw $s3, 1
                          x"200c0000", -- addi $t4, $0, 0
                          x"200d0005", -- addi $t5, $0, 5
                          x"ac020004", -- sw $2, 4($0)
                          x"118d0002", -- beq $t4, $t5, end
                          x"218c0001", -- addi $t4, $t4, 1
                          x"80000006" -- j label
                          );       

  begin
    ins <= mem(to_integer(unsigned(PC)));

  end behavioral;
