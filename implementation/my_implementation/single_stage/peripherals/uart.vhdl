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
library counter8bit_lib;


entity uart is
   generic(
      G_BAUD               : positive := C_BAUD;
      G_FREQUENCY_MHZ      : positive := C_FREQUENCY_MHZ -- TODO: change to hz
   ); port (
      i_rst_n              : in std_logic;
      i_clk                : in std_logic;
      i_uart_wdata         : in std_logic_vector(31 downto 0);
      i_uart_rx            : in std_logic;
      i_uart_we            : in std_logic;
      i_uart_re            : in std_logic;
      o_uart_data          : out std_logic_vector(31 downto 0);
      o_uart_tx            : out std_logic
);
end entity uart;


architecture rtl of uart is

   component counter8 is
      generic(
         G_COUNTER_8BIT_VALUE : positive := C_COUNTER_8BIT_VALUE - 1
      ); port(
         i_rst_n           : in std_logic;
         i_clk             : in std_logic;
         i_cnt8_we         : in std_logic;
         i_cnt8_set_reset  : in std_logic;
         o_cnt8_overflow   : out std_logic;
         o_cnt8_q          : out integer range 0 to C_COUNTER_8BIT_VALUE - 1
   );
   end component counter8;


   -- General
   type t_uart_states         is (START, STOP, DATA, IDLE);
   -- Transmit purposes
   signal s_cnt8_q_tx         : integer range 0 to C_COUNTER_8BIT_VALUE - 1;
   signal uart_state_tx       : t_uart_states;
   signal s_cnt8_we_tx        : std_logic;
   signal s_cnt8_set_reset_tx : std_logic;
   signal s_cnt8_overflow_tx  : std_logic;
   signal uart_buff_tx        : std_logic_vector(31 downto 0);
   signal bit_cnt_tx          : integer range 0 to 8;
   signal byte_cnt_tx         : integer range 0 to 3;
   -- Receive purposes
   signal s_cnt8_q_rx         : integer range 0 to C_COUNTER_8BIT_VALUE - 1;
   signal uart_state_rx       : t_uart_states;
   signal s_cnt8_we_rx        : std_logic;
   signal s_cnt8_set_reset_rx : std_logic;
   signal s_cnt8_overflow_rx  : std_logic;
   signal uart_buff_rx        : std_logic_vector(31 downto 0);
   signal bit_cnt_rx          : integer range 0 to 8;
   signal byte_cnt_rx         : integer range 0 to 3;


