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

   signal rom : t_rom;

begin

   p_instruction_memory : process(all)
   begin
      if (i_rst = '1') then
         o_instruction  <= (others => '0');
       --  ram            <= C_CODE;
         for i in 0 to C_INSTRUCTIONS_NUMBER-1 loop
             rom(i*4)   <= C_CODE(i)(7 downto 0);
             rom(i*4+1) <= C_CODE(i)(15 downto 8);
             rom(i*4+2) <= C_CODE(i)(23 downto 16);
             rom(i*4+3) <= C_CODE(i)(31 downto 24);
         end loop;
      else
         o_instruction(7 downto 0)   <= rom(to_integer(unsigned(i_ram_read_addr)));
         o_instruction(15 downto 8)  <= rom(to_integer(unsigned(i_ram_read_addr+1)));
         o_instruction(23 downto 16) <= rom(to_integer(unsigned(i_ram_read_addr+2)));
         o_instruction(31 downto 24) <= rom(to_integer(unsigned(i_ram_read_addr+3)));
      end if;
   end process p_instruction_memory;

end architecture rtl;
