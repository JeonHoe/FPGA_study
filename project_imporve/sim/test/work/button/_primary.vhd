library verilog;
use verilog.vl_types.all;
entity button is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        start           : in     vl_logic;
        stop            : in     vl_logic;
        \signal\        : out    vl_logic
    );
end button;
