//Combinational circuit which computes the value of three cards, varying scores from 0-9
module scorehand(input logic [3:0] card1, input logic [3:0] card2, input logic [3:0] card3, output logic [3:0] total);

// The code describing scorehand will go here.  Remember this is a combinational
// block. The function is described in the handout. Be sure to review Verilog
// notes on bitwidth mismatches and signed/unsigned numbers.
logic [3:0] val1;
logic [3:0] val2;
logic [3:0] val3;
//Combinational logic block which determines the score of the player/dealer based on the 3 input cards
always_comb begin : scorehand
    case(card1) 
    4'b1010: val1 = 4'b0000;
    4'b1011: val1 = 4'b0000;
    4'b1100: val1 = 4'b0000;
    4'b1101: val1 = 4'b0000;
    default: val1 = card1;
    endcase
    case(card2) 
    4'b1010: val2 = 4'b0000;
    4'b1011: val2 = 4'b0000;
    4'b1100: val2 = 4'b0000;
    4'b1101: val2 = 4'b0000;
    default: val2 = card2;
    endcase
    case(card3) 
    4'b1010: val3 = 4'b0000;
    4'b1011: val3 = 4'b0000;
    4'b1100: val3 = 4'b0000;
    4'b1101: val3 = 4'b0000;
    default: val3 = card3;
    endcase

total = (val1 + val2 + val3) % 10;
end

endmodule

