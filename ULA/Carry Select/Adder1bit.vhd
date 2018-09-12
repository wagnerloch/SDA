library IEEE;
use IEEE.std_logic_1164.all;

ENTITY Reg32 IS
	PORT (
		dados		: in	std_logic_vector (31 downto 0);
		reset		: in	std_logic;
		clk1		: in	std_logic;
		saida		: out	std_logic_vector (31 downto 0)
		);
END Reg32;

ARCHITECTURE Arq_Reg32 OF Reg32 IS

BEGIN
	process(clk1)
	begin
		if(clk1'event and clk1='1') then
			CASE reset IS
				WHEN '1' => saida <= "00000000000000000000000000000000";
				WHEN OTHERS => saida <= dados;
			END CASE;
		end if;
	end process;

END Arq_Reg32;
