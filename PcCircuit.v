module PcCircuit(inst, clk, branch, zeroFlag, jump, newInst);
	//inputs declaration
	input branch, jump;	//control signals
	input clk;
	input zeroFlag;		//AlU zero flag
	input[18:0] inst;

	//output
	output[18:0] newInst;

	//wires
	wire [18:0] w, w1, w3, branchVal, w2, w4,inPc,start;
	
	//Instantiate needed modules
	PC pc(.clk(clk), .inPc(w4), .outPc(start));
	instructionMemory Mem(.readAddress(start),.instruction(newInst));
	
		
	//combinational logic
	assign w = start + 1;
	assign branchVal ={{10{inst[8]}},inst[8:0]};
	assign w1 = w + branchVal;
	assign w2 = (branch && zeroFlag)?  w1 : w;
	assign w3 = {4'b0000,inst[14:0]};
	assign w4 = jump? w3:w2;

endmodule
