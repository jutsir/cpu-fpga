`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Juri Tsirihhov
// 
// Create Date: 05/07/2026 11:52:51 PM
// Design Name: 
// Module Name: ram
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Single-port RAM module (32 x 8-bit) initialized with sample
//              program (using the extended EC2e ISA with OUT instructions)
//              upon Reset.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ec2e_ram
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
      // initialize RAM with EC-2 program
      
      ////////////////////////////////////////////////////////
      // COUNT
      // Program to countdown from input n to 0
      mem[0] <= 8'b11100000; // IN A
      //mem[0] <= 8'b00011110; // LOAD A,11110
      mem[1] <= 8'b11101000; // OUT A
      mem[2] <= 8'b01111111; // SUB A, 11111
      mem[3] <= 8'b10100100; // JZ 00101
      mem[4] <= 8'b11000001; // JPOS 00001
      mem[5] <= 8'b11111111; // HALT
      mem[30]<= 8'b00001101; // storage for the constant 13
      mem[31]<= 8'b00000001; // storage for the constant 1

    end else begin
      // write
      if (WE)
        mem[Address] <= D;
    end
    end // always
    
    // read
    always @(*) begin
      Q = mem[Address];
    end
endmodule
