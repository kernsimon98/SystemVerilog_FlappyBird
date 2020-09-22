module UserIn(clk, reset, in, out);
	input logic in, clk, reset;
	output logic out;
	
	logic meta;
	
	D_FF sw (.clk(clk),.q(meta), .d(in), .reset(reset));
	D_FF sw1 (.clk(clk),.q(out), .d(meta), .reset(reset));
	
endmodule


module UserIn_testbench();
	logic clk, reset, in;
	logic out;

	UserIn dut (clk, reset, in, out);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
									@(posedge clk);
		reset <= 1;  in <= 0;@(posedge clk);
		reset <= 0;   			@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
						in <= 1; @(posedge clk);
						in <= 0; @(posedge clk);
						in <= 1; @(posedge clk);
						in <= 0;	@(posedge clk);
						in <= 1; @(posedge clk);
						in <= 0; @(posedge clk);
						in <= 1; @(posedge clk);
						in <= 0; @(posedge clk);
						in <= 1; @(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
		reset <= 1;          @(posedge clk);
		reset <= 0; in <= 0; @(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
						in <= 1; @(posedge clk);
						in <= 0; @(posedge clk);
						in <= 1; @(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
						in <= 0; @(posedge clk);
									@(posedge clk);
		$stop; // End the simulation.
	end
endmodule 
