class r_environment extends uvm_env;
  `uvm_component_utils(r_environment)
  
  r_agent agent;
  r_scoreboard scb;
  
  function new(string name = "r_environment",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    agent = r_agent::type_id::create("agent",this);
    scb = r_scoreboard::type_id::create("scb",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    agent.driv.driv2scb.connect(scb.drv_scb);
    agent.mon.mon2scb.connect(scb.mon_scb);
    
  endfunction
  
  
endclass
  
