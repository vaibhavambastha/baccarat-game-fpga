//Controls the transitions to different states of the game using an active-low synchronous reset signal
//and slow clock, in charge of enabling the load for the player/dealer when they should receive a card
//and determines the logic for whether a the player/dealer should get a third card to determine the winner.

`define P1 3'b000
`define D1 3'b001
`define P2 3'b010
`define D2 3'b011
`define P3 3'b100
`define D3 3'b101
`define Result 3'b110
`define Error 3'bxxx

module statemachine(input logic slow_clock, input logic resetb,
                    input logic [3:0] dscore, input logic [3:0] pscore, input logic [3:0] pcard3,
                    output logic load_pcard1, output logic load_pcard2, output logic load_pcard3,
                    output logic load_dcard1, output logic load_dcard2, output logic load_dcard3,
                    output logic player_win_light, output logic dealer_win_light);


logic [2:0] present_state;
//Finite state machine that determines sequential logic
always_ff @(posedge slow_clock) begin 
    if(!resetb) begin
        present_state = `P1;
    end else begin
        case(present_state)
        `P1:
            present_state <= `D1;
        `D1:
            present_state <= `P2;
        `P2:
            present_state <= `D2;
        `D2:
            if((pscore == 4'b1000) || (dscore == 4'b1000) || (pscore == 4'b1001) || (dscore == 4'b1001)) begin
                present_state <= `Result;
            end
            else if((pscore >= 4'b0000) && (pscore <= 4'b0101)) begin
                present_state <= `P3;
            end
            else if((dscore >= 4'b0000) && (dscore <= 4'b0101)) begin
                present_state <= `D3;
            end
            else begin
                present_state <= `Result;
            end
        `P3:
            if(dscore == 4'b0111) begin
                present_state <= `Result;
            end
            else if(dscore == 4'b0110) begin
                if((pcard3 == 4'b0110) || (pcard3 == 4'b0111)) begin
                    present_state <= `D3;
                end
                else begin
                    present_state <= `Result;
                end
            end
            else if(dscore == 4'b0101) begin
                if((pcard3 == 4'b0100) || (pcard3 == 4'b0101) || (pcard3 == 4'b0110) || (pcard3 == 4'b0111)) begin
                    present_state <= `D3;
                end
                else begin
                    present_state <= `Result;
                end
            end
            else if(dscore == 4'b0100) begin
                if((pcard3 == 4'b0010) || (pcard3 == 4'b0011) || (pcard3 == 4'b0100) || (pcard3 == 4'b0101) || (pcard3 == 4'b0110) || (pcard3 == 4'b0111)) begin
                    present_state <= `D3;
                end
                else begin
                    present_state <= `Result;
                end
            end
            else if(dscore == 4'b0011) begin
                if(pcard3 == 4'b1000) begin
                    present_state <= `Result;
                end
                else begin
                    present_state <= `D3;
                end
            end
            else begin
                present_state <= `D3;
            end            
        `D3:
            present_state <= `Result;
        `Result:
            present_state <= `Result;
        default: present_state <= `Error;
        endcase
    end

end 
//Combinational logic block which handles loading the cards for player/dealer and displays LED for the appropriate winner
always_comb begin 
    case(present_state) 
        `P1: {load_pcard1, load_dcard1, load_pcard2, load_dcard2, load_pcard3, load_dcard3, player_win_light, dealer_win_light} = 8'b1_0_0_0_0_0_0_0;     
        `D1: {load_pcard1, load_dcard1, load_pcard2, load_dcard2, load_pcard3, load_dcard3, player_win_light, dealer_win_light} = 8'b0_1_0_0_0_0_0_0;     
        `P2: {load_pcard1, load_dcard1, load_pcard2, load_dcard2, load_pcard3, load_dcard3, player_win_light, dealer_win_light} = 8'b0_0_1_0_0_0_0_0;     
        `D2: {load_pcard1, load_dcard1, load_pcard2, load_dcard2, load_pcard3, load_dcard3, player_win_light, dealer_win_light} = 8'b0_0_0_1_0_0_0_0;     
        `P3: {load_pcard1, load_dcard1, load_pcard2, load_dcard2, load_pcard3, load_dcard3, player_win_light, dealer_win_light} = 8'b0_0_0_0_1_0_0_0;     
        `D3: {load_pcard1, load_dcard1, load_pcard2, load_dcard2, load_pcard3, load_dcard3, player_win_light, dealer_win_light} = 8'b0_0_0_0_0_1_0_0;     
        `Result: 
            if(pscore > dscore) begin
                {load_pcard1, load_dcard1, load_pcard2, load_dcard2, load_pcard3, load_dcard3, player_win_light, dealer_win_light} = 8'b0_0_0_0_0_0_1_0;     
            end
            else if(dscore > pscore) begin
                {load_pcard1, load_dcard1, load_pcard2, load_dcard2, load_pcard3, load_dcard3, player_win_light, dealer_win_light} = 8'b0_0_0_0_0_0_0_1;     
            end
            else begin 
                {load_pcard1, load_dcard1, load_pcard2, load_dcard2, load_pcard3, load_dcard3, player_win_light, dealer_win_light} = 8'b0_0_0_0_0_0_1_1;     
            end
        `Error: {load_pcard1, load_dcard1, load_pcard2, load_dcard2, load_pcard3, load_dcard3, player_win_light, dealer_win_light} = 8'b0_0_0_0_0_0_0_0;
        default: {load_pcard1, load_dcard1, load_pcard2, load_dcard2, load_pcard3, load_dcard3, player_win_light, dealer_win_light} = 8'b0_0_0_0_0_0_0_0;
    endcase 

end

endmodule

