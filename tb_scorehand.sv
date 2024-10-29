module tb_scorehand();

// Your testbench goes here. Make sure your tests exercise the entire design
// in the .sv file.  Note that in our tests the simulator will exit after
// 10,000 ticks (equivalent to "initial #10000 $finish();").

logic [3:0] test_card1;
logic [3:0] test_card2;
logic [3:0] test_card3;
logic [3:0] test_total;
logic [3:0] test_val1;
logic [3:0] test_val2;
logic [3:0] test_val3;

scorehand dut(.card1(test_card1), .card2(test_card2), .card3(test_card3), .total(test_total));

assign test_val1 = dut.val1;
assign test_val2 = dut.val2;
assign test_val3 = dut.val3;

initial begin
    test_card1 = 4'b0001;
    test_card2 = 4'b0000;
    test_card3 = 4'b0000;
    #10;
    assert(test_val1 == 4'b0001) else $fatal("val1 = %b incorrect for card1 = %b", test_val1, test_card1);
    assert(test_val2 == 4'b0000) else $fatal("val2 = %b incorrect for card2 = %b", test_val2, test_card2);
    assert(test_val3 == 4'b0000) else $fatal("val3 = %b incorrect for card3 = %b", test_val3, test_card3);
    assert(test_total == 4'b0001) else $fatal("Test failed for %b + %b + %b = %b", test_card1, test_card2, test_card3, test_total);
    test_card1 = 4'b0101;
    test_card2 = 4'b0101;
    test_card3 = 4'b0000;
    #10;
    assert(test_val1 == 4'b0101) else $fatal("val1 = %b incorrect for card1 = %b", test_val1, test_card1);
    assert(test_val2 == 4'b0101) else $fatal("val2 = %b incorrect for card2 = %b", test_val2, test_card2);
    assert(test_val3 == 4'b0000) else $fatal("val3 = %b incorrect for card3 = %b", test_val3, test_card3);
    assert(test_total == 4'b0000) else $fatal("Test failed for %b + %b + %b = %b", test_card1, test_card2, test_card3, test_total);

    test_card1 = 4'b0001;
    test_card2 = 4'b0001;
    test_card3 = 4'b0001;
    #10;
    assert(test_val1 == 4'b0001) else $fatal("val1 = %b incorrect for card1 = %b", test_val1, test_card1);
    assert(test_val2 == 4'b0001) else $fatal("val2 = %b incorrect for card2 = %b", test_val2, test_card2);
    assert(test_val3 == 4'b0001) else $fatal("val3 = %b incorrect for card3 = %b", test_val3, test_card3);    
    assert(test_total == 4'b0011) else $fatal("Test failed for %b + %b + %b = %b", test_card1, test_card2, test_card3, test_total);

    test_card1 = 4'b1010;
    test_card2 = 4'b1010;
    test_card3 = 4'b1010;
    #10;
    assert(test_val1 == 4'b0000) else $fatal("val1 = %b incorrect for card1 = %b", test_val1, test_card1);
    assert(test_val2 == 4'b0000) else $fatal("val2 = %b incorrect for card2 = %b", test_val2, test_card2);
    assert(test_val3 == 4'b0000) else $fatal("val3 = %b incorrect for card3 = %b", test_val3, test_card3);    
    assert(test_total == 4'b0000) else $fatal("Test failed for %b + %b + %b = %b", test_card1, test_card2, test_card3, test_total); 

    test_card1 = 4'b1011;
    test_card2 = 4'b1011;
    test_card3 = 4'b1011;
    #10;
    assert(test_val1 == 4'b0000) else $fatal("val1 = %b incorrect for card1 = %b", test_val1, test_card1);
    assert(test_val2 == 4'b0000) else $fatal("val2 = %b incorrect for card2 = %b", test_val2, test_card2);
    assert(test_val3 == 4'b0000) else $fatal("val3 = %b incorrect for card3 = %b", test_val3, test_card3);    
    assert(test_total == 4'b0000) else $fatal("Test failed for %b + %b + %b = %b", test_card1, test_card2, test_card3, test_total);  

    test_card1 = 4'b1100;
    test_card2 = 4'b1100;
    test_card3 = 4'b1100;
    #10;
    assert(test_val1 == 4'b0000) else $fatal("val1 = %b incorrect for card1 = %b", test_val1, test_card1);
    assert(test_val2 == 4'b0000) else $fatal("val2 = %b incorrect for card2 = %b", test_val2, test_card2);
    assert(test_val3 == 4'b0000) else $fatal("val3 = %b incorrect for card3 = %b", test_val3, test_card3);    
    assert(test_total == 4'b0000) else $fatal("Test failed for %b + %b + %b = %b", test_card1, test_card2, test_card3, test_total);  

    test_card1 = 4'b1101;
    test_card2 = 4'b1101;
    test_card3 = 4'b1101;
    #10;
    assert(test_val1 == 4'b0000) else $fatal("val1 = %b incorrect for card1 = %b", test_val1, test_card1);
    assert(test_val2 == 4'b0000) else $fatal("val2 = %b incorrect for card2 = %b", test_val2, test_card2);
    assert(test_val3 == 4'b0000) else $fatal("val3 = %b incorrect for card3 = %b", test_val3, test_card3);    
    assert(test_total == 4'b0000) else $fatal("Test failed for %b + %b + %b = %b", test_card1, test_card2, test_card3, test_total);  

    test_card1 = 4'b1001;
    test_card2 = 4'b1001;
    test_card3 = 4'b1001;
    #10;
    assert(test_val1 == 4'b1001) else $fatal("val1 = %b incorrect for card1 = %b", test_val1, test_card1);
    assert(test_val2 == 4'b1001) else $fatal("val2 = %b incorrect for card2 = %b", test_val2, test_card2);
    assert(test_val3 == 4'b1001) else $fatal("val3 = %b incorrect for card3 = %b", test_val3, test_card3);
    assert(test_total == 4'b0111) else $fatal("Test failed for %b + %b + %b = %b", test_card1, test_card2, test_card3, test_total);   

    test_card1 = 4'b0011;
    test_card2 = 4'b0011;
    test_card3 = 4'b0011;
    #10;
    assert(test_val1 == 4'b0011) else $fatal("val1 = %b incorrect for card1 = %b", test_val1, test_card1);
    assert(test_val2 == 4'b0011) else $fatal("val2 = %b incorrect for card2 = %b", test_val2, test_card2);
    assert(test_val3 == 4'b0011) else $fatal("val3 = %b incorrect for card3 = %b", test_val3, test_card3);
    assert(test_total == 4'b1001) else $fatal("Test failed for %b + %b + %b = %b", test_card1, test_card2, test_card3, test_total);

    #100;
    // $finish;              
end
endmodule
