`timescale 1ns/1ps
`define T_CLK 10

module test;

reg clk;
reg n_rst;
reg din;
wire dout;

initial begin
	clk = 1'b1;
	n_rst = 1'b0;
	#(`T_CLK * 2)
	@(negedge clk) n_rst = 1'b1;
end

always #(`T_CLK/2) clk = ~clk;

initial begin
    din = 1'b0;

    wait(n_rst == 1'b1);

    #(`T_CLK) din = 1'b1;
    #(`T_CLK) din = 1'b0;

    wait(dout == 1'b0);
    #(`T_CLK * 5) $stop();

end

delay u_delay(
    .clk(clk),
    .n_rst(n_rst),
    .din(din),
    .dout(dout)
);

endmodule