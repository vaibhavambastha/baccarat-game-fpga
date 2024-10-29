//Combinational circuit which computes the value of three cards, varying scores from 0-9

module scorehand(input logic [3:0] card1, input logic [3:0] card2, input logic [3:0] card3, output logic [3:0] total);

logic [3:0] val1;
logic [3:0] val2;
logic [3:0] val3;

//Combinational logic block which determines the score of the player/dealer based on the 3 input cards
always_comb begin : scorehand
    if((card1 == 4'b1010) || (card1 == 4'b1011) || (card1 == 4'b1100) || (card1 == 4'b1101)) begin
        val1 = 4'b0000;
    end
    else begin
        val1 = card1;
    end
    if((card2 == 4'b1010) || (card2 == 4'b1011) || (card2 == 4'b1100) || (card2 == 4'b1101)) begin
        val2 = 4'b0000;
    end
    else begin
        val2 = card2;
    end
    if((card3 == 4'b1010) || (card3 == 4'b1011) || (card3 == 4'b1100) || (card3 == 4'b1101)) begin
        val3 = 4'b0000;
    end
    else begin
        val3 = card3;
    end

total = (val1 + val2 + val3) % 10;
end

endmodule

