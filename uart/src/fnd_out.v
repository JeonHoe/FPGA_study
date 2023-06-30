module fnd_out(
    number,
    fnd_out
);

    input  [7:0] number;
	output [6:0] fnd_out;
	 
	 reg a,b,c,d,e,f,g;
	
	always @ (number) begin
		case(number)
		8'h00: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b1; end // 0 = 0x30- 0x30
		8'h01: begin a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b1; f = 1'b1; g = 1'b1; end // 1 = 0x31 -0x30
		8'h02: begin a = 1'b0; b = 1'b0; c = 1'b1; d = 1'b0; e = 1'b0; f = 1'b1; g = 1'b0; end // 2
		8'h03: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b1; f = 1'b1; g = 1'b0; end // 3
		8'h04: begin a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b1; f = 1'b0; g = 1'b0; end // 4
		8'h05: begin a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b0; e = 1'b1; f = 1'b0; g = 1'b0; end // 5
		8'h06: begin a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end // 6
		8'h07: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b1; f = 1'b0; g = 1'b1; end // 7
		8'h08: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end // 8
		8'h09: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b1; f = 1'b0; g = 1'b0; end // 9
		8'h0A: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b0; f = 1'b0; g = 1'b0; end //10 = 0x41 - 0x37 A
		8'h0B: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end //11 B
		8'h0C: begin a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b1; end //12 C
		8'h0D: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b1; end //13 D
		8'h0E: begin a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end //14 E
		8'h0F: begin a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b1; e = 1'b0; f = 1'b0; g = 1'b0; end //15 F
		8'h10: begin a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end //16 G
		8'h11: begin a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b0; f = 1'b0; g = 1'b0; end //17 H
		8'h12: begin a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b1; f = 1'b1; g = 1'b1; end //18 I
		default: begin a = 1'b1; b = 1'b1; c = 1'b1; d = 1'b1; e = 1'b1; f = 1'b1; g = 1'b1; end
		endcase
	end
	assign fnd_out = {a,b,c,d,e,f,g};
	
endmodule