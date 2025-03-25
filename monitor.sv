class r_monitor extends uvm_monitor;
  `uvm_component_utils(r_monitor)
  
  r_item tx;
  
  virtual interface rintf vif;
    
    uvm_analysis_port#(r_item) mon2scb;
  
  function new(string name = "r_monitor",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      if(!(uvm_config_db#(virtual rintf)::get(this,"*","rintf",vif)))
        begin
          `uvm_fatal("monitor congif","cannot get")
        end
    mon2scb = new("mon2scb",this);
    tx=r_item::type_id::create("tx",this);
        endfunction
  
  
    task run_phase (uvm_phase phase);
      forever
        begin
        
          @(negedge vif.clk)
          tx.rst = vif.rst;
          tx.addr = vif.addr;
          tx.wren = vif.wren;
          tx.wdata = vif.wdata;
          tx.rdata = vif.rdata;
          
         
          mon2scb.write(tx);
        end
    endtask
 
endclass
