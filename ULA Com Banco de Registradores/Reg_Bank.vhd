library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY Reg_Bank IS
	PORT (
		clk			: in 	std_logic;
		reset			: in 	std_logic;
		regDestino	: in 	std_logic_vector (4 downto 0);
		regFonte1	: in 	std_logic_vector (4 downto 0);
		regFonte2	: in 	std_logic_vector (4 downto 0);
		FUNCT			: in std_logic_vector (5 downto 0) --Função ULA
	);
END Reg_Bank;

ARCHITECTURE comportamento OF Reg_Bank IS

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

	--'saidas', vetor de 31 posiçao, que representa os 31 "fios" que vão ligados, um em cada registrador do banco
	type saidas_type	is array (0 to 31) of std_logic_vector(31 downto 0);
	signal saidas		: saidas_type;
	signal enable		: std_logic_vector (31 downto 0);
	signal dadoEntrada: std_logic_vector (31 downto 0);
	signal dadoSaida1 : std_logic_vector (31 downto 0);
	signal dadoSaida2 : std_logic_vector (31 downto 0);
	
	BEGIN
	
		PROCESS (clk, regDestino, regFonte1, regFonte2)
		BEGIN
			for i in 0 to 31 loop
				enable(i) <= '0';
			end loop;
			enable(to_integer(unsigned(regDestino))) <= '1';
			dadoSaida1 <= saidas(to_integer(unsigned(regFonte1)));
			dadoSaida2 <= saidas(to_integer(unsigned(regFonte2)));
		END PROCESS;
		
		GEN_REG: for i in 0 to 31 generate
			REGISTRADOR : RegN
				GENERIC MAP (N => 32)
				PORT MAP (
					entrada 	=> dadoEntrada,
					reset		=> reset,
					clock		=> clk,
					enable	=> enable(i),
					saida		=> saidas(i)
				);
		END generate GEN_REG;
				
		WITH FUNCT SELECT
			dadoEntrada <= 	dadoSaida1 + dadoSaida2 WHEN "000000",
									dadoSaida1 - dadoSaida2 WHEN "000001",
									(dadoSaida1 and dadoSaida2) or not(dadoSaida1) WHEN "000010",
									dadoSaida1 and dadoSaida2 WHEN "000011",
									dadoSaida1 or dadoSaida2 WHEN "000100",
									not(dadoSaida1) WHEN "000101",
									dadoSaida1 WHEN OTHERS;
END comportamento;