--------------------------------------------------------------------------------
-- File          : riscpol_tb.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Test for the entire processor (riscpol entity in
-- riscpol_design). All instructions (in assembly language) from this test are
-- in the file tests/general.asm.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------


library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.numeric_std_unsigned.all;
library std;
   use std.env.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;
   use riscpol_lib.riscpol_tb_pkg.all;


entity riscpol_tb is
end riscpol_tb;


architecture tb of riscpol_tb is


   component riscpol is
   port (
      i_rst_n                 : in std_logic;
      i_clk                   : in std_logic;
      io_gpio                 : inout std_logic_vector(C_NUMBER_OF_GPIO - 1 downto 0);
      i_rx                    : in std_logic;
      o_tx                    : out std_logic;
      o_7segment_1            : out std_logic_vector(6 downto 0);
      o_7segment_2            : out std_logic_vector(6 downto 0);
      o_7segment_3            : out std_logic_vector(6 downto 0);
      o_7segment_4            : out std_logic_vector(6 downto 0);
      o_7segment_anodes       : out std_logic_vector(3 downto 0);
      i_spi_miso              : in std_logic;
      o_spi_mosi              : out std_logic;
      o_spi_ss_n              : out std_logic;
      o_spi_sclk              : out std_logic
   );
   end component riscpol;


   -----------------------------------------------------------------------------
   -- SIGNALS AND CONSTANTS
   -----------------------------------------------------------------------------
   signal rst_n_tb            : std_logic;
   signal clk_tb              : std_logic;
   signal rx_tb               : std_logic;
   signal tx_tb               : std_logic;
   signal gpio_tb             : std_logic_vector(C_NUMBER_OF_GPIO-1 downto 0);
   signal test_point          : integer := 0;
   signal s_7segment_1_tb     : std_logic_vector(6 downto 0);
   signal s_7segment_2_tb     : std_logic_vector(6 downto 0);
   signal s_7segment_3_tb     : std_logic_vector(6 downto 0);
   signal s_7segment_4_tb     : std_logic_vector(6 downto 0);
   signal s_7segment_anodes_tb: std_logic_vector(3 downto 0);
   signal s_spi_miso_tb       : std_logic;
   signal s_spi_mosi_tb       : std_logic;
   signal s_spi_ss_n_tb       : std_logic;
   signal s_spi_sclk_tb       : std_logic;


 



   ------------------------------------------
   ---- Check the value of counter1 bit  ----
   ------------------------------------------
   procedure check_cnt( constant instruction        : in string;
                            constant cnt_val        : in integer range 0 to C_COUNTER1_VALUE - 1;
                            constant desired_value  : in integer range 0 to C_COUNTER1_VALUE - 1;
                            signal test_point       : out integer) is
   begin
      if (cnt_val /= desired_value) then
         echo("ERROR COUNTER: " & instruction);
         echo("Desired value:" & integer'image(desired_value));
         echo("Counter value:" & integer'image(cnt_val));
         echo("Test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("");
      end if;
      wait until rising_edge(clk_tb);
   end procedure;


   ---------------------------------
   ---- Check the value of seven segment display ----
   ---------------------------------
   procedure check_7segment(constant instruction    : in string;
                        constant desired_value_segment_1  : in std_logic_vector(6 downto 0);
                        constant desired_value_segment_2  : in std_logic_vector(6 downto 0);
                        constant desired_value_segment_3  : in std_logic_vector(6 downto 0);
                        constant desired_value_segment_4  : in std_logic_vector(6 downto 0);
                        signal test_point       : out integer) is
   begin
      if (to_integer(s_7segment_1_tb) /= to_integer(desired_value_segment_1) or
      to_integer(s_7segment_2_tb) /= to_integer(desired_value_segment_2) or
      to_integer(s_7segment_3_tb) /= to_integer(desired_value_segment_3) or
      to_integer(s_7segment_4_tb) /= to_integer(desired_value_segment_4)) then
         echo("ERROR seven segment: " & instruction);
         echo("Test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("instruction: " & instruction);
         echo("");
      end if;
      wait until rising_edge(clk_tb);
   end procedure;
   

   -------------------------------------------
   ----    Simulate sending UART data     ----
   -- TODO: comment, sendint from which perspective
   -------------------------------------------
   procedure check_uart_tx( constant instruction : in string;
                         -- TODO: change name, I think, it's not desired value...
                         constant desired_value  : in std_logic_vector(31 downto 0);
                         signal test_point       : out integer) is
      constant C_WAIT_TIME    : time := 1_000_000_000.0/real(C_BAUD) * ns;
      alias uart_status is << signal .riscpol_tb.inst_riscpol.inst_uart.
                              o_uart_status : std_logic_vector >>;
   begin
      wait for C_WAIT_TIME/2; -- Thanks to this delay, test will hit about half
      -- of the bit sent by UART
      -- Check start bit
      if (std_logic(tx_tb) /= '0') then
         echo("ERROR UART: " & instruction);
         echo("Start bit does not match the expected value.");
         echo("Test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("");
      end if;
      wait for C_WAIT_TIME;
      -- Check data bits
      for i in 0 to 7 loop
         if (desired_value(i) /= std_logic(tx_tb)) then
            echo("ERROR UART: " & instruction);
            echo("The bit does not match the expected value.");
            echo("Test_point: " & integer'image(test_point+1));
            test_point <= test_point + 1;
            echo("");
         end if;
         wait for C_WAIT_TIME;
      end loop;
      -- Check stop bit
      if (std_logic(tx_tb) /= '1') then
         echo("ERROR UART: " & instruction);
         echo("Stop bit does not match the expected value.");
         echo("Test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("");
      end if;
      -- Wait until the end of UART data sending
      wait until uart_status(0) = '0';
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
   end procedure;


   -----------------------------------------------------------------------------
   ----    Simulate receiving UART data   ----
   -- TODO: comment, sendint from which perspective
   -----------------------------------------------------------------------------
   procedure check_uart_rx(constant value_to_send        : in std_logic_vector(31 downto 0);
                           constant number_bytes_to_send : in positive range 1 to 4;
                           signal out_rx                 : out std_logic;
                           signal test_point             : out integer ) is
      constant C_WAIT_TIME    : time := 1_000_000_000.0/real(C_BAUD) * ns;
      alias spy_uart_data     is <<signal .riscpol_tb.inst_riscpol.inst_uart.o_uart_data: std_logic_vector(31 downto 0) >>;
      alias spy_uart_status   is <<signal .riscpol_tb.inst_riscpol.inst_uart.o_uart_status: std_logic_vector(31 downto 0) >>;
   begin
      for j in 0 to number_bytes_to_send-1 loop
         -- Start bit
         out_rx <= '0';
         wait for C_WAIT_TIME;
         -- Data bits
         for i in 0 to 7 loop
            out_rx <= value_to_send(8*j+i);
            wait for C_WAIT_TIME;
         end loop;
         -- Stop bit
         out_rx <= '1';
         wait until spy_uart_status(1) = '1';
         if (spy_uart_data(7 downto 0) /= value_to_send(8*j+7 downto 8*j)) then
            echo("ERROR UART rx: " & to_string(spy_uart_data(8*j+7 downto 8*j)));
            echo("The bit does not match the expected value.");
            echo("Test_point: " & integer'image(test_point+1));
            test_point <= test_point + 1;
            echo("");
         end if;
      end loop;
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
   end procedure;


   -------------------------------------------
   ----     Simulate sending SPI data     ----
   -------------------------------------------
   procedure check_spi_tx(constant instruction          : in string;
                          constant value_to_send        : in std_logic_vector(31 downto 0);
                          signal test_point             : out integer) is
      constant C_WAIT_TIME    : time := (1000000000/C_SPI_FREQUENCY_HZ) * ns;
   begin
         wait until rising_edge(clk_tb);
         wait until rising_edge(clk_tb);
         wait until rising_edge(clk_tb);
      for i in 0 to 31 loop
         wait for C_WAIT_TIME;
         if (s_spi_mosi_tb /= value_to_send(31-i)) then
            echo("ERROR SPI TX: " & instruction);
            echo("value_to_send: " & to_string(value_to_send));
            echo("Shoudl be: " & to_string(value_to_send(31-i)));
            echo("spi_mosi: " & to_string(s_spi_mosi_tb));
            echo("Test_point: " & integer'image(test_point+1));
            echo("");
         end if;
      end loop;
         wait for C_WAIT_TIME/2;
         wait until rising_edge(clk_tb);
         wait until rising_edge(clk_tb);
   end procedure;


begin


   inst_riscpol : component riscpol
   port map (
      i_rst_n           => rst_n_tb,
      i_clk             => clk_tb,
      io_gpio           => gpio_tb,
      i_rx              => rx_tb,
      o_tx              => tx_tb,
      o_7segment_1      => s_7segment_1_tb,
      o_7segment_2      => s_7segment_2_tb,
      o_7segment_3      => s_7segment_3_tb,
      o_7segment_4      => s_7segment_4_tb,
      o_7segment_anodes => s_7segment_anodes_tb,
      i_spi_miso        => s_spi_miso_tb,
      o_spi_mosi        => s_spi_mosi_tb,
      o_spi_ss_n        => s_spi_ss_n_tb,
      o_spi_sclk        => s_spi_sclk_tb
   );


   p_clk : process
   begin
      clk_tb   <= '1';
      wait for C_CLK_PERIOD/2;
      clk_tb   <= '0';
      wait for C_CLK_PERIOD/2;
      -- TODO: add procedure
   end process;


   p_tb : process
      -- TODO: move aliases to procedures
      alias spy_cnt1          is <<signal .riscpol_tb.inst_riscpol.inst_counter1.o_cnt1_q:
                                 integer range 0 to C_COUNTER1_VALUE - 1>>;
   begin

      rst_n_tb       <= '0';
      gpio_tb        <= (others => 'Z');
      rx_tb          <= '1';
      s_spi_miso_tb  <= 'Z';
      wait for C_CLK_PERIOD*20;
      rst_n_tb       <= '1';
      -- After the reset, three delays are required for the simulation purposes.
      -- The first delay is to "detec" the nearest rising edge of the clock.
      -- The second delay is to execute the instruction, but its result is not
      -- yet visible from the simulator.
      -- Thanks to the third delay, the result of execution of the instruction
      -- can be checked.
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);

      --------------------------------------------------------------------------
      --                                                                      --
      --         ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI         --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --               ADDI              --
      -------------------------------------
      check_gpr("addi  x1,  x0,   -2048", x"fffff800", clk_tb, test_point);
      check_gpr("addi  x1,  x0,   -2048", x"fff1f800", clk_tb, test_point);
                 
      check_branch("beq   x3,  x4,   loop1", '1', clk_tb, test_point);
      check_branch("beq   x3,  x4,   loop1", '0', clk_tb, test_point);
      check_ram("sw   x9,  0(x0)", x"00000078", 0, 0, clk_tb, test_point);
      check_ram("sh   x9,  0(x0)", x"00001234", 0, 0, clk_tb, test_point);
      check_ram("sb   x9,  0(x0)", x"00000034", 0, 0, clk_tb, test_point);
                 
      --------------------------------------------------------------------------
      --                                                                      --
      --                    Check behaviour after reset                       --
      --      The first instruction from rom.vhdl is always loaded during     --
      --      the reset.                                                      --
      --                                                                      --
      --------------------------------------------------------------------------
      wait for 1 us;
      rst_n_tb   <= '0';
      wait for C_CLK_PERIOD*20+C_CLK_PERIOD/2;
      rst_n_tb   <= '1';
      -- After the reset, three delays are required for the simulation purposes.
      -- The first delay is to "detec" the nearest rising edge of the clock.
      -- The second delay is to execute the instruction, but its result is not
      -- yet visible from the simulator.
      -- Thanks to the third delay, the result of execution of the instruction
      -- can be checked.

      -- wait until rising_edge(clk_tb);
      -- wait until rising_edge(clk_tb);
      -- wait until rising_edge(clk_tb);
      -- check_gpr( instruction    => "addi  x1,  x0,   -2048",
      --            gpr            => spy_gpr(1),
      --            desired_value  => 32x"fffff800",
      --            test_point     => test_point);
      -- check_gpr( instruction    => "addi  x2,  x0,   -511",
      --            gpr            => spy_gpr(2),
      --            desired_value  => 32x"fffffe01",
      --            test_point     => test_point);
      -- check_gpr( instruction    => "addi  x3,  x0,   -2",
      --            gpr            => spy_gpr(3),
      --            desired_value  => 32x"fffffffe",
      --            test_point     => test_point);
      -- check_gpr( instruction    => "addi  x4,  x0,   0",
      --            gpr            => spy_gpr(4),
      --            desired_value  => 32x"00000000",
      --            test_point     => test_point);
      echo("======================================");
      echo("Total errors: " & integer'image(test_point));
      echo("======================================");
      wait for 1 us;
      stop(0);
   end process p_tb;


end architecture tb;
