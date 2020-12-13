Input Ports
1. mem_to_reg
2. alu_res [31:0]
3. read_data [31:0]
Output Ports1. write_data [31:0]
Modules Required
1. One 32 bit 2:1 mux (mux.v → mux2to1).

mux2to1 #(32) mux(alu_res,read_data,mem_to_reg,write_data);