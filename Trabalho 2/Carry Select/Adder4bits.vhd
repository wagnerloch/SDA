library IEEE;
use IEEE.std_logic_1164.all;

ENTITY Adder4bits IS
	PORT (
		a, b		: in	std_logic_vector (3 downto 0);
		cin			: in	std_logic;
		saida		: out	std_logic_vector (3 downto 0);
		cout		: out	std_logic
		);
END Adder4bits;

ARCHITECTURE Arq_Adder4bits OF Adder4bits IS

	signal c1, c2, c3: std_logic;

	component Adder1bit
		PORT (
		a, b, cin	: in	std_logic;
		saida, cout	: out	std_logic
		);
	end component;

BEGIN
	
	SC0: Adder1bit 
		PORT MAP(a => a(0), b => b(0), cin => cin, saida => saida(0), cout => c1);	
	SC1: Adder1bit 
		PORT MAP(a => a(1), b => b(1), cin => c1, saida => saida(1), cout => c2);	
	SC2: Adder1bit 
		PORT MAP(a => a(2), b => b(2), cin => c2, saida => saida(2), cout => c3);	
	SC3: Adder1bit 
		PORT MAP(a => a(3), b => b(3), cin => c3, saida => saida(3), cout => cout);

END Arq_Adder4bits;
