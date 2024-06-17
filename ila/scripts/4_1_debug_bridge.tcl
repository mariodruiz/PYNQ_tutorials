create_bd_cell -type ip -vlnv xilinx.com:ip:debug_bridge debug_bridge_0

set_property CONFIG.C_DEBUG_MODE {2} [get_bd_cells debug_bridge_0]

connect_bd_net [get_bd_pins debug_bridge_0/s_axi_aclk] [get_bd_pins axis_data_fifo/s_axis_aclk]
connect_bd_net [get_bd_pins debug_bridge_0/s_axi_aresetn] [get_bd_pins axis_data_fifo/s_axis_aresetn]

set ps [get_bd_cells zynq_ultra_ps_e]
if {[string trim $ps] != ""} {
    apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/zynq_ultra_ps_e/pl_clk0 (99 MHz)} Clk_slave {/zynq_ultra_ps_e/pl_clk0 (99 MHz)} Clk_xbar {/zynq_ultra_ps_e/pl_clk0 (99 MHz)} Master {/zynq_ultra_ps_e/M_AXI_HPM0_LPD} Slave {/debug_bridge_0/S_AXI} ddr_seg {Auto} intc_ip {/ps8_axi_periph} master_apm {0}}  [get_bd_intf_pins debug_bridge_0/S_AXI]
} else {
    apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/processing_system7_0/FCLK_CLK0 (100 MHz)} Clk_slave {/processing_system7_0/FCLK_CLK0 (100 MHz)} Clk_xbar {/processing_system7_0/FCLK_CLK0 (100 MHz)} Master {/processing_system7_0/M_AXI_GP0} Slave {/debug_bridge_0/S_AXI} ddr_seg {Auto} intc_ip {/ps7_0_axi_periph} master_apm {0}}  [get_bd_intf_pins debug_bridge_0/S_AXI]
}

validate_bd_design
save_bd_design