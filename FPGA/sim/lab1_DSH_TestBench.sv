// E155: Lab 1 - FPGA & MCU Setup & Testing
// Sebastian Heredia, dheredia@g.hmc.edu
// September 1, 2025
// lab1_DSH_TestBench.sv contains the automatic testbench code for lab1_DSH.sv, ensuring proper simulation.

// NOTE: Derived from Harvey Mudd College E85 Lab 2 tesbench.sv.

`timescale 1ns/1ps	// Standard time unit

module lab1_DSH_TestBench();
	logic clk, reset;
	
	logic [3:0]s;	// 14-bits [13:0]
	logic [2:0]led;
	logic [6:0]seg;
	
	logic [2:0]led_expected;
	logic [6:0]seg_expected;

	logic [31:0] vectornum, errors;
	logic [13:0] testvectors[10000:0];

lab1_DSH dut(reset, s, led, seg);
always
	begin
		clk=1; #5;
		clk=0; #5;
	end

initial

	begin
		$readmemb("lab1_DSH_vectors.tv", testvectors);		// .tv data file in binary from truth table
		
		vectornum=0;
		errors=0;

		reset=1; #220;	// Don't want to reset prematurely, 200ps ensures enough time to test all 16 testvectors
		reset=0;
	end

always @(posedge clk)

		begin
			
			#1;
			{s, led_expected, seg_expected} = testvectors[vectornum];
		end

always @(negedge clk)

	if (reset) begin

		if (led !== led_expected || seg !== seg_expected) begin

			$display("Error: inputs = %b", {s});	// Input signal
		
			$display(" outputs = %b (%b expected)", led, seg, led_expected, seg_expected);	// Output signals and expected

			errors = errors + 1;
		end

		vectornum = vectornum + 1;

		if (testvectors[vectornum] === 14'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);

				$stop;
		end
	end
endmodule
