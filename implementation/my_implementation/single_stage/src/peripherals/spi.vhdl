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
      G_SPI_FREQUENCY_HZ   : positive := C_SPI_FREQUENCY_HZ;
      G_SPI_DATA_LENGTH    : positive := C_SPI_DATA_LENGTH;
      G_SPI_CPOL           : natural range 0 to 1 := C_SPI_CPOL;
      G_SPI_CPHA           : natural range 0 to 1 := C_SPI_CPHA
   );
   port (
      i_rst_n              : in std_logic;
      i_clk                : in std_logic;
      i_spi_wdata          : in std_logic_vector(31 downto 0);
      i_spi_we_ctrl        : in std_logic;
      i_spi_we_data        : in std_logic;
      i_spi_miso           : in std_logic;  -- master in, slave out
      o_spi_mosi           : out std_logic; -- master out, slave in
      o_spi_ss_n           : out std_logic; -- slave select / chip select
      o_spi_sclk           : out std_logic; -- spi clock
      o_spi_data           : out std_logic_vector(31 downto 0);
      o_spi_status         : out std_logic_vector(31 downto 0)
);
end entity spi;


architecture rtl of spi is


   component counter1 is
      generic(
         G_COUNTER1_VALUE : positive
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
   type t_spi_states          is (IDLE, LEADING_EDGE, DATA, TRAILING_EDGE);
   signal f_set_initial_value : std_logic;
   -- Timer
   signal s_cnt1_overflow     : std_logic;
   signal s_cnt1_we           : std_logic;
   signal s_cnt1_set_reset    : std_logic;
   -- Transmit purposes
   signal fsm_tx              : t_spi_states;
   signal reg_spi_mosi        : std_logic_vector(31 downto 0);
   signal bit_cnt_tx          : natural range 0 to G_SPI_DATA_LENGTH;
   signal s_status_tx_busy    : std_logic;
   signal s_rising_edge_sclk_tx : std_logic;
   -- Receive purposes
   signal reg_spi_miso        : std_logic_vector(7 downto 0);
   signal s_status_rx_ready   : std_logic;
   signal s_spi_sclk          : std_logic;
   signal s_spi_ss_n_tx       : std_logic;

signal s_clock_on_tx : std_logic;

begin


   inst_counter: component counter1
   generic map (
      G_COUNTER1_VALUE => positive(((real(C_FREQUENCY_HZ/G_SPI_FREQUENCY_HZ))/2.0)-1.0)
   ) port map (
      i_rst_n              => i_rst_n,
      i_clk                => i_clk,
      i_cnt1_we            => '1',
      i_cnt1_set_reset     => s_cnt1_set_reset,
      o_cnt1_overflow      => s_cnt1_overflow,
      o_cnt1_q             => open
   );


   o_spi_sclk                 <= s_spi_sclk;
   o_spi_ss_n                 <= s_spi_ss_n_tx;
   o_spi_status(0)            <= s_status_tx_busy;
   o_spi_status(1)            <= s_status_rx_ready;
   o_spi_status(31 downto 2)  <= (others => '0');


   p_spi_clock_gen : process (i_clk)
   begin
      if (rising_edge(i_clk)) then
         if (i_rst_n = '0') then
            if (G_SPI_CPOL = 1) then
               s_spi_sclk        <= '1';
            else
               s_spi_sclk        <= '0';
            end if;
         else
            -- TODO: I think the fastest way is to add control signal:
            -- if (s_clock_on_tx = '1') then... change state
            if (s_clock_on_tx = '1') then
                if (s_cnt1_overflow = '1') then
                   s_spi_sclk        <= not(s_spi_sclk);
                end if;
            else
                if (G_SPI_CPOL = 1) then
                   s_spi_sclk        <= '1';
                else
                   s_spi_sclk        <= '0';
                end if;
            end if;
         end if;
      end if;
   end process;


   p_tx : process (i_clk)
   begin
      if (rising_edge(i_clk)) then
         if (i_rst_n = '0') then
            fsm_tx                  <= IDLE;
            o_spi_mosi              <= 'Z';
            bit_cnt_tx              <= 0;
            s_status_tx_busy        <= '0';
            s_cnt1_set_reset        <= '0';
            s_spi_ss_n_tx           <= '1';
            s_clock_on_tx           <= '0'; 
         else
            case (fsm_tx) is

               when IDLE   =>

                  o_spi_mosi        <= 'Z';
                  s_status_tx_busy  <= '0';
                  s_cnt1_set_reset  <= '0';
                  if (i_spi_we_data = '1') then
                     fsm_tx            <= LEADING_EDGE;
                     reg_spi_mosi      <= i_spi_wdata; -- Latch data to send
                     s_status_tx_busy  <= '1';
                     s_cnt1_set_reset  <= '1';
                  end if;

               when LEADING_EDGE =>

                  s_spi_ss_n_tx     <= '0';
                  s_clock_on_tx     <= '1';
                  if (C_SPI_CPHA = 0) then
                     o_spi_mosi   <= reg_spi_mosi(0); -- LSB is send first
                     reg_spi_mosi <= reg_spi_mosi(0) & reg_spi_mosi(31 downto 1);
                     bit_cnt_tx   <= bit_cnt_tx + 1;
                  end if;
                  fsm_tx            <= DATA;

               when DATA   =>

                  if ((C_SPI_CPHA = 0 and s_spi_sclk = '1') or
                     (C_SPI_CPHA = 1 and s_spi_sclk = '0')) then
                     if (s_cnt1_overflow = '1') then
                        if (bit_cnt_tx = G_SPI_DATA_LENGTH) then
                           o_spi_mosi   <= 'Z';
                           bit_cnt_tx   <= 0;
                           s_clock_on_tx     <= '0';
                           fsm_tx       <= TRAILING_EDGE;
                        else
                           o_spi_mosi   <= reg_spi_mosi(0); -- LSB is send first
                           reg_spi_mosi <= reg_spi_mosi(0) & reg_spi_mosi(31 downto 1);
                           bit_cnt_tx   <= bit_cnt_tx + 1;
                        end if;
                     end if;
                  end if;
                 
               when TRAILING_EDGE   =>
               
                  if (C_SPI_CPHA = 0) then
                     if (s_cnt1_overflow = '1') then
                        s_spi_ss_n_tx     <= '1';
                        fsm_tx            <= IDLE;
                     end if;
                  else
                      s_spi_ss_n_tx     <= '1';
                      fsm_tx            <= IDLE;
                  end if;

               when others =>

                  fsm_tx            <= IDLE;
                  bit_cnt_tx        <= 0;
                  o_spi_mosi        <= 'Z';
                  s_status_tx_busy  <= '0';
                  s_clock_on_tx     <= '0';

            end case;
         end if;
      end if;
   end process;


   p_rx : process (i_clk)
   begin
      if (rising_edge(i_clk)) then
         if (i_rst_n = '0') then
            s_status_rx_ready          <= '0';
         else
         end if;
      end if;
   end process;


end architecture rtl;
