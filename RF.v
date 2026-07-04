module RF(
    input [1:0] addr1 , addr2 , addr3,
    output wire [15:0] data1 , data2,
    input [15:0] data3,
    input write , reset_n , clk
);
    reg [15:0] register[3:0];
    
    always @(posedge clk , negedge reset_n)begin 
        if(!reset_n)
            for (integer i = 0 ; i < 4 ; i = i + 1)
                register[i] <= 0;
        else if(write && addr3 != 0)
            register[addr3] <= data3;
        
    end

    assign data1 = (addr1==0) ? 16'd0 : register[addr1];
    assign data2 = (addr2==0) ? 16'd0 : register[addr2];    



endmodule