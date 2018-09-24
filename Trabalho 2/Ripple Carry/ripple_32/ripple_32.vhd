-- Ripple Carry Adder de 32 bits

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


entity ripple_32 is

port(
	X, Y 		: IN 	std_logic_vector(31 downto 0);
	clock		: IN std_logic;
	S 	 		: OUT 	std_logic_vector(31 downto 0);
	COUT 		: OUT 	std_logic
);

end entity;

architecture hardware of ripple_32 is

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

	component ripple PORT (
		Cin			: IN 	std_logic ;
		X, Y 		: IN 	std_logic;
		S 	 		: OUT 	std_logic;
		COUT 		: OUT 	std_logic
	);
	end component;
	
	signal carry: std_logic_vector(31 downto 0);
	signal sinalA : std_logic_vector(31 downto 0);
	signal sinalB	: std_logic_vector (31 downto 0);
	signal sinalS	: std_logic_vector (31 downto 0);

begin
	R0 : RegN
		GENERIC MAP (N => 32)
		PORT MAP (
			entrada 	=> X,
			reset		=> '0',
			clock		=> clock,
			enable	=>	'1',
			saida		=>	sinalA
		);
	R1 : RegN
		GENERIC MAP (N => 32)
		PORT MAP (
			entrada 	=> Y,
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
	
	chamada0: ripple
		port map(Cin=>'0', X=>sinalA(0), Y=>sinalB(0), S=>sinalS(0), COUT=>carry(0));
	
	G: for I in 1 to 30 generate
      chamada : ripple 
		port map(Cin=>carry(i-1), X=>sinalA(i), Y=>sinalB(i), S=>sinalS(i), COUT=>carry(i));
   end generate G;
	
	chamada31: ripple
		port map(Cin=>carry(30), X=>sinalA(31), Y=>sinalB(31), S=>sinalS(31), COUT=>COUT);
	
END architecture;