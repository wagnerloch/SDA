library IEEE;
use IEEE.std_logic_1164 .all;
 
entity Meio_Somador is
	port(
		A, B 	: in std_logic;	--Entradas
		S 		: out std_logic;	--Saída
		Cout 	: out std_logic);	--Carry Out
end entity;
 
architecture comportamento of Meio_Somador is
begin
  process(A,B)
  begin
    S <= A xor B;
    Cout <= A and B;
  end process;
end comportamento;