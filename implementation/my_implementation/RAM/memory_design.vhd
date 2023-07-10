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

   signal ram : t_ram;

begin

   p_memory : process(all)
   begin
      if (i_rst = '1') then
         ram   <= C_CODE;
         o_q   <= (others => '0');
      elsif (i_clk'event and i_clk = '1') then
         if (i_wr_enable = '1') then
            ram(to_integer(unsigned(i_wr_addr)))(7 downto 0)
               <= i_wr_data(7 downto 0);
            ram(to_integer(unsigned(i_wr_addr)))(15 downto 8)
               <= i_wr_data(15 downto 8);
            ram(to_integer(unsigned(i_wr_addr)))(23 downto 16)
               <= i_wr_data(23 downto 16);
            ram(to_integer(unsigned(i_wr_addr)))(31 downto 24)
               <= i_wr_data(31 downto 24);
         end if;
         o_q <= ram(to_integer(unsigned(i_rd_addr)));
      end if;
   end process p_memory;

end architecture rtl;
