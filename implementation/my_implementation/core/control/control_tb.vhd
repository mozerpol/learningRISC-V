library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;
library opcodes;
   use opcodes.opcodesPkg.all;
library alu_lib;
   use alu_lib.alu_pkg.all;

entity control_tb is
end control_tb;

architecture tb of control_tb is

   component control is
   port (
      i_rst                   : in std_logic;
      i_opcode                : in std_logic_vector(6 downto 0);
      i_func3                 : in std_logic_vector(2 downto 0);
      i_func7                 : in std_logic_vector(6 downto 0);
      o_alu_mux_1_ctrl        : out std_logic;
      o_alu_mux_2_ctrl        : out std_logic;
      o_alu_control           : out std_logic_vector(5 downto 0);
      o_reg_wr_ctrl           : out std_logic
   );
   end component control;

   signal rst_tb              : std_logic;
   signal opcode_tb           : std_logic_vector(6 downto 0);
   signal func3_tb            : std_logic_vector(2 downto 0);
   signal func7_tb            : std_logic_vector(6 downto 0);
   signal alu_mux_1_ctrl_tb   : std_logic;
   signal alu_mux_2_ctrl_tb   : std_logic;
   signal alu_control_tb      : std_logic_vector(5 downto 0);
   signal reg_wr_ctrl_tb      : std_logic;

begin

   inst_control : component control
   port map (
      i_rst             => rst_tb,
      i_opcode          => opcode_tb,
      i_func3           => func3_tb,
      i_func7           => func7_tb,
      o_alu_mux_1_ctrl  => alu_mux_1_ctrl_tb,
      o_alu_mux_2_ctrl  => alu_mux_2_ctrl_tb,
      o_alu_control     => alu_control_tb,
      o_reg_wr_ctrl     => reg_wr_ctrl_tb
   );

   p_tb : process
   begin

      rst_tb      <= '1';
      opcode_tb   <= (others => '0');
      func3_tb    <= (others => '0');
      func7_tb    <= (others => '0');
      wait for 5 ns;
      rst_tb      <= '0';

      ---- ALU ----
      -- ALU return 011100 = SUB
      opcode_tb   <= C_OPCODE_OP & "11";
      func3_tb    <= C_FUNC3_ADD_SUB;
      func7_tb    <= C_FUNC7_SUB;
      wait for 5 ns;
      -- ALU return 011011 = ADD
      func7_tb    <= C_FUNC7_ADD;
      wait for 5 ns;
      -- ALU return 011101 = SLL
      func3_tb    <= C_FUNC3_SLL;
      wait for 5 ns;
      -- ALU return 100011 = OR
      func3_tb    <= C_FUNC3_OR;
      wait for 5 ns;
      -- ALU return 100010 = SRA
      func3_tb    <= C_FUNC3_SRL_SRA;
      func7_tb    <= C_FUNC7_SRA;
      wait for 5 ns;
      ---- ALU MUX ----
      -- Check if alu mux pass rs1 and rs1
      -- opcode_tb   <= C_OPCODE_OP & "11";
      ---- REG WR ----
      -- Save in GPR data
      opcode_tb      <= C_OPCODE_JALR & "11";

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
