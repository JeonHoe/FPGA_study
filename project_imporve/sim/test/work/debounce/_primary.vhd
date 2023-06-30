library verilog;
use verilog.vl_types.all;
entity debounce is
    generic(
        T_ONE_SEC       : vl_logic_vector(0 to 25) := (Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        T_20MS          : vl_logic_vector(0 to 19) := (Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        N               : integer := 20
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        din             : in     vl_logic;
        dout            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T_ONE_SEC : constant is 1;
    attribute mti_svvh_generic_type of T_20MS : constant is 1;
    attribute mti_svvh_generic_type of N : constant is 1;
end debounce;
