library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;

entity DEC1a2 is
port (	E : in std_logic;
	S : out std_logic_vector(1 downto 0);
	ena: in std_logic);
end DEC1a2;

	
architecture Behavioral of DEC1a2 is
	
	signal interna: std_logic_vector(1 downto 0);

Begin
	with E select
		interna <=	"01" when “0”, 
				"10" when “1”,
				"--" when others;

	S <= interna when ena= ‘1’ else “00”;

end Behavioral;