begin


   inst_counter_tx : component counter8
   generic map (
      G_COUNTER_8BIT_VALUE => positive(real(G_FREQUENCY_MHZ)*(1.0/real(G_BAUD)))
   ) port map (
      i_rst_n              => i_rst_n,
      i_clk                => i_clk,
      i_cnt8_we            => s_cnt8_we_tx,
      i_cnt8_set_reset     => s_cnt8_set_reset_tx,
      o_cnt8_overflow      => s_cnt8_overflow_tx,
      o_cnt8_q             => s_cnt8_q_tx
   );


   inst_counter_rx : component counter8
   generic map (
      G_COUNTER_8BIT_VALUE => positive(real(G_FREQUENCY_MHZ)*(1.0/real(G_BAUD)))
   ) port map (
      i_rst_n              => i_rst_n,
      i_clk                => i_clk,
      i_cnt8_we            => s_cnt8_we_rx,
      i_cnt8_set_reset     => s_cnt8_set_reset_rx,
      o_cnt8_overflow      => s_cnt8_overflow_rx,
      o_cnt8_q             => s_cnt8_q_rx
   );


   p_tx : process(i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst_n = '0') then
            uart_state_tx     <= IDLE;
            s_cnt8_we_tx      <= '0';
            uart_buff_tx      <= (others => '0');
            bit_cnt_tx        <= 0;
            byte_cnt_tx       <= 0;
         else
            case (uart_state_tx) is

               when IDLE =>

                  o_uart_tx         <= '1';
                  if (i_uart_we = '1') then
                     uart_state_tx     <= START;
                     uart_buff_tx      <= i_uart_wdata; -- Latch data to send
                  end if;

               when START =>

                  o_uart_tx         <= '0';
                  uart_state_tx     <= DATA;
                  s_cnt8_we_tx      <= '1';
                  s_cnt8_set_reset_tx  <= '1';

               when DATA =>

                  if (s_cnt8_overflow_tx = '1') then
                     if (bit_cnt_tx = 8) then
                        o_uart_tx         <= '1';
                        uart_state_tx     <= STOP;
                        bit_cnt_tx        <= 0;
                     else
                        bit_cnt_tx        <= bit_cnt_tx + 1;
                        o_uart_tx         <= uart_buff_tx(bit_cnt_tx);
                     end if;
                  end if;

               when STOP =>

                  if (s_cnt8_overflow_tx = '1') then
                     if (byte_cnt_tx = 3) then
                        byte_cnt_tx       <= 0;
                        uart_state_tx     <= IDLE;
                        s_cnt8_set_reset_tx  <= '0';
                     -- All 32 bits must be sent, so shift the buffer and send
                     -- the next byte, until byte_cnt_tx = 3.
                     else
                        byte_cnt_tx       <= byte_cnt_tx + 1;
                        uart_state_tx     <= DATA;
                        o_uart_tx         <= '0';
                        uart_buff_tx      <= uart_buff_tx(7 downto 0) &
                                             uart_buff_tx(31 downto 8);
                     end if;
                  end if;

               when others =>

                  uart_state_tx     <= IDLE;
                  s_cnt8_we_tx      <= '0';
                  uart_buff_tx      <= (others => '0');
                  bit_cnt_tx        <= 0;
                  byte_cnt_tx       <= 0;

            end case;
         end if;
      end if;
   end process p_tx;


   p_rx : process (i_clk)
      variable rx_start_counter  : integer range 0 to positive((
                                 real(G_FREQUENCY_MHZ)*(1.0/real(G_BAUD)))/2.0);
      constant C_MAX_VALUE       : integer := positive((
                                 real(G_FREQUENCY_MHZ)*(1.0/real(G_BAUD)))/2.0);
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst_n = '0') then
            uart_state_rx        <= IDLE;
            uart_buff_rx         <= (others => '0');
            rx_start_counter     := 0;
            s_cnt8_we_rx         <= '0';
            s_cnt8_set_reset_rx  <= '0';
            bit_cnt_rx           <= 0;
            o_uart_data          <= (others => '0');
         else
            case (uart_state_rx) is

               when IDLE   =>

                  if (i_uart_rx = '0') then
                     if (rx_start_counter = C_MAX_VALUE) then
                        rx_start_counter     := 0;
                        uart_state_rx        <= DATA;
                        s_cnt8_we_rx         <= '1';
                        s_cnt8_set_reset_rx  <= '1';
                        uart_buff_rx         <= (others => '0');
                     else
                        rx_start_counter  := rx_start_counter + 1;
                     end if;
                  else
                     rx_start_counter  := 0;
                  end if;

               when START  =>

               when DATA   =>

                  if (s_cnt8_overflow_rx = '1') then
                     if (bit_cnt_rx = 8) then
                        uart_state_rx     <= STOP;
                        bit_cnt_rx        <= 0;
                     else
                        bit_cnt_rx        <= bit_cnt_rx + 1;
                        uart_buff_rx      <= i_uart_rx & uart_buff_rx(31 downto 1);
                     end if;
                  end if;

               when STOP   =>

                  if (s_cnt8_overflow_rx = '1') then
                     s_cnt8_we_rx         <= '0';
                     s_cnt8_set_reset_rx  <= '0';
                     uart_state_rx        <= IDLE;
                     o_uart_data          <= uart_buff_rx;
                  end if;

               when others =>

            end case;
         end if;
      end if;
   end process;


end architecture rtl;
