library IEEE;
use IEEE.STD_LOGIC_1164.ALL; --(std_logic; std_logic_vector)
use IEEE.NUMERIC_STD.ALL;

entity LFSR is
Port (	clk : in std_logic;
        reset : in std_logic;
        lfsr_out : out std_logic);
end LFSR;


	
architecture Behavioral of LFSR is	

    signal lfsr_reg : std_logic_vector(3 downto 0);

begin
    process(clk, reset)
    begin
        if (reset = '1') then
            --lfsr_reg <= (others => '0');  No inicio LFSR con señal reset			
        elsif (clk'event and clk = '1') then
            -- Lógica del LFSR
            lfsr_reg(3 downto 1) <= lfsr_reg(2 downto 0);
            lfsr_reg(0) <= lfsr_reg(3) xor lfsr_reg(2); 
        end if;
    end process;
    
    lfsr_out <= lfsr_reg(3);

end Behavioral;
