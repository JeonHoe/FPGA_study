module ram_dual_port_2x32(
    wrclk,
    rdclk,
	data,
	rdaddress,
	wraddress,
	wren,
	q
);

parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 1;

input [(DATA_WIDTH-1):0] data;
input [(ADDR_WIDTH-1):0] rdaddress, wraddress;
input wren, rdclk, wrclk;
output reg [(DATA_WIDTH-1):0] q;

reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];
	
always @ (posedge wrclk)
begin // Write
        if (wren) ram[wraddress] <= data;
end
	
always @ (posedge rdclk)
begin	// Read 
        q <= ram[rdaddress];
end
	
endmodule


