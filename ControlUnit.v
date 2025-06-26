module controlUnit(opCode,regDst, regWrite, extd, aluSrc, memRead, memWrite, memToReg, branch, jump, mvs, lea);
	//inputs	
	input [3:0] opCode;

	//outputs declaration
	output reg regDst, regWrite, extd, aluSrc, memRead, memWrite, memToReg, branch, jump, mvs, lea;	
	
	//Comninational Logic
	always@(*)begin
	
	 // initialize all bits to 0
        {regDst, regWrite, extd, aluSrc,
         memRead, memWrite, memToReg,
         branch, jump, mvs, lea} = 11'b0;
	
	//case statement to translate op code to control signals controling our programm flow
	//control signals table will be provided in presentation	
	case (opCode)
            4'b0000: begin // add
                regDst = 1; regWrite = 1;
            end
            4'b0001: begin // sub
                regDst = 1; regWrite = 1;
            end
            4'b0010: begin // and
                regDst = 1; regWrite = 1;
            end
            4'b0011: begin // or
                regDst = 1; regWrite = 1;
            end
            4'b0100: begin // addi
                regWrite = 1; extd = 1; aluSrc = 1;
            end
            4'b0101: begin // andi
                regWrite = 1; aluSrc = 1;
            end
            4'b0110: begin // slt
                regDst = 1; regWrite = 1;
            end
            4'b0111: begin // lw
                regWrite = 1; extd = 1; aluSrc = 1;
                memRead = 1; memToReg = 1;
            end
            4'b1000: begin // sw
                extd = 1; aluSrc = 1;
                memWrite = 1;
            end
            4'b1001: begin // j
                jump = 1;
            end
            4'b1010: begin // beq
                extd = 1;
                branch = 1;
            end
            4'b1011: begin // lea
                regDst = 0; regWrite = 1;
                aluSrc = 1; lea = 1;
            end
            4'b1100: begin // mvs
                regDst = 1; regWrite = 1;
                mvs = 1;
            end
        endcase
	end

endmodule
