library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;

entity AUnsigned is
port (	E : in std_logic_vector(10 downto 0);
	PiezaAleatoria : out UNSIGNED;);
end AUnsigned;

architecture Behavioral of AUnsigned is
Begin
	with E select
		PiezaAleatoria <=	"0000" when “00000000000”, 
					"0001" when “00000000001”, 
					"0010" when “00000000010”, 
					"0011" when “00000000100”, 
					"0100" when “00000001000”, 
					"0101" when “00000010000”, 
					"0110" when “00000100000”, 
					"0111" when “00001000000”, 
					"1000" when “00010000000”, 
					"1001" when “00100000000”, 
					"1010" when “01000000000”, 
					"1011" when “10000000000”, 
					"1111" when others; --TEMPORAL, PARA OBSERVAR FALLOS

end Behavioral;
