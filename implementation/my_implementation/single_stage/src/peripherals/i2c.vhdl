--------------------------------------------------------------------------------
-- File          : i2c.vhdl
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


entity i2c is
   generic(
      G_I2C_FREQUENCY_HZ     : positive := C_I2C_FREQUENCY_HZ
   );
   port (
      i_rst_n              : in std_logic;
      i_clk                : in std_logic;
      i_i2c_wdata          : in std_logic_vector(31 downto 0);
      i_i2c_write          : in std_logic;
      i_i2c_read           : in std_logic;
      i_i2c_control        : in std_logic;
      io_i2c_scl           : inout std_logic;
      io_i2c_sda           : inout std_logic;
      o_i2c_data           : out std_logic_vector(31 downto 0);
      o_i2c_status         : out std_logic_vector(31 downto 0)
);
end entity i2c;


architecture rtl of i2c is


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
   type t_i2c_states          is (ST_IDLE, ST_START, ST_SEND_ADDR, ST_RW_BIT,
                                  ST_SEND_DATA, ST_ACK, ST_DATA_FRAME, ST_STOP);
   type t_clock_states        is (ST_ONE_FOURTH, ST_TWO_FOURTH, ST_THREE_FOURTH,
                                  ST_FOUR_FOURTH);
   -- Timer
   signal s_cnt1_overflow     : std_logic;
   -- Clock generation
   signal s_clock_flip        : std_logic;
   signal s_shift_data        : std_logic;
   signal s_ack_en            : std_logic;
   signal fsm_clk             : t_clock_states;
   -- Transmit purposes
   signal s_cnt1_set_reset_tx : std_logic;
   signal fsm_tx              : t_i2c_states;
   signal s_status_tx_busy    : std_logic;
   signal slv_tx_data         : std_logic_vector(31 downto 0);
   signal slv_tx_addr         : std_logic_vector(7 downto 0);
   signal slv_tx_bytes        : std_logic_vector(2 downto 0);
   signal s_sda_control       : std_logic;
   signal s_status_tx_addr_buff : std_logic;
   signal s_status_tx_data_buff : std_logic;
   signal cnt_tx_addr         : natural range 0 to 41;
   signal cnt_tx_data_bits    : natural range 0 to 41;
   signal cnt_tx_data_bytes   : natural range 0 to 4;
   signal cnt_tx_rw           : natural range 0 to 4;
   -- Receive purposes
   signal s_status_rx_busy    : std_logic;
   signal s_sda               : std_logic;
   signal s_tx_rw_bit         : std_logic;
   signal cnt : integer range 0 to 50;
   signal cnt_tx_ack : integer range 0 to 4;
   signal s_status_tx_ack_error : std_logic;
   signal dupa : std_logic;


