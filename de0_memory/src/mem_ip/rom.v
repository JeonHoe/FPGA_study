module rom(
    clk,
    addr,
    data
);
parameter D_WIDTH = 8;
parameter A_WIDTH = 5;

input   clk;
input   [A_WIDTH-1:0]  addr;
output [D_WIDTH-1:0]  data;
reg      [D_WIDTH-1:0] data;

reg [D_WIDTH-1:0] rom [2**A_WIDTH-1:0];

// Read the memory contents
initial  begin
    $readmemh("../src/mem_ip/rom_32x8.txt", rom);
end

always @ (posedge clk)
    begin
        data <= rom[addr];
    end

// without an initialization file
/*always @ (posedge clk)
begin
    case(addr)
        2'b00 : data = 8'h01;
        2'b01 : data = 8'h23;
        2'b10 : data = 8'h45;
       2'b11 : data = 8'h67;
    endcase
end*/

	
endmodule
