`timescale 1ns/100ps
`define T_CLK 10

module tb();

reg clk;
reg n_rst;
reg sel;
reg [7:0] tx_data;
reg load;
reg rxd;

wire txd;
wire [6:0] fnd_h;
wire [6:0] fnd_l;


top u_top1(
    .clk(clk),
    .n_rst(n_rst),
    .sel(sel),
    .tx_data(tx_data),
    .load(load),
    .txd(txd),
    .rxd(rxd),
    .fnd_h(),
    .fnd_l()
);

top u_top2(
    .clk(clk),
    .n_rst(n_rst),
    .sel(sel),
    .tx_data(),
    .load(),
    .txd(),
    .rxd(txd),
    .fnd_h(fnd_h),
    .fnd_l(fnd_l)
);

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = ~n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

initial begin
    sel = 1'b0; 
    load = 1'b0;
    rxd = 1'b1;

    wait(n_rst == 1'b1);

    #(`T_CLK * 2.7) load = 1'b1;
    #(`T_CLK * 1) load = 1'b0;

    #(`T_CLK * 60000) tx_data = 8'hA4;

    #(`T_CLK * 2.7) load = 1'b1;
    #(`T_CLK * 1) load = 1'b0;

    #(`T_CLK * 60000) $stop;

end

endmodule