/*
Combinational logic access control system for three
compartments (A, B, C) based on user permissions.
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

    /*
    A: You, SO, Parents allowed
       Blocked by Siblings or Pet
    */
    assign A = (Y | S | P) & ~(L | T);

    /*
    B: You, SO allowed only
       Blocked by Parents, Siblings, Pet
    */
    assign B = (Y | S) & ~(P | L | T);

    /*
    C: You only
       Blocked by anyone else
    */
    assign C = Y & ~(S | P | L | T);

endmodule
