library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;
library instruction_memory_lib;
   use instruction_memory_lib.all;
   use instruction_memory_lib.instruction_memory_pkg.all;

entity instruction_memory_tb is
end instruction_memory_tb;

architecture tb of instruction_memory_tb is

   component instruction_memory is
   port (
      i_rst             : in std_logic;
      i_ram_read_addr   : in std_logic_vector(31 downto 0);
      o_instruction     : out std_logic_vector(31 downto 0)
   );
   end component instruction_memory;

   signal rst_tb              : std_logic;
   signal ram_read_addr_tb    : std_logic_vector(31 downto 0);
   signal instruction_tb      : std_logic_vector(31 downto 0);

begin

   inst_instruction_memory : component instruction_memory
   port map (
      i_rst             => rst_tb,
      i_ram_read_addr   => ram_read_addr_tb,
      o_instruction     => instruction_tb
   );

   p_tb : process
   begin

      rst_tb            <= '1';
      ram_read_addr_tb  <= (others => '0');
      wait for 5 ns;
      rst_tb            <= '0';


      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
