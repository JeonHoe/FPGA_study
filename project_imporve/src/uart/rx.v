module rx(
    clk,
    n_rst,
    rxd,
    rx_data
);

parameter MAX = 5208;

input clk;
input n_rst;
input rxd;

output reg [7:0] rx_data;

localparam FLG = MAX/2;

localparam SR0 = 2'h0;
localparam SR1 = 2'h1;
localparam SR2 = 2'h2;
localparam SR3 = 2'h3;

reg [1:0] c_state;
reg [1:0] n_state;

reg [15:0] c_cnt1;
reg [15:0] n_cnt1;

reg [3:0] c_cnt2;
reg [3:0] n_cnt2;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        c_state <= SR0;
        c_cnt1 <= 16'h0001;
        c_cnt2 <= 4'h1;
    end
    else begin
        c_state <= n_state;
        c_cnt1 <= n_cnt1;
        c_cnt2 <= n_cnt2;
    end
end

always @(c_state or rxd or n_cnt2) begin
    case(c_state)
    SR0 : n_state = (rxd == 1'b0) ? SR1 : c_state;
    SR1 : n_state = (n_cnt2 == 4'h2) ? SR2 : c_state;
    SR2 : n_state = (n_cnt2 == 4'hA) ? SR3 : c_state;
    SR3 : n_state = (n_cnt2 == 4'h1) ? SR0 : c_state;
    default : n_state = SR0;
    endcase
end

always @(c_state or c_cnt1) begin
    case(c_state)
    SR0 : n_cnt1 = 16'h0001;
    default : n_cnt1 = (c_cnt1 == MAX) ? 16'h0001 : c_cnt1 + 16'h0001;
    endcase
end

reg rxen;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        rxen <= 1'b0;
    end
    else begin
        rxen <= (c_cnt1 == FLG) ? 1'b1 : 1'b0;
    end
end

always @(c_cnt2 or rxen or c_state) begin
    case(c_state)
    SR0 : n_cnt2 = 4'h1;
    default : n_cnt2 = (rxen == 1'b0) ? c_cnt2 :
                       (c_cnt2 == 4'hA) ? 4'h1 : c_cnt2 + 4'h1;
    endcase
end

always @ (posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        rx_data <= 8'h00;
    end
    else if (c_state == SR2) begin
        rx_data <= (rxen == 1'b1) ? {rxd, rx_data[7:1]} : rx_data;
    end
    else begin
        rx_data <= rx_data;
    end
end

endmodule