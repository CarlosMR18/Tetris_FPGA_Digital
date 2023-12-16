library IEEE;
use ieee.std_logic_1164.all; --(std_logic; std_logic_vector)
use ieee.numeric_std.all;
-- Falta definir TOP_LFSR con Maquina de Estados
entity Bloque_Accion is
    Port ( clk : in std_logic;
           reset : in std_logic;
		   Accion_Flag : in std_logic;
		   MD : in std_logic;
		   MI : in std_logic;
		   GD : in std_logic;
		   GI : in std_logic;
		   MiPieza_TP : in unsigned(6 downto 0); --MiPieza_TipoPosicion
		   MiPieza_ND : in unsigned(2 downto 0); --MiPieza_NivelDisplay
		   E1 : in unsigned(6 downto 0);
		   E2 : in unsigned(6 downto 0);
		   E3 : in unsigned(6 downto 0);
		   E4 : in unsigned(6 downto 0);
		   
		   Accion_Fin_Flag : out std_logic;
		   MiPieza_TP_act : out unsigned(6 downto 0);
		   Transformacion_Compatible : out std_logic; --Quizas sobra
		   );
end Bloque_Accion;



architecture Behavioral of Bloque_Accion is
	signal interna_C : std_logic_vector (1 downto 0);
	signal MiPieza_TP_Trasnformada : unsigned(6 downto 0);
	signal MiPieza_MD: unsigned(6 downto 0);
	signal MiPieza_MI: unsigned(6 downto 0);
	signal MiPieza_GD: unsigned(6 downto 0);
	signal MiPieza_GI: unsigned(6 downto 0);
	signal E_int: unsigned(6 downto 0);
	signal Producto_BitaBit: unsigned(6 downto 0);
	
