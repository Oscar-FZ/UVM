module det_1011 
(
    input clk,
    input rstn,
    input in,
    output out
);

    parameter   IDLE    = 0,
                S1      = 1,
                S10     = 2,
                S101    = 3,
                S1011   = 4;

    reg [2:0] cur_state, next_state;

    assign out = cur_state == S1011 ? 1 : 0;

    always @(posedge clk) begin
        if (!rstn) begin
            cur_state <= IDLE;
        end

        else begin
            cur_state <= next_state; 
        end 
    end

    always @(cur_state or in) begin
        case (cur_state)
            IDLE: begin
                if (in) next_state = S1;
                else next_state = IDLE;       
            end 

            S1: begin
                if (in) next_state = S1;
                else next_state = S10; 
            end

            S10: begin
                if (in) next_state = S101;
                else next_state = IDLE; 
            end

            S101: begin
                if (in) next_state = S1011;
                else next_state = S10; 
            end

            S1011: begin
                if (in) next_state = S1;
                else next_state = S10; 
            end
        endcase
    end
endmodule