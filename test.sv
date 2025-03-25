class r_test extends uvm_test;
  `uvm_component_utils(r_test)
  
  r_environment env;
  
  r_sequence r_seq;
  reset_seq rst_s;
  write_only wr_s;
  read_only rd_s;
  write_read wrd_s;
  
  
  function new(string name = "r_test",uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
   
  function void build_phase(uvm_phase phase);
      super.build_phase(phase);
    env = r_environment::type_id::create("env",this);
    
    r_seq = r_sequence::type_id::create("r_seq");
    
rst_s = reset_seq::type_id::create("rst_s");
     wr_s = write_only::type_id::create("wr_s");
     rd_s = read_only::type_id::create("rd_s");
    wrd_s = write_read::type_id::create("wrd_s");
  endfunction
  
  
  function void end_of_elobartion_phase(uvm_phase phase);
      $display("End of eleboration phase in agent");
      
      print();
    endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
  
          r_seq.start(env.agent.seqr);
    
    rst_s.start(env.agent.seqr);
    wr_s.start(env.agent.seqr);
        rd_s.start(env.agent.seqr);
        wrd_s.start(env.agent.seqr);
                                  
  phase.drop_objection(this);
 endtask
  
endclass
  
  
  
                                        
          
     

     
