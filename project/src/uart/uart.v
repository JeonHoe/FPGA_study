module uart(
    clk,
    n_rst,
    sel,
    tx_data,
    load,
    rxd,
    txd,
    tx_stop,
    rx_data
);

input clk;
input n_rst;
input sel;
input [7:0] tx_data;
input load;
input rxd;

output txd;
output tx_stop;
output [7:0] rx_data;

wire txen;

gen_en u_gen_en(
    .clk(clk),
    .n_rst(n_rst),
    .sel(sel),
    .txen(txen)
);

tx u_tx(
    .clk(clk),
    .n_rst(n_rst),
    .tx_data(tx_data),
    .txen(txen),
    .load(load),
    .txd(txd),
    .tx_stop(tx_stop)
);

rx #(.MAX(5208)) u_rx(
    .clk(clk),
    .n_rst(n_rst),
    .rxd(rxd),
    .rx_data(rx_data)
);

endmodule
