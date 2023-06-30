library verilog;
use verilog.vl_types.all;
entity ascii is
    port(
        data            : in     vl_logic_vector(4 downto 0);
        decode          : out    vl_logic_vector(7 downto 0)
    );
end ascii;
