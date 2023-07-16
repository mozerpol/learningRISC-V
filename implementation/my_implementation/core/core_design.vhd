library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library core_lib;
   use core_lib.all;
   use core_lib.core_pkg.all;
library memory_lib;
   use memory_lib.all;
   use memory_lib.memory_pkg.all;
library alu_lib;
   use alu_lib.all;
   use alu_lib.alu_pkg.all;
library alu_mux_1_lib;
   use alu_mux_1_lib.all;
   use alu_mux_1_lib.alu_mux_1_pkg.all;
library alu_mux_2_lib;
   use alu_mux_2_lib.all;
   use alu_mux_2_lib.alu_mux_2_pkg.all;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;
library opcodes;
   use opcodes.opcodesPkg.all;
library decoder_lib;
   use decoder_lib.all;
   use decoder_lib.decoder_pkg.all;
library reg_file_lib;
   use reg_file_lib.all;
   use reg_file_lib.reg_file_pkg.all; 
   
   
entity core is
   port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_instruction_read   : in std_logic_vector(31 downto 0);
      o_instruction_write  : out std_logic_vector(31 downto 0);
      o_addr_read          : out std_logic_vector(7 downto 0);
      o_addr_write         : out std_logic_vector(7 downto 0);
      o_write_enable       : out std_logic
   );
end entity core;

architecture rtl of core is






begin





end architecture rtl;
