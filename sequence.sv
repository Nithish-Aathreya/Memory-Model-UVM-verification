class r_sequence extends uvm_sequence#(r_item);
  `uvm_object_utils(r_sequence)
  
  r_item tx;
  
 function new(string name = "r_sequence");
    super.new(name);
  endfunction
  
  
  virtual task body();
    
    
  endtask 
endclass
  

class reset_seq extends r_sequence;   //reset
  `uvm_object_utils(reset_seq)
    r_item tx;
  
  function new(string name = "reset_seq");
    super.new(name);
  endfunction
  
  
  task body();
    tx = r_item::type_id::create("tx");
    start_item(tx);
   tx.rst=1;
    tx.wdata=0;
    tx.wren=0;
    tx.addr=0;
    
    finish_item(tx);
  endtask

endclass

class write_only extends r_sequence;   //write only
    `uvm_object_utils(write_only)
    r_item tx;
  
  function new(string name = "write_only");
    super.new(name);
  endfunction
  
  
  task body();
    repeat(10)
      begin
    tx = r_item::type_id::create("tx");
    start_item(tx);
        if (!tx.randomize() with { tx.wren == 1; }) begin
    `uvm_info("WRITE_ONLY_SEQ", "Randomization failed, dumping constraints...", UVM_MEDIUM)
    tx.print();
end
    tx.rst = 0;  
    finish_item(tx);
      end
  endtask

endclass


class read_only extends r_sequence;   //read only
  `uvm_object_utils(read_only)
    r_item tx;
  
  function new(string name = "read_only");
    super.new(name);
  endfunction
  
  
  task body();
    repeat(10)
      begin
    tx = r_item::type_id::create("tx");
    start_item(tx);
        if (!tx.randomize() with { tx.wren == 0; }) begin
          `uvm_info("read_ONLY_SEQ", "Randomization failed, dumping constraints...", UVM_MEDIUM)
    tx.print();
end
    tx.rst = 0;  
    finish_item(tx);
      end
  endtask

endclass

class write_read extends r_sequence;   //write and read 
    `uvm_object_utils(write_read)
    r_item tx;
  
  function new(string name = "write_read");
    super.new(name);
  endfunction
  
  
  task body();
    repeat(10)
      begin
    tx = r_item::type_id::create("tx");
    start_item(tx);
        if (!tx.randomize() with { tx.wren == 1; }) begin
    `uvm_info("WRITE_SEQ", "Randomization failed, dumping constraints...", UVM_MEDIUM)
    tx.print();
end
    tx.rst = 0;  
    finish_item(tx);
      end
    
    repeat(10)
      begin
    tx = r_item::type_id::create("tx");
    start_item(tx);
        if (!tx.randomize() with { tx.wren == 0; }) begin
          `uvm_info("Read_SEQ", "Randomization failed, dumping constraints...", UVM_MEDIUM)
    tx.print();
end
    tx.rst = 0;  
    finish_item(tx);
      end
    
    
    
    
  endtask

endclass
