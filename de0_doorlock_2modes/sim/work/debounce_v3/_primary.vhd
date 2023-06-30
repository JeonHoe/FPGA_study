library verilog;
use verilog.vl_types.all;
entity debounce_v3 is
    generic(
        N               : integer := 3;
        T_20MS          : vl_logic_vector(0 to 2) := (Hi0, Hi0, Hi0);
        D_INIT          : vl_logic := Hi0
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        din             : in     vl_logic;
        dout            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of N : constant is 1;
    attribute mti_svvh_generic_type of T_20MS : constant is 1;
    attribute mti_svvh_generic_type of D_INIT : constant is 1;
end debounce_v3;
