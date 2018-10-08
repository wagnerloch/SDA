library IEEE;
use IEEE.std_logic_1164.all;

ENTITY Carry_Select4bits IS
	PORT (
		a, b			: in	std_logic_vector (3 downto 0);
		cin				: in	std_logic;
		saida			: out	std_logic_vector (3 downto 0);
		cout0, cout1	: out	std_logic
		);
END Carry_Select4bits;

ARCHITECTURE Arq_Carry_Select4bits OF Carry_Select4bits IS

	signal aux0, aux1: std_logic_vector (3 downto 0);

	component Adder4bits
		PORT (
			a, b		: in	std_logic_vector (3 downto 0);
			cin			: in	std_logic;
			saida		: out	std_logic_vector (3 downto 0);
			cout		: out	std_logic
		);
	end component;

	component Mux8x4
		PORT (
			in0, in1	: in	std_logic_vector (3 downto 0);
			sel			: in	std_logic;
			saida		: out	std_logic_vector (3 downto 0)
		);
	end component;

BEGIN
	
	Carry_Select_Adder0: Adder4bits
		PORT MAP(a => a, b => b, cin => '0', saida => aux0, cout => cout0);
	Carry_Select_Adder1: Adder4bits
		PORT MAP(a => a, b => b, cin => '1', saida => aux1, cout => cout1);
	Carry_Select_Mux: Mux8x4
		PORT MAP(in0 => aux0, in1 => aux1, sel => cin, saida => saida);

END Arq_Carry_Select4bits;
