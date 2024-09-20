There are scripts that automate simulation. I wrote them under Linux 
(debian), for Windows you can try to edit them, otherwise you have to do 
everything manually, i.e. add all files with the vhdl extension, compile them 
and then run tests which are in *riscpol_tb.vhdl* file.
1. ModelSim - To run simulation in ModelSim on Linux go to folder 
*/simulation_script/modelsim* and run command: `do script.tcl` <br/>
After running this command in ModelSim the simulation will start, end itself and 
show all signals on the waveforms. You can add your own signals to the waveforms 
by modifying the */simulation_script/modelsim/waveforms.do* file. <br/>
I used Quest Intel Starter FPGA Edition-64 2021.2.
2. GHDL - To run simulation in GHDL on Linux go to folder
*/simulation_script/ghld* and run command: `make` using command line. <br/>
After running this command in terminal the GHDL will start simulation, end 
itself and show all signals on the waveforms. You can add your own signals to 
the waveforms by modifying the */simulation_script/ghdl/waveforms.tcl* file. 
<br/> I used GHDL 5.0.0-dev (4.1.0.r206.g283e84280) [Dunoon edition] <br/>
How to install GHDL: <br/>
- sudo apt install -y git make gnat zlib1g-dev
- git clone https://github.com/ghdl/ghdl
- cd ghdl
- ./configure --prefix=/usr/local
- make
- sudo make install
3. Vivado - TODO
