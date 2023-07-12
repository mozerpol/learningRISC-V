library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library main_lib;
   use main_lib.all;
   use main_lib.main_pkg.all;

entity main is
   port (
      i_rst          : in std_logic;
      i_clk          : in std_logic;
      i_wr_data      : in std_logic_vector(31 downto 0);
      i_wr_enable    : in std_logic;
      o_rd_data      : out std_logic_vector(31 downto 0)
   );
end entity main;

architecture rtl of main is


   component memory is
      port (
         i_rst       : in std_logic;
         i_clk       : in std_logic;
         i_rd_addr   : in std_logic_vector(7 downto 0);
         i_wr_addr   : in std_logic_vector(7 downto 0);
         i_wr_data   : in std_logic_vector(31 downto 0);
         i_wr_enable : in std_logic;
         o_q         : out std_logic_vector(31 downto 0)
      );
   end component memory;

   component alu is
      port (
         i_rst             : in std_logic;
         i_alu_operand_1   : in std_logic_vector(31 downto 0);
         i_alu_operand_2   : in std_logic_vector(31 downto 0);
         i_control         : in std_logic_vector(5 downto 0);
         o_alu_out         : out std_logic_vector(31 downto 0)
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
         o_control_alu     : out std_logic_vector(5 downto 0);
         o_reg_wr_ctrl     : out std_logic
      );
   end component control;

   component decoder is
      port (
         i_rst          : in std_logic;
         i_instruction  : in std_logic_vector(31 downto 0);
         o_rd_data      : out std_logic_vector(4 downto 0);
         o_rs1_data     : out std_logic_vector(4 downto 0);
         o_rs2_data     : out std_logic_vector(4 downto 0);
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
         i_alu_out      : in std_logic_vector(31 downto 0);
         o_rs1_data     : out std_logic_vector(31 downto 0);
         o_rs2_data     : out std_logic_vector(31 downto 0)
      );
   end component reg_file;

   signal rst              : std_logic;
   signal clk              : std_logic;
   signal rd_addr          : std_logic_vector(7 downto 0);
   signal wr_addr          : std_logic_vector(7 downto 0);
   signal wr_data          : std_logic_vector(31 downto 0);
   signal wr_enable        : std_logic;
   signal q                : std_logic_vector(31 downto 0);
   signal alu_operand_1    : std_logic_vector(31 downto 0);
   signal alu_operand_2    : std_logic_vector(31 downto 0);
   signal alu_out          : std_logic_vector(31 downto 0);
   signal alu_mux_1_ctrl   : std_logic;
   signal rs1_data         : std_logic_vector(31 downto 0);
   signal pc_addr          : std_logic_vector(31 downto 0);
   signal alu_mux_2_ctrl   : std_logic;
   signal rs2_data         : std_logic_vector(31 downto 0);
   signal imm              : std_logic_vector(31 downto 0);
   signal opcode           : std_logic_vector(6 downto 0);
   signal control_alu      : std_logic_vector(5 downto 0);
   signal instruction      : std_logic_vector(31 downto 0);
   signal rd_data          : std_logic_vector(4 downto 0);
   signal func3            : std_logic_vector(2 downto 0);
   signal func7            : std_logic_vector(6 downto 0);
   signal rs1_addr         : std_logic_vector(4 downto 0);
   signal rs2_addr         : std_logic_vector(4 downto 0);
   signal reg_wr_ctrl      : std_logic;

begin

   p_main : process(all)
   begin
      if (i_rst) then
      -- elsif (clk'event and clk = '1') then
      end if;
   end process p_main;

end architecture rtl;
