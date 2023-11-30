library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;

entity LFSR is
Port (	clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        lfsr_out : out STD_LOGIC);
end LFSR;


	
architecture Behavioral of LFSR is	
	
    signal lfsr_reg : STD_LOGIC_VECTOR(3 downto 0) := "0000";

begin
    process(clk, reset)
    begin
        if (reset = '1') then
            lfsr_reg <= (others => '0'); -- Reinicio LFSR para señal reset
			--lfsr_reg <= "0000";  
        elsif (clk'event and clk = '1') then
            -- Lógica del LFSR
            lfsr_reg(0) <= lfsr_reg(3) xor lfsr_reg(2);
            lfsr_reg(1) <= lfsr_reg(0);
            lfsr_reg(2) <= lfsr_reg(1);
            lfsr_reg(3) <= lfsr_reg(2);
        end if;
    end process;

    lfsr_out <= lfsr_reg(3);

end Behavioral;
