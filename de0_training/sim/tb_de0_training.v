`timescale 1ns/100ps
`define T_CLK 10

module tb_de0_training;

parameter D_SIZE = 2;

reg 		 clk;
reg 		 n_rst;

initial begin
	clk = 1'b1;
end

always #(`T_CLK/2) clk = ~clk;

initial begin
	n_rst = 1'b0;
	#(`T_CLK * 2.2) n_rst = 1'b1;
end

reg  [3:0] din_0;
reg  [3:0] din_1;
reg  [1:0] sel;
wire [3:0] dout;
wire 		 blink;

integer i, j;
initial begin
	din_0 = 4'h0;
	din_1 = 4'h0;
	sel = 2'h0;

	wait(n_rst == 1'b1);

	sel = 2'h0;
	din_0 = 4'h0;	
	for (i=1;i<=15;i=i+1) begin
		#(`T_CLK) din_0 = i;
	end

	#(`T_CLK) sel = 2'h1;
	din_1 = 4'h0;
	for (i=1;i<=15;i=i+1) begin
		#(`T_CLK) din_1 = i;	
	end

	#(`T_CLK) sel = 2'h2;
	din_0 = 4'h0;
	din_1 = 4'h0;
	for (i=0;i<=15;i=i+1) begin
		for (j=0;j<=15;j=j+1) begin
			#(`T_CLK) din_0 = i;	
					  din_1 = j;	
		end
	end

	#(`T_CLK) sel = 2'h3;
	din_0 = 4'h0;
	din_1 = 4'h0;
	for (i=0;i<=15;i=i+1) begin
		for (j=0;j<=15;j=j+1) begin
			#(`T_CLK) din_0 = i;	
					  din_1 = j;	
		end
	end

	#(`T_CLK * 5) $stop;

end

de0_training 
	#(.D_SIZE(D_SIZE)) 
	u_de0_training (
	.clk(clk),
	.n_rst(n_rst),
	.din_0(din_0),
	.din_1(din_1),
	.sel(sel),
	.dout(dout),
	.blink(blink)
);

endmodule
