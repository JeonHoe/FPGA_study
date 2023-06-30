module button(
    clk,
    n_rst,
    start,
    stop,
    signal
);

input clk;
input n_rst;
input start;
input stop;

output reg signal;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        signal <= 1'b0;
    end
    else if(start == 1'b1) begin
        signal <= 1'b1;
    end
    else if(stop == 1'b1) begin
        signal <= 1'b0;
    end
    else begin
        signal <= signal;
    end
end

endmodule