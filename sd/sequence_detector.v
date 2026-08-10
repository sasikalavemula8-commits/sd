module sequence_detector (
    input  wire clk,
    input  wire reset,
    input  wire data_in,
    output reg  detected
);

    // State definitions
    parameter S0 = 3'b000;  // No match
    parameter S1 = 3'b001;  // Detected 1
    parameter S2 = 3'b010;  // Detected 10
    parameter S3 = 3'b011;  // Detected 101

    reg [2:0] state, next_state;

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    // Next-state logic
    always @(*) begin
        case (state)

            S0: begin
                if (data_in)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (data_in)
                    next_state = S1;
                else
                    next_state = S2;
            end

            S2: begin
                if (data_in)
                    next_state = S3;
                else
                    next_state = S0;
            end

            S3: begin
                if (data_in) begin
                    next_state = S1;
                end
                else begin
                    next_state = S2;
                end
            end

            default:
                next_state = S0;

        endcase
    end

    // Output logic
    // Sequence 1011 is detected when in S3 and data_in = 1
    always @(*) begin
        if ((state == S3) && (data_in == 1'b1))
            detected = 1'b1;
        else
            detected = 1'b0;
    end

endmodule