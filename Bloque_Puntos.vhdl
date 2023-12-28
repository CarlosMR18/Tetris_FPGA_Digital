library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;

entity Bloque_Linea is
Port (  clk : in std_logic;
        reset : in std_logic;
        Bloque_Linea_Flag : in std_logic;
		E1 : in unsigned(6 downto 0);
		E2 : in unsigned(6 downto 0);
		E3 : in unsigned(6 downto 0);
		E4 : in unsigned(6 downto 0);
		puntos : in unsigned(0 downto 0);
		Bloque_Linea_Fin_Flag : out std_logic;
		E1_pto : out unsigned(6 downto 0);
		E2_pto : out unsigned(6 downto 0);
		E3_pto : out unsigned(6 downto 0);
		E4_pto : out unsigned(6 downto 0);
		puntos_act : out unsigned(0 downto 0);
		
end Bloque_Linea;

architecture Behavioral of Bloque_Linea is

	signal index : unsigned(2 downto 0);
	type state_t is (ESPERA,PARPADEO_LINEA, LIMPIO_LINEA)
	signal ESTADO : state_t;
	-- Señal de reloj de 125 MHz
	constant cntMax1seg : integer := 125*(10**6)-1;
	signal counter : integer range 0 to cntMax;
	signal E_linea : unsigned(6 downto 0);;
	signal timer_expired : std_logic;
	signal E1_pto : unsigned(6 downto 0);
	signal E2_pto : unsigned(6 downto 0);
	signal E3_pto : unsigned(6 downto 0);
	signal E4_pto : unsigned(6 downto 0);
begin

	estados : process(clk, reset)
	begin
		if (reset = '1') then
				ESTADO <= ESPERA;
				index <= "000";
				timer_expired <= '0';
				E_linea <= (others => '1');
				puntos_act <= puntos;
		elsif (clk = '1' and clk'event) then
			case ESTADO is
				when ESPERA =>
					index <=	"001" when (E1 = "1111111") else
								"010" when (E2 = "1111111") else
								"011" when (E3 = "1111111") else
								"100" when (E4 = "1111111") else
								"000";
					if (Bloque_Linea_Flag = '1' and index/="000") then
						ESTADO <= PARPADEO_LINEA;
						cnt <= (others => '0');
					end if;
				
				when PARPADEO_LINEA =>
					if (counter < cntMax1seg) then 
						counter <= counter + 1;
					else									-- Valor correspondiente a 1 segundo
						timer_expired <= not timer_expired;
						counter <= (others => '0');
					end if;

					if timer_expired = '1' then
						E_linea <= not E_linea;
						case index is
							when "001" =>
								E1_pto <= E_linea;
								E2_pto <= E2;
								E3_pto <= E3;
								E4_pto <= E4;
								
							when "010" =>
								E1_pto <= E1;
								E2_pto <= E_linea;
								E3_pto <= E3;
								E4_pto <= E4;
								
							when "011" =>
								E1_pto <= E1;
								E2_pto <= E2;
								E3_pto <= E_linea;
								E4_pto <= E4;
								
							when "100" =>
								E1_pto <= E1;
								E2_pto <= E2;
								E3_pto <= E3;
								E4_pto <= E_linea;
								
						end case;
							
					end if;
				end if;
				
				when LIMPIO_LINEA =>
					case index is
						when "001" =>
							E1_pto <= (others => '0');
							E2_pto <= E2;
							E3_pto <= E3;
							E4_pto <= E4;
							
						when "010" =>
							E1_pto <= (others => '0');
							E2_pto <= E1;
							E3_pto <= E3;
							E4_pto <= E4;
							
						when "011" =>
							E1_pto <= (others => '0');
							E2_pto <= E1;
							E3_pto <= E2;
							E4_pto <= E4;
							
						when "100" =>
							E1_pto <= (others => '0');
							E2_pto <= E1;
							E3_pto <= E2;
							E4_pto <= E3;
							
					end case;
					index <= others;
					ESTADO <= ESPERA;
					puntos_act <= puntos + 1;
	end process;

end Behavioral;
