library verilog;
use verilog.vl_types.all;
entity tb_de0_training is
    generic(
        D_SIZE          : integer := 2
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of D_SIZE : constant is 1;
end tb_de0_training;