begin


   inst_counter: component counter1
   generic map (
      G_COUNTER1_VALUE => positive(((real(C_FREQUENCY_HZ/G_I2C_FREQUENCY_HZ))/4.0)-1.0)
   ) port map (
      i_rst_n              => i_rst_n,
      i_clk                => i_clk,
      i_cnt1_we            => '1',
      i_cnt1_set_reset     => s_cnt1_set_reset_tx,
      o_cnt1_overflow      => s_cnt1_overflow,
      o_cnt1_q             => open
   );


   io_i2c_sda                 <= 'Z' when s_sda = '1' else '0';
   dupa                       <= io_i2c_sda;
       
   o_i2c_status(0)            <= s_status_tx_busy;
   o_i2c_status(1)            <= s_status_tx_addr_buff;
   o_i2c_status(2)            <= s_status_tx_data_buff;
   o_i2c_status(3)            <= s_status_rx_busy;
   o_i2c_status(4)            <= s_status_tx_ack_error;
   o_i2c_status(31 downto 5)  <= (others => '0');



   
   
   p_i2c_clock_gen : process (i_clk)
   begin
      if (rising_edge(i_clk)) then
         if (i_rst_n = '0') then
            io_i2c_scl      <= 'Z';
            fsm_clk         <= ST_ONE_FOURTH;
         else
            if (s_cnt1_overflow = '1') then -- if (s_cnt1_overflow = '1' and io_i2c_scl = '0') then
               case (fsm_clk) is
                  when ST_ONE_FOURTH =>
                     -- The clock signal is pulled up to VCC via the pull up resistor.
                     io_i2c_scl      <= 'Z';
                     fsm_clk         <= ST_TWO_FOURTH;

                  when ST_TWO_FOURTH =>

                     io_i2c_scl      <= 'Z';
                     fsm_clk <= ST_THREE_FOURTH;

                  when ST_THREE_FOURTH =>

                     io_i2c_scl      <= '0';
                     fsm_clk <= ST_FOUR_FOURTH;

                  when ST_FOUR_FOURTH =>

                     io_i2c_scl      <= '0';
                     fsm_clk <= ST_ONE_FOURTH;

                  when others =>

                     io_i2c_scl      <= 'Z';
                     fsm_clk <= ST_ONE_FOURTH;

               end case;
            end if;
         end if;
      end if;
   end process p_i2c_clock_gen;


   p_i2c : process (i_clk)
   begin
      if (rising_edge(i_clk)) then
         if (i_rst_n = '0') then
            fsm_tx               <= ST_IDLE;
            s_status_tx_busy     <= '0';
            s_cnt1_set_reset_tx  <= '0';
            s_sda                <= '1';
            s_sda_control        <= '0';
            s_status_tx_addr_buff<= '0';
            s_status_tx_data_buff<= '0';
            cnt_tx_addr          <= 0;
            cnt_tx_data_bits     <= 0;
            cnt_tx_data_bytes    <= 0;
            cnt                  <= 0;
            cnt_tx_rw            <= 0;
            cnt_tx_ack           <= 0;
            s_status_tx_ack_error <= '0';
         else
            case (fsm_tx) is

               when ST_IDLE   =>

                  s_sda_control        <= '0';
                  if (i_i2c_write = '1') then
                     if (i_i2c_control = '0') then
                     -- Set address and number of bytes to send
                        -- Latch address
                        slv_tx_addr          <= i_i2c_wdata(7 downto 0);
                        -- Latch number of bytes
                        slv_tx_bytes         <= i_i2c_wdata(10 downto 8);
                        -- Latch read/write bit
                        s_tx_rw_bit          <= i_i2c_wdata(11);
                        -- Set status bit, address buffer is full
                        s_status_tx_addr_buff<= '1';
                     else
                     -- Latch data
                        slv_tx_data          <= i_i2c_wdata; -- Latch data to send
                        s_status_tx_data_buff<= '1';
                        s_status_tx_busy     <= '1';
                        fsm_tx               <= ST_START;
                     end if;
                  end if;

               when ST_START   =>

                  fsm_tx               <= ST_SEND_ADDR;
                  s_sda                <= '0';
                  s_sda_control        <= '1';
                  s_cnt1_set_reset_tx  <= '1';

               when ST_SEND_ADDR   =>

                  s_sda_control        <= '1';
                  if (s_cnt1_overflow = '1') then
                     cnt_tx_addr          <= cnt_tx_addr + 1;
                     if (cnt_tx_addr = 39) then
                        cnt_tx_addr          <= 0;
                        fsm_tx               <= ST_ACK;
                     elsif (cnt_tx_addr = 35) then
                        -- R/W bit = 1 = read
                        -- R/W bit = 0 = write
                        s_sda                <= s_tx_rw_bit; -- Set R/W bit
                     elsif (cnt_tx_addr = 31) then
                        s_sda                <= slv_tx_addr(7);
                     elsif (cnt_tx_addr = 27) then
                        s_sda                <= slv_tx_addr(6);
                     elsif (cnt_tx_addr = 23) then
                        s_sda                <= slv_tx_addr(5);
                     elsif (cnt_tx_addr = 19) then
                        s_sda                <= slv_tx_addr(4);
                     elsif (cnt_tx_addr = 15) then
                        s_sda                <= slv_tx_addr(3);
                     elsif (cnt_tx_addr = 11) then
                        s_sda                <= slv_tx_addr(2);
                     elsif (cnt_tx_addr = 7) then
                        s_sda                <= slv_tx_addr(1);
                     elsif (cnt_tx_addr = 3) then
                        s_sda                <= slv_tx_addr(0);
                     end if;
                  end if;

               when ST_SEND_DATA   =>

                  -- TODO: finish it, just finished ACK.
                  if (s_cnt1_overflow = '1') then
                     s_sda_control        <= '1';
                     if (cnt_tx_data_bytes = 4) then
                        -- To prevent sending more data than is in the buffer
                        fsm_tx               <= ST_STOP;
                        cnt_tx_data_bytes    <= 0;
                     elsif (cnt_tx_data_bytes = to_integer(unsigned(slv_tx_bytes))) then
                        fsm_tx               <= ST_STOP;
                        cnt_tx_data_bytes    <= 0;
                     else
                        cnt_tx_data_bits     <= cnt_tx_data_bits + 1;
                        if (cnt_tx_data_bits = 23) then
                           fsm_tx               <= ST_ACK;
                           cnt_tx_data_bits     <= 0;
                           cnt_tx_data_bytes    <= cnt_tx_data_bytes + 1;
                        elsif (cnt_tx_data_bits = 19) then
                           s_sda                <= slv_tx_data(0);
                           slv_tx_data          <= slv_tx_data(0) & slv_tx_data(31 downto 1);
                        elsif (cnt_tx_data_bits = 15) then
                           s_sda                <= slv_tx_data(0);
                           slv_tx_data          <= slv_tx_data(0) & slv_tx_data(31 downto 1);
                        elsif (cnt_tx_data_bits = 11) then
                           s_sda                <= slv_tx_data(0);
                           slv_tx_data          <= slv_tx_data(0) & slv_tx_data(31 downto 1);
                        elsif (cnt_tx_data_bits = 7) then
                           s_sda                <= slv_tx_data(0);
                           slv_tx_data          <= slv_tx_data(0) & slv_tx_data(31 downto 1);
                        elsif (cnt_tx_data_bits = 3) then
                           s_sda                <= slv_tx_data(0);
                           slv_tx_data          <= slv_tx_data(0) & slv_tx_data(31 downto 1);
                        elsif (cnt_tx_data_bits = 0) then
                           s_sda                <= slv_tx_data(0);
                           slv_tx_data          <= slv_tx_data(0) & slv_tx_data(31 downto 1);
                        end if;
                     end if;
                  end if;

               when ST_ACK   =>

                  --s_sda_control        <= '0';
                  s_sda                <= '1';
                  if (s_cnt1_overflow = '1') then
                     cnt_tx_ack           <= cnt_tx_ack + 1;
                     if (cnt_tx_ack = 3) then -- Change state
                        cnt_tx_ack           <= 0;
                        fsm_tx               <= ST_ACK; --ST_SEND_DATA;
                     elsif (cnt_tx_ack = 1 or cnt_tx_ack = 2) then
                     -- Check if ACK two times
                       -- if (dupa /= '0') then
                       --    s_status_tx_ack_error <= '1';
                       -- end if;
                       if (dupa = '0') then
                           s_status_tx_ack_error <= '0';
                       else
                           s_status_tx_ack_error <= '1';
                       end if;
                     end if;
                  end if;

               when ST_STOP   =>

                  s_sda                <= 'Z';
                  s_sda_control        <= '0';
                  s_cnt1_set_reset_tx  <= '0';
                  s_cnt1_set_reset_tx  <= '0';
                  s_status_tx_data_buff<= '0';
                  s_status_tx_busy     <= '0';
                  fsm_tx               <= ST_IDLE;

               when others =>

                  fsm_tx               <= ST_IDLE;
                  s_status_tx_busy     <= '0';
                  s_cnt1_set_reset_tx  <= '0';
                  s_sda                <= 'Z';

            end case;
         end if;
      end if;
   end process p_i2c;


end architecture rtl;
