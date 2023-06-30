module comparator(
    reg_data,
    new_data,
    flag,
    great,
    equal,
    less
);

input [7:0] reg_data;
input [7:0] new_data;
input flag;

output great;
output equal;
output less;

assign great = (flag && (new_data > reg_data)) ? 1'b1 : 1'b0;
assign equal = (flag &&(new_data == reg_data)) ? 1'b1 : 1'b0;
assign less = (flag && (new_data < reg_data)) ? 1'b1 : 1'b0;

endmodule