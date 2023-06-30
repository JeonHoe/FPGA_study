module delay(
    clk,
    n_rst,
    din,
    dout
);


//parameter N = 28;
//parameter T_20MS = 28'h000_0008;

parameter N = 28;
parameter T_1S = 28'h2FA_F080;
// 1s = 1.0+e9, 1clock = 20ns, 1s = 5.0+e7
//5.0+e7 = 28'b0010_1111_1010_1111_0000_1000_0000 = 28'h2FA_F080

input clk;
input n_rst;
input din;

output dout;

reg c_state;
reg n_state;

reg [N-1:0] c_cnt;
reg [N-1:0] n_cnt;

localparam D_INT = 1'b0;
localparam D_DELAY = 1'b1;

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
        n_state = (din == 1'b1) ? D_DELAY : c_state;
        n_cnt = (din == 1'b1) ? T_1S : c_cnt;
    end
    D_DELAY: begin
        n_state = (n_cnt == {N{1'b0}}) ? D_INT : c_state;
        n_cnt = c_cnt - {{(N-1){1'b0}}, 1'b1};
    end
    default : begin
        n_state = D_INT;
        n_cnt = {N{1'b0}};
    end
    endcase

    assign dout = (c_state == D_DELAY) ? 1'b1 : 1'b0;

endmodule