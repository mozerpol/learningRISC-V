library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity mux_reg_file_tb is
end mux_reg_file_tb;

architecture tb of mux_reg_file_tb is

   component mux_reg_file is
   port (
      i_rst                : in std_logic;
      i_alu_result         : in std_logic_vector(31 downto 0);
      i_instruction        : in std_logic_vector(31 downto 0);
      i_mux_reg_file_ctrl  : in std_logic;
      o_rd_data            : out std_logic_vector(31 downto 0);
      o_instruction        : out std_logic_vector(31 downto 0)
   );
   end component mux_reg_file;

   signal rst_tb                 : std_logic;
   signal alu_result_tb          : std_logic_vector(31 downto 0);
   signal instruction_in_tb      : std_logic_vector(31 downto 0);
   signal mux_reg_file_ctrl_tb   : std_logic;
   signal rd_data_tb             : std_logic_vector(31 downto 0);
   signal instruction_out_tb     : std_logic_vector(31 downto 0);

begin

   inst_mux_reg_file : component mux_reg_file
   port map (
      i_rst                => rst_tb,
      i_alu_result         => alu_result_tb,
      i_instruction        => instruction_in_tb,
      i_mux_reg_file_ctrl  => mux_reg_file_ctrl_tb,
      o_rd_data            => rd_data_tb,
      o_instruction        => instruction_out_tb
   );

   p_tb : process
   begin
      
      rst_tb               <= '1';
      alu_result_tb        <= (others => '0');
      instruction_in_tb    <= (others => '0');
      mux_reg_file_ctrl_tb <= '0';
      wait for 5 ns;

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
