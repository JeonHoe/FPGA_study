module uart_str(
    clk,
    n_rst,
    start,
    adc_data,
    tx_stop,
    load,
    data
);

input clk;
input n_rst;
input start;
input [7:0] adc_data;
input tx_stop;

output reg load;
output reg [4:0] data;

localparam S0 = 2'h0;
localparam S1 = 2'h1;
localparam S2 = 2'h2;
localparam S3 = 2'h3;

reg [1:0] c_state;
reg [1:0] n_state;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        c_state <= S0;
    end
    else begin
        c_state <= n_state;
    end
end

always @(c_state or start or tx_stop) begin
    case(c_state)
    S0 : begin
        n_state = (start == 1'b1) ? S1 : c_state;
    end
    S1 : begin
        n_state = (tx_stop == 1'b1) ? S2 : c_state;
    end
    S2 : begin
        n_state = (tx_stop == 1'b1) ? S3 : c_state;
    end
    S3 : begin
        n_state = (tx_stop == 1'b1) ? S0 : c_state;
    end
    default : begin
        n_state = S0;
    end
    endcase
end

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        data <= 5'h00;
    end
    else begin
        data <= (c_state == S1) ? {1'b0, adc_data[7:4]} : 
                (c_state == S2) ? {1'b0, adc_data[3:0]} :
                (c_state == S3) ? {1'b1, data[3:0]} : data;
    end
end

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        load <= 1'b0;
    end
    else begin
        load <= (((c_state == S1)||(c_state == S2)||(c_state == S3))&&(tx_stop == 1'b0)) ? 1'b1 : 1'b0;
    end
end

endmodule