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
      G_I2C_FREQUENCY_HZ     : positive := C_I2C_FREQUENCY_HZ;
      G_I2C_ADDR_WIDTH_BITS  : positive := C_I2C_ADDR_WIDTH_BITS
   );
   port (
      i_rst_n              : in std_logic;
      i_clk                : in std_logic;
      i_i2c_wdata          : in std_logic_vector(31 downto 0);
      i_i2c_write          : in std_logic;
      i_i2c_read           : in std_logic;
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
   type t_i2c_states          is (ST_IDLE, ST_START, ST_ADDR_FRAME, ST_RW_BIT,
                                  ST_ACK, ST_DATA_FRAME, ST_STOP);
   -- Timer
   signal s_cnt1_overflow     : std_logic;
   -- Clock generation
   signal s_i2c_sclk          : std_logic;
   -- Transmit purposes
   signal s_cnt1_set_reset_tx : std_logic;
   signal fsm_tx              : t_i2c_states;
   signal cnt_bit_tx          : natural range 0 to 16;
   signal s_status_tx_busy    : std_logic;
   signal slv_tx              : std_logic_vector(31 downto 0);

   signal s_scl               : std_logic;
   signal s_sda               : std_logic;


begin


   inst_counter: component counter1
   generic map (
      G_COUNTER1_VALUE => positive(((real(C_FREQUENCY_HZ/G_I2C_FREQUENCY_HZ))/2.0)-1.0)
   ) port map (
      i_rst_n              => i_rst_n,
      i_clk                => i_clk,
      i_cnt1_we            => '1',
      i_cnt1_set_reset     => s_cnt1_set_reset_tx,
      o_cnt1_overflow      => s_cnt1_overflow,
      o_cnt1_q             => open
   );


   io_i2c_scl                 <= 'Z';
   io_i2c_sda                 <= s_sda;
   o_i2c_status(0)            <= s_status_tx_busy;
   o_i2c_status(31 downto 1)  <= (others => '0');


   p_i2c_tx : process (i_clk)
   begin
      if (rising_edge(i_clk)) then
         if (i_rst_n = '0') then
            fsm_tx               <= ST_IDLE;
            cnt_bit_tx           <= 0;
            s_status_tx_busy     <= '0';
            s_cnt1_set_reset_tx  <= '0';
            s_scl                <= '0';
            s_sda                <= '0';
         else
            case (fsm_tx) is

               when ST_IDLE   =>

                  if (i_i2c_write = '1') then
                      fsm_tx               <= ST_START;
                      slv_tx               <= i_i2c_wdata; -- Latch data to send
                      s_status_tx_busy     <= '1';
                      s_cnt1_set_reset_tx  <= '1';
                  end if;

               when ST_START   =>

                  if (s_cnt1_overflow = '1') then
                      fsm_tx               <= ST_ADDR_FRAME;
                      s_sda                <= '0';
                  end if;

               when ST_ADDR_FRAME   =>

                  if (s_cnt1_overflow = '1') then
                     if (cnt_bit_tx = G_I2C_ADDR_WIDTH_BITS) then
                        fsm_tx               <= ST_RW_BIT;
                     else
                        cnt_bit_tx           <= cnt_bit_tx + 1;
                        s_sda                <= slv_tx(cnt_bit_tx);
                     end if;
                  end if;

               when ST_RW_BIT   =>

                   fsm_tx               <= ST_IDLE;

               when others =>

                  fsm_tx               <= ST_IDLE;
                  cnt_bit_tx           <= 0;
                  s_status_tx_busy     <= '0';
                  s_cnt1_set_reset_tx  <= '0';

            end case;
         end if;
      end if;
   end process p_i2c_tx;


end architecture rtl;
