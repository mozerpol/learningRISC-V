      --------------------------------------------------------------------------
      --                                                                      --
      --                                 UART                                 --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --             UART TX             --
      -------------------------------------
      check_gpr( instruction    => "addi  x3,  x0,   0x44",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"00000044",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x4,  x0,   0xD",
                 gpr            => spy_gpr(4),
                 desired_value  => 32x"0000000d",
                 test_point     => set_test_point );                 
      check_uart_tx( instruction=> "sw    x3,  243(x0)",
                 desired_value  => 32x"00000044",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x3,  x0,   0",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_uart_tx( instruction=> "sw    x4,  243(x0)",
                 desired_value  => 32x"0000000d",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x4,  x0,   0",
                 gpr            => spy_gpr(4),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      -------------------------------------
      --             UART RX             --
      -------------------------------------
      check_gpr( instruction    => "addi  x1,  x0,   0xAB",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"000000ab",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x2,  x0,   0x12",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"00000012",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x3,  x0,   0xCD",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"000000CD",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x4,  x0,   0x99",
                 gpr            => spy_gpr(4),
                 desired_value  => 32x"00000099",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x5,  x0,   0",
                 gpr            => spy_gpr(5),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_uart_rx( value_to_send     => 32x"ABEEEEEE",
                 number_bytes_to_send  => 4,
                 out_rx                => rx_tb,
                 test_point            => set_test_point );
      check_uart_rx( value_to_send     => 32x"00120000",
                 number_bytes_to_send  => 3,
                 out_rx                => rx_tb,
                 test_point            => set_test_point );
      check_uart_rx( value_to_send     => 32x"0000CDEF",
                 number_bytes_to_send  => 2,
                 out_rx                => rx_tb,
                 test_point            => set_test_point );
      check_uart_rx( value_to_send     => 32x"00000099",
                 number_bytes_to_send  => 1,
                 out_rx                => rx_tb,
                 test_point            => set_test_point );   
      check_gpr( instruction    => "addi  x2,  x0,   0",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x2,  x2,   1",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x2,  x2,   1",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"00000002",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x2,  x2,   1",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"00000003",
                 test_point     => set_test_point );
