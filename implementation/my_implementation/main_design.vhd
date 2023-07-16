library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library main_lib;
   use main_lib.all;
   use main_lib.main_pkg.all;
library memory_lib;
   use memory_lib.all;
   use memory_lib.memory_pkg.all;
library core_lib;
   use core_lib.all;
   use core_lib.core_pkg.all;
   
   
entity main is
   port (
      i_rst     : in std_logic;
      i_clk     : in std_logic
      -- Maybe will be GPIO handler in the future
   );
end entity main;


architecture rtl of main is


   component memory is
      port (
         i_rst                : in std_logic;
         i_clk                : in std_logic;
         i_ram_read_addr      : in std_logic_vector(7 downto 0);
         i_ram_write_addr     : in std_logic_vector(7 downto 0);
         i_ram_write_data     : in std_logic_vector(31 downto 0);
         i_ram_write_enable   : in std_logic;
         o_instruction        : out std_logic_vector(31 downto 0)
      );
   end component memory;

   component core is
      port (
          i_rst                : in std_logic;
          i_clk                : in std_logic;
          i_instruction_read   : in std_logic_vector(31 downto 0);
          o_instruction_write  : out std_logic_vector(31 downto 0);
          o_addr_read          : out std_logic_vector(7 downto 0);
          o_addr_write         : out std_logic_vector(7 downto 0);
          o_write_enable       : out std_logic
      );
   end component core;
   
   -- General
   signal rst               : std_logic;
   signal clk               : std_logic;
   -- RAM
   signal ram_read_addr     : std_logic_vector(7 downto 0);
   signal ram_write_addr    : std_logic_vector(7 downto 0);
   signal ram_write_data    : std_logic_vector(31 downto 0);
   signal ram_write_enable  : std_logic;
   signal instruction       : std_logic_vector(31 downto 0);
   -- Core
   signal instruction_read  : std_logic_vector(31 downto 0);
   signal instruction_write : std_logic_vector(31 downto 0);
   signal addr_read         : std_logic_vector(7 downto 0);
   signal addr_write        : std_logic_vector(7 downto 0);
   signal write_enable      : std_logic;
   

begin

   inst_memory : component memory
   port map (
      i_rst                => i_rst,
      i_clk                => i_clk,
      i_ram_read_addr      => ram_read_addr,
      i_ram_write_addr     => ram_write_addr,
      i_ram_write_data     => ram_write_data,
      i_ram_write_enable   => ram_write_enable,
      o_instruction        => instruction
   );

   inst_core : component core 
   port map (
      i_rst                => i_rst,
      i_clk                => i_clk,
      i_instruction_read   => instruction_read,
      o_instruction_write  => instruction_write,
      o_addr_read          => addr_read,
      o_addr_write         => addr_write,
      o_write_enable       => write_enable
   );

    
   ram_read_addr     <= addr_read; 
   ram_write_addr    <= addr_write;
   ram_write_data    <= instruction_write; 
   ram_write_enable  <= write_enable;
   --
   instruction_read  <= instruction;

   p_main : process(all)
   begin
      if (i_rst) then

      elsif (clk'event and clk = '1') then
         
      end if;
   end process p_main;

end architecture rtl;
