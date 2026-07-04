module ALU(
    input signed [15:0] A,
    input signed [15:0] B,
    input [2:0]  ALUOp,
    output reg signed [15:0] result,
    output zero
);
    always @(*) begin
        case(ALUOp)
            0 : result = A + B;
            1 : result = A - B;
            2 : result = A | B;
            3 : result = A & B;


            default : result = 16'b0;
        endcase
    end

    assign zero = (result == 16'b0);

endmodule