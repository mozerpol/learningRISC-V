      --------------------------------------------------------------------------
      --                                                                      --
      --                              LB, LH, LW                              --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --         Prepare registers       --
      -------------------------------------
      check_gpr( instruction    => "addi  x1,  x0,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x2,  x0,   2",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"00000002",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x3,  x0,   0",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x7,  x0,   -1024",
                 gpr            => spy_gpr(7),
                 desired_value  => 32x"fffffc00",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lui   x8,  0xE",
                 gpr            => spy_gpr(8),
                 desired_value  => 32x"0000e000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x8,  x8,   0xF1",
                 gpr            => spy_gpr(8),
                 desired_value  => 32x"0000e0f1",
                 test_point     => set_test_point );
      -------------------------------------
      --          Prepare memory         --
      -------------------------------------
      check_ram( instruction           => "sw   x7,  0(x0)",
                 ram_byte_0            => spy_ram(0)(0),
                 ram_byte_1            => spy_ram(0)(1),
                 ram_byte_2            => spy_ram(0)(2),
                 ram_byte_3            => spy_ram(0)(3),
                 desired_value_byte_0  => x"00",
                 desired_value_byte_1  => x"fc",
                 desired_value_byte_2  => x"ff",
                 desired_value_byte_3  => x"ff",
                 test_point            => set_test_point );
      check_ram( instruction           => "sw   x7,  2(x2)",
                 ram_byte_0            => spy_ram(1)(0),
                 ram_byte_1            => spy_ram(1)(1),
                 ram_byte_2            => spy_ram(1)(2),
                 ram_byte_3            => spy_ram(1)(3),
                 desired_value_byte_0  => x"00",
                 desired_value_byte_1  => x"fc",
                 desired_value_byte_2  => x"ff",
                 desired_value_byte_3  => x"ff",
                 test_point            => set_test_point );
      check_ram( instruction           => "sh    x8,  10(x0)",
                 ram_byte_0            => spy_ram(2)(2),
                 ram_byte_1            => spy_ram(2)(3),
                 desired_value_byte_0  => x"f1",
                 desired_value_byte_1  => x"e0",
                 test_point            => set_test_point );
      -------------------------------------
      --                LB               --
      -------------------------------------
      check_gpr( instruction    => "lb    x3,  0(x1)",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"fffffffc",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lb    x4,  0(x2)",
                 gpr            => spy_gpr(4),
                 desired_value  => 32x"ffffffff",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lb    x5,  11(x0)",
                 gpr            => spy_gpr(5),
                 desired_value  => 32x"ffffffe0",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lb    x7,  -1(x2)",
                 gpr            => spy_gpr(7),
                 desired_value  => 32x"fffffffc",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lb    x8,  -2(x2)",
                 gpr            => spy_gpr(8),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lb    x12, 4(x3)",
                 gpr            => spy_gpr(12),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lb    x13, 15(x3)",
                 gpr            => spy_gpr(13),
                 desired_value  => 32x"ffffffe0",
                 test_point     => set_test_point );
      -------------------------------------
      --                LH               --
      -------------------------------------
      check_gpr( instruction    => "lh    x14, 0(x2)",
                 gpr            => spy_gpr(14),
                 desired_value  => 32x"ffffffff",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lh    x15, 10(x0)",
                 gpr            => spy_gpr(15),
                 desired_value  => 32x"ffffe0f1",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lh    x17, 4(x3)",
                 gpr            => spy_gpr(17),
                 desired_value  => 32x"fffffc00",
                 test_point     => set_test_point );
      -------------------------------------
      --                LW               --
      -------------------------------------
      check_gpr( instruction    => "lw    x18, 2(x2)",
                 gpr            => spy_gpr(18),
                 desired_value  => 32x"fffffc00",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lw    x21, 4(x3)",
                 gpr            => spy_gpr(21),
                 desired_value  => 32x"fffffc00",
                 test_point     => set_test_point );
      -------------------------------------
      --               LBU               --
      -------------------------------------
      check_gpr( instruction    => "addi  x1,  x0,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lbu   x2,  1(x0)",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"000000fc",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lbu   x3,  1(x1)",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"000000ff",
                 test_point     => set_test_point );
      -------------------------------------
      --               LHU               --
      -------------------------------------
      check_gpr( instruction    => "lhu   x4,  4(x0)",
                 gpr            => spy_gpr(4),
                 desired_value  => 32x"0000fc00",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lhu   x5,  1(x1)",
                 gpr            => spy_gpr(5),
                 desired_value  => 32x"0000ffff",
                 test_point     => set_test_point );
