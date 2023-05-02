library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;


entity reg_file_design is
   generic (
      ADDR_LEN : integer := 5
   );
   port (
      signal clk     : in std_logic;
      signal reg_wr  : in std_logic;
      signal rs1     : in std_logic_vector(ADDR_LEN-1 downto 0);
      signal rs2     : in std_logic_vector(ADDR_LEN-1 downto 0);
      signal rd      : in std_logic_vector(ADDR_LEN-1 downto 0);
      signal rd_d    : in std_logic_vector(REG_LEN-1 downto 0);
      signal rs1_d   : out std_logic_vector(REG_LEN-1 downto 0);
      signal rs2_d   : out std_logic_vector(REG_LEN-1 downto 0)
   );
end entity reg_file_design;

architecture rtl of reg_file_design is

   type t_x  is array(REG_LEN downto 0) of std_logic_vector(REG_LEN-1 downto 0);
   signal x : t_x;

begin


   rs1_d <= 32x"0" when rs1 = 5b"0" else x(to_integer(unsigned(rs1)));
   rs2_d <= 32x"0" when rs2 = 5b"0" else x(to_integer(unsigned(rs2)));

   p_reg : process(clk)
   begin
      if (clk'event and clk = '1') then
         if(reg_wr) then
            x(to_integer(signed(rd))) <= rd_d;
         end if;
      end if;
   end process p_reg;

end architecture rtl;
