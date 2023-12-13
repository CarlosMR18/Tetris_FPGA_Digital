----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2023 12:01:19
-- Design Name: 
-- Module Name: MovFichas - Behavioral
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
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MovFichas is
Port ( clk : in STD_LOGIC;  -- Reloj del sistema
       reset : in STD_LOGIC;  -- Señal de reinicio
       level : in STD_LOGIC_VECTOR (3 downto 0);  -- Cada linea del juego
       phase : in STD_LOGIC_VECTOR (7 downto 0);  -- Nivel del juego
       move_left : in STD_LOGIC;  -- Mover ficha a la izquierda
       move_right : in STD_LOGIC;  -- Mover ficha a la derecha
       rotate_left: in STD_LOGIC;
       rotate_right: in STD_LOGIC;
       piece_position : out STD_LOGIC_VECTOR (7 downto 0)  -- Posición de la ficha: cuadruple 1, simple 3, doble 4
       tipo_ficha_flag : in STD_LOGIC_VECTOR (14 downto 0); --De 0 a 10 las iniciales, y las demás las 4 L que se pueden formar abajo 
      );
end MovFichas;

architecture Behavioral of MovFichas is
    signal timer : integer := 2000;  -- Tiempo de descenso inicial en milisegundos
    signal current_position : integer range 0 to 7 := 0;  -- Posición actual de la ficha
begin
    process(clk, reset)
    begin
        if reset = '1' then
            -- Reiniciar posición y temporizador
            current_position <= 0;
            timer <= 2000;
        elsif (clk'event and clk = '1') then
            -- Ajustar el temporizador basado en el nivel
            if (tipo_ficha_flag < 5) then
                timer <= 2000 - (200 * to_integer(unsigned(phase)));
            else
                timer <= 2000 - (100 * to_integer(unsigned(phase)));


            --IGNORAR:
            -- Mover ficha a la izquierda o derecha
            if move_left = '1' and current_position > 0 then
                current_position <= current_position - 1;
            elsif move_right = '1' and current_position < 7 then
                current_position <= current_position + 1;
            end if;
        end if;
    end process;
    
     piece_position <= std_logic_vector(to_unsigned(current_position, 8)); --Asignar la posicion de la ficha para la salida

end Behavioral;
