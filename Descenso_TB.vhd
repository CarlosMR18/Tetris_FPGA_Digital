library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Descenso_TB is
-- El test bench no tiene entradas ni salidas
end Descenso_TB;

architecture behavior of Descenso_TB is 
    -- Declaración de señales para simular las entradas y salidas del módulo Descenso
    signal clk : std_logic := '0';
    signal reset : std_logic := '0';
    signal MiPieza_ND : unsigned(2 downto 0) := (others => '0');
    signal MiPieza_TP : unsigned(6 downto 0) := (others => '0');
    signal enable_flag : std_logic;
	constant clk_period : time := 8 ns;

    -- Instancia del módulo Descenso
    component Descenso
    port(
        clk : in std_logic;
        reset : in std_logic;
        MiPieza_ND : in unsigned(2 downto 0);
        MiPieza_TP : in unsigned(6 downto 0);
        enable_flag : out std_logic
    );
    end component;
	

begin
    -- Instancia del módulo a probar
    uut: Descenso port map(
        clk => clk,
        reset => reset,
        MiPieza_ND => MiPieza_ND,
        MiPieza_TP => MiPieza_TP,
        enable_flag => enable_flag
    );

    clk_process :process
	begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
	end process;
 

   stim_proc: process
   begin		
		reset <= '1';
		wait for 100 ns;	
		reset <= '0';
      wait;
   end process;

end behavior;