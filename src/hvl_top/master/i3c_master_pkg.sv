`ifndef I3C_MASTER_PKG_INCLUDED_
`define I3C_MASTER_PKG_INCLUDED_

//--------------------------------------------------------------------------------------------
// Package: master_pkg
//  Includes all the files related to SPI master
//--------------------------------------------------------------------------------------------
package i3c_master_pkg;

  //-------------------------------------------------------
  // Import uvm package
  //-------------------------------------------------------
  `include "uvm_macros.svh"
  import uvm_pkg::*;
 
  // Import spi_globals_pkg 
  import i3c_globals_pkg::*;

  //-------------------------------------------------------
  // Include all other files
  //-------------------------------------------------------
  `include "i3c_master_agent_config.sv"
  `include "i3c_master_tx.sv"
  `include "i3c_master_seq_item_converter.sv"
  `include "i3c_master_cfg_converter.sv"
  `include "i3c_master_sequencer.sv"
  `include "i3c_master_driver_proxy.sv"
  `include "i3c_master_monitor_proxy.sv"
  `include "i3c_master_coverage.sv"
  `include "i3c_master_agent.sv"
  
endpackage : i3c_master_pkg

`endif
