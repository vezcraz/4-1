
wire [31:0] pc_next, muxOut;
mux2to1 #(32) mux(pc_next, pc_branch, pc_select, muxOut);
//result saved inside muxOut
wire [31:0] pc_current; //output from the reg pc
reg32bit program_counter(muxOut, pc_current, 1'b1)
assign pc_next = {32'h4 + pc_current};
wire [5:0] address;
assign address = pc_current[7:2];
wire [31:0] data_out;
rom instr_memory(address, data_out);
assign instruction = data_out;
