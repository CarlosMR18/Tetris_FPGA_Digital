library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;
-- Falta definir TOP_LFSR con Maquina de Estados

entity Bloque_Aleatorio is
Port (	clk : in std_logic;
        reset : in std_logic;
		Generacion_pieza_flag : in std_logic;
		MiPieza_ND_Nuevo : out unsigned(2 downto 0);
		MiPieza_TP_Nuevo : out unsigned(6 downto 0);
		Generacion_pieza_fin_flag : out unsigned);		   );
end Bloque_Aleatorio;


architecture Structure of Bloque_Aleatorio is
    -- component
	--signal Nombre : STD_LOGIC_VECTOR(3 downto 0) := "0000";

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

	
	component DEC3a8 is
    	port (	E : in std_logic_vector(2 downto 0);
            	S : out std_logic_vector(7 downto 0);
            	ena: in std_logic);
	end component;
	
	component DEC2a4 is
	port (	E : in std_logic_vector(1 downto 0);
		S : out std_logic_vector(3 downto 0);
		ena: in std_logic);
	end component;


	component AUnsigned is
	port (	E : in std_logic_vector(10 downto 0);
		PiezaAleatoria : out UNSIGNED;);
	end component;

	signal clk : std_logic;
	signal reset : std_logic;
	
	signal lfsr_cable : std_logic_vector(4 downto 0);
	
	signal TipoElegido : std_logic;
	
	signal Tipo_S_cable : std_logic;
	signal Tipo_D_cable : std_logic;
	signal Tipo_C_cable : std_logic;
	
	signal Ena_Tipo : std_logic;
	signal E_Tipo : std_logic_vector(1 downto 0);
	signal E_Pos : std_logic_vector(2 downto 0);
	
	
	signal Pos_S_cable: std_logic_vector(4 downto 0);
	signal Pos_D_cable: std_logic_vector(3 downto 0);
	signal Pos_C_cable : std_logic_vector(1 downto 0);
	
	signal MiPieza_TP_Nuevo: unsigned(6 downto 0);
	signal MiPieza_ND_Nuevo_interna: unsigned(2 downto 0):="000";
	signal Generacion_pieza_fin_flag : std_logic;

		
begin

	LFSR1 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_cable(0));
    LFSR2 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_cable(1));	
    LFSR3 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_cable(2));	
    LFSR4 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_cable(3));	
    LFSR5 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_cable(4));
							
	TOP_LFSR: TOP_LFSR port map (	clk -> clk, 
									reset -> reset,
									lfsr_in -> lfsr_cable,
									Generacion_pieza_flag -> Generacion_pieza_flag,
									TipoElegido -> TipoElegido,
									SimpleElegida -> Tipo_S_cable,
	                                DobleElegida -> Tipo_D_cable,
			                        CuadradaElegid -> Tipo_C_cable,
			                        
			                        Ena_Tipo -> Ena_Tipo,
			                        E_Tipo -> E_Tipo,
                                    E_Pos -> E_Pos,
			                        MiPieza_TP_Nuevo -> MiPieza_TP_Nuevo,
			                        Generacion_pieza_fin_flag -> Generacion_pieza_fin_flag);
			
			
			
	
	DEC_Tipo: DEC2a4 port map (	E->E_Tipo, 
								S(2 downto 0)->Tipo_C_cable&Tipo_D_cable&Tipo_S_cable,
								ena->Ena_Tipo);
							
	DEC_Pos: DEC3a8 port map (	E->E_Pos, 
								S->Pos_S_cable,
								ena->TipoElegido);
								
	TipoElegido <= Tipo_S_cable or 
					Tipo_D_cable or 
					Tipo_C_cable;

	MiPieza_ND_Nuevo <= MiPieza_ND_Nuevo_interna;
	
end Structure;
