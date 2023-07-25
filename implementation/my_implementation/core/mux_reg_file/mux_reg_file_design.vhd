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
      i_alu_result         : in std_logic_vector(31 downto 0);
      i_instruction        : in std_logic_vector(31 downto 0);
      i_mux_reg_file_ctrl  : in std_logic;
      o_rd_data            : out std_logic_vector(31 downto 0);
      o_instruction        : out std_logic_vector(31 downto 0)
   );
end entity mux_reg_file;

architecture rtl of mux_reg_file is

begin

   p_mux : process(all)
   begin
      if (i_rst = '1') then
         o_rd_data      <= (others => '0');
         o_instruction  <= (others => '0');
      else
         if (i_mux_reg_file_ctrl = '1') then
            o_rd_data      <= i_instruction;
         else
            -- TODO: add i_alu_result handler
            o_instruction  <= i_instruction;
         end if;
      end if;
   end process p_mux;

end architecture rtl;
