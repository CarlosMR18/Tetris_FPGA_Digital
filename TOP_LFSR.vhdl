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
	
*****************************************
*********  PROCESO MODIFICANDO  *********
*****************************************
library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;

entity TOP_LFSR is
Port (  clk : in std_logic;
        reset : in std_logic;
        
        lfsr_in : in std_logic_vector(4 downto 0);
        Generacion_pieza_flag : in std_logic;
        
		   
        Ena_Tipo : out std_logic;
        E_Tipo : out std_logic_vector(1 downto 0);
        E_Pos : out std_logic_vector(2 downto 0);
        
        PiezaElegida: in std_logic;
        PosicionElegida: in std_logic;
        Generacion_pieza_fin_flag : out std_logic;
        --Faltan salidas E()
	);		   
end TOP_LFSR;



architecture Behavioral of TOP_LFSR is
	-- component
	--signal Nombre : std_logic_vector(3 downto 0) := "0000";
	--signal lfsr_in : std_logic_vector(5 downto 0);
	
	component LFSR is
	Port (	clk : in std_logic;
		reset : in std_logic;
		lfsr_out : out std_logic);
	end component;
	
	type state_t is (Espera, Activo)
	signal  STATE_LFSR : state_t;
	
	signal aux_pulso : std_logic_vector(2 downto 0);
	signal  pulso_flag : std_logic;
	
Begin
    entrada_flag : process(clk,reset)
    begin
        if(reset = '1') then
            aux_pulso <= (others =>'0');
        elsif(clk = '1' and clk'event) then
            aux_pulso <= aux_pulso(1 downto 0)&Generacion_pieza_flag;
        end if;
    end process;
    pulso_flag <= aux_pulso(1) and not(aux_pulso(2));
    
    
    Maquina_Estados : process(clk,reset)
    begin
        if(reset = '1') then
            STATE_LFSR <= Espera;
        elsif(clk = '1' and clk'event) then    
           case STATE_LFSR is
               when Espera =>
                   if(Generacion_pieza_flag = '1') then
                    STATE_LFSR <= Activo_Tipo;
               when Activo_Tipo =>
                   if(PiezaElegida = '1') then
                    STATE_LFSR <= Activo_Posicion;
                    
               when Activo_Posicion =>
                   if(PosicionElegida = '1') then
                    STATE_LFSR <= Espera;
             end case;       
        end if;
    end process;
    Ena_Tipo <= '1' when (STATE_LFSR /= Activo) else
                '0';
    
    LFSR1 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_in(0));
    LFSR2 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_in(1)):	
    LFSR3 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_in(2)):	
    LFSR4 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_in(3)):	
    LFSR5 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_in(4)):	                                                
	
end Behavioral;
