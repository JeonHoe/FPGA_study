module top(
    clk,
    n_rst,
    start,
    sdata,
    sel,
    cs_n,
    sclk,
    txd,
    fnd_h,
    fnd_l
);

input clk;
input n_rst;
input start;
input sdata;
input sel;

output cs_n;
output sclk;
output txd;
output [6:0] fnd_h;
output [6:0] fnd_l;

wire tx_stop;
wire cs_n_rs;

wire start_db;
wire start_rs;

debounce u_debounce(
	.clk(clk),
	.n_rst(n_rst), 
	.din(!start), 
	.dout(start_db) 
);

edge_detection u_edge_detection1(
    .clk(clk),
    .n_rst(n_rst),
    .data(start_db),
    .tick(),
    .tick_rising(start_rs),
    .tick_falling()
);

edge_detection u_edge_detection2(
    .clk(clk),
    .n_rst(n_rst),
    .data(!cs_n),
    .tick(),
    .tick_rising(),
    .tick_falling(cs_n_rs)
);

wire [7:0] adc_data;

spi_master u_spi_master(
    .clk(clk),
    .n_rst(n_rst),
    .start(start_rs),
    .sdata(sdata),
    .cs_n(cs_n),
    .sclk(sclk),
    .adc_data(adc_data)
);

wire [4:0] data;
wire load;

uart_str u_uart_str(
    .clk(clk),
    .n_rst(n_rst),
    .start(cs_n_rs),
    .adc_data(adc_data),
    .tx_stop(tx_stop),
    .load(load),
    .data(data)
);

wire [7:0] decode;

ascii u_ascii1(
    .data(data),
    .decode(decode)
);

wire txd_in;

uart u_uart1(
    .clk(clk),
    .n_rst(n_rst),
    .sel(sel),
    .tx_data(decode),
    .load(load),
    .rxd(),
    .txd(txd_in),
    .tx_stop(tx_stop),
    .rx_data()
);

assign txd = !txd_in;

fnd_out fnd_out_1(
    .number(adc_data[7:4]),
    .fnd_out(fnd_h)
);

fnd_out fnd_out_2(
    .number(adc_data[3:0]),
    .fnd_out(fnd_l)
);

endmodule