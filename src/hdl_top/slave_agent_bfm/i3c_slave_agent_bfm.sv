`ifndef I3C_SLAVE_AGENT_BFM_INCLUDED_
`define I3C_SLAVE_AGENT_BFM_INCLUDED_

module i3c_slave_agent_bfm #(parameter int SLAVE_ID=0) 
                              (i3c_if intf);

 //-------------------------------------------------------
 // Package : Importing Uvm Pakckage and Test Package
 //-------------------------------------------------------
 import uvm_pkg::*;
 `include "uvm_macros.svh"
  //-------------------------------------------------------
  // Package : Importing SPI Global Package 
  //-------------------------------------------------------
  import i3c_globals_pkg::*;
 //-------------------------------------------------------
  //-------------------------------------------------------
  //I3C Slave driver bfm instantiation
  //-------------------------------------------------------
  i3c_slave_driver_bfm i3c_slave_drv_bfm_h(.pclk(intf.pclk), 
                                           .areset(intf.areset),
                                           .scl_i(intf.scl_i),
                                           .scl_o(intf.scl_o),
                                           .scl_oen(intf.scl_oen),
                                           .sda_i(intf.sda_i),
                                           .sda_o(intf.sda_o),
                                           .sda_oen(intf.sda_oen)
					   //.scl(intf.scl),
                                           //.sda(intf.sda)
                                          );
  // MSHA: assign i3c_slave_drv_bfm_h.slave_id = SLAVE_ID;

  //-------------------------------------------------------
  //I3C slave driver bfm instantiation
  //-------------------------------------------------------
  i3c_slave_monitor_bfm i3c_slave_mon_bfm_h(.pclk(intf.pclk), 
                                            .areset(intf.areset),
                                            .scl_i(intf.scl_i),
                                            .scl_o(intf.scl_o),
                                            .scl_oen(intf.scl_oen),
                                            .sda_i(intf.sda_i),
                                            .sda_o(intf.sda_o),
                                            .sda_oen(intf.sda_oen)
                                          );
  // MSHA: assign i3c_slave_mon_bfm_h.slave_id = SLAVE_ID;
 //-------------------------------------------------------
 // Setting the virtual handle of BMFs into config_db
 //-------------------------------------------------------
 
 initial begin
  // MSHA: static string path_drv, path_mon;
  
  // MSHA: path_drv = {"*i3c_slave_driver_bfm*",$sformatf("%0d",SLAVE_ID),"*"};
  // MSHA: $display("DEBUG_MSHA :: path_drv = %0s", path_drv);

  // MSHA: path_mon = {"*i3c_slave_monitor_bfm*",$sformatf("%0d",SLAVE_ID),"*"};
  // MSHA: $display("DEBUG_MSHA :: path_mon = %0s", path_mon);

  // MSHA: uvm_config_db#(virtual i3c_slave_driver_bfm)::set(null,path_drv,"i3c_slave_driver_bfm",
  // MSHA:                                                             i3c_slave_drv_bfm_h);

  // MSHA: uvm_config_db#(virtual i3c_slave_monitor_bfm)::set(null,path_mon,"i3c_slave_monitor_bfm",
  // MSHA:                                                             i3c_slave_mon_bfm_h);

  static string drv_str, mon_str;
  drv_str = {"i3c_slave_driver_bfm_",$sformatf("%0d",SLAVE_ID)};
  $display("DEBUG_MSHA :: drv_str = %0s", drv_str);

  mon_str = {"i3c_slave_monitor_bfm_",$sformatf("%0d",SLAVE_ID)};
  $display("DEBUG_MSHA :: mon_str = %0s", mon_str);

  uvm_config_db#(virtual i3c_slave_driver_bfm)::set(null,"*",drv_str,
                                                              i3c_slave_drv_bfm_h);

  uvm_config_db#(virtual i3c_slave_monitor_bfm)::set(null,"*",mon_str,
                                                              i3c_slave_mon_bfm_h);
  end

  initial begin
    $display("Slave Agent BFM");
  end


endmodule : i3c_slave_agent_bfm

`endif
