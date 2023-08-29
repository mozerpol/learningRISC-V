library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library core_lib;
   use core_lib.all;
   use core_lib.core_pkg.all;
library opcodes;
   use opcodes.opcodesPkg.all;
library alu_lib;
   use alu_lib.all;
   use alu_lib.alu_pkg.all;
library alu_mux_1_lib;
   use alu_mux_1_lib.all;
   use alu_mux_1_lib.alu_mux_1_pkg.all;
library alu_mux_2_lib;
   use alu_mux_2_lib.all;
   use alu_mux_2_lib.alu_mux_2_pkg.all;
library branch_instructions_lib;
   use branch_instructions_lib.all;
   use branch_instructions_lib.branch_instructions_pkg.all;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;
library decoder_lib;
   use decoder_lib.all;
   use decoder_lib.decoder_pkg.all;
library instruction_memory_lib;
   use instruction_memory_lib.all;
   use instruction_memory_lib.instruction_memory_pkg.all;
library program_counter_lib;
   use program_counter_lib.all;
   use program_counter_lib.program_counter_pkg.all;
library ram_management_lib;
   use ram_management_lib.all;
   use ram_management_lib.ram_management_pkg.all;
library reg_file_lib;
   use reg_file_lib.all;
   use reg_file_lib.reg_file_pkg.all;


entity core is
   port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_ram_data_read      : in std_logic_vector(31 downto 0);
      o_ram_data_write     : out std_logic_vector(31 downto 0);
      o_ram_addr           : out std_logic_vector(7 downto 0);
      o_byte_number        : out std_logic_vector(3 downto 0);
      o_write_enable       : out std_logic
   );
end entity core;

