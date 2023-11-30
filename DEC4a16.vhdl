library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;

entity DEC4a16 is
Port (	E : in std_logic_vector(3 downto 0);
	S : out std_logic_vector(15 downto 0);
	ena: in std_logic);
end DEC4a16;

	
architecture Structural of DEC4a16 is

	component DEC2a4 is
	port (	E : in std_logic_vector(1 downto 0);
		S : out std_logic_vector(3 downto 0);
		ena: in std_logic);
	end component;

	signal enaint: std_logic_vector(3 downto 0);

Begin
	C1: DEC2a4 port map ( E(3 downto 2), enaint, ena);
	C2: DEC2a4 port map ( E(1 downto 0), S(3 downto 0), enaint(0));
	C3: DEC2a4 port map ( E(1 downto 0), S(7 downto 4), enaint(1));
	C4: DEC2a4 port map ( E(1 downto 0), S(11 downto 8), enaint(2));
	C5: DEC2a4 port map ( E(1 downto 0), S(15 downto 12), enaint(3));		
end Structural;
