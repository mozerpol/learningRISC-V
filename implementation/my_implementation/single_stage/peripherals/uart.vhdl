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
library counter1_lib;


entity uart is
   generic(
      G_BAUD               : positive := C_BAUD
   ); port (
      i_rst_n              : in std_logic;
      i_clk                : in std_logic;
      i_uart_wdata         : in std_logic_vector(31 downto 0);
      i_uart_rx            : in std_logic;
      i_uart_we            : in std_logic;
      o_uart_data          : out std_logic_vector(31 downto 0);
      o_uart_status        : out std_logic_vector(31 downto 0);
      o_uart_tx            : out std_logic
);
end entity uart;


architecture rtl of uart is


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
   type t_uart_states         is (IDLE, START, DATA, STOP);
   -- Transmit purposes
   signal s_cnt1_q_tx         : integer range 0 to C_COUNTER1_VALUE - 1;
   signal uart_state_tx       : t_uart_states;
   signal s_cnt1_we_tx        : std_logic;
   signal s_cnt1_set_reset_tx : std_logic;
   signal s_cnt1_overflow_tx  : std_logic;
   signal uart_buff_tx        : std_logic_vector(7 downto 0);
   signal bit_cnt_tx          : integer range 0 to 8; -- TODO: range up to constant
   signal s_status_tx_busy    : std_logic;
   -- Receive purposes
   signal s_cnt1_q_rx         : integer range 0 to C_COUNTER1_VALUE - 1;
   signal uart_state_rx       : t_uart_states;
   signal s_cnt1_we_rx        : std_logic;
   signal s_cnt1_set_reset_rx : std_logic;
   signal s_cnt1_overflow_rx  : std_logic;
   signal uart_buff_rx        : std_logic_vector(31 downto 0);
   signal bit_cnt_rx          : integer range 0 to 8;
   signal byte_cnt_rx         : integer range 0 to 3;
   signal s_status_rx_ready   : std_logic;


begin


   inst_counter_tx : component counter1
   generic map (
      G_COUNTER1_VALUE => positive(real(C_FREQUENCY_HZ)*(1.0/real(G_BAUD)))
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
      G_COUNTER1_VALUE => positive(real(C_FREQUENCY_HZ)*(1.0/real(G_BAUD)) - 2.0)
   ) port map (
      i_rst_n              => i_rst_n,
      i_clk                => i_clk,
      i_cnt1_we            => s_cnt1_we_rx,
      i_cnt1_set_reset     => s_cnt1_set_reset_rx,
      o_cnt1_overflow      => s_cnt1_overflow_rx,
      o_cnt1_q             => open
   );


   o_uart_status(0) <= s_status_tx_busy;
   o_uart_status(1) <= s_status_rx_ready;
   o_uart_status(31 downto 2) <= (others => '0');
   

   -- TODO: check p_tx, fix p_rx, write asm code for tx, code.txt is up to date
   -- with 7segment. Take care about addresses


   p_tx : process(i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst_n = '0') then
            uart_state_tx     <= IDLE;
            s_cnt1_we_tx      <= '0';
            uart_buff_tx      <= (others => '0');
            bit_cnt_tx        <= 0;
            s_status_tx_busy  <= '0'; 
         else
            case (uart_state_tx) is

               when IDLE   =>

                  o_uart_tx         <= '1';
                  s_status_tx_busy  <= '0';
                  if (i_uart_we = '1') then
                     uart_state_tx     <= START;
                     uart_buff_tx      <= i_uart_wdata(7 downto 0); -- Latch data to send
                     s_status_tx_busy  <= '1'; 
                  end if;

               when START  =>

                  o_uart_tx            <= '0';
                  uart_state_tx        <= DATA;
                  s_cnt1_we_tx         <= '1';
                  s_cnt1_set_reset_tx  <= '1';

               when DATA   =>

                  if (s_cnt1_overflow_tx = '1') then
                     if (bit_cnt_tx = 8) then
                        o_uart_tx         <= '1';
                        uart_state_tx     <= STOP;
                        bit_cnt_tx        <= 0;
                     else
                        bit_cnt_tx        <= bit_cnt_tx + 1;
                        o_uart_tx         <= uart_buff_tx(bit_cnt_tx);
                     end if;
                  end if;

               when STOP   =>

                  if (s_cnt1_overflow_tx = '1') then
                     uart_state_tx        <= IDLE;
                     s_cnt1_set_reset_tx  <= '0';
                  end if;

               when others =>

                  uart_state_tx     <= IDLE;
                  s_cnt1_we_tx      <= '0';
                  uart_buff_tx      <= (others => '0');
                  bit_cnt_tx        <= 0;
                  s_status_tx_busy  <= '0';

            end case;
         end if;
      end if;
   end process p_tx;


   p_rx : process (i_clk)
      -- TODO: for what is this variable?
      variable rx_start_counter  : integer range 0 to positive((
                                 real(C_FREQUENCY_HZ)*(1.0/real(G_BAUD)))/2.0);
      -- TODO: why this constant exist?
      constant C_MAX_VALUE       : integer := positive((
                                 real(C_FREQUENCY_HZ)*(1.0/real(G_BAUD)))/2.0);
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst_n = '0') then
            uart_state_rx        <= IDLE;
            uart_buff_rx         <= (others => '0');
            rx_start_counter     := 0;
            s_cnt1_we_rx         <= '0';
            s_cnt1_set_reset_rx  <= '0';
            bit_cnt_rx           <= 0;
            o_uart_data          <= (others => '0');
            s_status_rx_ready <= '0'; 
         else
            case (uart_state_rx) is

               when IDLE   =>

                  if (i_uart_rx = '0') then
                     if (rx_start_counter = C_MAX_VALUE) then
                        rx_start_counter     := 0;
                        uart_state_rx        <= DATA;
                        s_cnt1_we_rx         <= '1';
                        s_cnt1_set_reset_rx  <= '1';
                        uart_buff_rx         <= (others => '0');
                     else
                        rx_start_counter     := rx_start_counter + 1;
                     end if;
                  else
                     rx_start_counter  := 0;
                  end if;

               when START  =>

               when DATA   =>

                  if (s_cnt1_overflow_rx = '1') then
                     if (bit_cnt_rx = 8) then
                        uart_state_rx        <= STOP;
                        bit_cnt_rx           <= 0;
                     else
                        bit_cnt_rx           <= bit_cnt_rx + 1;
                        uart_buff_rx         <= i_uart_rx & uart_buff_rx(31 downto 1);
                     end if;
                  end if;

               when STOP   =>

                  if (rx_start_counter = C_MAX_VALUE) then
                     uart_state_rx           <= IDLE;
                     o_uart_data(7 downto 0) <= uart_buff_rx(31 downto 24);
                     s_cnt1_set_reset_rx     <= '0';
                     rx_start_counter        := 0;
                  else
                     rx_start_counter        := rx_start_counter + 1;
                  end if;

               when others =>

            end case;
         end if;
      end if;
   end process;


end architecture rtl;
