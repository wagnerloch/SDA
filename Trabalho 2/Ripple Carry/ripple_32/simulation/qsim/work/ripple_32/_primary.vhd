library verilog;
use verilog.vl_types.all;
entity ripple_32 is
    port(
        X               : in     vl_logic_vector(31 downto 0);
        Y               : in     vl_logic_vector(31 downto 0);
        S               : out    vl_logic_vector(31 downto 0);
        COUT            : out    vl_logic
    );
end ripple_32;
