# Create Vivado Project for KV260

set path $::env(HOME)
set proj_name "test1"

create_project ${proj_name} ${path}/${proj_name} -part xck26-sfvc784-2LV-c
set_property board_part xilinx.com:kv260_som:part0:1.4 [current_project]