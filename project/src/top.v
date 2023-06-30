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

localparam IDLE = 2'h0;
localparam UART1 = 2'h1;
localparam UART2 = 2'h2;

reg [1:0] c_state;
reg [1:0] n_state;

wire cs_n_rs;
wire tx_stop;

always @ (posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        c_state <= IDLE;
    end
    else begin
        c_state <= n_state;
    end
end

always @(c_state or cs_n_rs or tx_stop) begin
    case(c_state)
    IDLE : begin
        n_state = (cs_n_rs == 1'b1) ? UART1 : c_state;
    end
    UART1 : begin
        n_state = (tx_stop == 1'b1) ? UART2 : c_state;
    end
    UART2 : begin
        n_state = (tx_stop == 1'b1) ? IDLE : c_state;
    end
    default : begin
        n_state = IDLE;
    end
    endcase
end

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
    .tick_rising(cs_n_rs),
    .tick_falling()
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

reg [4:0] data;
reg load;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        data <= 5'h00;
    end
    else begin
        data <= (c_state == UART1) ? {1'b0, adc_data[3:0]} :
                (c_state == UART2) ? {1'b0, adc_data[7:4]} : {1'b1, data[3:0]};
    end
end

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        load <= 1'b0;
    end
    else begin
        load <= ((c_state == UART1)||(c_state == UART2)) ? 1'b1 : 1'b0;
    end
end

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