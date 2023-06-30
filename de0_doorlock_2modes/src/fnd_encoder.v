module fnd_encoder(
    data,
    number
);

    input  [9:0] data;
	output reg [3:0] number;
	
	always @ (data) begin
		case(data)
		10'h001 : number = 4'h0;
		10'h002 : number = 4'h1;
        10'h004 : number = 4'h2;
        10'h008 : number = 4'h3;
        10'h010 : number = 4'h4;
        10'h020 : number = 4'h5;
        10'h040 : number = 4'h6;
        10'h080 : number = 4'h7;
        10'h100 : number = 4'h8;
        10'h200 : number = 4'h9;
		default : number = 4'he;
		endcase
	end
	
endmodule