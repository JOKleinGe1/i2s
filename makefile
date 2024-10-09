all : tb_i2s.vcd 

tb_i2s.vvp  :  tb_i2s.v  i2s.v rom1port_sim.v
	iverilog  -o $@  $^
tb_i2s.vcd :tb_i2s.vvp
	vvp   $^ 

clean :
	rm -f *.vcd *.vvp
