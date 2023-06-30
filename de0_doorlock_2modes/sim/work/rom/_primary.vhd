library verilog;
use verilog.vl_types.all;
entity rom is
    generic(
        D_WIDTH         : integer := 8;
        A_WIDTH         : integer := 5
    );
    port(
        clk             : in     vl_logic;
        addr            : in     vl_logic_vector;
        data            : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of D_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of A_WIDTH : constant is 1;
end rom;
