library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;

entity control is
   port (
      i_rst             : in std_logic;
      i_opcode          : out std_logic_vector(6 downto 0);
      i_func3           : out std_logic_vector(2 downto 0);
      i_func7           : out std_logic_vector(6 downto 0);
      o_rd_data         : out std_logic_vector(4 downto 0);
      o_rs1_data        : out std_logic_vector(4 downto 0);
      o_rs2_data        : out std_logic_vector(4 downto 0);
      o_imm             : out std_logic_vector(31 downto 0);
      o_alu_mux_1_ctrl  : out std_logic;
      o_alu_mux_2_ctrl  : out std_logic
   );
end entity control;

architecture rtl of control is

begin

   p_control : process(all)
   begin
      if (i_rst = '1') then
         o_rd_data         <= (others => '0');
         o_rs1_data        <= (others => '0');
         o_rs2_data        <= (others => '0');
         o_imm             <= (others => '0');
         o_alu_mux_1_ctrl  <= '0';
         o_alu_mux_2_ctrl  <= '0';
      else
         case i_opcode is
            when C_OPCODE_OP =>
               case i_func3 is
                  when C_FUNC3_ADD_SUB => 
                     if (i_func7 = C_FUNC7_SUB) then
                     else
                     end if;
                  when C_FUNC3_SLL     =>
                  when C_FUNC3_SLT     =>
                  when C_FUNC3_SLTU    =>
                  when C_FUNC3_XOR     =>
                  when C_FUNC3_SRL_SRA =>
                     if (i_func7 = C_FUNC7_SRA) then
                     else
                     end if;
                  when C_FUNC3_OR      =>
                  when C_FUNC3_AND     =>
                  when others => NULL;
               end case;
            when others => 
               o_rd_data         <= (others => '0');
               o_rs1_data        <= (others => '0');
               o_rs2_data        <= (others => '0');
               o_imm             <= (others => '0');
               o_alu_mux_1_ctrl  <= '0';
               o_alu_mux_2_ctrl  <= '0';
         end case;
      end if;
   end process p_control;

end architecture rtl;
