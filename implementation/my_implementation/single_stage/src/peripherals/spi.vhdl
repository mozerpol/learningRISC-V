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
   use ieee.numeric_std.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;
library counter1_lib;


entity spi is
   generic(
      G_SPI_FREQUENCY_HZ   : positive := C_SPI_FREQUENCY_HZ;
      G_SPI_CPOL           : natural range 0 to 1 := C_SPI_CPOL;
      G_SPI_CPHA           : natural range 0 to 1 := C_SPI_CPHA
   );
   port (
      i_rst_n              : in std_logic;
      i_clk                : in std_logic;
      i_spi_wdata          : in std_logic_vector(31 downto 0);
      i_spi_write          : in std_logic;
      i_spi_read           : in std_logic;
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
         G_COUNTER1_VALUE  : positive
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
   type t_spi_states          is (ST_IDLE, ST_LEADING_EDGE, ST_DATA, ST_TRAILING_EDGE);
   -- Timer
   signal s_cnt1_overflow     : std_logic;
   -- Clock generation
   signal s_spi_sclk          : std_logic;
   -- Transmit purposes
   signal s_cnt1_set_reset_tx : std_logic;
   signal fsm_tx              : t_spi_states;
   signal slv_spi_mosi        : std_logic_vector(7 downto 0);
   signal cnt_bit_tx          : natural range 0 to 16;
   signal s_status_tx_busy    : std_logic;
   signal s_sclk_on_tx        : std_logic;
   signal s_spi_ss_n_tx       : std_logic;
   signal s_half_of_data_tx   : std_logic;
   -- Receive purposes
   signal s_cnt1_set_reset_rx : std_logic;
   signal fsm_rx              : t_spi_states;
   signal slv_spi_miso        : std_logic_vector(7 downto 0);
   signal cnt_bit_rx          : natural range 0 to 16;
   signal s_status_rx_ready   : std_logic;
   signal s_status_rx_busy    : std_logic;
   signal s_sclk_on_rx        : std_logic;
   signal s_spi_ss_n_rx       : std_logic;
   signal s_half_of_data_rx   : std_logic;


begin


   inst_counter: component counter1
   generic map (
      G_COUNTER1_VALUE => positive(((real(C_FREQUENCY_HZ/G_SPI_FREQUENCY_HZ))/2.0)-1.0)
   ) port map (
      i_rst_n              => i_rst_n,
      i_clk                => i_clk,
      i_cnt1_we            => '1',
      i_cnt1_set_reset     => s_cnt1_set_reset_tx or s_cnt1_set_reset_rx,
      o_cnt1_overflow      => s_cnt1_overflow,
      o_cnt1_q             => open
   );


   o_spi_sclk                 <= s_spi_sclk;
   o_spi_ss_n                 <= s_spi_ss_n_tx and s_spi_ss_n_rx;
   o_spi_status(0)            <= s_status_tx_busy; -- TODO: is it busy or ready?
   o_spi_status(1)            <= s_status_rx_busy;
   o_spi_status(2)            <= s_status_rx_ready;
   o_spi_status(31 downto 3)  <= (others => '0');


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
            if (s_sclk_on_tx = '1' or s_sclk_on_rx = '1') then
               if (s_cnt1_overflow = '1') then
                  s_spi_sclk           <= not(s_spi_sclk);
               end if;
            end if;
         end if;
      end if;
   end process p_spi_clock_gen;


   p_tx : process (i_clk)
   begin
      if (rising_edge(i_clk)) then
         if (i_rst_n = '0') then
            fsm_tx               <= ST_IDLE;
            o_spi_mosi           <= 'Z';
            cnt_bit_tx           <= 0;
            s_status_tx_busy     <= '0';
            s_spi_ss_n_tx        <= '1';
            s_sclk_on_tx         <= '0';
            s_cnt1_set_reset_tx  <= '0';
            s_half_of_data_tx    <= '0';
         else
            case (fsm_tx) is

               when ST_IDLE   =>

                  o_spi_mosi           <= 'Z';
                  if (i_spi_write = '1') then
                     s_status_tx_busy     <= '1';
                     slv_spi_mosi         <= i_spi_wdata(7 downto 0); -- Latch data to send
                     fsm_tx               <= ST_LEADING_EDGE;
                     s_cnt1_set_reset_tx  <= '1';
                  end if;

               when ST_LEADING_EDGE =>

                  if (s_cnt1_overflow = '1') then
                     s_spi_ss_n_tx        <= '0';
                     s_sclk_on_tx         <= '1';
                     cnt_bit_tx           <= cnt_bit_tx + 1;
                     fsm_tx               <= ST_DATA;
                     if (G_SPI_CPHA = 0) then
                        o_spi_mosi           <= slv_spi_mosi(0); -- LSB is send first
                        slv_spi_mosi         <= slv_spi_mosi(0) & slv_spi_mosi(7 downto 1);
                        s_half_of_data_tx    <= '1';
                     end if;
                  end if;

               when ST_DATA   =>

                  if (s_cnt1_overflow = '1') then
                     if (cnt_bit_tx = 16) then
                        s_sclk_on_tx         <= '0';
                        cnt_bit_tx           <= 0;
                        fsm_tx               <= ST_TRAILING_EDGE;
                        if (G_SPI_CPHA = 0) then
                           o_spi_mosi           <= 'Z';
                        end if;
                     else
                        cnt_bit_tx           <= cnt_bit_tx + 1;
                        if (s_half_of_data_tx = '1') then
                            s_half_of_data_tx    <= '0';
                        else
                           o_spi_mosi           <= slv_spi_mosi(0); -- LSB is send first
                           slv_spi_mosi         <= slv_spi_mosi(0) & slv_spi_mosi(7 downto 1);
                           s_half_of_data_tx    <= '1';
                        end if;
                     end if;
                  end if;

               when ST_TRAILING_EDGE =>

                  if (s_cnt1_overflow = '1') then
                     fsm_tx               <= ST_IDLE;
                     s_cnt1_set_reset_tx  <= '0';
                     s_spi_ss_n_tx        <= '1';
                     o_spi_mosi           <= 'Z';
                     s_status_tx_busy     <= '0';
                  end if;

               when others =>

                  fsm_tx               <= ST_IDLE;
                  o_spi_mosi           <= 'Z';
                  cnt_bit_tx           <= 0;
                  s_status_tx_busy     <= '0';
                  s_spi_ss_n_tx        <= '1';
                  s_sclk_on_tx         <= '0';
                  s_cnt1_set_reset_tx  <= '0';
                  s_half_of_data_tx    <= '0';

            end case;
         end if;
      end if;
   end process p_tx;


 -- TODO:
 -- add a new port i_spi_re_data. When high state occurs on this input bit
 -- it means turn on sclk, after shift data in rx register. After rx is complete
 -- then set o_spi_status valid data bit.
 -- Add additional process for reseting this valid data bit. Maybe modify
 -- i_spi_we_ctrl input signal?

   p_rx : process (i_clk)
   begin
      if (rising_edge(i_clk)) then
         if (i_rst_n = '0') then
            fsm_rx                  <= ST_IDLE;
            cnt_bit_rx              <= 0;
            s_status_rx_ready       <= '0';
            s_status_rx_busy        <= '0';
            s_spi_ss_n_rx           <= '1';
            s_sclk_on_rx            <= '0';
            s_cnt1_set_reset_rx     <= '0';
            s_half_of_data_rx       <= '0';
         else
            case (fsm_rx) is

               when ST_IDLE   =>

                  if (i_spi_read = '1' and i_spi_wdata(0) = '1') then
                     -- start reading data from slave
                     fsm_rx               <= ST_LEADING_EDGE;
                     s_cnt1_set_reset_rx  <= '1';
                     s_status_rx_busy     <= '1';
                  elsif (i_spi_read = '1' and i_spi_wdata(0) = '0') then
                     s_status_rx_ready       <= '0';
                  end if;

               when ST_LEADING_EDGE =>

                  if (s_cnt1_overflow = '1') then
                     s_spi_ss_n_rx        <= '0';
                     s_sclk_on_rx         <= '1';
                     cnt_bit_rx           <= cnt_bit_rx + 1;
                     fsm_rx               <= ST_DATA;
                     if (G_SPI_CPHA = 0) then
                        s_half_of_data_rx    <= '1';
                     end if;
                  end if;

               when ST_DATA   =>

                  if (s_cnt1_overflow = '1') then
                     if (cnt_bit_rx = 16) then
                        s_sclk_on_rx         <= '0';
                        cnt_bit_rx           <= 0;
                        fsm_rx               <= ST_TRAILING_EDGE;
                        if (G_SPI_CPHA = 0) then

                        end if;
                     else
                        cnt_bit_rx           <= cnt_bit_rx + 1;
                        if (s_half_of_data_rx = '1') then
                            s_half_of_data_rx    <= '0';
                        else
                           s_half_of_data_rx    <= '1';
                        end if;
                     end if;
                  end if;

               when ST_TRAILING_EDGE =>

                  if (s_cnt1_overflow = '1') then
                     fsm_rx               <= ST_IDLE;
                     s_cnt1_set_reset_rx  <= '0';
                     s_spi_ss_n_rx        <= '1';
                     s_status_rx_busy     <= '0';
                     s_status_rx_ready    <= '1';
                  end if;

               when others =>

                  fsm_rx               <= ST_IDLE;
                  cnt_bit_rx           <= 0;
                  s_status_rx_ready    <= '0';
                  s_status_rx_busy     <= '0';
                  s_spi_ss_n_rx        <= '1';
                  s_sclk_on_rx         <= '0';
                  s_cnt1_set_reset_rx  <= '0';
                  s_half_of_data_rx    <= '0';

            end case;
         end if;
      end if;
   end process p_rx;


end architecture rtl;
