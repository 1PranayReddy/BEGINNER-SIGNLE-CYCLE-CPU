module InstrMem(
    input [15:0] addr,
    output [15:0] instruction
);

    reg [15:0] mem [0:255];
    //what are these dollar sign things
    initial $readmemh("program.hex" , mem);
    assign instruction = mem[addr];

endmodule;