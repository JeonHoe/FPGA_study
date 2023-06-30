module tx( // 병렬 입력 tx_data를 직렬 출력 tx로 변환하는 모듈
    clk,
    n_rst,
    tx_data,
    txen,
    load,
    txd
);

input clk;
input n_rst;
input [7:0] tx_data;
input txen;
input load;

output reg txd;

localparam FLG = 4'h9; // start bit 1 + write bit 8 + finish bit 1 = 10bit => 0~9 카운트

localparam ST0 = 3'h0; // 초기화 상태 or 모듈이 동작하지 않는 상태
localparam ST1 = 3'h1; // 로드 상태 : load 신호가 입력되고 txen이 1이 될 때까지 기다리는 상태
localparam ST2 = 3'h2; // start bit 부분 상태 : start 비트를 인식하는 상태
localparam ST3 = 3'h3; // write bit 부분 상태 : data 비트를 쓰는 상태
localparam ST4 = 3'h4; // stop bit 부분 상태 : stop 비트를 인식하는 상태

reg [3:0] c_cnt;
reg [3:0] n_cnt; // txen을 세는 카운터

reg [2:0] c_state;
reg [2:0] n_state; // 상태

always @(posedge clk or negedge n_rst) begin // 상태 및 카운터 초기화
    if(!n_rst) begin
        c_state <=  ST0;
        c_cnt <= 4'h0;
    end
    else begin
        c_state <= n_state;
        c_cnt <= n_cnt;
    end
end

always @(c_state or load or n_cnt or txen) begin  // @(load or n_cnt or txen) begin // 상태 동작 정의
    case(c_state)
    ST0 : n_state = (load == 1'b1) ? ST1 : c_state;
    ST1 : n_state = (txen == 4'h1) ? ST2 : c_state;
    ST2 : n_state = (n_cnt == 4'h1) ? ST3 : c_state;
    ST3 : n_state = (n_cnt == FLG) ? ST4 : c_state;
    ST4 : n_state = (n_cnt == 4'h0) ? ST0 : c_state;
    default : n_state = ST0;
    endcase
end

always @(c_state or c_cnt or txen) begin //(txen) begin // 카운터 동작 정의
    case(c_state)
    ST0 : n_cnt = 4'h0;
    ST1 : n_cnt = c_cnt;
    default : n_cnt = (txen == 1'b0) ? c_cnt :
                      (c_cnt == FLG) ? 4'h0 : c_cnt + 4'h1;
    endcase
end

reg [7:0] tx_data_in; // 병렬 입력 tx_data를 shift화 한 data

always @(posedge clk or negedge n_rst) // tx_data_in 동작 정의
    if(!n_rst) begin // 초기화
        tx_data_in <=  8'h00;
    end
    else if(c_state == ST2) begin // start bit 부분에서 tx_data 원본 입력
        tx_data_in <= tx_data;
    end
    else if(c_state == ST3) begin // write bit 부분에서 1bit씩 right-shift 실행
        tx_data_in <= (txen == 1'b1) ? {1'b0, tx_data_in[7:1]} : tx_data_in;
    end
    else begin
        tx_data_in <= 8'h00;
    end

always @(posedge clk or negedge n_rst) //txd 동작 정의
    if(!n_rst) begin // 초기화
        txd <=  1'b1;
    end
    else if(c_state == ST2)begin // start bit 부분에서 1'b0 출력
        txd <= 1'b0;
    end
    else if(c_state == ST3) begin // write bit 부분에서 tx_data_in의 lsb write
        txd <= (txen == 1'b0) ? tx_data_in[0] /*tx_data[c_cnt-4'h1]*/ : txd;
    end
    else if(c_state == ST4) begin // finish bit 부분에서 1'b1 출력
        txd <= 1'b1;
    end
    else begin
        txd <= txd;
    end

endmodule
