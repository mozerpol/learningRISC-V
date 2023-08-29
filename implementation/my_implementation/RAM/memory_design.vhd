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
      i_byte_number        : in std_logic_vector(3 downto 0);
      o_ram_data           : out std_logic_vector(31 downto 0)
   );
end entity memory;

architecture rtl of memory is

   signal ram        : t_ram;

begin

   p_manage : process(all)
   begin
      if (i_rst = '1') then
         o_ram_data <= (others => '0');
      else
         if (i_byte_number = "1111") then
            o_ram_data(7 downto 0)   <= ram(to_integer(unsigned(i_ram_addr)), 0);
            o_ram_data(15 downto 8)  <= ram(to_integer(unsigned(i_ram_addr)), 1);
            o_ram_data(23 downto 16) <= ram(to_integer(unsigned(i_ram_addr)), 2);
            o_ram_data(31 downto 24) <= ram(to_integer(unsigned(i_ram_addr)), 3);
         elsif (i_byte_number = "0110") then
            o_ram_data(7 downto 0)   <= ram(to_integer(unsigned(i_ram_addr)), 1);
            o_ram_data(15 downto 8)  <= ram(to_integer(unsigned(i_ram_addr)), 2);
            o_ram_data(31 downto 16) <= (others => '0');
         elsif (i_byte_number = "0011") then
            o_ram_data(7 downto 0)   <= ram(to_integer(unsigned(i_ram_addr)), 2);
            o_ram_data(15 downto 8)  <= ram(to_integer(unsigned(i_ram_addr)), 3);
            o_ram_data(31 downto 16) <= (others => '0');
         elsif (i_byte_number = "0100") then
            o_ram_data(7 downto 0)   <= ram(to_integer(unsigned(i_ram_addr)), 1);
            o_ram_data(31 downto 8)  <= (others => '0');
         elsif (i_byte_number = "0010") then
            o_ram_data(7 downto 0)   <= ram(to_integer(unsigned(i_ram_addr)), 2);
            o_ram_data(31 downto 8)  <= (others => '0');
         elsif (i_byte_number = "0001") then
            o_ram_data(7 downto 0)   <= ram(to_integer(unsigned(i_ram_addr)), 3);
            o_ram_data(31 downto 8)  <= (others => '0');
         else
            o_ram_data(31 downto 8)  <= (others => '0');
         end if;
      end if;
   end process p_manage;


   p_memory : process(all)
   begin
      if (i_rst = '1') then
         ram         <= (others => (others => (others => '0')));
      elsif (i_clk'event and i_clk = '1') then
         if (i_write_enable = C_WRITE_ENABLE) then
            if (i_byte_number(0) = '1') then
               ram(to_integer(unsigned(i_ram_addr)), 0) <= i_data(7 downto 0);
            end if;
            if (i_byte_number(1) = '1') then
               ram(to_integer(unsigned(i_ram_addr)), 1) <= i_data(15 downto 8);
            end if;
            if (i_byte_number(2) = '1') then
               ram(to_integer(unsigned(i_ram_addr)), 2) <= i_data(23 downto 16);
            end if;
            if (i_byte_number(3) = '1') then
               ram(to_integer(unsigned(i_ram_addr)), 3) <= i_data(31 downto 24);
            end if;
         end if;
      end if;
   end process p_memory;

end architecture rtl;
