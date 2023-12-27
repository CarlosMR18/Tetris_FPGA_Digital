library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;

entity Bloque_Puntos is
Port (  clk : in std_logic;
        reset : in std_logic;
        Bloque_Puntos_Flag : in std_logic;
		E1 : in unsigned(6 downto 0);
		E2 : in unsigned(6 downto 0);
		E3 : in unsigned(6 downto 0);
		E4 : in unsigned(6 downto 0);
		puntos : in unsigned(0 downto 0);
		Bloque_Puntos_Fin_Flag : out std_logic;
		E1_pto : out unsigned(6 downto 0);
		E2_pto : out unsigned(6 downto 0);
		E3_pto : out unsigned(6 downto 0);
		E4_pto : out unsigned(6 downto 0);
		puntos_act : out unsigned(0 downto 0);
		
end Bloque_Puntos;

architecture Behavioral of Bloque_Puntos is

	

begin

	

end Behavioral;
