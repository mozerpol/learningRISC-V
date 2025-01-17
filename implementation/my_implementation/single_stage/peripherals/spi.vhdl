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
   signal s_spi_sclk          : std_logic;
   signal s_toggle_flag       : std_logic;
   -- Transmit purposes
   signal s_cnt1_we_tx        : std_logic;
   signal s_cnt1_set_reset_tx : std_logic;
   signal s_cnt1_overflow_tx  : std_logic;
   signal s_spi_ss_n          : std_logic;
   signal buffer_spi_mosi     : std_logic_vector(31 downto 0);
   signal bit_cnt_tx          : integer range 0 to 32;
   -- Receive purposes
   signal s_cnt1_we_rx        : std_logic;
   signal s_cnt1_set_reset_rx : std_logic;
   signal s_cnt1_overflow_rx  : std_logic;
   signal s_spi_mosi          : std_logic;
   signal buffer_spi_miso     : std_logic_vector(7 downto 0);


begin


   inst_counter_tx : component counter1
   generic map (
      G_COUNTER1_VALUE => positive(((real(C_FREQUENCY_HZ/G_SPI_FREQUENCY_HZ))/2.0)-1.0)
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
      G_COUNTER1_VALUE => positive(((real(C_FREQUENCY_HZ/G_SPI_FREQUENCY_HZ))/2.0)-1.0)
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
      if (i_clk'event and i_clk = '1') then
         if (i_rst_n = '0') then
            s_cnt1_we_tx         <= '0';
            s_cnt1_set_reset_tx  <= '0';
            s_spi_ss_n           <= '1';
            s_spi_sclk           <= '0';
            spi_states           <= IDLE;
            s_toggle_flag        <= '0';
            s_spi_mosi           <= 'Z';
            bit_cnt_tx           <= 0;
         else
            case (spi_states) is

               when IDLE   =>

                  s_spi_sclk           <= '0';
                  s_spi_mosi           <= 'Z';
                  s_toggle_flag        <= '0';
                  if (i_spi_we = '1') then
                     spi_states        <= START;
                     buffer_spi_mosi   <= i_spi_wdata; -- Latch data to send
                     s_spi_ss_n        <= '0';
                  end if;

               when START  =>

                  spi_states           <= DATA;
                  s_cnt1_we_tx         <= '1';
                  s_cnt1_set_reset_tx  <= '1';

               when DATA   =>

                  if (s_cnt1_overflow_tx = '1') then
                     s_spi_sclk           <= not(s_spi_sclk);
                     if (s_toggle_flag = '0') then
                        s_toggle_flag        <= '1';
                        s_spi_mosi           <= buffer_spi_mosi(31);
                        buffer_spi_mosi      <= buffer_spi_mosi(30 downto 0) &
                                                buffer_spi_mosi(31);
                        if (bit_cnt_tx = 32) then
                           spi_states           <= IDLE;
                           bit_cnt_tx           <= 0;
                           s_cnt1_set_reset_tx  <= '0';
                           s_spi_ss_n           <= '1';
                        else
                           bit_cnt_tx           <= bit_cnt_tx + 1;
                        end if;
                     else
                        s_toggle_flag        <= '0';
                     end if;
                  end if;

               when others =>

                  spi_states              <= IDLE;
                  bit_cnt_tx              <= 0;
                  s_cnt1_we_tx            <= '0';
                  s_cnt1_set_reset_tx     <= '0';
                  s_spi_ss_n              <= '1';
                  s_spi_sclk              <= '0';
                  s_spi_mosi              <= 'Z';
                  s_toggle_flag           <= '0';

            end case;
         end if;
         o_spi_ss_n  <= s_spi_ss_n;
         o_spi_mosi  <= s_spi_mosi;
         o_spi_sclk  <= s_spi_sclk;
      end if;
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
