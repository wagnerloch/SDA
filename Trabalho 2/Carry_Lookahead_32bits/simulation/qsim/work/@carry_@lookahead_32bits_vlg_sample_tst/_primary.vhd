library verilog;
use verilog.vl_types.all;
entity Carry_Lookahead_32bits_vlg_sample_tst is
    port(
        A               : in     vl_logic_vector(31 downto 0);
        B               : in     vl_logic_vector(31 downto 0);
        Cin             : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end Carry_Lookahead_32bits_vlg_sample_tst;
