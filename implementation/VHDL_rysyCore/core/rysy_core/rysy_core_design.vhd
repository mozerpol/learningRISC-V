library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library rysy_core_lib;
   use rysy_core_lib.all;
   use rysy_core_lib.rysy_core_pkg.all;
library opcodes;
   use opcodes.opcodesPkg.all;
library imm_mux_lib;
   use imm_mux_lib.all;
   use imm_mux_lib.imm_mux_pkg.all;
library alu_lib;
   use alu_lib.all;
   use alu_lib.alu_pkg.all;
library alu1_mux_lib;
   use alu1_mux_lib.all;
   use alu1_mux_lib.alu1_mux_pkg.all;
library alu2_mux_lib;
   use alu2_mux_lib.all;
   use alu2_mux_lib.alu2_mux_pkg.all;
library cmp_lib;
   use cmp_lib.all;
   use cmp_lib.cmp_pkg.all;
library inst_mgmt_lib;
   use inst_mgmt_lib.all;
   use inst_mgmt_lib.inst_mgmt_pkg.all;
library mem_addr_sel_lib;
   use mem_addr_sel_lib.all;
   use mem_addr_sel_lib.mem_addr_sel_pkg.all;
library rd_mux_lib;
   use rd_mux_lib.all;
   use rd_mux_lib.rd_mux_pkg.all;
library select_rd_lib;
   use select_rd_lib.all;
   use select_rd_lib.select_rd_pkg.all;
library ctrl_lib;
   use ctrl_lib.all;
   use ctrl_lib.ctrl_pkg.all;


entity rysy_core_design is
   port (
      clk      : in std_logic;
      rst      : in std_logic;
      rdata    : in std_logic_vector (REG_LEN-1 downto 0);
      wdata    : out std_logic_vector(REG_LEN-1 downto 0);
      addr     : out std_logic_vector(REG_LEN-1 downto 0);
      we       : out std_logic;
      be       : out std_logic_vector(3 downto 0)
   );
end entity rysy_core_design;

architecture rtl of rysy_core_design is

begin

end architecture rtl;
