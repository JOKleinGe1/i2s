module i2s(	input	  clock, output i2sdata_out, output ws, output fbit); 
	reg	[14:0]  address = 15'd0;
	wire	[15:0]  q;
	reg [15:0] shiftregister = 16'd0;
	rom1port romsound(.address(address),.clock(clock), .q(q));
	reg [6:0] prescaler71 = 7'd0;
	reg [3:0] prescaler16 = 4'd0;
	reg Tbit = 1'b0;
	reg Tword = 1'b0;
	always @ (posedge (clock))	prescaler71 <= (prescaler71 + 7'd1) % 71;
	always @ (posedge (clock))  Tbit <= ( prescaler71 == 7'd0);
	always @ (posedge (clock))prescaler16 <= (prescaler16 + Tbit);
	always @ (posedge (clock))  Tword <= ( prescaler16 == 4'd0) & Tbit;
	always @ ( posedge (clock)) 
		if (Tword) shiftregister <= q; 
		else if (Tbit) shiftregister <= {shiftregister[14:0],1'b0};
	always @ ( posedge (clock)) address <= address + Tword;
	assign i2sdata_out = shiftregister[15];
	assign ws = prescaler16[3]; 
	assign fbit = (prescaler71 > 35) ;
endmodule

