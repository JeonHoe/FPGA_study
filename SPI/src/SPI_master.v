module SPI_master(
    clk,
    n_rst,
    sclk,
    cs_n,
    sdata,
    led,
    seg_h,
    seg_l,
    adc_data,
    start
);

input clk;
input n_rst;
input sdata;
input start;

output led;
output [3:0] seg_h;
output [3:0] seg_l;
output cs_n;
output sclk;
output reg [7:0] adc_data;

localparam S0 = 2'h0;
localparam S1 = 2'h1;
localparam S2 = 2'h2;
localparam S3 = 2'h3;

reg [3:0] c_state;
reg [3:0] n_state;

localparam FLG1 = 5'h19;
localparam FLG2 = 4'hf;

reg [4:0] c_cnt1;
reg [4:0] n_cnt1; // COUNTER1

reg [3:0] c_cnt2;
reg [3:0] n_cnt2; // COUNTER2

always @ (posedge clk or negedge n_rst)
    if(!n_rst) begin
        c_state <= S0;
        c_cnt1 <= 5'h01;
        c_cnt2 <= 4'h1;
    end
    else begin
        c_state <= n_state;
        c_cnt1 <= n_cnt1;
        c_cnt2 <= n_cnt2;
    end

always @ (start or n_cnt2)
    case(c_state)
        S0 : n_state = (start  == 1'b1) ? S1 : c_state;
        S1 : n_state = (n_cnt2 == 4'h4) ? S2 : c_state;
        S2 : n_state = (n_cnt2 == 4'hc) ? S3 : c_state;
        S3 : n_state = (n_cnt2 == 4'h1) ? S0 : c_state;
        default : n_state = S0;
    endcase

always @ (c_state or c_cnt1)
    case(c_state)
        S0 : n_cnt1 = 5'h01;
        default : n_cnt1 = (n_state == S0) ? 5'h01 :
                           (c_cnt1 == FLG1) ? 5'h01 : c_cnt1 + 5'h01;
    endcase

assign cs_n = (c_state == S0) ? 1'b1 : 1'b0;
assign sclk = (c_cnt1 < 5'h0d) ? 1'b1 : 1'b0;

reg sclk_d;
wire r_sclk;

always @ (posedge clk or negedge n_rst)
    if(!n_rst)
        sclk_d <= 1'b1;
    else
        sclk_d <= sclk;

assign r_sclk = ((sclk == 1'b1)&&(sclk_d == 1'b0)) ? 1'b1 : 1'b0;

always @ (c_state or r_sclk)
    case (c_state)
        S0 : n_cnt2 = 4'h1;
        default : n_cnt2 = (r_sclk == 1'b0) ? c_cnt2 :
                           (c_cnt2 == FLG2) ? 4'h1 : c_cnt2 + 4'h1;
    endcase

always @ (posedge clk or negedge n_rst)
    if(!n_rst)
        adc_data <= 8'h00;
    else if (c_state == S2) begin
        adc_data <= (r_sclk == 1'b1) ? {adc_data[6:0], sdata} : adc_data;
    end
    else
        adc_data <= adc_data;

assign led = (c_state == S0) ? 1'b0 : 1'b1;
assign seg_h = adc_data[7:4];
assign seg_l = adc_data[3:0];

endmodule