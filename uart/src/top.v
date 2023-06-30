`define FPGA

module top(
    clk,
    n_rst,
    sel,
    tx_data,
    load,
    txd,
    rxd,
    fnd
);

input clk;
input n_rst;
input sel;
input [7:0] tx_data;
input load;
input rxd;

output txd;
output [6:0] fnd;

wire txen;
wire [7:0] rx_data;

gen_en u_gen_en(
    .clk(clk),
    .n_rst(n_rst),
    .sel(sel),
    .txen(txen)
);

`ifdef FPGA

wire db_load;
wire load_in;

debounce u_debounce(
    .clk(clk),
	 .n_rst(n_rst), 
	 .din(!load), 
	 .dout(db_load) 
);

edge_detection u_edge_detection(
    .clk(clk),
    .n_rst(n_rst),
    .data(db_load),
    .tick(),
    .tick_rising(load_in),
    .tick_falling()
);

wire txd_in;

tx u_tx(
    .clk(clk),
    .n_rst(n_rst),
    .tx_data(tx_data),
    .txen(txen),
    .load(load_in),
    .txd(txd_in)
);

assign txd = !txd_in;

rx u_rx(
    .clk(clk),
    .n_rst(n_rst),
    .rxd(!rxd),
    .rx_data(rx_data)
);

wire [7:0] fnd_in;

ascii u_ascii(
    .data(rx_data),
    .decode(fnd_in)
);

fnd_out u_fnd_out1(
    .number(fnd_in),
    .fnd_out(fnd)
);

`else

tx u_tx(
    .clk(clk),
    .n_rst(n_rst),
    .tx_data(tx_data),
    .txen(txen),
    .load(load),
    .txd(txd)
);

rx u_rx(
    .clk(clk),
    .n_rst(n_rst),
    .rxd(rxd),
    .rx_data(rx_data)
);

fnd_out u_fnd_out1(
    .number(rx_data),
    .fnd_out(fnd)
);

`endif

endmodule
