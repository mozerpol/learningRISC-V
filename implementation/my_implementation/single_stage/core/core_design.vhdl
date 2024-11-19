--------------------------------------------------------------------------------
-- File          : core_design.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : It integrates all internal modules e.g. ALU, MUX1, MUX2,
-- program counter, control, etc. connecting them together. This module can be
-- connected to external modules such as RAM or GPIO (connecting takes place
-- inside riscpol_design).
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
library opcodes;
   use opcodes.opcodesPkg.all;
library alu_lib;
library alu_mux_1_lib;
library alu_mux_2_lib;
library branch_instructions_lib;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;
library decoder_lib;
library instruction_memory_lib;
library program_counter_lib;
library ram_management_lib;
library register_file_lib;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;


entity core is
   port (
      i_rst_n                    : in std_logic;
      i_clk                      : in std_logic;
      i_core_data_read           : in std_logic_vector(31 downto 0);
      o_core_data_write          : out std_logic_vector(31 downto 0);
      o_core_write_enable        : out std_logic;
      o_core_byte_enable         : out std_logic_vector(3 downto 0);
      o_core_addr_read           : out integer range 0 to C_RAM_LENGTH-1;
      o_core_addr_write          : out integer range 0 to C_RAM_LENGTH-1
   );
end entity core;


