library verilog;
use verilog.vl_types.all;
entity final_03 is
    generic(
        max             : integer := 8;
        over_max        : integer := 7;
        over_min        : integer := -8
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        result          : out    vl_logic_vector(3 downto 0);
        sclk            : in     vl_logic;
        ss              : in     vl_logic;
        mosi            : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of max : constant is 1;
    attribute mti_svvh_generic_type of over_max : constant is 1;
    attribute mti_svvh_generic_type of over_min : constant is 1;
end final_03;
