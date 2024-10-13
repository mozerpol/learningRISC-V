--------------------------------------------------------------------------------
-- File          : bus_interconnect.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : 
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;

entity bus_interconnect is
   port (
      i_write_enable_bus   : out std_logic;
      i_raddr_bus          : out integer range 0 to C_RAM_LENGTH-1;
      i_waddr_bus          : out integer range 0 to C_RAM_LENGTH-1;
      o_chip_enable_bus    : out std_logic
);
end bus_interconnect;

architecture rtl of bus_interconnect is

begin

   p_bus_interconnect : process(i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
      end if;
   end process p_bus_interconnect;

end rtl;
