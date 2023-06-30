library verilog;
use verilog.vl_types.all;
entity timer is
    generic(
        TIME            : vl_logic_vector(0 to 27) := (Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0)
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        \signal\        : in     vl_logic;
        count           : in     vl_logic_vector(3 downto 0);
        flag            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TIME : constant is 1;
end timer;
