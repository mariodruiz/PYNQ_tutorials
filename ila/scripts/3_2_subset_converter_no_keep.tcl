set_property -dict [list \
  CONFIG.S_HAS_TLAST.VALUE_SRC USER \
  CONFIG.M_HAS_TKEEP.VALUE_SRC USER \
  CONFIG.M_HAS_TLAST.VALUE_SRC USER \
  CONFIG.M_HAS_TKEEP {1} \
  CONFIG.M_HAS_TLAST {1} \
  CONFIG.S_HAS_TLAST {1} \
  CONFIG.TKEEP_REMAP {4'b0} \
] [get_bd_cells axis_subset_converter]