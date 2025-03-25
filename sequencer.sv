class r_sequencer extends uvm_sequencer#(r_item);
  `uvm_component_utils(r_sequencer)
  
  
  function new(string name = "r_sequencer",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  
endclass
