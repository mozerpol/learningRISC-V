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
      o_gpio_q       : out std_logic_vector(31 downto 0)
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
            -- Last C_NUMBER_OF_GPIO-1 bits from wdata vector are mapped
            for i in 0 to C_NUMBER_OF_GPIO - 1 loop
               o_gpio_q(i) <= i_gpio_wdata(32-C_NUMBER_OF_GPIO+i);
            end loop;
            -- TODO: describe below line
            o_gpio_q(31 downto C_NUMBER_OF_GPIO) <= (others => '0');
         end if;
      end if;
   end process p_gpio;


end rtl;
