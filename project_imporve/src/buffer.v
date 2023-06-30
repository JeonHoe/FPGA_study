module buffer(
    clk,
    n_rst,
    in,
    sel1,
    sel2,
    sel3,
    out
);

input clk;
input n_rst;
input [3:0] in;
input sel1;
input sel2;
input sel3;

output reg [3:0] out;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        out <= 4'h0;
    end
    else begin
        out <= ({sel1, sel2, sel3} == 3'b100) ? in : out;
    end
end

endmodule