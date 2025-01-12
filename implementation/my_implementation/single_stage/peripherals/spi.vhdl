--------------------------------------------------------------------------------
-- File          : spi.vhdl
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
library counter1_lib;


entity spi is
   generic(
      G_SPI_FREQUENCY_HZ   : positive := C_SPI_FREQUENCY_HZ
   );
   port (
      i_rst_n              : in std_logic;
      i_clk                : in std_logic;
      i_spi_wdata          : in std_logic_vector(31 downto 0);
      i_spi_we             : in std_logic;
      i_spi_miso           : in std_logic;  -- master in, slave out
      o_spi_ss_n           : out std_logic; -- slave select / chip select
      o_spi_mosi           : out std_logic; -- master out, slave in
      o_spi_sclk           : out std_logic;
      o_spi_data           : out std_logic_vector(31 downto 0)
);
end entity spi;


architecture rtl of spi is





begin


   

   p_tx : process (i_clk)
   begin

   end process;


   p_rx : process (i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst_n = '0') then
         else
         end if;
      end if;
   end process;


end architecture rtl;
