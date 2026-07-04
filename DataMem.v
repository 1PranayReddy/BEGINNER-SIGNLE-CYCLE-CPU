module DataMem(
    input MemRead,MemWrite,clk,
    input [15:0] wdata,
    input [15:0]addr,
    output [15:0] rdata
);

    reg [15:0] mem[255:0];
    assign rdata = MemRead ? mem[addr] : 16'd0;

    always @(posedge clk)begin 
        if(MemWrite)
            mem[addr] <= wdata;
    end


endmodule