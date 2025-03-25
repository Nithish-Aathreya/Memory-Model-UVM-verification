class r_agent extends uvm_agent;
   `uvm_component_utils(r_agent)
  
  r_sequencer seqr;
  r_driver driv;
  r_monitor mon;
  
  
   function new(string name = "r_agent",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    seqr = r_sequencer::type_id::create("seqr",this);
    driv = r_driver::type_id::create("driv",this);
    mon = r_monitor::type_id::create("mon",this);
  endfunction
  
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    driv.seq_item_port.connect(seqr.seq_item_export);
  endfunction
  
endclass
