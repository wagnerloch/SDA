-- Ripple Carry Adder de 32 bits

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


entity ripple_32 is

port(
	X, Y 		: IN 	std_logic_vector(31 downto 0);
	S 	 		: OUT 	std_logic_vector(31 downto 0);
	COUT 		: OUT 	std_logic
);

end entity;

architecture hardware of ripple_32 is

	component ripple PORT (
		Cin			: IN 	std_logic ;
		X, Y 		: IN 	std_logic;
		S 	 		: OUT 	std_logic;
		COUT 		: OUT 	std_logic
	);
	end component;
	
	signal carry: std_logic_vector(31 downto 0);

begin
	
	chamada0: ripple
		port map(Cin=>'0', X=>X(0), Y=>Y(0), S=>S(0), COUT=>carry(0));
	
	G: for I in 1 to 30 generate
      chamada : ripple 
		port map(Cin=>carry(i-1), X=>X(i), Y=>Y(i), S=>S(i), COUT=>carry(i));
   end generate G;
	
	chamada31: ripple
		port map(Cin=>carry(30), X=>X(31), Y=>Y(31), S=>S(31), COUT=>COUT);
	
END architecture;