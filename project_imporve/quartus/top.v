module top(
    clk,
    n_rst,
    start,
    stop,
    sdata,
    sel,
    cs_n,
    sclk,
    txd,
    fnd_h,
    fnd_l
);

input clk; input n_rst; input start; input stop; input sdata; input sel;

output cs_n; output sclk; output txd;
output [6:0] fnd_h; 
output [6:0] fnd_l;

wire tx_stop; wire cs_n_rs;
wire start_db; wire stop_db;
wire start_rs; wire stop_rs;

debounce u_debounce1(
	.clk(clk),
	.n_rst(n_rst), 
	.din(!start), 
	.dout(start_db) 
);

debounce u_debounce2(
	.clk(clk),
	.n_rst(n_rst), 
	.din(!stop), 
	.dout(stop_db) 
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
    .data(stop_db),
    .tick(),
    .tick_rising(stop_rs),
    .tick_falling()
);

wire signal; wire flag; wire [3:0] count;

button u_button(
    .clk(clk),
    .n_rst(n_rst),
    .start(start_rs),
    .stop(stop_rs),
    .signal(signal)
);

timer u_timer(
    .clk(clk),
    .n_rst(n_rst),
    .count(count),
    .signal(signal),
    .flag(flag)
);

counter u_counter(
    .clk(clk),
    .n_rst(n_rst),
    .signal(signal),
    .flag(flag),
    .count(count)
);

edge_detection u_edge_detection3(
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
    .start(flag),
    .sdata(sdata),
    .cs_n(cs_n),
    .sclk(sclk),
    .adc_data(adc_data)
);

wire [7:0] reg_data, sel_data;
wire great, equal, less;
wire [3:0] reg_count;

comparator u_comparator(
    .reg_data(reg_data),
    .new_data(adc_data),
    .flag(cs_n_rs),
    .great(great),
    .equal(equal),
    .less(less)
);

d_ff u_d_ff(
    .clk(clk),
    .n_rst(n_rst),
    .wren(cs_n_rs),
    .din(sel_data),
    .dout(reg_data)
);

mux u_mux(
    .reg_data(reg_data),
    .new_data(adc_data),
    .sel1(great),
    .sel2(equal),
    .sel3(less),
    .sel_data(sel_data)
);

buffer u_buffer(
    .clk(clk),
    .n_rst(n_rst),
    .in(count),
    .sel1(great),
    .sel2(equal),
    .sel3(less),
    .out(reg_count)
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

wire [3:0] reg_count_10;
wire [3:0] reg_count_01;

assign reg_count_10 = reg_count / 4'hA;
assign reg_count_01 = reg_count % 4'hA;

fnd_out fnd_out_1(
    .number(reg_count_10),
    .fnd_out(fnd_h)
);

fnd_out fnd_out_2(
    .number(reg_count_01),
    .fnd_out(fnd_l)
);

endmodule