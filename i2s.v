module i2s(	input	  clock, output i2sdata_out, output ws, output fbit); 
	reg	[14:0]  address = 15'd0;
	wire	[31:0]  q;
	reg [31:0] shiftregister = 32'd0;
	rom1port romsound(.address(address),.clock(clock), .q(q));
	reg [5:0] prescaler35 = 6'd0;
	reg [4:0] prescaler32 = 5'd0;
	reg Tbit = 1'b0;
	reg Tword = 1'b0;
	always @ (posedge (clock))	prescaler35 <= (prescaler35 + 6'd1) % 35;
	always @ (posedge (clock))  Tbit <= ( prescaler35 == 6'd0);
	always @ (posedge (clock))prescaler32 <= (prescaler32 + Tbit);
	always @ (posedge (clock))  Tword <= ( prescaler32 == 5'd0) & Tbit;
	always @ ( posedge (clock)) 
		if (Tword) shiftregister <= q; 
		else if (Tbit) shiftregister <= {shiftregister[30:0],1'b0};
	always @ ( posedge (clock)) address <= address + Tword;
	assign i2sdata_out = shiftregister[31];
	assign ws = prescaler32[4]; 
	assign fbit = (prescaler35 > 17) ;
endmodule

