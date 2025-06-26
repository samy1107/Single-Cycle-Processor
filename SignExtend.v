module signExtend(input [8:0] in, output [18:0] out);
    //replicates the sign bit 9 times then concatinates it to lefty of input
    assign out = {{10{in[8]}}, in};

endmodule
