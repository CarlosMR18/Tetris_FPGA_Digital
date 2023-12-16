----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2023 12:12:52
-- Design Name: 
-- Module Name: DescensoFichas - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DescensoFichas is
Port (clk : in STD_LOGIC;  -- Reloj del sistema
      reset : in STD_LOGIC;  -- Señal de reinicio
      phase : in STD_LOGIC_VECTOR (7 downto 0);  -- Nivel del juego
      fall_signal : out STD_LOGIC  -- Señal para indicar el descenso de la ficha
      tipo_ficha_flag: in STD_LOGIC_VECTOR (10 downto 0)
 );
end DescensoFichas;

architecture Behavioral of DescensoFichas is
    constant base_time : integer := 2000;  -- Tiempo base de descenso en milisegundos
    signal fall_timer : integer := base_time;  -- Temporizador para el descenso
    signal count : integer := 0;  -- Contador para el temporizador
    signal time_per_level : integer;  -- Tiempo de descenso ajustado por nivel
begin
  -- Ajustar tiempo de descenso según el nivel
    if (tipo_ficha_flag < 5) then
        time_per_level <= base_time - (100 * to_integer(unsigned(phase)));
    else
        time_per_level <= base_time - (200 * to_integer(unsigned(phase)));



   process(clk, reset)
   begin
        if reset = '1' then
            -- Reiniciar temporizador y contador
            fall_timer <= base_time;
            count <= 0;
            fall_signal <= '0';
        elsif (clk'event and clk = '1') then
           if count < time_per_level then
               -- Incrementar contador
               count <= count + 1;
           else
               -- Tiempo de descenso alcanzado, enviar señal de caída
               fall_signal <= '1';
               count <= 0;
           end if;
        end if;
    end process;


  end Behavioral;
