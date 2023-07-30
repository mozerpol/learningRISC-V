library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library memory_lib;
   use memory_lib.all;
   use memory_lib.memory_pkg.all;

entity memory is
   port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_ram_addr           : in std_logic_vector(7 downto 0);
      i_write_enable       : in std_logic;
      i_data               : in std_logic_vector(31 downto 0);
      o_ram_data           : out std_logic_vector(31 downto 0)
   );
end entity memory;

architecture rtl of memory is

   signal ram : t_ram;

begin

   o_instruction <= ram(to_integer(unsigned(i_ram_read_addr)));
    
   p_memory : process(all)
   begin
      if (i_rst = '1') then
         ram   <= C_CODE;
      elsif (i_clk'event and i_clk = '1') then
         if (i_ram_write_enable = '1') then
            ram(to_integer(unsigned(i_ram_write_addr)))(7 downto 0)
               <= i_ram_write_data(7 downto 0);
            ram(to_integer(unsigned(i_ram_write_addr)))(15 downto 8)
               <= i_ram_write_data(15 downto 8);
            ram(to_integer(unsigned(i_ram_write_addr)))(23 downto 16)
               <= i_ram_write_data(23 downto 16);
            ram(to_integer(unsigned(i_ram_write_addr)))(31 downto 24)
               <= i_ram_write_data(31 downto 24);
         end if;
      end if;
   end process p_memory;

end architecture rtl;
