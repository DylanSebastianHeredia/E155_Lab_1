// E155: Lab 1 - FPGA & MCU Setup & Testing
// Sebastian Heredia, dheredia@g.hmc.edu
// September 1, 2025
// SevenSegment_TestBench.sv contains the automatic testbench code for SevenSegment.sv, ensuring proper simulation. 

// NOTE: Derived from Harvey Mudd College E85 Lab 2 tesbench.sv.

`timescale 1ns/1ps	// Standard time unit

module SevenSegment_TestBench();
	logic clk, reset;
	
	logic [3:0]s;	// 11-bits [10:0]
	logic [6:0]seg;
	
	logic [6:0]seg_expected;

	logic [31:0] vectornum, errors;
	logic [10:0] testvectors[10000:0];

SevenSegment dut(s, seg);
always
	begin
		clk=1; #5;
		clk=0; #5;
	end

initial

	begin
		$readmemb("SevenSegment_vectors.tv", testvectors);		// .tv data file in binary from truth table
		
		vectornum=0;
		errors=0;

		reset=1; #220;	// Don't want to reset prematurely, 220ps ensures enough time to test all 16 testvectors
		reset=1;
	end

always @(posedge clk)

		begin
			
			#1;
			{s, seg_expected} = testvectors[vectornum];
		end

always @(negedge clk)

	if (reset) begin

		if (seg !== seg_expected) begin

			$display("Error: inputs = %b", {s});	// input signal
			
			$display(" outputs = %b (%b expected)", seg, seg_expected);	// output signals and expected

			errors = errors + 1;
		end

		vectornum = vectornum + 1;

		if (testvectors[vectornum] === 11'bx) begin
				$display("%d tests completed with %d errors", vectornum, errors);

				$stop;
		end
	end
endmodule
