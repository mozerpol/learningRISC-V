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
      end if;
   end process p_control;

end architecture rtl;
