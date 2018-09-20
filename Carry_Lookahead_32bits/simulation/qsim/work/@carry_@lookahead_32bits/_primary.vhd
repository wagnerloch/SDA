library verilog;
use verilog.vl_types.all;
entity Carry_Lookahead_32bits is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        Cin             : in     vl_logic;
        Cout            : out    vl_logic;
        S               : out    vl_logic_vector(31 downto 0)
    );
end Carry_Lookahead_32bits;
