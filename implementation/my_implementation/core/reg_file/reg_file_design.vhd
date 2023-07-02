library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library reg_file_lib;
   use reg_file_lib.all;
   use reg_file_lib.reg_file_pkg.all;

entity reg_file is
   port (
      i_rst          : in std_logic;
      i_rs1_addr     : in std_logic_vector(5 downto 0); -- address of rs1
      i_rs2_addr     : in std_logic_vector(5 downto 0); -- address of rs2
      i_rd_addr      : in std_logic_vector(4 downto 0);
      i_reg_wr_ctrl  : in std_logic;
      i_alu_out      : in std_logic_vector(31 downto 0);
      o_rs1_data     : out std_logic_vector(31 downto 0);
      o_rs2_data     : out std_logic_vector(31 downto 0)
   );
end entity reg_file;

architecture rtl of reg_file is

begin

   p_reg_file : process(all)
   begin
   end process p_reg_file;

end architecture rtl;
