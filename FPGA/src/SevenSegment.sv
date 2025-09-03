// E155: Lab 1 - FPGA & MCU Setup & Testing
// Sebastian Heredia, dheredia@g.hmc.edu
// September 1, 2025
// SevenSegment.sv contains combinational logic to display hex numbers 0-f on the 7-segment display.

module SevenSegment (	input logic	[3:0]s,		// 4-bits
						output logic	[6:0]seg);	// 7-bits

	always_comb begin
		casez(s)	// s is the SW6 variable (4-bits for 4 SWs)
			4'h0: seg = 7'b1000000;	// 0
			4'h1: seg = 7'b1111001;	// 1
			4'h2: seg = 7'b0100100;	// 2
			4'h3: seg = 7'b0110000; 	// 3
			4'h4: seg = 7'b0011001; 	// 4
			4'h5: seg = 7'b0010010; 	// 5
			4'h6: seg = 7'b0000010; 	// 6
			4'h7: seg = 7'b1111000; 	// 7
			4'h8: seg = 7'b0000000; 	// 8
			4'h9: seg = 7'b0011000; 	// 9
			4'ha: seg = 7'b0001000; 	// A
			4'hb: seg = 7'b0000011; 	// b
			4'hc: seg = 7'b1000110; 	// C
			4'hd: seg = 7'b0100001; 	// d
			4'he: seg = 7'b0000110; 	// E
			4'hf: seg = 7'b0001110;	// F
			default: seg = 7'b1111111;
		endcase
	end
endmodule
