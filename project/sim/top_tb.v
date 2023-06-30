`timescale 1ns/100ps
`define T_CLK 10

module top_tb();

reg clk;
reg n_rst;
reg start;
reg sdata;
reg sel;

wire cs_n;
wire sclk;
wire txd;
wire [6:0] fnd_h;
wire [6:0] fnd_l;

top_v2 u_top(
    .clk(clk),
    .n_rst(n_rst),
    .start(start),
    .sdata(sdata),
    .sel(sel),
    .cs_n(cs_n),
    .sclk(sclk),
    .txd(txd),
    .fnd_h(fnd_h),
    .fnd_l(fnd_l)
);

initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = ~n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

reg [7:0] i;
reg [7:0] j;

initial begin
    sel = 1'b0; start = 1'b1; sdata = 1'b1; i = 8'b1001_0011; j = 8'h00;

    wait(n_rst == 1'b1);
    #(`T_CLK) start = 1'b0;

    wait(cs_n == 1'b0);
    #(`T_CLK) start = 1'b1;

    for (j=0;j<15;j=j+1) begin
	    @(negedge sclk);
	    if( j< 3 ) begin
		    sdata = 1'b0; // zero, 3count
	    end
	    else if( j< 11 ) begin
		    sdata = i[7-(j-3)]; // ADC Data
	    end
	    else begin
		    sdata = 1'b0; // zero, 4count
	    end
    end	//for j

    #(`T_CLK * 200000) i = 8'b0011_1010; j = 8'h00;
    #(`T_CLK) start = 1'b0;

    #(`T_CLK) start = 1'b1;

    for (j=0;j<15;j=j+1) begin
	    @(negedge sclk);
	    if( j< 3 ) begin
		    sdata = 1'b0; // zero, 3count
	    end
	    else if( j< 11 ) begin
		    sdata = i[7-(j-3)]; // ADC Data
	    end
	    else begin
		    sdata = 1'b0; // zero, 4count
	    end
    end	//for j

    #(`T_CLK * 200000) $stop;

end

endmodule