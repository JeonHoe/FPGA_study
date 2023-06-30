module mux(
    reg_data,
    new_data,
    sel1,
    sel2,
    sel3,
    sel_data
);

input [7:0] reg_data;
input [7:0] new_data;
input sel1;
input sel2;
input sel3;

output [7:0] sel_data;

assign sel_data = ({sel1, sel2, sel3} == 3'b100) ? new_data : reg_data;

endmodule