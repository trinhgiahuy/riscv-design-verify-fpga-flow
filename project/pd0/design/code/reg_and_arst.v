/**
* Exercise 3.3 
* you can change the code below freely
  * */
module reg_and_arst(
  input  wire clock,
  input  wire areset,
  input  wire x,
  input  wire y,
  output reg  z
);
  
  reg out;
  // asynchronous reset adds to sensitivity list with new signal --reset
  always @(posedge clock or posedge areset) begin
    if ( areset == 1'b1 )
      z <= 1'b0; //reset condition
    else
      z <= x & y; 
  end
endmodule


/*
  * Asnwer difference between asynchronous and synchronous resets:
  * Synchronous reset (Sync reset) are aligned with clock which mean when reset is enable, it will take effect until next positive/negative clock edge.  
  * Asynchronous reset are independent from clock, which will take effect immediately without waiting for next active clock edge. 
  * 
*/
