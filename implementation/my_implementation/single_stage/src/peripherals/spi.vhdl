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
      i_spi_control        : in std_logic_vector(7 downto 0);
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
   type t_spi_states          is (IDLE, DATA, STOP);
   signal spi_states          : t_spi_states;
   -- Timer
   signal s_cnt1_overflow     : std_logic;
   -- Transmit purposes
   signal reg_spi_mosi        : std_logic_vector(31 downto 0);
   signal bit_cnt_tx          : natural range 0 to 32;
   -- Receive purposes
   signal reg_spi_miso        : std_logic_vector(7 downto 0);


begin


   inst_counter: component counter1
   generic map (
      G_COUNTER1_VALUE => positive(((real(C_FREQUENCY_HZ/G_SPI_FREQUENCY_HZ))/2.0)-1.0)
   ) port map (
      i_rst_n              => i_rst_n,
      i_clk                => i_clk,
      i_cnt1_we            => i_spi_control(0),
      i_cnt1_set_reset     => i_spi_control(0),
      o_cnt1_overflow      => s_cnt1_overflow,
      o_cnt1_q             => open
   );


   o_spi_sclk <= s_cnt1_overflow when i_spi_we = '1';
   o_spi_ss_n <= i_spi_control(1) when i_spi_we = '1';


   p_tx : process (i_clk)
   begin
      if (rising_edge(i_clk)) then
         if (i_rst_n = '0') then
            spi_states           <= IDLE;
            o_spi_mosi           <= 'Z';
            bit_cnt_tx           <= 0;
         else
            case (spi_states) is

               when IDLE   =>

                  o_spi_mosi           <= 'Z';
                  if (i_spi_we = '1' and i_spi_control(2) = '1') then
                     spi_states     <= DATA;
                     reg_spi_mosi   <= i_spi_wdata; -- Latch data to send
                  end if;

               when DATA   =>

                  if (s_cnt1_overflow = '1') then
                     o_spi_mosi           <= reg_spi_mosi(31);
                     reg_spi_mosi          <= reg_spi_mosi(30 downto 0) & reg_spi_mosi(31);
                     if (bit_cnt_tx = 32) then
                        spi_states           <= IDLE;
                        bit_cnt_tx           <= 0;
                     else
                        bit_cnt_tx           <= bit_cnt_tx + 1;
                     end if;
                  end if;

               when others =>

                  spi_states              <= IDLE;
                  bit_cnt_tx              <= 0;
                  o_spi_mosi              <= 'Z';

            end case;
         end if;
         o_spi_mosi  <= o_spi_mosi;
      end if;
   end process;


   p_rx : process (i_clk)
   begin
      if (rising_edge(i_clk)) then
         if (i_rst_n = '0') then
         else
         end if;
      end if;
   end process;


end architecture rtl;
