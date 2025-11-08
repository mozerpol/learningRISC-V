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
