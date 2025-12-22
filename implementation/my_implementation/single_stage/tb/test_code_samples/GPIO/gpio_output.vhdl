      --------------------------------------------------------------------------
      --                                                                      --
      --                              GPIO output                             --
      --                                                                      --
      --------------------------------------------------------------------------
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   15", x"0000000f", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   10", x"0000000a", clk_tb, test_point);
      -- loop27:
      check_gpr("addi  x1,  x1,   1", x"00000001", clk_tb, test_point);
      check_gpio("sb    x1,  255(x0)", b"00000001", clk_tb, test_point);
      for i in 0 to 13 loop
         -- loop26:
         for i in 1 to 20 loop
            -- wait for execute loop26
            -- addi  x3,  x3,   1
            -- bne   x3,  x4,   loop26
            wait until rising_edge(clk_tb);
         end loop;
         check_gpr("addi  x3,  x0,   0", x"00000000", clk_tb, test_point);
         check_branch("bne   x1,  x2,   loop27", '0', clk_tb, test_point);
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
      check_gpr("addi  x3,  x0,   0", x"00000000", clk_tb, test_point);
      check_branch("bne   x1,  x2,   loop27", '1', clk_tb, test_point);
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0", x"00000000", clk_tb, test_point);
