module dataMemory(dataIn, address, memRead, memWrite, clk, dataOut);

	//inputs declaration
	input[18:0] dataIn;	//Register in memory is 19 bits wide
	input[18:0] address;	
	input memRead, memWrite, clk;

	//output declaration
	output reg[18:0] dataOut;

	//Memory array
	reg [18:0] memory [524288:0];
	
	//combinational Read
	always @(*) begin
    		if (memRead)
        		dataOut = memory[address];
    		else
        		dataOut = 19'd0; // or 19'bz, based on your design
		end
	//Seqquential Write Logic
	always@(posedge clk) begin
		if(memWrite && memRead)begin
			$display("Data Memory Does not support reading and writing simultaneosly");	
		end 
		else if(memWrite) begin
			memory[address] <= dataIn;
		end
	end			
endmodule
