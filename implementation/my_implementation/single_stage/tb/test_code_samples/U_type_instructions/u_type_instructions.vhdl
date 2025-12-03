      --------------------------------------------------------------------------
      --                                                                      --
      --                              LUI, AUIPC                              --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --              AUIPC              --
      -------------------------------------
      wait until rising_edge(clk_tb); -- auipc x8,  0
      wait until rising_edge(clk_tb); -- auipc x9,  0
      check_gpr( instruction    => "sub   x10, x9,   x8",
                 gpr            => spy_gpr(10),
                 desired_value  => 32x"00000004",
                 test_point     => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x11, 0
      wait until rising_edge(clk_tb); -- auipc x12, 1048575
      check_gpr( instruction    => "sub   x13, x12,  x11",
                 gpr            => spy_gpr(13),
                 desired_value  => 32x"fffff004",
                 test_point     => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x14, 0
      wait until rising_edge(clk_tb); -- auipc x15, 2048
      check_gpr( instruction    => "sub   x16, x15, x14",
                 gpr            => spy_gpr(16),
                 desired_value  => 32x"00800004",
                 test_point     => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x17, 0
      wait until rising_edge(clk_tb); -- auipc x18, 1
      check_gpr( instruction    => "sub   x19, x18, x17",
                 gpr            => spy_gpr(19),
                 desired_value  => 32x"00001004",
                 test_point     => set_test_point );
      -------------------------------------
      --               LUI               --
      -------------------------------------
      check_gpr( instruction    => "lui   x16, 0",
                 gpr            => spy_gpr(16),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lui   x17, 1048575",
                 gpr            => spy_gpr(17),
                 desired_value  => 32x"fffff000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lui   x18, 524287",
                 gpr            => spy_gpr(18),
                 desired_value  => 32x"7ffff000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lui   x19, 1024",
                 gpr            => spy_gpr(19),
                 desired_value  => 32x"00400000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lui   x20, 512",
                 gpr            => spy_gpr(20),
                 desired_value  => 32x"00200000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lui   x20, 512",
                 gpr            => spy_gpr(20),
                 desired_value  => 32x"00200000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lui   x21, 1",
                 gpr            => spy_gpr(21),
                 desired_value  => 32x"00001000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "lui   x21, 3",
                 gpr            => spy_gpr(21),
                 desired_value  => 32x"00003000",
                 test_point     => set_test_point );
