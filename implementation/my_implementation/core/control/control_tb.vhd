library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;

entity control_tb is
end control_tb;

architecture tb of control_tb is

   component control is
   port (
      i_rst             : in std_logic;
      i_opcode          : in std_logic_vector(6 downto 0);
      i_func3           : in std_logic_vector(2 downto 0);
      i_func7           : in std_logic_vector(6 downto 0);
      o_alu_mux_1_ctrl  : out std_logic;
      o_alu_mux_2_ctrl  : out std_logic;
      o_control_alu     : out std_logic_vector(5 downto 0)
   );
   end component control;

   signal rst_tb             : std_logic;
   signal opcode_tb          : std_logic_vector(6 downto 0);
   signal func3_tb           : std_logic_vector(2 downto 0);
   signal func7_tb           : std_logic_vector(6 downto 0);
   signal alu_mux_1_ctrl_tb  : std_logic;
   signal alu_mux_2_ctrl_tb  : std_logic;
   signal control_alu_tb     : std_logic_vector(5 downto 0);

begin

   inst_control : component control
   port map (
      i_rst             => rst_tb,
      i_opcode          => opcode_tb,
      i_func3           => func3_tb,
      i_func7           => func7_tb,
      o_alu_mux_1_ctrl  => alu_mux_1_ctrl_tb,
      o_alu_mux_2_ctrl  => alu_mux_2_ctrl_tb,
      o_control_alu     => control_alu_tb
   );

   p_tb : process
   begin

      rst_tb      <= '1';
      opcode_tb   <= (others => '0');
      func3_tb    <= (others => '0');
      func7_tb    <= (others => '0');
      wait for 5 ns;
      rst_tb      <= '0';


      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
