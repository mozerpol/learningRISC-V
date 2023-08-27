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
      i_bytes_number       : in std_logic_vector(1 downto 0);
      o_ram_data           : out std_logic_vector(31 downto 0)
   );
end entity memory;

architecture rtl of memory is

   signal ram        : t_ram;

begin

   p_memory : process(all)
      variable v_column : natural range 0 to 3;
      variable v_row    : natural range 0 to C_RAM_DEPTH-1;
   begin
      if (i_rst = '1') then
         ram         <= (others => (others => (others => '0')));
         v_column    := 0;
         v_row       := 0;
         o_ram_data  <= (others => '0');
      elsif (i_clk'event and i_clk = '1') then
         if (i_write_enable = C_WRITE_ENABLE) then
            v_column := to_integer(unsigned(i_ram_addr - (i_ram_addr(7 downto 2) & "00")));
            v_row    := to_integer(unsigned(i_ram_addr(7 downto 2)));
            ram(v_row, v_column) <= (others => '1');
            if (i_bytes_number = C_STORE_WORD) then -- SW
            elsif (i_bytes_number = C_STORE_HALF) then -- SH
            elsif (i_bytes_number = C_STORE_BYTE) then -- SB
            end if;
         end if;
      end if;
   end process p_memory;

end architecture rtl;
