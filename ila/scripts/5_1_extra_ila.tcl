set system_ila_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:system_ila system_ila_1 ]

set_property -dict [list \
  CONFIG.C_EN_STRG_QUAL {1} \
] $system_ila_0


connect_bd_net [get_bd_pins system_ila_1/clk] [get_bd_pins zynq_ultra_ps_e/pl_clk0]
connect_bd_net [get_bd_pins system_ila_1/resetn] [get_bd_pins rst_ps8_100M/peripheral_aresetn]
connect_bd_intf_net [get_bd_intf_pins system_ila_1/SLOT_0_AXI] [get_bd_intf_pins axi_smc/S01_AXI]
