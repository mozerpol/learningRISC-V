      --------------------------------------------------------------------------
      --                                                                      --
      --                              SB, SH, SW                              --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --        Prepare registers        --
      -------------------------------------
      check_gpr("addi  x1,  x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   2", x"00000002", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   1234", x"000004d2", clk_tb, test_point);
      check_gpr("addi  x5,  x0,   AB", x"000000ab", clk_tb, test_point);
      check_gpr("addi  x6,  x0,   CD", x"000000cd", clk_tb, test_point);
      check_gpr("addi  x7,  x0,   -1024", x"fffffc00", clk_tb, test_point);
      check_gpr("lui   x8,  ABCDE", x"abcde000", clk_tb, test_point);
      check_gpr("addi  x8,  x8,   F1", x"abcde0f1", clk_tb, test_point);
      check_gpr("lui   x9,  12345", x"12345000", clk_tb, test_point);
      check_gpr("addi  x9,  x9,   678", x"12345678", clk_tb, test_point);
      -------------------------------------
      --               SB                --
      -------------------------------------
      check_ram("sb   x9,  0(x0)", x"00000078", 0, 0,clk_tb, test_point);
      check_ram("sb   x9,  1(x0)", x"00000078", 0, 1,clk_tb, test_point);
      check_ram("sb   x9,  1(x1)", x"00000078", 0, 2,clk_tb, test_point);
      check_ram("sb   x9,  1(x2)", x"00000078", 0, 3,clk_tb, test_point);
      check_ram("sb   x9,  2(x2)", x"00000078", 1, 0,clk_tb, test_point);
      check_ram("sb   x8,  -1(x1)", x"000000f1", 0, 0,clk_tb, test_point);
      check_ram("sb   x8,  -1(x2)", x"000000f1", 0, 1,clk_tb, test_point);
      check_ram("sb   x8,  -2(x2)", x"000000f1", 0, 0,clk_tb, test_point);
      check_ram("sb   x8,  10(x0)", x"000000f1",2, 2, clk_tb, test_point);
      check_ram("sb   x8,  16(x1)", x"000000f1", 4, 1, clk_tb, test_point);
      -------------------------------------
      --               SH                --
      -------------------------------------
      check_ram("sh    x8,  0(x0)", x"0000e0f1", 0, 0, clk_tb, test_point);
      check_ram("sh    x8,  1(x1)", x"0000e0f1", 0, 2, clk_tb, test_point);
      check_ram("sh    x8,  2(x2)", x"0000e0f1", 1, 0, clk_tb, test_point);
      check_ram("sh    x9,  -1(x1)", x"00005678", 0, 0, clk_tb, test_point);
      check_ram("sh    x8,  -2(x2)", x"0000e0f1", 0, 0, clk_tb, test_point);
      check_ram("sh    x8,  10(x0)", x"0000e0f1", 2, 2, clk_tb, test_point);
      check_ram("sh    x8,  16(x2)", x"0000e0f1", 4, 2, clk_tb, test_point);
      -------------------------------------
      --               SW                --
      -------------------------------------
      check_ram("sw   x7,  0(x0)", x"fffffc00", 0, 0, clk_tb, test_point);
      check_ram("sw   x7,  2(x2)", x"fffffc00", 0, 0, clk_tb, test_point);
      check_ram("sw   x8,  -1(x1)", x"abcde0f1", 0, 0, clk_tb, test_point);
      check_ram("sw   x7,  -2(x2)", x"fffffc00", 0, 0, clk_tb, test_point);
