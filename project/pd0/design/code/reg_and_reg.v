/**
* Exercise 3.4
* you can change the code below freely
  * */
module reg_and_reg(
  input  wire clock,
  input  wire reset,
  input  wire x,
  input  wire y,
  output reg  z
);

  // Register inputs x & y with synchronous reset
  reg x_tmp, y_tmp;
  always @ (posedge clock) begin 
    if (reset == 1'b1) begin
      x_tmp <= 1'b0;
      y_tmp <= 1'b0;
    end else begin
      x_tmp <= x;
      y_tmp <= y;
    end
  end

  // Register output z with synchronous reset
  always @ (posedge clock) begin
    if (reset == 1'b1)
      z <= 1'b0;
    else
      z <= x_tmp & y_tmp;
  end
endmodule
