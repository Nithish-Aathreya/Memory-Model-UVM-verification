module ram(clk,rst,wren,addr,wdata,rdata);
  
  input clk,rst;
  input [15:0] addr;
  input wren;
  input [7:0] wdata;
  output reg [7:0]rdata;
  
  reg [7:0] mem[(2**16 - 1):0];
  
  always@(posedge clk)
    begin
      if(rst == 1)
        begin
          for(int unsigned i =0;i<2**16;i=i+1)
            mem[i] = 8'b0;
        end
    end
  
  always@(wren,addr,wdata)
    begin
      if(wren == 1)   //write operation 
        mem[addr] = wdata;
      
      else if(wren == 0)  // read operation
        rdata = mem[addr];
      
      else
        rdata = rdata;
    end
endmodule
