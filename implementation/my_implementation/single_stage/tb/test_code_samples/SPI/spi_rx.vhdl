      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0", x"00000000", clk_tb, test_point);
      check_spi_rx("lw    x1,  24(x0)", x"95", s_spi_miso_tb, clk_tb, test_point);
