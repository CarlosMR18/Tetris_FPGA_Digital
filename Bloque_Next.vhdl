library IEEE;
use ieee.std_logic_1164.all; --(std_logic; std_logic_vector)
use ieee.numeric_std.all;
-- Falta definir TOP_LFSR con Maquina de Estados
entity Bloque_Next is
    Port ( clk : in std_logic;
           reset : in std_logic;
		   Next_Flag : in std_logic;
		   MiPieza_TP : in unsigned(6 downto 0); --MiPieza_TipoPosicion
		   MiPieza_ND : in unsigned(2 downto 0); --MiPieza_NivelDisplay
		   E1 : in unsigned(6 downto 0);
		   E2 : in unsigned(6 downto 0);
		   E3 : in unsigned(6 downto 0);
		   E4 : in unsigned(6 downto 0);

		   MiPieza_ND_act : out unsigned(6 downto 0);   
		   PiezaFijada_Flag : out std_logic;
		   PiezaBajada_Flag : out std_logic;
		   E1_act : out unsigned(6 downto 0);
		   E2_act : out unsigned(6 downto 0);
		   E3_act : out unsigned(6 downto 0);
		   E4_act : out unsigned(6 downto 0)
		   );
end Bloque_Next;



architecture Behavioral of Bloque_Next is
	signal E_int : unsigned(6 downto 0);
	
	signal Producto_BitaBit : unsigned(6 downto 0);
	signal Suma_BitaBit : unsigned(6 downto 0);
	signal Ei_transformada : unsigned(6 downto 0);
	
begin
	localizo_Display: process (MiPieza_ND, E1, E2, E3, E4, E_int)
	begin                                  
		with MiPieza_ND select             
			E_int <= 	E1 when "00",      
						E2 when "01",
						E3 when "10",
						E4 when "11",
						"0000000" when others;
						
		E_int(1) <= E_int(1) or E_int(5);
		E_int(2) <= E_int(2) or E_int(4);
	end process localizo_Display;
	
	Producto_BitaBit <= E_int and MiPieza_TP;
	Suma_BitaBit <= E_int or MiPieza_TP;
	
	actualizo_bajada_o_fijada: process(Producto_BitaBit, PiezaFijada_Flag, PiezaBajada_Flag, MiPieza_ND_act, MiPieza_ND, E1, E2, E3, E4, Ei_transformada, E1_act, E2_act, E3_act, E4_act)
	begin 
		if(Producto_BitaBit = "0000000") then 	-- Accion Compatible (Baja Pieza)
			PiezaFijada_Flag <= '1';
			PiezaBajada_Flag <= '0';
			MiPieza_ND_act <= MiPieza_ND + 1;
		else 									-- Accion Incompatible (Fija Pieza)
			PiezaFijada_Flag <= '0';
			PiezaBajada_Flag <= '1';
			case MiPieza_ND_act is
				when "00" => (	E1_act <= Ei_transformada,
								E2_act <= E2,
								E3_act <= E3,
								E4_act <= E4);
								
				when "01" => (	E1_act <= E1,
								E2_act <= Ei_transformada,
								E3_act <= E3,
								E4_act <= E4);
								
				when "10" => (	E1_act <= E1,
								E2_act <= E2,
								E3_act <= Ei_transformada,
								E4_act <= E4);
								
				when "11" => (	E1_act <= E1,
								E2_act <= E2,
								E3_act <= E3,
								E4_act <= Ei_transformada);
								
		end if;
		
	end process actualizo_bajada_o_fijada;

end Behavioral;
			
------------------------------------------------------------------
--------------------- MODIFICANDO EN PROCESO ---------------------	
------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all; --(std_logic; std_logic_vector)
use ieee.numeric_std.all;

entity Bloque_Next is
    Port ( clk : in std_logic;
           reset : in std_logic;
		   Next_Flag : in std_logic;
		   MiPieza_TP : in unsigned(6 downto 0); --MiPieza_TipoPosicion
		   MiPieza_ND : in unsigned(2 downto 0); --MiPieza_NivelDisplay
		   E1 : in unsigned(6 downto 0);
		   E2 : in unsigned(6 downto 0);
		   E3 : in unsigned(6 downto 0);
		   E4 : in unsigned(6 downto 0);
		   
		   MiPieza_TP_act : out unsigned(6 downto 0);
		   MiPieza_ND_act : out unsigned(6 downto 0);   
		   PiezaFijada_Flag : out std_logic;
		   PiezaBajada_Flag : out std_logic;
		   E1_act : out unsigned(6 downto 0);
		   E2_act : out unsigned(6 downto 0);
		   E3_act : out unsigned(6 downto 0);
		   E4_act : out unsigned(6 downto 0)
		   );
