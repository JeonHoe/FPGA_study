library verilog;
use verilog.vl_types.all;
entity top is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        start           : in     vl_logic;
        sdata           : in     vl_logic;
        sel             : in     vl_logic;
        cs_n            : out    vl_logic;
        sclk            : out    vl_logic;
        txd             : out    vl_logic;
        fnd_h           : out    vl_logic_vector(6 downto 0);
        fnd_l           : out    vl_logic_vector(6 downto 0)
    );
end top;
