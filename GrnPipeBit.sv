module GrnPipeBit (RST, NR, lightOn, Over, clk); // Gotta Implement the LFSR to create random pipes
    input logic clk, RST, Over;
	 input logic [15:0] NR;
	 output logic [15:0] lightOn;
	 logic [15:0] ps, ns;
	 
	 initial begin
		ps = 16'b0000000000000000;
	 end
	 
	 always_comb begin
		ns = NR;
	end
	
	 assign lightOn = ps;
	
	always @(posedge clk) begin
		if(Over) 
			ps <= ps;
		else if(RST)
			ps <= 16'b0000000000000000;
		else 
			ps <= ns;
	end
			
endmodule

module GrnPipeBitOn (RST, NR, lightOn, Over, clk);
    input logic clk, RST, Over;
	 input logic [15:0] NR;
	 output logic [15:0] lightOn;
	 logic [2:0] off;
	 logic [12:0] on;
	 logic [15:0] ps, ns;
	 integer i;
	 integer typeP;
	 
	 assign off = 3'b000;
	 assign on = 13'b1111111111111;
	 
	 initial begin
		ps = 16'b1111000111111111;
		typeP = 2;
		i = 0;
	 end
	 
	 assign lightOn = ps;
	
	always @(posedge clk) begin
		if(Over) 
			ps <= ps;
		else if(RST | i == 15) begin
			ps <= ns;
			i <= 0;
			if(typeP == 1) begin
					ns <= {on[12:3], off, on[2:0]};
					typeP <= 2;
			end
			else if(typeP == 2) begin
					ns <= {on[12:9], off, on[8:0]};
					typeP <= 3;
			end
			else if(typeP == 3) begin
					ns <= {on[12:6], off, on[5:0]};
					typeP <= 4;
			end
			else if(typeP == 4) begin
					ns <= {on[12:11], off, on[10:0]};
					typeP <= 1;
			end
		end
		else begin
			ps <= NR;
			i <= i + 1;
		end
	end
			
endmodule

module GrnPipeBit_testbench();
	 logic clk, RST, Over;
	 logic [15:0] NR;
	 logic [15:0] lightOn;
	 integer i;
	 
	GrnPipeBit dut (.RST, .NR, .lightOn, .Over, .clk);
	GrnPipeBitOn dutt (.RST, .NR, .lightOn, .Over, .clk);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	 
		for(i = 0; i <32; i++) begin
									@(posedge clk); RST <=1; Over <= 0;
									@(posedge clk); RST <=0;
									@(posedge clk); 
						  		   @(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
						  		   @(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b1111000111111111;
						  		   @(posedge clk); NR <= 16'b1111000111111111;
									@(posedge clk); NR <= 16'b0000000000000000;
						  		   @(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
						  		   @(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
						  		   @(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
						  		   @(posedge clk); Over <= 1;
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
									@(posedge clk); RST <=1; Over <= 0;
									@(posedge clk); RST <=0;
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
									@(posedge clk); 
						  		   @(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
						  		   @(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b1111000111111111;
						  		   @(posedge clk); NR <= 16'b1111000111111111;
									@(posedge clk); NR <= 16'b0000000000000000;
						  		   @(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
						  		   @(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
						  		   @(posedge clk); NR <= 16'b0000000000000000;
									@(posedge clk); NR <= 16'b0000000000000000;
						  		   @(posedge clk); Over <= 1;
									@(posedge clk);
						  		   @(posedge clk);
					end
		$stop; // End the simulation.
	end
endmodule 