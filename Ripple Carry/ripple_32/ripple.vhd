-- Ripple Carry Adder de 1 bit

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity ripple is

port(
	Cin			: IN 	std_logic ;
	X, Y 		: IN 	std_logic;
	S 	 		: OUT 	std_logic;
	COUT 		: OUT 	std_logic
);

end entity;

architecture hardware of ripple is
begin
	S<=(X xor Y) xor Cin;
	COUT<= (X and Y) or (X and Cin) or (Y and Cin );
END architecture;