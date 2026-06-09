`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Juri Tsirihhov
// 
// Create Date: 05/09/2026 12:52:53 AM
// Design Name: 
// Module Name: bin2bcd
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Converts an 8-bit binary number to three BCD digits using
//              the Double Dabble algorithm, with optional signed input
//              support.
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module bin2bcd(
  input [7:0] binary,          // 8-bit input binary number
  input signednumber,          // Switch: 1 = signed (2's complement), 0 = unsigned
  output reg [3:0] hundreds,   // BCD output for hundreds digit
  output reg [3:0] tens,       // BCD output for tens digit
  output reg [3:0] ones,       // BCD output for ones digit
  output reg minus             // Negative sign flag (1 if number is negative)
);

  integer i;
  reg [11:0] bcd;              // Internal register to store 3 BCD digits
  reg [7:0] abs_value;         // Absolute value of the input number

  always @(*) begin
    // --- 1. Sign Handling ---
    // Check if the number is signed and negative (MSB is 1)
    if (signednumber && binary[7]) begin
      minus = 1'b1;
      abs_value = ~binary + 1'b1; // Convert 2's complement to magnitude
    end else begin
      minus = 1'b0;
      abs_value = binary;         // Keep as is if unsigned or positive
    end

    // --- 2. Initialize BCD register ---
    bcd = 12'b0;

    // --- 3. Double Dabble Algorithm ---
    for (i = 0; i < 8; i = i + 1) begin
      
      // Check each BCD nibble. If value is 5 or greater, add 3.
      // This adjustment compensates for the base-10 carry when shifting.
      
      // Units nibble (4 bits: 3 down to 0)
      if (bcd[3:0] >= 5)
          bcd[3:0] = bcd[3:0] + 3;
          
      // Tens nibble (4 bits: 7 down to 4)
      if (bcd[7:4] >= 5)
          bcd[7:4] = bcd[7:4] + 3;

      // Hundreds nibble (4 bits: 11 down to 8)
      // Note: For an 8-bit input (max 255), 'hundreds' will never reach 5 
      // before the final shift, so this check is technically optional.
      if (bcd[11:8] >= 5)
          bcd[11:8] = bcd[11:8] + 3;

      // --- 4. Shift ---
      // Concatenate BCD and the next bit of binary input, then shift left by 1.
      // This moves the MSB of abs_value into the LSB of the BCD register.
      bcd = {bcd[10:0], abs_value[7-i]};
    end

    // --- 5. Output Assignment ---
    hundreds = bcd[11:8];
    tens     = bcd[7:4];
    ones     = bcd[3:0];
  end
endmodule
