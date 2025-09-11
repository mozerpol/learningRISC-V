      --------------------------------------------------------------------------
      --                                                                      --
      --                              GPIO output                              --
      --                                                                      --
      --------------------------------------------------------------------------
      check_gpr( instruction    => "addi  x1,  x0,   0",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x2,  x0,   15",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"0000000f",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x3,  x0,   0",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x4,  x0,   10",
                 gpr            => spy_gpr(4),
                 desired_value  => 32x"0000000a",
                 test_point     => set_test_point );
      -- loop27:
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      check_gpio(instruction    => "sb    x1,  255(x0)",
                 desired_value  => 8b"00000001",
                 test_point     => set_test_point );
      for i in 0 to 13 loop
         -- loop26:
         for i in 1 to 20 loop
            -- wait for execute loop26
            -- addi  x3,  x3,   1
            -- bne   x3,  x4,   loop26
            wait until rising_edge(clk_tb);
         end loop;
         check_gpr( instruction    => "addi  x3,  x0,   0",
                    gpr            => spy_gpr(3),
                    desired_value  => 32x"00000000",
                    test_point     => set_test_point );
         check_branch( instruction   => "bne   x1,  x2,   loop27",
                       branch_result => spy_branch_result,
                       desired_value => '0',
                       test_point    => set_test_point );
         -- addi  x1,  x1,   1     # Increment x1
         wait until rising_edge(clk_tb);
         -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
         wait until rising_edge(clk_tb);
      end loop;
      -- The last iteration where GPIO = 00001111. This is here (outside the
      -- loop27) because the return value of the instruction bne x1, x2, loop27
      --  is 1, not 0 as inside the loop.
      for i in 1 to 20 loop
         -- wait for execute loop26
         -- addi  x3,  x3,   1
         -- bne   x3,  x4,   loop26
         wait until rising_edge(clk_tb);
      end loop;
      check_gpr( instruction    => "addi  x3,  x0,   0",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_branch( instruction   => "bne   x1,  x2,   loop27",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      check_gpr( instruction    => "addi  x1,  x0,   0",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x3,  x0,   0",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
