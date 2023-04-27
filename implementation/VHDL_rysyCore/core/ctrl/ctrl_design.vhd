library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library ctrl_lib;
   use ctrl_lib.all;
   use ctrl_lib.ctrl_pkg.all;

entity ctrl is
   port (
      clk      : in std_logic;
      rst      : in std_logic;
      opcode   : in std_logic_vector(4 downto 0);
      func3    : in std_logic_vector(2 downto 0);
      func7    : in std_logic_vector(6 downto 0);
      b        : in std_logic;
      reg_wr   : out std_logic;
      we       : out std_logic;
      imm_type : out std_logic_vector(2 downto 0);
      alu1_sel : out std_logic;
      alu2_sel : out std_logic;
      rd_sel   : out std_logic_vector(1 downto 0);
      pc_sel   : out std_logic_vector(1 downto 0);
      mem_sel  : out std_logic;
      cmp_op   : out std_logic_vector(2 downto 0);
      sel_type : out std_logic_vector(2 downto 0);
      inst_sel : out std_logic_vector(1 downto 0);
      alu_op   : out std_logic_vector(3 downto 0)
   );
end entity ctrl;

architecture rtl of ctrl is


begin

   p_ctrl : process(all)
   begin

   end process p_ctrl;

end architecture rtl;
