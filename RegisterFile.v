module regFile (readReg1, readReg2 ,writeReg,writeData,outReg1,outReg2,regWrite,clk);

	//declaring inputs
	input clk, regWrite;
	input[2:0] readReg1, readReg2, writeReg;

	//declaring outputs
	input[18:0] writeData;
	output[18:0] outReg1, outReg2;

	//creating 8 registers each of 19 bits
	reg [18:0] registers [7:0];


	//Sequential Logic (Sunchrones writing)
	always @(posedge clk) begin
		if (regWrite && (writeReg != 0)) begin
            registers[writeReg] <= writeData;
        end
	end

	//Combinational Logic(Asynchrones reading)
	assign outReg1 = (readReg1 == 0) ? 0 : registers[readReg1];
	assign outReg2 = (readReg2 == 0) ? 0 : registers[readReg2];

endmodule
	
	

