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
      i_rst             : in std_logic;
      i_opcode          : in std_logic_vector(6 downto 0);
      i_func3           : in std_logic_vector(2 downto 0);
      i_func7           : in std_logic_vector(6 downto 0);
      o_alu_mux_1_ctrl  : out std_logic;
      o_alu_mux_2_ctrl  : out std_logic;
      o_alu_control     : out std_logic_vector(5 downto 0);
      o_reg_wr_ctrl     : out std_logic;
      o_ram_wr_ctrl     : out std_logic
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
            when C_OPCODE_LUI    => o_alu_control <= C_LUI;
            when C_OPCODE_LOAD   =>
               case i_func3 is
                  when C_FUNC3_LB         => o_alu_control <= C_LB;
                  when C_FUNC3_LH         => o_alu_control <= C_LH;
                  when C_FUNC3_LW         => o_alu_control <= C_LW;
                  when C_FUNC3_LBU        => o_alu_control <= C_LBU;
                  when C_FUNC3_LHU        => o_alu_control <= C_LHU;
                  when others             => o_alu_control <= (others => '0');
               end case;
            when C_OPCODE_STORE  =>
               case i_func3 is
                  when C_FUNC3_SB         => o_alu_control <= C_SB;
                  when C_FUNC3_SH         => o_alu_control <= C_SH;
                  when C_FUNC3_SW         => o_alu_control <= C_SW;
                  when others             => o_alu_control <= (others => '0');
               end case;
            when others    => o_alu_control  <= (others => '0');
         end case;
      end if;
   end process p_alu;

   p_alu_mux : process (all)
   begin
      if (i_rst = '1') then
         o_alu_mux_1_ctrl  <= '0';
         o_alu_mux_2_ctrl  <= '0';
      else
         if (i_opcode(6 downto 2) = C_OPCODE_OP) then
            o_alu_mux_1_ctrl <= '0'; -- Select rs1 data as operand
            o_alu_mux_2_ctrl <= '0'; -- Select rs2 data as operand
         -- elsif (i_opcode(6 downto 2) = (C_OPCODE_OPIMM or C_OPCODE_LUI)) then
         elsif (i_opcode(6 downto 2) = C_OPCODE_OPIMM) then
            o_alu_mux_2_ctrl <= '1'; -- Select imm data as operand
         elsif (i_opcode(6 downto 2) = C_OPCODE_LUI) then
            o_alu_mux_2_ctrl <= '1';
         elsif (i_opcode(6 downto 2) = C_OPCODE_STORE) then
            o_alu_mux_1_ctrl <= '0'; -- Select rs1 data as operand
            o_alu_mux_2_ctrl <= '1'; -- Select imm data as operand
         end if;
      end if;
   end process p_alu_mux;

   p_reg_file : process(all)
   begin
      if (i_rst = '1') then
         o_reg_wr_ctrl <= '0';
      else
         case i_opcode(6 downto 2) is
            when C_OPCODE_JAL | C_OPCODE_JALR | C_OPCODE_OPIMM | C_OPCODE_LUI |
                 C_OPCODE_OP =>
                  o_reg_wr_ctrl <= '1';
            -- when C_OPCODE_LOAD =>
            when others => o_reg_wr_ctrl <= '0'; -- C_OPCODE_STORE
         end case;
      end if;
   end process;

   p_memory_management : process(all)
   begin
      if (i_rst = '1') then
        o_ram_wr_ctrl <= '0';
      else
         case i_opcode(6 downto 2) is
            when C_OPCODE_STORE  => o_ram_wr_ctrl <= '1';
                -- Later add controlling which part of RAM to write depending on
                -- the instruction
            when others          => o_ram_wr_ctrl <= '0'; 
         end case;
      end if;
   end process p_memory_management;

end architecture rtl;
