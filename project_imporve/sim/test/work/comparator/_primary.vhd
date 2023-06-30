library verilog;
use verilog.vl_types.all;
entity comparator is
    port(
        reg_data        : in     vl_logic_vector(7 downto 0);
        new_data        : in     vl_logic_vector(7 downto 0);
        flag            : in     vl_logic;
        great           : out    vl_logic;
        equal           : out    vl_logic;
        less            : out    vl_logic
    );
end comparator;
