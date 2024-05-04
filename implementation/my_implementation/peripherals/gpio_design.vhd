--------------------------------------------------------------------------------
-- File          : gpio_design.vhd
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : The output ports of this module are GPIO, which are connected
-- to the riscpol_design module, and there to the physical outputs of the FPGA.
-- The MMIO mechanism was used here (see Wikipedia) or comments below.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;

entity gpio is
   port (
      i_clk    : in std_logic;
      i_addr   : in integer range 0 to C_RAM_LENGTH-1;
      i_wdata  : in std_logic_vector(31 downto 0);
      o_gpio   : out std_logic_vector(7 downto 0)
);
end gpio;

architecture rtl of gpio is

begin

   p_gpio : process(i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         -- The C_MMIO_ADDR_GPIO constant describes which RAM address is mapped
         -- and used by the GPIO. In the case of GPIO control, use the command
         -- to write to RAM (sw, sh, sb) to the C_MMIO_ADDR_GPIO address and the
         -- data that would be written to RAM is assigned to GPIO. Example of
         -- assigning zeros to GPIO:
         -- sb x0, C_MMIO_ADDR_GPIO*4-1
         -- For C_MMIO_ADDR_GPIO = 64 will be:
         -- sb x0, 255(x0)
         if (i_addr = C_MMIO_ADDR_GPIO-1) then
            -- Last 8 bits from wdata vector are mapped
            o_gpio(0) <= i_wdata(24);
            o_gpio(1) <= i_wdata(25);
            o_gpio(2) <= i_wdata(26);
            o_gpio(3) <= i_wdata(27);
            -- o_gpio(4) <= i_wdata(28);
            -- o_gpio(5) <= i_wdata(29);
            -- o_gpio(6) <= i_wdata(30);
            -- o_gpio(7) <= i_wdata(31);
         end if;
      end if;
   end process p_gpio;

end rtl;
