module tx(
    clk,
    n_rst,
    load,
    txen,
    tx_data,
    txd,
    tx_stop
);

input clk;
input n_rst;
input load;
input txen;
input [7:0] tx_data;

output reg txd;
output tx_stop;

localparam ST0 = 3'h0;
localparam ST1 = 3'h1;
localparam ST2 = 3'h2;
localparam ST3 = 3'h3;
localparam ST4 = 3'h4;

reg [2:0] c_state;
reg [2:0] n_state;

reg [3:0] c_cnt;
reg [3:0] n_cnt;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        c_state <= ST0;
        c_cnt <= 4'h1;
    end
    else begin
        c_state <= n_state;
        c_cnt <= n_cnt;
    end
end

always @(c_state or load or txen or n_cnt) begin
    case(c_state)
    ST0 : n_state = (load == 1'b1) ? ST1 : c_state;
    ST1 : n_state = (txen == 1'b1) ? ST2 : c_state;
    ST2 : n_state = (n_cnt == 4'h2) ? ST3 : c_state;
    ST3 : n_state = (n_cnt == 4'hA) ? ST4 : c_state;
    ST4 : n_state = (n_cnt == 4'h1) ? ST0 : c_state;
    default : n_state = ST0;
    endcase
end

always @(c_state or txen or c_cnt) begin
    case(c_state)
    ST0 : n_cnt = 4'h1;
    ST1 : n_cnt = c_cnt;
    default : n_cnt = (txen == 1'b0) ? c_cnt :
                      (c_cnt == 4'hA) ? 4'h1 : c_cnt + 4'h1;
    endcase
end

reg [7:0] tx_data_in;

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        tx_data_in <= 8'h00;
    end
    else if(c_state == ST2) begin
        tx_data_in <= tx_data;
    end
    else if(c_state == ST3) begin
        tx_data_in <= (txen == 1'b1) ? {1'b0, tx_data_in[7:1]} : tx_data_in;
    end
    else begin
        tx_data_in <= tx_data_in;
    end
end

always @(posedge clk or negedge n_rst) begin
    if(!n_rst) begin
        txd <= 1'b1;
    end
    else if(c_state == ST2) begin
        txd <= 1'b0;
    end
    else if(c_state == ST3) begin
        txd <= (txen == 1'b0) ? tx_data_in[0] : txd;
    end
    else if(c_state == ST4) begin
        txd <= 1'b1;
    end
    else begin
        txd <= txd;
    end
end

assign tx_stop = ((c_state == ST4)&&(txen == 1'b1)) ? 1'b1 : 1'b0;

endmodule