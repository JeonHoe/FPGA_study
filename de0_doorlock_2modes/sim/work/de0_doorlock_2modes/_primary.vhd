library verilog;
use verilog.vl_types.all;
entity de0_doorlock_2modes is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        star            : in     vl_logic;
        sharp           : in     vl_logic;
        number          : in     vl_logic_vector(9 downto 0);
        \open\          : out    vl_logic;
        alarm           : out    vl_logic;
        mode_active     : out    vl_logic;
        mode_set        : out    vl_logic;
        fnd_on          : out    vl_logic_vector(6 downto 0)
    );
end de0_doorlock_2modes;
