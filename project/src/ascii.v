module ascii (
    data,
    decode
);

input [4:0] data;

output [7:0] decode;

assign decode = ((data >= 5'h00)&&(data <= 5'h09)) ? data + 8'h30 :
                ((data >= 5'h0A)&&(data <= 5'h0F)) ? data + 8'h37 : 8'h2C;

endmodule