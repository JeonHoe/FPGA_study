module counter(
    clk,
    n_rst,
    signal,
    flag,
    count
);

input clk;
input n_rst;
input signal;
input flag;

output reg [3:0] count;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        count <= 4'h0;
    end
    else begin
        count <= (signal == 1'b0) ? count :
                 (flag == 1'b0) ?  count :
                 (count == 4'hF) ? count : count + 4'h1;
    end
end

endmodule