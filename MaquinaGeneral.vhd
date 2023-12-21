----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2023 21:45:23
-- Design Name: 
-- Module Name: MaquinaGeneral - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity MaquinaGeneral is

    Port (  clk     : in std_logic;
            reset   : in std_logic;
            looser  : in std_logic;
            win     : in std_logic;
            timex   : in std_logic;
            pause   : in std_logic;
            start   : in std_logic;
            fase    : in std_logic;
            disp    : out std_logic_vector (1 downto 0)
            );

end MaquinaGeneral;

architecture Behavioral of MaquinaGeneral is

    type State_t is (ESPERA, JUEGO, PAUSA, PIERDES, FIN);
    signal STATE    : State_t;

begin

    process(clk, reset)
    begin
        if (reset = '1') then 
            STATE <= ESPERA;
        elsif (clk'event and clk = '1') then
            case STATE is
                when ESPERA =>
                    if (start = '1') then
                        STATE <= JUEGO;
                    end if;
                    
                when JUEGO =>
                    if (pause = '1') then
                        STATE <= PAUSA;
                    elsif (looser = '1') then
                        STATE <= PIERDES;
                    elsif (win = '1') then
                        STATE <= FIN;                    
                    end if;
                
                when PAUSA =>
                    if (start = '1') then
                        STATE <= JUEGO;
                    end if;
                
                when PIERDES =>
                    if (timex = '1') then
                        STATE <= FIN;
                    end if;
                    
                when FIN =>
                    
            end case;
        end if;
    end process;

-- display parpadea cuando es 01, muestra el número de fase cuando es 10, en el resto es 00 y sigue el juego.
    disp <= "01" when (STATE = PIERDES) else
            "10" when (STATE = FIN)
            else "00"; 

end Behavioral;
