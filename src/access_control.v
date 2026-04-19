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

    // A = (Y OR S OR P) AND NOT (L OR T)
    assign A = (Y | S | P) & ~(L | T);

    // B = (Y OR S) AND NOT (P OR L OR T)
    assign B = (Y | S) & ~(P | L | T);

    // C = Y AND NOT (S OR P OR L OR T)
    assign C = Y & ~(S | P | L | T);

endmodule
