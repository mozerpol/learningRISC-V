--------------------------------------------------------------------------------
-- File          : uart.vhdl
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


entity uart is 
   generic(
      G_BAUD            : positive := C_BAUD;
      G_FREQUENCY_MHZ   : positive := C_FREQUENCY_MHZ
   ); port (
      i_rst_n           : in std_logic;
      i_clk             : in std_logic;
      i_uart_rx         : in std_logic;
      o_uart_tx         : out std_logic
);
end entity uart;


architecture rtl of uart is


begin


   p_uart : process(i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst_n = '0') then
            NULL;
         else
            NULL;
         end if;   
      end if;
   end process p_uart;


end architecture rtl;
