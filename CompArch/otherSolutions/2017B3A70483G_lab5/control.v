
module control_circuit (input clk, input reset, input [5:0] opcode, input [5:0] funct, 
                        output reg IorD, output reg memRead, output reg IRWrite, output reg regDest, output reg regWrite,
                        output reg aluSrcA, output reg [1:0] aluSrcB, output reg [1:0] aluOp, output reg hiWrite,
                        output reg loWrite, output reg [1:0] memToReg, output reg [1:0] pcSrc, output reg pcWrite,
                        output reg branch );

    reg [3:0] old_state;
    reg [3:0] new_state;    
    always@(negedge clk)
    begin
        case(reset)
            1'b1: old_state = 4'b0000;
            1'b0: old_state = new_state;
        endcase
    end
    always@(opcode or old_state)
    begin
        case(old_state)
        4'b0000:
            begin
                IorD = 1'b0;
                IRWrite = 1'b0;
                memRead = 1'b0;
                regWrite = 1'b0;
                aluSrcB = 2'b00;
                regDest = 1'b0;
                aluOp = 2'b00;
                loWrite = 1'b0;
                hiWrite = 1'b0;
                pcWrite = 1'b0;
                new_state = 4'b0001; 
                aluSrcA = 1'b0;
                branch = 1'b0;
                pcSrc = 2'b00;
                memToReg=2'b00;
            end
        4'b0001:
            begin
                IRWrite = 1'b1;
                aluOp = 2'b00;
                memRead = 1'b1;
                IorD = 1'b0;
                regWrite = 1'b0;
                memToReg=2'b00;
                aluSrcA = 1'b0;
                regDest = 1'b0;
                loWrite = 1'b0;
                pcWrite = 1'b1;
                hiWrite = 1'b0;
                branch = 1'b0;
                aluSrcB = 2'b01;
                pcSrc = 2'b10;
                new_state = 4'b0010; 
            end
        4'b0010:  
            begin
                IRWrite = 1'b0;
                IorD = 1'b0;
                memRead = 1'b0;
                regWrite = 1'b0;
                regDest = 1'b0;
                aluOp = 2'b00;
                pcSrc = 2'b00;
                hiWrite = 1'b0;
                branch = 1'b0;
                loWrite = 1'b0;
                pcWrite = 1'b0;
                aluSrcA = 1'b0;
                memToReg=2'b00;
                aluSrcB = 2'b11;
                case(opcode)
                    6'b011000: new_state = 4'b0100; 
                    6'b010000: new_state = 4'b0101; 
                    6'b000100: new_state = 4'b1000; 
                    6'b001000: new_state = 4'b0011; 
                    6'b100011: new_state = 4'b0110;
                    6'b000010: new_state = 4'b0111;
                endcase
            end
        4'b0011: 
            begin
                IorD = 1'b0;
                aluSrcA = 1'b1;
                IRWrite = 1'b0;
                aluOp = 2'b00;
                regWrite = 1'b0;
                hiWrite = 1'b0;
                regDest = 1'b0;
                aluSrcB = 2'b10;
                loWrite = 1'b0;
                memToReg=2'b00;
                new_state = 4'b1001;
                pcWrite = 1'b0;
                pcSrc = 2'b00;
                branch = 1'b0;
                memRead = 1'b0;
            end
        4'b0100:
            begin
                regWrite = 1'b0;
                IorD = 1'b0;
                IRWrite = 1'b0;
                regDest = 1'b0;
                loWrite = 1'b0;
                aluSrcA = 1'b1;
                aluSrcB = 2'b00;
                memRead = 1'b0;
                aluOp = 2'b10;
                memToReg=2'b00;
                pcSrc = 2'b00;
                pcWrite = 1'b0;
                branch = 1'b0;
                hiWrite = 1'b0;
                new_state = 4'b1010;
            end
        4'b0101: 
            begin
                memRead = 1'b0;
                regDest = 1'b1;
                aluOp = 2'b00;
                IorD = 1'b0;
                regWrite = 1'b1;
                aluSrcA = 1'b0;
                IRWrite = 1'b0;
                aluSrcB = 2'b00;
                hiWrite = 1'b0;
                new_state = 4'b0001;
                loWrite = 1'b0;
                pcSrc = 2'b00;
                pcWrite = 1'b0;
                branch = 1'b0;
                memToReg=2'b01;
            end
        4'b0110: 
            begin
                IorD = 1'b0;
                memRead = 1'b0;
                hiWrite = 1'b0;
                aluOp = 2'b00;
                IRWrite = 1'b0;
                regDest = 1'b0;
                aluSrcA = 1'b1;
                aluSrcB = 2'b10;
                loWrite = 1'b0;
                branch = 1'b0;
                memToReg=2'b00;
                regWrite = 1'b0;
                pcSrc = 2'b00;
                pcWrite = 1'b0;
                new_state = 4'b1011;
            end
        4'b0111: 
            begin
                IorD = 1'b0;
                memRead = 1'b0;
                IRWrite = 1'b0;
                regWrite = 1'b0;
                aluSrcA = 1'b0;
                hiWrite = 1'b0;
                aluSrcB = 2'b00;
                regDest = 1'b0;
                pcWrite = 1'b1;
                aluOp = 2'b00;
                memToReg=2'b00;
                pcSrc = 2'b01;
                branch = 1'b0;
                loWrite = 1'b0;
                new_state = 4'b0001;
            end
        4'b1000: 
            begin
                IorD = 1'b0;
                aluSrcB = 2'b00;
                memRead = 1'b0;
                IRWrite = 1'b0;
                regWrite = 1'b0;
                aluOp = 2'b01;
                aluSrcA = 1'b1;
                regDest = 1'b0;
                hiWrite = 1'b0;
                memToReg=2'b00;
                pcSrc = 2'b00;
                branch = 1'b1;
                pcWrite = 1'b0;
                loWrite = 1'b0;
                new_state = 4'b0001;
            end
        4'b1001: 
            begin
                IorD = 1'b0;
                memRead = 1'b0;
                aluSrcB = 2'b00;
                IRWrite = 1'b0;
                aluSrcA = 1'b0;
                aluOp = 2'b00;
                regDest = 1'b0;
                regWrite = 1'b1;
                hiWrite = 1'b0;
                loWrite = 1'b0;
                pcSrc = 2'b00;
                pcWrite = 1'b0;
                branch = 1'b0;
                memToReg=2'b10;
                new_state = 4'b0001;
            end
        4'b1010: 
            begin
                IorD = 1'b0;
                memRead = 1'b0;
                IRWrite = 1'b0;
                hiWrite = 1'b1;
                regDest = 1'b0;
                aluSrcA = 1'b0;
                aluOp = 2'b00;
                aluSrcB = 2'b00;
                loWrite = 1'b1;
                memToReg=2'b00;
                pcSrc = 2'b00;
                pcWrite = 1'b0;
                regWrite = 1'b0;
                branch = 1'b0;
                new_state = 4'b0001;
            end
        4'b1011: 
            begin
                IorD = 1'b1;
                memRead = 1'b1;
                IRWrite = 1'b0;
                aluOp = 2'b00;
                regDest = 1'b0;
                aluSrcA = 1'b0;
                aluSrcB = 2'b00;
                regWrite = 1'b0;
                hiWrite = 1'b0;
                memToReg=2'b00;
                pcSrc = 2'b00;
                pcWrite = 1'b0;
                loWrite = 1'b0;
                branch = 1'b0;
                new_state = 4'b1100;
            end
        4'b1100: 
            begin
                IorD = 1'b0;
                memRead = 1'b0;
                IRWrite = 1'b0;
                regWrite = 1'b1;
                aluSrcB = 2'b00;
                aluOp = 2'b00;
                hiWrite = 1'b0;
                pcSrc = 2'b00;
                regDest = 1'b0;
                aluSrcA = 1'b0;
                loWrite = 1'b0;
                pcWrite = 1'b0;
                memToReg=2'b00;
                branch = 1'b0;
                new_state = 4'b0001;
            end
        endcase
    end
endmodule
