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


   component counter1 is
      generic(
         G_COUNTER1_VALUE : positive := C_COUNTER1_VALUE - 1
      ); port(
         i_rst_n           : in std_logic;
         i_clk             : in std_logic;
         i_cnt1_we         : in std_logic;
         i_cnt1_set_reset  : in std_logic;
         o_cnt1_overflow   : out std_logic;
         o_cnt1_q          : out integer range 0 to C_COUNTER1_VALUE - 1
   );
   end component counter1;


   -- General
   type t_spi_states          is (START, STOP, DATA, IDLE);
   signal spi_states          : t_spi_states;
   signal s_spi_sclk              : std_logic;
   -- Transmit purposes
   signal s_cnt1_we_tx        : std_logic;
   signal s_cnt1_set_reset_tx : std_logic;
   signal s_cnt1_overflow_tx  : std_logic;
   signal s_spi_ss_n          : std_logic;
   signal buffer_spi_mosi     : std_logic_vector(31 downto 0);
   signal bit_cnt_tx          : integer range 0 to 31; -- TODO: range up to constant
   -- Receive purposes
   signal s_cnt1_we_rx        : std_logic;
   signal s_cnt1_set_reset_rx : std_logic;
   signal s_cnt1_overflow_rx  : std_logic;
   signal s_spi_mosi          : std_logic;
   signal buffer_spi_miso     : std_logic_vector(7 downto 0);


begin


   inst_counter_tx : component counter1
   generic map (
      G_COUNTER1_VALUE => positive(real(C_FREQUENCY_HZ)/(real(G_SPI_FREQUENCY_HZ)))
   ) port map (
      i_rst_n              => i_rst_n,
      i_clk                => i_clk,
      i_cnt1_we            => s_cnt1_we_tx,
      i_cnt1_set_reset     => s_cnt1_set_reset_tx,
      o_cnt1_overflow      => s_cnt1_overflow_tx,
      o_cnt1_q             => open
   );


   inst_counter_rx : component counter1
   generic map (
      G_COUNTER1_VALUE => positive(real(C_FREQUENCY_HZ)/(real(G_SPI_FREQUENCY_HZ)))
   ) port map (
      i_rst_n              => i_rst_n,
      i_clk                => i_clk,
      i_cnt1_we            => s_cnt1_we_rx,
      i_cnt1_set_reset     => s_cnt1_set_reset_rx,
      o_cnt1_overflow      => s_cnt1_overflow_rx,
      o_cnt1_q             => open
   );


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
