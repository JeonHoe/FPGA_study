module read_ctrl(
    clk,
    n_rst,
    r_data,
    status_vld,
    read,
    dout,
    dout_vld,
    dout_err,
    r_addr,
    r_done
);

input clk;
input n_rst;
input [7:0] r_data;
input [1:0] status_vld;
input read;

output [7:0] dout;
output dout_vld;
output dout_err;
output r_addr;
output [1:0] r_done;

reg r_addr;
reg [7:0] dout;

localparam S0 = 3'h0;
localparam S1 = 3'h1;
localparam S2 = 3'h2;
localparam S3 = 3'h3;
localparam S4 = 3'h4;
localparam S5 = 3'h5;

reg [2:0] c_state;
reg [2:0] n_state;

always @ (posedge clk or negedge n_rst)
    if (!n_rst)
        c_state <= S0;
    else
        c_state <= n_state;

always @(c_state or r_data or status_vld or read)
    case(c_state)
        S0 : n_state = S1;
        S1 : n_state = ((read == 1'b1) && (status_vld[r_addr] == 1'b1)) ? S2 :
                       ((read == 1'b1) && (status_vld[r_addr] == 1'b0)) ? S5 : c_state;
        S2 : n_state = S3;
        S3 : n_state = S4;
        S4 : n_state = S1;
        S5 : n_state = S1;
        default : n_state = S0;
    endcase

always @ (posedge clk or negedge n_rst)
    if(!n_rst)
        r_addr <= 1'b0;
    else
        r_addr <= ((n_state == S5)||(n_state == S4)) ? ~r_addr : r_addr;

always @ (posedge clk or negedge n_rst)
    if(!n_rst)
        dout <= 8'h00;
    else
        dout <= (n_state == S3) ? r_data : dout;

wire [1:0] mask;
assign mask = (r_addr == 1'b0) ? 2'b01 : 2'b10;

assign r_done = (c_state == S3) ? mask : 2'b00;
assign dout_vld = (c_state == S2) ? 1'b1 : 1'b0;
assign dout_err = (c_state == S5) ? 1'b1 : 1'b0;

endmodule