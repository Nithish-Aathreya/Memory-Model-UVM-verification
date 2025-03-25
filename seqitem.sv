class r_item extends uvm_sequence_item;
  `uvm_object_utils(r_item)
  
  bit rst;
  rand bit [15:0] addr;
  rand bit wren;
  rand bit [7:0] wdata;
  bit [7:0]rdata;
  
  
  function new(string name = "r_item");
    super.new(name);
  endfunction
  
  
   function string convert2string();
     return $sformatf("sequence_item  ",$sformatf("wdata=%0f addr=%0f wren=%0b rst=%0b rdata=%0f",wdata,addr,wren,rst,rdata));
  endfunction
  
  
  
  
  
endclass
