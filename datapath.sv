//Keeps track of each hand for both player and dealer and computes their scores as each card is dealt,
//instantiating the card7seg, scorehand, dealcard, and reg4 blocks to achieve this

module datapath(input logic slow_clock, input logic fast_clock, input logic resetb,
                input logic load_pcard1, input logic load_pcard2, input logic load_pcard3,
                input logic load_dcard1, input logic load_dcard2, input logic load_dcard3,
                output logic [3:0] pcard3_out,
                output logic [3:0] pscore_out, output logic [3:0] dscore_out,
                output logic [6:0] HEX5, output logic [6:0] HEX4, output logic [6:0] HEX3,
                output logic [6:0] HEX2, output logic [6:0] HEX1, output logic [6:0] HEX0);


logic [3:0] new_card;
logic [3:0] PReg1_out;
logic [3:0] PReg2_out;
logic [3:0] PReg3_out;
logic [3:0] DReg1_out;
logic [3:0] DReg2_out;
logic [3:0] DReg3_out;

dealcard dc(.clock(fast_clock), .resetb(resetb), .new_card(new_card));

reg4 pcard1(.new_card(new_card), .load_card(load_pcard1), .resetb(resetb), .slow_clock(slow_clock), .out(PReg1_out));
reg4 pcard2(.new_card(new_card), .load_card(load_pcard2), .resetb(resetb), .slow_clock(slow_clock), .out(PReg2_out));
reg4 pcard3(.new_card(new_card), .load_card(load_pcard3), .resetb(resetb), .slow_clock(slow_clock), .out(PReg3_out));
reg4 dcard1(.new_card(new_card), .load_card(load_dcard1), .resetb(resetb), .slow_clock(slow_clock), .out(DReg1_out));
reg4 dcard2(.new_card(new_card), .load_card(load_dcard2), .resetb(resetb), .slow_clock(slow_clock), .out(DReg2_out));
reg4 dcard3(.new_card(new_card), .load_card(load_dcard3), .resetb(resetb), .slow_clock(slow_clock), .out(DReg3_out));

assign pcard3_out = PReg3_out;

card7seg pcard1Seg(.card(PReg1_out), .seg7(HEX0));
card7seg pcard2Seg(.card(PReg2_out), .seg7(HEX1));
card7seg pcard3Seg(.card(PReg3_out), .seg7(HEX2));
card7seg dcard1Seg(.card(DReg1_out), .seg7(HEX3));
card7seg dcard2Seg(.card(DReg2_out), .seg7(HEX4));
card7seg dcard3Seg(.card(DReg3_out), .seg7(HEX5));

scorehand score_p(.card1(PReg1_out), .card2(PReg2_out), .card3(PReg3_out), .total(pscore_out));
scorehand score_d(.card1(DReg1_out), .card2(DReg2_out), .card3(DReg3_out), .total(dscore_out));


endmodule

