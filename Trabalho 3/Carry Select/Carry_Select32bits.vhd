library IEEE;
use IEEE.std_logic_1164.all;

ENTITY Carry_Select32bits IS
	PORT (
		a, b				: in	std_logic_vector (31 downto 0);
		cin				: in	std_logic;
		clock				: in std_logic;
		saida				: out	std_logic_vector (31 downto 0);
		cout0, cout1	: out	std_logic
		);
END Carry_Select32bits;

ARCHITECTURE Arq_Carry_Select32bits OF Carry_Select32bits IS

	signal s_carry0, s_carry1: std_logic_vector (8 downto 0);
	signal sinalA	: std_logic_vector (31 downto 0);
	signal sinalB	: std_logic_vector (31 downto 0);
	signal sinalS	: std_logic_vector (31 downto 0);
	
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

	component Carry_Select4bits
		PORT (
			a, b			: in	std_logic_vector (3 downto 0);
			cin				: in	std_logic;
			saida			: out	std_logic_vector (3 downto 0);
			cout0, cout1	: out	std_logic
		);
	end component;

BEGIN


	R0 : RegN
		GENERIC MAP (N => 32)
		PORT MAP (
			entrada 	=> a,
			reset		=> '0',
			clock		=> clock,
			enable	=>	'1',
			saida		=>	sinalA
		);
	R1 : RegN
		GENERIC MAP (N => 32)
		PORT MAP (
			entrada 	=> b,
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
			saida		=>	saida
		);
	
	Carry_Select_Block1: Carry_Select4bits
			PORT MAP(a => sinalA(3 downto 0), b => sinalB(3 downto 0), cin => cin, saida => sinalS(3 downto 0),
			cout0 => s_carry0(1), cout1 => s_carry1(1));
	G1: FOR i IN 2 TO 8 GENERATE
		Carry_Select_Block: Carry_Select4bits
			PORT MAP(a => sinalA((i*4)-1 downto ((i*4)-4)), b => sinalB((i*4)-1 downto ((i*4)-4)), 
			cin => (s_carry0(i-1) OR (s_carry1(i-1) AND s_carry1(i-2))), saida => sinalS((i*4)-1 downto (i*4)-4),
			cout0 => s_carry0(i), cout1 => s_carry1(i));
	END GENERATE;
	cout0 <= s_carry0(8);
	cout1 <= s_carry1(8);

END Arq_Carry_Select32bits;
