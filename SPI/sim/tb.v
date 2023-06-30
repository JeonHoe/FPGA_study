`timescale 1ns/100ps
`define T_CLK 10

module tb();

reg clk;
reg n_rst;
reg sdata;
reg start;

wire led;
//wire seg_h;
//wire seg_l;
wire cs_n;
wire sclk;

wire [6:0] fnd_out1;
wire [6:0] fnd_out2;
//wire [7:0] adc_data;

reg [7:0] i;

reg [7:0] j;

de0_SPI_master u_de0_SPI_master(
    .clk(clk),
    .n_rst(n_rst),
    .sclk(sclk),
    .cs_n(cs_n),
    .sdata(sdata),
    .led(led),
    //.seg_h,
    //.seg_l,
    //.adc_data,
    .start(start),
    .fnd_out1(fnd_out1),
    .fnd_out2(fnd_out2)
);


initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    #(`T_CLK * 2.2) n_rst = ~n_rst;
end

always #(`T_CLK / 2) clk = ~clk;

initial begin
    start = 1'b0; sdata = 1'b1; i = 8'b1001_0011; j = 8'h00;

    wait(n_rst == 1'b1);
    #(`T_CLK) start = 1'b1;

    wait(cs_n == 1'b0);
    #(`T_CLK) start = 1'b0;

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

    wait(cs_n == 1'b1);
    #(`T_CLK) sdata = 1'b1;

    #(`T_CLK * 50) i = 8'b0001_0101; start = 1'b0;

    wait(n_rst == 1'b1);
    #(`T_CLK) start = 1'b1;

    wait(cs_n == 1'b0);
    #(`T_CLK) start = 1'b0;

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

    wait(cs_n == 1'b1);
    #(`T_CLK) sdata = 1'b1;

    #(`T_CLK * 50) i = 8'b1011_0100; start = 1'b0;

    wait(n_rst == 1'b1);
    #(`T_CLK) start = 1'b1;

    wait(cs_n == 1'b0);
    #(`T_CLK) start = 1'b0;

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

    #(`T_CLK * 50) $stop;

end

endmodule