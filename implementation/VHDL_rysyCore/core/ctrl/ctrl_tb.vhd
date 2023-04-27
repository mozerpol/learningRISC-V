library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity ctrl_tb is
end ctrl_tb;

architecture tb of ctrl_tb is

   component ctrl is
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
   end component ctrl;

   signal clk_tb         : std_logic;
   signal rst_tb         : std_logic;
   signal opcode_tb      : std_logic_vector(4 downto 0);
   signal func3_tb       : std_logic_vector(2 downto 0);
   signal func7_tb       : std_logic_vector(6 downto 0);
   signal b_tb           : std_logic;
   signal reg_wr_tb      : std_logic;
   signal we_tb          : std_logic;
   signal imm_type_tb    : std_logic_vector(2 downto 0);
   signal alu1_sel_tb    : std_logic;
   signal alu2_sel_tb    : std_logic;
   signal rd_sel_tb      : std_logic_vector(1 downto 0);
   signal pc_sel_tb      : std_logic_vector(1 downto 0);
   signal mem_sel_tb     : std_logic;
   signal cmp_op_tb      : std_logic_vector(2 downto 0);
   signal sel_type_tb    : std_logic_vector(2 downto 0);
   signal inst_sel_tb    : std_logic_vector(1 downto 0);
   signal alu_op_tb      : std_logic_vector(3 downto 0);
 
begin

   inst_ctrl : component ctrl 
   port map (
      clk      => clk_tb,
      rst      => rst_tb,
      opcode   => opcode_tb,
      func3    => func3_tb,
      func7    => func7_tb,
      b        => b_tb,
      reg_wr   => reg_wr_tb,
      we       => we_tb,
      imm_type => imm_type_tb,
      alu1_sel => alu1_sel_tb,
      alu2_sel => alu2_sel_tb,
      rd_sel   => rd_sel_tb,
      pc_sel   => pc_sel_tb,
      mem_sel  => mem_sel_tb,
      cmp_op   => cmp_op_tb,
      sel_type => sel_type_tb,
      inst_sel => inst_sel_tb,
      alu_op   => alu_op_tb
   );

   ctrl_tb : process
   begin

      wait for 25 ns;
      stop(2); 
   end process ctrl_tb;

end architecture tb;
