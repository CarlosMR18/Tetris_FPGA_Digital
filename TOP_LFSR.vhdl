library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;

entity TOP_LFSR is
Port (  clk : in std_logic;
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
        Generacion_pieza_fin_flag : out std_logic;
	);		   
end TOP_LFSR;



architecture Behavioral of TOP_LFSR is

	component LFSR is
	Port (	clk : in std_logic;
		reset : in std_logic;
		lfsr_out : out std_logic);
	end component;
	
	signal aux_pulso : std_logic_vector(2 downto 0);
	signal  pulso_flag : std_logic;
	
	type state_t is (Espera, Generando_Tipo, Generando_Posicion)
	signal  STATE_LFSR : state_t;
	signal Reg_Tipo : std_logic_vector(1 downto 0);
	
Begin
    
	LFSR1 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_in(0));
    LFSR2 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_in(1));	
    LFSR3 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_in(2));	
    LFSR4 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_in(3));	
    LFSR5 : LFSR port mat  (clk -> clk,
                            reset -> reset,
                            lfsr_out -> lfsr_in(4));
							
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
                    STATE_LFSR <= Generando_Tipo;
					Reg_Tipo <= (others => '0');
					
               when Generando_Tipo =>
                   if(TipoElegido = '1') then
                    STATE_LFSR <= Generando_Posicion;
					Reg_Tipo <= E_Tipo;
                    
               when Generando_Posicion =>
                   if(E_Tipo = "00" and SimpleElegida = '1' or E_Tipo = "01" and DobleElegida = '1' or E_Tipo = "10" and CuadradaElegida = '1') then
                    STATE_LFSR <= Espera;
					case Reg_Tipo is
						when "00" => 
							if(SimpleElegida = '1') then
								with E_Pos select
									MiPieza_TP_Nuevo <=	"0000001" when "000",
														"0001000" when "001",
														"0010000" when "010",
														"0100000" when "011",
														"1000000" when "100",
														"-------" when others;
						when "01" => 
							if(DobleElegida = '1') then
								with E_Pos(1 downto 0) select
									MiPieza_TP_Nuevo <=	"0100001" when "000",
														"1100000" when "001",
														"1010000" when "010",
														"0011000" when "011",
														"-------" when others;
						when "10" => 
							if(CuadradaElegida = '1') then
								with E_Pos(0) select
									MiPieza_TP_Nuevo <=	"0000000" when "0",
														"0000000" when "1",
														"-------" when others;
						when "00" =>
							--Nada
														
             end case;       
        end if;
    end process;
    Ena_Tipo <= '1' when (STATE_LFSR /= Activo) else
                '0';
    

	

end Behavioral;
