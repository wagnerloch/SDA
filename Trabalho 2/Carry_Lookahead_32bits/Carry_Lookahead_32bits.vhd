library IEEE;
use IEEE.std_logic_1164 .all;

entity Carry_Lookahead_32bits is
	port (
		A, B	: in std_logic_vector (31 downto 0);
		Cin	: in std_logic;
		clock	: in std_logic;
		Cout	: out std_logic;
		S		: out std_logic_vector (31 downto 0)
	);
end entity;

architecture comportamento of Carry_Lookahead_32bits is
	signal sinalA	: std_logic_vector (31 downto 0);
	signal sinalB	: std_logic_vector (31 downto 0);
	signal sinalS	: std_logic_vector (31 downto 0);
	signal SP		: std_logic_vector (31 downto 0);
	signal SG		: std_logic_vector (31 downto 0);
	
	type sig_carry is array (1 to 31) of std_logic;
	signal C : sig_carry;
	
	COMPONENT RegN IS
		GENERIC (N 		: integer := 32);
		PORT (
			entrada		: in	std_logic_vector (N-1 downto 0);
			reset		: in	std_logic;
			clock		: in	std_logic;
			enable		: in 	std_logic;
			saida		: out	std_logic_vector (N-1 downto 0)
		);
	END COMPONENT;
	
	component Meio_Somador is
		port (
			A, B 	: in std_logic;	--Entradas
			S 		: out std_logic;	--Saída
			Cout 	: out std_logic);	--Carry Out
	end component;	
	
	begin
	
	R0 : RegN
		GENERIC MAP (N => 32)
		PORT MAP (
			entrada 	=> A,
			reset		=> '0',
			clock		=> clock,
			enable	=>	'1',
			saida		=>	sinalA
		);
	R1 : RegN
		GENERIC MAP (N => 32)
		PORT MAP (
			entrada 	=> B,
			reset		=> '0',
			clock		=> clock,
			enable	=>	'1',
			saida		=>	sinalB
		);
	R2 : RegN
		GENERIC MAP (N => 32)
		PORT MAP (
			entrada 	=> sinalS,
			reset		=> '0',
			clock		=> clock,
			enable	=>	'1',
			saida		=>	S
		);
	
	GERADOR: for i in 0 to 31 generate
		SOMADORES: Meio_Somador port map (
			A		=> sinalA(i),
			B		=> sinalB(i),
			S		=> SP(i),
			Cout	=> SG(i)
		);
	end generate;
		
		process (sinalA, sinalB, Cin)
		begin
			--C(i) = G(i-1) + P(i-1) . C(i-1)
			C(1)		<= SG(0) or (SP(0) and Cin);			
			for i in 2 to 31 loop
				C(i)	<= SG(i-1) or (SP(i-1) and C(i-1));
			end loop;			
			Cout <= SG(31) or (SP(31) and C(31));
			
			---------------------------------------------------------
			
			--Gera saída através do propagate
			sinalS(0)	<= SP(0) xor Cin;			
			for i in 1 to 31 loop
				sinalS(i) <= SP(i) xor C(i);
			end loop;
		end process;
		
end comportamento;