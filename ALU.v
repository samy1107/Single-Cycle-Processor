module ALU (
    input  [18:0] A,           // Operand A
    input  [18:0] B,           // Operand B
    input  [3:0] ALUControl,   // ALU control signal
    output reg [18:0] Result,  // ALU result
    output Zero                // Zero flag
);

    assign Zero = (Result == 0);

    always @(*) begin
        case (ALUControl)
            4'b0010: Result = A & B;        // AND
	    4'b0101: Result = A & B;	    // ANDi 
            4'b0011: Result = A | B;        // OR
            4'b0000: Result = A + B;        // ADD
	    4'b0100: Result = A + B;        // ADDi
	    4'b0111: Result = A + B;	    // LOAD
	    4'b1000: Result = A + B;	    // STORE
	    4'b1011: Result = A + B;	    // LEA
	    4'b1100: Result = A + B;	    // MVS			
            4'b0001: Result = A - B;        // SUB
            4'b0110: Result = (A < B) ? 19'b1111111111111111111 : 19'b0; // SLT
            default: Result = 19'b0;
        endcase
    end

endmodule

