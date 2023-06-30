library verilog;
use verilog.vl_types.all;
entity de0_training is
    generic(
        D_SIZE          : integer := 25
    );
    port(
        clk             : in     vl_logic;
        n_rst           : in     vl_logic;
        din_0           : in     vl_logic_vector(3 downto 0);
        din_1           : in     vl_logic_vector(3 downto 0);
        sel             : in     vl_logic_vector(1 downto 0);
        dout            : out    vl_logic_vector(3 downto 0);
        blink           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of D_SIZE : constant is 1;
end de0_training;
