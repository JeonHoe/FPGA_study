module gen_en( // sel의 설정에 맞는 bps에 txen을 출력한는 모듈
    clk,
    n_rst,
    sel,
    txen
);

input clk;
input n_rst;
input sel; // bps 값을 설정하는 입력 단자

output txen; // TX가 TXD를 출력하게 하는 flag 신호
reg txen;

localparam FLG1 = 16'h1458;
// 9600bps => 1s에 9600bit 데이터 전송 => txen 1s에 9600번 1'b1 출력
// 9600bps <=> 9600Hz,  FPGA : 50MHz => 1clock = 20ns 
// 50MHz/9600Hz ≒ 5208 = 16'h1458
localparam FLG2 = 16'h0A2C;

reg [15:0] c_cnt;
reg [15:0] n_cnt; // txen 출력 타이밍 제어 카운터

always @(posedge clk or negedge n_rst) begin // 카운터 초기화
    if(!n_rst) begin
        c_cnt <= 16'h0001;
    end
    else begin
        c_cnt <= n_cnt;
    end
end

always @(c_cnt or sel) // sel 설정에 따른 카운터 개수 설정 및 카운터 동작 정의
    if(sel == 1'b0) begin
        n_cnt = (c_cnt == FLG1) ? 16'h0001 : c_cnt + 16'h0001;
    end
    else begin
        n_cnt = (c_cnt == FLG2) ? 16'h0001 : c_cnt + 16'h0001;
    end

always @(posedge clk or negedge n_rst) // txen 동작 정의
    if(!n_rst) begin
        txen <= 1'b0;
    end
    else begin
        if(sel == 1'b0) begin
            txen <= (c_cnt == FLG1) ? 1'b1 : 1'b0;
        end
        else begin
            txen <= (c_cnt == FLG2) ? 1'b1 : 1'b0;
        end
    end


endmodule