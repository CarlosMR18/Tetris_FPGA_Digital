library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;
-- Falta definir TOP_LFSR con Maquina de Estados

entity Bloque_Aleatorio is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
		   FaltaPieza_Flag : in STD_LOGIC;
		   PiezaGenerada_Flag : out STD_LOGIC;
		   PiezaAleatoria : out UNSIGNED;		   
		 --Sin Acabar
		   );
end Bloque_Aleatorio;



architecture Structure of TOP_LFSR is
    -- component
	--signal Nombre : STD_LOGIC_VECTOR(3 downto 0) := "0000";

	component LFSR is
		Port (	clk : in STD_LOGIC;
				reset : in STD_LOGIC;
				lfsr_out : out STD_LOGIC);
	end component;
	
	component TOP_LFSR is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           lfsr_in : in STD_LOGIC_VECTOR(4 downto 0);
		   FaltaPieza_Flag: in STD_LOGIC;
		   PiezaElegida: in STD_LOGIC;
		   PosicionElegida: in STD_LOGIC;
		   
		   Ena_Tipo : out STD_LOGIC;
		   E_Tipo : out STD_LOGIC_VECTOR(1 downto 0);
		   E_Pos : out STD_LOGIC_VECTOR(2 downto 0);
		   --Faltan salidas E()
		   );
	end component;
	
	component DEC3a8 is
    port (  E : in std_logic_vector(2 downto 0);
            S : out std_logic_vector(7 downto 0);
            ena: in std_logic);
	end component;
	
	component DEC2a4 is
		port (	E : in std_logic_vector(1 downto 0);
				S : out std_logic_vector(3 downto 0);
				ena: in std_logic);
	end component;
	
	component DEC1a2 is
		port (	E : in std_logic;
				S : out std_logic_vector(1 downto 0);
				ena: in std_logic);
	end component;
	

	component AUnsigned is
		port (	E : in std_logic_vector(10 downto 0);
				PiezaAleatoria : out UNSIGNED;);
	end component;

	signal clk : STD_LOGIC;
	signal reset : STD_LOGIC;
	
	signal lfsr_in_cable : STD_LOGIC_VECTOR(5 downto 0);
	signal PiezaElegida : STD_LOGIC;
	signal PosicionElegida : STD_LOGIC;
	signal Ena_Tipo : STD_LOGIC;
	signal E_Tipo : STD_LOGIC_VECTOR(1 downto 0);
	signal E_Pos : STD_LOGIC_VECTOR(2 downto 0);
	
	signal Tipo_S_cable : STD_LOGIC;
	signal Tipo_D_cable : STD_LOGIC;
	signal Tipo_C_cable : STD_LOGIC;
	
	signal Pos_S_cable: STD_LOGIC_VECTOR(4 downto 0);;
	signal Pos_D_cable: STD_LOGIC_VECTOR(3 downto 0);;
	signal Pos_C_cable : STD_LOGIC_VECTOR(1 downto 0);;
	
	--signal E_Aunsigned_cable : STD_LOGIC_VECTOR(10 downto 0);
begin
	LFSR1: LFSR port map (	clk->clk, 
				reset->reset,
				lfsr_out->lfsr_in_cable(0));						
	LFSR2: LFSR port map (	clk->clk, 
				reset->reset,
				lfsr_out->lfsr_in_cable(1));
	LFSR3: LFSR port map (	clk->clk, 
				reset->reset,
				lfsr_out->lfsr_in_cable(2));
	LFSR4: LFSR port map (	clk->clk, 
				reset->reset,
				lfsr_out->lfsr_in_cable(3));
	LFSR5: LFSR port map (	clk->clk, 
				reset->reset,
				lfsr_out->lfsr_in_cable(4));
							
	TOP_LFSR: TOP_LFSR port map (	clk->clk, 
					reset->reset,
					lfsr_in->lfsr_in_cable,
					FaltaPieza_Flag->FaltaPieza_Flag,
					PiezaElegida->PiezaElegida,
					PosicionElegida->PosicionElegida,
					Ena_Tipo->Ena_Tipo,
					E_Tipo->E_Tipo,
					E_Pos->E_Pos);
									
	DEC_Tipo: DEC2a4 port map (	E->E_Tipo, 
					S(0)->Tipo_S_cable,
					S(1)->Tipo_D_cable,
					S(2)->Tipo_C_cable,
					ena->Ena_Tipo);
							
	DEC_Pos_D: DEC3a8 port map (	E->E_Pos, 
					S(4 downto 0)->Pos_S_cable,
					ena->Tipo_S_cable);
									
	DEC_Pos_D: DEC2a4 port map (	E->E_Pos(1 downto 0), 
					S->Pos_D_cable,
					ena->Tipo_D_cable);
	
	DEC_Pos_C: DEC1a2 port map (	E->E_Pos(0), 
					S->Pos_C_cable,
					ena->Tipo_C_cable);
								
	AUnsigned: AUnsigned port map (	E->Pos_C_cable&Pos_D_cable&Pos_S_cable,								
					PiezaAleatoria->PiezaAleatoria);	
								
	
	PiezaElegida <= Tipo_S_cable or 
			Tipo_D_cable or 
			Tipo_C_cable;
	PosicionElegida <=	Pos_S_cable(4) or 
				Pos_S_cable(3) or 
				Pos_S_cable(2) or 
				Pos_S_cable(1) or 
				Pos_S_cable(0) or 
				Pos_D_cable(3) or 
				Pos_D_cable(2) or 
				Pos_D_cable(1) or 
				Pos_D_cable(0) or
				Pos_C_cable(1) or 
				Pos_C_cable(0);
	PiezaGenerada_Flag <=	PiezaElegida and PosicionElegida;			
end Structure;
