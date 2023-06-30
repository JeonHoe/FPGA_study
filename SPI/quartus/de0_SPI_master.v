`define FPGA
module de0_SPI_master(
    clk,
    n_rst,
    sclk,
    cs_n,
    sdata,
    led,
    //seg_h,
    //seg_l,
    //adc_data,
    start,
    fnd_out1,
    fnd_out2
);

input clk;
input n_rst;
input sdata;
input start;

output led;
//output [3:0] seg_h;
//output [3:0] seg_l;
output cs_n;
output sclk;
//output [7:0] adc_data;
output [6:0] fnd_out1;
output [6:0] fnd_out2;

wire [3:0] seg_h;
wire [3:0] seg_l;

`ifdef FPGA

reg start_d1;
wire start_in;

always @ (posedge clk or negedge n_rst)
    if(!n_rst) begin
        start_d1 <= 1'b1;
	end
    else begin
        start_d1 <= start;
	end

assign start_in = ((start == 1'b0)&&(start_d1==1'b1)) ? 1'b0 : 1'b1;

SPI_master u_SPI_master1 (
    .clk(clk),
    .n_rst(n_rst),
    .sclk(sclk),
    .cs_n(cs_n),
    .sdata(sdata),
    .led(led),
    .seg_h(seg_h),
    .seg_l(seg_l),
    .adc_data(),
    .start(!start_in)
);

`else

SPI_master u_SPI_master2 (
    .clk(clk),
    .n_rst(n_rst),
    .sclk(sclk),
    .cs_n(cs_n),
    .sdata(sdata),
    .led(led),
    .seg_h(seg_h),
    .seg_l(seg_l),
    .adc_data(),
    .start(start)
);

`endif

fnd_out u_fnd_out2 (
    .number(seg_h),
    .fnd_out(fnd_out2)
);

fnd_out u_fnd_out1 (
    .number(seg_l),
    .fnd_out(fnd_out1)
);

endmodule