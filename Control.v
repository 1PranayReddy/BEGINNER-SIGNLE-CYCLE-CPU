module Control(
    input [3:0] opcode,
    input [1:0] func,
    output RegDst,
    output ALUSrc,
    output MemRead,
    output MemWrite,
    output MemtoReg,
    output RegWrite,
    output Branch,
    output BranchNE,
    output Jump,
    output reg [2:0] ALUOp
);

localparam R=4'd15, ADI=4'd4, LWD=4'd7, SWD=4'd8, BEQ=4'd1, BNE=4'd0, JMP=4'd9;

assign RegDst = (opcode == R);
assign ALUSrc = (opcode == ADI ||opcode == LWD ||opcode == SWD);
assign MemRead = (opcode == LWD);
assign MemWrite = (opcode == SWD);
assign MemtoReg = (opcode == LWD);
assign RegWrite = (opcode == R || opcode == ADI ||opcode == LWD );
assign Branch = (opcode == BEQ );
assign BranchNE = (opcode == BNE);
assign Jump = (opcode == JMP);

always @(*) begin

    case(opcode)
        R : ALUOp = {1'b0 , func};
        ADI : ALUOp = 3'd0;
        LWD : ALUOp = 3'd0;
        SWD : ALUOp = 3'd0;
        BEQ : ALUOp = 3'd1;
        BNE : ALUOp = 3'd1;

        default: ALUOp = 3'd0;
    endcase

end


endmodule