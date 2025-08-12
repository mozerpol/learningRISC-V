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
   signal set_test_point      : integer := 0;
   signal s_7segment_1_tb     : std_logic_vector(6 downto 0);
   signal s_7segment_2_tb     : std_logic_vector(6 downto 0);
   signal s_7segment_3_tb     : std_logic_vector(6 downto 0);
   signal s_7segment_4_tb     : std_logic_vector(6 downto 0);
   signal s_7segment_anodes_tb: std_logic_vector(3 downto 0);
   signal s_spi_miso_tb       : std_logic;
   signal s_spi_mosi_tb       : std_logic;
   signal s_spi_ss_n_tb       : std_logic;
   signal s_spi_sclk_tb       : std_logic;
   -----------------------------------------------------------------------------
   -- PROCEDURES DEDICATED TO TEST
   -----------------------------------------------------------------------------
   -- The procedure prints out information in simulator without additional text
   -- like time or iteration.
   procedure echo (arg : in string := "") is
   begin
      std.textio.write(std.textio.output, arg & LF);
   end procedure echo;


   -----------------------------------------------------
   ---- Check the value of general purpose register ----
   -----------------------------------------------------
   procedure check_gpr( constant instruction    : in string;
                        constant gpr            : in std_logic_vector(31 downto 0);
                        constant desired_value  : in std_logic_vector(31 downto 0);
                        signal test_point       : out integer) is
   begin
      if (gpr /= desired_value) then
         echo("ERROR GPR: " & instruction);
         echo("desired_value: " & to_string(desired_value));
         echo("gpr value: " & to_string(gpr));
         echo("Test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("");
      end if;
      wait until rising_edge(clk_tb);
   end procedure;


   -----------------------------------------------------
   ----   Check the result of branch instruction    ----
   -----------------------------------------------------
   procedure check_branch( constant instruction : in string;
                        constant branch_result  : in std_logic;
                        constant desired_value  : in std_logic;
                        signal test_point       : out integer) is
   begin
      if (branch_result /= desired_value) then
         echo("ERROR branch instruction: " & instruction);
         echo("desired_value: " & to_string(desired_value));
         echo("result: " & to_string(branch_result));
         echo("Test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("");
      end if;
      wait until rising_edge(clk_tb);
   end procedure;


   ----------------------------------------------------------------------------
   ---- Check the value of one byte in RAM - used to verify SB instruction ----
   ----------------------------------------------------------------------------
   procedure check_ram( constant instruction          : in string;
                        constant ram_byte             : in std_logic_vector(7 downto 0);
                        constant desired_value_byte   : in std_logic_vector(7 downto 0);
                        signal test_point             : out integer ) is
   begin
      if (ram_byte /= desired_value_byte) then
          echo("ERROR RAM: " & instruction);
          echo("Test_point: " & integer'image(test_point+1));
          test_point <= test_point + 1;
          echo("");
      end if;
      wait until rising_edge(clk_tb);
   end procedure;


   -----------------------------------------------------------------------------
   ---- Check the value of two bytes in RAM - used to verify SH instruction ----
   -----------------------------------------------------------------------------
   procedure check_ram( constant instruction          : in string;
                        constant ram_byte_0           : in std_logic_vector(7 downto 0);
                        constant ram_byte_1           : in std_logic_vector(7 downto 0);
                        constant desired_value_byte_0 : in std_logic_vector(7 downto 0);
                        constant desired_value_byte_1 : in std_logic_vector(7 downto 0);
                        signal test_point             : out integer ) is
   begin
      if (ram_byte_0 /= desired_value_byte_0 or
          ram_byte_1 /= desired_value_byte_1) then
            echo("ERROR RAM: " & instruction);
            echo("Test_point: " & integer'image(test_point+1));
            test_point <= test_point + 1;
            echo("");
      end if;
      wait until rising_edge(clk_tb);
   end procedure;


   -----------------------------------------------------------------------------
   ---- Check the value of three bytes in RAM - used to verify SW instruction --
   ----------------------------------------------sim:/riscpol_tb/set_test_point
-------------------------------
   procedure check_ram( constant instruction          : in string;
                        constant ram_byte_0           : in std_logic_vector(7 downto 0);
                        constant ram_byte_1           : in std_logic_vector(7 downto 0);
                        constant ram_byte_2           : in std_logic_vector(7 downto 0);
                        constant ram_byte_3           : in std_logic_vector(7 downto 0);
                        constant desired_value_byte_0 : in std_logic_vector(7 downto 0);
                        constant desired_value_byte_1 : in std_logic_vector(7 downto 0);
                        constant desired_value_byte_2 : in std_logic_vector(7 downto 0);
                        constant desired_value_byte_3 : in std_logic_vector(7 downto 0);
                        signal test_point             : out integer ) is
   begin
      if (ram_byte_0 /= desired_value_byte_0 or
          ram_byte_1 /= desired_value_byte_1 or
          ram_byte_2 /= desired_value_byte_2 or
          ram_byte_3 /= desired_value_byte_3) then
            echo("ERROR RAM: " & instruction);
            echo("Test_point: " & integer'image(test_point+1));
            test_point <= test_point + 1;
            echo("");
      end if;
      wait until rising_edge(clk_tb);
   end procedure;


   ---------------------------------
   ---- Check the value of GPIO ----
   ---------------------------------
   procedure check_gpio(constant instruction    : in string;
                        constant desired_value  : in std_logic_vector(7 downto 0);
                        signal test_point       : out integer) is
   begin
      if (to_integer(gpio_tb) /= to_integer(desired_value)) then
         echo("ERROR GPIO: " & instruction);
         echo("Test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("instruction: " & instruction);
         echo("desired_value: " & to_string(desired_value));
         echo("gpio_tb value: " & to_string(gpio_tb));
         echo("");
      end if;
      wait until rising_edge(clk_tb);
   end procedure;


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


   -------------------------------------------
   ----    Simulate sending UART data     ----
   -------------------------------------------
   procedure check_uart_tx( constant instruction : in string;
                         constant desired_value  : in std_logic_vector(31 downto 0);
                         signal test_point       : out integer) is
      constant C_WAIT_TIME    : time := 1_000_000_000.0/real(C_BAUD) * ns;
      alias cnt1_overflow is << signal .riscpol_tb.inst_riscpol.inst_uart.
                                 inst_counter_tx.o_cnt1_overflow : std_logic >>;
   begin
      wait for C_WAIT_TIME/2; -- Thanks to this delay, test will hit about half
      -- of the bit sent by UART
      for j in 0 to 3 loop
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
            if (desired_value(8*j+i) /= std_logic(tx_tb)) then
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
         if (j = 3) then -- Wait until the end of UART data sending (because
            -- there was delay C_WAIT_TIME/2 at the beginning).
            wait until rising_edge(cnt1_overflow);
         else
            wait for C_WAIT_TIME;
         end if;
      end loop;
   end procedure;


   -------------------------------------------
   ----    Simulate receiving UART data   ----
   -------------------------------------------
   procedure check_uart_rx(constant instruction          : in string;
                           constant gpr                  : in std_logic_vector(31 downto 0);
                           constant value_to_send        : in std_logic_vector(31 downto 0);
                           constant number_bytes_to_send : in integer;
                           signal out_rx                 : out std_logic;
                           signal test_point             : out integer) is
      constant C_WAIT_TIME    : time := 1_000_000_000.0/real(C_BAUD) * ns;
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
         wait for C_WAIT_TIME;
         -- Check if the sent data has been saved in GPR
         if (gpr /= value_to_send) then
            echo("ERROR UART RX: " & instruction);
            echo("value_to_send: " & to_string(value_to_send));
            echo("gpr value: " & to_string(gpr));
            echo("Test_point: " & integer'image(test_point+1));
            test_point <= test_point + 1;
            echo("");
         end if;
         wait until rising_edge(clk_tb);
      end loop;
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
   end process;


   p_tb : process
      alias spy_gpr           is <<signal .riscpol_tb.inst_riscpol.inst_core.inst_reg_file.gpr: t_gpr >>;
      alias spy_branch_result is <<signal .riscpol_tb.inst_riscpol.inst_core.inst_branch_instructions.o_branch_result: std_logic >>;
      alias spy_ram           is <<signal .riscpol_tb.inst_riscpol.inst_ram.ram: ram_t >>;
      alias spy_cnt1          is <<signal .riscpol_tb.inst_riscpol.inst_counter1.o_cnt1_q:
                                 integer range 0 to C_COUNTER1_VALUE - 1>>;
   begin


      rst_n_tb       <= '0';
      gpio_tb        <= (others => 'Z');
      rx_tb          <= 'Z';
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

   -- TODO: put instructions here, describe it.
   -- TODO: write that, firstly ADDI instruction should be run, in case to 
   -- prepare the rest of instructions.
   -- TODO: create a new packet testbench_procedures.vhdl and put all procedures
   -- there, in this file.
   -- TODO: fix all instructions, put them in the separate file.
   -- TODO: add a separate folder: Documentation and put there README and drawio
   -- TODO: describe tests
   -- TODO: add timer ov output
      ----------------------------------------------------------------
      --                                                            --
      --              A simple algorithm to check GPIO              --
      --                                                            --
      ----------------------------------------------------------------
   --      set_test_point <= 11;
      check_gpr( instruction    => "addi  x1,  x0,   0", -- 00000093
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
    --     set_test_point <= 21;
      check_gpr( instruction    => "addi  x2,  x0,   15", -- 00f00113
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"0000000f",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x3,  x0,   0", -- 00000193
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x4,  x0,   10", -- 00a00213
                 gpr            => spy_gpr(4),
                 desired_value  => 32x"0000000a",
                 test_point     => set_test_point );         
                 
                 
      -- loop27:
      check_gpr( instruction    => "addi  x1,  x1,   1", -- 00108093
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
    --  set_test_point <= 29;
      check_gpio(instruction    => "sb    x1,  255(x0)", -- 0e100fa3
                 desired_value  => 8b"00000001",
                 test_point     => set_test_point );
                 
                 
    --  set_test_point <= 31;
      for i in 0 to 14 loop -- loop27

         for i in 1 to 20 loop
            -- wait for execute loop26
            -- addi  x3,  x3,   1      :00118193
            -- bne   x3,  x4,   loop26 :fe419ee3
            wait until rising_edge(clk_tb);
         end loop;
         
      --   set_test_point <= 41;
         check_gpr( instruction    => "addi  x3,  x0,   0", -- 00000193
                    gpr            => spy_gpr(3),
                    desired_value  => 32x"00000000",
                    test_point     => set_test_point );
     --    set_test_point <= 51;
         check_branch( instruction   => "bne   x1,  x2,   loop27", -- fe2096e3
                       branch_result => spy_branch_result,
                       desired_value => '0',
                       test_point    => set_test_point ); -- TODO: it's good, because the last branch result is equal 0, so maybe make for loop to 13 (not 14) and the last loop make outside of this loop!!!!
         -- 00108093  addi x1, x1, 1
     --    set_test_point <= 61;
         wait until rising_edge(clk_tb);
      --   set_test_point <= 71;
         -- 0e100fa3  sb   x1, 255(x0)
         wait until rising_edge(clk_tb);
      end loop;
      
      
     --    set_test_point <= 81;
      check_gpr( instruction    => "addi  x1,  x0,   0",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x3,  x0,   0",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
                 
      ----------------------------------------------------------------
      --                                                            --
      --               Check behaviour after reset                  --
      -- The first instruction from rom.vhdl is always loaded during--
      -- the reset.                                                 --
      ----------------------------------------------------------------
      wait for 250 ns;
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
      --            test_point     => set_test_point );
      -- check_gpr( instruction    => "addi  x2,  x0,   -511",
      --            gpr            => spy_gpr(2),
      --            desired_value  => 32x"fffffe01",
      --            test_point     => set_test_point );
      -- check_gpr( instruction    => "addi  x3,  x0,   -2",
      --            gpr            => spy_gpr(3),
      --            desired_value  => 32x"fffffffe",
      --            test_point     => set_test_point );
      -- check_gpr( instruction    => "addi  x4,  x0,   0",
      --            gpr            => spy_gpr(4),
      --            desired_value  => 32x"00000000",
      --            test_point     => set_test_point );
      echo("======================================");
      echo("Total errors: " & integer'image(set_test_point));
      echo("======================================");
      wait for 1 us;
      stop(0);
   end process p_tb;


end architecture tb;
