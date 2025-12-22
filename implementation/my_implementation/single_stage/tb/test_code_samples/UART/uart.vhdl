      --------------------------------------------------------------------------
      --                                                                      --
      --                                 UART                                 --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --             UART TX             --
      -------------------------------------
      check_gpr("addi  x3,  x0,   0x44", x"00000044", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   0xD", x"0000000d", clk_tb, test_point);                 
      check_uart_tx("sw    x3,  243(x0)", x"00000044", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0", x"00000000", clk_tb, test_point);
      check_uart_tx("sw    x4,  243(x0)", x"0000000d", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --             UART RX             --
      -------------------------------------
      check_gpr("addi  x1,  x0,   0xAB", x"000000ab", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   0x12", x"00000012", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0xCD", x"000000CD", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   0x99", x"00000099", clk_tb, test_point);
      check_gpr("addi  x5,  x0,   0", x"00000000", clk_tb, test_point);
      check_uart_rx(x"ABEEEEEE", 4, uart_rx_tb, clk_tb, test_point);
      check_uart_rx(x"00120000", 3, uart_rx_tb, clk_tb, test_point);
      check_uart_rx(x"0000CDEF", 2, uart_rx_tb, clk_tb, test_point);
      check_uart_rx(x"00000099", 1, uart_rx_tb, clk_tb, test_point);
      check_gpr("addi  x2,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x2,  x2,   1", x"00000001", clk_tb, test_point);
      check_gpr("addi  x2,  x2,   1", x"00000002", clk_tb, test_point);
      check_gpr("addi  x2,  x2,   1", x"00000003", clk_tb, test_point);
