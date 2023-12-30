----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 7.12.2023 10:09:15
-- Design Name: 
-- Module Name: estructura - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity estructura is
  Port (
        clk :           in std_logic;
        reset :         in std_logic;
        

        
        led :           out std_logic_vector (7 downto 0);
        segments :      out std_logic_vector (7 downto 0);
        selector :      out std_logic_vector (3 downto 0));
         

end estructura;

architecture Behavioral of estructura is
    component Secuencia_FSM is
        port(
             clk          :        in STD_LOGIC;
             reset        :        in STD_LOGIC;
             pausa        :        in std_logic;
             start_resume :        in std_logic; 
             reset_juego  :        in std_logic; 
             m_dcha       :        in std_logic;
             m_izq        :        in std_logic;
             g_dcha       :        in std_logic;
             g_izq        :        in std_logic);
             --faltan (o sobran) cosas, esta empezado para darnos una idea
    end component;
    

    
    --faltan components
    
    --Señales internas--
    signal pausa :          std_logic;
    signal start_resume :   std_logic;
    signal reset_juego :    std_logic;
    signal m_dcha :         std_logic;
    signal m_izq :          std_logic;
    signal g_dcha :         std_logic;
    signal g_izq :          std_logic;
    --faltan señales internas
    

begin

    FSM : Secuencia_FSM
    port map(
        clk            => clk,
        reset          => reset,
        pausa          =>  pausa,
        start_resume   => start_resume,
        reset_juego    => reset_juego, 
        m_dcha         => m_dcha,
        m_izq          => m_izq,
        g_dcha         => g_dcha,
        g_izq          => g_izq );
        
     


end Behavioral;
