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
      i_uart_wdata         : in std_logic_vector(31 downto 0); -- TODO: should be 7 downto 0, because can send only 6 bits
      i_uart_rx            : in std_logic;
      i_uart_we            : in std_logic;
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


   signal s_cnt8_we        : std_logic;
   signal s_cnt8_set_reset : std_logic;
   signal s_cnt8_overflow  : std_logic;
   signal s_cnt8_q         : integer range 0 to C_COUNTER_8BIT_VALUE - 1;
   type t_uart_state       is (start, stop, data, idle);
   signal uart_state       : t_uart_state;
   signal uart_buff_send   : std_logic_vector(31 downto 0);
   signal sent_data_cnt    : integer range 0 to 6;

begin
-- (1/C_BAUD)*C_FREQUENCY_MHZ

   inst_counter : component counter8
   generic map (
      G_COUNTER_8BIT_VALUE => 347 --G_FREQUENCY_MHZ*(1/G_BAUD)
   ) port map (
      i_rst_n              => i_rst_n,
      i_clk                => i_clk,
      i_cnt8_we            => s_cnt8_we,
      i_cnt8_set_reset     => s_cnt8_set_reset,
      o_cnt8_overflow      => s_cnt8_overflow,
      o_cnt8_q             => s_cnt8_q
   );


   p_tx : process(i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst_n = '0') then
            uart_state        <= idle;
            s_cnt8_we         <= '0';
            uart_buff_send    <= (others => '0');
            sent_data_cnt     <= 0;
         else
            case (uart_state) is

               when idle =>

                  o_uart_tx         <= '1';
                  if (i_uart_we = '1') then
                     uart_state        <= start;
                     uart_buff_send    <= i_uart_wdata;
                  end if;

               when start =>

                  o_uart_tx         <= '0';
                  uart_state        <= data;
                  s_cnt8_we         <= '1';
                  s_cnt8_set_reset  <= '1';

               when data =>

                  if (s_cnt8_overflow = '1') then
                     if (sent_data_cnt = 6) then
                        o_uart_tx         <= '1';
                        uart_state        <= stop;
                        sent_data_cnt     <= 0;
                     else
                        sent_data_cnt    <= sent_data_cnt + 1;
                        o_uart_tx        <= uart_buff_send(sent_data_cnt);
                     end if;
                  end if;

               when stop =>

                  if (s_cnt8_overflow = '1') then
                     uart_state        <= idle;
                     s_cnt8_set_reset  <= '0';
                  end if;

               when others =>

            end case;
         end if;
         o_uart_data <= uart_buff_send;
      end if;
   end process p_tx;


end architecture rtl;
