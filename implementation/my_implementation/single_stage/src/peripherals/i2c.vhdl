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
      i_i2c_sda            : in  std_logic;
      i_i2c_scl            : in  std_logic;
      o_i2c_sda_drive      : out std_logic;
      o_i2c_scl_drive      : out std_logic;
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


   -- Timer
   signal s_cnt1_overflow     : std_logic;
   -- Clock generation
   type t_clock_states        is (ST_ONE_FOURTH, ST_TWO_FOURTH, ST_THREE_FOURTH,
                                  ST_FOUR_FOURTH);
   signal fsm_clk             : t_clock_states;
   -- I2C purposes
   type t_i2c_states          is (ST_IDLE, ST_START, ST_SEND_ADDR, ST_RW_BIT,
                                  ST_SEND_DATA, ST_READ_DATA, ST_READ_ACK,
                                  ST_SEND_ACK, ST_DATA_FRAME, ST_STOP);
   signal fsm_i2c             : t_i2c_states;
   signal s_sda_drive         : std_logic;
   signal s_scl_drive         : std_logic;
   signal s_cnt1_set_reset    : std_logic;
   signal s_status_busy       : std_logic;
   signal s_status_addr_buff  : std_logic;
   signal s_status_data_buff  : std_logic;
   signal s_status_ack_error  : std_logic;
   signal slv_addr            : std_logic_vector(7 downto 0);
   signal slv_bytes           : std_logic_vector(2 downto 0);
   signal s_rw_bit            : std_logic;
   signal slv_data            : std_logic_vector(31 downto 0);
   signal cnt_addr            : natural range 0 to 36;
   signal cnt_data_bits       : natural range 0 to 32;
   signal cnt_data_bytes      : natural range 0 to 4;
   signal cnt_ack             : integer range 0 to 4;
   signal cnt_stop            : natural range 0 to 1;


