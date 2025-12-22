      --------------------------------------------------------------------------
      --                                                                      --
      --         ADDI, SLTI, SLTIU, XORI, ORI, ANDI, SLLI, SRLI, SRAI         --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --               ADDI              --
      -------------------------------------      
      check_gpr("addi  x1,  x0,   -2048", x"fffff800", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   -511", x"fffffe01", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   -2", x"fffffffe", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x5,  x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("addi  x6,  x0,   511", x"000001ff", clk_tb, test_point);
      check_gpr("addi  x7,  x0,   2047", x"000007ff", clk_tb, test_point);
      check_gpr("addi  x1,  x7,   -2048", x"ffffffff", clk_tb, test_point);
      check_gpr("addi  x2,  x6,   -511", x"00000000", clk_tb, test_point);
      check_gpr("addi  x3,  x5,   -2", x"ffffffff", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x5,  x3,   1", x"00000000", clk_tb, test_point);
      check_gpr("addi  x6,  x2,   511", x"000001ff", clk_tb, test_point);
      check_gpr("addi  x7,  x1,   2047", x"000007fe", clk_tb, test_point);
      check_gpr("addi  x1,  x1,   2047", x"000007fe", clk_tb, test_point);
      check_gpr("addi  x1,  x1,   -2048", x"fffffffe", clk_tb, test_point);
      -------------------------------------
      --               SLTI              --
      -------------------------------------
      check_gpr("slti  x8,  x0,   -2048", x"00000000", clk_tb, test_point);
      check_gpr("slti  x9,  x0,   -511", x"00000000", clk_tb, test_point);
      check_gpr("slti  x10, x0,   -2", x"00000000", clk_tb, test_point);
      check_gpr("slti  x11, x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("slti  x12, x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("slti  x13, x0,   511", x"00000001", clk_tb, test_point);
      check_gpr("slti  x14, x0,   2047", x"00000001", clk_tb, test_point);
      check_gpr("slti  x8,  x7,   -2048", x"00000000", clk_tb, test_point);
      check_gpr("slti  x9,  x1,   -511", x"00000000", clk_tb, test_point);
      check_gpr("slti  x10, x12,  -2", x"00000000", clk_tb, test_point);
      check_gpr("slti  x11, x11,  0", x"00000000", clk_tb, test_point);
      check_gpr("slti  x12, x10,  1", x"00000001", clk_tb, test_point);
      check_gpr("slti  x13, x6,   511", x"00000000", clk_tb, test_point);
      check_gpr("slti  x14, x9,   2047", x"00000001", clk_tb, test_point);
      check_gpr("slti  x14, x14,  2047", x"00000001", clk_tb, test_point);
      check_gpr("slti  x14, x14,  -2048", x"00000000", clk_tb, test_point);
      -------------------------------------
      --              SLTIU              --
      -------------------------------------
      check_gpr("sltiu x15, x0,   -2048", x"00000001", clk_tb, test_point);
      check_gpr("sltiu x16, x0,   -511", x"00000001", clk_tb, test_point);
      check_gpr("sltiu x17, x0,   -2", x"00000001", clk_tb, test_point);
      check_gpr("sltiu x18, x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("sltiu x19, x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("sltiu x20, x0,   511", x"00000001", clk_tb, test_point);
      check_gpr("sltiu x21, x0,   2047", x"00000001", clk_tb, test_point);
      check_gpr("sltiu x15, x7,   -2048", x"00000001", clk_tb, test_point);
      check_gpr("sltiu x16, x1,   -511", x"00000000", clk_tb, test_point);
      check_gpr("sltiu x17, x19,  -2", x"00000001", clk_tb, test_point);
      check_gpr("sltiu x18, x18,  0", x"00000000", clk_tb, test_point);
      check_gpr("sltiu x19, x17,  1", x"00000000", clk_tb, test_point);
      check_gpr("sltiu x20, x6,   511", x"00000000", clk_tb, test_point);
      check_gpr("sltiu x21, x15,  2047", x"00000001", clk_tb, test_point);
      check_gpr("sltiu x21, x21,  2047", x"00000001", clk_tb, test_point);
      check_gpr("sltiu x21, x21,  -2048", x"00000001", clk_tb, test_point);
      -------------------------------------
      --               XORI              --
      -------------------------------------
      check_gpr("xori  x22, x0,   -2048", x"fffff800", clk_tb, test_point);
      check_gpr("xori  x23, x0,   -511", x"fffffe01", clk_tb, test_point);
      check_gpr("xori  x24, x0,   -2", x"fffffffe", clk_tb, test_point);
      check_gpr("xori  x25, x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("xori  x26, x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("xori  x27, x0,   511", x"000001ff", clk_tb, test_point);
      check_gpr("xori  x28, x0,   2047", x"000007ff", clk_tb, test_point);
      check_gpr("xori  x22, x28,  -2048", x"ffffffff", clk_tb, test_point);
      check_gpr("xori  x23, x27,  -511", x"fffffffe", clk_tb, test_point);
      check_gpr("xori  x24, x26,  -2", x"ffffffff", clk_tb, test_point);
      check_gpr("xori  x25, x25,  0", x"00000000", clk_tb, test_point);
      check_gpr("xori  x26, x24,  1", x"fffffffe", clk_tb, test_point);
      check_gpr("xori  x27, x23,  511", x"fffffe01", clk_tb, test_point);
      check_gpr("xori  x28, x22,  2047", x"fffff800", clk_tb, test_point);
      check_gpr("xori  x28, x28,  2047", x"ffffffff", clk_tb, test_point);
      check_gpr("xori  x28, x28,  -2048", x"000007ff", clk_tb, test_point);
      -------------------------------------
      --               ORI               --
      -------------------------------------
      check_gpr("ori   x29, x0,   -2048", x"fffff800", clk_tb, test_point);
      check_gpr("ori   x30, x0,   -511", x"fffffe01", clk_tb, test_point);
      check_gpr("ori   x31, x0,   -2", x"fffffffe", clk_tb, test_point);
      check_gpr("ori   x1,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("ori   x2,  x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("ori   x3,  x0,   511", x"000001ff", clk_tb, test_point);
      check_gpr("ori   x4,  x0,   2047", x"000007ff", clk_tb, test_point);
      check_gpr("ori   x29, x4,   -2048", x"ffffffff", clk_tb, test_point);
      check_gpr("ori   x30, x3,   -511", x"ffffffff", clk_tb, test_point);
      check_gpr("ori   x31, x2,   -2", x"ffffffff", clk_tb, test_point);
      check_gpr("ori   x1,  x1,   0", x"00000000", clk_tb, test_point);
      check_gpr("ori   x2,  x31,  1", x"ffffffff", clk_tb, test_point);
      check_gpr("ori   x3,  x30,  511", x"ffffffff", clk_tb, test_point);
      check_gpr("ori   x4,  x28,  2047", x"000007ff", clk_tb, test_point);
      check_gpr("ori   x4,  x4,   2047", x"000007ff", clk_tb, test_point);
      check_gpr("ori   x4,  x4,   -2048", x"ffffffff", clk_tb, test_point);
      -------------------------------------
      --               ANDI              --
      -------------------------------------
      check_gpr("andi  x5,  x0,   -2048", x"00000000", clk_tb, test_point);
      check_gpr("andi  x6,  x0,   -511", x"00000000", clk_tb, test_point);
      check_gpr("andi  x7,  x0,   -2", x"00000000", clk_tb, test_point);
      check_gpr("andi  x8,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("andi  x9,  x0,   1", x"00000000", clk_tb, test_point);
      check_gpr("andi  x10, x0,   511", x"00000000", clk_tb, test_point);
      check_gpr("andi  x11, x0,   2047", x"00000000", clk_tb, test_point);
      check_gpr("andi  x5,  x4,   -2048", x"fffff800", clk_tb, test_point);
      check_gpr("andi  x6,  x10,  -511", x"00000000", clk_tb, test_point);
      check_gpr("andi  x7,  x28,  -2", x"000007fe", clk_tb, test_point);
      check_gpr("andi  x8,  x27,  0", x"00000000", clk_tb, test_point);
      check_gpr("andi  x9,  x7,   1", x"00000000", clk_tb, test_point);
      check_gpr("andi  x10, x6,   511", x"00000000", clk_tb, test_point);
      check_gpr("andi  x11, x5,   2047", x"00000000", clk_tb, test_point);
      check_gpr("andi  x11, x11,  2047", x"00000000", clk_tb, test_point);
      check_gpr("andi  x11, x11,  -2048", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               SLLI              --
      -------------------------------------
      check_gpr("slli  x12, x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("slli  x13, x0,   1", x"00000000", clk_tb, test_point);
      check_gpr("slli  x14, x0,   2", x"00000000", clk_tb, test_point);
      check_gpr("slli  x15, x0,   10", x"00000000", clk_tb, test_point);
      check_gpr("slli  x16, x0,   20", x"00000000", clk_tb, test_point);
      check_gpr("slli  x17, x0,   31", x"00000000", clk_tb, test_point);
      check_gpr("slli  x12, x27,  0", x"fffffe01", clk_tb, test_point);
      check_gpr("slli  x13, x28,  1", x"00000ffe", clk_tb, test_point);
      check_gpr("slli  x14, x21,  2", x"00000004", clk_tb, test_point);
      check_gpr("slli  x15, x29,  10", x"fffffc00", clk_tb, test_point);
      check_gpr("slli  x16, x5,   20", x"80000000", clk_tb, test_point);
      check_gpr("slli  x17, x7,   31", x"00000000", clk_tb, test_point);
      check_gpr("slli  x17, x17,  31", x"00000000", clk_tb, test_point);
      check_gpr("slli  x17, x17,  0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               SRLI              --
      -------------------------------------
      check_gpr("srli  x18, x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("srli  x19, x0,   1", x"00000000", clk_tb, test_point);
      check_gpr("srli  x20, x0,   2", x"00000000", clk_tb, test_point);
      check_gpr("srli  x21, x0,   10", x"00000000", clk_tb, test_point);
      check_gpr("srli  x22, x0,   20", x"00000000", clk_tb, test_point);
      check_gpr("srli  x23, x0,   31", x"00000000", clk_tb, test_point);
      check_gpr("srli  x18, x26,  0", x"fffffffe", clk_tb, test_point);
      check_gpr("srli  x19, x27,  1", x"7fffff00", clk_tb, test_point);
      check_gpr("srli  x20, x28,  2", x"000001ff", clk_tb, test_point);
      check_gpr("srli  x21, x29,  10", x"003fffff", clk_tb, test_point);
      check_gpr("srli  x22, x30,  20", x"00000fff", clk_tb, test_point);
      check_gpr("srli  x23, x7,   31", x"00000000", clk_tb, test_point);
      check_gpr("srli  x23, x23,  31", x"00000000", clk_tb, test_point);
      check_gpr("srli  x23, x23,  0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               SRAI              --
      -------------------------------------
      check_gpr("srai  x24, x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("srai  x25, x0,   1", x"00000000", clk_tb, test_point);
      check_gpr("srai  x26, x0,   2", x"00000000", clk_tb, test_point);
      check_gpr("srai  x27, x0,   10", x"00000000", clk_tb, test_point);
      check_gpr("srai  x28, x0,   20", x"00000000", clk_tb, test_point);
      check_gpr("srai  x29, x0,   31", x"00000000", clk_tb, test_point);
      check_gpr("srai  x24, x22,  0", x"00000fff", clk_tb, test_point);
      check_gpr("srai  x25, x21,  1", x"001fffff", clk_tb, test_point);
      check_gpr("srai  x26, x20,  2", x"0000007f", clk_tb, test_point);
      check_gpr("srai  x27, x19,  10", x"001fffff", clk_tb, test_point);
      check_gpr("srai  x28, x18,  20", x"ffffffff", clk_tb, test_point);
      check_gpr("srai  x29, x16,  31", x"ffffffff", clk_tb, test_point);
      check_gpr("srai  x29, x29,  31", x"ffffffff", clk_tb, test_point);
      check_gpr("srai  x29, x29,  0", x"ffffffff", clk_tb, test_point);
