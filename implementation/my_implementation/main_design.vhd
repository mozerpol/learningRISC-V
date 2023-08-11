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


   component core is
      port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_ram_data_read      : in std_logic_vector(31 downto 0);
      o_ram_data_write     : out std_logic_vector(31 downto 0);
      o_ram_addr           : out std_logic_vector(7 downto 0);
      o_write_enable       : out std_logic
      );
   end component core;
   

   component memory is
      port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_ram_addr           : in std_logic_vector(7 downto 0);
      i_write_enable       : in std_logic;
      i_data               : in std_logic_vector(31 downto 0);
      o_ram_data           : out std_logic_vector(31 downto 0)
      );
   end component memory;

   
   -- General
   signal rst               : std_logic;
   signal clk               : std_logic;
-- RAM and core
signal ram_addr           : std_logic_vector(7 downto 0);
signal write_enable       : std_logic;
signal data               : std_logic_vector(31 downto 0);
signal ram_data           : std_logic_vector(31 downto 0);
signal ram_data_read      : std_logic_vector(31 downto 0);
signal ram_data_write     : std_logic_vector(31 downto 0);


begin

   inst_memory : component memory
   port map (
      i_rst                => rst,
      i_clk                => clk,
      i_ram_addr           => ram_addr,
      i_write_enable       => write_enable,
      i_data               => data,
      o_ram_data           => ram_data
   );

   inst_core : component core 
   port map (
      i_rst                => rst,
      i_clk                => clk,
      i_ram_data_read      => ram_data_read,
      o_ram_data_write     => ram_data_write, 
      o_ram_addr           => ram_addr,
      o_write_enable       => write_enable 
   );
    
rst <= i_rst;
clk <= i_clk;
-- RAM output
ram_data_read <= ram_data;
-- Core output 
ram_data_write <= data;
ram_addr    <= ram_addr;
write_enable <= write_enable;
      

   p_main : process(all)
   begin
      if (i_rst) then

      elsif (clk'event and clk = '1') then
         
      end if;
   end process p_main;

end architecture rtl;
