library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library memory_lib;
   use memory_lib.all;
   use memory_lib.memory_pkg.all;

entity memory is
   port (
      i_rst       : in std_logic;
      i_clk       : in std_logic;
      i_rd_addr   : in std_logic_vector(7 downto 0);
      i_wr_addr   : in std_logic_vector(7 downto 0);
      i_wr_data   : in std_logic_vector(31 downto 0);
      i_wr_enable : in std_logic;
      o_q         : out std_logic_vector(31 downto 0)
   );
end entity memory;

architecture rtl of memory is

begin

   p_memory : process(all)
   begin
   end process p_memory;

end architecture rtl;
