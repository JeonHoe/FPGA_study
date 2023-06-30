`timescale 1ns/1ps
`define T_CLK 10
module tb_de0_memory;

reg clk, n_rst;
initial begin
	clk = 1'b1;
	n_rst = 1'b0;
	#(`T_CLK*2.2) n_rst = 1'b1;
end

always #(`T_CLK/2) clk = ~clk;

reg [5:0] sw;
wire [6:0] fnd0, fnd1, fnd2, fnd3;

integer i;
initial begin
    sw = 6'h00;
    wait (n_rst == 1'b1);

    for(i=0;i<=3;i=i+1) begin
        #(`T_CLK*1) sw = i;
    end
     for(i=0;i<=3;i=i+1) begin
        #(`T_CLK*1) sw = i|(6'b10_0000);
    end

    for(i=0;i<=3;i=i+1) begin
        #(`T_CLK*1) sw = i;
    end

    /*for(i=31;i>=0;i=i-1) begin
        #(`T_CLK*1) sw = i;
    end

    for(i=31;i>=-1;i=i-1) begin
        #(`T_CLK*1) sw = i|(6'b10_0000);
    end*/

    #(`T_CLK*4) $stop;
end

de0_memory u_de0_memory(
	.clk(clk),
	.n_rst(n_rst),
	.sw(sw),
	.fnd0(fnd0),
	.fnd1(fnd1),
	.fnd2(fnd2),
	.fnd3(fnd3)
);

endmodule
