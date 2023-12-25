library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;

entity Bloque_Aleatorio is
Port (	clk : in std_logic;
        reset : in std_logic;
		Generacion_pieza_flag : in std_logic;
		MiPieza_ND_Nuevo : out unsigned(2 downto 0);
		MiPieza_TP_Nuevo : out unsigned(6 downto 0);
		Generacion_pieza_fin_flag : out unsigned);
end Bloque_Aleatorio;


architecture Structure of Bloque_Aleatorio is

	component LFSR is
	Port (	clk : in std_logic;
		reset : in std_logic;
		lfsr_out : out std_logic);
	end component;
	
	component TOP_LFSR is
	Port (	clk : in std_logic;
			reset : in std_logic;
			
			lfsr_in : in std_logic_vector(4 downto 0);
			Generacion_pieza_flag : in std_logic;
			
			TipoElegido: in std_logic;
			SimpleElegida: in std_logic;
			DobleElegida: in std_logic;
			CuadradaElegida: in std_logic;
			
			Ena_Tipo : out std_logic;
			E_Tipo : out std_logic_vector(1 downto 0);
			E_Pos : out std_logic_vector(2 downto 0);
			MiPieza_TP_Nuevo : out unsigned(6 downto 0);
			Generacion_pieza_fin_flag : out std_logic);		   
	component TOP_LFSR;

	signal clk : std_logic;
	signal reset : std_logic;
	
	signal lfsr_cable : std_logic_vector(4 downto 0);
	signal Generacion_pieza_flag : std_logic;

	signal Ena_Tipo : std_logic;
	signal E_Tipo : std_logic_vector(1 downto 0);
	signal E_Pos : std_logic_vector(2 downto 0);

	signal TipoElegido : std_logic;
	signal SimpleElegida: std_logic;
	signal DobleElegida: std_logic;
	signal CuadradaElegida: std_logic;
	
	signal MiPieza_TP_Nuevo: unsigned(6 downto 0);
	signal MiPieza_ND_Nuevo_interna: unsigned(2 downto 0) :="000";
	signal Generacion_pieza_fin_flag : std_logic;

		
begin

	LFSR1 : LFSR port map  (clk => clk,
                            reset => reset,
                            lfsr_out => lfsr_cable(0));
    LFSR2 : LFSR port map  (clk => clk,
                            reset => reset,
                            lfsr_out => lfsr_cable(1));	
    LFSR3 : LFSR port map  (clk => clk,
                            reset => reset,
                            lfsr_out => lfsr_cable(2));	
    LFSR4 : LFSR port map  (clk => clk,
                            reset => reset,
                            lfsr_out => lfsr_cable(3));	
    LFSR5 : LFSR port map  (clk => clk,
                            reset => reset,
                            lfsr_out => lfsr_cable(4));
							
	TOP_LFSR: TOP_LFSR port map (	clk => clk, 
									reset => reset,
									lfsr_in => lfsr_cable,
									Generacion_pieza_flag => Generacion_pieza_flag,
									TipoElegido => TipoElegido,
									SimpleElegida => SimpleElegida,
	                                DobleElegida => DobleElegida,
			                        CuadradaElegida => CuadradaElegida,
			                        
			                        Ena_Tipo => Ena_Tipo,
			                        E_Tipo => E_Tipo,
                                    E_Pos => E_Pos,
			                        MiPieza_TP_Nuevo => MiPieza_TP_Nuevo,
			                        Generacion_pieza_fin_flag => Generacion_pieza_fin_flag);

	TipoElegido <= 	'1' when (E_Tipo /= "11" and Ena_Tipo = '1') else
					'0';
					
	SimpleElegida <=	'1' when (TipoElegido = '1' and E_Tipo = "00" and E_Pos = "000") else
						'1' when (TipoElegido = '1' and E_Tipo = "00" and E_Pos = "001") else
						'1' when (TipoElegido = '1' and E_Tipo = "00" and E_Pos = "010") else
						'1' when (TipoElegido = '1' and E_Tipo = "00" and E_Pos = "011") else
						'1' when (TipoElegido = '1' and E_Tipo = "00" and E_Pos = "100") else
						'0';
						
	DobleElegida <=	'1' when (TipoElegido = '1' and E_Tipo = "01" and E_Pos(1 downto 0) = "00") else
					'1' when (TipoElegido = '1' and E_Tipo = "01" and E_Pos(1 downto 0) = "01") else
                    '1' when (TipoElegido = '1' and E_Tipo = "01" and E_Pos(1 downto 0) = "10") else
                    '1' when (TipoElegido = '1' and E_Tipo = "01" and E_Pos(1 downto 0) = "11") else
					'0';
					
	CuadradaElegida <=	'1' when (TipoElegido = '1' and E_Tipo = "10") else
						'0';
						
	MiPieza_ND_Nuevo <= MiPieza_ND_Nuevo_interna;
	
end Structure;
