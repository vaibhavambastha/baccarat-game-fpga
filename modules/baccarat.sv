
module baccarat(input logic CLOCK_50, input logic [3:0] KEY, output logic [9:0] LEDR,
            output logic [6:0] HEX5, output logic [6:0] HEX4, output logic [6:0] HEX3,
            output logic [6:0] HEX2, output logic [6:0] HEX1, output logic [6:0] HEX0);

// some local signals 

logic fast_clock, slow_clock, resetb;
logic load_pcard1, load_pcard2, load_pcard3;
logic load_dcard1, load_dcard2, load_dcard3;
logic [3:0] pscore, dscore;
logic [3:0] pcard3;

assign resetb = KEY[3];
assign slow_clock = KEY[0];
assign fast_clock = CLOCK_50;

// instantiate the datapath

datapath dp(.slow_clock(slow_clock),
            .fast_clock(fast_clock),
            .resetb(resetb),
            .load_pcard1(load_pcard1),
            .load_pcard2(load_pcard2),
            .load_pcard3(load_pcard3),
            .load_dcard1(load_dcard1),
            .load_dcard2(load_dcard2),
            .load_dcard3(load_dcard3),
            .dscore_out(dscore),
            .pscore_out(pscore),
            .pcard3_out(pcard3),
            .HEX5(HEX5),
            .HEX4(HEX4),
            .HEX3(HEX3),
            .HEX2(HEX2),
            .HEX1(HEX1),
            .HEX0(HEX0));

assign LEDR[3:0] = pscore;
assign LEDR[7:4] = dscore;

// instantiate the state machine

statemachine sm(.slow_clock(slow_clock),
                .resetb(resetb),
                .dscore(dscore),
                .pscore(pscore),
                .pcard3(pcard3),
                .load_pcard1(load_pcard1),
                .load_pcard2(load_pcard2),
                .load_pcard3(load_pcard3),						  
                .load_dcard1(load_dcard1),
                .load_dcard2(load_dcard2),
                .load_dcard3(load_dcard3),	
                .player_win_light(LEDR[8]), 
                .dealer_win_light(LEDR[9]));

endmodule
