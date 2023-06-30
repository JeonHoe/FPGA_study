module de0_training (
	clk,
	n_rst,
	din_0,
	din_1,
	sel,
	dout,
	blink,
	fnd1,
	fnd2,
	fnd3,
	fnd4
);

parameter D_SIZE = 25;

input 		 clk;
input 		 n_rst;
input  [3:0] din_0;
input  [3:0] din_1;
input  [1:0] sel;
output [3:0] dout;
output [6:0] fnd1;
output [6:0] fnd2;
output [6:0] fnd3;
output [6:0] fnd4;
reg    [3:0] dout;
output 		 blink;

reg [3:0] din_0_d1, din_0_d2;
reg [3:0] din_1_d1, din_1_d2;
reg [1:0] sel_d1, sel_d2;

always @(posedge clk or negedge n_rst)
	if(!n_rst) begin
		din_0_d1 <= 4'h0;
		din_0_d2 <= 4'h0;
		din_1_d1 <= 4'h0;
		din_1_d2 <= 4'h0;
		sel_d1   <= 2'h0;
		sel_d2   <= 2'h0;
	end
	else begin
		din_0_d1 <= din_0;
		din_0_d2 <= din_0_d1;
		din_1_d1 <= din_1;
		din_1_d2 <= din_1_d1;
		sel_d1   <= sel;
		sel_d2   <= sel_d1;
		// sel_d2   <= sel; // error
	end

always @(posedge clk or negedge n_rst)
	if(!n_rst) begin
		dout <= 4'h0;
	end
	else begin
		dout <= (sel_d2 == 2'h0)? din_0_d2 :
			    (sel_d2 == 2'h1)? din_1_d2 : 
				(sel_d2 == 2'h2)? din_0_d2 + din_1_d2 : 
							      din_0_d2 | din_1_d2;
	end

reg [D_SIZE-1:0] cnt;
always @(posedge clk or negedge n_rst)
	if(!n_rst) begin
		cnt <= {D_SIZE{1'b0}};
	end
	else begin
		cnt <= cnt + {{{D_SIZE-1}{1'b0}},1'b1};
	end
	
wire [3:0] sel4;

assign sel4 = {1'b0, 1'b0, sel};

assign blink = cnt[D_SIZE-1];	

fnd u_fnd1(.number(din_0), .fnd_on(fnd4));
fnd u_fnd2(.number(din_1), .fnd_on(fnd3));
fnd u_fnd3(.number(sel4), .fnd_on(fnd2));
fnd u_fnd4(.number(dout), .fnd_on(fnd1));

endmodule
