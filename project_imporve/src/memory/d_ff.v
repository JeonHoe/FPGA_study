module d_ff(
    clk,
    n_rst,
    wren,
    din,
    dout
);

input clk;
input n_rst;
input wren;
input [7:0] din;

output reg [7:0] dout;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        dout <= 7'h00;
    end
    else begin
        dout <= (wren == 1'b1) ? din : dout;
    end
end

endmodule