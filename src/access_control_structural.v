/*
Structural version of access_control
*/

module access_control (

    input  wire Y,  // You
    input  wire S,  // SO
    input  wire P,  // Parents
    input  wire L,  // Siblings
    input  wire T,  // Pet

    output wire A,  // Money
    output wire B,  // Car Key
    output wire C   // Bitcoin Wallet
);

    // Intermediate wires
    wire w1_A, w2_A;
    wire w1_B, w2_B;
    wire w1_C, w2_C;

    // A = (Y | S | P) & ~(L | T)
    or  (w1_A, Y, S, P);   // Y | S | P
    or  (w2_A, L, T);      // L | T
    not (w2_A, w2_A);      // ~(L | T)
    and (A, w1_A, w2_A);   // final A

    // B = (Y | S) & ~(P | L | T)
    or  (w1_B, Y, S);      // Y | S
    or  (w2_B, P, L, T);   // P | L | T
    not (w2_B, w2_B);      // ~(...)
    and (B, w1_B, w2_B);   // final B

    // C = Y & ~(S | P | L | T)
    or  (w1_C, S, P, L, T); // S | P | L | T
    not (w2_C, w1_C);       // ~(...)
    and (C, Y, w2_C);       // final C

endmodule
