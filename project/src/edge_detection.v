module edge_detection(
    clk,
    n_rst,
    data,
    tick,
    tick_rising,
    tick_falling
);

    input clk;
    input n_rst;
    input data;

    output tick;
    output tick_rising;
    output tick_falling;
    
    reg tick;

    reg state;
    reg next_state;

    localparam S_LOW = 1'b0;
    localparam S_HIGH = 1'b1;

    always @(posedge clk or negedge n_rst)
    if(!n_rst) state <= S_LOW;
    else       state <= next_state;

    always @(state or data)
        case(state)
        S_LOW  : begin
            next_state = (data == 1'b1) ? S_HIGH  : state;
            tick = (data == 1'b1)? 1'b1 : 1'b0; 
        end
        S_HIGH : begin
            next_state = (data == 1'b0) ? S_LOW   : state;
            tick = (data == 1'b0)? 1'b1 : 1'b0;

        end
        default: next_state = S_LOW;
        endcase

    assign tick_rising = ((state == S_LOW)&&(data == 1'b1))? 1'b1 : 1'b0;
    assign tick_falling = ((state == S_HIGH)&&(data == 1'b0))? 1'b1 : 1'b0;

endmodule