architecture rtl of core is


   component alu is
      port (
         i_rst             : in std_logic;
         i_alu_operand_1   : in std_logic_vector(31 downto 0);
         i_alu_operand_2   : in std_logic_vector(31 downto 0);
         i_alu_control     : in std_logic_vector(5 downto 0);
         o_alu_result      : out std_logic_vector(31 downto 0)
      );
   end component alu;

   component alu_mux_1 is
      port (
         i_rst             : in std_logic;
         i_alu_mux_1_ctrl  : in std_logic;
         i_rs1_data        : in std_logic_vector(31 downto 0);
         i_pc_addr         : in std_logic_vector(31 downto 0);
         o_alu_operand_1   : out std_logic_vector(31 downto 0)
      );
   end component alu_mux_1;

   component alu_mux_2 is
      port (
         i_rst             : in std_logic;
         i_alu_mux_2_ctrl  : in std_logic;
         i_rs2_data        : in std_logic_vector(31 downto 0);
         i_imm             : in std_logic_vector(31 downto 0);
         o_alu_operand_2   : out std_logic_vector(31 downto 0)
      );
   end component alu_mux_2;

   component branch_instructions is
      port (
         i_rst             : in std_logic;
         i_branch_ctrl     : in std_logic_vector(2 downto 0);
         i_rs1_data        : in std_logic_vector(31 downto 0);
         i_rs2_data        : in std_logic_vector(31 downto 0);
         o_branch_result   : out std_logic
      );
   end component branch_instructions;

   component control is
      port (
         i_rst                   : in std_logic;
         i_opcode                : in std_logic_vector(6 downto 0);
         i_func3                 : in std_logic_vector(2 downto 0);
         i_func7                 : in std_logic_vector(6 downto 0);
         i_branch_result         : in std_logic;
         o_alu_mux_1_ctrl        : out std_logic;
         o_alu_mux_2_ctrl        : out std_logic;
         o_pc_ctrl               : out std_logic_vector(1 downto 0);
         o_alu_control           : out std_logic_vector(5 downto 0);
         o_reg_file_wr_ctrl      : out std_logic;
         o_load_inst_ctrl        : out std_logic;
         o_reg_file_inst_ctrl    : out std_logic_vector(1 downto 0);
         o_ram_management_ctrl   : out std_logic_vector(2 downto 0);
         o_load_instruction      : out std_logic_vector(2 downto 0);
         o_branch_ctrl           : out std_logic_vector(2 downto 0)
      );
   end component control;

   component decoder is
      port (
         i_rst             : in std_logic;
         i_instruction     : in std_logic_vector(31 downto 0);
         o_rd_addr         : out std_logic_vector(4 downto 0);
         o_rs1_addr        : out std_logic_vector(4 downto 0);
         o_rs2_addr        : out std_logic_vector(4 downto 0);
         o_imm             : out std_logic_vector(31 downto 0);
         o_opcode          : out std_logic_vector(6 downto 0);
         o_func3           : out std_logic_vector(2 downto 0);
         o_func7           : out std_logic_vector(6 downto 0)
      );
   end component decoder;

   component reg_file is
      port (
         i_rst                : in std_logic;
         i_clk                : in std_logic;
         i_rs1_addr           : in std_logic_vector(4 downto 0);
         i_rs2_addr           : in std_logic_vector(4 downto 0);
         i_rd_addr            : in std_logic_vector(4 downto 0);
         i_reg_file_wr_ctrl   : in std_logic;
         i_reg_file_inst_ctrl : in std_logic_vector(1 downto 0);
         i_rd_data            : in std_logic_vector(31 downto 0);
         i_alu_result         : in std_logic_vector(31 downto 0);
         i_pc_addr            : in std_logic_vector(31 downto 0);
         i_load_instruction   : in std_logic_vector(2 downto 0);
         o_rs1_data           : out std_logic_vector(31 downto 0);
         o_rs2_data           : out std_logic_vector(31 downto 0)
      );
   end component reg_file;

   component ram_management is
      port (
      i_rst                   : in std_logic;
      i_ram_management_ctrl   : in std_logic_vector(2 downto 0);
      i_rs1_data              : in std_logic_vector(31 downto 0);
      i_rs2_data              : in std_logic_vector(31 downto 0);
      i_imm                   : in std_logic_vector(31 downto 0);
      i_load_inst_ctrl        : in std_logic;
      o_ram_addr              : out std_logic_vector(7 downto 0);
      o_write_enable          : out std_logic;
      o_byte_number           : out std_logic_vector(3 downto 0);
      o_data                  : out std_logic_vector(31 downto 0)
      );
   end component ram_management;

   component program_counter is
      port (
         i_rst          : in std_logic;
         i_clk          : in std_logic;
         i_alu_result   : in std_logic_vector(31 downto 0);
         i_pc_ctrl      : in std_logic_vector(1 downto 0);
         o_pc_addr      : out std_logic_vector(31 downto 0)
      );
   end component program_counter;

   component instruction_memory is
      port (
         i_rst             : in std_logic;
         i_ram_read_addr   : in std_logic_vector(31 downto 0);
         o_instruction     : out std_logic_vector(31 downto 0)
      );
   end component;


   signal rst                 : std_logic;
   signal clk                 : std_logic;
   signal alu_operand_1       : std_logic_vector(31 downto 0);
   signal alu_operand_2       : std_logic_vector(31 downto 0);
   signal alu_result          : std_logic_vector(31 downto 0);
   signal alu_control         : std_logic_vector(5 downto 0);
   signal alu_mux_1_ctrl      : std_logic;
   signal rs1_data            : std_logic_vector(31 downto 0);
   signal pc_addr             : std_logic_vector(31 downto 0);
   signal alu_mux_2_ctrl      : std_logic;
   signal rs2_data            : std_logic_vector(31 downto 0);
   signal imm                 : std_logic_vector(31 downto 0);
   signal branch_ctrl         : std_logic_vector(2 downto 0);
   signal branch_result       : std_logic;   
   signal opcode              : std_logic_vector(6 downto 0);
   signal instruction         : std_logic_vector(31 downto 0);
   signal instruction_write   : std_logic_vector(31 downto 0);
   signal rd_data             : std_logic_vector(31 downto 0);
   signal func3               : std_logic_vector(2 downto 0);
   signal func7               : std_logic_vector(6 downto 0);
   signal rs1_addr            : std_logic_vector(4 downto 0);
   signal rs2_addr            : std_logic_vector(4 downto 0);
   signal rd_addr             : std_logic_vector(4 downto 0);
   signal ram_wr_ctrl         : std_logic;
   signal addr_read           : std_logic_vector(7 downto 0);
   signal addr_write          : std_logic_vector(7 downto 0);
   signal read_addr           : std_logic_vector(7 downto 0);
   signal write_addr          : std_logic_vector(7 downto 0);
   signal ram_write_data      : std_logic_vector(31 downto 0);
   signal write_data          : std_logic_vector(31 downto 0);
   signal pc_ctrl             : std_logic_vector(1 downto 0);
   signal reg_file_wr_ctrl    : std_logic;
   signal reg_file_inst_ctrl  : std_logic_vector(1 downto 0);
   signal ram_management_ctrl : std_logic_vector(2 downto 0);
   signal load_instruction    : std_logic_vector(2 downto 0);
   signal load_inst_ctrl      : std_logic;

