library verilog;
use verilog.vl_types.all;
entity spi_master is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        start           : in     vl_logic;
        sdata           : in     vl_logic;
        cs_n            : out    vl_logic;
        sclk            : out    vl_logic;
        adc_data        : out    vl_logic_vector(7 downto 0)
    );
end spi_master;
