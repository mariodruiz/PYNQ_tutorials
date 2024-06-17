set proj_name [current_project]
#set bd_name [lindex [get_bd_designs] end] mroe generic but may not always work
set bd_name "dma"
set proj_path [get_property DIRECTORY [current_project]]

#set project basename, so final overlay would be in the form of "dma" + basename
set basename "" 

# Change depending on the board you're using
#set folder "overlay/zynq"
set folder "overlay/mpsoc"

cd ${proj_path}
exec mkdir ${folder} -p

catch {exec cp ${proj_path}/${proj_name}.runs/impl_1/${bd_name}_wrapper.bit ${proj_path}/${folder}/${bd_name}${basename}.bit}
catch {exec cp ${proj_path}/${proj_name}.runs/impl_1/${bd_name}_wrapper.ltx ${proj_path}/${folder}/${bd_name}${basename}.ltx}
catch {exec cp ${proj_path}/${proj_name}.gen/sources_1/bd/${bd_name}/hw_handoff/${bd_name}.hwh ${proj_path}/${folder}/${bd_name}${basename}.hwh}

puts "Files copied to: ${proj_path}/${folder}/"