end Bloque_Next;



architecture Behavioral of Bloque_Next is
	signal E_int : unsigned(6 downto 0);
	signal MiPieza_TP_int  : unsigned(6 downto 0);
	
	signal Producto_BitaBit : unsigned(6 downto 0);
	signal Suma_BitaBit : unsigned(6 downto 0);
	signal E_aux : unsigned(6 downto 0);
	signal aux_seg_E : std_logic;
	signal aux_seg_F : std_logic;
	
	type state_t is (ESPERA, RAPIDO_ALTO, RAPIDO_BAJO, LENTO);
	signal ESTADO : state_t;
	signal ena_time : std_logic;
	signal NoActua_Flag : std_logic;
	signal Ei_act : std_logic(6 downto 0);	
begin

process(clk, reset)
	if (reset = '1') then
		ESTADO <= ESPERA;
		ena_time <= '1';
	elsif (clk = '1' and clk'event) then
		case ESTADO is
			when ESPERA => 
				if (Next_Flag = '1') then
					with MiPieza_TP is
						ESTADO <=	RAPIDO_ALTO when "0100000",  
									RAPIDO_ALTO when "0010000",
									RAPIDO_BAJO when "0000010",
									RAPIDO_BAJO when "0000100",
									LENTO when others;
				end if;
				
			when LENTO =>  --Mi Pieza es no Simple Horizontal, Velocidad de caida pieza Lenta
				ena_time <= not(ena_time); --Señal auxiliar, duplica periodo. 
				if(Producto_BitaBit/="0000000") then
					case MiPieza_ND_act is
						when "00" => (	E1_act <= E1 or MiPieza_TP,
										E2_act <= E2,
										E3_act <= E3,
										E4_act <= E4);
										
						when "01" => (	E1_act <= E1,
										E2_act <= E2 or MiPieza_TP,
										E3_act <= E3,
										E4_act <= E4);
										
						when "10" => (	E1_act <= E1,
										E2_act <= E2,
										E3_act <= E3 or MiPieza_TP,
										E4_act <= E4);
										
						when "11" => (	E1_act <= E1,
										E2_act <= E2,
										E3_act <= E3,
										E4_act <= E4 or MiPieza_TP);
					end case;
				else 
					MiPieza_ND_act <= MiPieza_ND + 1;
				end if;
				ESTADO <= ESPERA;
				
			when RAPIDO_ALTO =>  --Mi Pieza es Simple Horizontal contenida en segmento E o F, Velocidad de caida pieza Rápida
				ena_time <= '0';
				if(Producto_BitaBit/="0000000") then
					case MiPieza_ND_act is
						when "000" => (	E1_act <= E1,
										E2_act <= E2,
										E3_act <= E3,
										E4_act <= E4);
										
						when "001" => (	E1_act <= E1 or MiPieza_TP_int,
										E2_act <= E2,
										E3_act <= E3,
										E4_act <= E4);
										
						when "010" => (	E1_act <= E1,
										E2_act <= E2 or MiPieza_TP_int,
										E3_act <= E3,
										E4_act <= E4);
										
						when "011" => (	E1_act <= E1,
										E2_act <= E2,
										E3_act <= E3 or MiPieza_TP_int,
										E4_act <= E4);
										
						when "100" => (	E1_act <= E1,
										E2_act <= E2,
										E3_act <= E3,
										E4_act <= E4 or MiPieza_TP_int);	
										
						when others => ;
						
					end case;
				end if;
				ESTADO <= ESPERA;
			
			when RAPIDO_BAJO =>  --Mi Pieza es Simple Horizontal contenida en segmento B o C, Velocidad de caida pieza Rápida
				ena_time <= '0';
				if(Producto_BitaBit/="0000000") then
					case MiPieza_ND_act is
						when "001" => (	E1_act <= MiPieza_ND or E1,
										E2_act <= E2,
										E3_act <= E3,
										E4_act <= E4);
										
						when "010" => (	E1_act <= E1,
										E2_act <= MiPieza_ND or E2,
										E3_act <= E3,
										E4_act <= E4);
										
						when "011" => (	E1_act <= E1,
										E2_act <= E2,
										E3_act <= MiPieza_ND or E3,
										E4_act <= E4);
										
						when "100" => (	E1_act <= E1,
										E2_act <= E2,
										E3_act <= E3,
										E4_act <= MiPieza_ND or E4);
						
						when others =>	;
						
					end case;
				else
					MiPieza_ND_act <= MiPieza_ND + 1;
				end if;
				ESTADO <= ESPERA;
		end case;		
	end if;
end process;	

-- Banderas
NoActua_Flag <=	'1' when (ESTADO = LENTO and ena_time = '0') else
				'0';
				
PiezaFijada_Flag <=	'1' when (ESTADO = LENTO and ena_time = '1' and Producto_BitaBit/="0000000") else
					'1' when (ESTADO = RAPIDO_ALTO and Producto_BitaBit/="0000000") else
					'1' when (ESTADO = RAPIDO_BAJO and Producto_BitaBit/="0000000") else
					'0';

PiezaBajada_Flag <=	'1' when (ESTADO = LENTO and ena_time = '1' and Producto_BitaBit = "0000000") else
					'1' when (ESTADO = LENTO and Producto_BitaBit = "0000000") else
					'0';


E_aux <=	E1 when (MiPieza_ND = "000" and ESTADO = LENTO and ena_time = '1') else --LENTO
			E2 when (MiPieza_ND = "001" and ESTADO = LENTO and ena_time = '1') else
			E3 when (MiPieza_ND = "010" and ESTADO = LENTO and ena_time = '1') else
			E4 when (MiPieza_ND = "011" and ESTADO = LENTO and ena_time = '1') else
			"1111111";		
			
aux_seg_B <= E_aux(1) or E_aux(5); -- Estando el segmento F acupado, no puede bajar al segmento B aunque está libre
aux_seg_C <= E_aux(2) or E_aux(4); -- Estando el segmento E acupado, no puede bajar al segmento C aunque está libre
					
E_int <=	E_aux(6 downto 3)&aux_seg_C&aux_seg_B&E_aux(0) when (MiPieza_ND = "000" and ESTADO = LENTO and ena_time = '1') else --LENTO
			E_aux(6 downto 3)&aux_seg_C&aux_seg_B&E_aux(0) when (MiPieza_ND = "001" and ESTADO = LENTO and ena_time = '1') else
			E_aux(6 downto 3)&aux_seg_C&aux_seg_B&E_aux(0) when (MiPieza_ND = "010" and ESTADO = LENTO and ena_time = '1') else
			E_aux(6 downto 3)&aux_seg_C&aux_seg_B&E_aux(0) when (MiPieza_ND = "011" and ESTADO = LENTO and ena_time = '1') else		
			E1 when (MiPieza_ND = "000" and ESTADO = RAPIDO_ALTO) else --RAPIDO_ALTO
			E1 when (MiPieza_ND = "001" and ESTADO = RAPIDO_ALTO) else
			E2 when (MiPieza_ND = "010" and ESTADO = RAPIDO_ALTO) else
			E3 when (MiPieza_ND = "011" and ESTADO = RAPIDO_ALTO) else
			E4 when (MiPieza_ND = "100" and ESTADO = RAPIDO_ALTO) else
			E2 when (MiPieza_ND = "001" and ESTADO = RAPIDO_BAJO) else --RAPIDO_BAJO
			E3 when (MiPieza_ND = "010" and ESTADO = RAPIDO_BAJO) else
			E4 when (MiPieza_ND = "011" and ESTADO = RAPIDO_BAJO) else
			"1111111"; --NO ACTUA 

MiPieza_TP_int <=	"0100000" when (ESTADO = RAPIDO_ALTO and MiPieza_TP(5) = '1' and MiPieza_ND = "000"),
					"0010000" when (ESTADO = RAPIDO_ALTO and MiPieza_TP(4) = '1' and MiPieza_ND = "000"),
					"0000010" when (ESTADO = RAPIDO_ALTO and MiPieza_TP(5) = '1' and MiPieza_ND = "000"),
					"0000100" when (ESTADO = RAPIDO_ALTO and MiPieza_TP(4) = '1' and MiPieza_ND = "000"),
					"0100000" when (ESTADO = RAPIDO_BAJO and MiPieza_TP(1) = '1'),
					"0010000" when (ESTADO = RAPIDO_BAJO and MiPieza_TP(2) = '1'),
					MiPieza_TP when others;

Producto_BitaBit <= E_int and MiPieza_TP_int;
Suma_BitaBit <= E_int or MiPieza_TP_int;

with Producto_BitaBit select
Ei_act <=	Ei_act when "0000000" else
			E_int;

with ESTADO select
	MiPieza_TP_act <=	MiPieza_TP_int when RAPIDO_ALTO,
						MiPieza_TP_int when RAPIDO_BAJO,
						MiPieza_TP when others;

end Behavioral;
