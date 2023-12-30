----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.12.2023 10:40:33
-- Design Name: 
-- Module Name: Antirrebotes_top - Behavioral
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

entity Antirrebotes_top is
  Port (
        clk :               in std_logic;
        reset :             in std_logic;
        
        B_pausa :           in std_logic;
        B_start_resume :    in std_logic; 
        B_reset :           in std_logic; 
        B_m_dcha :          in std_logic;
        B_m_izq :           in std_logic;
        B_g_dcha :          in std_logic;
        B_g_izq :           in std_logic);
        
        
end Antirrebotes_top;

architecture Behavioral of Antirrebotes_top is

    component Antirrebotes is
        port(
            boton :     in std_logic;
            clk :       in std_logic;
            reset :     in std_logic;
            filtrado :  out std_logic);
    end component;
    
    -- señales internas--
    signal Pausa :          std_logic;
    signal Start_Resume :   std_logic;
    signal Reset_juego :    std_logic;
    signal M_dcha :         std_logic;
    signal M_izq :          std_logic;
    signal G_dcha :         std_logic;
    signal G_izq :          std_logic;


begin

    Anti_pausa: Antirrebotes
    port map(
        clk       => clk,
        reset     => reset,
        boton     => B_pausa,
        filtrado  => Pausa );  
        
     Anti_start: Antirrebotes
     port map(
        clk       => clk,
        reset     => reset,
        boton     => B_start_resume,
        filtrado  => Start_Resume );    
        
     Anti_reset: Antirrebotes
     port map(
        clk       => clk,
        reset     => reset,
        boton     => B_reset,
        filtrado  => Reset_juego ); 
     
     Anti_m_dcha: Antirrebotes
     port map(
        clk       => clk,
        reset     => reset,
        boton     => B_m_dcha,
        filtrado  => M_dcha ); 

     Anti_m_izq: Antirrebotes
     port map(
        clk       => clk,
        reset     => reset,
        boton     => B_m_izq,
        filtrado  => M_izq );        

     Anti_g_dcha: Antirrebotes
     port map(
        clk       => clk,
        reset     => reset,
        boton     => B_g_dcha,
        filtrado  => G_dcha );
        
     Anti_g_izq: Antirrebotes
     port map(
        clk       => clk,
        reset     => reset,
        boton     => B_g_izq,
        filtrado  => G_izq );


end Behavioral;

