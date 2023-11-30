----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.11.2023 15:40:34
-- Design Name: 
-- Module Name: Antirrebotes - Behavioral
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

entity Antirrebotes is
Port (    boton : in STD_LOGIC;
          clk : in STD_LOGIC;
          reset : in STD_LOGIC;
          filtrado : out STD_LOGIC);
end Antirrebotes;

architecture Behavioral of Antirrebotes is

    signal Q1: std_logic ;
    signal Q2: std_logic ;
    signal Q3: std_logic;
    signal flanco: std_logic;
    signal E: std_logic;
    signal T: std_logic;

    type state_anti is(S_NADA, S_BOTON);
    signal STATE: state_anti;

    constant contMAX: integer := 50;
    signal cont : integer range 0 to contMAX;

begin

-- Sincronizador
    process(clk, reset)
    begin
        if(reset= '1') then
            Q1<='0';
        elsif (clk'event and clk='1') then
            Q1<=boton;
        end if;
    end process;

    process(clk, reset)
    begin
        if(reset='1') then
            Q2 <='0';
        elsif(clk'event and clk='1') then
            Q2<=Q1;
        end if;
    end process;

-- Detector flancos
    process(clk, reset)
    begin
        if(reset='1') then
            Q3 <='0';
        elsif(clk'event and clk='1') then
            Q3<=Q2;
        end if;
    end process;

    flanco <=  Q2 and (not Q3);


-- TEMPORIZADOR
    process(clk, reset)
    begin
        if(reset = '1') then
            cont <= 0;
        elsif(clk' event and clk='1') then
            if(E ='1') then
                if(cont < contMAX) then
                    cont<= cont + 1;
                elsif(cont = contMAX) then 
                    cont <= 0; 
                end if;
            end if;
        end if;   
    end process;

    T <=    '1' when (cont = contMAX) else
            '0';

    process(clk,reset)
    begin
        if(reset= '1') then 
            STATE<= S_NADA;   
        elsif(clk'event and clk = '1') then
            case STATE is
                when S_NADA => 
                    if(flanco='1') then
                        STATE <= S_BOTON;
                    elsif (flanco = '0') then
                        STATE <=S_NADA;
                    end if;
                
                when S_BOTON => 
                    if(T = '0') then
                        STATE <= S_BOTON;
                    elsif (T = '1') then
                        STATE <=S_NADA;
                    end if;
                 end case;
         end if;                        
    end process;

    filtrado <='1' WHEN (Q2 = '1' and T ='1' and STATE = S_BOTON) ELSE '0';

    E <= '1' when (STATE = S_BOTON) else '0'; 

end Behavioral;

