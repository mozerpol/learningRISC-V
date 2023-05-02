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
library select_wr_lib;
   use select_wr_lib.all;
   use select_wr_lib.select_wr_pkg.all;
library reg_file_lib;
   use reg_file_lib.all;
   use reg_file_lib.reg_file_pkg.all;
library decode_lib;
   use decode_lib.all;
   use decode_lib.decode_pkg.all;
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

   component mem_addr_sel is
   port (
      clk      : in std_logic;
      rst      : in std_logic;
      pc_sel   : in std_logic_vector(1 downto 0);
      mem_sel  : in std_logic;
      alu_out  : in std_logic_vector(REG_LEN-1 downto 0);
      pc       : out std_logic_vector(REG_LEN-1 downto 0);
      addr     : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component mem_addr_sel;

   component inst_mgmt is
   port (
      signal clk        : in std_logic;
      signal rst        : in std_logic;
      signal inst_sel   : in std_logic_vector(1 downto 0);
      signal rdata      : in std_logic_vector(REG_LEN-1 downto 0);
      signal inst       : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component;

   component decode is
   port (
      signal inst    : in std_logic_vector(31 downto 0);
      signal rd      : out std_logic_vector(4 downto 0);
      signal rs1     : out std_logic_vector(4 downto 0);
      signal rs2     : out std_logic_vector(4 downto 0);
      signal imm_I   : out std_logic_vector(31 downto 0);
      signal imm_S   : out std_logic_vector(31 downto 0);
      signal imm_B   : out std_logic_vector(31 downto 0);
      signal imm_U   : out std_logic_vector(31 downto 0);
      signal imm_J   : out std_logic_vector(31 downto 0);
      signal opcode  : out std_logic_vector(4 downto 0);
      signal func3   : out std_logic_vector(2 downto 0);
      signal func7   : out std_logic_vector(6 downto 0)
   );
   end component;

   component imm_mux is
   port (
      imm_type    : in std_logic_vector(2 downto 0);
      imm_J       : in std_logic_vector(REG_LEN-1 downto 0);
      imm_U       : in std_logic_vector(REG_LEN-1 downto 0);
      imm_B       : in std_logic_vector(REG_LEN-1 downto 0);
      imm_S       : in std_logic_vector(REG_LEN-1 downto 0);
      imm_I       : in std_logic_vector(REG_LEN-1 downto 0);
      imm         : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component;

   component select_rd_design is
   port (
      signal rdata         : in std_logic_vector(REG_LEN-1 downto 0);
      signal sel_type      : in std_logic_vector(2 downto 0);
      signal sel_addr_old  : in std_logic_vector(1 downto 0);
      signal rd_mem        : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component;

   component reg_file_design is
   generic (
      ADDR_LEN : integer := 5
   );
   port (
      signal clk     : in std_logic;
      signal reg_wr  : in std_logic;
      signal rs1     : in std_logic_vector(ADDR_LEN-1 downto 0);
      signal rs2     : in std_logic_vector(ADDR_LEN-1 downto 0);
      signal rd      : in std_logic_vector(ADDR_LEN-1 downto 0);
      signal rd_d    : in std_logic_vector(REG_LEN-1 downto 0);
      signal rs1_d   : out std_logic_vector(REG_LEN-1 downto 0);
      signal rs2_d   : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component;

   component rd_mux_design is
   port (
      signal imm        : in std_logic_vector(REG_LEN-1 downto 0);
      signal pc         : in std_logic_vector(REG_LEN-1 downto 0);
      signal alu_out    : in std_logic_vector(REG_LEN-1 downto 0);
      signal rd_mem     : in std_logic_vector(REG_LEN-1 downto 0);
      signal clk        : in std_logic;
      signal rd_sel     : in std_logic_vector(1 downto 0);
      signal rd_d       : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component;

   component alu1_mux_design is
   port (
      rs1_d    : in std_logic_vector(REG_LEN-1 downto 0);
      pc       : in std_logic_vector(REG_LEN-1 downto 0);
      alu1_sel : in std_logic;
      clk      : in std_logic;
      alu_in1  : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component;

   component alu2_mux_design is
   port (
      signal rs2_d    : in std_logic_vector(REG_LEN-1 downto 0);
      signal imm      : in std_logic_vector(REG_LEN-1 downto 0);
      signal alu2_sel : in std_logic;
      signal alu_in2  : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component;

   component alu is
   port (
      signal alu_in1    : in std_logic_vector(REG_LEN-1 downto 0);
      signal alu_in2    : in std_logic_vector(REG_LEN-1 downto 0);
      signal alu_op     : in std_logic_vector(3 downto 0);
      signal alu_out    : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component;

   component cmp is
   port (
      rs1_d    : in std_logic_vector(REG_LEN-1 downto 0);
      rs2_d    : in std_logic_vector(REG_LEN-1 downto 0);
      cmp_op   : in std_logic_vector(2 downto 0);
      b        : out std_logic
   );
   end component;

   component select_wr_design is
   port (
      signal rs2_d      : in std_logic_vector(REG_LEN-1 downto 0);
      signal sel_type   : in std_logic_vector(2 downto 0);
      signal sel_addr   : in std_logic_vector(1 downto 0);
      signal be         : out std_logic_vector(3 downto 0);
      signal wdata      : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component;

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
   end component;

   signal pc_sel        : std_logic_vector(1 downto 0);
   signal mem_sel       : std_logic;
   signal alu_out       : std_logic_vector(REG_LEN-1 downto 0);
   signal pc            : std_logic_vector(REG_LEN-1 downto 0);
   signal inst_sel      : std_logic_vector(1 downto 0);
   signal inst          : std_logic_vector(REG_LEN-1 downto 0);
   signal rd            : std_logic_vector(4 downto 0);
   signal rs1           : std_logic_vector(4 downto 0);
   signal rs2           : std_logic_vector(4 downto 0);
   signal imm_I         : std_logic_vector(31 downto 0);
   signal imm_S         : std_logic_vector(31 downto 0);
   signal imm_B         : std_logic_vector(31 downto 0);
   signal imm_U         : std_logic_vector(31 downto 0);
   signal imm_J         : std_logic_vector(31 downto 0);
   signal opcode        : std_logic_vector(4 downto 0);
   signal func3         : std_logic_vector(2 downto 0);
   signal func7         : std_logic_vector(6 downto 0);
   signal imm_type      : std_logic_vector(2 downto 0);
   signal imm           : std_logic_vector(REG_LEN-1 downto 0);
   signal sel_type      : std_logic_vector(2 downto 0);
   signal sel_addr      : std_logic_vector(1 downto 0);
   signal sel_addr_old  : std_logic_vector(1 downto 0);
   signal rd_mem        : std_logic_vector(REG_LEN-1 downto 0);
   signal reg_wr        : std_logic;
   signal rd_d          : std_logic_vector(REG_LEN-1 downto 0);
   signal rs1_d         : std_logic_vector(REG_LEN-1 downto 0);
   signal rs2_d         : std_logic_vector(REG_LEN-1 downto 0);
   signal rd_sel        : std_logic_vector(1 downto 0);
   signal alu1_sel      : std_logic;
   signal alu_in1       : std_logic_vector(REG_LEN-1 downto 0);
   signal alu2_sel      : std_logic;
   signal alu_in2       : std_logic_vector(REG_LEN-1 downto 0);
   signal alu_op        : std_logic_vector(3 downto 0);
   signal cmp_op        : std_logic_vector(2 downto 0);
   signal b             : std_logic;


begin

   inst_mem_addr_sel : component mem_addr_sel
   port map (
      pc_sel   => pc_sel,
      mem_sel  => mem_sel,
      pc       => pc,
      alu_out  => alu_out,
      clk      => clk,
      rst      => rst,
      addr     => addr
   );

   inst_inst_mgtm : component inst_mgmt
   port map(
      clk      => clk,
      rst      => rst,
      inst_sel => inst_sel,
      rdata    => rdata,
      inst     => inst
   );

   inst_decode : component decode
   port map(
      inst     => inst,
      rd       => rd,
      rs1      => rs1,
      rs2      => rs2,
      imm_I    => imm_I,
      imm_S    => imm_S,
      imm_B    => imm_B,
      imm_U    => imm_U,
      imm_J    => imm_J,
      opcode   => opcode,
      func3    => func3,
      func7    => func7
   );

   inst_imm_mux : component imm_mux
   port map(
      imm_type => imm_type,
      imm_I    => imm_I,
      imm_S    => imm_S,
      imm_B    => imm_B,
      imm_U    => imm_U,
      imm_J    => imm_J,
      imm      => imm
   );

   inst_select_rd : component select_rd_design
   port map(
      sel_addr_old   => sel_addr_old,
      rd_mem   => rd_mem,
      rdata    => rdata,
      sel_type => sel_type
   );

   inst_reg_file : component reg_file_design
   generic map(
      ADDR_LEN => 5
   )
   port map(
      clk      => clk,
      reg_wr   => reg_wr, 
      rs1      => rs1,
      rs2      => rs2,
      rd       => rd,
      rd_d     => rd_d,
      rs1_d    => rs1_d,
      rs2_d    => rs2_d
   );

   inst_rd_mux : component rd_mux_design
   port map(
      pc       => pc,
      rd_sel   => rd_sel,
      rd_d     => rd_d,
      alu_out  => alu_out,
      imm      => imm,
      rd_mem   => rd_mem,
      clk      => clk
   );

   inst_alu1_mux : component alu1_mux_design
   port map(
      rs1_d    => rs1_d,
      pc       => pc,
      alu1_sel => alu1_sel,
      clk      => clk,
      alu_in1  => alu_in1
   );

   inst_alu2_mux : component alu2_mux_design
   port map(
      rs2_d    => rs2_d,
      imm      => imm,
      alu2_sel => alu2_sel,
      alu_in2  => alu_in2
   );

   inst_alu : component alu
   port map(
      alu_op   => alu_op,
      alu_in1  => alu_in1,
      alu_in2  => alu_in2,
      alu_out  => alu_out
   );

   inst_cmp : component cmp
   port map(
      rs1_d    => rs1_d,
      rs2_d    => rs2_d,
      cmp_op   => cmp_op,
      b        => b
   );

   inst_select_wr : component select_wr_design
   port map(
      rs2_d    => rs2_d,
      sel_type => sel_type,
      sel_addr => sel_addr,
      be       => be,
      wdata    => wdata
   );

   inst_ctrl : component ctrl
   port map(
      clk      => clk,
      rst      => rst,
      opcode   => opcode,
      func3    => func3,
      func7    => func7,
      b        => b,
      reg_wr   => reg_wr,
      we       => we,
      pc_sel   => pc_sel,
      mem_sel  => mem_sel,
      imm_type => imm_type,
      inst_sel => inst_sel,
      alu1_sel => alu1_sel,
      alu2_sel => alu2_sel,
      rd_sel   => rd_sel,
      cmp_op   => cmp_op,
      sel_type => sel_type,
      alu_op   => alu_op
   );

   sel_addr <= addr(1 downto 0);

   p_rysy_core : process (clk)
   begin
      if (clk'event and clk = '1') then
         sel_addr_old <= sel_addr;
      end if;
   end process p_rysy_core;

end architecture rtl;
