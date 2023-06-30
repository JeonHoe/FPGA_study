module sig(
    clk,
    n_rst,
    start,
    sig
);

input clk;
input n_rst;
input start;

output reg sig;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        sig <= 1'b0;
    end
    else if(start == 1'b1) begin
        sig <= 1'b1;
    end
    else begin
        sig <= sig;
    end
end

endmodule