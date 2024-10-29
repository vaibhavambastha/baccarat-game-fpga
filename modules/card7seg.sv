//Responsible for displaying 7 segment display based on the input card value

`define BLANK 7'b1111111 
`define ACE 7'b0001000
`define TWO 7'b0100100
`define THREE 7'b0110000
`define FOUR 7'b0011001
`define FIVE 7'b0010010
`define SIX 7'b0000010
`define SEVEN 7'b1111000
`define EIGHT 7'b0000000
`define NINE 7'b0010000
`define TEN 7'b1000000
`define JACK 7'b1100001
`define QUEEN 7'b0011000
`define KING 7'b0001001

module card7seg(input logic [3:0] card, output logic [6:0] seg7);  //Reads a 4 bit input representing the card
                                                                   //and converts to 7 segment display 
   
   //Combinational logic that determines the 7-bit segment value for a 4-bit input value
   always_comb begin : led
     case(card)
         4'b0001: seg7 = `ACE;
         4'b0010: seg7 = `TWO;
         4'b0011: seg7 = `THREE;
         4'b0100: seg7 = `FOUR;
         4'b0101: seg7 = `FIVE;
         4'b0110: seg7 = `SIX;
         4'b0111: seg7 = `SEVEN;
         4'b1000: seg7 = `EIGHT;
         4'b1001: seg7 = `NINE;
         4'b1010: seg7 = `TEN;
         4'b1011: seg7 = `JACK;
         4'b1100: seg7 = `QUEEN;
         4'b1101: seg7 = `KING;
         default: seg7 = `BLANK;
     endcase 
   end

endmodule

