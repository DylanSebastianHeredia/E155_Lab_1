// E155: Lab 1 - FPGA & MCU Setup & Testing
// Sebastian Heredia, dheredia@g.hmc.edu
// September 1, 2025
// lab1_DSH.sv contains code to interface four SW6 on the UPduino 3.1 with three on-board LEDS and the 7-segment display. lab1_DSH.sv 

module lab1_DSH (	input logic 		reset,
					input logic		[3:0]s,
					output logic 	[2:0]led,
					output logic		[6:0]seg
				);
				
	// led[0]
	assign led[0] = s[1] ^ s[0];		// XOR from table

	// led[1]
	assign led[1] = s[3] & s[2];		// AND from table

	// led[2] - Given in E155 tutorial
	logic 		int_osc;				// Integer # of oscillations
	logic [31:0]counter = 0;			// Start with counter at 0
	logic 		led_state = 0;
  
	// Instatntiate HSOSC module
	HSOSC #(.CLKHF_DIV(2'b01)) 		// Divide clk to 24MHz
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(int_osc));
  
    // Counter for 2.4Hz
	always_ff @(posedge int_osc) begin
		if (reset == 0)begin
			counter   <= 0;
			led_state <= 0;
		end 
		
		// 24MHz / 2.4Hz = 10E6
		// 10E6 / 2 = 5E6 for toggle (ON-OFF)
		// Subtract 1 since [4,999,999:0] is 5E6 bits
												
		else if (counter == 5000000-1) begin
			counter   <= 0;
			led_state <= ~led_state;  	// Toggle LED OFF after 5E6 counts
		end 
		
		else begin
			counter <= counter + 1;		// Continue incrementing counter
		end
	end

	assign led[2] = led_state;

    // Instantiate SevenSegment module
    SevenSegment SevenSeg(s, seg);

endmodule


