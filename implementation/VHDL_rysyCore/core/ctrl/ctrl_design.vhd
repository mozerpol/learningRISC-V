library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library opcodes;
   use opcodes.opcodesPkg.all;
library ctrl_lib;
   use ctrl_lib.all;
   use ctrl_lib.ctrl_pkg.all;
library imm_mux_lib;
   use imm_mux_lib.all;
   use imm_mux_lib.imm_mux_pkg.all;
library alu_lib;
   use alu_lib.all;
   use alu_lib.alu_pkg.all;
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


entity ctrl is
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
end entity ctrl;

architecture rtl of ctrl is

   signal next_nop      : std_logic;
   signal load_phase    : std_logic;

begin

   ------ Controlling imm_mux ------  
   p_imm_mux : process(opcode)
   begin
      case (opcode) is
         when OP_IMM => imm_type <= C_IMM_I;
         when LUI    => imm_type <= C_IMM_U;
         when JAL    => imm_type <= C_IMM_J;
         when JALR   => imm_type <= C_IMM_I;
         when BRANCH => imm_type <= C_IMM_B;
         when LOAD   => imm_type <= C_IMM_I;
         when STORE  => imm_type <= C_IMM_S;
         when others => imm_type <= C_IMM_DEFAULT; 
      end case;
   end process p_imm_mux;

   ------ Controlling alu1_mux ------
   p_alu1_mux : process(opcode)
   begin
      case (opcode) is
         when BRANCH => alu1_sel <= ALU1_PC;
         when JAL    => alu1_sel <= ALU1_PC;
         when others => alu1_sel <= ALU1_RS;
      end case;
   end process p_alu1_mux;
   
   ------ Controlling alu2_mux ------
   p_alu2_mux : process (opcode)
   begin
      case (opcode) is
         when LOAD | STORE | BRANCH | JALR | JAL | OP_IMM => 
                        alu2_sel <= ALU2_IMM;
         when OP     => alu2_sel <= ALU2_RS;
         when others => alu2_sel <= ALU2_IMM;
      end case;
   end process p_alu2_mux;

   ------ Controlling reg_wr from reg_file module ------
   p_reg_wr : process (opcode, load_phase)
   begin
      case (opcode) is
         when JALR | JAL | OP_IMM | LUI | OP =>
                        reg_wr <= '1';
         when LOAD =>   reg_wr <= load_phase;
         when others => reg_wr <= '0';
      end case;
   end process p_reg_wr;

   ------ Controlling rd_mux ------
   p_rd_mux : process (opcode)
   begin
      case (opcode) is
         when OP_IMM | OP     => rd_sel <= RD_ALU;
         when LUI             => rd_sel <= RD_IMM;
         when JALR | JAL      => rd_sel <= RD_PCP4;
         when LOAD            => rd_sel <= RD_MEM;
         when others          => rd_sel <= RD_ALU;
      end case;
   end process p_rd_mux;
 
   ------ Controlling mem_addr_sel pc_sel part ------
   p_mem_addr_sel : process(opcode, b, load_phase)
   begin
      case (opcode) is
         when JALR | JAL   => pc_sel <= PC_ALU;
         when BRANCH       => pc_sel <= PC_ALU when b = '1' else PC_P4;
         when STORE        => pc_sel <= PC_OLD;
         when LOAD         =>
            case (load_phase) is
               when '1'       => pc_sel <= PC_M4;
               when '0'       => pc_sel <= PC_P4;
               when others    => pc_sel <= PC_OLD;
            end case;
         when others       => pc_sel <= PC_P4;
      end case;
   end process p_mem_addr_sel;

   ------ Controlling mem_addr_sel mem_sel part ------
   p_mem_addr_sel2 : process (opcode, load_phase)
   begin
      case (opcode) is
         when STORE  => mem_sel <= MEM_ALU;
         when LOAD   =>
            case (load_phase) is
               when '0'    =>  mem_sel <= MEM_ALU;
               when others => mem_sel  <= MEM_PC;
            end case;
         when others => mem_sel <= MEM_PC;
      end case;
   end process p_mem_addr_sel2;

   ------ Controlling cmp ------
   p_cmp : process (all)
   begin
      case (func3) is
         when FUNC3_BRANCH_BEQ  => cmp_op <= EQ;
         when FUNC3_BRANCH_BNE  => cmp_op <= NE;
         when FUNC3_BRANCH_BLT  => cmp_op <= LT;
         when FUNC3_BRANCH_BGE  => cmp_op <= GE;
         when FUNC3_BRANCH_BLTU => cmp_op <= LTU;
         when FUNC3_BRANCH_BGEU => cmp_op <= GEU;
         when others => cmp_op <= EQ;
      end case;
   end process p_cmp;

   ------ Controlling select_pkg ------
   p_select_pkg : process (func3, opcode)
   begin
      case (func3) is
         when FUNC3_SB  => sel_type <= SB;
         when FUNC3_SH  => sel_type <= SH;
         when FUNC3_SW  => sel_type <= SW;
         when FUNC3_SBU => sel_type <= SBU;
         when FUNC3_SHU => sel_type <= SHU;
         when others    => sel_type <= SW;
      end case;
   end process p_select_pkg;

   ------ Controlling inst_mgmt ------
   p_inst_mgmt : process (next_nop, opcode, b, load_phase)
   begin
      if (next_nop) then
         inst_sel <= INST_NOP;
      else
         case (opcode) is
            when JALR | JAL => inst_sel <= INST_NOP;
            when BRANCH => inst_sel <= INST_NOP when b = '1' else INST_MEM;
            when LOAD   =>
               case (load_phase) is
                  when '1'    => inst_sel <= INST_NOP;
                  when others => inst_sel <= INST_OLD;
               end case;
            when others => inst_sel <= INST_MEM;
         end case;
      end if;
   end process p_inst_mgmt;

   ------ Controlling alu ------
   p_alu : process (opcode, func3, func7)
   begin
      case (opcode) is
         when OP_IMM | OP =>
            case (func3) is
               when FUNC3_ADD_SUB =>
                  if (opcode = OP and func7 = FUNC7_ADD_SUB_SUB) then
                     alu_op <= "0001"; -- SUB
                  else
                     alu_op <= ADD;
                  end if;
               when FUNC3_SLT    => alu_op <= SLT;
               when FUNC3_SLTU   => alu_op <= SLTU;
               when FUNC3_XOR    => alu_op <= "0010"; -- XOR
               when FUNC3_OR     => alu_op <= "0011"; -- OR
               when FUNC3_AND    => alu_op <= SLT;
               when FUNC3_SLL    => alu_op <= "0101"; -- SLL
               when FUNC3_SR     => 
                  case (func7) is
                     when FUNC7_SR_SRL => alu_op <= "0110"; -- SRL
                     when FUNC7_SR_SRA => alu_op <= "0111"; -- SRA
                     when others => alu_op       <= ADD;
                  end case;
               when others       => alu_op       <= ADD;
            end case;
         when LOAD | STORE | BRANCH | JAL | JALR =>
                        alu_op <= ADD;
         when others => alu_op <= ADD;
      end case;
   end process p_alu;

   ------  ------
   p_next_nop : process (clk)
   begin
      if (rst = '1') then
         next_nop <= '1';
      elsif (clk'event and clk = '1') then
         if (opcode = JAL or opcode = JALR or (opcode = BRANCH and b = '1') or
             opcode = STORE) then
               next_nop <= '1';
         else
            next_nop <= '0'; 
         end if;
      end if;
   end process p_next_nop;

   ------  ------
   p_load_phase : process (clk)
   begin
      if (rst) then
         load_phase <= '0';
      elsif (clk'event and clk = '1') then
         if (opcode = LOAD) then
            load_phase <= not(load_phase);
         end if;
      end if;
   end process p_load_phase;

   ------  ------
   p_opcode : process(opcode)
   begin
      case (opcode) is
         when STORE  => we <= '1';
         when others => we <= '0';
      end case;
   end process p_opcode;


end architecture rtl;
