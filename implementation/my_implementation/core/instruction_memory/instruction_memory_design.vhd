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
      i_clk             : in std_logic;
      i_instruction_addr   : in std_logic_vector(31 downto 0);
      o_instruction     : out std_logic_vector(31 downto 0)
   );
end entity instruction_memory;

architecture rtl of instruction_memory is

   signal rom : t_rom;

begin

   p_instruction_memory : process(all)
    variable v_asdf : std_logic;
   begin
      if (i_rst = '1') then
         o_instruction  <= (others => '0');
         v_asdf := '0';
      elsif (i_clk = '1' and i_clk'event) then -- get rid of the ROM, read instructions directly from CONSTANT.
     --    if (v_asdf = '1') then
          o_instruction  <= C_CODE(to_integer(unsigned(i_instruction_addr(11 downto 2))));
    --     else
    --      v_asdf := '1';
    --      o_instruction  <= (others => '0');
    --     end if;
      end if;
   end process p_instruction_memory;

end architecture rtl;
