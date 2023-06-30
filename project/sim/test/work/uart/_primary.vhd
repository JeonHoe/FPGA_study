library verilog;
use verilog.vl_types.all;
entity uart is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        sel             : in     vl_logic;
        tx_data         : in     vl_logic_vector(7 downto 0);
        load            : in     vl_logic;
        rxd             : in     vl_logic;
        txd             : out    vl_logic;
        tx_stop         : out    vl_logic;
        rx_data         : out    vl_logic_vector(7 downto 0)
    );
end uart;
