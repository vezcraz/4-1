module alu(input [31:0] aluIn1, input [31:0] aluIn2, input [1:0] aluOp, output reg [31:0] aluOut0, output reg [31:0] aluOut1, output reg zero);
    
	// Write your code here
    // out0 corresponds to the lower 32 bits of the result
    // out1 corresponds to the higher 32 bits of the result
    always @(aluOp or aluIn1 or aluIn2)
    begin
    case(aluOp)
        2'b00: begin aluOut0 = aluIn1 + aluIn2; 
                     aluOut1 = 32'b0;
                end
        2'b10: begin
                {aluOut1, aluOut0} = aluIn1*aluIn2;
                end
        2'b01: begin aluOut0 = aluIn1 - aluIn2; 
                     aluOut1 = 32'b0;
                end
    endcase
    end

    always @(aluIn1 or aluIn2)
    begin
    if({aluOut1, aluOut0} == 64'b0)
        zero = 1'b1;
    else
        zero = 1'b0;
    end
	
endmodule