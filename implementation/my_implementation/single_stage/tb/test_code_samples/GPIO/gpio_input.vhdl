      --------------------------------------------------------------------------
      --                                                                      --
      --                              GPIO input                              --
      --                                                                      --
      --------------------------------------------------------------------------
      gpio_tb        <= 8b"00001101"; -- Simulate GPIO input
      wait until rising_edge(clk_tb); -- nop instruction
      wait until rising_edge(clk_tb); -- nop instruction
      wait until rising_edge(clk_tb); -- nop instruction
      wait until rising_edge(clk_tb); -- nop instruction
      wait until rising_edge(clk_tb); -- nop instruction
      -- Check if value 0000000D has been loaded into register x1
      check_gpr("lw    x1,  255(x0)", x"0000000D", clk_tb, test_point);
      gpio_tb        <= (others => 'Z');
