`timescale 10ns/1ps

`define S_CLK 100
`define T_CLK 10

module tb_final;

reg clk;
reg n_rst;

initial begin
	clk = 1'b0;
	n_rst = 1'b0;
	#(`T_CLK * 2.2) n_rst = 1'b1;
end

always #(`T_CLK/2) clk = ~clk;

reg sclk, ss;
reg mosi;
reg [7:0] mosi_mem [0:3];
initial begin
	mosi_mem[0] = 8'b0_100_0101;
	mosi_mem[1] = 8'b0_110_1001;
	mosi_mem[2] = 8'b0_000_0000;
	mosi_mem[3] = 8'b0_001_0000;
end

integer i, j;
initial begin
	sclk = 1'b0;
	ss = 1'b1;
	mosi = 1'b1;

	wait(n_rst == 1'b1)
	#(`S_CLK) ss = 1'b0;
	for (i=0;i<=3;i=i+1) begin
		for (j=7;j>=0;j=j-1) begin
			@(posedge sclk) mosi = mosi_mem[i][j];
		end
		#(`S_CLK) ss = 1'b1;
				  mosi = 1'b1;
		#(`S_CLK*5) ss = 1'b0;

	end
	#(`S_CLK * 2) $stop;

end

always #(`S_CLK/2) sclk = (ss == 1'b0)? ~sclk : sclk;

wire [3:0] result;

//final_01 
//final_02 
final_03 
//final_04 
	u_final(
	.clk(clk),
	.n_rst(n_rst),

	.result(result),

	.sclk(sclk),
	.ss(ss),
	.mosi(mosi)
);	

endmodule
