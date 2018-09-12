library IEEE;
use IEEE.std_logic_1164.all;

ENTITY Mux8x4 IS
	PORT (
		in0, in1	: in	std_logic_vector (3 downto 0);
		sel			: in	std_logic;
		saida		: out	std_logic_vector (3 downto 0)
		);
END Mux8x4;

ARCHITECTURE Arq_Mux8x4 OF Mux8x4 IS

BEGIN
	
	WITH sel SELECT 
	saida <=	in0 when '0',
				in1 when OTHERS;

END Arq_Mux8x4;