architecture rtl of core is


   component alu is
      port (
         i_alu_operand_1         : in std_logic_vector(31 downto 0);
         i_alu_operand_2         : in std_logic_vector(31 downto 0);
         i_alu_control           : in std_logic_vector(4 downto 0);
         o_alu_result            : out std_logic_vector(31 downto 0)
      );
   end component alu;

   component alu_mux_1 is
      port (
         i_alu_mux_1_ctrl        : in std_logic;
         i_rs1_data              : in std_logic_vector(31 downto 0);
         i_pc_addr               : in std_logic_vector(31 downto 0);
         o_alu_operand_1         : out std_logic_vector(31 downto 0)
      );
   end component alu_mux_1;

   component alu_mux_2 is
      port (
         i_alu_mux_2_ctrl        : in std_logic;
         i_rs2_data              : in std_logic_vector(31 downto 0);
         i_imm                   : in std_logic_vector(31 downto 0);
         o_alu_operand_2         : out std_logic_vector(31 downto 0)
      );
   end component alu_mux_2;

   component branch_instructions is
      port (
         i_branch_ctrl           : in std_logic_vector(2 downto 0);
         i_rs1_data              : in std_logic_vector(31 downto 0);
         i_rs2_data              : in std_logic_vector(31 downto 0);
         o_branch_result         : out std_logic
      );
   end component branch_instructions;

   component control is
      port (
         i_rst_n                 : in std_logic;
         i_opcode                : in std_logic_vector(6 downto 0);
         i_func3                 : in std_logic_vector(2 downto 0);
         i_func7                 : in std_logic_vector(6 downto 0);
         i_branch_result         : in std_logic;
         o_alu_mux_1_ctrl        : out std_logic;
         o_alu_mux_2_ctrl        : out std_logic;
         o_pc_ctrl               : out std_logic_vector(1 downto 0);
         o_inst_addr_ctrl        : out std_logic;
         o_alu_control           : out std_logic_vector(4 downto 0);
         o_reg_file_inst_ctrl    : out std_logic_vector(1 downto 0);
         o_ram_management_ctrl   : out std_logic_vector(3 downto 0);
         o_branch_ctrl           : out std_logic_vector(2 downto 0)
      );
   end component control;

   component decoder is
      port (
         i_instruction           : in std_logic_vector(31 downto 0);
         o_rd_addr               : out std_logic_vector(4 downto 0);
         o_rs1_addr              : out std_logic_vector(4 downto 0);
         o_rs2_addr              : out std_logic_vector(4 downto 0);
         o_imm                   : out std_logic_vector(31 downto 0);
         o_opcode                : out std_logic_vector(6 downto 0);
         o_func3                 : out std_logic_vector(2 downto 0);
         o_func7                 : out std_logic_vector(6 downto 0)
      );
   end component decoder;

   component reg_file is
      port (
         i_clk                   : in std_logic;
         i_rs1_addr              : in std_logic_vector(4 downto 0);
         i_rs2_addr              : in std_logic_vector(4 downto 0);
         i_rd_addr               : in std_logic_vector(4 downto 0);
         i_reg_file_inst_ctrl    : in std_logic_vector(1 downto 0);
         i_rd_data               : in std_logic_vector(31 downto 0);
         i_alu_result            : in std_logic_vector(31 downto 0);
         i_pc_addr               : in std_logic_vector(31 downto 0);
         o_rs1_data              : out std_logic_vector(31 downto 0);
         o_rs2_data              : out std_logic_vector(31 downto 0)
      );
   end component reg_file;

   component ram_management is
      port (
         i_rst_n                 : in std_logic;
         i_ram_management_ctrl   : in std_logic_vector(3 downto 0);
         i_rs1_data              : in std_logic_vector(31 downto 0);
         i_rs2_data              : in std_logic_vector(31 downto 0);
         i_imm                   : in std_logic_vector(31 downto 0);
         i_data_from_ram         : in std_logic_vector(31 downto 0);
         o_rd_data               : out std_logic_vector(31 downto 0);
         o_write_enable          : out  std_logic;
         o_byte_enable           : out  std_logic_vector (3 downto 0);
         o_raddr                 : out  integer range 0 to C_RAM_LENGTH-1;
         o_waddr                 : out  integer range 0 to C_RAM_LENGTH-1;
         o_data                  : out  std_logic_vector(31 downto 0)
      );
   end component ram_management;

   component program_counter is
      port (
         i_rst_n                 : in std_logic;
         i_clk                   : in std_logic;
         i_alu_result            : in std_logic_vector(31 downto 0);
         i_inst_addr_ctrl        : in std_logic;
         i_pc_ctrl               : in std_logic_vector(1 downto 0);
         o_instruction_addr      : out std_logic_vector(31 downto 0);
         o_pc_addr               : out std_logic_vector(31 downto 0)
      );
   end component program_counter;

   component instruction_memory is
      port (
         i_rst_n                 : in std_logic;
         i_clk                   : in std_logic;
         i_instruction_addr      : in std_logic_vector(31 downto 0);
         o_instruction           : out std_logic_vector(31 downto 0)
      );
   end component;


   signal rst_n                  : std_logic;
   signal clk                    : std_logic;
   signal alu_operand_1          : std_logic_vector(31 downto 0);
   signal alu_operand_2          : std_logic_vector(31 downto 0);
   signal alu_result             : std_logic_vector(31 downto 0);
   signal alu_control            : std_logic_vector(4 downto 0);
   signal inst_addr_ctrl         : std_logic;
   signal alu_mux_1_ctrl         : std_logic;
   signal rs1_data               : std_logic_vector(31 downto 0);
   signal pc_addr                : std_logic_vector(31 downto 0);
   signal alu_mux_2_ctrl         : std_logic;
   signal rs2_data               : std_logic_vector(31 downto 0);
   signal imm                    : std_logic_vector(31 downto 0);
   signal branch_ctrl            : std_logic_vector(2 downto 0);
   signal branch_result          : std_logic;
   signal instruction_addr       : std_logic_vector(31 downto 0);
   signal opcode                 : std_logic_vector(6 downto 0);
   signal instruction            : std_logic_vector(31 downto 0);
   signal rd_data                : std_logic_vector(31 downto 0);
   signal func3                  : std_logic_vector(2 downto 0);
   signal func7                  : std_logic_vector(6 downto 0);
   signal rs1_addr               : std_logic_vector(4 downto 0);
   signal rs2_addr               : std_logic_vector(4 downto 0);
   signal rd_addr                : std_logic_vector(4 downto 0);
   signal pc_ctrl                : std_logic_vector(1 downto 0);
   signal reg_file_inst_ctrl     : std_logic_vector(1 downto 0);
   signal ram_management_ctrl    : std_logic_vector(3 downto 0);
   signal data_from_ram          : std_logic_vector(31 downto 0);

