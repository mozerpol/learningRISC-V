library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library mux_reg_file_lib;
   use mux_reg_file_lib.all;
   use mux_reg_file_lib.mux_reg_file_pkg.all;

entity mux_reg_file is
   port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_alu_result         : in std_logic_vector(31 downto 0);
      i_instruction        : in std_logic_vector(31 downto 0);
      i_mux_reg_file_ctrl  : in std_logic;
      o_rd_data            : out std_logic_vector(31 downto 0);
      o_instruction_dec    : out std_logic_vector(31 downto 0)
   );
end entity mux_reg_file;

architecture rtl of mux_reg_file is

begin


    o_rd_data  <= i_alu_result when i_mux_reg_file_ctrl = '0' else i_instruction;

   p_mux : process(all)
   begin
      if (i_rst = '1') then
         o_instruction_dec  <= (others => '0');
      elsif (i_clk'event and i_clk = '1') then
         o_instruction_dec <= i_instruction;
      end if;
   end process p_mux;

end architecture rtl;
