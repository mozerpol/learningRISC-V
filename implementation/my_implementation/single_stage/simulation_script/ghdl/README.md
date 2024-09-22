The top-level entity is *riscpol* in *riscpol_design.vhdl*. The tests are in 
*riscpol_tb.vhdl* file. <br/>
To run simulation in GHDL on Linux go to folder
*/simulation_script/ghld* and run command: `make` using command line. <br/>
After running this command in terminal the GHDL will start simulation, end 
itself and show all signals on the waveforms using GTKWave. You can add your own
signals to the waveforms by modifying the 
*/simulation_script/ghdl/waveforms.tcl* file. 

I used GHDL 5.0.0-dev (4.1.0.r206.g283e84280) [Dunoon edition] <br/>
How to install GHDL: <br/>
- sudo apt install -y git make gnat zlib1g-dev
- git clone https://github.com/ghdl/ghdl
- cd ghdl
- ./configure --prefix=/usr/local
- make
- sudo make install
