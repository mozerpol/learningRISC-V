--------------------------------------------------------------------------------
-- File          : control_design.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Control path. This module receives the decoded instruction
-- from the decoder module (decoder_design.vhdl) and the result of a branch type
-- instruction (if, of course, the type of such an instruction is executed, from
-- module branch_instructions_design.vhdl). On this basis, it generates control
-- signals for all modules inside the core (core_design.vhdl).
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------


library ieee;
   use ieee.std_logic_1164.all;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;
library opcodes;
   use opcodes.opcodesPkg.all;


entity control is
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
      o_data_mem_mgmt_ctrl   : out std_logic_vector(3 downto 0);
      o_reg_file_inst_ctrl    : out std_logic_vector(3 downto 0);
      o_data_source_ctrl      : out std_logic_vector(1 downto 0);
      o_branch_ctrl           : out std_logic_vector(2 downto 0)
   );
end entity control;


architecture rtl of control is


begin


   p_alu : process(i_rst_n, i_opcode, i_func3, i_func7)
   begin
      if (i_rst_n = '0') then
         o_alu_control     <= (others => '0');
      else
         case i_opcode(6 downto 0) is
            when C_OPCODE_OP =>
               case i_func3 is
                  when C_FUNC3_ADD_SUB =>
                     if (i_func7 = C_FUNC7_SUB) then
                        o_alu_control <= C_SUB;
                     else
                        o_alu_control <= C_ADD;
                     end if;
                  when C_FUNC3_SLL        => o_alu_control <= C_SLL;
                  when C_FUNC3_SLT        => o_alu_control <= C_SLT;
                  when C_FUNC3_SLTU       => o_alu_control <= C_SLTU;
                  when C_FUNC3_XOR        => o_alu_control <= C_XOR;
                  when C_FUNC3_SRL_SRA    =>
                     if (i_func7 = C_FUNC7_SRA ) then
                        o_alu_control <= C_SRA;
                     else
                        o_alu_control <= C_SRL;
                     end if;
                  when C_FUNC3_OR         => o_alu_control <= C_OR;
                  when C_FUNC3_AND        => o_alu_control <= C_AND;
                  when others             => o_alu_control <= (others => '0');
               end case;
            when C_OPCODE_OPIMM =>
               case i_func3 is
                  when C_FUNC3_ADDI       => o_alu_control <= C_ADDI;
                  when C_FUNC3_SLTI       => o_alu_control <= C_SLTI;
                  when C_FUNC3_SLTIU      => o_alu_control <= C_SLTIU;
                  when C_FUNC3_XORI       => o_alu_control <= C_XORI;
                  when C_FUNC3_ORI        => o_alu_control <= C_ORI;
                  when C_FUNC3_ANDI       => o_alu_control <= C_ANDI;
                  when C_FUNC3_SLLI       => o_alu_control <= C_SLLI;
                  when C_FUNC3_SRLI_SRAI  =>
                  if (i_func7 = C_FUNC7_SRLI ) then
                     o_alu_control <= C_SRLI;
                  else
                     o_alu_control <= C_SRAI;
                  end if;
                  when others             => o_alu_control <= (others => '0');
               end case;
            when C_OPCODE_LUI    => o_alu_control  <= C_LUI;
            when C_OPCODE_AUIPC  => o_alu_control  <= C_AUIPC;
            when C_OPCODE_JAL    => o_alu_control  <= C_JAL;
            when C_OPCODE_JALR   => o_alu_control  <= C_JALR;
            when C_OPCODE_BRANCH => o_alu_control  <= C_ADD;
            when others          => o_alu_control  <= (others => '0');
         end case;
      end if;
   end process p_alu;


   p_alu_mux : process (i_rst_n, i_opcode)
   begin
      if (i_rst_n = '0') then
         o_alu_mux_1_ctrl     <= C_RS1_DATA;
         o_alu_mux_2_ctrl     <= C_RS2_DATA;
      else
         case i_opcode(6 downto 0) is
            when C_OPCODE_OP     =>
               o_alu_mux_1_ctrl     <= C_RS1_DATA;
               o_alu_mux_2_ctrl     <= C_RS2_DATA;
            when C_OPCODE_OPIMM  =>
               o_alu_mux_1_ctrl     <= C_RS1_DATA;
               o_alu_mux_2_ctrl     <= C_IMM;
            when C_OPCODE_STORE  =>
                o_alu_mux_1_ctrl     <= C_RS1_DATA;
                o_alu_mux_2_ctrl     <= C_IMM;
            when C_OPCODE_LUI    =>
               o_alu_mux_1_ctrl     <= C_RS1_DATA;
               o_alu_mux_2_ctrl     <= C_IMM;
            when C_OPCODE_AUIPC  =>
               o_alu_mux_1_ctrl     <= C_PC_ADDR;
               o_alu_mux_2_ctrl     <= C_IMM;
            when C_OPCODE_JAL    =>
                o_alu_mux_1_ctrl     <= C_PC_ADDR;
                o_alu_mux_2_ctrl     <= C_IMM;
            when C_OPCODE_JALR   =>
                o_alu_mux_1_ctrl     <= C_RS1_DATA;
                o_alu_mux_2_ctrl     <= C_IMM;
            when C_OPCODE_BRANCH =>
               o_alu_mux_1_ctrl     <= C_PC_ADDR;
               o_alu_mux_2_ctrl     <= C_IMM;
            when others =>
               o_alu_mux_1_ctrl     <= C_RS1_DATA;
               o_alu_mux_2_ctrl     <= C_RS2_DATA;
         end case;
      end if;
   end process p_alu_mux;


   p_reg_file : process(i_rst_n, i_opcode, i_func3)
   begin
      if (i_rst_n = '0') then
         o_data_source_ctrl      <= C_WRITE_RD_DATA;
         o_reg_file_inst_ctrl    <= (others => '0');
      else
         case i_opcode(6 downto 0) is
            when C_OPCODE_OPIMM  =>
               o_data_source_ctrl <= C_WRITE_ALU_RESULT;
               o_reg_file_inst_ctrl <= (others => '0');
            when C_OPCODE_OP     =>
               o_data_source_ctrl <= C_WRITE_ALU_RESULT;
               o_reg_file_inst_ctrl <= (others => '0');
            when C_OPCODE_LOAD   =>
               o_data_source_ctrl <= C_WRITE_RD_DATA;
               case i_func3 is
                  when C_FUNC3_LB   => o_reg_file_inst_ctrl <= C_LB;
                  when C_FUNC3_LH   => o_reg_file_inst_ctrl <= C_LH;
                  when C_FUNC3_LW   => o_reg_file_inst_ctrl <= C_LW;
                  when C_FUNC3_LBU  => o_reg_file_inst_ctrl <= C_LBU;
                  when C_FUNC3_LHU  => o_reg_file_inst_ctrl <= C_LHU;
                  when others       => o_reg_file_inst_ctrl <= (others => '0');
               end case;
            when C_OPCODE_STORE  =>
               o_data_source_ctrl <= C_WRITE_RD_DATA;
               case i_func3 is
                  when C_FUNC3_SB   => o_reg_file_inst_ctrl <= C_SB;
                  when C_FUNC3_SH   => o_reg_file_inst_ctrl <= C_SH;
                  when C_FUNC3_SW   => o_reg_file_inst_ctrl <= C_SW;
                  when others       => o_reg_file_inst_ctrl <= (others => '0');
               end case;
            when C_OPCODE_LUI    =>
               o_data_source_ctrl   <= C_WRITE_ALU_RESULT;
               o_reg_file_inst_ctrl <= (others => '0');
            when C_OPCODE_AUIPC  =>
               o_data_source_ctrl   <= C_WRITE_ALU_RESULT;
               o_reg_file_inst_ctrl <= (others => '0');
            when C_OPCODE_JAL    =>
               o_data_source_ctrl   <= C_WRITE_PC_ADDR;
               o_reg_file_inst_ctrl <= (others => '0');
            when C_OPCODE_JALR   =>
               o_data_source_ctrl   <= C_WRITE_PC_ADDR;
               o_reg_file_inst_ctrl <= (others => '0');
            when others          =>
               o_data_source_ctrl   <= C_WRITE_RD_DATA;
               o_reg_file_inst_ctrl <= (others => '0');
         end case;
      end if;
   end process;


   p_data_mem_mgmt : process(i_rst_n, i_opcode, i_func3)
   begin
      if (i_rst_n = '0') then
         o_data_mem_mgmt_ctrl   <= (others => '0');
      else
         if (i_opcode(6 downto 0) = C_OPCODE_LOAD) then
            case i_func3 is
               when C_FUNC3_LB   => o_data_mem_mgmt_ctrl <= C_LB;
               when C_FUNC3_LH   => o_data_mem_mgmt_ctrl <= C_LH;
               when C_FUNC3_LW   => o_data_mem_mgmt_ctrl <= C_LW;
               when C_FUNC3_LBU  => o_data_mem_mgmt_ctrl <= C_LBU;
               when C_FUNC3_LHU  => o_data_mem_mgmt_ctrl <= C_LHU;
               when others       => o_data_mem_mgmt_ctrl <= (others => '0');
            end case;
         elsif (i_opcode(6 downto 0) = C_OPCODE_STORE) then
            case i_func3 is
               when C_FUNC3_SB   => o_data_mem_mgmt_ctrl <= C_SB;
               when C_FUNC3_SH   => o_data_mem_mgmt_ctrl <= C_SH;
               when C_FUNC3_SW   => o_data_mem_mgmt_ctrl <= C_SW;
               when others       => o_data_mem_mgmt_ctrl <= (others => '0');
            end case;
         else
            o_data_mem_mgmt_ctrl <= (others => '0');
         end if;
      end if;
   end process p_data_mem_mgmt;


   p_program_counter : process(i_rst_n, i_opcode, i_branch_result)
   begin
      if (i_rst_n = '0') then
         o_pc_ctrl         <= C_NOP;
         o_inst_addr_ctrl  <= C_INST_ADDR_PC;
      else
         case i_opcode(6 downto 0) is
            when C_OPCODE_LOAD =>
               o_pc_ctrl         <= C_INCREMENT_PC;
               o_inst_addr_ctrl  <= C_INST_ADDR_PC;
            when C_OPCODE_JAL    =>
               o_pc_ctrl         <= C_LOAD_ALU_RESULT;
               o_inst_addr_ctrl  <= C_INST_ADDR_ALU;
            when C_OPCODE_JALR   =>
               o_pc_ctrl         <= C_LOAD_ALU_RESULT;
               o_inst_addr_ctrl  <= C_INST_ADDR_ALU;
            when C_OPCODE_BRANCH =>
               if (i_branch_result = C_TAKEN) then
                  o_pc_ctrl         <= C_LOAD_ALU_RESULT;
                  o_inst_addr_ctrl  <= C_INST_ADDR_ALU;
               else -- C_NOT_TAKEN
                  o_pc_ctrl         <= C_INCREMENT_PC;
                  o_inst_addr_ctrl  <= C_INST_ADDR_PC;
               end if;
            when C_OPCODE_ZEROS  =>
                  o_inst_addr_ctrl  <= C_INST_ADDR_PC;
                  o_pc_ctrl         <= C_NOP;
            when others          =>
               o_pc_ctrl         <= C_INCREMENT_PC;
               o_inst_addr_ctrl  <= C_INST_ADDR_PC;
            end case;
      end if;
   end process p_program_counter;


   p_branch_instructions : process(i_rst_n, i_opcode, i_func3)
   begin
      if (i_rst_n = '0') then
         o_branch_ctrl <= (others => '0');
      else
         if (i_opcode(6 downto 0) = C_OPCODE_BRANCH) then
            case i_func3 is
               when C_FUNC3_BEQ  => o_branch_ctrl <= C_BEQ;
               when C_FUNC3_BNE  => o_branch_ctrl <= C_BNE;
               when C_FUNC3_BLT  => o_branch_ctrl <= C_BLT;
               when C_FUNC3_BGE  => o_branch_ctrl <= C_BGE;
               when C_FUNC3_BLTU => o_branch_ctrl <= C_BLTU;
               when C_FUNC3_BGEU => o_branch_ctrl <= C_BGEU;
               when others       => o_branch_ctrl <= (others => '0');
            end case;
         else
            o_branch_ctrl <= (others => '0');
         end if;
      end if;
   end process p_branch_instructions;


end architecture rtl;
