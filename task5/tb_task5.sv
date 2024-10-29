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
module tb_task5();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 100,000 ticks (equivalent to "initial #100000 $finish();").

// module task5(input logic CLOCK_50, input logic [3:0] KEY, output logic [9:0] LEDR,
//             output logic [6:0] HEX5, output logic [6:0] HEX4, output logic [6:0] HEX3,
//             output logic [6:0] HEX2, output logic [6:0] HEX1, output logic [6:0] HEX0);

logic CLOCK_50;
logic [3:0] KEY;
logic [9:0] LEDR;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;



task5 dut(
    .CLOCK_50(CLOCK_50),
    .KEY(KEY),
    .LEDR(LEDR),
    .HEX5(HEX5),
    .HEX4(HEX4),
    .HEX3(HEX3),
    .HEX2(HEX2),
    .HEX1(HEX1),
    .HEX0(HEX0)
);


initial begin
    CLOCK_50 = 0;
    forever #5 CLOCK_50 = ~CLOCK_50;
end

initial begin
    //Test full cycle
    KEY[0] = 0;
    KEY[3] = 0;
    #10;
    KEY[0] = 1;
    #10;
    KEY[0] = 0;
    #10;
    KEY[0] = 1;
    KEY[3] = 1;
    #10;
    KEY[0] = 0;
    #10;  //p1
    KEY[0] = 1;
    #10;
    KEY[0] = 0;
    #10;  //d1
    KEY[0] = 1;
    #10;
    KEY[0] = 0;
    #10;  //p2    
    KEY[0] = 1;
    #10;
    KEY[0] = 0;
    #10;  //d2
    KEY[0] = 1;
    #10;
    KEY[0] = 0;
    #10;  //p3
    KEY[0] = 1;
    #10;
    KEY[0] = 0;
    #10;  //d3
    KEY[0] = 1;
    #10;
    KEY[0] = 0;
    #10; //final    

    assert(HEX0 == `ACE) else $fatal("HEX0 = %b, expected: ACE", HEX0);
    assert(HEX1 == `FIVE) else $fatal("HEX1 = %b, expected: FIVE", HEX1);
    assert(HEX2 == `BLANK) else $fatal("HEX2 = %b, expected: BLANK", HEX2);
    assert(HEX3 == `THREE) else $fatal("HEX3 = %b, expected: THREE", HEX3);
    assert(HEX4 == `SEVEN) else $fatal("HEX4 = %b, expected: SEVEN", HEX4);
    assert(HEX5 == `NINE) else $fatal("HEX5 = %b, expected: NINE", HEX5);
    assert(LEDR[7:4] == 4'b1001) else $fatal("Dealer Score = %b, expected: 4'b1001", LEDR[7:4]);
    assert(LEDR[3:0] == 4'b0110) else $fatal("Player Score = %b, expected: 4'b0110", LEDR[3:0]);
    assert(LEDR[9] == 1) else $fatal("Dealer won, light should be ON");
    assert(LEDR[8] == 0) else $fatal("Player lost, light should be OFF");
    

    //Test dut.dp.PReg1_out
    #10;
    force dut.dp.PReg1_out = 4'b0001;
    #10;
    assert(HEX0 == `ACE) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.dp.PReg1_out, HEX0);
    #10;
    force dut.dp.PReg1_out = 4'b0010;
    #10;
    assert(HEX0 == `TWO) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.dp.PReg1_out, HEX0);
    #10;
    force dut.dp.PReg1_out = 4'b0011;
    #10;
    assert(HEX0 == `THREE) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.dp.PReg1_out, HEX0);
    #10;
    force dut.dp.PReg1_out = 4'b0100;
    #10;
    assert(HEX0 == `FOUR) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.dp.PReg1_out, HEX0);
    #10;
    force dut.dp.PReg1_out = 4'b0101;
    #10;
    assert(HEX0 == `FIVE) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.dp.PReg1_out, HEX0);
    #10;
    force dut.dp.PReg1_out = 4'b0110;
    #10;
    assert(HEX0 == `SIX) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.dp.PReg1_out, HEX0);
    #10;
    force dut.dp.PReg1_out = 4'b0111;
    #10;
    assert(HEX0 == `SEVEN) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.dp.PReg1_out, HEX0);
    #10;
    force dut.dp.PReg1_out = 4'b1000;
    #10;
    assert(HEX0 == `EIGHT) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.dp.PReg1_out, HEX0);
    #10;
    force dut.dp.PReg1_out = 4'b1001;
    #10;
    assert(HEX0 == `NINE) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.dp.PReg1_out, HEX0);
    #10;
    force dut.dp.PReg1_out = 4'b1010;
    #10;
    assert(HEX0 == `TEN) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.dp.PReg1_out, HEX0);
    #10;
    force dut.dp.PReg1_out = 4'b1011;
    #10;
    assert(HEX0 == `JACK) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.dp.PReg1_out, HEX0);
    #10;
    force dut.dp.PReg1_out = 4'b1100;
    #10;
    assert(HEX0 == `QUEEN) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.dp.PReg1_out, HEX0);
    #10;
    force dut.dp.PReg1_out = 4'b1101;
    #10;
    assert(HEX0 == `KING) else $fatal("PReg1_out = %b, but HEX0 = %b", dut.dp.PReg1_out, HEX0);
    #10;
    release dut.dp.PReg1_out;
    
    //Test dut.dp.PReg2_out
    #10;
    force dut.dp.PReg2_out = 4'b0001;
    #10;
    assert(HEX1 == `ACE) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.dp.PReg2_out, HEX1);
    #10;
    force dut.dp.PReg2_out = 4'b0010;
    #10;
    assert(HEX1 == `TWO) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.dp.PReg2_out, HEX1);
    #10;
    force dut.dp.PReg2_out = 4'b0011;
    #10;
    assert(HEX1 == `THREE) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.dp.PReg2_out, HEX1);
    #10
    force dut.dp.PReg2_out = 4'b0100;
    #10;
    assert(HEX1 == `FOUR) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.dp.PReg2_out, HEX1);
    #10;
    force dut.dp.PReg2_out = 4'b0101;
    #10;
    assert(HEX1 == `FIVE) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.dp.PReg2_out, HEX1);
    #10;
    force dut.dp.PReg2_out = 4'b0110;
    #10;
    assert(HEX1 == `SIX) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.dp.PReg2_out, HEX1);
    #10;
    force dut.dp.PReg2_out = 4'b0111;
    #10;
    assert(HEX1 == `SEVEN) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.dp.PReg2_out, HEX1);
    #10;
    force dut.dp.PReg2_out = 4'b1000;
    #10;
    assert(HEX1 == `EIGHT) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.dp.PReg2_out, HEX1);
    #10;
    force dut.dp.PReg2_out = 4'b1001;
    #10;
    assert(HEX1 == `NINE) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.dp.PReg2_out, HEX1);
    #10;
    force dut.dp.PReg2_out = 4'b1010;
    #10;
    assert(HEX1 == `TEN) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.dp.PReg2_out, HEX1);
    #10;
    force dut.dp.PReg2_out = 4'b1011;
    #10;
    assert(HEX1 == `JACK) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.dp.PReg2_out, HEX1);
    #10;
    force dut.dp.PReg2_out = 4'b1100;
    #10;
    assert(HEX1 == `QUEEN) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.dp.PReg2_out, HEX1);
    #10;
    force dut.dp.PReg2_out = 4'b1101;
    #10;
    assert(HEX1 == `KING) else $fatal("PReg2_out = %b, but HEX1 = %b", dut.dp.PReg2_out, HEX1);
    #10;
    release dut.dp.PReg2_out;
    
    //Test dut.dp.PReg3_out
    #10;
    force dut.dp.PReg3_out = 4'b0001;
    #10;
    assert(HEX2 == `ACE) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.dp.PReg2_out, HEX2);
    #10;
    force dut.dp.PReg3_out = 4'b0010;
    #10;
    assert(HEX2 == `TWO) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.dp.PReg2_out, HEX2);
    #10;
    force dut.dp.PReg3_out = 4'b0011;
    #10;
    assert(HEX2 == `THREE) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.dp.PReg2_out, HEX2);
    #10
    force dut.dp.PReg3_out = 4'b0100;
    #10;
    assert(HEX2 == `FOUR) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.dp.PReg2_out, HEX2);
    #10;
    force dut.dp.PReg3_out = 4'b0101;
    #10;
    assert(HEX2 == `FIVE) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.dp.PReg2_out, HEX2);
    #10;
    force dut.dp.PReg3_out = 4'b0110;
    #10;
    assert(HEX2 == `SIX) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.dp.PReg2_out, HEX2);
    #10;
    force dut.dp.PReg3_out = 4'b0111;
    #10;
    assert(HEX2 == `SEVEN) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.dp.PReg2_out, HEX2);
    #10;
    force dut.dp.PReg3_out = 4'b1000;
    #10;
    assert(HEX2 == `EIGHT) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.dp.PReg2_out, HEX2);
    #10;
    force dut.dp.PReg3_out = 4'b1001;
    #10;
    assert(HEX2 == `NINE) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.dp.PReg2_out, HEX2);
    #10;
    force dut.dp.PReg3_out = 4'b1010;
    #10;
    assert(HEX2 == `TEN) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.dp.PReg2_out, HEX2);
    #10;
    force dut.dp.PReg3_out = 4'b1011;
    #10;
    assert(HEX2 == `JACK) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.dp.PReg2_out, HEX2);
    #10;
    force dut.dp.PReg3_out = 4'b1100;
    #10;
    assert(HEX2 == `QUEEN) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.dp.PReg2_out, HEX2);
    #10;
    force dut.dp.PReg3_out = 4'b1101;
    #10;
    assert(HEX2 == `KING) else $fatal("PReg3_out = %b, but HEX2 = %b", dut.dp.PReg2_out, HEX2);
    #10;
    release dut.dp.PReg3_out;
    
    //Test dut.dp.DReg1_out
    #10;
    force dut.dp.DReg1_out = 4'b0001;
    #10;
    assert(HEX3 == `ACE) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.dp.DReg1_out, HEX3);
    #10;
    force dut.dp.DReg1_out = 4'b0010;
    #10;
    assert(HEX3 == `TWO) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.dp.DReg1_out, HEX3);
    #10;
    force dut.dp.DReg1_out = 4'b0011;
    #10;
    assert(HEX3 == `THREE) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.dp.DReg1_out, HEX3);
    #10;
    force dut.dp.DReg1_out = 4'b0100;
    #10;
    assert(HEX3 == `FOUR) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.dp.DReg1_out, HEX3);
    #10;
    force dut.dp.DReg1_out = 4'b0101;
    #10;
    assert(HEX3 == `FIVE) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.dp.DReg1_out, HEX3);
    #10;
    force dut.dp.DReg1_out = 4'b0110;
    #10;
    assert(HEX3 == `SIX) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.dp.DReg1_out, HEX3);
    #10;
    force dut.dp.DReg1_out = 4'b0111;
    #10;
    assert(HEX3 == `SEVEN) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.dp.DReg1_out, HEX3);
    #10;
    force dut.dp.DReg1_out = 4'b1000;
    #10;
    assert(HEX3 == `EIGHT) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.dp.DReg1_out, HEX3);
    #10;
    force dut.dp.DReg1_out = 4'b1001;
    #10;
    assert(HEX3 == `NINE) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.dp.DReg1_out, HEX3);
    #10;
    force dut.dp.DReg1_out = 4'b1010;
    #10;
    assert(HEX3 == `TEN) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.dp.DReg1_out, HEX3);
    #10;
    force dut.dp.DReg1_out = 4'b1011;
    #10;
    assert(HEX3 == `JACK) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.dp.DReg1_out, HEX3);
    #10;
    force dut.dp.DReg1_out = 4'b1100;
    #10;
    assert(HEX3 == `QUEEN) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.dp.DReg1_out, HEX3);
    #10;
    force dut.dp.DReg1_out = 4'b1101;
    #10;
    assert(HEX3 == `KING) else $fatal("DReg1_out = %b, but HEX3 = %b", dut.dp.DReg1_out, HEX3);
    #10;
    release dut.dp.DReg1_out;

    //Test dut.dp.DReg2_out
    #10;
    force dut.dp.DReg2_out = 4'b0001;
    #10;
    assert(HEX4 == `ACE) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.dp.DReg2_out, HEX4);
    #10;
    force dut.dp.DReg2_out = 4'b0010;
    #10;
    assert(HEX4 == `TWO) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.dp.DReg2_out, HEX4);
    #10;
    force dut.dp.DReg2_out = 4'b0011;
    #10;
    assert(HEX4 == `THREE) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.dp.DReg2_out, HEX4);
    #10;
    force dut.dp.DReg2_out = 4'b0100;
    #10;
    assert(HEX4 == `FOUR) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.dp.DReg2_out, HEX4);
    #10;
    force dut.dp.DReg2_out = 4'b0101;
    #10;
    assert(HEX4 == `FIVE) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.dp.DReg2_out, HEX4);
    #10;
    force dut.dp.DReg2_out = 4'b0110;
    #10;
    assert(HEX4 == `SIX) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.dp.DReg2_out, HEX4);
    #10;
    force dut.dp.DReg2_out = 4'b0111;
    #10;
    assert(HEX4 == `SEVEN) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.dp.DReg2_out, HEX4);
    #10;
    force dut.dp.DReg2_out = 4'b1000;
    #10;
    assert(HEX4 == `EIGHT) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.dp.DReg2_out, HEX4);
    #10;
    force dut.dp.DReg2_out = 4'b1001;
    #10;
    assert(HEX4 == `NINE) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.dp.DReg2_out, HEX4);
    #10;
    force dut.dp.DReg2_out = 4'b1010;
    #10;
    assert(HEX4 == `TEN) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.dp.DReg2_out, HEX4);
    #10;
    force dut.dp.DReg2_out = 4'b1011;
    #10;
    assert(HEX4 == `JACK) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.dp.DReg2_out, HEX4);
    #10;
    force dut.dp.DReg2_out = 4'b1100;
    #10;
    assert(HEX4 == `QUEEN) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.dp.DReg2_out, HEX4);
    #10;
    force dut.dp.DReg2_out = 4'b1101;
    #10;
    assert(HEX4 == `KING) else $fatal("DReg2_out = %b, but HEX4 = %b", dut.dp.DReg2_out, HEX4);
    #10;
    release dut.dp.DReg2_out;
    #10;

    //Test dut.dp.DReg3_out
    #10;
    force dut.dp.DReg3_out = 4'b0001;
    #10;
    assert(HEX5 == `ACE) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.dp.DReg2_out, HEX5);
    #10;
    force dut.dp.DReg3_out = 4'b0010;
    #10;
    assert(HEX5 == `TWO) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.dp.DReg2_out, HEX5);
    #10;
    force dut.dp.DReg3_out = 4'b0011;
    #10;
    assert(HEX5 == `THREE) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.dp.DReg2_out, HEX5);
    #10;
    force dut.dp.DReg3_out = 4'b0100;
    #10;
    assert(HEX5 == `FOUR) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.dp.DReg2_out, HEX5);
    #10;
    force dut.dp.DReg3_out = 4'b0101;
    #10;
    assert(HEX5 == `FIVE) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.dp.DReg2_out, HEX5);
    #10;
    force dut.dp.DReg3_out = 4'b0110;
    #10;
    assert(HEX5 == `SIX) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.dp.DReg2_out, HEX5);
    #10;
    force dut.dp.DReg3_out = 4'b0111;
    #10;
    assert(HEX5 == `SEVEN) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.dp.DReg2_out, HEX5);
    #10;
    force dut.dp.DReg3_out = 4'b1000;
    #10;
    assert(HEX5 == `EIGHT) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.dp.DReg2_out, HEX5);
    #10;
    force dut.dp.DReg3_out = 4'b1001;
    #10;
    assert(HEX5 == `NINE) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.dp.DReg2_out, HEX5);
    #10;
    force dut.dp.DReg3_out = 4'b1010;
    #10;
    assert(HEX5 == `TEN) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.dp.DReg2_out, HEX5);
    #10;
    force dut.dp.DReg3_out = 4'b1011;
    #10;
    assert(HEX5 == `JACK) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.dp.DReg2_out, HEX5);
    #10;
    force dut.dp.DReg3_out = 4'b1100;
    #10;
    assert(HEX5 == `QUEEN) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.dp.DReg2_out, HEX5);
    #10;
    force dut.dp.DReg3_out = 4'b1101;
    #10;
    assert(HEX5 == `KING) else $fatal("DReg2_out = %b, but HEX5 = %b", dut.dp.DReg2_out, HEX5);
    #10;
    release dut.dp.DReg3_out;
    #10;


    #1000;
    // $finish;
end

endmodule