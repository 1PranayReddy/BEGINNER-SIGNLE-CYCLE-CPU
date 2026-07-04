module CPU_tb;
    reg clk, reset_n;
    wire [15:0] pc_out, alu_out;
    integer i;

    CPU uut(.clk(clk), .reset_n(reset_n), .pc_out(pc_out), .alu_out(alu_out));

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset_n = 0;
        #15 reset_n = 1;

        #150;

       
        
        $finish;
    end
    // always @(posedge clk)
    // $display("t=%0t PC=%0d instr=%h | R1=%0d R2=%0d R3=%0d | waddr=%0d wdata=%0d RegWrite=%b",
    //     $time, pc_out, uut.instruction,
    //     uut.rf.register[1], uut.rf.register[2], uut.rf.register[3],
    //     uut.waddr, uut.wdata, uut.RegWrite);


    always @(uut.rf.register[1] , uut.rf.register[2])
        $display("PC: %d , Register 1 value : %d ; Register 2 value : ", uut.PC ,uut.rf.register[1] , uut.rf.register[2]);
endmodule