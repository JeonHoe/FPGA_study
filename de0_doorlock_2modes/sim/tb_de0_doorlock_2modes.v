`timescale 1ns/1ps

`define T_CLK 10
`define B_DLY 1
`define PUSH_ON 1'b0
`define PUSH_OFF 1'b1
module tb_de0_doorlock_fixed;

//parameter PW0 = 10'b00_1000_0000;
//parameter PW1 = 10'b00_0000_0100;
//parameter PW2 = 10'b00_0000_0001;

reg clk;
reg n_rst;
reg star;
reg sharp;
reg [9:0] number;
wire	  open;
wire	  alarm;

initial begin
	clk = 1'b1;
	n_rst = 1'b0;
	#(`T_CLK * 2)
	@(negedge clk) n_rst = 1'b1;
end

always #(`T_CLK/2) clk = ~clk;

initial begin
	star = `PUSH_OFF;
	sharp = `PUSH_OFF;
	number = 10'h000;

	wait(n_rst == 1'b1);

	// --------------------------------------
	// password set ... 8, 3
    push_sharp;

	#(`T_CLK*2) number = 10'b01_0000_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0000_1000;
	#(`T_CLK*2) number = 10'h000;

	push_sharp;

	// ....
	wait(u_de0_doorlock_2modes.u_doorlock_2modes.g_state == 1'h0);
	@(negedge clk)
	// ....
	#(`T_CLK * 5)


	// password fail ... 8

	#(`T_CLK*2) number = 10'b01_0000_0000;
	#(`T_CLK*2) number = 10'h000;

    push_star;

	if (open == 1'b1) $stop();

	@(negedge clk)

	// password ok ... 8, 3
	
	#(`T_CLK*2) number = 10'b01_0000_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0000_1000;
	#(`T_CLK*2) number = 10'h000;

	push_star;

	if (alarm == 1'b1) $stop();

	@(negedge clk)

	// password fail ... 8, 6

	#(`T_CLK*2) number = 10'b01_0000_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0100_0000;
	#(`T_CLK*2) number = 10'h000;

	push_star;

	if (open == 1'b1) $stop();

	@(negedge clk)

	// password fail ... 8, 3, 3

	#(`T_CLK*2) number = 10'b01_0000_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0000_1000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0000_1000;
	#(`T_CLK*2) number = 10'h000;

	push_star;

	if (open == 1'b1) $stop();

	@(negedge clk)

	// ----------------------------------------------
	// password set ... 7, 2, 5

	push_sharp;

	#(`T_CLK*2) number = 10'b00_1000_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0000_0100;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0010_0000;
	#(`T_CLK*2) number = 10'h000;

	push_sharp;

	wait(u_de0_doorlock_2modes.u_doorlock_2modes.g_state == 1'h0);

	@(negedge clk)

	// password ok ... 7, 2, 5
	//
	#(`T_CLK*2) number = 10'b00_1000_0000;
    #(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0000_0100;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0010_0000;
	#(`T_CLK*2) number = 10'h000;

	push_star;

	if (alarm == 1'b1) $stop();

	@(negedge clk)

	// password fail ... 7, 3, 5
	//
	#(`T_CLK*2) number = 10'b00_1000_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0000_1000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0010_0000;
	#(`T_CLK*2) number = 10'h000;

	push_star;

	if (open == 1'b1) $stop();

	@(negedge clk)

	// password fail ... 7, 3, 5, 9, 1
	//
	#(`T_CLK*2) number = 10'b00_1000_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0000_1000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0010_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b10_0000_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0000_0010;
	#(`T_CLK*2) number = 10'h000;

	push_star;

	if (open == 1'b1) $stop();


	@(negedge clk)

	// password fail... short ... 7, 2

	#(`T_CLK*2) number = 10'b00_1000_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0000_0100;
	#(`T_CLK*2) number = 10'h000;

	push_star;

	if (open == 1'b1) $stop();

	@(negedge clk)
	
	// ----------------------------------------
	// password set ... 0, 4, 9, 6
	push_sharp;

	#(`T_CLK*2) number = 10'b00_0000_0001;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0001_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b10_0000_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0100_0000;
	#(`T_CLK*2) number = 10'h000;

	push_sharp;

	wait(u_de0_doorlock_2modes.u_doorlock_2modes.g_state == 1'h0);

	@(negedge clk)

	// password ok ... 0, 4, 9

	#(`T_CLK*2) number = 10'b00_0000_0001;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0001_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b10_0000_0000;
	#(`T_CLK*2) number = 10'h000;

	push_star;

	if (alarm == 1'b1) $stop();

	@(negedge clk)
	

	// password fail ... 4, 9, 6
	#(`T_CLK*2) number = 10'b00_0001_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b10_0000_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0100_0000;
	#(`T_CLK*2) number = 10'h000;

	push_star;

	if (open == 1'b1) $stop();

	@(negedge clk)


	// ----------------------------------------
	// password set ... 9
	push_sharp;

	#(`T_CLK*2) number = 10'b10_0000_0000;
	#(`T_CLK*2) number = 10'h000;

	push_sharp;

    wait(u_de0_doorlock_2modes.u_doorlock_2modes.g_state == 1'h0);

	@(negedge clk)

	// password ok ... 0, 4, 9

	#(`T_CLK*2) number = 10'b00_0000_0001;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b00_0001_0000;
	#(`T_CLK*2) number = 10'h000;

	#(`T_CLK*2) number = 10'b10_0000_0000;
	#(`T_CLK*2) number = 10'h000;

	push_star;

	if (alarm == 1'b1) $stop();


	#(`T_CLK*5) $stop;

end

de0_doorlock_2modes u_de0_doorlock_2modes(
	.clk(clk),
	.n_rst(n_rst),
	.star(star),
	.sharp(sharp),
	.number(number),
	.open(open),
	.alarm(alarm),
	.mode_active(),
	.mode_set()
);

task automatic push_sharp;
    begin
	    #(`T_CLK*2) sharp = `PUSH_ON;
	    #(`T_CLK) sharp = `PUSH_OFF;
		#(`T_CLK) sharp = `PUSH_ON;
		#(`T_CLK*2) sharp = `PUSH_OFF;
	    #(`T_CLK*2) sharp = `PUSH_ON;
	    #(`T_CLK*10) sharp = `PUSH_OFF;
		#(`T_CLK) sharp = `PUSH_ON;
		#(`T_CLK) sharp = `PUSH_OFF;
		#(`T_CLK*2) sharp = `PUSH_ON;
		#(`T_CLK*2) sharp = `PUSH_OFF;
	end
endtask

task automatic push_star;
    begin
	    #(`T_CLK*2) star = `PUSH_ON;
	    #(`T_CLK) star = `PUSH_OFF;
		#(`T_CLK) star = `PUSH_ON;
		#(`T_CLK*2) star = `PUSH_OFF;
	    #(`T_CLK*2) star = `PUSH_ON;
	    #(`T_CLK*10) star = `PUSH_OFF;
		#(`T_CLK) star = `PUSH_ON;
		#(`T_CLK) star = `PUSH_OFF;
		#(`T_CLK*2) star = `PUSH_ON;
		#(`T_CLK*2) star = `PUSH_OFF;
	end
endtask


endmodule
