# TCL File Generated by Component Editor 11.0sp1
# Wed Jan 13 20:51:26 CET 2016
# DO NOT MODIFY


# +-----------------------------------
# | 
# | muladd "muladd" v1.0
# | null 2016.01.13.20:51:26
# | 
# | 
# | C:/Users/Qizhen/Dropbox/study/programmable electronic systems/labs/lab 5/muladd.vhd
# | 
# |    ./muladd.vhd syn, sim
# | 
# +-----------------------------------

# +-----------------------------------
# | request TCL package from ACDS 11.0
# | 
package require -exact sopc 11.0
# | 
# +-----------------------------------

# +-----------------------------------
# | module muladd
# | 
set_module_property NAME muladd
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property DISPLAY_NAME muladd
set_module_property TOP_LEVEL_HDL_FILE muladd.vhd
set_module_property TOP_LEVEL_HDL_MODULE muladd
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL TRUE
set_module_property STATIC_TOP_LEVEL_MODULE_NAME muladd
set_module_property FIX_110_VIP_PATH false
# | 
# +-----------------------------------

# +-----------------------------------
# | files
# | 
add_file muladd.vhd {SYNTHESIS SIMULATION}
# | 
# +-----------------------------------

# +-----------------------------------
# | parameters
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | display items
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point nios_custom_instruction_slave_0
# | 
add_interface nios_custom_instruction_slave_0 nios_custom_instruction end
set_interface_property nios_custom_instruction_slave_0 clockCycle 0
set_interface_property nios_custom_instruction_slave_0 operands 2

set_interface_property nios_custom_instruction_slave_0 ENABLED true

add_interface_port nios_custom_instruction_slave_0 dataa dataa Input 32
add_interface_port nios_custom_instruction_slave_0 datab datab Input 32
add_interface_port nios_custom_instruction_slave_0 result result Output 32
# | 
# +-----------------------------------
