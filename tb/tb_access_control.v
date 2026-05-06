`timescale 1ns / 1ps

/*
This testbench verifies the functionality of the
access_control module by applying multiple input
combinations and checking expected outputs.

It also generates a waveform file (VCD) for GTKWave
analysis.
*/

module tb_access_control;

    // Testbench Inputs (Registers)
    reg Y, S, P, L, T;

    // DUT Outputs (Wires)
    wire A, B, C;

    // Instantiate Device Under Test (DUT)
    access_control uut (
        .Y(Y), .S(S), .P(P), .L(L), .T(T),
        .A(A), .B(B), .C(C)
    );

    /*
    Waveform Dump Setup
    Creates a VCD file for GTKWave visualization.
    */
    initial begin
        $dumpfile("sim/dump.vcd"); // output waveform file
        $dumpvars(0, tb_access_control); // dump all signals
    end

    /*
    Apply Input Task
    Sets input values, waits for propagation delay, then prints current output state.
    */
    task apply_input;
        input y, s, p, l, t;
        begin
            Y = y; S = s; P = p; L = l; T = t;
            #10; // propagation delay

            $display("%b %b %b %b %b | %b %b %b",
                     Y, S, P, L, T, A, B, C);
        end
    endtask

    /*
    Check Task
    Compares actual outputs against expected values.
    Prints FAIL message if mismatch occurs.
    */
    task check;
        input expA, expB, expC;
        begin
            // If any output is not as expected, fail
            if (A !== expA || B !== expB || C !== expC) begin
                $display("FAIL @ %0t | Expected: %b %b %b | Got: %b %b %b",
                         $time, expA, expB, expC, A, B, C);
            end
        end
    endtask

    /*
    Test Sequence
    Covers different user combinations to validate logic.
    */
    initial begin

        $display("Y S P L T | A B C");

        // Single user cases
        apply_input(1,0,0,0,0); check(1,1,1); // You only
        apply_input(0,1,0,0,0); check(1,1,0); // SO only
        apply_input(0,0,1,0,0); check(1,0,0); // Parents only
        apply_input(0,0,0,1,0); check(0,0,0); // Siblings only
        apply_input(0,0,0,0,1); check(0,0,0); // Pet only

        // Two-user combinations
        apply_input(1,1,0,0,0); check(1,1,0); // You + SO
        apply_input(1,0,1,0,0); check(1,0,0); // You + Parents
        apply_input(1,0,0,1,0); check(0,0,0); // You + Siblings
        apply_input(1,0,0,0,1); check(0,0,0); // You + Pet
        apply_input(0,1,1,0,0); check(1,0,0); // SO + Parents
        apply_input(0,1,0,1,0); check(0,0,0); // SO + Siblings
        apply_input(0,1,0,0,1); check(0,0,0); // SO + Pet
        apply_input(0,0,1,1,0); check(0,0,0); // Parents + Siblings
        apply_input(0,0,1,0,1); check(0,0,0); // Parents + Pet
        apply_input(0,0,0,1,1); check(0,0,0); // Siblings + Pet

        // Three-user combinations
        apply_input(1,1,1,0,0); check(1,0,0); // You + SO + Parents
        apply_input(1,1,0,1,0); check(0,0,0); // You + SO + Siblings
        apply_input(1,1,0,0,1); check(0,0,0); // You + SO + Pet
        apply_input(1,0,1,1,0); check(0,0,0); // You + Parents + Siblings
        apply_input(1,0,1,0,1); check(0,0,0); // You + Parents + Pet
        apply_input(1,0,0,1,1); check(0,0,0); // You + Siblings + Pet
        apply_input(0,1,1,1,0); check(0,0,0); // SO + Parents + Siblings
        apply_input(0,1,1,0,1); check(0,0,0); // SO + Parents + Pet
        apply_input(0,1,0,1,1); check(0,0,0); // SO + Siblings + Pet
        apply_input(0,0,1,1,1); check(0,0,0); // Parents + Siblings + Pet

        // Four-user combinations
        apply_input(1,1,1,1,0); check(0,0,0);
        apply_input(1,1,1,0,1); check(0,0,0);
        apply_input(1,1,0,1,1); check(0,0,0);
        apply_input(1,0,1,1,1); check(0,0,0);
        apply_input(0,1,1,1,1); check(0,0,0);

        // All users
        apply_input(1,1,1,1,1); check(0,0,0);

        $finish;
    end

endmodule
