module fnd_out(
    number,
    fnd_out
);

    input  [3:0] number;
	output [6:0] fnd_out;
	 
	 reg a,b,c,d,e,f,g;
	
	always @ (number) begin
		case(number)
		4'h0: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b1; end // 0
		4'h1: begin a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b1; f = 1'b1; g = 1'b1; end // 1
		4'h2: begin a = 1'b0; b = 1'b0; c = 1'b1; d = 1'b0; e = 1'b0; f = 1'b1; g = 1'b0; end // 2
		4'h3: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b1; f = 1'b1; g = 1'b0; end // 3
		4'h4: begin a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b1; f = 1'b0; g = 1'b0; end // 4
		4'h5: begin a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b0; e = 1'b1; f = 1'b0; g = 1'b0; end // 5
		4'h6: begin a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end // 6
		4'h7: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b1; f = 1'b0; g = 1'b1; end // 7
		4'h8: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end // 8
		4'h9: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b1; f = 1'b0; g = 1'b0; end // 9
		4'hA: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b0; f = 1'b0; g = 1'b0; end //10
		4'hB: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end //11
		4'hC: begin a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b1; end //12
		4'hD: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b1; end //13
		4'hE: begin a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end //14
		4'hF: begin a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b1; e = 1'b0; f = 1'b0; g = 1'b0; end //15
		/*8'h00: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b1; end // 0 = 0x30- 0x30
		8'h01: begin a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b1; f = 1'b1; g = 1'b1; end // 1 = 0x31 -0x30
		8'h02: begin a = 1'b0; b = 1'b0; c = 1'b1; d = 1'b0; e = 1'b0; f = 1'b1; g = 1'b0; end // 2
		8'h03: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b1; f = 1'b1; g = 1'b0; end // 3
		8'h04: begin a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b1; f = 1'b0; g = 1'b0; end // 4
		8'h05: begin a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b0; e = 1'b1; f = 1'b0; g = 1'b0; end // 5
		8'h06: begin a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end // 6
		8'h07: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b1; f = 1'b0; g = 1'b1; end // 7
		8'h08: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end // 8
		8'h09: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b1; f = 1'b0; g = 1'b0; end // 9
		8'h0A: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b0; f = 1'b0; g = 1'b0; end //10 = 0x41 - 0x37
		8'h0B: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end //11
		8'h0C: begin a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b1; end //12
		8'h0D: begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b1; end //13
		8'h0E: begin a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end //14
		8'h0F: begin a = 1'b0; b = 1'b1; c = 1'b1; d = 1'b1; e = 1'b0; f = 1'b0; g = 1'b0; end //15
		8'h10: begin a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b0; e = 1'b0; f = 1'b0; g = 1'b0; end //16
		8'h11: begin a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b0; f = 1'b0; g = 1'b0; end //17
		8'h12: begin a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b1; e = 1'b1; f = 1'b1; g = 1'b1; end //18*/
		default: begin a = 1'b1; b = 1'b1; c = 1'b1; d = 1'b1; e = 1'b1; f = 1'b1; g = 1'b1; end
		endcase
	end
	assign fnd_out = {a,b,c,d,e,f,g};
	
endmodule