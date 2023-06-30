module final_02(
    clk,
    n_rst,
    result,
    sclk,
    ss,
    mosi
);

input clk;
input n_rst;
input mosi;
input sclk;
input ss;

output reg [3:0] result;

parameter max = 8;

reg [1:0] c_state, n_state;
reg [3:0] c_cnt1, n_cnt1;

localparam S0 = 2'h0, S1 = 2'h1, S2 = 2'h2, S3 = 2'h3;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        c_state <= S0;
        c_cnt1 <= 3'h1;
    end
    else begin
        c_state <= n_state;
        c_cnt1 <= n_cnt1;
    end
end

reg sclk_d;
wire sclk_r, sclk_f;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        sclk_d <= 1'b0;
    end
    else begin
        sclk_d <= sclk;
    end
end

assign sclk_r = ((sclk == 1'b1)&&(sclk_d == 1'b0)) ? 1'b1 : 1'b0;
assign sclk_f = ((sclk == 1'b0)&&(sclk_d == 1'b1)) ? 1'b1 : 1'b0;

always @(c_state or n_cnt1 or ss or sclk_r) begin
    case(c_state)
    S0 : n_state = ((ss == 1'b1)&&(sclk==1'b0)&&(mosi==1'b1)) ? c_state : S1;
    S1 : n_state = (n_cnt1 == 3'h2) ? S2 : c_state; // zero
    S2 : n_state = (n_cnt1 == 3'h5) ? S3 : c_state; // op
    S3 : n_state = (n_cnt1 == 3'h1) ? S0 : c_state; // data
    default : n_state = S0;
    endcase
end

always @(c_state or c_cnt1 or sclk_f) begin
    case(c_state)
    S0 : n_cnt1 = 3'h1;
    default : n_cnt1 = (sclk_f != 1'b1) ? c_cnt1 :
                       (c_cnt1 == max) ? 3'h1 : c_cnt1 + 3'h1;
    endcase
end

reg [6:0] inst;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        inst <= 7'h00;
    end
    else if((c_state == S2)||(c_state == S3)) begin
        inst <= (sclk_f == 1'b1) ? {inst[5:0], mosi} : inst;
    end
    else begin
        inst <= inst;
    end
end

wire flg;

assign flg = ((c_cnt1 == max)&&(sclk_f == 1'b1)) ? 1'b1 : 1'b0;
reg flg_d;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        flg_d <= 1'b0;
    end
    else begin
        flg_d <= flg;
    end
end

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        result <= 4'h0;
    end
    else begin
        result <= (flg_d != 1'b1) ? result :
                  (inst[6:4] == 3'b100) ? inst[3:0] :
                  (inst[6:4] == 3'b110) ? inst[3:0] : result;
    end
end

reg [3:0] operand_a;
reg [3:0] operand_b;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        operand_a <= 4'h0;
    end
    else begin
        operand_a <= (flg_d != 1'b1) ? operand_a :
                     (inst[6:4] == 3'b100) ? inst[3:0] : operand_a;
    end
end

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        operand_b <= 4'h0;
    end
    else begin
        operand_b <= (flg_d != 1'b1) ? operand_b :
                     (inst[6:4] == 3'b110) ? inst[3:0] : operand_b;
    end
end

endmodule