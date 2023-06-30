module ram(
    clk,
    data,
    rdaddress,
    wraddress,
    wren,
    q
);

parameter DATA_WIDTH = ;
parameter ADDR_WIDTH = ;

input clk;
input [(DATA_WIDTH-1):0] data;
input [(ADDR_WIDTH-1):0] rdaddress;
input [(ADDR_WIDTH-1):0] wraddress;
input wren;

output reg [(DATA_WIDTH-1):0] q;

reg [(DATA_WIDTH-1):0] ram [(2**ADDR_WIDTH-1):0];

always @(posedge clk) begin
    if(wren) ram[wraddress] <= data;
end

always @(posedge clk) begin
    q <= ram[rdaddress];
end

endmodule