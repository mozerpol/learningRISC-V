      --------------------------------------------------------------------------
      --                                                                      --
      --                            COUNTER 8-BIT                             --
      --                                                                      --
      --------------------------------------------------------------------------
      check_gpr( instruction    => "addi  x1,  x0,   0x2",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000002",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x2,  x0,   0x212",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"00000212",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x3,  x0,   0x1",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x4,  x0,   0x0",
                 gpr            => spy_gpr(4),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      wait until rising_edge(clk_tb); -- Have to wait one additional clock cycle
      -- the counter value will be readable (stabilized).
      check_cnt(instruction => "sb    x3,  251(x0)",
                 cnt_val        => spy_cnt1,
                 desired_value  => 1,
                 test_point     => set_test_point );
      check_cnt(instruction => "sb    x0,  251(x0)",
                 cnt_val        => spy_cnt1,
                 desired_value  => 0,
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x0,  x0,   0x0",
                 gpr            => spy_gpr(0),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x0,  x0,   0x0",
                 gpr            => spy_gpr(0),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x0,  x0,   0x0",
                 gpr            => spy_gpr(0),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_cnt(instruction => "sb    x3,  251(x0)",
                 cnt_val        => spy_cnt1,
                 desired_value  => 1,
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x0,  x0,   0x0",
                 gpr            => spy_gpr(0),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x0,  x0,   0x0",
                 gpr            => spy_gpr(0),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_cnt(instruction => "sb    x0,  251(x0)",
                 cnt_val        => spy_cnt1,
                 desired_value  => 0,
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x0,  x0,   0x0",
                 gpr            => spy_gpr(0),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x0,  x0,   0x0",
                 gpr            => spy_gpr(0),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x0,  x0,   0x0",
                 gpr            => spy_gpr(0),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_cnt(instruction => "sb    x3,  251(x0)",
                 cnt_val        => spy_cnt1,
                 desired_value  => 1,
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x4,  x4,   0x1",
                 gpr            => spy_gpr(4),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      for i in 0 to 1056 loop
         -- A loop while the timer is counting.
         -- bne x4, x2, -4   fe221ee3
         -- addi x4, x4, 1   00120213
         wait until rising_edge(clk_tb);
      end loop;
      check_gpr( instruction    => "addi  x4,  x0,   0x0",
                 gpr            => spy_gpr(4),
                 desired_value  => 32x"00000212",
                 test_point     => set_test_point );
      check_cnt(instruction => "sb    x0,  251(x0)",
                 cnt_val        => spy_cnt1,
                 desired_value  => 37,
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x4,  x0,   0x0",
                 gpr            => spy_gpr(4),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_cnt(instruction => "sb    x3,  251(x0)",
                 cnt_val        => spy_cnt1,
                 desired_value  => 0,
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x0,  x0,   0x0",
                 gpr            => spy_gpr(0),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x0,  x0,   0x0",
                 gpr            => spy_gpr(0),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x0,  x0,   0x0",
                 gpr            => spy_gpr(0),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lw    x5,  251(x0)",
                 gpr            => spy_gpr(5),
                 desired_value  => 32x"00000003",
                 test_point     => set_test_point );
      check_cnt(instruction => "sb    x0,  251(x0)",
                 cnt_val        => spy_cnt1,
                 desired_value  => 5,
                 test_point     => set_test_point );
