library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;
library opcodes;
   use opcodes.opcodesPkg.all;
library alu_lib;
   use alu_lib.alu_pkg.all;


entity control is
   port (
      i_rst                   : in std_logic;
      i_opcode                : in std_logic_vector(6 downto 0);
      i_func3                 : in std_logic_vector(2 downto 0);
      i_func7                 : in std_logic_vector(6 downto 0);
      o_alu_mux_1_ctrl        : out std_logic;
      o_alu_mux_2_ctrl        : out std_logic;
      o_pc_ctrl               : out std_logic_vector(1 downto 0);
      o_alu_control           : out std_logic_vector(5 downto 0);
      o_ram_management_ctrl   : out std_logic_vector(2 downto 0);
      o_reg_file_inst_ctrl    : out std_logic_vector(1 downto 0);
      o_reg_file_wr_ctrl      : out std_logic
   );
end entity control;

architecture rtl of control is

begin

   p_alu : process(all)
   begin
      if (i_rst = '1') then
         o_alu_control     <= (others => '0');
      else
         case i_opcode(6 downto 2) is
            when C_OPCODE_OP =>
               case i_func3 is
                  when C_FUNC3_ADD_SUB =>
                     o_alu_control <= C_SUB when i_func7 = C_FUNC7_SUB else C_ADD;
                  when C_FUNC3_SLL        => o_alu_control <= C_SLL;
                  when C_FUNC3_SLT        => o_alu_control <= C_SLT;
                  when C_FUNC3_SLTU       => o_alu_control <= C_SLTU;
                  when C_FUNC3_XOR        => o_alu_control <= C_XOR;
                  when C_FUNC3_SRL_SRA    =>
                     o_alu_control <= C_SRA when i_func7 = C_FUNC7_SRA else C_SRL;
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
                     o_alu_control <= C_SRLI when i_func7 = C_FUNC7_SRLI else C_SRAI;
                  when others             => o_alu_control <= (others => '0');
               end case;
            when C_OPCODE_LUI    => o_alu_control  <= C_LUI;
            when C_OPCODE_AUIPC  => o_alu_control  <= C_AUIPC;
            when C_OPCODE_JAL    => o_alu_control  <= C_JAL;
            when others          => o_alu_control  <= (others => '0');
         end case;
      end if;
   end process p_alu;

   p_alu_mux : process (all)
   begin
      if (i_rst = '1') then
         o_alu_mux_1_ctrl     <= C_RS1_DATA;
         o_alu_mux_2_ctrl     <= C_RS2_DATA;
      else
         -- TODO: CHANGE IF-ELSE TO CASE
         if (i_opcode(6 downto 2) = C_OPCODE_OP) then
            o_alu_mux_1_ctrl  <= C_RS1_DATA;
            o_alu_mux_2_ctrl  <= C_RS2_DATA;
         elsif (i_opcode(6 downto 2) = C_OPCODE_OPIMM) then
            o_alu_mux_1_ctrl  <= C_RS1_DATA;
            o_alu_mux_2_ctrl  <= C_IMM;
         elsif (i_opcode(6 downto 2) = C_OPCODE_STORE) then
            o_alu_mux_1_ctrl  <= C_RS1_DATA;
            o_alu_mux_2_ctrl  <= C_IMM;
         elsif (i_opcode(6 downto 2) = C_OPCODE_LUI) then
            -- o_alu_mux_1_ctrl -- value is not important in this case
            o_alu_mux_2_ctrl  <= C_IMM;
         elsif (i_opcode(6 downto 2) = C_OPCODE_AUIPC) then
            o_alu_mux_1_ctrl  <= C_PC_ADDR;
            o_alu_mux_2_ctrl  <= C_IMM;
         elsif (i_opcode(6 downto 2) = C_OPCODE_JAL) then
            o_alu_mux_1_ctrl  <= C_PC_ADDR;
            o_alu_mux_2_ctrl  <= C_IMM;
         end if;
      end if;
   end process p_alu_mux;

   p_reg_file : process(all)
   begin
      if (i_rst = '1') then
         o_reg_file_inst_ctrl    <= C_WRITE_RD_DATA;
         o_reg_file_wr_ctrl      <= C_READ_ENABLE;
      else
         case i_opcode(6 downto 2) is
            when C_OPCODE_JALR | C_OPCODE_OPIMM | C_OPCODE_OP =>
               o_reg_file_inst_ctrl <= C_WRITE_ALU_RESULT;
               o_reg_file_wr_ctrl   <= C_WRITE_ENABLE;
            when C_OPCODE_LOAD   =>
               o_reg_file_inst_ctrl <= C_WRITE_RD_DATA;
               o_reg_file_wr_ctrl   <= C_WRITE_ENABLE;
            when C_OPCODE_STORE  =>
               -- o_reg_file_inst_ctrl <= vaule is not important in this case
               o_reg_file_wr_ctrl   <= C_READ_ENABLE;
            when C_OPCODE_LUI | C_OPCODE_AUIPC =>
               o_reg_file_inst_ctrl <= C_WRITE_ALU_RESULT;
               o_reg_file_wr_ctrl   <= C_WRITE_ENABLE;
            when C_OPCODE_JAL    =>
               o_reg_file_inst_ctrl <= C_WRITE_PC_ADDR;
               o_reg_file_wr_ctrl   <= C_WRITE_ENABLE;
            when others          =>
               o_reg_file_inst_ctrl <= C_WRITE_RD_DATA;
               o_reg_file_wr_ctrl   <= C_READ_ENABLE;
         end case;
      end if;
   end process;

   p_ram_management : process(all)
   begin
      if (i_rst = '1') then
         o_ram_management_ctrl   <= (others => '0');
      else
         -- TODO: CHANGE IF-ELSE TO CASE
         if (i_opcode(6 downto 2) = C_OPCODE_LOAD) then
            case i_func3 is
               when C_FUNC3_LB   => o_ram_management_ctrl <= C_LB;
               when C_FUNC3_LH   => o_ram_management_ctrl <= C_LH;
               when C_FUNC3_LW   => o_ram_management_ctrl <= C_LW;
               when C_FUNC3_LBU  => o_ram_management_ctrl <= C_LBU;
               when C_FUNC3_LHU  => o_ram_management_ctrl <= C_LHU;
               when others       => o_ram_management_ctrl <= (others => '0');
            end case;
         elsif (i_opcode(6 downto 2) = C_OPCODE_STORE) then
            case i_func3 is
               when C_FUNC3_SB   => o_ram_management_ctrl <= C_SB;
               when C_FUNC3_SH   => o_ram_management_ctrl <= C_SH;
               when C_FUNC3_SW   => o_ram_management_ctrl <= C_SW;
               when others       => o_ram_management_ctrl <= (others => '0');
            end case;
         else
            o_ram_management_ctrl <= (others => '0');
         end if;
      end if;
   end process p_ram_management;

   p_program_counter : process(all)
   begin
      if (i_rst = '1') then
         o_pc_ctrl   <= C_NOP;
      else
    if (i_opcode(6 downto 0) = C_OPCODE_LOAD & "11") then
      o_pc_ctrl   <= C_INCREMENT_PC;
    elsif (i_opcode(6 downto 0) = C_OPCODE_JAL & "11") then
      o_pc_ctrl   <= C_LOAD_ALU_RESULT;
    else
      o_pc_ctrl   <= C_INCREMENT_PC;
    end if;
         -- Manage pc depending on instructions
      end if;
   end process p_program_counter;


end architecture rtl;
