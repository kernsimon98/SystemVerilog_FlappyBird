module LFSR(out, reset, Over, clk);
	input logic reset, clk, Over;
	output integer out;
	logic [2:0] outm;
	logic [2:0] ns;
	integer i;
	integer j;
	integer e;
	
	initial begin
		out = 0;
		outm = 3'b000;
		i = 0;
	end
	
	always_comb begin
		e = 1;
		for(j = 0; j <3; j++) begin
			out = (e*outm[j])+out;
			e = e * 2;
		end
	end
	
	always_ff @(posedge clk) begin
		if(reset) begin
			outm <= 3'b000;
			i <= 0;
		end
		else if(i == 15) begin
			if((outm[2] & outm[1]) | (~outm[2])&(~outm[1])) begin
				outm[0] <= 1;
				outm[1] <= outm[0];
				outm[2] <= outm[1];
			end
			else begin
				outm[0] <= 0;
				outm[1] <= outm[0];
				outm[2] <= outm[1];
			end
			i <= 0;
		end
		else
			if(~Over)
				i <= i+1;
	end
endmodule

module LFSR_testbench();
	logic clk, reset, Over;
	logic [2:0] out;

	LFSR dut (out,reset, Over, clk);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin
									@(posedge clk);
		reset <= 1;   			@(posedge clk);
		reset <= 0;   			@(negedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);
									@(posedge clk);		
		$stop; // End the simulation.
	end
endmodule
	