module instructionMemory(readAddress, instruction);
	//input(PC)
	input[18:0] readAddress;

	//output (Next instruction)
	output[18:0] instruction;
	
	//memory array (array of instructions)
	reg [18:0] memory [0:524287]; //capacity for 2^19 instructions
		
	assign instruction = memory[readAddress];
	
endmodule
