module CPU(
    input clk, 
    input reset_n,
    output [15:0] pc_out,
    output [15:0] alu_out
);

    reg [15:0] PC;
    wire [15:0] nextPC , PCplus1;



    wire [15:0] instruction;


    wire RegDst , ALUSrc , MemRead , MemWrite , MemtoReg , RegWrite , Branch , BranchNE , Jump;
    wire [2:0] ALUOp;


    wire [1:0] waddr;
    wire[15:0] data1 , data2 , aluB , alu_result , imm_ext , wdata , mem_rdata;
    wire zero;


    InstrMem imem(.addr(PC) , .instruction(instruction));


    wire [3:0] opcode = instruction[15:12];
    wire [1:0] rs     = instruction[11:10];
    wire[1:0]  rt     = instruction[9:8];
    wire[1:0]  rd     = instruction[7:6];
    wire[1:0]  func   = instruction[1:0];
    wire[7:0]  imm    = instruction[7:0];



    Control ctrl(.opcode(opcode), .func(func),
        .RegDst(RegDst), .ALUSrc(ALUSrc), .MemRead(MemRead),
        .MemWrite(MemWrite), .MemtoReg(MemtoReg), .RegWrite(RegWrite),
        .Branch(Branch), .BranchNE(BranchNE), .Jump(Jump), .ALUOp(ALUOp));

    Mux2 #(2) rdmux(.a(rt) , .b(rd) , .sel(RegDst) , .out(waddr));

    RF rf(.clk(clk), .reset_n(reset_n), .write(RegWrite),
        .addr1(rs), .addr2(rt), .addr3(waddr),
        .data1(data1), .data2(data2), .data3(wdata));
    
    SignExtend se(.imm(imm) , .ext(imm_ext));

    Mux2 #(16) bmux(.a(data2) , .b(imm_ext) , .sel(ALUSrc) , .out(aluB));

    ALU alu(.A(data1), .B(aluB), .ALUOp(ALUOp), .result(alu_result), .zero(zero));

    //datamemory???>
    DataMem dmem(.clk(clk) , .addr(alu_result) , .wdata(data2) , .MemRead(MemRead) , .MemWrite(MemWrite),
                .rdata(mem_rdata));

    Mux2 #(16) wbmux(.a(alu_result), .b(mem_rdata), .sel(MemtoReg), .out(wdata));


    assign PCplus1 = PC + 16'd1;

    wire branch_taken = (Branch & zero) | (BranchNE & ~zero);
    wire [15:0] branch_target = PCplus1 + imm_ext;
    wire [15:0] jump_target = {PC[15:12] , instruction[11:0]};

    assign nextPC = Jump ? jump_target : 
                    branch_taken ? branch_target :
                    PCplus1;
    
    always @(posedge clk , negedge reset_n) begin
        if(!reset_n) PC <= 16'd0;
         else        PC <= nextPC;
    end

    assign pc_out = PC;
    assign alu_out = alu_result;


endmodule



