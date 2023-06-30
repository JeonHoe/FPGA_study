`timescale 1ns/100ps
`define T_CLK 10

module tb_memory_hw();

reg w_clk;
reg [7:0] din;
reg din_vld;
reg n_rst;
reg r_clk;
reg read;

wire full;
wire [1:0] status_vld;
wire dout_vld;
wire [6:0] fnd_out1;
wire [6:0] fnd_out2;
wire [6:0] fnd_out3;
wire [6:0] fnd_out4;


memory_hw u_memory_hw(
    .w_clk(w_clk),
    .din(din),
    .din_vld(din_vld),
    .read(read),
    .n_rst(n_rst),
    .r_clk(r_clk),
    .full(full),
    .status_vld(status_vld),
    .dout_vld(dout_vld),
    .fnd_out1(fnd_out1),
    .fnd_out2(fnd_out2),
    .fnd_out3(fnd_out3),
    .fnd_out4(fnd_out4)
);

initial begin
    w_clk = 1'b1;
    r_clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2);
    @(negedge w_clk) n_rst = ~n_rst;
end

always #(`T_CLK / 2) w_clk = ~w_clk;

always #(`T_CLK / 2) r_clk = ~r_clk;

initial begin
    read = 1'b0;
    din = 8'h00;
    din_vld = 1'b0;

    wait(n_rst == 1'b1);

    // status_vld = 2'b00
    // input signal din and din_vld
    #(`T_CLK) din = 8'h89;
    #(`T_CLK) din_vld = 1'b1;
    #(`T_CLK) din_vld = 1'b0;
    #(`T_CLK) din = 8'h00;
    #(`T_CLK) read = 1'b1;
    #(`T_CLK) read = 1'b0;

    // status_vld = 2'b01
    // input signal din and din_vld
    #(`T_CLK) din = 8'hFE;
    #(`T_CLK) din_vld = 1'b1;
    #(`T_CLK) din_vld = 1'b0;
    #(`T_CLK) din = 8'h00;
    #(`T_CLK) read = 1'b1;
    #(`T_CLK) read = 1'b0;

    // status_vld = 2'b11
    // input signal din and din_vld
    #(`T_CLK) din = 32'h98;
    #(`T_CLK) din_vld = 1'b1;
    #(`T_CLK) din_vld = 1'b0;
    #(`T_CLK) din = 8'h00;
    #(`T_CLK) read = 1'b1;
    #(`T_CLK) read = 1'b0;

    #(`T_CLK * 10) $stop;
end

endmodule