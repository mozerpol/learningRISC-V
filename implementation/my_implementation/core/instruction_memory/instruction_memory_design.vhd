library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library instruction_memory_lib;
   use instruction_memory_lib.all;
   use instruction_memory_lib.instruction_memory_pkg.all;


entity instruction_memory is
   port (
      i_rst             : in std_logic;
      i_ram_read_addr   : in std_logic_vector(31 downto 0);
      o_instruction     : out std_logic_vector(31 downto 0)
   );
end entity instruction_memory;

architecture rtl of instruction_memory is

   signal ram : t_instruction_memory;

begin

   p_instruction_memory : process(all)
   begin
      if (i_rst = '1') then
        o_instruction <= (others => '0');
        ram           <= C_CODE;
      else
         o_instruction  <= ram(to_integer(unsigned(i_ram_read_addr)));
      end if;
   end process p_instruction_memory;

end architecture rtl;
