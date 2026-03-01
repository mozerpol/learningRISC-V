      check_gpr("addi  x2,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0x95", x"00000095", clk_tb, test_point);
      check_spi_tx("sw    x3,  20(x0)", x"00000095", clk_tb, test_point);
