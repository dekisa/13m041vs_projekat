
# (C) 2001-2019 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 18.1 625 win32 2019.08.01.15:07:34
# ----------------------------------------
# Auto-generated simulation script rivierapro_setup.tcl
# ----------------------------------------
# This script provides commands to simulate the following IP detected in
# your Quartus project:
#     soc_system
# 
# Altera recommends that you source this Quartus-generated IP simulation
# script from your own customized top-level script, and avoid editing this
# generated script.
# 
# To write a top-level script that compiles Altera simulation libraries and
# the Quartus-generated IP in your project, along with your design and
# testbench files, copy the text from the TOP-LEVEL TEMPLATE section below
# into a new file, e.g. named "aldec.do", and modify the text as directed.
# 
# ----------------------------------------
# # TOP-LEVEL TEMPLATE - BEGIN
# #
# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator.
# #
# set QSYS_SIMDIR <script generation output directory>
# #
# # Source the generated IP simulation script.
# source $QSYS_SIMDIR/aldec/rivierapro_setup.tcl
# #
# # Set any compilation options you require (this is unusual).
# set USER_DEFINED_COMPILE_OPTIONS <compilation options>
# set USER_DEFINED_VHDL_COMPILE_OPTIONS <compilation options for VHDL>
# set USER_DEFINED_VERILOG_COMPILE_OPTIONS <compilation options for Verilog>
# #
# # Call command to compile the Quartus EDA simulation library.
# dev_com
# #
# # Call command to compile the Quartus-generated IP simulation files.
# com
# #
# # Add commands to compile all design files and testbench files, including
# # the top level. (These are all the files required for simulation other
# # than the files compiled by the Quartus-generated IP simulation script)
# #
# vlog -sv2k5 <your compilation options> <design and testbench files>
# #
# # Set the top-level simulation or testbench module/entity name, which is
# # used by the elab command to elaborate the top level.
# #
# set TOP_LEVEL_NAME <simulation top>
# #
# # Set any elaboration options you require.
# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
# #
# # Call command to elaborate your design and testbench.
# elab
# #
# # Run the simulation.
# run
# #
# # Report success to the shell.
# exit -code 0
# #
# # TOP-LEVEL TEMPLATE - END
# ----------------------------------------
# 
# IP SIMULATION SCRIPT
# ----------------------------------------
# If soc_system is one of several IP cores in your
# Quartus project, you can generate a simulation script
# suitable for inclusion in your top-level simulation
# script by running the following command line:
# 
# ip-setup-simulation --quartus-project=<quartus project>
# 
# ip-setup-simulation will discover the Altera IP
# within the Quartus project, and generate a unified
# script which supports all the Altera IP within the design.
# ----------------------------------------

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "soc_system"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "C:/intelfpga_lite/18.1/quartus/"
}