begin

   inst_alu : component alu
   port map (
      i_rst             => rst,
      i_alu_operand_1   => alu_operand_1,
      i_alu_operand_2   => alu_operand_2,
      i_alu_control     => alu_control,
      o_alu_result      => alu_result
   );

   inst_alu_mux_1 : component alu_mux_1
   port map (
      i_rst             => rst,
      i_alu_mux_1_ctrl  => alu_mux_1_ctrl,
      i_rs1_data        => rs1_data,
      i_pc_addr         => pc_addr,
      o_alu_operand_1   => alu_operand_1
   );

   inst_alu_mux_2 : component alu_mux_2
   port map (
      i_rst             => rst,
      i_alu_mux_2_ctrl  => alu_mux_2_ctrl,
      i_rs2_data        => rs2_data,
      i_imm             => imm,
      o_alu_operand_2   => alu_operand_2
   );
   
   inst_branch_instructions : component branch_instructions
   port map (
      i_rst             => rst,
      i_branch_ctrl     => branch_ctrl,
      i_rs1_data        => rs1_data,
      i_rs2_data        => rs2_data,
      o_branch_result   => branch_result
   );

   inst_control : component control
   port map (
      i_rst                   => rst,
      i_opcode                => opcode,
      i_func3                 => func3,
      i_func7                 => func7,
      i_branch_result         => branch_result,
      o_alu_mux_1_ctrl        => alu_mux_1_ctrl,
      o_alu_mux_2_ctrl        => alu_mux_2_ctrl,
      o_pc_ctrl               => pc_ctrl,
      o_alu_control           => alu_control,
      o_reg_file_inst_ctrl    => reg_file_inst_ctrl,
      o_reg_file_wr_ctrl      => reg_file_wr_ctrl,
      o_ram_management_ctrl   => ram_management_ctrl,
      o_load_inst_ctrl        => load_inst_ctrl,
      o_load_instruction      => load_instruction,
      o_branch_ctrl           => branch_ctrl
   );

   inst_decoder : component decoder
   port map (
      i_rst             => rst,
      i_instruction     => instruction,
      o_rd_addr         => rd_addr,
      o_rs1_addr        => rs1_addr,
      o_rs2_addr        => rs2_addr,
      o_imm             => imm,
      o_opcode          => opcode,
      o_func3           => func3,
      o_func7           => func7
   );

   inst_reg_file : component reg_file
   port map (
      i_rst                => rst,
      i_clk                => clk,
      i_rs1_addr           => rs1_addr,
      i_rs2_addr           => rs2_addr,
      i_rd_addr            => rd_addr,
      i_reg_file_wr_ctrl   => reg_file_wr_ctrl,
      i_reg_file_inst_ctrl => reg_file_inst_ctrl,
      i_rd_data            => rd_data,
      i_alu_result         => alu_result,
      i_pc_addr            => pc_addr,
      i_load_instruction   => load_instruction,
      o_rs1_data           => rs1_data,
      o_rs2_data           => rs2_data
   );

   inst_ram_management : component ram_management
   port map (
      i_rst                   => rst,
      i_ram_management_ctrl   => ram_management_ctrl,
      i_rs1_data              => rs1_data,
      i_rs2_data              => rs2_data,
      i_imm                   => imm,
      i_load_inst_ctrl        => load_inst_ctrl,
      o_ram_addr              => o_ram_addr,
      o_write_enable          => o_write_enable,
      o_byte_number           => o_byte_number,
      o_data                  => o_ram_data_write
   );

   inst_program_counter : component program_counter
   port map (
      i_rst             => rst,
      i_clk             => clk,
      i_alu_result      => alu_result,
      i_pc_ctrl         => pc_ctrl,
      o_pc_addr         => pc_addr
   );

   inst_instruction_memory : component instruction_memory
   port map (
      i_rst             => rst,
      i_ram_read_addr   => pc_addr,
      o_instruction     => instruction
   );


   rst      <= i_rst;
   clk      <= i_clk;
   rd_data  <= i_ram_data_read;


   p_core : process(all)
   begin
      if (i_rst = '1') then

      elsif (clk'event and clk = '1') then

      end if;
   end process p_core;

end architecture rtl;
