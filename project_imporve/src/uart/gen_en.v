module gen_en(
    clk,
    n_rst,
    sel,
    txen
);

input clk;
input n_rst;
input sel;

output txen;

localparam MAX9600 = 16'h1458;
localparam MAX19200 = 16'h0A2C;

wire [15:0] max;

assign max = (sel == 1'b0) ? MAX9600 : MAX19200;

reg [15:0] c_cnt;
reg [15:0] n_cnt;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        c_cnt <= 16'h0001;
    end
    else begin
        c_cnt <= n_cnt;
    end
end

always @(c_cnt or max) begin
    n_cnt = (c_cnt >= max) ? 16'h0001 : c_cnt + 16'h0001;
end

assign txen = (c_cnt >= max) ? 1'b1 : 1'b0;

endmodule