library IEEE;
use IEEE.std_logic_1164 .all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity Somador is
	port (
		A, B	: in std_logic_vector (31 downto 0);
		reset		: in	std_logic;
		clk		: in	std_logic;
		enable		: in 	std_logic;
		S		: out std_logic_vector (31 downto 0)
	);
end entity;

architecture comportamento of Somador is

signal fio: std_logic_vector (31 downto 0);
signal fio2: std_logic_vector (31 downto 0);
signal fio3: std_logic_vector (31 downto 0);

component RegN IS
	GENERIC (N 		: integer := 32);
	PORT (
		entrada		: in	std_logic_vector (N-1 downto 0);
		reset		: in	std_logic;
		clock		: in	std_logic;
		enable		: in 	std_logic;
		saida		: out	std_logic_vector (N-1 downto 0)
		);
END component;

begin

	REGISTRADOR1 : RegN
	GENERIC MAP (N => 32)
			PORT MAP (
				entrada 	=> A,
				reset		=> reset,
				clock		=> clk,
				enable	=> '1',
				saida		=> fio
			);
			
			REGISTRADOR3 : RegN
	GENERIC MAP (N => 32)
			PORT MAP (
				entrada 	=> B,
				reset		=> reset,
				clock		=> clk,
				enable	=> '1',
				saida		=> fio3
			);

	fio2 <= fio + fio3;
	
	REGISTRADOR2 : RegN
				GENERIC MAP (N => 32)
				PORT MAP (
					entrada 	=> fio2,
					reset		=> reset,
					clock		=> clk,
					enable	=> '1',
					saida		=> S
				);

end architecture;