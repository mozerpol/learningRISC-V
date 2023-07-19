library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;
library memory_management_lib;
   use memory_management_lib.all;
   use memory_management_lib.memory_management_pkg.all;

entity memory_management_tb is
end memory_management_tb;

architecture tb of memory_management_tb is

   component memory_management is
   port (
      i_rst          : in std_logic;
      i_alu_out      : in std_logic_vector(31 downto 0);
      i_rs2_data     : in std_logic_vector(31 downto 0);
      i_alu_control  : in std_logic_vector(5 downto 0);
      o_read_addr    : out std_logic_vector(7 downto 0);
      o_write_addr   : out std_logic_vector(7 downto 0);
      o_write_data   : out std_logic_vector(31 downto 0)
   );
   end component memory_management;

   signal rst_tb           : std_logic;
   signal alu_out_tb       : std_logic_vector(31 downto 0);
   signal rs2_data_tb      : std_logic_vector(31 downto 0);
   signal alu_control_tb   : std_logic_vector(5 downto 0);
   signal read_addr_tb     : std_logic_vector(7 downto 0);
   signal write_addr_tb    : std_logic_vector(7 downto 0);
   signal write_data_tb    : std_logic_vector(31 downto 0);

begin

   inst_memory_management : component memory_management
   port map (
      i_rst             => rst_tb,
      i_alu_out         => alu_out_tb,
      i_rs2_data        => rs2_data_tb,
      i_alu_control     => alu_control_tb,
      o_read_addr       => read_addr_tb,
      o_write_addr      => write_addr_tb,
      o_write_data      => write_data_tb
   );

   p_tb : process
   begin


      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
