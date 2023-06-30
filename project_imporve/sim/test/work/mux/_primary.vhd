library verilog;
use verilog.vl_types.all;
entity mux is
    port(
        reg_data        : in     vl_logic_vector(7 downto 0);
        new_data        : in     vl_logic_vector(7 downto 0);
        sel1            : in     vl_logic;
        sel2            : in     vl_logic;
        sel3            : in     vl_logic;
        sel_data        : out    vl_logic_vector(7 downto 0)
    );
end mux;
