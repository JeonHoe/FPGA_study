library verilog;
use verilog.vl_types.all;
entity uart_str is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        start           : in     vl_logic;
        adc_data        : in     vl_logic_vector(7 downto 0);
        tx_stop         : in     vl_logic;
        load            : out    vl_logic;
        data            : out    vl_logic_vector(4 downto 0)
    );
end uart_str;
