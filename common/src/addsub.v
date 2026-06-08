`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2026 12:09:39 AM
// Design Name: 
// Module Name: addsub
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module addsub
#(parameter n = 4)
(
  input S,
  input [n-1:0] A, B,
  output reg [n-1:0] F
);

  always @ (S or A or B) begin
    case (S)
      0: F = A + B;
      1: F = A - B;
    endcase
  end
endmodule
