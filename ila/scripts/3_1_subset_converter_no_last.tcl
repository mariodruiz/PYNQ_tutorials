disconnect_bd_intf_net [get_bd_intf_net axis_data_fifo_M_AXIS] [get_bd_intf_pins axis_data_fifo/M_AXIS]

create_bd_cell -type ip -vlnv xilinx.com:ip:axis_subset_converter axis_subset_converter
connect_bd_net [get_bd_pins axis_subset_converter/aclk] [get_bd_pins axis_data_fifo/s_axis_aclk]
connect_bd_net [get_bd_pins axis_subset_converter/aresetn] [get_bd_pins axis_data_fifo/s_axis_aresetn]
connect_bd_intf_net [get_bd_intf_pins axis_subset_converter/S_AXIS] [get_bd_intf_pins axis_data_fifo/M_AXIS]
connect_bd_intf_net [get_bd_intf_pins axis_subset_converter/M_AXIS] [get_bd_intf_pins axi_dma/S_AXIS_S2MM]

set_property -dict [list \
  CONFIG.S_HAS_TLAST.VALUE_SRC USER \
  CONFIG.M_HAS_TLAST.VALUE_SRC USER \
  CONFIG.DEFAULT_TLAST {20} \
  CONFIG.S_HAS_TLAST {0} \
] [get_bd_cells axis_subset_converter]

validate_bd_design
save_bd_design