library IEEE;
use IEEE.std_logic_1164 .all;

entity Carry_Lookahead_32bits is
	port (
		A, B	: in std_logic_vector (31 downto 0);
		Cin	: in std_logic;
		Cout	: out std_logic;
		S		: out std_logic_vector (31 downto 0)
	);
end entity;

architecture comportamento of Carry_Lookahead_32bits is
	signal SP	: std_logic_vector (31 downto 0);
	signal SG	: std_logic_vector (31 downto 0);
	
	type sig_carry is array (1 to 31) of std_logic;
	signal C : sig_carry;
	
	component Meio_Somador is
		port (
			A, B 	: in std_logic;	--Entradas
			S 		: out std_logic;	--Saída
			Cout 	: out std_logic);	--Carry Out
	end component;	
	
	begin
	GERADOR: for i in 0 to 31 generate
		SOMADORES: Meio_Somador port map (
			A		=> A(i),
			B		=> B(i),
			S		=> SP(i),
			Cout	=> SG(i)
		);
	end generate;
		
		process (A, B, Cin)
		begin
			--C(i) = G(i-1) + P(i-1) . C(i-1)
			C(1)		<= SG(0) or (SP(0) and Cin);			
			for i in 2 to 31 loop
				C(i)	<= SG(i-1) or (SP(i-1) and C(i-1));
			end loop;			
			Cout <= SG(31) or (SP(31) and C(31));
			
			---------------------------------------------------------
			
			--Gera saída através do propagate
			S(0)	<= SP(0) xor Cin;			
			for i in 1 to 31 loop
				S(i) <= SP(i) xor C(i);
			end loop;
		end process;
		
end comportamento;