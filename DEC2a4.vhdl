library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;

entity DEC2a4 is
port (	E : in std_logic_vector(1 downto 0);
	S : out std_logic_vector(3 downto 0);
	ena: in std_logic);
end DEC2a4;

architecture Behavioral of DEC2a4 is

	signal interna: std_logic_vector(3 downto 0);

Begin
	
	with E select
		interna <=	"0001" when “00”, 
				"0010" when “01”,
				"0100" when “10”,
				"1000" when “11”,
				"----" when others;
	S <= interna when ena= ‘1’ else “0000”;

end Behavioral;
