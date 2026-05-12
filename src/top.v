module top(
    input  wire Y,
    input  wire S,
    input  wire P,
    input  wire L,
    input  wire T,

    output wire A,
    output wire B,
    output wire C
);

    assign A = (Y | S | P) & ~(L | T);
    assign B = (Y | S) & ~(P | L | T);
    assign C = Y & ~(S | P | L | T);

endmodule
