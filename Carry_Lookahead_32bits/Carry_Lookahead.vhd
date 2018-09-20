library IEEE;
use IEEE.std_logic_1164 .all;

entity Carry_Lookahead is
	port (
		A, B	: in std_logic_vector (3 downto 0);
		Cin	: in std_logic;
		Cout	: out std_logic;
		S		: out std_logic_vector (3 downto 0)
	);
end entity;

architecture comportamento of Carry_Lookahead is
	signal sig_propagate	: std_logic_vector (3 downto 0);
	signal sig_generate	: std_logic_vector (3 downto 0);
	
	signal C1, C2, C3		: std_logic;
	
	component Meio_Somador is
		port (
			A, B 	: in std_logic;	--Entradas
			S 		: out std_logic;	--Saída
			Cout 	: out std_logic);	--Carry Out
	end component;
	
	begin
		SOMADOR_0: Meio_Somador port map (
			A 		=> A(0),
			B 		=> B(0),
			S 		=> sig_propagate(0),
			Cout 	=> sig_generate(0)
		);
		SOMADOR_1: Meio_Somador port map (
			A 		=> A(1),
			B 		=> B(1),
			S 		=> sig_propagate(1),
			Cout 	=> sig_generate(1)
		);
		SOMADOR_2: Meio_Somador port map (
			A 		=> A(2),
			B 		=> B(2),
			S 		=> sig_propagate(2),
			Cout 	=> sig_generate(2)
		);
		SOMADOR_3: Meio_Somador port map (
			A 		=> A(3),
			B 		=> B(3),
			S 		=> sig_propagate(3),
			Cout 	=> sig_generate(3)
		);
		
		C1 	<= sig_generate(0) or (sig_propagate(0) and Cin);
		C2 	<= sig_generate(1) or (sig_propagate(1) and sig_generate(0)) or (sig_propagate(1) and sig_propagate(0) and Cin);
		C3 	<= sig_generate(2) or (sig_propagate(2) and sig_generate(1)) or (sig_propagate(2) and sig_propagate(1) and sig_generate(0)) or (sig_propagate(2) and sig_propagate(1) and sig_propagate(0) and Cin);
		Cout 	<= sig_generate(3) or (sig_propagate(3) and sig_generate(2)) or (sig_propagate(3) and sig_propagate(2) and sig_generate(1)) or (sig_propagate(3) and sig_propagate(2) and sig_propagate(1) and sig_generate(0)) or (sig_propagate(3) and sig_propagate(2) and sig_propagate(1) and sig_propagate(0) and Cin);
		
		S(0)	<= sig_propagate(0) xor Cin;
		S(1)	<= sig_propagate(1) xor C1;
		S(2)	<= sig_propagate(2) xor C2;
		S(3)	<= sig_propagate(3) xor C3;
		
end comportamento;