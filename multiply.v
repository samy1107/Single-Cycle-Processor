module multiply(A, B, AB);
	//declaring inputs and outputs
	input[8:0] A,B;
	output[18:0] AB;

	//simple logic
	assign AB = A * B;	
endmodule
