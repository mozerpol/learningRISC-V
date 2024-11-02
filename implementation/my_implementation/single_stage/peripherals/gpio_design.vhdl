--------------------------------------------------------------------------------
-- File          : gpio_design.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : The output ports of this module are GPIO, which are connected
-- to the physical outputs of the FPGA. The MMIO mechanism was used here (see 
-- Wikipedia) or comments below.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;

entity gpio is
   port (
      i_clk          : in std_logic;
      i_gpio_wdata   : in std_logic_vector(31 downto 0); -- Why 32 bits if we're
      -- using only 8? Maybe it shoudl depend on constant and be generated
      -- in for loop, I mean o_gpio_q(constant_number) should be generated. Look
      -- to ram.vhdl as generate example.
      i_gpio_we      : in std_logic;
      o_gpio_q       : out std_logic_vector(7 downto 0)
);
end gpio;

architecture rtl of gpio is

begin

   p_gpio : process(i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         -- The C_MMIO_ADDR_GPIO constant describes which RAM address is mapped
         -- and used by the GPIO. To control GPIO, use the sw, sh, sb commands.
         -- Example of assigning zeros to GPIO:
         -- sb x0, 255(x0)
         -- 255, because C_MMIO_ADDR_GPIO*4-1
         -- To see more examples of GPIO usage, check out the tests in the 
         -- riscpol_tb.vhdl file.
         if (i_gpio_we = '1') then
            -- Last 8 bits from wdata vector are mapped
            o_gpio_q(0) <= i_gpio_wdata(24);
            o_gpio_q(1) <= i_gpio_wdata(25);
            o_gpio_q(2) <= i_gpio_wdata(26);
            o_gpio_q(3) <= i_gpio_wdata(27);
            o_gpio_q(4) <= i_gpio_wdata(28);
            o_gpio_q(5) <= i_gpio_wdata(29);
            o_gpio_q(6) <= i_gpio_wdata(30);
            o_gpio_q(7) <= i_gpio_wdata(31);
         end if;
      end if;
   end process p_gpio;

end rtl;