begin

   inst_alu : component alu
   port map (
      i_alu_operand_1         => alu_operand_1,
      i_alu_operand_2         => alu_operand_2,
      i_alu_control           => alu_control,
      o_alu_result            => alu_result
   );

   inst_alu_mux_1 : component alu_mux_1
   port map (
      i_alu_mux_1_ctrl        => alu_mux_1_ctrl,
      i_rs1_data              => rs1_data,
      i_pc_addr               => pc_addr,
      o_alu_operand_1         => alu_operand_1
   );

   inst_alu_mux_2 : component alu_mux_2
   port map (
      i_alu_mux_2_ctrl        => alu_mux_2_ctrl,
      i_rs2_data              => rs2_data,
      i_imm                   => imm,
      o_alu_operand_2         => alu_operand_2
   );

   inst_branch_instructions : component branch_instructions
   port map (
      i_branch_ctrl           => branch_ctrl,
      i_rs1_data              => rs1_data,
      i_rs2_data              => rs2_data,
      o_branch_result         => branch_result
   );

   inst_control : component control
   port map (
      i_rst_n                 => rst_n,
      i_opcode                => opcode,
      i_func3                 => func3,
      i_func7                 => func7,
      i_branch_result         => branch_result,
      o_alu_mux_1_ctrl        => alu_mux_1_ctrl,
      o_alu_mux_2_ctrl        => alu_mux_2_ctrl,
      o_pc_ctrl               => pc_ctrl,
      o_inst_addr_ctrl        => inst_addr_ctrl,
      o_alu_control           => alu_control,
      o_reg_file_inst_ctrl    => reg_file_inst_ctrl,
      o_ram_management_ctrl   => ram_management_ctrl,
      o_branch_ctrl           => branch_ctrl
   );

   inst_decoder : component decoder
   port map (
      i_instruction           => instruction,
      o_rd_addr               => rd_addr,
      o_rs1_addr              => rs1_addr,
      o_rs2_addr              => rs2_addr,
      o_imm                   => imm,
      o_opcode                => opcode,
      o_func3                 => func3,
      o_func7                 => func7
   );

   inst_reg_file : component reg_file
   port map (
      i_clk                   => clk,
      i_rs1_addr              => rs1_addr,
      i_rs2_addr              => rs2_addr,
      i_rd_addr               => rd_addr,
      i_reg_file_inst_ctrl    => reg_file_inst_ctrl,
      i_rd_data               => rd_data,
      i_alu_result            => alu_result,
      i_pc_addr               => pc_addr,
      o_rs1_data              => rs1_data,
      o_rs2_data              => rs2_data
   );

   inst_ram_management : component ram_management
   port map (
      i_rst_n                 => rst_n,
      i_ram_management_ctrl   => ram_management_ctrl,
      i_rs1_data              => rs1_data,
      i_rs2_data              => rs2_data,
      i_imm                   => imm,
      i_data_from_ram         => data_from_ram,
      o_rd_data               => rd_data,
      o_write_enable          => o_core_write_enable,
      o_byte_enable           => o_core_byte_enable,
      o_raddr                 => o_core_addr_read,
      o_waddr                 => o_core_addr_write,
      o_data                  => o_core_data_write
   );

   inst_program_counter : component program_counter
   port map (
      i_rst_n                 => rst_n,
      i_clk                   => clk,
      i_alu_result            => alu_result,
      i_pc_ctrl               => pc_ctrl,
      i_inst_addr_ctrl        => inst_addr_ctrl,
      o_instruction_addr      => instruction_addr,
      o_pc_addr               => pc_addr
   );

   inst_instruction_memory : component instruction_memory
   port map (
      i_rst_n                 => rst_n,
      i_clk                   => clk,
      i_instruction_addr      => instruction_addr,
      o_instruction           => instruction
   );

   rst_n          <= i_rst_n;
   clk            <= i_clk;
   data_from_ram  <= i_core_data_read;

end architecture rtl;
