library IEEE;
use IEEE.std_logic_1164 .all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity Somador is
	port (
		A, B	: in std_logic_vector (31 downto 0);
		S		: out std_logic_vector (31 downto 0)
	);
end entity;

architecture comportamento of Somador is
begin
	S <= A + B;
end architecture;