if ![info exists USER_DEFINED_COMPILE_OPTIONS] { 
  set USER_DEFINED_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VHDL_COMPILE_OPTIONS] { 
  set USER_DEFINED_VHDL_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VERILOG_COMPILE_OPTIONS] { 
  set USER_DEFINED_VERILOG_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_ELAB_OPTIONS] { 
  set USER_DEFINED_ELAB_OPTIONS ""
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

set Aldec "Riviera"
if { [ string match "*Active-HDL*" [ vsim -version ] ] } {
  set Aldec "Active"
}

if { [ string match "Active" $Aldec ] } {
  scripterconf -tcl
  createdesign "$TOP_LEVEL_NAME"  "."
  opendesign "$TOP_LEVEL_NAME"
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib      ./libraries     
ensure_lib      ./libraries/work
vmap       work ./libraries/work
ensure_lib                       ./libraries/altera_ver           
vmap       altera_ver            ./libraries/altera_ver           
ensure_lib                       ./libraries/lpm_ver              
vmap       lpm_ver               ./libraries/lpm_ver              
ensure_lib                       ./libraries/sgate_ver            
vmap       sgate_ver             ./libraries/sgate_ver            
ensure_lib                       ./libraries/altera_mf_ver        
vmap       altera_mf_ver         ./libraries/altera_mf_ver        
ensure_lib                       ./libraries/altera_lnsim_ver     
vmap       altera_lnsim_ver      ./libraries/altera_lnsim_ver     
ensure_lib                       ./libraries/cyclonev_ver         
vmap       cyclonev_ver          ./libraries/cyclonev_ver         
ensure_lib                       ./libraries/cyclonev_hssi_ver    
vmap       cyclonev_hssi_ver     ./libraries/cyclonev_hssi_ver    
ensure_lib                       ./libraries/cyclonev_pcie_hip_ver
vmap       cyclonev_pcie_hip_ver ./libraries/cyclonev_pcie_hip_ver
ensure_lib                           ./libraries/altera_common_sv_packages
vmap       altera_common_sv_packages ./libraries/altera_common_sv_packages
ensure_lib                           ./libraries/hps                      
vmap       hps                       ./libraries/hps                      
ensure_lib                           ./libraries/address_span_extender_0  
vmap       address_span_extender_0   ./libraries/address_span_extender_0  
ensure_lib                           ./libraries/sync_ctrl                
vmap       sync_ctrl                 ./libraries/sync_ctrl                
ensure_lib                           ./libraries/rd_ctrl                  
vmap       rd_ctrl                   ./libraries/rd_ctrl                  
ensure_lib                           ./libraries/pkt_trans_wr             
vmap       pkt_trans_wr              ./libraries/pkt_trans_wr             
ensure_lib                           ./libraries/wr_ctrl                  
vmap       wr_ctrl                   ./libraries/wr_ctrl                  
ensure_lib                           ./libraries/video_in                 
vmap       video_in                  ./libraries/video_in                 
ensure_lib                           ./libraries/core_0                   
vmap       core_0                    ./libraries/core_0                   
ensure_lib                           ./libraries/scheduler                
vmap       scheduler                 ./libraries/scheduler                
ensure_lib                           ./libraries/video_out                
vmap       video_out                 ./libraries/video_out                
ensure_lib                           ./libraries/cvo_core                 
vmap       cvo_core                  ./libraries/cvo_core                 
ensure_lib                           ./libraries/sop_align                
vmap       sop_align                 ./libraries/sop_align                
ensure_lib                           ./libraries/rst_controller           
vmap       rst_controller            ./libraries/rst_controller           
ensure_lib                           ./libraries/mm_interconnect_0        
vmap       mm_interconnect_0         ./libraries/mm_interconnect_0        
ensure_lib                           ./libraries/pll_0                    
vmap       pll_0                     ./libraries/pll_0                    
ensure_lib                           ./libraries/ddr3_0                   
vmap       ddr3_0                    ./libraries/ddr3_0                   
ensure_lib                           ./libraries/alt_vip_cl_vfb_0         
vmap       alt_vip_cl_vfb_0          ./libraries/alt_vip_cl_vfb_0         
ensure_lib                           ./libraries/alt_vip_cl_tpg_0         
vmap       alt_vip_cl_tpg_0          ./libraries/alt_vip_cl_tpg_0         
ensure_lib                           ./libraries/alt_vip_cl_cvo_0         
vmap       alt_vip_cl_cvo_0          ./libraries/alt_vip_cl_cvo_0         

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  eval vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                    -work altera_ver           
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                             -work lpm_ver              
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                -work sgate_ver            
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                            -work altera_mf_ver        
  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                        -work altera_lnsim_ver     
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                       -work cyclonev_ver         
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                  -work cyclonev_hssi_ver    
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"              -work cyclonev_pcie_hip_ver
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/common/alt_vip_common_pkg.sv"                                                                                                        -work altera_common_sv_packages
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_ddr3_0_hps.v"                                                                                                                   -work hps                      
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_address_span_extender.sv"                                                                              -l altera_common_sv_packages -work address_span_extender_0  
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_decode/src_hdl/alt_vip_common_event_packet_decode.sv"               -l altera_common_sv_packages -work sync_ctrl                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_encode/src_hdl/alt_vip_common_event_packet_encode.sv"               -l altera_common_sv_packages -work sync_ctrl                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_vfb_sync_ctrl.sv"                                                                       -l altera_common_sv_packages -work sync_ctrl                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_decode/src_hdl/alt_vip_common_event_packet_decode.sv"               -l altera_common_sv_packages -work rd_ctrl                  
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_encode/src_hdl/alt_vip_common_event_packet_encode.sv"               -l altera_common_sv_packages -work rd_ctrl                  
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_vfb_rd_ctrl.sv"                                                                         -l altera_common_sv_packages -work rd_ctrl                  
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_decode/src_hdl/alt_vip_common_event_packet_decode.sv"               -l altera_common_sv_packages -work pkt_trans_wr             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_encode/src_hdl/alt_vip_common_event_packet_encode.sv"               -l altera_common_sv_packages -work pkt_trans_wr             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_dc_mixed_widths_fifo/src_hdl/alt_vip_common_dc_mixed_widths_fifo.sv"             -l altera_common_sv_packages -work pkt_trans_wr             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_fifo2/src_hdl/alt_vip_common_fifo2.sv"                                           -l altera_common_sv_packages -work pkt_trans_wr             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_delay/src_hdl/alt_vip_common_delay.sv"                                           -l altera_common_sv_packages -work pkt_trans_wr             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_clock_crossing_bridge_grey/src_hdl/alt_vip_common_clock_crossing_bridge_grey.sv" -l altera_common_sv_packages -work pkt_trans_wr             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_packet_transfer_pack_proc.sv"                                                           -l altera_common_sv_packages -work pkt_trans_wr             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_packet_transfer_twofold_ram.sv"                                                         -l altera_common_sv_packages -work pkt_trans_wr             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_packet_transfer_twofold_ram_reversed.sv"                                                -l altera_common_sv_packages -work pkt_trans_wr             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_packet_transfer_read_proc.sv"                                                           -l altera_common_sv_packages -work pkt_trans_wr             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_packet_transfer_write_proc.sv"                                                          -l altera_common_sv_packages -work pkt_trans_wr             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_packet_transfer.sv"                                                                     -l altera_common_sv_packages -work pkt_trans_wr             
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_decode/src_hdl/alt_vip_common_event_packet_decode.sv"               -l altera_common_sv_packages -work wr_ctrl                  
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_encode/src_hdl/alt_vip_common_event_packet_encode.sv"               -l altera_common_sv_packages -work wr_ctrl                  
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_vfb_wr_ctrl.sv"                                                                         -l altera_common_sv_packages -work wr_ctrl                  
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_alt_vip_cl_vfb_0_video_in.v"                                                                                                    -work video_in                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_decode/src_hdl/alt_vip_common_event_packet_decode.sv"               -l altera_common_sv_packages -work core_0                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_encode/src_hdl/alt_vip_common_event_packet_encode.sv"               -l altera_common_sv_packages -work core_0                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_tpg_bars_alg_core.sv"                                                                   -l altera_common_sv_packages -work core_0                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_tpg_bars_alg_core_par_lut.sv"                                                           -l altera_common_sv_packages -work core_0                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_tpg_bars_alg_core_seq_lut.sv"                                                           -l altera_common_sv_packages -work core_0                   
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_decode/src_hdl/alt_vip_common_event_packet_decode.sv"               -l altera_common_sv_packages -work scheduler                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_encode/src_hdl/alt_vip_common_event_packet_encode.sv"               -l altera_common_sv_packages -work scheduler                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_slave_interface/src_hdl/alt_vip_common_slave_interface.sv"                       -l altera_common_sv_packages -work scheduler                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_slave_interface/src_hdl/alt_vip_common_slave_interface_mux.sv"                   -l altera_common_sv_packages -work scheduler                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_tpg_multi_scheduler.sv"                                                                 -l altera_common_sv_packages -work scheduler                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/soc_system_alt_vip_cl_tpg_0_scheduler.sv"                                                                     -l altera_common_sv_packages -work scheduler                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_video_packet_encode/src_hdl/alt_vip_common_latency_0_to_latency_1.sv"            -l altera_common_sv_packages -work video_out                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_video_packet_encode/src_hdl/alt_vip_common_video_packet_empty.sv"                -l altera_common_sv_packages -work video_out                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_video_packet_encode/src_hdl/alt_vip_common_video_packet_encode.sv"               -l altera_common_sv_packages -work video_out                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_decode/src_hdl/alt_vip_common_event_packet_decode.sv"               -l altera_common_sv_packages -work video_out                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_encode/src_hdl/alt_vip_common_event_packet_encode.sv"               -l altera_common_sv_packages -work video_out                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_message_pipeline_stage/src_hdl/alt_vip_common_message_pipeline_stage.sv"         -l altera_common_sv_packages -work video_out                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_sop_align/src_hdl/alt_vip_common_sop_align.sv"                                   -l altera_common_sv_packages -work video_out                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_video_output_bridge.sv"                                                                 -l altera_common_sv_packages -work video_out                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_encode/src_hdl/alt_vip_common_event_packet_encode.sv"               -l altera_common_sv_packages -work cvo_core                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_decode/src_hdl/alt_vip_common_event_packet_decode.sv"               -l altera_common_sv_packages -work cvo_core                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_cvo_stream_marker.sv"                                                                   -l altera_common_sv_packages -work cvo_core                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_cvo_core.sv"                                                                            -l altera_common_sv_packages -work cvo_core                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_cvo_sync_compare.v"                                                                     -l altera_common_sv_packages -work cvo_core                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_cvo_sync_conditioner.sv"                                                                -l altera_common_sv_packages -work cvo_core                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_cvo_sync_generation.sv"                                                                 -l altera_common_sv_packages -work cvo_core                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_cvo_calculate_mode.v"                                                                   -l altera_common_sv_packages -work cvo_core                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_cvo_mode_banks.sv"                                                                      -l altera_common_sv_packages -work cvo_core                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_cvo_statemachine.sv"                                                                    -l altera_common_sv_packages -work cvo_core                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_fifo/src_hdl/alt_vip_common_fifo.v"                                                                           -work cvo_core                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_generic_step_count/src_hdl/alt_vip_common_generic_step_count.v"                                               -work cvo_core                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_to_binary/src_hdl/alt_vip_common_to_binary.v"                                                                 -work cvo_core                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_sync/src_hdl/alt_vip_common_sync.v"                                                                           -work cvo_core                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_trigger_sync/src_hdl/alt_vip_common_trigger_sync.v"                                                           -work cvo_core                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_sync_generation/src_hdl/alt_vip_common_sync_generation.v"                                                     -work cvo_core                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_frame_counter/src_hdl/alt_vip_common_frame_counter.v"                                                         -work cvo_core                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_sample_counter/src_hdl/alt_vip_common_sample_counter.v"                                                       -work cvo_core                 
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_decode/src_hdl/alt_vip_common_event_packet_decode.sv"               -l altera_common_sv_packages -work sop_align                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_encode/src_hdl/alt_vip_common_event_packet_encode.sv"               -l altera_common_sv_packages -work sop_align                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_sop_align/src_hdl/alt_vip_common_sop_align.sv"                                   -l altera_common_sv_packages -work sop_align                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_pip_sop_realign.sv"                                                                     -l altera_common_sv_packages -work sop_align                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_decode/src_hdl/alt_vip_common_event_packet_decode.sv"               -l altera_common_sv_packages -work scheduler                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/modules/alt_vip_common_event_packet_encode/src_hdl/alt_vip_common_event_packet_encode.sv"               -l altera_common_sv_packages -work scheduler                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/aldec/src_hdl/alt_vip_cvo_scheduler.sv"                                                                       -l altera_common_sv_packages -work scheduler                
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_alt_vip_cl_cvo_0_video_in.v"                                                                                                    -work video_in                 
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_reset_controller.v"                                                                                                                 -work rst_controller           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/altera_reset_synchronizer.v"                                                                                                               -work rst_controller           
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_mm_interconnect_0.v"                                                                                                            -work mm_interconnect_0        
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_pll_0.vo"                                                                                                                       -work pll_0                    
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_ddr3_0.v"                                                                                                                       -work ddr3_0                   
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_alt_vip_cl_vfb_0.v"                                                                                                             -work alt_vip_cl_vfb_0         
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_alt_vip_cl_tpg_0.v"                                                                                                             -work alt_vip_cl_tpg_0         
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/soc_system_alt_vip_cl_cvo_0.v"                                                                                                             -work alt_vip_cl_cvo_0         
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/soc_system.v"                                                                                                                                                                        
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim +access +r -t ps $ELAB_OPTIONS -L work -L altera_common_sv_packages -L hps -L address_span_extender_0 -L sync_ctrl -L rd_ctrl -L pkt_trans_wr -L wr_ctrl -L video_in -L core_0 -L scheduler -L video_out -L cvo_core -L sop_align -L rst_controller -L mm_interconnect_0 -L pll_0 -L ddr3_0 -L alt_vip_cl_vfb_0 -L alt_vip_cl_tpg_0 -L alt_vip_cl_cvo_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with -dbg -O2 option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -dbg -O2 +access +r -t ps $ELAB_OPTIONS -L work -L altera_common_sv_packages -L hps -L address_span_extender_0 -L sync_ctrl -L rd_ctrl -L pkt_trans_wr -L wr_ctrl -L video_in -L core_0 -L scheduler -L video_out -L cvo_core -L sop_align -L rst_controller -L mm_interconnect_0 -L pll_0 -L ddr3_0 -L alt_vip_cl_vfb_0 -L alt_vip_cl_tpg_0 -L alt_vip_cl_cvo_0 -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -dbg -O2
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                                         -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                                           -- Compile device library files"
  echo
  echo "com                                               -- Compile the design files in correct order"
  echo
  echo "elab                                              -- Elaborate top level design"
  echo
  echo "elab_debug                                        -- Elaborate the top level design with -dbg -O2 option"
  echo
  echo "ld                                                -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                                          -- Compile all the design files and elaborate the top level design with -dbg -O2"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                                    -- Top level module name."
  echo "                                                     For most designs, this should be overridden"
  echo "                                                     to enable the elab/elab_debug aliases."
  echo
  echo "SYSTEM_INSTANCE_NAME                              -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                                       -- Platform Designer base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR                               -- Quartus installation directory."
  echo
  echo "USER_DEFINED_COMPILE_OPTIONS                      -- User-defined compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_ELAB_OPTIONS                         -- User-defined elaboration options, added to elab/elab_debug aliases."
  echo
  echo "USER_DEFINED_VHDL_COMPILE_OPTIONS                 -- User-defined vhdl compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_VERILOG_COMPILE_OPTIONS              -- User-defined verilog compile options, added to com/dev_com aliases."
}
file_copy
h
