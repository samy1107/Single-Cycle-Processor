module singleCycleProcessor(clk);
	input clk;
	//wire declaration
	wire regDst, regWrite, extd, aluSrc, memRead, memWrite, memToReg, branch, jump, mvs, lea;
	wire zeroFlag, writeEnable;
	wire [18:0] wIn1,wIn2, writeData, outReg1, outReg2, result;
	wire [2:0] writeReg;
        wire [18:0] newInst, start, product,out,dataOut,memoutx;
	wire [3:0] opCode;
	
	assign opCode = newInst[18:15] ;
	
	//instantainiation

	//Control Unit 
	controlUnit CU(opCode,regDst, regWrite, extd, aluSrc, memRead, memWrite, memToReg, branch, jump, mvs, lea);
		
	//ALU

	//calc win1,win2
	assign wIn1 = mvs? 19'd0 : outReg1;
	assign wIn2 = aluSrc? (lea? product : out): outReg2;

	ALU ALU(wIn1,wIn2,opCode,result,zeroFlag);

	//PcCircuit contains PC and instruction memoryt and their connections
	PcCircuit pcCircuit(.inst(newInst), .clk(clk), .branch(branch), .zeroFlag(zeroFlag), .jump(jump), .newInst(newInst));

	//Register File
	assign writeReg = regDst? newInst[8:6] : newInst[11:9];
	assign writeEnable = (mvs)? zeroFlag : regWrite;
	//assign memoutx = memToReg? dataOut : result;
	assign writeData = (mvs&&zeroFlag)? outReg1 : memoutx;
	
	regFile regFile(newInst[14:12], newInst[11:9], writeReg, writeData, outReg1, outReg2, writeEnable, clk);
	
	//signExtender
	signExtend signExtender(newInst[8:0],out);

	//multiplier
	multiply multiplier(newInst[8:0], outReg2[8:0],product);

	//Data Memory
	assign memoutx =  memToReg? dataOut:result;
	dataMemory dataMemory(outReg2, result, memRead, memWrite, clk,dataOut);


endmodule 
