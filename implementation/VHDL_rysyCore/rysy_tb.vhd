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
   generic (
      CODE    : string  := "ram_content_hex.txt"
   );
   port (
      i_clk   : in std_logic;
      i_rst   : in std_logic;
      o_gpio  : out std_logic_vector(3 downto 0)
   );
   end component rysy;

   signal clk_tb  :   std_logic;
   signal rst_tb  :   std_logic;
   signal gpio_tb :   std_logic_vector(3 downto 0);

begin
   inst_rysy : component rysy
   generic map(
      CODE => "ram_content_hex.txt"
   )
   port map (
      i_clk   => clk_tb,
      i_rst   => rst_tb,
      o_gpio  => gpio_tb
   );

   p_tb : process
   begin
      
      rst_tb <= '0';
      wait for 25 ns;
      rst_tb <= '1';

      wait for 100 ns;
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
