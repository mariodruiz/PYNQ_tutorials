# Overlays

This folder contains TCL scripts to generate the overlays for the ILA blog series

## Create Vivado Project

Two scripts are provided one for [KV260](https://www.amd.com/en/products/system-on-modules/kria/k26/kv260-vision-starter-kit.html) and another for [PYNQ-Z2](https://www.amd.com/en/corporate/university-program/aup-boards/pynq-z2.html). If your board is not listed, you'll have to modify the script
to create a Vivado project for your board.

- **KV260**: [0_kv260.tcl](0_0_kv260_project.tcl)
- **PYNQ-Z2**: [0_pynqz2.tcl](0_pynqz2_project.tcl)

## Create Block Design

- Using a Zynq based board such as PYNQ-Z2, use [1_0_zynq_dma_overlay.tcl](1_0_zynq_dma_overlay.tcl)
- Using an MPSoC based board such as KV260, use [1_0_mpsoc_dma_overlay.tcl](1_0_mpsoc_dma_overlay.tcl)

## Add ILA

You can do it manualy as specified on the blog or use [1_1_add_ila.tcl](1_1_add_ila.tcl)

## Crete HDL Wrapper

You can do this either manually or use [1_2_create_hdl_wrapper.tcl](1_2_create_hdl_wrapper.tcl)

## Generate Bitstream

Click generate bitstream on Vivado

## Get Overlay files

You can copy the `*.bit` and `*.hwh` files manually or use [copy_overlay.tcl](copy_overlay.tcl)

> **NOTE**: modify the `basename` variable to change the filename

## Add Subset Converter to Remove TLAST

You can do it manually as specified on the blog or use [3_1_subset_converter_no_last.tcl](3_1_subset_converter_no_last.tcl)

## Modify Subset Converter to Eemove TKEEP

You can do it manually as specified on the blog or use [3_2_subset_converter_no_keep.tcl](3_2_subset_converter_no_keep.tcl)