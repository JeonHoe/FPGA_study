library verilog;
use verilog.vl_types.all;
entity debounce_v0 is
    generic(
        N               : integer := 3
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        din             : in     vl_logic;
        dout            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
end debounce_v0;
