###############################################################################
# _pin_assign.tcl
#
# BOARD    : DE0NANO Board
# Author   : Dragomir El Mezeni, ETF 
# Revision : 0.1                  
# Date     : 17 may 2015
#
#
###############################################################################

#set top_name your_top_name

##############################################################################

########## Set the pin location variables

#project set_active_cmp $top_name
	set_global_assignment -name FAMILY "Cyclone IVE"
	set_global_assignment -name DEVICE EP4CE22F17C6
	set_global_assignment -name DEVICE_FILTER_PACKAGE FBGA
	set_global_assignment -name DEVICE_FILTER_PIN_COUNT 256
	set_global_assignment -name ENABLE_INIT_DONE_OUTPUT OFF
	set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED WITH WEAK PULL-UP"
	set_global_assignment -name RESERVE_ASDO_AFTER_CONFIGURATION "AS INPUT TRI-STATED"
	set_global_assignment -name RESERVE_ALL_UNUSED_PINS_NO_OUTPUT_GND "AS INPUT TRI-STATED"
	set_global_assignment -name DEVICE_MIGRATION_LIST EP4CE22F17C6
	set_global_assignment -name ENABLE_DEVICE_WIDE_RESET OFF
# Reset Key[0]
##############################################################################

	set_location_assignment PIN_J15  -to reset_n        	

# CLOCKs In
##############################################################################
	set_location_assignment PIN_R8   -to clk_50MHz

# CLOCKs Out
##############################################################################

	set_location_assignment PIN_R4  -to SDRAM_clk

# SDRAM
##############################################################################

	set_location_assignment PIN_G2   -to SDRAM_DQ[0]
	set_location_assignment PIN_G1   -to SDRAM_DQ[1]
	set_location_assignment PIN_L8   -to SDRAM_DQ[2]
	set_location_assignment PIN_K5   -to SDRAM_DQ[3]
	set_location_assignment PIN_K2   -to SDRAM_DQ[4]
	set_location_assignment PIN_J2   -to SDRAM_DQ[5]
	set_location_assignment PIN_J1   -to SDRAM_DQ[6]
	set_location_assignment PIN_R7   -to SDRAM_DQ[7]
	set_location_assignment PIN_T4   -to SDRAM_DQ[8]
	set_location_assignment PIN_T2   -to SDRAM_DQ[9]
	set_location_assignment PIN_T3   -to SDRAM_DQ[10]
	set_location_assignment PIN_R3   -to SDRAM_DQ[11]
	set_location_assignment PIN_R5   -to SDRAM_DQ[12]
	set_location_assignment PIN_P3   -to SDRAM_DQ[13]
	set_location_assignment PIN_N3   -to SDRAM_DQ[14]
	set_location_assignment PIN_K1   -to SDRAM_DQ[15]
	
	set_location_assignment PIN_R6   -to SDRAM_DQM[0]
	set_location_assignment PIN_T5   -to SDRAM_DQM[1]
	
	set_location_assignment PIN_M7   -to SDRAM_BA[0]
	set_location_assignment PIN_M6   -to SDRAM_BA[1]
	
	set_location_assignment PIN_P2   -to SDRAM_ADDR[0]
	set_location_assignment PIN_N5   -to SDRAM_ADDR[1]
	set_location_assignment PIN_N6   -to SDRAM_ADDR[2]
	set_location_assignment PIN_M8   -to SDRAM_ADDR[3]
	set_location_assignment PIN_P8   -to SDRAM_ADDR[4]
	set_location_assignment PIN_T7   -to SDRAM_ADDR[5]
	set_location_assignment PIN_N8   -to SDRAM_ADDR[6]
	set_location_assignment PIN_T6   -to SDRAM_ADDR[7]
	set_location_assignment PIN_R1   -to SDRAM_ADDR[8]
	set_location_assignment PIN_P1   -to SDRAM_ADDR[9]
	set_location_assignment PIN_N2   -to SDRAM_ADDR[10]
	set_location_assignment PIN_N1   -to SDRAM_ADDR[11]
	set_location_assignment PIN_L4   -to SDRAM_ADDR[12]
	
	set_location_assignment PIN_L7   -to SDRAM_CKE
	set_location_assignment PIN_P6   -to SDRAM_CS_n
	set_location_assignment PIN_L2   -to SDRAM_RAS_n
	set_location_assignment PIN_L1   -to SDRAM_CAS_n
	set_location_assignment PIN_C2   -to SDRAM_WE_n
	

