`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )
class r_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(r_scoreboard)
  
  uvm_analysis_imp_drv#(r_item,r_scoreboard) drv_scb;
  uvm_analysis_imp_mon#(r_item,r_scoreboard) mon_scb;
  
  uvm_tlm_fifo#(r_item) expfifo;
  uvm_tlm_fifo#(r_item) outfifo;
  
  reg[7:0] refe [(2**16 - 1):0];   //reference model
  reg [15:0]t_data;    //temporary reg 
  
  
  function new(string name = "r_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    
    drv_scb = new("drv_scb",this);
    mon_scb = new("mon_scb",this);
    expfifo = new("expfifo",this);
    outfifo = new("outfifo",this);
  endfunction
  
  function void write_drv(r_item tr);
    `uvm_info("write_driv STIM", tr.convert2string(), UVM_MEDIUM)
    if(tr.rst == 1)
      begin
        $display("RESET");
        for(int unsigned i=0;i<2**16;i=i+1)
          begin
          	refe[i]=0;
            tr.addr=0;
            tr.wdata=0;
            tr.rdata=0;
            tr.wren=0;
          end
      end
    
     if(tr.wren == 1)
      begin
      refe[tr.addr] = tr.wdata;
      end
    
    if(tr.wren == 0)
      begin
        t_data = refe[tr.addr];
      end
    
    else
      begin
      t_data = t_data;
      end
    
    tr.rdata = t_data;
    void'(expfifo.try_put(tr));
  endfunction
  
  
  function void write_mon(r_item txn);
    `uvm_info("write_mon OUT ", txn.convert2string(), UVM_MEDIUM)
    void'(outfifo.try_put(txn));
  endfunction
  
  
  task run_phase(uvm_phase phase);
    r_item exp_tr,out_tr;
    forever 
      begin
		`uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
		expfifo.get(exp_tr);
		`uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
		outfifo.get(out_tr);
      
    
    
    if(out_tr.rst == 1)
      begin
        $display("RESET");
 
      end
    
    if(out_tr.rdata == exp_tr.rdata)
      begin
        
        `uvm_info("PASS",out_tr.convert2string(),UVM_LOW)
        
        
      end
    
    else
      begin
        `uvm_info("fail",out_tr.convert2string(),UVM_LOW)
        
        
        
      end
      end
    
  endtask
  
endclass
