      --------------------------------------------------------------------------
      --                                                                      --
      --                        SEVEN SEGMENT DISPLAY                         --
      --                                                                      --
      --------------------------------------------------------------------------
      check_gpr( instruction    => "addi  x1,  x0,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x2,  x0,   8",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"00000008",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x3,  x0,   9",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"00000009",
                 test_point     => set_test_point );
      -------------------------------------
      --         SEVEN SEGMENT 1         --
      -------------------------------------
      check_7segment( instruction    => "sw    x0,  243(x0)",
                 desired_value_segment_1 => 7b"0111111",
                 desired_value_segment_2 => 7b"0111111",
                 desired_value_segment_3 => 7b"0111111",
                 desired_value_segment_4 => 7b"0111111",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x1,  243(x0)",
                 desired_value_segment_1 => 7b"0000110",
                 desired_value_segment_2 => 7b"0111111",
                 desired_value_segment_3 => 7b"0111111",
                 desired_value_segment_4 => 7b"0111111",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x2,  243(x0)",
                 desired_value_segment_1 => 7b"1111111",
                 desired_value_segment_2 => 7b"0111111",
                 desired_value_segment_3 => 7b"0111111",
                 desired_value_segment_4 => 7b"0111111",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x3,  243(x0)",
                 desired_value_segment_1 => 7b"1101111",
                 desired_value_segment_2 => 7b"0111111",
                 desired_value_segment_3 => 7b"0111111",
                 desired_value_segment_4 => 7b"0111111",
                 test_point     => set_test_point );
      -------------------------------------
      --         SEVEN SEGMENT 2         --
      -------------------------------------
      check_gpr( instruction    => "slli  x1,  x1,   8",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000100",
                 test_point     => set_test_point );
      check_gpr( instruction    => "slli  x2,  x2,   8",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"00000800",
                 test_point     => set_test_point );
      check_gpr( instruction    => "slli  x3,  x3,   8",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"00000900",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x0,  243(x0)",
                 desired_value_segment_1 => 7b"0111111",
                 desired_value_segment_2 => 7b"0111111",
                 desired_value_segment_3 => 7b"0111111",
                 desired_value_segment_4 => 7b"0111111",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x1,  243(x0)",
                 desired_value_segment_1 => 7b"0111111",
                 desired_value_segment_2 => 7b"0000110",
                 desired_value_segment_3 => 7b"0111111",
                 desired_value_segment_4 => 7b"0111111",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x2,  243(x0)",
                 desired_value_segment_1 => 7b"0111111",
                 desired_value_segment_2 => 7b"1111111",
                 desired_value_segment_3 => 7b"0111111",
                 desired_value_segment_4 => 7b"0111111",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x3,  243(x0)",
                 desired_value_segment_1 => 7b"0111111",
                 desired_value_segment_2 => 7b"1101111",
                 desired_value_segment_3 => 7b"0111111",
                 desired_value_segment_4 => 7b"0111111",
                 test_point     => set_test_point );
      -------------------------------------
      --         SEVEN SEGMENT 3         --
      -------------------------------------
      check_gpr( instruction    => "slli  x1,  x1,   8",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00010000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "slli  x2,  x2,   8",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"00080000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "slli  x3,  x3,   8",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"00090000",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x0,  243(x0)",
                 desired_value_segment_1 => 7b"0111111",
                 desired_value_segment_2 => 7b"0111111",
                 desired_value_segment_3 => 7b"0111111",
                 desired_value_segment_4 => 7b"0111111",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x1,  243(x0)",
                 desired_value_segment_1 => 7b"0111111",
                 desired_value_segment_2 => 7b"0111111",
                 desired_value_segment_3 => 7b"0000110",
                 desired_value_segment_4 => 7b"0111111",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x2,  243(x0)",
                 desired_value_segment_1 => 7b"0111111",
                 desired_value_segment_2 => 7b"0111111",
                 desired_value_segment_3 => 7b"1111111",
                 desired_value_segment_4 => 7b"0111111",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x3,  243(x0)",
                 desired_value_segment_1 => 7b"0111111",
                 desired_value_segment_2 => 7b"0111111",
                 desired_value_segment_3 => 7b"1101111",
                 desired_value_segment_4 => 7b"0111111",
                 test_point     => set_test_point );
      -------------------------------------
      --         SEVEN SEGMENT 4         --
      -------------------------------------
      check_gpr( instruction    => "slli  x1,  x1,   8",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"01000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "slli  x2,  x2,   8",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"08000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "slli  x3,  x3,   8",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"09000000",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x0,  243(x0)",
                 desired_value_segment_1 => 7b"0111111",
                 desired_value_segment_2 => 7b"0111111",
                 desired_value_segment_3 => 7b"0111111",
                 desired_value_segment_4 => 7b"0111111",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x1,  243(x0)",
                 desired_value_segment_1 => 7b"0111111",
                 desired_value_segment_2 => 7b"0111111",
                 desired_value_segment_3 => 7b"0111111",
                 desired_value_segment_4 => 7b"0000110",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x2,  243(x0)",
                 desired_value_segment_1 => 7b"0111111",
                 desired_value_segment_2 => 7b"0111111",
                 desired_value_segment_3 => 7b"0111111",
                 desired_value_segment_4 => 7b"1111111",
                 test_point     => set_test_point );
      check_7segment( instruction    => "sw    x3,  243(x0)",
                 desired_value_segment_1 => 7b"0111111",
                 desired_value_segment_2 => 7b"0111111",
                 desired_value_segment_3 => 7b"0111111",
                 desired_value_segment_4 => 7b"1101111",
                 test_point     => set_test_point );
