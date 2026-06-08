`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/09/2026 01:25:32 AM
// Design Name: 
// Module Name: display7seg4x
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


module display7seg4x(
  input Clock,              // Refresh clock for multiplexing
  input [7:0] binary,       // 8-bit input binary number
  input signednumber,       // Sign mode selector
  output [7:0] Segs,        // Segments output [a,b,c,d,e,f,g,dp]
  output reg [7:0] Anodes   // Anode control (active LOW for most FPGAs)
);

  // Internal signals to hold BCD digits
  wire [3:0] bcd_h, bcd_t, bcd_o;
  wire minus_flag;
  reg [3:0] mux_data;       // Data selected for current display cycle
  
  // 2-bit counter to cycle through the 4 digits
  reg [1:0] digit_sel = 2'b00;
  
  always @(posedge Clock) begin
      digit_sel <= digit_sel + 1;
  end

  // --- 1. Instantiate Binary to BCD Converter ---
  bin2bcd converter (
    .binary(binary),
    .signednumber(signednumber),
    .hundreds(bcd_h),
    .tens(bcd_t),
    .ones(bcd_o),
    .minus(minus_flag)
  );

  // --- 2. Multiplexer: Select BCD digit based on counter ---
  always @(*) begin
    case(digit_sel)
      2'b00: mux_data = bcd_o;       // Units
      2'b01: mux_data = bcd_t;       // Tens
      2'b10: mux_data = bcd_h;       // Hundreds
      2'b11: mux_data = (minus_flag) ? 4'hA : 4'hF; // Sign or Empty
      default: mux_data = 4'hF;
    endcase
  end

  // --- 3. Instantiate BCD to 7-Segment Decoder ---
  bcd2segs decoder (
    .I(mux_data),
    .Segs(Segs)
  );

  // --- 4. Anode Control Logic ---
  // Note: We use Active LOW logic here (0 = Display ON, 1 = Display OFF)
  // Most common FPGA boards (like Nexys or Basys) use this scheme.
  always @(*) begin
    Anodes = 8'hFF; // Default: all displays OFF
    case(digit_sel)
      2'b00: Anodes[0] = 1'b0; // Activate 1st Digit (Ones)
      2'b01: Anodes[1] = 1'b0; // Activate 2nd Digit (Tens)
      2'b10: Anodes[2] = 1'b0; // Activate 3rd Digit (Hundreds)
      2'b11: Anodes[3] = 1'b0; // Activate 4th Digit (Sign)
    endcase
  end

endmodule
