library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library memory_management_lib;
   use memory_management_lib.all;
   use memory_management_lib.memory_management_pkg.all;
library alu_lib;
   use alu_lib.alu_pkg.all;


entity memory_management is
   port (
      i_rst          : in std_logic;
      i_alu_out      : in std_logic_vector(31 downto 0);
      i_rs2_data     : in std_logic_vector(31 downto 0);
      i_alu_control  : in std_logic_vector(5 downto 0);
      o_read_addr    : out std_logic_vector(7 downto 0);
      o_write_addr   : out std_logic_vector(7 downto 0);
      o_write_data   : out std_logic_vector(31 downto 0)
   );
end entity memory_management;

architecture rtl of memory_management is

begin

   p_memory_management : process(all)
   begin
      if (i_rst = '1') then
         o_read_addr    <= (others => '0');
         o_write_addr   <= (others => '0');
         o_write_data   <= (others => '0');
      else
         case i_alu_control is
            when C_SW   => 
               o_write_addr <= i_alu_out(7 downto 0);
               o_write_data <= i_rs2_data;
            when others => 
         end case;
      end if;
   end process p_memory_management;

end architecture rtl;
