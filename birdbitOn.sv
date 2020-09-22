module birdbitOn (in, up, dn, clk, reset, Over, lightOn);
		input logic in, up, dn, clk, reset, Over;
		output logic lightOn;
		logic ps, ns;
		integer i;
		
		initial begin
			ps = 1'b1;
		end
		
		always_comb begin
			ns = (in & dn) | (~in & up);
		end
		
		assign lightOn = ps;
		
		always @(posedge clk) begin
			if(reset) begin
				ps <= 1'b1;
				i <= 0;	
			end
			else if(Over)
				ps <= ps;
			else if(in) begin
				ps <= ns;
				i <= 0; 
			end
			else if(~in) begin
				if(i == 3) begin
					i <= 0;
					ps <= ns;
				end
				else
					i <= i+1;
			end
		end
		
endmodule

module birdbit (in, up, dn, clk, reset, Over, lightOn);
		input logic in, up, dn, clk, reset, Over;
		output logic lightOn;
		logic ps, ns;
		integer i;
		
		always_comb begin
			ns = (in & dn) | (~in & up);
		end
		
		assign lightOn = ps;
		
		always @(posedge clk) begin
			if(reset) begin
				ps <= 1'b0;
				i <= 0;
			end
			else if(Over)
				ps <= ps;
			else if(in) begin
				ps <= ns;
				i <= 0; 
			end
			else if(~in) begin
				if(i == 3) begin
					i <= 0;
					ps <= ns;
				end
				else
					i <= i+1;
			end
		end
		
endmodule

module birdbitTop (in, up, dn, clk, reset, Over, lightOn);
		input logic in, up, dn, clk, reset, Over;
		output logic lightOn;
		logic ps, ns;
		integer i;
		
		always_comb begin
			ns = (in & dn);
		end
		
		assign lightOn = ps;
		
		always @(posedge clk) begin
			if(reset) begin
				ps <= 1'b0;
				i <= 0;
			end
			else if(Over)
				ps <= ps;
			else if(in) begin
				i <= 0;
				if(ps == 1'b1)
					ps <= ps;
				else
					ps <= ns; 
			end
			else if(~in) begin
				if(i == 3) begin
					i <= 0;
					ps <= ns;
				end
				else
					i <= i+1;
			end
		end
		
endmodule

module birdbitBot (in, up, dn, clk, reset, Over, lightOn);
		input logic in, up, dn, clk, reset, Over;
		output logic lightOn;
		logic ps, ns;
		integer i;
		
		always_comb begin
			ns = (~in & up);
		end
		
		assign lightOn = ps;
		
		always @(posedge clk) begin
			if(reset) begin
				ps <= 1'b0;
				i <= 0;
			end
			else if(Over)
				ps <= ps;
			else if(in) begin
				ps <= ns;
				i <= 0; 
			end
			else if(~in) begin
				if(i == 3) begin
					i <= 0;
					if(ps == 1'b1)
						ps <= ps;
					else
						ps <= ns;
				end
				else
					i <= i+1;
			end
		end
		
endmodule


module birdbitOn_testbench();
	logic in, up, dn, clk, reset, Over;
	logic lightOn;
	integer i;
	
	birdbitOn dut (.in, .up, .dn, .clk, .reset, .Over, .lightOn);
	birdbit dutt (.in, .up, .dn, .clk, .reset, .Over, .lightOn);
	birdbitTop duttt (.in, .up, .dn, .clk, .reset, .Over, .lightOn);
	birdbitBot dut5 (.in, .up, .dn, .clk, .reset, .Over, .lightOn);

	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin

		reset <= 1; Over <= 0; in <= 0; up <= 0; dn <= 0; @(posedge clk);
		reset <= 0;   											 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
							in <= 1; up <= 0; dn <= 0; 	 @(posedge clk);
											 in <= 0;			 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
							in <= 1; up <= 1; dn <= 0; 	 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
					Over <= 1; in <= 0; up <= 1; dn <= 0;@(posedge clk);
														dn<=1; 	 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
  reset <= 1; Over <= 0; in <= 0; up <= 0; dn <= 0; @(posedge clk);
		reset <= 0;   											 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
							in <= 1; up <= 0; dn <= 0; 	 @(posedge clk);
											 in <= 0;			 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
							in <= 1; up <= 0; dn <= 1; 	 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
																	 @(posedge clk);
												in <= 0;			 @(posedge clk);


		$stop; // End the simulation.
	end

endmodule 
