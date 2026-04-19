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
        $dumpfile("sim/dump.vcd");
        $dumpvars(0, tb_access_control);
    end

    // Apply inputs task
    task apply_input;
        input y, s, p, l, t;
        begin
            Y = y; S = s; P = p; L = l; T = t;
            #10;

            $display("%b %b %b %b %b | %b %b %b",
                     Y, S, P, L, T, A, B, C);
        end
    endtask

    // Check task
    task check;
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
