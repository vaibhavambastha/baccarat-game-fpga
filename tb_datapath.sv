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
module tb_datapath();


logic slow_clock, fast_clock, resetb, load_pcard1, load_pcard2, load_pcard3, load_dcard1, load_dcard2, load_dcard3;
logic [3:0] pcard3_out, pscore_out, dscore_out;
logic [6:0] HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

logic [3:0] new_card;

datapath dut(
    .slow_clock(slow_clock),
    .fast_clock(fast_clock),
    .resetb(resetb),
    .load_pcard1(load_pcard1),
    .load_pcard2(load_pcard2),
    .load_pcard3(load_pcard3),
    .load_dcard1(load_dcard1),
    .load_dcard2(load_dcard2),
    .load_dcard3(load_dcard3),
    .pcard3_out(pcard3_out),
    .pscore_out(pscore_out),
    .dscore_out(dscore_out),
    .HEX5(HEX5),
    .HEX4(HEX4),
    .HEX3(HEX3),
    .HEX2(HEX2),
    .HEX1(HEX1),
    .HEX0(HEX0)
);

assign new_card = dut.new_card;

initial begin
    fast_clock = 0;
    forever #5 fast_clock = ~fast_clock;
end

initial begin
    #10;
    slow_clock = 0;
    resetb = 0;
    load_pcard1 = 0;
    load_pcard2 = 0;
    load_pcard3 = 0;
    load_dcard1 = 0;
    load_dcard2 = 0;
    load_dcard3 = 0;
    #10;
    slow_clock = 1;
    #10;
    slow_clock = 0;
    #10;
    slow_clock = 1;
    assert(pscore_out == 4'b0000) else $display("pscore_out should be 4'b0000 but pscore_out = %b", pscore_out);
    assert(dscore_out == 4'b0000) else $display("dscore_out should be 4'b0000 but dscore_out = %b", dscore_out);
    resetb = 1;
    load_pcard1 = 1;
    #10;
    slow_clock = 0;
    #10;
    slow_clock = 1;
    load_pcard1 = 0;
    load_dcard1 = 1;
    #10;
    slow_clock = 0;
    #10;
    slow_clock = 1;
    assert(HEX3 == `THREE) else $display("HEX3 not THREE");
    load_dcard1 = 0;
    load_pcard2 = 1;
    #10;
    slow_clock = 0;
    #10;
    slow_clock = 1;
    assert(HEX1 == `FIVE) else $display("HEX1 not FIVE");
    load_pcard2 = 0;
    load_dcard2 = 1;
    #10;
    slow_clock = 0;
    #10;
    slow_clock = 1;
    assert(HEX4 == `SEVEN) else $display("HEX4 not SEVEN"); 
    load_dcard2 = 0;
    load_pcard3 = 1;       
    #10;
    slow_clock = 0;
    #10;
    slow_clock = 1;    
    assert(HEX2 == `NINE) else $display("HEX2 not NINE");
    assert(pcard3_out == 4'b1001) else $display("pcard3_out = %b, expected: 4'b1001", pcard3_out);
    load_pcard3 = 0;
    load_dcard3 = 1;
    #10;
    slow_clock = 0;
    #10;
    slow_clock = 1; 
    assert(HEX5 == `JACK) else $display("HEX5 not JACK");      
    #10;

    //Test dut.PReg1_out
    #10;
    force dut.PReg1_out = 4'b0001;
    #10;
    assert(HEX0 == `ACE) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.PReg1_out, HEX0);
    #10;
    force dut.PReg1_out = 4'b0010;
    #10;
    assert(HEX0 == `TWO) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.PReg1_out, HEX0);
    #10;
    force dut.PReg1_out = 4'b0011;
    #10;
    assert(HEX0 == `THREE) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.PReg1_out, HEX0);
    #10;
    force dut.PReg1_out = 4'b0100;
    #10;
    assert(HEX0 == `FOUR) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.PReg1_out, HEX0);
    #10;
    force dut.PReg1_out = 4'b0101;
    #10;
    assert(HEX0 == `FIVE) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.PReg1_out, HEX0);
    #10;
    force dut.PReg1_out = 4'b0110;
    #10;
    assert(HEX0 == `SIX) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.PReg1_out, HEX0);
    #10;
    force dut.PReg1_out = 4'b0111;
    #10;
    assert(HEX0 == `SEVEN) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.PReg1_out, HEX0);
    #10;
    force dut.PReg1_out = 4'b1000;
    #10;
    assert(HEX0 == `EIGHT) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.PReg1_out, HEX0);
    #10;
    force dut.PReg1_out = 4'b1001;
    #10;
    assert(HEX0 == `NINE) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.PReg1_out, HEX0);
    #10;
    force dut.PReg1_out = 4'b1010;
    #10;
    assert(HEX0 == `TEN) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.PReg1_out, HEX0);
    #10;
    force dut.PReg1_out = 4'b1011;
    #10;
    assert(HEX0 == `JACK) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.PReg1_out, HEX0);
    #10;
    force dut.PReg1_out = 4'b1100;
    #10;
    assert(HEX0 == `QUEEN) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.PReg1_out, HEX0);
    #10;
    force dut.PReg1_out = 4'b1101;
    #10;
    assert(HEX0 == `KING) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.PReg1_out, HEX0);
    #10;
    release dut.PReg1_out;
    
    //Test dut.PReg2_out
    #10;
    force dut.PReg2_out = 4'b0001;
    #10;
    assert(HEX1 == `ACE) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.PReg2_out, HEX1);
    #10;
    force dut.PReg2_out = 4'b0010;
    #10;
    assert(HEX1 == `TWO) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.PReg2_out, HEX1);
    #10;
    force dut.PReg2_out = 4'b0011;
    #10;
    assert(HEX1 == `THREE) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.PReg2_out, HEX1);
    #10
    force dut.PReg2_out = 4'b0100;
    #10;
    assert(HEX1 == `FOUR) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.PReg2_out, HEX1);
    #10;
    force dut.PReg2_out = 4'b0101;
    #10;
    assert(HEX1 == `FIVE) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.PReg2_out, HEX1);
    #10;
    force dut.PReg2_out = 4'b0110;
    #10;
    assert(HEX1 == `SIX) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.PReg2_out, HEX1);
    #10;
    force dut.PReg2_out = 4'b0111;
    #10;
    assert(HEX1 == `SEVEN) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.PReg2_out, HEX1);
    #10;
    force dut.PReg2_out = 4'b1000;
    #10;
    assert(HEX1 == `EIGHT) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.PReg2_out, HEX1);
    #10;
    force dut.PReg2_out = 4'b1001;
    #10;
    assert(HEX1 == `NINE) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.PReg2_out, HEX1);
    #10;
    force dut.PReg2_out = 4'b1010;
    #10;
    assert(HEX1 == `TEN) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.PReg2_out, HEX1);
    #10;
    force dut.PReg2_out = 4'b1011;
    #10;
    assert(HEX1 == `JACK) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.PReg2_out, HEX1);
    #10;
    force dut.PReg2_out = 4'b1100;
    #10;
    assert(HEX1 == `QUEEN) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.PReg2_out, HEX1);
    #10;
    force dut.PReg2_out = 4'b1101;
    #10;
    assert(HEX1 == `KING) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.PReg2_out, HEX1);
    #10;
    release dut.PReg2_out;
    
    //Test dut.PReg3_out
    #10;
    force dut.PReg3_out = 4'b0001;
    #10;
    assert(HEX2 == `ACE) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.PReg2_out, HEX2);
    #10;
    force dut.PReg3_out = 4'b0010;
    #10;
    assert(HEX2 == `TWO) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.PReg2_out, HEX2);
    #10;
    force dut.PReg3_out = 4'b0011;
    #10;
    assert(HEX2 == `THREE) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.PReg2_out, HEX2);
    #10
    force dut.PReg3_out = 4'b0100;
    #10;
    assert(HEX2 == `FOUR) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.PReg2_out, HEX2);
    #10;
    force dut.PReg3_out = 4'b0101;
    #10;
    assert(HEX2 == `FIVE) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.PReg2_out, HEX2);
    #10;
    force dut.PReg3_out = 4'b0110;
    #10;
    assert(HEX2 == `SIX) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.PReg2_out, HEX2);
    #10;
    force dut.PReg3_out = 4'b0111;
    #10;
    assert(HEX2 == `SEVEN) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.PReg2_out, HEX2);
    #10;
    force dut.PReg3_out = 4'b1000;
    #10;
    assert(HEX2 == `EIGHT) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.PReg2_out, HEX2);
    #10;
    force dut.PReg3_out = 4'b1001;
    #10;
    assert(HEX2 == `NINE) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.PReg2_out, HEX2);
    #10;
    force dut.PReg3_out = 4'b1010;
    #10;
    assert(HEX2 == `TEN) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.PReg2_out, HEX2);
    #10;
    force dut.PReg3_out = 4'b1011;
    #10;
    assert(HEX2 == `JACK) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.PReg2_out, HEX2);
    #10;
    force dut.PReg3_out = 4'b1100;
    #10;
    assert(HEX2 == `QUEEN) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.PReg2_out, HEX2);
    #10;
    force dut.PReg3_out = 4'b1101;
    #10;
    assert(HEX2 == `KING) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.PReg2_out, HEX2);
    #10;
    release dut.PReg3_out;
    
    //Test dut.DReg1_out
    #10;
    force dut.DReg1_out = 4'b0001;
    #10;
    assert(HEX3 == `ACE) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.DReg1_out, HEX3);
    #10;
    force dut.DReg1_out = 4'b0010;
    #10;
    assert(HEX3 == `TWO) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.DReg1_out, HEX3);
    #10;
    force dut.DReg1_out = 4'b0011;
    #10;
    assert(HEX3 == `THREE) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.DReg1_out, HEX3);
    #10;
    force dut.DReg1_out = 4'b0100;
    #10;
    assert(HEX3 == `FOUR) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.DReg1_out, HEX3);
    #10;
    force dut.DReg1_out = 4'b0101;
    #10;
    assert(HEX3 == `FIVE) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.DReg1_out, HEX3);
    #10;
    force dut.DReg1_out = 4'b0110;
    #10;
    assert(HEX3 == `SIX) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.DReg1_out, HEX3);
    #10;
    force dut.DReg1_out = 4'b0111;
    #10;
    assert(HEX3 == `SEVEN) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.DReg1_out, HEX3);
    #10;
    force dut.DReg1_out = 4'b1000;
    #10;
    assert(HEX3 == `EIGHT) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.DReg1_out, HEX3);
    #10;
    force dut.DReg1_out = 4'b1001;
    #10;
    assert(HEX3 == `NINE) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.DReg1_out, HEX3);
    #10;
    force dut.DReg1_out = 4'b1010;
    #10;
    assert(HEX3 == `TEN) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.DReg1_out, HEX3);
    #10;
    force dut.DReg1_out = 4'b1011;
    #10;
    assert(HEX3 == `JACK) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.DReg1_out, HEX3);
    #10;
    force dut.DReg1_out = 4'b1100;
    #10;
    assert(HEX3 == `QUEEN) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.DReg1_out, HEX3);
    #10;
    force dut.DReg1_out = 4'b1101;
    #10;
    assert(HEX3 == `KING) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.DReg1_out, HEX3);
    #10;
    release dut.DReg1_out;

    //Test dut.DReg2_out
    #10;
    force dut.DReg2_out = 4'b0001;
    #10;
    assert(HEX4 == `ACE) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.DReg2_out, HEX4);
    #10;
    force dut.DReg2_out = 4'b0010;
    #10;
    assert(HEX4 == `TWO) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.DReg2_out, HEX4);
    #10;
    force dut.DReg2_out = 4'b0011;
    #10;
    assert(HEX4 == `THREE) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.DReg2_out, HEX4);
    #10;
    force dut.DReg2_out = 4'b0100;
    #10;
    assert(HEX4 == `FOUR) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.DReg2_out, HEX4);
    #10;
    force dut.DReg2_out = 4'b0101;
    #10;
    assert(HEX4 == `FIVE) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.DReg2_out, HEX4);
    #10;
    force dut.DReg2_out = 4'b0110;
    #10;
    assert(HEX4 == `SIX) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.DReg2_out, HEX4);
    #10;
    force dut.DReg2_out = 4'b0111;
    #10;
    assert(HEX4 == `SEVEN) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.DReg2_out, HEX4);
    #10;
    force dut.DReg2_out = 4'b1000;
    #10;
    assert(HEX4 == `EIGHT) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.DReg2_out, HEX4);
    #10;
    force dut.DReg2_out = 4'b1001;
    #10;
    assert(HEX4 == `NINE) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.DReg2_out, HEX4);
    #10;
    force dut.DReg2_out = 4'b1010;
    #10;
    assert(HEX4 == `TEN) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.DReg2_out, HEX4);
    #10;
    force dut.DReg2_out = 4'b1011;
    #10;
    assert(HEX4 == `JACK) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.DReg2_out, HEX4);
    #10;
    force dut.DReg2_out = 4'b1100;
    #10;
    assert(HEX4 == `QUEEN) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.DReg2_out, HEX4);
    #10;
    force dut.DReg2_out = 4'b1101;
    #10;
    assert(HEX4 == `KING) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.DReg2_out, HEX4);
    #10;
    release dut.DReg2_out;
    #10;

    //Test dut.DReg3_out
    #10;
    force dut.DReg3_out = 4'b0001;
    #10;
    assert(HEX5 == `ACE) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.DReg2_out, HEX5);
    #10;
    force dut.DReg3_out = 4'b0010;
    #10;
    assert(HEX5 == `TWO) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.DReg2_out, HEX5);
    #10;
    force dut.DReg3_out = 4'b0011;
    #10;
    assert(HEX5 == `THREE) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.DReg2_out, HEX5);
    #10;
    force dut.DReg3_out = 4'b0100;
    #10;
    assert(HEX5 == `FOUR) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.DReg2_out, HEX5);
    #10;
    force dut.DReg3_out = 4'b0101;
    #10;
    assert(HEX5 == `FIVE) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.DReg2_out, HEX5);
    #10;
    force dut.DReg3_out = 4'b0110;
    #10;
    assert(HEX5 == `SIX) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.DReg2_out, HEX5);
    #10;
    force dut.DReg3_out = 4'b0111;
    #10;
    assert(HEX5 == `SEVEN) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.DReg2_out, HEX5);
    #10;
    force dut.DReg3_out = 4'b1000;
    #10;
    assert(HEX5 == `EIGHT) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.DReg2_out, HEX5);
    #10;
    force dut.DReg3_out = 4'b1001;
    #10;
    assert(HEX5 == `NINE) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.DReg2_out, HEX5);
    #10;
    force dut.DReg3_out = 4'b1010;
    #10;
    assert(HEX5 == `TEN) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.DReg2_out, HEX5);
    #10;
    force dut.DReg3_out = 4'b1011;
    #10;
    assert(HEX5 == `JACK) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.DReg2_out, HEX5);
    #10;
    force dut.DReg3_out = 4'b1100;
    #10;
    assert(HEX5 == `QUEEN) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.DReg2_out, HEX5);
    #10;
    force dut.DReg3_out = 4'b1101;
    #10;
    assert(HEX5 == `KING) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.DReg2_out, HEX5);
    #10;
    release dut.DReg3_out;
    #10;

    #1000;
    // $finish;   
end

endmodule
