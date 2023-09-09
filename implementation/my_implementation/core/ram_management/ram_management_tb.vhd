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
      
      o_write_enable     : out  std_logic;                       -- we
      o_byte_enable      : out  std_logic_vector (3 downto 0);   -- be
      o_raddr            : out  integer range 0 to 63;
      o_waddr            : out  integer range 0 to 63;
      o_data             : out  std_logic_vector(31 downto 0)    -- wdata
   );
   end component ram_management;

   signal rst_tb                   : std_logic;
   signal ram_management_ctrl_tb   : std_logic_vector(2 downto 0);
   signal rs1_data_tb              : std_logic_vector(31 downto 0);
   signal rs2_data_tb              : std_logic_vector(31 downto 0);
   signal imm_tb                   : std_logic_vector(31 downto 0);
   signal load_inst_ctrl_tb        : std_logic;
   signal ram_addr_tb              : std_logic_vector(7 downto 0);
   signal write_enable_tb          : std_logic;-- we
   signal data_tb                  : std_logic_vector(31 downto 0); -- wdata
        
      signal byte_enable_tb      : std_logic_vector (3 downto 0);   -- be
      signal raddr_tb            : integer range 0 to 63;
      signal waddr_tb            : integer range 0 to 63;

begin

   inst_ram_management : component ram_management
   port map (
      i_rst                  => rst_tb,
      i_ram_management_ctrl   => ram_management_ctrl_tb,
      i_rs1_data             => rs1_data_tb,
      i_rs2_data             => rs2_data_tb,
      i_imm                   => imm_tb,
      i_load_inst_ctrl      => load_inst_ctrl_tb,
      o_write_enable     => write_enable_tb,
      o_byte_enable    => byte_enable_tb,
      o_raddr          => raddr_tb,
      o_waddr           => waddr_tb,
      o_data             => data_tb
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
      ---- SW ----
      ram_management_ctrl_tb  <= C_SW;
      rs1_data_tb             <= 32d"0";
      imm_tb                  <= 32d"0";
      rs2_data_tb             <= 32x"00ff00ff";
      wait for 5 ns;
      ---- SW ----
      ram_management_ctrl_tb  <= C_SW;
      rs1_data_tb             <= 32d"2";
      imm_tb                  <= 32d"2";
      rs2_data_tb             <= 32x"ff00ff00";
      wait for 5 ns;
      ---- SH ----
      ram_management_ctrl_tb  <= C_SH;
      rs1_data_tb             <= 32d"3";
      imm_tb                  <= 32d"3";
      rs2_data_tb             <= 32x"ee00ee00";
      wait for 5 ns;
      ---- SH ----
      ram_management_ctrl_tb  <= C_SH;
      rs1_data_tb             <= 32d"3";
      imm_tb                  <= 32d"1";
      rs2_data_tb             <= 32x"00ee00ee";
      wait for 5 ns;
       ---- SB ----
      ram_management_ctrl_tb  <= C_SH;
      rs1_data_tb             <= 32d"5";
      imm_tb                  <= 32d"0";
      rs2_data_tb             <= 32x"00dd00dd";
      wait for 5 ns;
       ---- SB ----
      ram_management_ctrl_tb  <= C_SH;
      rs1_data_tb             <= 32d"1";
      imm_tb                  <= 32d"5";
      rs2_data_tb             <= 32x"dd00dd00";
      wait for 5 ns;
       ---- LW ----
      ram_management_ctrl_tb  <= C_LW;
      rs1_data_tb             <= 32d"0";
      imm_tb                  <= 32d"4";
      rs2_data_tb             <= (others => '0');
      load_inst_ctrl_tb       <= '1';
      wait for 5 ns;
       ---- LB ----
      ram_management_ctrl_tb  <= C_LB;
      rs1_data_tb             <= 32d"2";
      imm_tb                  <= 32d"3";
      wait for 5 ns;
      
      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