begin
	with MiPieza_TP select
	MiPieza_MD <=	to_unsigned(1) when to_unsigned(1),		-- Simple1
					to_unsigned(2) when to_unsigned(2),  	-- Simple2
					to_unsigned(2) when to_unsigned(4),  	-- Simple3
					to_unsigned(64) when to_unsigned(8),  	-- Simple4
					to_unsigned(32) when to_unsigned(16),  	-- Simple5
					to_unsigned(32) when to_unsigned(32),  	-- Simple6
					to_unsigned(1) when to_unsigned(64),  	-- Simple7
					
					to_unsigned(96) when to_unsigned(96), 	-- Doble1
					to_unsigned(66) when to_unsigned(66),  	-- Doble2
					to_unsigned(3) when to_unsigned(3),  	-- Doble3
					to_unsigned(33) when to_unsigned(33),  	-- Doble4
					to_unsigned(96) when to_unsigned(17),  	-- Doble5
					to_unsigned(66) when to_unsigned(5),  	-- Doble6
					to_unsigned(3) when to_unsigned(12),  	-- Doble7
					to_unsigned(33) when to_unsigned(24),  	-- Doble8
					
					to_unsigned(99) when to_unsigned(99), 	-- Cuadrado1
					to_unsigned(99) when to_unsigned(29),  	-- Cuadrado2
					"-------" when others;
					
	MiPieza_MI <=	to_unsigned(64) when to_unsigned(1),	-- Simple1
					to_unsigned(4) when to_unsigned(2), 	-- Simple2
					to_unsigned(4) when to_unsigned(4), 	-- Simple3
					to_unsigned(8) when to_unsigned(8),  	-- Simple4
					to_unsigned(16) when to_unsigned(16),  	-- Simple5
					to_unsigned(16) when to_unsigned(32),  	-- Simple6
					to_unsigned(8) when to_unsigned(64),  	-- Simple7
					
					to_unsigned(17) when to_unsigned(96),  	-- Doble1
					to_unsigned(5) when to_unsigned(66),  	-- Doble2
					to_unsigned(12) when to_unsigned(3),  	-- Doble3
					to_unsigned(24) when to_unsigned(33),  	-- Doble4
					to_unsigned(17) when to_unsigned(17),  	-- Doble5
					to_unsigned(5) when to_unsigned(5),  	-- Doble6
					to_unsigned(12) when to_unsigned(12),  	-- Doble7
					to_unsigned(24) when to_unsigned(24),  	-- Doble8
					
					to_unsigned(29) when to_unsigned(99),  	-- Cuadrado1
					to_unsigned(29) when to_unsigned(29), 	-- Cuadrado2
					"-------" when others;
					
	MiPieza_GD <=	to_unsigned(2) when to_unsigned(1),  	-- Simple1
					to_unsigned(64) when to_unsigned(2),  	-- Simple2
					to_unsigned(8) when to_unsigned(4),  	-- Simple3
					to_unsigned(16) when to_unsigned(8),  	-- Simple4
					to_unsigned(64) when to_unsigned(16),  	-- Simple5
					to_unsigned(1) when to_unsigned(32),  	-- Simple6
					to_unsigned(32) when to_unsigned(64),  	-- Simple7
					
					to_unsigned(33) when to_unsigned(96),  	-- Doble1
					to_unsigned(96) when to_unsigned(66),  	-- Doble2
					to_unsigned(66) when to_unsigned(3),  	-- Doble3
					to_unsigned(3) when to_unsigned(33),  	-- Doble4
					to_unsigned(24) when to_unsigned(17),  	-- Doble5
					to_unsigned(17) when to_unsigned(5),  	-- Doble6
					to_unsigned(5) when to_unsigned(12),  	-- Doble7
					to_unsigned(12) when to_unsigned(24),  	-- Doble8
					
					to_unsigned(99) when to_unsigned(99),  	-- Cuadrado1
					to_unsigned(29) when to_unsigned(29), 	-- Cuadrado2
					"-------" when others;
					
	MiPieza_GI <=	to_unsigned(32) when to_unsigned(1), 	-- Simple1
					to_unsigned(1) when to_unsigned(2),   	-- Simple2
					to_unsigned(64) when to_unsigned(4), 	-- Simple3
					to_unsigned(4) when to_unsigned(8),   	-- Simple4
					to_unsigned(8) when to_unsigned(16),   	-- Simple5
					to_unsigned(64) when to_unsigned(32), 	-- Simple6
					to_unsigned(16) when to_unsigned(64),  	-- Simple7
					                                     
					to_unsigned(66) when to_unsigned(96),  	-- Doble1
					to_unsigned(3) when to_unsigned(66),   	-- Doble2
					to_unsigned(33) when to_unsigned(3),  	-- Doble3
					to_unsigned(96) when to_unsigned(33), 	-- Doble4
					to_unsigned(5) when to_unsigned(17),   	-- Doble5
					to_unsigned(12) when to_unsigned(5),  	-- Doble6
					to_unsigned(24) when to_unsigned(12), 	-- Doble7
					to_unsigned(17) when to_unsigned(24),  	-- Doble8
					                                     
					to_unsigned(99) when to_unsigned(99),  	-- Cuadrado1
					to_unsigned(29) when to_unsigned(29), 	-- Cuadrado2
					"-------" when others;
					
	
	interna_C <=	"11" when MD = '1' else
					"10" when MI = '1' else
					"01" when GD = '1' else
					"00" when GI = '1' else
					"--";
					
	with interna_C select
		MiPieza_TP_Trasnformada <=	MiPieza_MD when "11",
									MiPieza_MI when "10",
									MiPieza_GD when "01",
									MiPieza_GI when "00";
	
	with MiPieza_ND select
		E_int <=	E1 when to_unsigned(1),
					E2 when to_unsigned(2),
					E3 when to_unsigned(3),
					E4 when to_unsigned(4),
					"-------" when others;
					
	Producto_BitaBit <=  MiPieza_TP_Trasnformada and E_int; -- Si coincide algun bit, supondrá que el segmento ya se usa
	
	
	salidas: process (Producto_BitaBit, Transformacion_Compatible, MiPieza_TP_act)
	begin
		if (Producto_BitaBit = "0000000") then 	-- Accion Compatible
			Transformacion_Compatible <= '1';
			MiPieza_TP_act <= MiPieza_TP_Trasnformada;
		else 									-- Accion Incompatible
			Transformacion_Compatible <= '0';
			MiPieza_TP_act <= MiPieza_TP;
			
		end if;
	end process salidas;
	
	
end Behavioral;
