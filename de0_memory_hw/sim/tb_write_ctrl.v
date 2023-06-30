`timescale 1ns/100ps
`define T_CLK 10

module tb_wtite_ctrl();

reg clk; reg n_rst;
reg [7:0] din;
reg din_vld;
reg [1:0] r_done;

wire full;
wire [1:0] status_vld;
wire w_addr;
wire [7:0] w_data;
wire w_en;

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2);
    @(negedge clk) n_rst = ~n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

initial begin
    din = 32'h0000_0000;
    din_vld = 1'b0;
    r_done = 2'b00;

    wait(n_rst == 1'b1);

    // status_vld = 2'b00
    // reg signal din and din_vld
    #(`T_CLK) din = 32'h89AB_CDEF;
    #(`T_CLK) din_vld = 1'b1;
    #(`T_CLK) din_vld = 1'b0;
    #(`T_CLK) din = 32'h0000_0000;

    // status_vld = 2'b01
    // reg signal din and din_vld
    #(`T_CLK) din = 32'hFEDC_BA98;
    #(`T_CLK) din_vld = 1'b1;
    #(`T_CLK) din_vld = 1'b0;
    #(`T_CLK) din = 32'h0000_0000;

    // status_vld = 2'b11
    // reg signal din and din_vld
    #(`T_CLK) din = 32'hFEDC_BA98;
    #(`T_CLK) din_vld = 1'b1;
    #(`T_CLK) din_vld = 1'b0;
    #(`T_CLK) din = 32'h0000_0000;

    // reg signal r_done = 2'10;
    #(`T_CLK) r_done = 2'b10;
    #(`T_CLK) r_done = 2'b00;

    #(`T_CLK * 3) $stop;
end

write_ctrl u_write_ctrl(
    .clk(clk),
    .n_rst(n_rst),
    .din(din),
    .din_vld(din_vld),
    .r_done(r_done),
    .full(full),
    .status_vld(status_vld),
    .w_addr(w_addr),
    .w_data(w_data),
    .w_en(w_en)
);

endmodule