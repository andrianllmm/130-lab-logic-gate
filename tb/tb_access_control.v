`timescale 1ns / 1ps

module tb_access_control;

    reg Y, S, P, L, T;
    wire A, B, C;

    access_control uut (
        .Y(Y), .S(S), .P(P), .L(L), .T(T),
        .A(A), .B(B), .C(C)
    );

    // Waveform dump
    initial begin
        $dumpfile("sim/dump.vcd"); //creates a file named dump.vcd inside a folder named sim, to visualize it
        $dumpvars(0, tb_access_control); //tells the simulator to record all the signals (vars) within the module tv_access_control; the 0 is shorthand telling it to include all sub-modules as well
    end
    //thing above basically creates a recording of the circuit's behavior while it runs

    task apply_input; //this function puts in the input values to begin the benching
        input y, s, p, l, t; //local variables
        begin
            Y = y; S = s; P = p; L = l; T = t;
            #10; //tells the simulator to wait for 10 time units

            $display("%b %b %b %b %b | %b %b %b",
                     Y, S, P, L, T, A, B, C);
        end
    endtask

    task check; //this function is conditionals to check if logic does what its supposed to do
        input expA, expB, expC;
        begin
            if (A !== expA || B !== expB || C !== expC) begin
                $display("FAIL @ %0t | Expected: %b %b %b | Got: %b %b %b",
                         $time, expA, expB, expC, A, B, C);
            end
        end
    endtask

    // Test sequence
    initial begin

        $display("Y S P L T | A B C");

        // You only
        apply_input(1,0,0,0,0);
        check(1,1,1);

        // SO only
        apply_input(0,1,0,0,0);
        check(1,1,0);

        // Parents only
        apply_input(0,0,1,0,0);
        check(1,0,0);

        // Siblings only
        apply_input(0,0,0,1,0);
        check(0,0,0);

        // Pet only
        apply_input(0,0,0,0,1);
        check(0,0,0);

        // You with SO
        apply_input(1,1,0,0,0);
        check(1,1,0);

        // You with Parents
        apply_input(1,0,1,0,0);
        check(1,0,0);

        // You with Siblings
        apply_input(1,0,0,1,0);
        check(0,0,0);

        // You with Pet
        apply_input(1,0,0,0,1);
        check(0,0,0);

        // Everyone active
        apply_input(1,1,1,1,1);
        check(0,0,0);

        $finish;
    end

endmodule
