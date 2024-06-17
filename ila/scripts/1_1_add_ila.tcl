
set system_ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila system_ila_0 ]
set_property -dict [list \
CONFIG.C_EN_STRG_QUAL {1} \
CONFIG.C_NUM_MONITOR_SLOTS {2} \
CONFIG.C_SLOT {1} \
CONFIG.C_SLOT_0_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
CONFIG.C_SLOT_1_INTF_TYPE {xilinx.com:interface:axis_rtl:1.0} \
] $system_ila_0

connect_bd_intf_net [get_bd_intf_pins system_ila_0/SLOT_0_AXIS] [get_bd_intf_pins axi_dma/M_AXIS_MM2S]
connect_bd_intf_net [get_bd_intf_pins system_ila_0/SLOT_1_AXIS] [get_bd_intf_pins axis_data_fifo/M_AXIS]
connect_bd_net [get_bd_pins system_ila_0/clk] [get_bd_pins axis_data_fifo/s_axis_aclk]
connect_bd_net [get_bd_pins system_ila_0/resetn] [get_bd_pins axis_data_fifo/s_axis_aresetn]

save_bd_design
validate_bd_design
save_bd_design