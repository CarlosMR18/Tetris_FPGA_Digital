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
