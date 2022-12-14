`ifndef I3C_ENV_INCLUDED_
`define I3C_ENV_INCLUDED_

//--------------------------------------------------------------------------------------------
// Class: i3c_env
// Environment contains slave_agent_top,master_agent_top and virtual_sequencer
//--------------------------------------------------------------------------------------------
class i3c_env extends uvm_env;
  `uvm_component_utils(i3c_env)
  
  // Variable: i3c_master_agent_h
  // declaring i3c_master agent handle
  i3c_master_agent i3c_master_agent_h[];
  
  // Variable: i3c_slave_agent_h
  // Declaring i3c_slave handles
  i3c_slave_agent i3c_slave_agent_h[];

  // Variable: i3c_virtual_seqr_h
  // declaring handle for virtual sequencer
  i3c_virtual_sequencer i3c_virtual_seqr_h; 
  
  // Variable: i3c_env_cfg_h
  // Declaring environment configuration handle
  i3c_env_config i3c_env_cfg_h;
  
  // Variable: i3c_scoreboard_h
  // declaring scoreboard handle
  i3c_scoreboard i3c_scoreboard_h;
  
  //-------------------------------------------------------
  // Externally defined Tasks and Functions
  //-------------------------------------------------------
  extern function new(string name = "i3c_env", uvm_component parent = null);
  extern virtual function void build_phase(uvm_phase phase);
  extern virtual function void connect_phase(uvm_phase phase);

endclass : i3c_env

//--------------------------------------------------------------------------------------------
// Construct: new
//
// Parameters:
//  name - i3c_env
//  parent - parent under which this component is created
//--------------------------------------------------------------------------------------------
function i3c_env::new(string name = "i3c_env",
                                 uvm_component parent = null);
  super.new(name, parent);
endfunction : new

//--------------------------------------------------------------------------------------------
// Function: build_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void i3c_env::build_phase(uvm_phase phase);
  super.build_phase(phase);

  if(!uvm_config_db #(i3c_env_config)::get(this,"","i3c_env_config",i3c_env_cfg_h)) begin
    `uvm_fatal("CONFIG","cannot get() the i3c_env_cfg_h from the uvm_config_db . Have you set it?")
  end
  
  i3c_master_agent_h=new[i3c_env_cfg_h.no_of_masters];
     
  foreach(i3c_master_agent_h[i])begin
    i3c_master_agent_h[i]=i3c_master_agent::type_id::create($sformatf("i3c_master_agent_h[%0d]",i),this);
  end
     
  i3c_slave_agent_h=new[i3c_env_cfg_h.no_of_slaves];    
      
  foreach(i3c_slave_agent_h[i])begin    
   i3c_slave_agent_h[i]=i3c_slave_agent::type_id::create($sformatf("i3c_slave_agent_h[%0d]",i),this);
  end
   
  if(i3c_env_cfg_h.has_virtual_sequencer)begin
   i3c_virtual_seqr_h=i3c_virtual_sequencer::type_id::create("virtual_seqr_h",this);
  end 
  
  if(i3c_env_cfg_h.has_scoreboard)begin
   i3c_scoreboard_h=i3c_scoreboard::type_id::create("i3c_scoreboard_h",this);
  end 

endfunction : build_phase

//--------------------------------------------------------------------------------------------
// Function: connect_phase
// <Description_here>
//
// Parameters:
//  phase - uvm phase
//--------------------------------------------------------------------------------------------
function void i3c_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  if(i3c_env_cfg_h.has_virtual_sequencer)
  begin
    foreach(i3c_master_agent_h[i])begin
      i3c_virtual_seqr_h.i3c_master_seqr_h=i3c_master_agent_h[i].i3c_master_seqr_h;
      i3c_master_agent_h[i].i3c_master_mon_proxy_h.master_analysis_port.connect(i3c_scoreboard_h.master_analysis_fifo.analysis_export); 
    end
    foreach(i3c_slave_agent_h[i])begin
      i3c_virtual_seqr_h.i3c_slave_seqr_h=i3c_slave_agent_h[i].i3c_slave_seqr_h;
      i3c_slave_agent_h[i].i3c_slave_mon_proxy_h.slave_analysis_port.connect(i3c_scoreboard_h.slave_analysis_fifo.analysis_export);
    end
  end
endfunction : connect_phase


`endif

