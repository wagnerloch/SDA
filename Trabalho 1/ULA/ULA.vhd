library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY ULA IS
	PORT (
		Rs			: in 	std_logic_vector (4 downto 0); --Registrador fonte 1
		Rt			: in 	std_logic_vector (4 downto 0); --Registrador fonte 2
		Rd			: in 	std_logic_vector (4 downto 0); --Registrador destino
		FUNCT		: in	std_logic_vector (5 downto 0);
		intest	: in 	std_logic_vector (32 downto 0);
		teste		: out	std_logic_vector (32 downto 0)
	);
END ULA;

ARCHITECTURE ULA_ARQ OF ULA IS

type t_Memory is array (0 to 32) of std_logic_vector(32 downto 0);
signal r_Mem : t_Memory;

BEGIN
	PROCESS (Rs, Rt, Rd, FUNCT, r_Mem)
	BEGIN
		CASE FUNCT IS
			WHEN "000000" => r_Mem(to_integer(unsigned(Rd))) <= intest;
			WHEN "000001" => r_Mem(to_integer(unsigned(Rd))) <= r_Mem(to_integer(unsigned(Rs))) and r_Mem(to_integer(unsigned(Rt)));
			WHEN "000010" => r_Mem(to_integer(unsigned(Rd))) <= r_Mem(to_integer(unsigned(Rs))) or r_Mem(to_integer(unsigned(Rt)));
			WHEN OTHERS => r_Mem(to_integer(unsigned(Rd))) <= r_Mem(to_integer(unsigned(Rd)));
		END CASE;
	END PROCESS;
END ULA_ARQ;