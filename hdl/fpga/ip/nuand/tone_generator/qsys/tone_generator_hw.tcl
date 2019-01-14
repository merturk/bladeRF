# TCL File Generated by Component Editor 18.0
# Mon Jan 14 18:52:45 EST 2019
# DO NOT MODIFY


# 
# tone_generator "bladeRF Tone Generator" v1.0
# Rey Sabrina Tucker <rey.tucker@nuand.com> 2019.01.14.18:52:45
# Generates IQ samples with tones
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module tone_generator
# 
set_module_property DESCRIPTION "Generates IQ samples with tones"
set_module_property NAME tone_generator
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP Peripherals
set_module_property AUTHOR "Rey Sabrina Tucker <rey.tucker@nuand.com>"
set_module_property DISPLAY_NAME "bladeRF Tone Generator"
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL tone_generator_hw
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file tone_generator_hw.vhd VHDL PATH ../vhdl/tone_generator_hw.vhd TOP_LEVEL_FILE
add_fileset_file tone_generator.vhd VHDL PATH ../vhdl/tone_generator.vhd
add_fileset_file nco.vhd VHDL PATH ../../synthesis/nco.vhd
add_fileset_file cordic.vhd VHDL PATH ../../synthesis/cordic.vhd
add_fileset_file reset_synchronizer.vhd VHDL PATH ../../synthesis/reset_synchronizer.vhd
add_fileset_file synchronizer.vhd VHDL PATH ../../synthesis/synchronizer.vhd

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL tone_generator_hw
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file tone_generator_tb.vhd VHDL PATH ../vhdl/tb/tone_generator_tb.vhd
add_fileset_file tone_generator.vhd VHDL PATH ../vhdl/tone_generator.vhd
add_fileset_file tone_generator_hw.vhd VHDL PATH ../vhdl/tone_generator_hw.vhd


# 
# parameters
# 
add_parameter QUEUE_LENGTH POSITIVE 8 "Number of tones that can be queued"
set_parameter_property QUEUE_LENGTH DEFAULT_VALUE 8
set_parameter_property QUEUE_LENGTH DISPLAY_NAME "Queue length"
set_parameter_property QUEUE_LENGTH TYPE POSITIVE
set_parameter_property QUEUE_LENGTH UNITS None
set_parameter_property QUEUE_LENGTH ALLOWED_RANGES 1:2147483647
set_parameter_property QUEUE_LENGTH DESCRIPTION "Number of tones that can be queued"
set_parameter_property QUEUE_LENGTH HDL_PARAMETER true
add_parameter ADDR_WIDTH POSITIVE 2 "Minimum 2 bits"
set_parameter_property ADDR_WIDTH DEFAULT_VALUE 2
set_parameter_property ADDR_WIDTH DISPLAY_NAME "Address bus width"
set_parameter_property ADDR_WIDTH TYPE POSITIVE
set_parameter_property ADDR_WIDTH UNITS None
set_parameter_property ADDR_WIDTH ALLOWED_RANGES 1:2147483647
set_parameter_property ADDR_WIDTH DESCRIPTION "Minimum 2 bits"
set_parameter_property ADDR_WIDTH HDL_PARAMETER true
add_parameter DATA_WIDTH POSITIVE 32 "Minimum 8 bits"
set_parameter_property DATA_WIDTH DEFAULT_VALUE 32
set_parameter_property DATA_WIDTH DISPLAY_NAME "Data bus width"
set_parameter_property DATA_WIDTH TYPE POSITIVE
set_parameter_property DATA_WIDTH UNITS None
set_parameter_property DATA_WIDTH ALLOWED_RANGES 1:2147483647
set_parameter_property DATA_WIDTH DESCRIPTION "Minimum 8 bits"
set_parameter_property DATA_WIDTH HDL_PARAMETER true


# 
# display items
# 


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock_sink
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset reset Input 1


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock_sink
set_interface_property avalon_slave_0 associatedReset reset
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 1
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 0
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 addr address Input addr_width
add_interface_port avalon_slave_0 din writedata Input data_width
add_interface_port avalon_slave_0 dout readdata Output data_width
add_interface_port avalon_slave_0 write write Input 1
add_interface_port avalon_slave_0 read read Input 1
add_interface_port avalon_slave_0 waitreq waitrequest Output 1
add_interface_port avalon_slave_0 readack readdatavalid Output 1
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point clock_sink
# 
add_interface clock_sink clock end
set_interface_property clock_sink clockRate 0
set_interface_property clock_sink ENABLED true
set_interface_property clock_sink EXPORT_OF ""
set_interface_property clock_sink PORT_NAME_MAP ""
set_interface_property clock_sink CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink SVD_ADDRESS_GROUP ""

add_interface_port clock_sink clock clk Input 1


# 
# connection point clock_sink_iq
# 
add_interface clock_sink_iq clock end
set_interface_property clock_sink_iq clockRate 0
set_interface_property clock_sink_iq ENABLED true
set_interface_property clock_sink_iq EXPORT_OF ""
set_interface_property clock_sink_iq PORT_NAME_MAP ""
set_interface_property clock_sink_iq CMSIS_SVD_VARIABLES ""
set_interface_property clock_sink_iq SVD_ADDRESS_GROUP ""

add_interface_port clock_sink_iq sample_clk clk Input 1


# 
# connection point samplestream
# 
add_interface samplestream conduit end
set_interface_property samplestream associatedClock clock_sink
set_interface_property samplestream associatedReset ""
set_interface_property samplestream ENABLED true
set_interface_property samplestream EXPORT_OF ""
set_interface_property samplestream PORT_NAME_MAP ""
set_interface_property samplestream CMSIS_SVD_VARIABLES ""
set_interface_property samplestream SVD_ADDRESS_GROUP ""

add_interface_port samplestream sample_valid valid Output 1


# 
# connection point status
# 
add_interface status conduit end
set_interface_property status associatedClock clock_sink
set_interface_property status associatedReset ""
set_interface_property status ENABLED true
set_interface_property status EXPORT_OF ""
set_interface_property status PORT_NAME_MAP ""
set_interface_property status CMSIS_SVD_VARIABLES ""
set_interface_property status SVD_ADDRESS_GROUP ""

add_interface_port status queue_empty empty Output 1
add_interface_port status queue_full full Output 1
add_interface_port status running running Output 1
