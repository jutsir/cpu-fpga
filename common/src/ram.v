`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2026 11:52:51 PM
// Design Name: 
// Module Name: ram
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


module ram
#(parameter size=5)
(
  input Clock,
  input Reset,
  input WE,
  input [size-1:0] Address,
  input [7:0] D,
  output reg [7:0] Q
);
  reg [7:0] mem[2**size-1:0];
  
  always @(posedge Clock or posedge Reset) begin
    // this reset block and the Reset signal
    // is only needed to initialize the RAM locations
    if (Reset) begin
      // initialize RAM with program
    end else begin
      // write
      if (WE)
        mem[Address] <= D;
    end
    end // always
    
    // read
    always @ (Address) begin
      Q <= mem[Address];
    end
endmodule
