`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/08/2026 12:51:55 AM
// Design Name: 
// Module Name: mp
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


module ec2_mp(
  input Clock, Reset, Enter,
  input [7:0] Input,
  output [7:0] Output,
  output reg Halt,
  output [3:0] debug
);

  reg [3:0] state;
  reg [7:0] IR;
  reg [4:0] PC;
  reg [7:0] A;
  reg [4:0] memory_address;
  wire [7:0] memory_data;
  reg MemWr;

  ec2_ram U5_ram(.Clock(Clock), .Reset(Reset), .WE(MemWr),
  .Address(memory_address), .D(A), .Q(memory_data));
  
  
  always @ (posedge Clock, posedge Reset) begin
    if (Reset) begin
      PC <= 5'b00000;
      IR <= 8'b00000000;
      A <= 8'b00000000;
      MemWr <= 1'b0;
      Halt <= 1'b0;
      state<=4'b0000;
      end
    else
      case (state)
      4'b0000: begin // Start
        memory_address <= PC;
        MemWr <= 1'b0;
        state <= 4'b0001;
        end
      4'b0001: begin // Fetch
        IR <= memory_data;
        PC <= PC + 1;
        state<=4'b0010;
        end
      4'b0010: begin // Decode
        // memory access using last 5 bits of IR
        memory_address <= IR[4:0];
        MemWr <= 1'b0;            // Reset MemWr by default for all commands
        case (IR[7:5])
          3'b000: state<=4'b1000; // Load
          3'b001: begin           // Store
            MemWr <= 1'b1;        // Set MemWr only for Store
            state<=4'b1001;
            end
          3'b010: state<=4'b1010; // Add
          3'b011: state<=4'b1011; // Sub
          3'b100: state<=4'b1100; // Input
          3'b101: state<=4'b1101; // JZ
          3'b110: state<=4'b1110; // Jpos
          3'b111: state<=4'b1111; // Halt
          default:state<=4'b0000; // Start
        endcase
        end
      4'b1000: begin // Load
        A <= memory_data;
        state<=4'b0000;
        end
      4'b1001: begin // Store
        MemWr <= 1'b0;
        state<=4'b0000;
        end
      4'b1010: begin // Add
        A <= A + memory_data;
        state<=4'b0000;
        end
      4'b1011: begin // Sub
        A <= A - memory_data;
        state<=4'b0000;
        end
      4'b1100: begin // Input
        A <= Input;
        if (Enter) begin
          state<=4'b0000;
          end
        else begin
          state<=4'b1100;
          end
        end
      4'b1101: begin // Jz
        if (A == 0)
          PC <= IR[4:0];
        state<=4'b0000;
        end
      4'b1110: begin // Jpos
        if (A[7] == 1'b0)
          PC <= IR[4:0];
        state<=4'b0000;
        end
      4'b1111: begin // Halt
        Halt <= 1'b1;
        state<=4'b1111;
        end
      default: begin
        state<=4'b0000;
        end
      endcase
  end // always
  
  assign Output = A; // send value of Accumulator to the output
  assign debug = state;

endmodule
