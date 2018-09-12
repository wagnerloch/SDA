library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY Reg_Bank IS
	PORT (
		clk			: in 	std_logic;
		reset			: in 	std_logic;
		dadoEntrada	: in 	std_logic_vector (31 downto 0);
		regDestino	: in 	std_logic_vector (4 downto 0);
		regFonte1	: in 	std_logic_vector (4 downto 0);
		regFonte2	: in 	std_logic_vector (4 downto 0);
		dadoSaida1	: out std_logic_vector (31 downto 0);
		dadoSaida2	: out std_logic_vector (31 downto 0)
	);
END Reg_Bank;

ARCHITECTURE Reg_Bank_arq OF Reg_Bank IS

	COMPONENT Reg32 PORT (
		dados		: in	std_logic_vector (31 downto 0);
		reset		: in	std_logic;
		clk1		: in	std_logic;
		saida		: out	std_logic_vector (31 downto 0));
	END COMPONENT;
	
	--'entradas' e 'saidas', vetor de 31 posiçao, que representa os 31 "fios" que vão ligados, um em cada registrador do banco
	type entradas_type 	is array (0 to 31) of std_logic_vector(31 downto 0);
	type saidas_type		is array (0 to 31) of std_logic_vector(31 downto 0);
	signal entradas  	: entradas_type;
	signal saidas		: saidas_type;
	
	BEGIN	
		PROCESS (clk, regDestino, regFonte1, regFonte2)
		BEGIN
			entradas(to_integer(unsigned(regDestino))) <= dadoEntrada;
			dadoSaida1 <= saidas(to_integer(unsigned(regFonte1)));
			dadoSaida2 <= saidas(to_integer(unsigned(regFonte2)));
		END PROCESS;
		
		--Gera os 32 registradores conectando seus fios de entrada e saída
		GEN_REG:
		for I in 0 to 31 generate
			registradores	: Reg32 port map (
				dados => entradas(to_integer(unsigned(regDestino))),
				reset => reset,
				clk1	=> clk,
				saida => saidas(I)
			);
		end generate GEN_REG;
	
END Reg_Bank_arq;