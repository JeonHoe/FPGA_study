`define FPGA
module memory_hw(
    w_clk,
    r_clk,
    din,
    din_vld,
    n_rst,
    read,
    full,
    dout_vld,
    dout_err,
    status_vld,
    fnd_out1,
    fnd_out2,
    fnd_out3,
    fnd_out4
);

input w_clk;
input r_clk;
input read;
input [7:0] din;
input din_vld;
input n_rst;

output full;
output dout_vld;
output dout_err;
output [1:0] status_vld;
output [6:0] fnd_out1;
output [6:0] fnd_out2;
output [6:0] fnd_out3;
output [6:0] fnd_out4;

reg [6:0] fnd_out1;
reg [6:0] fnd_out2;
reg [6:0] fnd_out3;
reg [6:0] fnd_out4;

wire [7:0] dout;
wire [7:0] w_data;
wire w_addr;
wire w_en;
wire [7:0] q;
wire r_addr;
wire [1:0] r_done;
wire dout_vld_in;

`ifdef FPGA

reg din_vld_d1;
wire din_vld_in;

wire dout_err_in;

always @ (posedge r_clk or negedge n_rst)
    if (!n_rst)
        din_vld_d1 <= 1'b1;
    else
        din_vld_d1 <= din_vld;

assign din_vld_in = ((din_vld == 1'b0) && (din_vld_d1 == 1'b1)) ? 1'b1 : 1'b0;

reg read_d1;
wire read_in;

always @ (posedge r_clk or negedge n_rst)
    if (!n_rst)
        read_d1 <= 1'b1;
    else
        read_d1 <= read;

assign read_in = ((read == 1'b0) && (read_d1 == 1'b1)) ? 1'b1 : 1'b0;

ram_dual_2x8 u_ram_dual_2x8(
    .data(w_data),
	.rdaddress({3'b000, r_addr}),
	.rdclock(r_clk),
	.wraddress({3'b000, w_addr}),
	.wrclock(w_clk),
	.wren(w_en),
	.q(q)
);

write_ctrl u_write_ctrl1 (
    .clk(w_clk),
    .n_rst(n_rst),
    .din(din),
    .din_vld(din_vld_in),
    .r_done(r_done),
    .full(full),
    .status_vld(status_vld),
    .w_addr(w_addr),
    .w_data(w_data),
    .w_en(w_en)
);

read_ctrl u_read_ctrl1 (
    .clk(r_clk),
    .n_rst(n_rst),
    .r_data(q),
    .status_vld(status_vld),
    .read(read_in),
    .dout(dout),
    .dout_vld(dout_vld_in),
    .dout_err(dout_err_in),
    .r_addr(r_addr),
    .r_done(r_done)
);

`else

ram_dual_port_2x32 #( .DATA_WIDTH(8), .ADDR_WIDTH(1) ) u_ram_dual_port_2x32(
	.wrclk(w_clk),
    .rdclk(r_clk),
	.data(w_data),
	.rdaddress(r_addr),
	.wraddress(w_addr),
	.wren(w_en),
	.q(q)
);

write_ctrl u_write_ctrl2 (
    .clk(w_clk),
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

read_ctrl u_read_ctrl2 (
    .clk(r_clk),
    .n_rst(n_rst),
    .r_data(q),
    .status_vld(status_vld),
    .read(read),
    .dout(dout),
    .dout_vld(dout_vld_in),
    .dout_err(dout_err_in),
    .r_addr(r_addr),
    .r_done(r_done)
);

`endif

wire [6:0] pre_fnd_out1;
wire [6:0] pre_fnd_out2;
wire [6:0] pre_fnd_out3;
wire [6:0] pre_fnd_out4;

fnd_out u_fnd_out1 (
    .number(dout[7:4]),
    .fnd_on(pre_fnd_out1)
);

fnd_out u_fnd_out2 (
    .number(dout[3:0]),
    .fnd_on(pre_fnd_out2)
);

fnd_out u_fnd_out3 (
    .number(dout[7:4]),
    .fnd_on(pre_fnd_out3)
);

fnd_out u_fnd_out4 (
    .number(dout[3:0]),
    .fnd_on(pre_fnd_out4)
);

reg dout_vld_d;

always @ (posedge r_clk or negedge n_rst)
    if(!n_rst)
        dout_vld_d <= 1'b0;
    else
        dout_vld_d <= dout_vld_in;

always @ (posedge r_clk or negedge n_rst) // HEX1
    if(!n_rst)
        fnd_out1 <= 7'h7f;
    else
        fnd_out1 <= ((dout_vld_d == 1'b1) && (r_addr == 1'b0)) ? pre_fnd_out1 : fnd_out1;

always @ (posedge r_clk or negedge n_rst) // HEX0
    if(!n_rst)
        fnd_out2 <= 7'h7f;
    else
        fnd_out2 <= ((dout_vld_d == 1'b1) && (r_addr == 1'b0)) ? pre_fnd_out2 : fnd_out2;

always @ (posedge r_clk or negedge n_rst) // HEX3
    if(!n_rst)
        fnd_out3 <= 7'h7f;
    else
        fnd_out3 <= ((dout_vld_d == 1'b1) && (r_addr == 1'b1)) ? pre_fnd_out3 : fnd_out3;

always @ (posedge r_clk or negedge n_rst) // HEX2
    if(!n_rst)
        fnd_out4 <= 7'h7f;
    else
        fnd_out4 <= ((dout_vld_d == 1'b1) && (r_addr == 1'b1)) ? pre_fnd_out4 : fnd_out4;

delay u_delay1 (
    .clk(r_clk),
    .n_rst(n_rst),
    .din(dout_err_in),
    .dout(dout_err)
);

delay u_delay2 (
    .clk(r_clk),
    .n_rst(n_rst),
    .din(dout_vld_in),
    .dout(dout_vld)
);

endmodule