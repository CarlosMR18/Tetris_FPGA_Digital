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
Port (clk : in std_logic;  -- Reloj del sistema
      reset : in std_logic;  -- Señal de reinicio
      MiPieza_ND : in unsigned(2 downto 0);
      MiPieza_TP: in unsigned(6 downto 0);
      -- inicio_flag: out std_logic
 );
end DescensoFichas;

architecture Behavioral of DescensoFichas is
    
	--constant frec_max: integer:=125000000;
	constant frec_2: integer:=125000000*(2-(MiPieza_ND*0.2));
	constant frec_1: integer:=125000000*(2-(MiPieza_ND*0.1));
	signal cont_2: integer range 0 to frec_2;
	signal cont_1: integer range 0 to frec_1;
	signal enable_flag: std_logic;
	
begin

   process(clk, reset)
   begin
        if reset = '1' then
           cont_2<=0;
	   cont_1<=0;
        elsif (clk'event and clk = '1') then
		if (MiPieza_TP=...)	
			if (cont_1=frec_1-1)
				cont_1<=0;
			else
				cont_1<=cont_1+1;
			end if;
		else
		    	if (cont_2=frec_2-1)
				cont_2<=0;
			else
				cont_2<=cont_2+1;
			end if;
	end if;
    end process;

  enable_flag<='1' when ((cont_2=cont_2-1) or (cont_1=cont_1-1)) else '0';
  end Behavioral;
