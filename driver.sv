class r_driver extends uvm_driver#(r_item);
  `uvm_component_utils(r_driver)
  
  r_item tx;
  
  virtual interface rintf vif;
    
    uvm_analysis_port#(r_item) driv2scb;
  
  
  function new(string name = "r_driver",uvm_component parent);
    super.new(name,parent);
    driv2scb = new("driv2scb",this);
  endfunction
    
    
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      
      if(!(uvm_config_db#(virtual rintf)::get(this,"*","rintf",vif)))
        begin
        `uvm_fatal("driver congif","cannot get")
        end
      
        endfunction
    
    task run_phase(uvm_phase phase);
      r_item tx;
      forever
        begin
      seq_item_port.get_next_item(tx);
      @(posedge vif.clk)
       
          vif.rst <= tx.rst;
          vif.addr <= tx.addr;
          vif.wren <= tx.wren;
          vif.wdata <= tx.wdata;
  
     #5
      driv2scb.write(tx);
          `uvm_info(get_type_name(),tx.convert2string(),UVM_MEDIUM)
          
          seq_item_port.item_done(tx);
         end
    endtask
        
        
    endclass
