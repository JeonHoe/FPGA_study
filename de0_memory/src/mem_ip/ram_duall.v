module ram_dual(
	clk,
	wdata,
	raddr,
	waddr,
	wen,
	rdata
);

parameter D_WIDTH = 8;
parameter A_WIDTH = 5;

input clk;
input [A_WIDTH-1:0]  waddr;
input wen;
input [D_WIDTH-1:0]  wdata;
input [A_WIDTH-1:0]  raddr;
output [D_WIDTH-1:0]  rdata;

reg	[D_WIDTH-1:0]  rdata;
// Single-clk, Simple Dual-Port Synchronous RAM 
// with Old wdata Read-During-Write Behavior

reg [D_WIDTH-1:0] ram [2**A_WIDTH-1:0];

always @ (posedge clk)
begin
	if (wen == 1'b1) begin
		ram[waddr] <= wdata;
    end
    rdata <= ram[raddr];
end 


endmodule

