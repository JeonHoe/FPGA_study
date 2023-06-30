`timescale 1ns/100ps
`define T_CLK 10

module uart_tb();

reg clk;
reg n_rst;
reg sel;
reg [7:0] tx_data;
reg load;
reg rxd;

wire txd;
wire [7:0] rx_data;

uart u_uart1(
    .clk(clk),
    .n_rst(n_rst),
    .sel(sel),
    .tx_data(tx_data),
    .load(load),
    .rxd(rxd),
    .txd(txd),
    .rx_data()
);

uart u_uart2(
    .clk(clk),
    .n_rst(n_rst),
    .sel(sel),
    .tx_data(),
    .load(),
    .rxd(txd),
    .txd(),
    .rx_data(rx_data)
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
    tx_data = 8'h92;

    wait(n_rst == 1'b1);

    #(`T_CLK * 2.7) load = 1'b1;
    //#(`T_CLK * 1) load = 1'b0;

    #(`T_CLK * 60000) tx_data = 8'hA4;

    #(`T_CLK * 2.7) load = 1'b1;
    #(`T_CLK * 1) load = 1'b0;

    #(`T_CLK * 60000) $stop;

end

endmodule