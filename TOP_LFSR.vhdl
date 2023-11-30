library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;

entity TOP_LFSR is
Port (	clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        lfsr_in : in STD_LOGIC_VECTOR(4 downto 0);
	--Flag: in STD_LOGIC;
	PiezaElegida: in STD_LOGIC;
	PosicionElegida: in STD_LOGIC;
		   
	Ena_Tipo : out STD_LOGIC;
	E_Tipo : out STD_LOGIC_VECTOR(1 downto 0);
	E_Pos : out STD_LOGIC_VECTOR(2 downto 0);
	--Faltan salidas E()
	);		   
end TOP_LFSR;



architecture Behavioral of TOP_LFSR is
	-- component
	--signal Nombre : STD_LOGIC_VECTOR(3 downto 0) := "0000";
	--signal lfsr_in : STD_LOGIC_VECTOR(5 downto 0);
	
	component LFSR is
	Port (	clk : in STD_LOGIC;
		reset : in STD_LOGIC;
		lfsr_out : out STD_LOGIC);
	end component; 

begin
	LFSR1: LFSR port map (	clk->clk, 
				reset->reset,
				lfsr_out->lfsr_in(0));
	
end Behavioral;
