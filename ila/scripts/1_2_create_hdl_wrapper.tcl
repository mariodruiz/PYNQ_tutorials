set proj_name [current_project]
#set bd_name [lindex [get_bd_designs] end] more generic but may not always work
set bd_name "dma"
set proj_path [get_property DIRECTORY [current_project]]

make_wrapper -files [get_files ${proj_path}/${proj_name}.srcs/sources_1/bd/${bd_name}/${bd_name}.bd] -top -force
add_files -norecurse ${proj_path}/${proj_name}.gen/sources_1/bd/${bd_name}/hdl/${bd_name}_wrapper.v -force