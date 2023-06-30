module de0_doorlock_2modes(
	clk,
	n_rst,
	star,
	sharp,
	number,
	open,
	alarm,
	mode_active,
	mode_set,
	fnd_on
);

input clk;
input n_rst;
input star;
input sharp;
input [9:0] number;

output open;
output alarm;
output mode_active;
output mode_set;
output [6:0] fnd_on;

wire debounce_star;
wire debounce_sharp;

wire edge_star;
wire edge_sharp;



debounce u_debounce1(
    .clk(clk),
	.n_rst(n_rst), 
	.din(!star), 
	.dout(debounce_star) 
);

debounce u_debounce2(
    .clk(clk),
	.n_rst(n_rst), 
	.din(!sharp), 
	.dout(debounce_sharp) 
);

edge_detection u_edge_detection1(
    .clk(clk),
    .n_rst(n_rst),
    .data(debounce_star),
    .tick(),
    .tick_rising(edge_star),
    .tick_falling()
);

edge_detection u_edge_detection2(
    .clk(clk),
    .n_rst(n_rst),
    .data(debounce_sharp),
	.tick(),
    .tick_rising(edge_sharp),
	.tick_falling()
);

wire slide_data = (number == 10'h000) ? 1'b0 : 1'b1;

/*reg slide_data;

always @(number)
    if(number != 10'h000) slide_data = 1'b1;
	else slide_data = 1'b0;*/

wire slide_tick_rising;

edge_detection u_edge_detection3(
    .clk(clk),
    .n_rst(n_rst),
    .data(slide_data),
	.tick(),
    .tick_rising(slide_tick_rising),
	.tick_falling()
);

wire [9:0] edge_number;

assign edge_number = (slide_tick_rising == 1'b1) ? number : 10'h000;

wire d_open;
wire d_alarm;

doorlock_2modes u_doorlock_2modes(
    .clk(clk),
	.n_rst(n_rst),
	.star(edge_star),
	.sharp(edge_sharp),
	.number(edge_number),
	.open(d_open),
	.alarm(d_alarm),
	.mode_active(mode_active),
	.mode_set(mode_set)
);

delay u_delay01(
    .clk(clk),
	.n_rst(n_rst),
	.din(d_open),
	.dout(open)
);

delay u_delay02(
   .clk(clk),
	.n_rst(n_rst),
	.din(d_alarm),
	.dout(alarm)
);

wire [3:0] fnd_in;

fnd_encoder u_fnd_enoder01(
    .data(number),
    .number(fnd_in)
);

fnd_out u_fnd_out01(
    .number(fnd_in),
    .fnd_on(fnd_on)
);

endmodule