library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
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

begin

end architecture rtl;
