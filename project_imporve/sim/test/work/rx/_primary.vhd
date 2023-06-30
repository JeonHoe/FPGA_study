library verilog;
use verilog.vl_types.all;
entity rx is
    generic(
        MAX             : integer := 5208
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        rxd             : in     vl_logic;
        rx_data         : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of MAX : constant is 1;
end rx;
