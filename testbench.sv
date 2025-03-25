`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "seqitem.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"

module tb;
  
  bit clk;
  rintf intf(clk);
  
  ram DUT(.clk(intf.clk),.rst(intf.clk),.addr(intf.addr),.wren(intf.wren),.wdata(intf.wdata),.rdata(intf.rdata));
  
  initial
    begin
      
      clk = 1'b0;
    end
  
  always #5 clk = ~ clk;
  
  
  
  initial
    begin
  uvm_config_db#(virtual rintf)::set(null,"*","rintf",intf);
    end
  
   initial begin
    $dumpfile("dumpfile.vcd");
    $dumpvars;
  end
  
  
  initial
    begin
      run_test("r_test");
    end
  
endmodule
