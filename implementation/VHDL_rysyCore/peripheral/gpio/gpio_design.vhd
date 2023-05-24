library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library gpio_lib;
   use gpio_lib.all;
   use gpio_lib.gpio_pkg.all;


entity gpio is
   port (
      addr  : in std_logic_vector(7 downto 0);
      be    : in std_logic_vector(3 downto 0);
      wdata : in std_logic_vector(31 downto 0);
      we    : in std_logic;
      clk   : in std_logic;
      rst   : in std_logic;
      q     : out std_logic_vector(31 downto 0);
      gpio  : out std_logic_vector(3 downto 0)
   );
end entity gpio;


architecture rtl of gpio is

   signal gpio_state : std_logic_vector(31 downto 0);

begin

   p_main : process (clk)
   begin
      if (rst = '1') then
         gpio_state <= (others => '0');
      elsif (clk'event and clk = '1') then
         if (we = '0' and addr = "00000000") then
            gpio_state <= wdata;
         end if;
      end if;
   end process p_main;

   gpio  <= not(gpio_state(3 downto 0));
   q     <= gpio_state;

end architecture rtl;
