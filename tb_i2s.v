`timescale 1 ns / 100 ps
module tb_i2s;
	reg clock = 1;
	wire i2sdata_out,ws,fbit;
	always #10 clock = ~clock; // 50MHz system clock
 
 	i2s i2s_0 (clock, i2sdata_out, ws, fbit); 
	initial begin
		$dumpfile("tb_i2s.vcd");
		$dumpvars(0, tb_i2s );
		repeat (10000) @(posedge clock);	
	$finish;
	end
endmodule
