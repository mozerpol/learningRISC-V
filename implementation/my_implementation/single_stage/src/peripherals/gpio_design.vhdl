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
      i_rst_n        : in std_logic;
      i_clk          : in std_logic;
      i_gpio_wdata   : in std_logic_vector(31 downto 0);
      i_gpio_we      : in std_logic;
      i_gpio_re      : in std_logic;
      o_gpio_q       : out std_logic_vector(31 downto 0)
);
end gpio;


architecture rtl of gpio is


   signal reg_gpio_q : std_logic_vector(31 downto 0);


begin

   
   o_gpio_q <= (others => 'Z') when i_gpio_re = '1' else 
               reg_gpio_q when i_gpio_we = '1' else reg_gpio_q;


   p_gpio : process(i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst_n = '0') then
            reg_gpio_q <= (others => 'Z');
         else
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
                  reg_gpio_q(i) <= i_gpio_wdata(32-C_NUMBER_OF_GPIO+i);
               end loop;
               -- The youngest bits are GPIO, and the oldest bits, unused by
               -- GPIO, are zeros.
               reg_gpio_q(31 downto C_NUMBER_OF_GPIO) <= (others => '0');
            end if;
         end if;
      end if;
   end process p_gpio;


end rtl;
