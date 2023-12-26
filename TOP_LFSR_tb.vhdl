library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TOP_LFSR_tb is
end TOP_LFSR_tb;

architecture testbench of TOP_LFSR_tb is
    signal clk_tb, reset_tb, lfsr_in_tb : std_logic;
    signal Generacion_pieza_flag_tb, TipoElegido_tb, SimpleElegida_tb, DobleElegida_tb, CuadradaElegida_tb : std_logic;
    signal Ena_Tipo_tb : std_logic;
    signal E_Tipo_tb, E_Pos_tb : std_logic_vector(1 downto 0);
    signal MiPieza_TP_Nuevo_tb : unsigned(6 downto 0);
    signal Generacion_pieza_fin_flag_tb : std_logic;

    -- Add signals for LFSR outputs if needed for monitoring

    constant CLK_PERIOD : time := 10 ns; -- Adjust the clock period as needed

    component TOP_LFSR is
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
                Generacion_pieza_fin_flag : out std_logic);
    end component;

    -- Add LFSR component declaration if needed

begin

    -- Instantiate the unit under test (UUT)
    UUT: TOP_LFSR
        port map (
            clk => clk_tb,
            reset => reset_tb,
            lfsr_in => lfsr_in_tb,
            Generacion_pieza_flag => Generacion_pieza_flag_tb,
            TipoElegido => TipoElegido_tb,
            SimpleElegida => SimpleElegida_tb,
            DobleElegida => DobleElegida_tb,
            CuadradaElegida => CuadradaElegida_tb,
            Ena_Tipo => Ena_Tipo_tb,
            E_Tipo => E_Tipo_tb,
            E_Pos => E_Pos_tb,
            MiPieza_TP_Nuevo => MiPieza_TP_Nuevo_tb,
            Generacion_pieza_fin_flag => Generacion_pieza_fin_flag_tb
        );

    -- Add clock generation process
    process
    begin
        clk_tb <= '0';
        wait for CLK_PERIOD / 2;
        clk_tb <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    -- Add reset process
    process
    begin
        reset_tb <= '1';
        wait for 20 ns; -- Adjust the reset duration as needed
        reset_tb <= '0';
        wait;
    end process;

    -- Add stimulus process
    process
    begin
        wait for 10 ns; -- Wait for initial signals stabilization

        -- Add test scenarios here by manipulating input signals
        -- For example:
        Generacion_pieza_flag_tb <= '1';
        TipoElegido_tb <= '1';
        SimpleElegida_tb <= '1';
        wait for CLK_PERIOD * 5; -- Run for a few clock cycles
        Generacion_pieza_flag_tb <= '0';
        wait for CLK_PERIOD * 10; -- Run for a few more clock cycles

        -- Add more test scenarios as needed

        wait;
    end process;

end testbench;