begin


   inst_counter: component counter1
   generic map (
      G_COUNTER1_VALUE => positive(((real(C_FREQUENCY_HZ/G_I2C_FREQUENCY_HZ))/4.0)-1.0)
   ) port map (
      i_rst_n              => i_rst_n,
      i_clk                => i_clk,
      i_cnt1_we            => '1',
      i_cnt1_set_reset     => s_cnt1_set_reset,
      o_cnt1_overflow      => s_cnt1_overflow,
      o_cnt1_q             => open
   );


   o_i2c_sda_drive            <= '0' when s_sda_drive = '0' else '1';
   o_i2c_scl_drive            <= '0' when s_scl_drive = '0' else '1';
   -- Where:
   -- s_sda_drive = 1 - master releases SDA, pull-up goes high
   -- s_sda_drive = 0 - master pulls down SDA to 0
   o_i2c_status(0)            <= s_status_busy;
   o_i2c_status(1)            <= s_status_addr_buff;
   o_i2c_status(2)            <= s_status_data_buff;
   o_i2c_status(3)            <= s_status_ack_error;
   o_i2c_status(31 downto 4)  <= (others => '0'); -- TODO: add possibility to reset all flags
   o_i2c_data                 <= slv_data;


   p_i2c_clock_gen : process (i_clk)
   begin
      if (rising_edge(i_clk)) then
         if (i_rst_n = '0') then
            s_scl_drive     <= '1';
            fsm_clk         <= ST_ONE_FOURTH;
         else
            if (s_cnt1_set_reset = '0') then
               fsm_clk         <= ST_ONE_FOURTH;
            end if;
            if (s_cnt1_overflow = '1') then
               case (fsm_clk) is
                  when ST_ONE_FOURTH =>
                     -- The clock signal is pulled up to VCC via the pull up resistor.
                     s_scl_drive     <= '1';
                     fsm_clk         <= ST_TWO_FOURTH;

                  when ST_TWO_FOURTH =>

                     s_scl_drive     <= '1';
                     fsm_clk         <= ST_THREE_FOURTH;

                  when ST_THREE_FOURTH =>

                     s_scl_drive     <= '0';
                     fsm_clk         <= ST_FOUR_FOURTH;

                  when ST_FOUR_FOURTH =>

                     s_scl_drive     <= '0';
                     fsm_clk         <= ST_ONE_FOURTH;

                  when others =>

                     s_scl_drive     <= '1';
                     fsm_clk         <= ST_ONE_FOURTH;

               end case;
            end if;
         end if;
      end if;
   end process p_i2c_clock_gen;


   p_i2c : process (i_clk)
   begin
      if (rising_edge(i_clk)) then
         if (i_rst_n = '0') then
            fsm_i2c              <= ST_IDLE;
            s_cnt1_set_reset     <= '0';
            s_sda_drive          <= '1'; -- Hi-Z
            s_status_busy        <= '0';
            s_status_addr_buff   <= '0';
            s_status_data_buff   <= '0';
            s_status_ack_error   <= '0';
            cnt_addr             <= 0;
            cnt_data_bits        <= 0;
            cnt_data_bytes       <= 0;
            cnt_ack              <= 0;
            cnt_stop             <= 0;
         else
            case (fsm_i2c) is

               when ST_IDLE        =>

                  if (i_i2c_write = '1') then
                     if (i_i2c_control = '0') then
                     -- Set address and number of bytes to send
                        -- Latch address
                        slv_addr             <= i_i2c_wdata(7 downto 0);
                        -- Latch number of bytes
                        slv_bytes            <= i_i2c_wdata(10 downto 8);
                        -- Latch read/write bit
                        s_rw_bit             <= i_i2c_wdata(11);
                        -- Set status bit, address buffer is full
                        s_status_addr_buff   <= '1';
                     else
                     -- Latch data
                        slv_data             <= i_i2c_wdata; -- Latch data to send
                        s_status_data_buff   <= '1';
                        s_status_busy        <= '1'; -- Set busy bit
                        fsm_i2c              <= ST_START; -- Start
                     end if;
                  elsif (i_i2c_read = '1') then
                     -- Enable reading data
                     s_status_busy        <= '1'; -- Set busy bit
                     fsm_i2c              <= ST_START; -- Start
                  end if;

               when ST_START       =>

                  fsm_i2c              <= ST_SEND_ADDR;
                  s_sda_drive          <= '0'; -- Set start bit
                  s_cnt1_set_reset     <= '1'; -- Turn on scl

               when ST_SEND_ADDR   =>

                  if (s_cnt1_overflow = '1') then
                     cnt_addr             <= cnt_addr + 1;
                     if (cnt_addr = 35) then
                        cnt_addr             <= 0;
                        fsm_i2c              <= ST_READ_ACK;
                     elsif (cnt_addr = 31) then
                        -- R/W bit = 1 = read
                        -- R/W bit = 0 = write
                        s_sda_drive          <= s_rw_bit; -- Set R/W bit
                     elsif (((cnt_addr - 3) mod 4) = 0) then
                        s_sda_drive          <= slv_addr(6);
                        slv_addr             <= '0' & slv_addr(5 downto 0) & slv_addr(6);
                     end if;
                  end if;

               when ST_SEND_DATA   =>

                  if (s_cnt1_overflow = '1') then
                     cnt_data_bits        <= cnt_data_bits + 1;
                     if (cnt_data_bits = 31) then
                        fsm_i2c           <= ST_READ_ACK;
                        cnt_data_bits     <= 0;
                     elsif (((cnt_data_bits - 3) mod 4 = 0) or (cnt_data_bits = 0)) then
                     -- Set data bit for cnt_data_bits = 0, 3, 7, 11, 15, 19, 23, 27
                        s_sda_drive          <= slv_data(31);
                        slv_data             <= slv_data(30 downto 0) & slv_data(31);
                     end if;
                  end if;

               when ST_READ_DATA   =>

                  if (s_cnt1_overflow = '1') then
                     s_sda_drive          <= '1';
                     cnt_data_bits        <= cnt_data_bits + 1;
                     if (cnt_data_bits = 31) then
                        fsm_i2c           <= ST_SEND_ACK;
                        cnt_data_bits     <= 0;
                        s_sda_drive       <= '0';
                     elsif ((cnt_data_bits - 1) mod 4 = 0) then
                     -- Save data bit for cnt_data_bits = 1, 5, 9, 13, 17, 21, 25, 29
                        slv_data             <= slv_data(30 downto 0) & i_i2c_sda;
                        cnt_data_bits        <= cnt_data_bits + 1;
                     end if;
                  end if;

               when ST_SEND_ACK    =>

                  if (s_cnt1_overflow = '1') then
                     if (cnt_ack = 3) then
                        cnt_ack              <= 0;
                        if (cnt_data_bytes = 4) then
                        -- To prevent sending more data than is in the buffer
                           fsm_i2c              <= ST_STOP;
                           cnt_data_bytes       <= 0;
                        elsif (cnt_data_bytes = to_integer(unsigned(slv_bytes))) then
                        -- Check if all bytes were sent
                           fsm_i2c              <= ST_STOP;
                           cnt_data_bytes       <= 0;
                        else
                           fsm_i2c              <= ST_READ_DATA;
                           cnt_data_bytes       <= cnt_data_bytes + 1;
                        end if;
                     else
                        cnt_ack              <= cnt_ack + 1;
                     end if;
                  end if;

               when ST_READ_ACK    =>

                  s_sda_drive          <= '1';
                  if (s_cnt1_overflow = '1') then
                     cnt_ack              <= cnt_ack + 1;
                     if (cnt_ack = 3) then
                        cnt_ack              <= 0;
                        if (cnt_data_bytes = 4) then
                        -- To prevent sending more data than is in the buffer
                           fsm_i2c              <= ST_STOP;
                           cnt_data_bytes       <= 0;
                           s_sda_drive          <= '0';
                        elsif (cnt_data_bytes = to_integer(unsigned(slv_bytes))) then
                        -- Check if all bytes were sent
                           fsm_i2c              <= ST_STOP;
                           s_sda_drive          <= '0';
                           cnt_data_bytes       <= 0;
                        else
                           fsm_i2c              <= ST_READ_DATA;
                           cnt_data_bytes       <= cnt_data_bytes + 1;
                        end if;
                     elsif (cnt_ack = 1 or cnt_ack = 2) then
                     -- Check ACK two times
                        if (i_i2c_sda = '0') then
                           s_status_ack_error    <= '0';
                        else
                           s_status_ack_error    <= '1';
                           fsm_i2c               <= ST_STOP;
                        end if;
                     end if;
                  end if;

               when ST_STOP        =>

                  if (s_cnt1_overflow = '1') then
                     if (cnt_stop = 1) then
                        fsm_i2c              <= ST_IDLE;
                        s_cnt1_set_reset     <= '0';
                        s_sda_drive          <= '1'; -- Hi-Z
                        s_status_busy        <= '0';
                        s_status_addr_buff   <= '0';
                        s_status_data_buff   <= '0';
                        s_status_ack_error   <= '0';
                        cnt_addr             <= 0;
                        cnt_data_bits        <= 0;
                        cnt_data_bytes       <= 0;
                        cnt_ack              <= 0;
                        cnt_stop             <= 0;
                     else
                        cnt_stop             <= cnt_stop + 1;
                     end if;
                  end if;

               when others         =>

                  fsm_i2c              <= ST_IDLE;

            end case;
         end if;
      end if;
   end process p_i2c;


end architecture rtl;
