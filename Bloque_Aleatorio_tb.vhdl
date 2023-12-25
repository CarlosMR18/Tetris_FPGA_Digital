library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Testbench_Bloque_Aleatorio is
end Testbench_Bloque_Aleatorio;

architecture sim of Testbench_Bloque_Aleatorio is
    -- Señales de la interfaz del bloque aleatorio
    signal clk_tb : std_logic := '0';
    signal reset_tb : std_logic := '0';
    signal Generacion_pieza_flag_tb : std_logic := '0';
    signal MiPieza_ND_Nuevo_tb : unsigned(2 downto 0);
    signal MiPieza_TP_Nuevo_tb : unsigned(6 downto 0);
    signal Generacion_pieza_fin_flag_tb : unsigned;

    -- Constantes de tiempo
    constant clk_period : time := 10 ns;

    -- Proceso de generación de reloj
    process
    begin
        while now < 1000 ns loop
            clk_tb <= not clk_tb;
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Proceso de estímulo
    process
    begin
        -- Inicialización del testbench
        reset_tb <= '1';
        wait for 10 ns;
        reset_tb <= '0';

        -- Escenario de prueba
        wait for 20 ns;
        Generacion_pieza_flag_tb <= '1';
        wait for clk_period * 2;
        Generacion_pieza_flag_tb <= '0';

        -- Puedes agregar más casos de prueba según sea necesario

        wait for 100 ns;
        -- Terminar la simulación
        wait;
    end process;

    -- Instancia del bloque aleatorio
    component Bloque_Aleatorio
        Port (
            clk : in std_logic;
            reset : in std_logic;
            Generacion_pieza_flag : in std_logic;
            MiPieza_ND_Nuevo : out unsigned(2 downto 0);
            MiPieza_TP_Nuevo : out unsigned(6 downto 0);
            Generacion_pieza_fin_flag : out unsigned
        );
    end component;

begin
    -- Conectar el bloque aleatorio al testbench
    UUT : Bloque_Aleatorio
        port map (
            clk => clk_tb,
            reset => reset_tb,
            Generacion_pieza_flag => Generacion_pieza_flag_tb,
            MiPieza_ND_Nuevo => MiPieza_ND_Nuevo_tb,
            MiPieza_TP_Nuevo => MiPieza_TP_Nuevo_tb,
            Generacion_pieza_fin_flag => Generacion_pieza_fin_flag_tb
        );

    -- Proceso de impresión
    process
    begin
        wait until rising_edge(clk_tb);

        -- Imprimir resultados
        if Generacion_pieza_flag_tb = '1' then
            report "Generación de pieza iniciada";
        end if;

        if Generacion_pieza_fin_flag_tb = "1" then
            report "Generación de pieza finalizada";
            report "MiPieza_ND_Nuevo_tb: " & to_string(MiPieza_ND_Nuevo_tb);
            report "MiPieza_TP_Nuevo_tb: " & to_string(MiPieza_TP_Nuevo_tb);
        end if;
    end process;

end sim;
