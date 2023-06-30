module counter( // 빛 세기 비교기 및 카운터
    clk,
    n_rst,
    sig,
    adc_data,
    counter
);

input clk;
input n_rst;
input sig;
input [7:0] adc_data;

output reg [3:0] counter;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        counter <= 4'h0;
    end
    else if(((adc_data > 8'h50)||(adc_data<8'h10))&&(sig == 1'b1)) begin
        counter <= (counter == 4'hf) ? 4'hf : counter + 4'h1;
    end
    else begin
        counter <= counter;
    end
end

endmodule