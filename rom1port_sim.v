// File : rom1port_sim.v
// Only for simulation. not for synthesis

`define MEMORYSIZE (32*1024)

module rom1port (
	input	[14:0] 	address,
	input	  clock,
	output 	reg [15:0] 	q
	);
 
	reg [15:0] 	memory [0:`MEMORYSIZE-1];

	initial begin
		$readmemh("sound.mem16",memory);
	end

	always @(posedge clock) begin
 		 q <= memory[address];
	end
endmodule
