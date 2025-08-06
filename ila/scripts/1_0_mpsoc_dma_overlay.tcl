# KV260 script, can be used with any MPSoC device

## First you need to create the project using an MPSoC board supported by PYNQ

create_bd_design "dma"

create_bd_cell -type ip -vlnv xilinx.com:ip:zynq_ultra_ps_e:3.5 zynq_ultra_ps_e
apply_bd_automation -rule xilinx.com:bd_rule:zynq_ultra_ps_e -config {apply_board_preset "1" }  [get_bd_cells zynq_ultra_ps_e]

set_property -dict [list \
  CONFIG.PSU__MAXIGP0__DATA_WIDTH {32} \
  CONFIG.PSU__USE__M_AXI_GP0 {0} \
  CONFIG.PSU__USE__M_AXI_GP1 {0} \
  CONFIG.PSU__USE__M_AXI_GP2 {1} \
  CONFIG.PSU__USE__S_AXI_GP2 {1} \
  CONFIG.PSU__FPGA_PL1_ENABLE {0} \
  CONFIG.PSU__USE__IRQ0 {1} \
] [get_bd_cells zynq_ultra_ps_e]

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma axi_dma
set_property -dict [list \
  CONFIG.c_include_sg {0} \
  CONFIG.c_sg_length_width {23} \
  CONFIG.c_addr_width {64} \
] [get_bd_cells axi_dma]

create_bd_cell -type ip -vlnv xilinx.com:ip:axis_data_fifo axis_data_fifo
set_property CONFIG.FIFO_MODE {1} [get_bd_cells axis_data_fifo]

create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc axi_intc
set_property CONFIG.C_IRQ_CONNECTION {1} [get_bd_cells axi_intc]

create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat xlconcat

connect_bd_net [get_bd_pins axi_intc/irq] [get_bd_pins zynq_ultra_ps_e/pl_ps_irq0]
connect_bd_net [get_bd_pins xlconcat/dout] [get_bd_pins axi_intc/intr]
connect_bd_net [get_bd_pins axi_dma/mm2s_introut] [get_bd_pins xlconcat/In0]
connect_bd_net [get_bd_pins axi_dma/s2mm_introut] [get_bd_pins xlconcat/In1]
connect_bd_intf_net [get_bd_intf_pins axis_data_fifo/M_AXIS] [get_bd_intf_pins axi_dma/S_AXIS_S2MM]
connect_bd_intf_net [get_bd_intf_pins axi_dma/M_AXIS_MM2S] [get_bd_intf_pins axis_data_fifo/S_AXIS]

apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/zynq_ultra_ps_e/M_AXI_HPM0_LPD} Slave {/axi_dma/S_AXI_LITE} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_dma/S_AXI_LITE]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/zynq_ultra_ps_e/M_AXI_HPM0_LPD} Slave {/axi_intc/s_axi} ddr_seg {Auto} intc_ip {New AXI Interconnect} master_apm {0}}  [get_bd_intf_pins axi_intc/s_axi]
apply_bd_automation -rule xilinx.com:bd_rule:clkrst -config { Clk {/zynq_ultra_ps_e/pl_clk0 (100 MHz)} Freq {100} Ref_Clk0 {} Ref_Clk1 {} Ref_Clk2 {}}  [get_bd_pins axis_data_fifo/s_axis_aclk]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {Auto} Clk_slave {Auto} Clk_xbar {Auto} Master {/axi_dma/M_AXI_MM2S} Slave {/zynq_ultra_ps_e/S_AXI_HP0_FPD} ddr_seg {Auto} intc_ip {New AXI SmartConnect} master_apm {0}}  [get_bd_intf_pins zynq_ultra_ps_e/S_AXI_HP0_FPD]
apply_bd_automation -rule xilinx.com:bd_rule:axi4 -config { Clk_master {/zynq_ultra_ps_e/pl_clk0 (100 MHz)} Clk_slave {/zynq_ultra_ps_e/pl_clk0 (100 MHz)} Clk_xbar {/zynq_ultra_ps_e/pl_clk0 (100 MHz)} Master {/axi_dma/M_AXI_S2MM} Slave {/zynq_ultra_ps_e/S_AXI_HP0_FPD} ddr_seg {Auto} intc_ip {/axi_smc} master_apm {0}}  [get_bd_intf_pins axi_dma/M_AXI_S2MM]

save_bd_design
validate_bd_design
save_bd_design
