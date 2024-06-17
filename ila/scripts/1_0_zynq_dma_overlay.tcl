# PYNQ-Z2 script, can be used with any Zynq 7000 device

## First you need to create the project using a Zynq board supported by PYNQ

create_bd_design "dma"

create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7 processing_system7_0
apply_bd_automation -rule xilinx.com:bd_rule:processing_system7 -config {make_external "FIXED_IO, DDR" apply_board_preset "1" Master "Disable" Slave "Disable" }  [get_bd_cells processing_system7_0]

set_property -dict [list \
  CONFIG.PCW_USE_S_AXI_HP0 {1} \
  CONFIG.PCW_IRQ_F2P_INTR {1} \
  CONFIG.PCW_USE_FABRIC_INTERRUPT {1} \
] [get_bd_cells processing_system7_0]

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma axi_dma
set_property -dict [list \
  CONFIG.c_include_sg {0} \
  CONFIG.c_sg_length_width {23} \
] [get_bd_cells axi_dma]

create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo axis_data_fifo
set_property CONFIG.FIFO_MODE {1} [get_bd_cells axis_data_fifo]

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc axi_intc
set_property CONFIG.C_IRQ_CONNECTION {1} [get_bd_cells axi_intc]

create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat

connect_bd_net [get_bd_pins axi_intc/irq] [get_bd_pins processing_system7_0/IRQ_F2P]
connect_bd_net [get_bd_pins xlconcat/dout] [get_bd_pins axi_intc/intr]
connect_bd_net [get_bd_pins xlconcat/In0] [get_bd_pins axi_dma/mm2s_introut]
connect_bd_net [get_bd_pins xlconcat/In1] [get_bd_pins axi_dma/s2mm_introut]
connect_bd_intf_net [get_bd_intf_pins axis_data_fifo/S_AXIS] [get_bd_intf_pins axi_dma/M_AXIS_MM2S]
connect_bd_intf_net [get_bd_intf_pins axis_data_fifo/M_AXIS] [get_bd_intf_pins axi_dma/S_AXIS_S2MM]

apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/axi_dma/S_AXI_LITE} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_dma/S_AXI_LITE]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/processing_system7_0/M_AXI_GP0} Slave {/axi_intc/s_axi} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_intc/s_axi]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/processing_system7_0/FCLK_CLK0 (100 MHz)} Freq {100} Ref_Clk0 {} Ref_Clk1 {} Ref_Clk2 {}}  [get_bd_pins axis_data_fifo/s_axis_aclk]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/axi_dma/M_AXI_MM2S} Slave {/processing_system7_0/S_AXI_HP0} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/processing_system7_0/FCLK_CLK0 (100 MHz)} Clk_slave {/processing_system7_0/FCLK_CLK0 (100 MHz)} Clk_xbar {/processing_system7_0/FCLK_CLK0 (100 MHz)} Master {/axi_dma/M_AXI_S2MM} Slave {/processing_system7_0/S_AXI_HP0} ddr_seg {Auto} intc_ip {/axi_mem_intercon} master_apm {0}}  [get_bd_intf_pins axi_dma/M_AXI_S2MM]

save_bd_design
validate_bd_design
save_bd_design
