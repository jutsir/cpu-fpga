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
      // initialize RAM with EC-2 program
      
//      mem[0] <= 8'b00011110; // LOAD A,11110
//      mem[1] <= 8'b00011111; // LOAD A,11111
//      mem[2] <= 8'b11111111; // HALT
//      mem[30]<= 8'b00001101; // storage for the constant 13
//      mem[31]<= 8'b00000001; // storage for the constant 1      
      
      ////////////////////////////////////////////////////////
      // COUNT
      // Program to countdown from input n to 0
      mem[0] <= 8'b10000000; // IN A
      //mem[0] <= 8'b00011110; // LOAD A,11110
      mem[1] <= 8'b01111111; // SUB A, 11111
      mem[2] <= 8'b10100100; // JZ 00100
      mem[3] <= 8'b11000001; // JPOS 00001
      mem[4] <= 8'b11111111; // HALT
      mem[30]<= 8'b00001101; // storage for the constant 13
      mem[31]<= 8'b00000001; // storage for the constant 1
      
      /////////////////////////////////////////////////
      // SUM
      // Program to sum n downto 1 where n is an input number
//      mem[0] <= 8'b00011101; // LOAD A,one       // to zero sum
//      mem[1] <= 8'b01111101; // SUB A,one        // by doing 1 - 1
//      mem[2] <= 8'b00111110; // STORE A,sum
      
//      mem[3] <= 8'b10000000; // IN A
//      mem[4] <= 8'b00111111; // STORE A,n
      
//      mem[5] <= 8'b00011111; // loop: LOAD A,n   // n + sum
//      mem[6] <= 8'b01011110; // ADD A,sum
//      mem[7] <= 8'b00111110; // STORE A,sum
//      mem[8] <= 8'b00011111; // LOAD A,n         // decrement A
//      mem[9] <= 8'b01111101; // SUB A,one
//      mem[10]<= 8'b00111111; // STORE A,n 

//      mem[11]<= 8'b10101101; // JZ out
//      mem[12]<= 8'b11000101; // JPOS loop
//      mem[13]<= 8'b00011110; // out: LOAD A,sum
//      mem[14]<= 8'b11111111; // HALT
      
//      mem[29]<= 8'b00000001; // storage for the constant 1
//      mem[30]<= 8'b00000000; // storage for variable sum
//      mem[31]<= 8'b00000000; // storage for variable n
      
      ////////////////////////////////////////////////////////
      // GCD
      // Program to calculate the GCD of two input
      // numbers, x and y
//      mem[0] <= 8'b10000000; // IN A             // input x
//      mem[1] <= 8'b00111110; // STORE A,x
//      mem[2] <= 8'b10000000; // IN A             // input y
//      mem[3] <= 8'b00111111; // STORE A,y
      
//      mem[4] <= 8'b00011110; // loop: LOAD A,x   // x=y?
//      mem[5] <= 8'b01111111; // SUB A,y
//      mem[6] <= 8'b10110000; // JZ out           // x=y
//      mem[7] <= 8'b11001100; // JPOS xgty        // x>y

//      mem[8] <= 8'b00011111; // LOAD A,y         // y>x
//      mem[9] <= 8'b01111110; // SUB A,x          // y-x
//      mem[10]<= 8'b00111111; // STORE A,y
//      mem[11]<= 8'b11000100; // JPOS loop        
      
//      mem[12]<= 8'b00011110; // xgty: LOAD A,x   // x>y
//      mem[13]<= 8'b01111111; // SUB A,y          // x-y
//      mem[14]<= 8'b00111110; // STORE A,x
//      mem[15]<= 8'b11000100; // JPOS loop 

//      mem[16] = 8'b00011110; // out: LOAD A,x
//      mem[17] = 8'b11111111; // HALT
      
//      mem[30] = 8'b00000000; // storage for variable x
//      mem[31] = 8'b00000000; // storage for variable y

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
