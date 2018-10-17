-- Quando itera, estou pulando de ler a primeira linha

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

ENTITY somador_tb IS
END somador_tb;

ARCHITECTURE behavior OF somador_tb IS 

	component RegN IS
		GENERIC (N 		: integer := 32);
		PORT (
			entrada		: in	std_logic_vector (N-1 downto 0);
			reset			: in	std_logic;
			clock			: in	std_logic;
			enable		: in 	std_logic;
			saida			: out	std_logic_vector (N-1 downto 0)
			);
	END component;

	component Somador IS
		port (
			A, B			: in std_logic_vector (31 downto 0);
			reset			: in	std_logic;
			clk			: in	std_logic;
			enable		: in 	std_logic;
			S				: out std_logic_vector (31 downto 0)
		);
	END component;

   function str_to_stdvec(inp: string) return std_logic_vector is
	variable temp: std_logic_vector(inp'range);
	begin
		for i in inp'range loop
			if (inp(i) = '1') then
				temp(i) := '1';
			elsif (inp(i) = '0') then
				temp(i) := '0';
			end if;
		end loop;
		return temp;
	end function str_to_stdvec;

	function stdvec_to_str(inp: std_logic_vector) return string is
		variable temp: string(inp'left+1 downto 1);
	begin
		for i in inp'reverse_range loop
			if (inp(i) = '1') then
				temp(i+1) := '1';
			elsif (inp(i) = '0') then
				temp(i+1) := '0';
			end if;
		end loop;
		return temp;
	end function stdvec_to_str;

	SIGNAL clk :  std_logic := '0';
	SIGNAL reset :  std_logic := '0';

	signal a, b: std_logic_vector(31 downto 0);
	signal result : std_logic_vector(31 downto 0);

	
	file filea, fileb, out_somador: text;
	
BEGIN
	
	uut1: Somador
	port map (a, b, reset, clk, '1', result);

	clock: PROCESS
	BEGIN	
		clk <= '1', '0' AFTER 5ns;
		WAIT FOR 10 ns;
	END PROCESS;
	
	   
	reset <= '1','0' after 300 ns;
		
	stimulus_in: process
	
		variable inline: line;
		variable out0: std_logic_vector(31 downto 0);
		variable str_out0: string(33 downto 1);
		variable outline: line;	
		variable sample: string(32 downto 1);
		
	begin
		FILE_OPEN(filea, "filea.txt", READ_MODE);
		FILE_OPEN(fileb, "fileb.txt", READ_MODE);		
		FILE_OPEN(out_somador, "out_somador.txt",WRITE_MODE);
		
		wait until (reset = '0');
		while not endfile(filea) loop
			readline(filea, inline);
			read(inline, sample);
			a <= str_to_stdvec(sample);
			readline(fileb, inline);
			read(inline, sample);
			b <= str_to_stdvec(sample);
			wait until(clk'event and clk = '1');
			wait until(clk'event and clk = '1');
			wait until(clk'event and clk = '1');
			wait until(clk'event and clk = '1');

			-- sucesso
			out0 := result;
			str_out0 := stdvec_to_str(out0);
			write(outline, str_out0);
			writeline(out_somador, outline);
		end loop;		
		
		file_close(filea);
		file_close(fileb);
		file_close(out_somador);
	end process;
	
end architecture;
