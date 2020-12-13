Input Ports
1. clk
2. reset
3. branch
4. alu_zero
5. mem_write
6. mem_read
Output Ports
1. alu_res [31:0]
2. rt_data [31:0]
3. pc_source
4. read_data [31:0]
Modules Required
1. An AND gate.
2. A block of Random Access Memory (memory.v → ram), 32 bits wide with 4 address lines.

assign pc_source = branch&alu_zero;

ram RAM(mem_write,alu_res[5:2],rt_data,mem_read,read_data);