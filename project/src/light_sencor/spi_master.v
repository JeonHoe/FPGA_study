module spi_master(
    clk,
    n_rst,
    start,
    sdata,
    cs_n,
    sclk,
    adc_data
);

input clk;
input n_rst;
input start;
input sdata;

output cs_n;
output reg sclk;
output reg [7:0] adc_data;

localparam S0 = 2'h0;
localparam S1 = 2'h1;
localparam S2 = 2'h2;
localparam S3 = 2'h3;

localparam FLG1 = 5'h19;
localparam FLG2 = 4'hF;

reg [1:0] c_state;
reg [1:0] n_state;

reg [4:0] c_cnt1;
reg [4:0] n_cnt1;

reg [3:0] c_cnt2;
reg [3:0] n_cnt2;

always @(posedge clk or negedge n_rst) begin
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
end

always @(c_state or start or n_cnt2) begin
    case(c_state)
    S0 : n_state = (start == 1'b1) ? S1 : c_state;
    S1 : n_state = (n_cnt2 == 4'h4) ? S2 : c_state;
    S2 : n_state = (n_cnt2 == 4'hC) ? S3 : c_state;
    S3 : n_state = (n_cnt2 == 4'h1) ? S0 : c_state;
    default : n_state = S0;
    endcase
end

always @(c_state or c_cnt1) begin
    case(c_state)
    S0 : n_cnt1 = 5'h01;
    default : n_cnt1 = (c_cnt1 == FLG1) ? 5'h01 : c_cnt1 + 5'h01;
    endcase
end

assign cs_n = (c_state == S0) ? 1'b1 : 1'b0;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        sclk <= 1'b1;
    end
    else begin
        sclk <= (c_cnt1 < 5'h0D) ? 1'b1 : 1'b0;
    end
end

reg sclk_d;
wire sclk_r;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        sclk_d <= 1'b1;
    end
    else begin
        sclk_d <= sclk;
    end
end

assign sclk_r = ((sclk == 1'b1)&&(sclk_d == 1'b0)) ? 1'b1 : 1'b0;

always @(c_state or sclk_r or c_cnt2) begin
    case(c_state)
    S0 : n_cnt2 = 4'h1;
    default : n_cnt2 = (sclk_r == 1'b0) ? c_cnt2 :
                       (c_cnt2 == FLG2) ? 4'h1 : c_cnt2 + 4'h1;
    endcase
end

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        adc_data <= 8'h00;
    end
    else if (c_state == S2) begin
        adc_data <= (sclk_r == 1'b1) ? {adc_data[6:0], sdata} : adc_data;
    end
    else begin
        adc_data <= adc_data;
    end
end

endmodule