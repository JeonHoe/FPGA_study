library verilog;
use verilog.vl_types.all;
entity de0_memory is
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        sw              : in     vl_logic_vector(5 downto 0);
        fnd0            : out    vl_logic_vector(6 downto 0);
        fnd1            : out    vl_logic_vector(6 downto 0);
        fnd2            : out    vl_logic_vector(6 downto 0);
        fnd3            : out    vl_logic_vector(6 downto 0)
    );
end de0_memory;
