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
      o_control_alu     : out std_logic_vector(5 downto 0);
      o_reg_wr_ctrl     : out std_logic
   );
end entity control;

architecture rtl of control is

begin

   p_control : process(all)
   begin
      if (i_rst = '1') then
         o_alu_mux_1_ctrl  <= '0';
         o_alu_mux_2_ctrl  <= '0';
         o_control_alu     <= (others => '0');
         o_reg_wr_ctrl     <= '0';
      else
         case i_opcode(6 downto 2) is
            when C_OPCODE_OP =>
               o_alu_mux_1_ctrl <= '0'; -- Select rs1 data as operand
               o_alu_mux_2_ctrl <= '0'; -- Select rs2 data as operand
               case i_func3 is
                  when C_FUNC3_ADD_SUB => 
                     o_control_alu <= C_SUB when i_func7 = C_FUNC7_SUB else C_ADD;
                  when C_FUNC3_SLL     => o_control_alu <= C_SLL;
                  when C_FUNC3_SLT     => o_control_alu <= C_SLT;
                  when C_FUNC3_SLTU    => o_control_alu <= C_SLTU;
                  when C_FUNC3_XOR     => o_control_alu <= C_XOR;
                  when C_FUNC3_SRL_SRA =>
                     o_control_alu <= C_SRA when i_func7 = C_SRA else C_SRL;
                  when C_FUNC3_OR      => o_control_alu <= C_OR;
                  when C_FUNC3_AND     => o_control_alu <= C_AND;
                  when others          => o_control_alu <= (others => '0');
               end case;
            when others => 
               o_alu_mux_1_ctrl  <= '0';
               o_alu_mux_2_ctrl  <= '0';
               o_control_alu     <= (others => '0');
         end case;
      end if;
   end process p_control;

end architecture rtl;
