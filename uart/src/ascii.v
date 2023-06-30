module ascii (
    data,
    decode
);

input [7:0] data;

output [7:0] decode;

assign decode = ((data >= 8'h30)&&(data <= 8'h39)) ? data - 8'h30 :
                ((data >= 8'h41)&&(data <= 8'h49)) ? data - 8'h37 :
                ((data >= 8'h61)&&(data <= 8'h69)) ? data - 8'h57 : 8'hff;

endmodule