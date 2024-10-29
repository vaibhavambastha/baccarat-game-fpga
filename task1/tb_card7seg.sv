module tb_card7seg();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

logic [3:0] test_SW;
logic [6:0] test_HEX0;

card7seg dut(
    .SW(test_SW),
    .HEX0(test_HEX0)
);

initial begin 
test_SW = 4'b0000;
#10;
$display("%b | %b | Blank", test_SW, test_HEX0);
assert(test_HEX0 == 7'b1111111) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b0001;
#10;
$display("%b | %b | Ace", test_SW, test_HEX0);
assert(test_HEX0 == 7'b0001000) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b0010;
#10;
$display("%b | %b | Two", test_SW, test_HEX0);
assert(test_HEX0 == 7'b0100100) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b0011;
#10;
$display("%b | %b | Three", test_SW, test_HEX0);
assert(test_HEX0 == 7'b0110000) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b0100;
#10;
$display("%b | %b | Four", test_SW, test_HEX0);
assert(test_HEX0 == 7'b0011001) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b0101;
#10;
$display("%b | %b | Five", test_SW, test_HEX0);
assert(test_HEX0 == 7'b0010010) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b0110;
#10;
$display("%b | %b | Six", test_SW, test_HEX0);
assert(test_HEX0 == 7'b0000010) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b0111;
#10;
$display("%b | %b | Seven", test_SW, test_HEX0);
assert(test_HEX0 == 7'b1111000) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b1000;
#10;
$display("%b | %b | Eight", test_SW, test_HEX0);
assert(test_HEX0 == 7'b0000000) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b1001;
#10;
$display("%b | %b | Nine", test_SW, test_HEX0);
assert(test_HEX0 == 7'b0010000) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b1010;
#10;
$display("%b | %b | Ten", test_SW, test_HEX0);
assert(test_HEX0 == 7'b1000000) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b1011;
#10;
$display("%b | %b | Jack", test_SW, test_HEX0);
assert(test_HEX0 == 7'b1100001) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b1100;
#10;
$display("%b | %b | Queen", test_SW, test_HEX0);
assert(test_HEX0 == 7'b0011000) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b1101;
#10;
$display("%b | %b | King", test_SW, test_HEX0);
assert(test_HEX0 == 7'b0001001) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b1110;
#10;
$display("%b | %b | Blank", test_SW, test_HEX0);
assert(test_HEX0 == 7'b1111111) else $fatal("Test failed for test_SW = %b", test_SW);

test_SW = 4'b1111;
#10;
$display("%b | %b | Blank", test_SW, test_HEX0);
assert(test_HEX0 == 7'b1111111) else $fatal("Test failed for test_SW = %b", test_SW);

#1000;
// $finish;
end 
						
endmodule

