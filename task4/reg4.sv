//4-bit wide register responsible for storing player/dealers hands,
//which allows value from dealcard to be updated or set to 0 based on enable signal and a
//active-low synchronous reset signal 
module reg4(input logic [3:0] new_card, input logic load_card,
            input logic resetb, input logic slow_clock, output logic [3:0] out);
//Defines sequential logic process updating out signal based on the resetb and slow_clock signals
always_ff@(posedge slow_clock) begin
    if(!resetb) begin
        out <= 4'b0000;
    end
    else if(load_card == 1'b1) begin
        out <= new_card;
    end
end
endmodule