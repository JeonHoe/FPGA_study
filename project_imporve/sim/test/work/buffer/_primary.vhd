library verilog;
use verilog.vl_types.all;
entity \buffer\ is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        \in\            : in     vl_logic_vector(3 downto 0);
        sel1            : in     vl_logic;
        sel2            : in     vl_logic;
        sel3            : in     vl_logic;
        \out\           : out    vl_logic_vector(3 downto 0)
    );
end \buffer\;
