library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library main_lib;
   use main_lib.all;
   use main_lib.main_pkg.all;
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
   
   
entity main is
   port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_instruction        : in std_logic_vector(31 downto 0);
      o_ram_read_data      : out std_logic_vector(31 downto 0);
      o_ram_write_data     : out std_logic_vector(31 downto 0);
      o_ram_read_addr      : out std_logic_vector(7 downto 0);
      o_ram_write_addr     : out std_logic_vector(7 downto 0);
      o_ram_write_enable   : out std_logic
   );
end entity main;

architecture rtl of main is


   component memory is
      port (
         i_rst                : in std_logic;
         i_clk                : in std_logic;
         i_ram_read_addr      : in std_logic_vector(7 downto 0);
         i_ram_write_addr     : in std_logic_vector(7 downto 0);
         i_ram_write_data     : in std_logic_vector(31 downto 0);
         i_ram_write_enable   : in std_logic;
         o_instruction        : out std_logic_vector(31 downto 0)
      );
   end component memory;

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
         i_rs1_data        : in std_logic_vector(31 downto 0); -- From reg_file
         i_pc_addr         : in std_logic_vector(31 downto 0);
         o_alu_operand_1   : out std_logic_vector(31 downto 0)
      );
   end component alu_mux_1;

   component alu_mux_2 is
      port (
         i_rst             : in std_logic;
         i_alu_mux_2_ctrl  : in std_logic;
         i_rs2_data        : in std_logic_vector(31 downto 0); -- From reg_file
         i_imm             : in std_logic_vector(31 downto 0);
         o_alu_operand_2   : out std_logic_vector(31 downto 0)
      );
   end component alu_mux_2;

   component control is
      port (
         i_rst             : in std_logic;
         i_opcode          : in std_logic_vector(6 downto 0);
         i_func3           : in std_logic_vector(2 downto 0);
         i_func7           : in std_logic_vector(6 downto 0);
         o_alu_mux_1_ctrl  : out std_logic;
         o_alu_mux_2_ctrl  : out std_logic;
         o_alu_control     : out std_logic_vector(5 downto 0);
         o_reg_wr_ctrl     : out std_logic
      );
   end component control;

   component decoder is
      port (
         i_rst          : in std_logic;
         i_instruction  : in std_logic_vector(31 downto 0);
         o_rd_addr      : out std_logic_vector(4 downto 0);
         o_rs1_addr     : out std_logic_vector(4 downto 0);
         o_rs2_addr     : out std_logic_vector(4 downto 0);
         o_imm          : out std_logic_vector(31 downto 0);
         o_opcode       : out std_logic_vector(6 downto 0);
         o_func3        : out std_logic_vector(2 downto 0);
         o_func7        : out std_logic_vector(6 downto 0)
      );
   end component decoder;

   component reg_file is
      port (
         i_rst          : in std_logic;
         i_clk          : in std_logic;
         i_rs1_addr     : in std_logic_vector(4 downto 0); -- address of rs1
         i_rs2_addr     : in std_logic_vector(4 downto 0); -- address of rs2
         i_rd_addr      : in std_logic_vector(4 downto 0);
         i_reg_wr_ctrl  : in std_logic;
         i_alu_result   : in std_logic_vector(31 downto 0);
         o_rs1_data     : out std_logic_vector(31 downto 0);
         o_rs2_data     : out std_logic_vector(31 downto 0)
      );
   end component reg_file;

   signal rst              : std_logic;
   signal clk              : std_logic;
   signal ram_read_addr    : std_logic_vector(7 downto 0);
   signal ram_write_addr   : std_logic_vector(7 downto 0);
   signal ram_write_data   : std_logic_vector(31 downto 0);
   signal ram_write_enable : std_logic;
   signal alu_operand_1    : std_logic_vector(31 downto 0);
   signal alu_operand_2    : std_logic_vector(31 downto 0);
   signal alu_result       : std_logic_vector(31 downto 0);
   signal alu_control      : std_logic_vector(5 downto 0);
   signal alu_mux_1_ctrl   : std_logic;
   signal rs1_data         : std_logic_vector(31 downto 0);
   signal pc_addr          : std_logic_vector(31 downto 0);
   signal alu_mux_2_ctrl   : std_logic;
   signal rs2_data         : std_logic_vector(31 downto 0);
   signal imm              : std_logic_vector(31 downto 0);
   signal opcode           : std_logic_vector(6 downto 0);
   signal instruction      : std_logic_vector(31 downto 0);
   signal rd_data          : std_logic_vector(4 downto 0);
   signal func3            : std_logic_vector(2 downto 0);
   signal func7            : std_logic_vector(6 downto 0);
   signal rs1_addr         : std_logic_vector(4 downto 0);
   signal rs2_addr         : std_logic_vector(4 downto 0);
   signal rd_addr          : std_logic_vector(4 downto 0);
   signal reg_wr_ctrl      : std_logic;

begin

   inst_memory : component memory
   port map (
      i_rst                => rst,
      i_clk                => clk,
      i_ram_read_addr      => ram_read_addr,
      i_ram_write_addr     => ram_write_addr,
      i_ram_write_data     => ram_write_data,
      i_ram_write_enable   => ram_write_enable,
      o_instruction        => instruction
   );

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

   inst_control : component control
   port map (
      i_rst             => rst,
      i_opcode          => opcode,
      i_func3           => func3,
      i_func7           => func7,
      o_alu_mux_1_ctrl  => alu_mux_1_ctrl,
      o_alu_mux_2_ctrl  => alu_mux_2_ctrl,
      o_alu_control     => alu_control,
      o_reg_wr_ctrl     => reg_wr_ctrl
   );

   inst_decoder : component decoder
   port map (
      i_rst          => rst,
      i_instruction  => instruction,
      o_rd_addr      => rd_addr,
      o_rs1_addr     => rs1_addr,
      o_rs2_addr     => rs2_addr,
      o_imm          => imm,
      o_opcode       => opcode,
      o_func3        => func3,
      o_func7        => func7
   );
   
   inst_reg_file : component reg_file
   port map (
      i_rst          => rst,
      i_clk          => clk,
      i_rs1_addr     => rs1_addr,
      i_rs2_addr     => rs2_addr,
      i_rd_addr      => rd_addr,
      i_reg_wr_ctrl  => reg_wr_ctrl,
      i_alu_result   => alu_result,
      o_rs1_data     => rs1_data,
      o_rs2_data     => rs2_data
   ); 

   p_main : process(all)
   begin
      if (i_rst) then
         o_ram_read_data      <= (others => '0');
         o_ram_write_data     <= (others => '0');
         o_ram_read_addr      <= (others => '0');
         o_ram_write_addr     <= (others => '0');
         o_ram_write_enable   <= '0';
      -- elsif (clk'event and clk = '1') then
      end if;
   end process p_main;

end architecture rtl;
