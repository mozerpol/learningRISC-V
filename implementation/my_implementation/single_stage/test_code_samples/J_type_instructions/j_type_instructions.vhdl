      --------------------------------------------------------------------------
      --                                                                      --
      --                               JAL, JALR                              --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --  Prepare registers, reset them  --
      -------------------------------------
      check_gpr( instruction    => "addi  x1,  x0,   0",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x12,  x0,   0",
                 gpr            => spy_gpr(12),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x13,  x0,   0",
                 gpr            => spy_gpr(13),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x14,  x0,   0",
                 gpr            => spy_gpr(14),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x16,  x0,   0",
                 gpr            => spy_gpr(16),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x17,  x0,   0",
                 gpr            => spy_gpr(17),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x18,  x0,   0",
                 gpr            => spy_gpr(18),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x19,  x0,   0",
                 gpr            => spy_gpr(19),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x20,  x0,   0",
                 gpr            => spy_gpr(20),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x21,  x0,   0",
                 gpr            => spy_gpr(21),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x22,  x0,   0",
                 gpr            => spy_gpr(22),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x23,  x0,   0",
                 gpr            => spy_gpr(23),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x24,  x0,   0",
                 gpr            => spy_gpr(24),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x25,  x0,   0",
                 gpr            => spy_gpr(25),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      -------------------------------------
      --               JAL               --
      -------------------------------------
      wait until rising_edge(clk_tb); -- auipc x12, 0
      wait until rising_edge(clk_tb); -- jal   x13, loop22
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      check_gpr( instruction    => "sub   x14, x13,  x12",
                 gpr            => spy_gpr(14),
                 desired_value  => 32x"00000008",
                 test_point     => set_test_point );
      wait until rising_edge(clk_tb); -- jal   x14, loop23
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000002",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000003",
                 test_point     => set_test_point );
      wait until rising_edge(clk_tb); -- jal   x16, loop24
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000004",
                 test_point     => set_test_point );
      check_gpr( instruction    => "sub   x17, x16,  x14",
                 gpr            => spy_gpr(17),
                 desired_value  => 32x"fffffff4",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x1,  x0,   0",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      -------------------------------------
      --               JALR              --
      -------------------------------------
      wait until rising_edge(clk_tb); -- auipc x18, 0
      wait until rising_edge(clk_tb); -- jalr  x19, x18,  8
      check_gpr( instruction    => "sub   x20, x19,  x18",
                 gpr            => spy_gpr(20),
                 desired_value  => 32x"00000008",
                 test_point     => set_test_point );
      wait until rising_edge(clk_tb); -- jalr  x20, x18,  32
      wait until rising_edge(clk_tb); -- auipc x21, 0
      check_gpr( instruction    => "sub   x21, x21,  x20",
                 gpr            => spy_gpr(21),
                 desired_value  => 32x"00000010",
                 test_point     => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x21,  0
      wait until rising_edge(clk_tb); -- jalr  x22, x21,  -24
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x23,  0
      check_gpr( instruction    => "sub   x24, x22,  x21",
                 gpr            => spy_gpr(24),
                 desired_value  => 32x"00000008",
                 test_point     => set_test_point );
      wait until rising_edge(clk_tb); -- jalr  x24, x23,  28
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000002",
                 test_point     => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x25,  0
      check_gpr( instruction    => "sub   x25, x25,  x24",
                 gpr            => spy_gpr(25),
                 desired_value  => 32x"00000014",
                 test_point     => set_test_point );
