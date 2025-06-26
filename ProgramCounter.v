module PC(
	input clk,
        input  [18:0] inPc,     // The value to update the PC with
        output reg [18:0] outPc     // Current PC value
);
	
	reg[18:0] pcMem;

    always @(posedge clk) begin
	pcMem <= inPc;         // Update PC with nextPC
	outPc <= inPc;
    end

endmodule
