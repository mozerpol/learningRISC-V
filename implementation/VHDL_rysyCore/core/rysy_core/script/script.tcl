###### Set module name ######
set module        "rysy_core"


###### Include external libraries ######
# set hdl_dir               "directory/to/library"
# set library_name          "library_name"
# vcom -2008 -quiet -work   $library_name $hdl_dir/file1.vhd
# vcom -2008 -quiet -work   $library_name $hdl_dir/file2.vhd
#                         .
#                         .
#                         .
# vcom -2008 -quiet -work   $library_name $hdl_dir/file.vhd

set hdl_dir                "../../"
set library_name           "rysy_pkg"
vcom -2008 -quiet -work    $library_name $hdl_dir/rysy_pkg.vhd

set hdl_dir                "../../"
set library_name           "opcodes"
vcom -2008 -quiet -work    $library_name $hdl_dir/opcodes.vhd

set hdl_dir                "../../imm_mux/"
set library_name           "imm_mux_lib"
vcom -2008 -quiet -work    $library_name $hdl_dir/imm_mux_pkg.vhd
vcom -2008 -quiet -work    $library_name $hdl_dir/imm_mux_design.vhd

set hdl_dir                "../../alu/"
set library_name           "alu_lib"
vcom -2008 -quiet -work    $library_name $hdl_dir/alu_pkg.vhd
vcom -2008 -quiet -work    $library_name $hdl_dir/alu_design.vhd

set hdl_dir                "../../alu1_mux/"
set library_name           "alu1_mux_lib"
vcom -2008 -quiet -work    $library_name $hdl_dir/alu1_mux_pkg.vhd
vcom -2008 -quiet -work    $library_name $hdl_dir/alu1_mux_design.vhd

set hdl_dir                "../../alu2_mux/"
set library_name           "alu2_mux_lib"
vcom -2008 -quiet -work    $library_name $hdl_dir/alu2_mux_pkg.vhd
vcom -2008 -quiet -work    $library_name $hdl_dir/alu2_mux_design.vhd

set hdl_dir                "../../cmp/"
set library_name           "cmp_lib"
vcom -2008 -quiet -work    $library_name $hdl_dir/cmp_pkg.vhd
vcom -2008 -quiet -work    $library_name $hdl_dir/cmp_design.vhd

set hdl_dir                "../../inst_mgmt/"
set library_name           "inst_mgmt_lib"
vcom -2008 -quiet -work    $library_name $hdl_dir/inst_mgmt_pkg.vhd
vcom -2008 -quiet -work    $library_name $hdl_dir/inst_mgmt_design.vhd

set hdl_dir                "../../decode/"
set library_name           "decode_lib"
vcom -2008 -quiet -work    $library_name $hdl_dir/decode_pkg.vhd
vcom -2008 -quiet -work    $library_name $hdl_dir/decode_design.vhd

set hdl_dir                "../../reg_file/"
set library_name           "reg_file_lib"
vcom -2008 -quiet -work    $library_name $hdl_dir/reg_file_pkg.vhd
vcom -2008 -quiet -work    $library_name $hdl_dir/reg_file_design.vhd

set hdl_dir                "../../mem_addr_sel/"
set library_name           "mem_addr_sel_lib"
vcom -2008 -quiet -work    $library_name $hdl_dir/mem_addr_sel_pkg.vhd
vcom -2008 -quiet -work    $library_name $hdl_dir/mem_addr_sel_design.vhd

set hdl_dir                "../../rd_mux/"
set library_name           "rd_mux_lib"
vcom -2008 -quiet -work    $library_name $hdl_dir/rd_mux_pkg.vhd
vcom -2008 -quiet -work    $library_name $hdl_dir/rd_mux_design.vhd

set hdl_dir                "../../select_wr/"
set library_name           "select_wr_lib"
vcom -2008 -quiet -work    $library_name $hdl_dir/select_wr_pkg.vhd
vcom -2008 -quiet -work    $library_name $hdl_dir/select_wr_design.vhd

