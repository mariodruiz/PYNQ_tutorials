# Create Vivado Project for PYNQ-Z2

set path $::env(HOME)
set proj_name "dma_blog_mpsoc"

create_project ${proj_name} ${path}/${proj_name} -part xc7z020clg400-1
set_property board_part tul.com.tw:pynq-z2:part0:1.0 [current_project]