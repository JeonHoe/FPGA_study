module timer( // 카운터 주기 타이머
    clk,
    n_rst,
    sig,
    flg
);

input clk;
input n_rst;
input sig;

output reg flg;

parameter FREQUENCY = 28'h2FA_F080;

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

always @(sig or c_cnt) begin
    n_cnt = (sig == 1'b0) ? 28'h000_0001 :
            (c_cnt == FREQUENCY) ? 28'h000_0001 : c_cnt + 28'h000_0001;
end

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        flg = 1'b0;
    end
    else begin
        flg = (c_cnt == FREQUENCY) ? 1'b1 : 1'b0;
    end
end

endmodule