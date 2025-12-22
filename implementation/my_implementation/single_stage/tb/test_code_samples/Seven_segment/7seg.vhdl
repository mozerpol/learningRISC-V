      --------------------------------------------------------------------------
      --                                                                      --
      --                        SEVEN SEGMENT DISPLAY                         --
      --                                                                      --
      --------------------------------------------------------------------------
      check_gpr("addi  x1,  x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   8", x"00000008", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   9", x"00000009", clk_tb, test_point);
      -------------------------------------
      --         SEVEN SEGMENT 1         --
      -------------------------------------
      check_7segment("sw    x0,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x1,  247(x0)", b"0000110", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x2,  247(x0)", b"1111111", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x3,  247(x0)", b"1101111", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      -------------------------------------
      --         SEVEN SEGMENT 2         --
      -------------------------------------
      check_gpr("slli  x1,  x1,   8", x"00000100", clk_tb, test_point);
      check_gpr("slli  x2,  x2,   8", x"00000800", clk_tb, test_point);
      check_gpr("slli  x3,  x3,   8", x"00000900", clk_tb, test_point);
      check_7segment("sw    x0,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x1,  247(x0)", b"0111111", b"0000110", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x2,  247(x0)", b"0111111", b"1111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x3,  247(x0)", b"0111111", b"1101111", b"0111111",
                      b"0111111", clk_tb, test_point);
      -------------------------------------
      --         SEVEN SEGMENT 3         --
      -------------------------------------
      check_gpr("slli  x1,  x1,   8", x"00010000", clk_tb, test_point);
      check_gpr("slli  x2,  x2,   8", x"00080000", clk_tb, test_point);
      check_gpr("slli  x3,  x3,   8", x"00090000", clk_tb, test_point);
      check_7segment("sw    x0,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x1,  247(x0)", b"0111111", b"0111111", b"0000110",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x2,  247(x0)", b"0111111", b"0111111", b"1111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x3,  247(x0)", b"0111111", b"0111111", b"1101111",
                      b"0111111", clk_tb, test_point);
      -------------------------------------
      --         SEVEN SEGMENT 4         --
      -------------------------------------
      check_gpr("slli  x1,  x1,   8", x"01000000", clk_tb, test_point);
      check_gpr("slli  x2,  x2,   8", x"08000000", clk_tb, test_point);
      check_gpr("slli  x3,  x3,   8", x"09000000", clk_tb, test_point);
      check_7segment("sw    x0,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x1,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"0000110", clk_tb, test_point);
      check_7segment("sw    x2,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"1111111", clk_tb, test_point);
      check_7segment("sw    x3,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"1101111", clk_tb, test_point);
