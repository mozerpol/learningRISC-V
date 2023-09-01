library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
   use std.env.all;
library ram_management_lib;
   use ram_management_lib.all;
   use ram_management_lib.ram_management_pkg.all;

entity ram_management_tb is
end ram_management_tb;

architecture tb of ram_management_tb is

   component ram_management is
   port (
      i_rst                   : in std_logic;
      i_ram_management_ctrl   : in std_logic_vector(2 downto 0);
      i_rs1_data              : in std_logic_vector(31 downto 0);
      i_rs2_data              : in std_logic_vector(31 downto 0);
      i_imm                   : in std_logic_vector(31 downto 0);
      i_load_inst_ctrl        : in std_logic;
      o_ram_addr              : out std_logic_vector(7 downto 0);
      o_write_enable          : out std_logic;
      o_byte_number           : out std_logic_vector(3 downto 0);
      o_data                  : out std_logic_vector(31 downto 0)
   );
   end component ram_management;

   signal rst_tb                   : std_logic;
   signal ram_management_ctrl_tb   : std_logic_vector(2 downto 0);
   signal rs1_data_tb              : std_logic_vector(31 downto 0);
   signal rs2_data_tb              : std_logic_vector(31 downto 0);
   signal imm_tb                   : std_logic_vector(31 downto 0);
   signal load_inst_ctrl_tb        : std_logic;
   signal ram_addr_tb              : std_logic_vector(7 downto 0);
   signal write_enable_tb          : std_logic;
   signal byte_number_tb           : std_logic_vector(3 downto 0);
   signal data_tb                  : std_logic_vector(31 downto 0);

begin

   inst_ram_management : component ram_management
   port map (
      i_rst                   => rst_tb,
      i_ram_management_ctrl   => ram_management_ctrl_tb,
      i_rs1_data              => rs1_data_tb,
      i_rs2_data              => rs2_data_tb,
      i_imm                   => imm_tb,
      i_load_inst_ctrl        => load_inst_ctrl_tb,
      o_ram_addr              => ram_addr_tb,
      o_write_enable          => write_enable_tb,
      o_byte_number           => byte_number_tb,
      o_data                  => data_tb
   );

   p_tb : process
   begin

      rst_tb                  <= '1';
      ram_management_ctrl_tb  <= (others => '0');
      rs1_data_tb             <= (others => '0');
      rs2_data_tb             <= (others => '0');
      imm_tb                  <= (others => '0');
      load_inst_ctrl_tb       <= '0';
      wait for 5 ns;
      rst_tb                  <= '0';

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
