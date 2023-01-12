###### Set module name only ######
set module        "simplegate"

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


echo "----> Create library:"
if {[file exists $lib_name/_info]} {
   echo "Library already exists"
} else {
   echo "Library $lib_name don't exist"
   echo "Create library inside: [pwd]"
   vlib $lib_name
}

echo "----> Map library:"
vmap $lib_name $lib_name

echo "----> Compile files:"
echo "-> Package"
if {[file exist $package_name.vhd]} {
   vcom -2008 -quiet -work $lib_name $package_name.vhd
} else {
   return "File $package_name not found, stop script"
}
echo "-> Design"
if {[file exist $design_name.vhd]} {
   vcom -2008 -quiet -work $lib_name $design_name.vhd 
} else {
   return "File $design_name not found, stop script"
}
echo "-> Testbench"
if {[file exist $test_name.vhd]} {
   vcom -2008 -quiet -work $lib_name $test_name.vhd
} else {
   return "File $test_name not found, stop script"
}

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

echo "----> Run tests"
run -all
# Simstats time
echo "Simulation start time : [clock format $systemTime_start -format %H:%M:%S]"
echo "Simulation end time   : [clock format $systemTime_end -format %H:%M:%S]"
echo "Simulation time       : [expr {$systemTime_end - $systemTime_start}] sec."
