library IEEE;
use IEEE.std_logic_1164.all;

ENTITY Adder1bit IS
	PORT (
		cin, a, b	: in	std_logic;
		saida, cout	: out	std_logic
		);
END Adder1bit;

ARCHITECTURE Arq_Adder1bit OF Adder1bit IS

BEGIN
	
	saida <= a XOR b XOR cin;
	cout <= (a AND b) OR (a AND cin) OR (b AND cin);

END Arq_Adder1bit;
