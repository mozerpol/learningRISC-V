--------------------------------------------------------------------------------
-- File          : instruction_memory_design.vhd
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : The module receives an address (i_instruction_addr signal)
-- that comes from the program_counter module. Based on this address, the
-- appropriate instruction from the ROM is read.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library instruction_memory_lib;
   use instruction_memory_lib.all;
   use instruction_memory_lib.rom.all;


entity instruction_memory is
   port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_instruction_addr   : in std_logic_vector(31 downto 0);
      o_instruction        : out std_logic_vector(31 downto 0)
   );
end entity instruction_memory;

architecture rtl of instruction_memory is

begin

   p_instruction_memory : process(i_clk, i_rst)
   begin
      if (i_rst = '1') then
         o_instruction  <= (others => '0');
      elsif (i_clk = '1' and i_clk'event) then
         -- The value of i_instruction_addr can only be a multiple of number 4,
         -- eg. 4, 8, 12, 16, 20, ...
         -- For this reason, the two youngest bits are not read. Otherwise, from
         -- memory that contains the instructions to be executed (C_CODE)
         -- instructions number 4, 8, 12, 16, etc. will be read.
         o_instruction  <= C_CODE(to_integer(unsigned(i_instruction_addr(11 downto 2))));
      end if;
   end process p_instruction_memory;

end architecture rtl;
