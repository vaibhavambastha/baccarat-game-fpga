`define P1 3'b000
`define D1 3'b001
`define P2 3'b010
`define D2 3'b011
`define P3 3'b100
`define D3 3'b101
`define Result 3'b110
`define Error 3'bxxx
module tb_statemachine();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

logic slow_clock, resetb;
logic [3:0] dscore, pscore, pcard3;
logic load_pcard1, load_pcard2, load_pcard3;
logic load_dcard1, load_dcard2, load_dcard3;
logic player_win_light, dealer_win_light;

logic [2:0] present_state;

statemachine dut(
    .slow_clock(slow_clock), 
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
    .player_win_light(player_win_light),
    .dealer_win_light(dealer_win_light)
);

assign present_state = dut.present_state;

initial begin
    slow_clock = 0;
    forever #5 slow_clock = ~slow_clock;
end

initial begin
    //Test 1: Player scores 9, Dealer scores 9 (Tie)
    resetb = 0; 
    #10;
    assert(present_state == `P1) else $fatal("present_state = %b, should be `P1", present_state);
    assert(load_pcard1 == 1) else $fatal("load_pcard1 = %b, should be 1", load_pcard1);

    resetb = 1;
    pscore = 4'b0100;
    #10;
    assert(present_state == `D1) else $fatal("present_state = %b, should be `D1", present_state);
    assert(load_dcard1 == 1) else $fatal("load_dcard1 = %b, should be 1", load_dcard1);    

    dscore = 4'b0100;
    #10;
    assert(present_state == `P2) else $fatal("present_state = %b, should be `P2", present_state);
    assert(load_pcard2 == 1) else $fatal("load_pcard2 = %b, should be 1", load_pcard2);    

    pscore = 4'b1000;
    #10;
    assert(present_state == `D2) else $fatal("present_state = %b, should be `D2", present_state);
    assert(load_dcard2 == 1) else $fatal("load_pcard2 = %b, should be 1", load_dcard2);        

    dscore = 4'b1000;
    #10;
    assert(present_state == `Result) else $fatal("present_state = %b, should be `Result", present_state);
    assert(player_win_light == 1) else $fatal("player_win_light = %b, should be 1", player_win_light);      
    assert(dealer_win_light == 1) else $fatal("dealer_win_light = %b, should be 1", dealer_win_light);
    
    //Test 2: Player scores first two cards 0-5, Dealer score first two cards 7
    resetb = 0;
    #10;

    resetb = 1;
    pscore = 4'b0000;
    #10;

    dscore = 4'b0000;
    #10;  

    pscore = 4'b0000;
    #10;  

    dscore = 4'b0111;
    #10;
    assert(present_state == `P3) else $fatal("present_state = %b, should be `P3", present_state);
    assert(load_pcard3 == 1) else $fatal("load_pcard2 = %b, should be 1", load_pcard3);

    pscore = 4'b0001;
    pcard3 = 4'b0001;
    #10;
    assert(present_state == `Result) else $fatal("present_state = %b, should be `Result", present_state);
    assert(player_win_light == 0) else $fatal("player_win_light = %b, should be 1", player_win_light);      
    assert(dealer_win_light == 1) else $fatal("dealer_win_light = %b, should be 1", dealer_win_light);  

    //Test 3: Player scores first two cards 0-5, Dealer score first two cards 6, pcard3 = 6 or 7
    resetb = 0;
    #10;

    resetb = 1;
    pscore = 4'b0010;
    #10;    

    dscore = 4'b0000;
    #10;  

    pscore = 4'b0101;
    #10; 

    dscore = 4'b0110;
    #10;

    pscore = 4'b0010;
    pcard3 = 4'b0111;
    #10;
    assert(present_state == `D3) else $fatal("present_state = %b, should be `P3", present_state);
    assert(load_dcard3 == 1) else $fatal("load_dcard3 = %b, should be 1", load_dcard3);
    
    #10;
    assert(present_state == `Result) else $fatal("present_state = %b, should be `Result", present_state);
    assert(player_win_light == 0) else $fatal("player_win_light = %b, should be 1", player_win_light);      
    assert(dealer_win_light == 1) else $fatal("dealer_win_light = %b, should be 1", dealer_win_light);     

    //Test 4: Player scores first two cards 0-5, Dealer score first two cards 6, pcard3 != 6 or 7
    resetb = 0;
    #10;

    resetb = 1;
    pscore = 4'b0010;
    #10; 

    dscore = 4'b0000;
    #10;  

    pscore = 4'b0101;
    #10; 

    dscore = 4'b0110;
    #10;

    pscore = 4'b0011;
    pcard3 = 4'b1000;
    #10;
    assert(present_state == `Result) else $fatal("present_state = %b, should be `Result", present_state);
    assert(player_win_light == 0) else $fatal("player_win_light = %b, should be 1", player_win_light);      
    assert(dealer_win_light == 1) else $fatal("dealer_win_light = %b, should be 1", dealer_win_light);     

    //Test 5: Player scores 0-5 first two cards, Dealer scores 5 first two cards, pcard3 = 4,5,6,7
    resetb = 0;
    #10;

    resetb = 1;
    pscore = 4'b0000;
    #10;

    dscore = 4'b0000;
    #10; 

    pscore = 4'b0000;
    #10;

    dscore = 4'b0101;
    #10;

    pscore = 4'b0100;
    pcard3 = 4'b0100;
    #10;
    assert(present_state == `D3) else $fatal("present_state = %b, should be `D3", present_state);
    assert(load_dcard3 == 1) else $fatal("load_dcard3 = %b, should be 1", load_dcard3);
    
    dscore = 4'b0000;
    #10;
    assert(present_state == `Result) else $fatal("present_state = %b, should be `Result", present_state);
    assert(player_win_light == 1) else $fatal("player_win_light = %b, should be 1", player_win_light);      
    assert(dealer_win_light == 0) else $fatal("dealer_win_light = %b, should be 1", dealer_win_light);   

   //Test 5: Player scores 0-5 first two cards, Dealer scores 5 first two cards, pcard3 != 4,5,6,7
    resetb = 0;
    #10;

    resetb = 1;
    pscore = 4'b0000;
    #10;

    dscore = 4'b0000;
    #10; 

    pscore = 4'b0000;
    #10;

    dscore = 4'b0101;
    #10;

    pscore = 4'b0011;
    pcard3 = 4'b0011;
    #10;

    assert(present_state == `Result) else $fatal("present_state = %b, should be `Result", present_state);
    assert(player_win_light == 0) else $fatal("player_win_light = %b, should be 1", player_win_light);      
    assert(dealer_win_light == 1) else $fatal("dealer_win_light = %b, should be 1", dealer_win_light);

    //Test 6: Player scores 0-5 first two cards, Dealer scores 4 first two cards, pcard3 = 2,3,4,5,6,7     
    resetb = 0;
    #10;

    resetb = 1;
    pscore = 4'b0000;
    #10;

    dscore = 4'b0000;
    #10; 

    pscore = 4'b0000;
    #10;

    dscore = 4'b0100;
    #10;

    pscore = 4'b0100;
    pcard3 = 4'b0100;
    #10;
    assert(present_state == `D3) else $fatal("present_state = %b, should be `D3", present_state);
    assert(load_dcard3 == 1) else $fatal("load_dcard3 = %b, should be 1", load_dcard3);
    
    dscore = 4'b0100;
    #10;
    assert(present_state == `Result) else $fatal("present_state = %b, should be `Result", present_state);
    assert(player_win_light == 1) else $fatal("player_win_light = %b, should be 1", player_win_light);      
    assert(dealer_win_light == 1) else $fatal("dealer_win_light = %b, should be 1", dealer_win_light); 

    //Test 7: Player scores 0-5 first two cards, Dealer scores 4 first two cards, pcard3 != 2,3,4,5,6,7  
    resetb = 0;
    #10;

    resetb = 1;
    pscore = 4'b0000;
    #10;

    dscore = 4'b0000;
    #10; 

    pscore = 4'b0000;
    #10;

    dscore = 4'b0100;
    #10;

    pscore = 4'b1000;
    pcard3 = 4'b1000;
    #10;
    
    assert(present_state == `Result) else $fatal("present_state = %b, should be `Result", present_state);
    assert(player_win_light == 1) else $fatal("player_win_light = %b, should be 1", player_win_light);      
    assert(dealer_win_light == 0) else $fatal("dealer_win_light = %b, should be 1", dealer_win_light);

    //Test 8: Player scores 0-5 first two cards, Dealer scores 3 first two cards, pcard3 != 8
    resetb = 0;
    #10;

    resetb = 1;
    pscore = 4'b0000;
    #10;

    dscore = 4'b0000;
    #10; 

    pscore = 4'b0000;
    #10;

    dscore = 4'b0011;
    #10;

    pscore = 4'b0111;
    pcard3 = 4'b0111;
    #10;
    assert(present_state == `D3) else $fatal("present_state = %b, should be `D3", present_state);
    assert(load_dcard3 == 1) else $fatal("load_dcard3 = %b, should be 1", load_dcard3);
    
    dscore = 4'b0111;
    #10;
    assert(present_state == `Result) else $fatal("present_state = %b, should be `Result", present_state);
    assert(player_win_light == 1) else $fatal("player_win_light = %b, should be 1", player_win_light);      
    assert(dealer_win_light == 1) else $fatal("dealer_win_light = %b, should be 1", dealer_win_light);   

    //Test 9: Player scores 0-5 first two cards, Dealer scores 3 first two cards, pcard3 = 8  
    resetb = 0;
    #10;

    resetb = 1;
    pscore = 4'b0000;
    #10;

    dscore = 4'b0000;
    #10; 

    pscore = 4'b0000;
    #10;

    dscore = 4'b0011;
    #10;

    pscore = 4'b1000;
    pcard3 = 4'b1000;
    #10;
    assert(present_state == `Result) else $fatal("present_state = %b, should be `Result", present_state);
    assert(player_win_light == 1) else $fatal("player_win_light = %b, should be 1", player_win_light);      
    assert(dealer_win_light == 0) else $fatal("dealer_win_light = %b, should be 1", dealer_win_light);

    //Test 10: Player scores 0-5 first two cards, Dealer scores 0,1,2 first two cards
    resetb = 0;
    #10;

    resetb = 1;
    pscore = 4'b0000;
    #10;

    dscore = 4'b0000;
    #10; 

    pscore = 4'b0000;
    #10;

    dscore = 4'b0000;
    #10;

    pscore = 4'b0111;
    pcard3 = 4'b0111;
    #10;
    assert(present_state == `D3) else $fatal("present_state = %b, should be `D3", present_state);
    assert(load_dcard3 == 1) else $fatal("load_dcard3 = %b, should be 1", load_dcard3);
    
    dscore = 4'b0110;
    #10;
    assert(present_state == `Result) else $fatal("present_state = %b, should be `Result", present_state);
    assert(player_win_light == 1) else $fatal("player_win_light = %b, should be 1", player_win_light);      
    assert(dealer_win_light == 0) else $fatal("dealer_win_light = %b, should be 1", dealer_win_light);

    //Test 11: Player scores 6 or 7 first two cards, Dealer scores 0-5 first two cards
    resetb = 0;
    #10;

    resetb = 1;
    pscore = 4'b0000;
    #10;

    dscore = 4'b0000;
    #10;  

    pscore = 4'b0110;
    #10;  

    dscore = 4'b0101;
    #10;
    assert(present_state == `D3) else $fatal("present_state = %b, should be `D3", present_state);
    assert(load_dcard3 == 1) else $fatal("load_dcard3 = %b, should be 1", load_dcard3);

    dscore = 4'b1000;
    #10;
    assert(present_state == `Result) else $fatal("present_state = %b, should be `Result", present_state);
    assert(player_win_light == 0) else $fatal("player_win_light = %b, should be 1", player_win_light);      
    assert(dealer_win_light == 1) else $fatal("dealer_win_light = %b, should be 1", dealer_win_light);     

    //Test 12: Player scores 6 or 7 first two cards, Dealer DOES NOT score 0-5 first two cards
    resetb = 0;
    #10;

    resetb = 1;
    pscore = 4'b0000;
    #10;

    dscore = 4'b0000;
    #10;  

    pscore = 4'b0111;
    #10;  

    dscore = 4'b0111;
    #10;
    assert(present_state == `Result) else $fatal("present_state = %b, should be `Result", present_state);
    assert(player_win_light == 1) else $fatal("player_win_light = %b, should be 1", player_win_light);      
    assert(dealer_win_light == 1) else $fatal("dealer_win_light = %b, should be 1", dealer_win_light);     


    

    #1000;
    // $finish;
end
endmodule
