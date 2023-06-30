`timescale 1ns/100ps
`define T_CLK 10

module spi_master_tb();

reg clk;
reg n_rst;
reg sdata;
reg start;

wire cs_n;
wire sclk;
wire adc_data;

reg [7:0] i;
reg [7:0] j;

spi_master u_spi_master(
    .clk(clk),
    .n_rst(n_rst),
    .start(start),
    .sdata(sdata),
    .cs_n(cs_n),
    .sclk(sclk),
    .adc_data(adc_data)
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