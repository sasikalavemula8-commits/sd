`timescale 1ns/1ps

module sequence_detector_tb;

    reg clk;
    reg reset;
    reg data_in;
    wire detected;

    // Instantiate the sequence detector
    sequence_detector uut (
        .clk(clk),
        .reset(reset),
        .data_in(data_in),
        .detected(detected)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Task to send one bit
    task send_bit;
        input bit_value;
        begin
            data_in = bit_value;
            #10;

            $display(
                "Time = %0t | Input = %b | Detected = %b",
                $time,
                data_in,
                detected
            );
        end
    endtask

    initial begin

        // Initialize signals
        clk = 0;
        reset = 1;
        data_in = 0;

        // Reset
        #10;
        reset = 0;

        // Send sequence: 1011
        send_bit(1);
        send_bit(0);
        send_bit(1);
        send_bit(1);

        // Additional data
        send_bit(0);
        send_bit(1);
        send_bit(1);

        // Finish simulation
        #10;
        $finish;

    end

endmodule