set ps [get_bd_cells zynq_ultra_ps_e]
if {[string trim $ps] != ""} {
    set_property CONFIG.PSU__SAXIGP2__DATA_WIDTH {32} [get_bd_cells zynq_ultra_ps_e]
} else {
    set_property CONFIG.PCW_S_AXI_HP0_DATA_WIDTH {32} [get_bd_cells processing_system7_0]
}