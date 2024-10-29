//Controls the transitions to different states of the game using an active-low synchronous reset signal
//and slow clock, in charge of enabling the load for the player/dealer when they should receive a card
//and determines the logic for whether a the player/dealer should get a third card to determine the winner.

`define P1 3'b000
`define D1 3'b001
`define P2 3'b010
`define D2 3'b011
`define Result 3'b110
`define Error 3'bxxx

module statemachine(input logic slow_clock, input logic resetb,
                    input logic [3:0] dscore, input logic [3:0] pscore, input logic [3:0] pcard3,
                    output logic load_pcard1, output logic load_pcard2, output logic load_pcard3,
                    output logic load_dcard1, output logic load_dcard2, output logic load_dcard3,
                    output logic player_win_light, output logic dealer_win_light);

// The code describing your state machine will go here.  Remember that
// a state machine consists of next state logic, output logic, and the 
// registers that hold the state.  You will want to review your notes from
// CPEN 211 or equivalent if you have forgotten how to write a state machine.

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
            present_state <= `D2;
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
        `Error: {load_pcard1, load_dcard1, load_pcard2, load_dcard2, load_pcard3, load_dcard3, player_win_light, dealer_win_light} = 8'b0_0_0_0_0_0_0_0;
        default: {load_pcard1, load_dcard1, load_pcard2, load_dcard2, load_pcard3, load_dcard3, player_win_light, dealer_win_light} = 8'b0_0_0_0_0_0_0_0; 
    endcase 
end

endmodule

