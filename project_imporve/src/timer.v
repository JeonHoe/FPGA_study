module timer(
    clk,
    n_rst,
    signal,
    count,
    flag
);

parameter TIME = 28'h2FA_F080;

input clk;
input n_rst;
input signal;
input [3:0] count;

output reg flag;

reg [27:0] c_cnt;
reg [27:0] n_cnt;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        c_cnt <= 28'h000_0001;
    end
    else begin
        c_cnt <= n_cnt;
    end
end

always @(signal or c_cnt or count) begin
    n_cnt = (count == 4'hF) ? 28'h000_0001 :
            (signal == 1'b0) ? 28'h000_0001 :
            (c_cnt == TIME) ? 28'h000_0001 : c_cnt + 28'h000_0001;
end

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        flag <= 1'b0;
    end
    else begin
        flag <= (c_cnt == TIME) ? 1'b1 : 1'b0;
    end
end

endmodule