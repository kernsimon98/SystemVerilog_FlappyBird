module GrnPipe (RST, GrnPixels, pipeState, Over, clk);
    input logic   clk, RST, Over;
    output logic [15:0][15:0] GrnPixels;
	 output logic [15:0] pipeState;// 16x16 array of green LEDs
	 
	 GrnPipeBitOn ro0 (.RST, .NR(GrnPixels[15]), .lightOn(GrnPixels[0]), .Over, .clk);
    GrnPipeBitOn ro1 (.RST, .NR(GrnPixels[0]), .lightOn(GrnPixels[1]), .Over, .clk);
		GrnPipeBit ro2 (.RST, .NR(GrnPixels[1]), .lightOn(GrnPixels[2]), .Over, .clk);
		GrnPipeBit ro3 (.RST, .NR(GrnPixels[2]), .lightOn(GrnPixels[3]), .Over, .clk);
		GrnPipeBit ro4 (.RST, .NR(GrnPixels[3]), .lightOn(GrnPixels[4]), .Over, .clk);
		GrnPipeBit ro5 (.RST, .NR(GrnPixels[4]), .lightOn(GrnPixels[5]), .Over, .clk);
		GrnPipeBit ro6 (.RST, .NR(GrnPixels[5]), .lightOn(GrnPixels[6]), .Over, .clk);
		GrnPipeBit ro7 (.RST, .NR(GrnPixels[6]), .lightOn(GrnPixels[7]), .Over, .clk);
		GrnPipeBit ro8 (.RST, .NR(GrnPixels[7]), .lightOn(GrnPixels[8]), .Over, .clk);
		GrnPipeBit ro9 (.RST, .NR(GrnPixels[8]), .lightOn(GrnPixels[9]), .Over, .clk);
		GrnPipeBit ro10 (.RST, .NR(GrnPixels[9]), .lightOn(GrnPixels[10]), .Over, .clk);
		GrnPipeBit ro11 (.RST, .NR(GrnPixels[10]), .lightOn(GrnPixels[11]), .Over, .clk);
		GrnPipeBit ro12 (.RST, .NR(GrnPixels[11]), .lightOn(GrnPixels[12]), .Over, .clk);
		GrnPipeBit ro13 (.RST, .NR(GrnPixels[12]), .lightOn(GrnPixels[13]), .Over, .clk);
		GrnPipeBit ro14 (.RST, .NR(GrnPixels[13]), .lightOn(GrnPixels[14]), .Over, .clk);
		GrnPipeBit ro15 (.RST, .NR(GrnPixels[14]), .lightOn(GrnPixels[15]), .Over, .clk);
		assign pipeState = GrnPixels[12];
		
endmodule

module GrnPipe_testbench();
	 logic clk, RST, Over;
    logic [15:0][15:0] GrnPixels;
	 logic [15:0] pipeState;
	 integer i;
	
	GrnPipe dut (.RST, .GrnPixels, .pipeState, .Over, .clk);
	
	// Set up the clock.
	parameter CLOCK_PERIOD=100;
	initial begin
		clk <= 0;
		forever #(CLOCK_PERIOD/2) clk <= ~clk;
	end

	// Set up the inputs to the design. Each line is a clock cycle.
	initial begin	
									@(posedge clk); RST <=1; Over <= 0;
									@(posedge clk); RST <=0; 
		for(i = 0; i <32; i++) begin
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
									@(posedge clk); Over <= 1;
						  		   @(posedge clk);
									@(posedge clk);
						  		   @(posedge clk);
									@(posedge clk);
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
					end
		$stop; // End the simulation.
	end
endmodule 
	
	