module SignExtend(
    input [7:0] imm,
    output [15:0] ext
);

    assign ext = { {8{imm[7]}} , imm};

endmodule