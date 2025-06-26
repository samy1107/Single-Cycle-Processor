module finalTb;
	//Inputs
	reg clk;
	
	//clk generation
	initial begin
		clk = 0;
		forever #20 clk = ~clk;
	end
	
	//instaniate circuit
	singleCycleProcessor uut(clk);
	integer i;
	////initialization
	initial begin 
		uut.pcCircuit.pc.pcMem = 19'b0;
		uut.pcCircuit.pc.outPc = 19'b0;
		
		//memories
		//registers
		for ( i = 0; i < 8; i = i + 1)begin
			uut.regFile.registers[i] = 19'b0;	
		end
		//Instruction memory
		for(i = 0; i < 524289; i = i + 1)begin
			uut.pcCircuit.Mem.memory[i] = 19'b0;
		end
		//Data Memory	
		for(i = 0; i < 524289; i = i + 1)begin
			uut.dataMemory.memory[i] = 19'b0;
		end	
	end
	
	//Test sequence
	initial begin
		uut.pcCircuit.pc.pcMem = 19'b0;
		uut.pcCircuit.pc.outPc = 19'b0;
		
		uut.regFile.registers[1] = 19'b101;
		uut.regFile.registers[2] = 19'b001;
		//Instructions Injection 
		uut.pcCircuit.Mem.memory[0] = 19'b1000_010_001_000_000_000;	//sw
		uut.pcCircuit.Mem.memory[1] = 19'b0111_010_101_000000000;	//lw
		uut.pcCircuit.Mem.memory[2] = 19'b0000_001_010_011_000000;	//add
		uut.pcCircuit.Mem.memory[3] = 19'b0001_001_010_100_000000;	//sub
		uut.pcCircuit.Mem.memory[4] = 19'b0010_001_010_101_000000;	//and
		uut.pcCircuit.Mem.memory[5] = 19'b0011_001_010_011_000000;	//or
		uut.pcCircuit.Mem.memory[6] = 19'b1010_101_010_000001000;	//beq
		uut.pcCircuit.Mem.memory[15] = 19'b1001_000000000000111;	//jump
		uut.pcCircuit.Mem.memory[7] = 19'b0100_010_111_000001001;	//addi
		uut.pcCircuit.Mem.memory[8] = 19'b0101_001_100_000000111;	//andi
		uut.pcCircuit.Mem.memory[9] = 19'b0110_010_001_110_000000;	//slt
		
		uut.pcCircuit.Mem.memory[10] = 19'b1100_010_000_110_000000;	//mvs
		uut.pcCircuit.Mem.memory[11] = 19'b1011_001_011_000000010;	//lea
		
			
		#10
		$display("instruction %d : %b", uut.pcCircuit.start,uut.pcCircuit.inst);
		$display("dataMemory[reg2(1)] <- (reg1(5))");
		
		#20
		$display("dataMemory[1] = %d", uut.dataMemory.memory[1]);
		$display("____________________________________");
		$display("instruction %d : %b", uut.pcCircuit.start,uut.pcCircuit.inst);
		$display("reg5 <- mem[reg2(1)]");
		#40
		$display("Register 5 = %d", uut.regFile.registers[5]);
		$display("____________________________________");
		$display("instruction %d : %b", uut.pcCircuit.start,uut.pcCircuit.inst);
		$display("reg3 <- reg1 + reg2");
		#40
		$display("Register 3 = %d", uut.regFile.registers[3]);
		$display("____________________________________");
		$display("instruction %d : %b", uut.pcCircuit.start,uut.pcCircuit.inst);
		$display("reg4 <- reg2 - reg1");
		
		#40
		$display("Register 4 = %d", uut.regFile.registers[4]);
		$display("____________________________________");

		$display("instruction %d : %b", uut.pcCircuit.start,uut.pcCircuit.inst);
		$display("reg5 <- reg1 AND reg2");
		
		#40
		$display("Register 5 = %b", uut.regFile.registers[5]);
		$display("____________________________________");
		

		$display("instruction %d : %b", uut.pcCircuit.start,uut.pcCircuit.inst);
		$display("reg3 <- reg1 OR reg2");
		
		#40
		$display("Register 3 = %b", uut.regFile.registers[3]);
		$display("____________________________________");

		$display("instruction %d : %b", uut.pcCircuit.start,uut.pcCircuit.inst);
		$display("PC <- PC + 9");
		
		$display("____________________________________");

		#40
		$display("instruction %d : %b", uut.pcCircuit.start,uut.pcCircuit.inst);
		$display("PC <- 7");
		$display("____________________________________");
		#40
		$display("instruction %d : %b", uut.pcCircuit.start,uut.pcCircuit.inst);
		$display("reg7 <- reg2 + 9");
		#40
		$display("Register 7 = %d", uut.regFile.registers[7]);
		$display("____________________________________");

		$display("instruction %d : %b", uut.pcCircuit.start,uut.pcCircuit.inst);
		$display("reg4 <- reg1 AND 7");
		#40
		$display("Register 4 = %b", uut.regFile.registers[4]);
		$display("____________________________________");

		$display("instruction %d : %b", uut.pcCircuit.start,uut.pcCircuit.inst);
		$display("reg6 <- (reg1 > reg2) ? 1 : 0");
		#40
		$display("Register 6 = %b",uut.regFile.registers[6]);
		$display("____________________________________");
		$display("instruction %d : %b", uut.pcCircuit.start,uut.pcCircuit.inst);
		$display("reg6 <- (reg0 == 0) ? reg2 : 0");
		#40			
		$display("Register 6 = %d",uut.regFile.registers[6]);
		$display("____________________________________");
		
		$display("instruction %d : %b", uut.pcCircuit.start,uut.pcCircuit.inst);
		//$display("product = %d, in1 = %d, in2 = %d", uut.product, uut.newInst[8:0],uut.outReg2[8:0]);
		$display("reg3 <- (reg3*2) + reg2");
		#40
		$display("Register 3 = %d",uut.regFile.registers[3]);
		$display("____________________________________");
		#40

		$display("END OF TESTING");
$finish;
	end

endmodule
