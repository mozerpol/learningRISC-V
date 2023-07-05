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
      i_clk          : in std_logic;
      i_rs1_addr     : in std_logic_vector(4 downto 0); -- address of rs1
      i_rs2_addr     : in std_logic_vector(4 downto 0); -- address of rs2
      i_rd_addr      : in std_logic_vector(4 downto 0);
      i_reg_wr_ctrl  : in std_logic;
      i_alu_out      : in std_logic_vector(31 downto 0);
      o_rs1_data     : out std_logic_vector(31 downto 0);
      o_rs2_data     : out std_logic_vector(31 downto 0)
   );
end entity reg_file;

architecture rtl of reg_file is

   type t_gpr  is array(0 to 31) of std_logic_vector(31 downto 0);
   signal gpr : t_gpr; -- general puprose register

begin

   o_rs1_data <= (others => '0') when i_rs1_addr = 5b"00000" else
                 gpr(to_integer(unsigned(i_rs1_addr)));
   o_rs2_data <= (others => '0') when i_rs2_addr = 5b"00000" else
                 gpr(to_integer(unsigned(i_rs2_addr)));

   p_reg_file : process(all)
   begin
      if (i_rst = '1') then
         -- Nothing
      elsif (i_clk'event and i_clk = '1') then
         if (i_reg_wr_ctrl = '1') then
            gpr(to_integer(unsigned(i_rd_addr))) <= i_alu_out;
         end if;
      end if;
   end process p_reg_file;

end architecture rtl;
