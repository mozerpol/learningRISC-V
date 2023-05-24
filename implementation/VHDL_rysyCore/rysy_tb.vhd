library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;
   
entity rysy_tb is
end rysy_tb;

architecture tb of rysy_tb is

   component rysy is
   port (
      clk   : in std_logic;
      rst   : in std_logic;
      gpio  : out std_logic_vector(3 downto 0)
   );
   end component rysy;

   signal clk_tb  :   std_logic;
   signal rst_tb  :   std_logic;
   signal gpio_tb :   std_logic_vector(3 downto 0);

begin
   inst_rysy : component rysy
   port map (
      clk   => clk_tb,
      rst   => rst_tb,
      gpio  => gpio_tb
   );

   p_tb : process
   begin

      wait for 25 ns;
      stop(2); 
   end process p_tb;

   p_clock_gen : process
   begin
      clk_tb <= '0';
      wait for 5 ns;
      clk_tb <= '1';
      wait for 5 ns;
   end process p_clock_gen;

end architecture tb;
