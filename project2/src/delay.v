module delay(
    clk,
    n_rst,
    din,
    dout
);


//parameter N = 28;
//parameter T_20MS = 28'h000_0008; testbench용 설정

parameter N = 28;
parameter T_1S = 28'h2FA_F080;
// 1s = 1.0+e9ns, 1clock = 20ns, 1s = 5.0+e7clock
//5.0+e7 = 28'b0010_1111_1010_1111_0000_1000_0000 = 28'h2FA_F080

input clk;
input n_rst;
input din;

output dout;

reg c_state;
reg n_state;

reg [N-1:0] c_cnt;
reg [N-1:0] n_cnt;

localparam D_INT = 1'b0;      // 초기화 상태
localparam D_DELAY = 1'b1;  // 지연 상태

always @(posedge clk or negedge n_rst)
    if(!n_rst) begin
        c_state <= D_INT;
        c_cnt <= {N{1'b0}};
    end
    else begin
        c_state <= n_state;
        c_cnt <= n_cnt;
    end

always @(c_state or din or c_cnt or n_cnt)
    case(c_state)
    D_INT : begin
        n_state = (din == 1'b1) ? D_DELAY : c_state; // 입력 din이 1'b1이 되면 지연 상태로 상태 변화, 아닐 경우 현재 상태 유지
        n_cnt = (din == 1'b1) ? T_1S : c_cnt;          // 입력 din이 1'b1이 되면 c_cnt는 다음 클록에서 계산 값으로 변화, 아닐 경우 유지
    end
    D_DELAY: begin
        n_state = (n_cnt == {N{1'b0}}) ? D_INT : c_state; // n_cnt의 값이 28'h000_0000이 될 때까지 지연 상태 유지
        n_cnt = c_cnt - {{(N-1){1'b0}}, 1'b1};                // 지연 상태에서 c_cnt는 28'h000_0001씩 감소
    end
    default : begin
        n_state = D_INT;
        n_cnt = {N{1'b0}};
    end
    endcase

    assign dout = (c_state == D_DELAY) ? 1'b1 : 1'b0; // 지연 상태에 있을 경우 출력 dout은 1'b1을 출력, 아닐 경우 1'b0을 출력

endmodule

/*
이해가 안 갈 경우 google에 wavedrom에서 editor로 들어가 아래 문장 기입
{signal: [
  {name:     'clk', wave: 'P.....|...', period: '2'},
  {name:   'r_nst', wave: 'lh..........|.......', period:  '1'},
  {name:     'din', wave: 'l..h.l......|.......', period:  '1'},
  {},
  {name: 'c_state', wave: '=...=.......|.....=.', period:  '1', data: 'D_INT D_DELAY D_INT'},
  {name: 'n_state', wave: '=..=........|...=...', period:  '1', data: 'D_INT D_DELAY D_INT'},
  {name:   'c_cnt', wave: '=...=.=.=.=.|==.=...', period:  '1', data: '000 111 110 101 100 010 001 000'},
  {name:   'n_cnt', wave: '=..==.=.=.=.|==.....', period:  '1', data: '000 111 110 101 100 011 001 000'},
  {},
  {name:  'dout', wave: 'l...h.......|.....l.'}
]}

*/