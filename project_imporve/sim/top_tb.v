`timescale 1ns/100ps
`define T_CLK 10

module top_tb();

reg clk;
reg n_rst;
reg start;
reg stop;
reg sdata;
reg sel;

wire cs_n;
wire sclk;
wire txd;
wire [6:0] fnd_h;
wire [6:0] fnd_l;

top u_top(
    .clk(clk),
    .n_rst(n_rst),
    .start(start),
    .stop(stop),
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
integer j;
integer k; 

initial begin
    sel = 1'b0; start = 1'b1; sdata = 1'b1; stop = 1'b1; i = $urandom%256; j = 0; k = 0;

    wait(n_rst == 1'b1);
    #(`T_CLK) start = 1'b0;
    #(`T_CLK) start = 1'b1;

    for (j=0;j<15;j=j+1) begin
        for (k=0;k<15;k=k+1) begin
	        @(negedge sclk);
	        if( k < 3 ) begin
	            sdata = 1'b0; // zero, 3count
	        end
    	    else if( k < 11 ) begin
		        sdata = i[7-(k-3)]; // ADC Data
	        end
	        else begin
		        sdata = 1'b0; // zero, 4count
	        end
        end
        @(posedge cs_n)
        #(`T_CLK) i = $urandom%256;
    end

    #(`T_CLK) $stop;

end

endmodule