set hdl_dir                "../../select_rd/"
set library_name           "select_rd_lib"
vcom -2008 -quiet -work    $library_name $hdl_dir/select_rd_pkg.vhd
vcom -2008 -quiet -work    $library_name $hdl_dir/select_rd_design.vhd

set hdl_dir                "../../ctrl/"
set library_name           "ctrl_lib"
vcom -2008 -quiet -work    $library_name $hdl_dir/ctrl_pkg.vhd
vcom -2008 -quiet -work    $library_name $hdl_dir/ctrl_design.vhd

##################################
#         PROJECT TREE:
#
# |___folder_example_name
# |   |___design.vhd
# |   |___testbench.vhd
# |   |___package.vhd
# |   |
# |   |___scripts
# |       |___script.tcl (this file)
# |       |___waveforms.do
# 
#         RULES:
# Design, testbench must have the VHD extension
# Waveforms must have the DO extension
# Script must have the TCL extension
#
#         HOW TO RUN:
# Go to directory where is script.tcl and run command: do script.tcl

set lib_name         $module\_lib
set design_name      ../$module\_design
set test_name        ../$module\_tb
set package_name     ../$module\_pkg
set waveforms        $module\_lib.$module\_tb
set systemTime_start [clock seconds]
set systemTime_end   [clock seconds]

proc s_show_description {} {
    global lib_name
    echo "\n============================\n"
    echo "      $lib_name"
    echo "\n============================\n"
}

proc s_create_lib_main {} {
    global lib_name
    echo "----> Create library:"
    if {[file exists $lib_name/_info]} {
       echo "Library already exists"
    } else {
       echo "Library $lib_name don't exist"
       echo "Create library inside: [pwd]"
       vlib $lib_name
    }
}

proc s_map_lib_main {} {
    global lib_name
    echo "----> Map library:"
    vmap $lib_name $lib_name
}

proc s_comp_package_main {} {
    global package_name lib_name
    echo "----> Compile files:"
    echo "-> Package"
    if {[file exist $package_name.vhd]} {
       echo "OK"
       vcom -2008 -quiet -work $lib_name $package_name.vhd
    } else {
       echo "File $package_name not found"
    }
}

proc s_comp_design_main {} {
    global design_name lib_name
    echo "-> Design"
    if {[file exist $design_name.vhd]} {
       echo "OK"
       vcom -2008 -quiet -work $lib_name $design_name.vhd 
    } else {
       return "File $design_name not found, stop script"
    }
}

proc s_comp_test_main {} {
    global test_name lib_name
    echo "-> Testbench"
    if {[file exist $test_name.vhd]} {
       echo "OK"
       vcom -2008 -quiet -work $lib_name $test_name.vhd
    } else {
       return "File $test_name not found, stop script"
    }
}

proc s_load_waves {} {
    global waveforms
    echo "----> Load waveforms:"
    if {[file exist waveforms.do]} {
       vsim -voptargs=+acc $waveforms 
       # voptargs=+acc - Apply full visibility to all modules, Questa need this, may
       # in Modelsim can delete
       view wave -undock -title wave_TOP
       do waveforms.do
       echo "-> Waveform loaded"
    } else {
       echo "File waveforms.do not found"
    }
}

proc s_start_sim {} {
    global systemTime_start systemTime_end systemTime_start
    echo "----> Run tests"
    run -all
    # Simstats time
    echo "Simulation start time : [clock format $systemTime_start -format %H:%M:%S]"
    echo "Simulation end time   : [clock format $systemTime_end -format %H:%M:%S]"
    echo "Simulation time       : [expr {$systemTime_end - $systemTime_start}] sec."
}

s_show_description
s_create_lib_main
s_map_lib_main
s_comp_package_main
s_comp_design_main
s_comp_test_main
s_load_waves
s_start_sim
