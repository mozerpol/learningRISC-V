      --------------------------------------------------------------------------
      --                                                                      --
      --                                  I2C                                 --
      --                                                                      --
      --------------------------------------------------------------------------
      check_gpr("lui   x1,  0xF0E7C", x"F0E7C000", clk_tb, test_point);
      check_gpr("addi  x1,  x1,   0x381", x"F0E7C381", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --          Read one byte          --
      -------------------------------------
      check_gpr("lui   x3,  1", x"00001000", clk_tb, test_point);
      check_gpr("addi  x3,  x3,   -1707", x"00000955", clk_tb, test_point);
      check_i2c_rx(7x"55", x"F0E7C381", 1, s_i2c_sda_tb, clk_tb, test_point);
      check_gpr("addi  x4,  x0,   0x1", x"00000001", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000002", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000003", clk_tb, test_point);
      -------------------------------------
      --          Read two bytes         --
      -------------------------------------
      check_gpr("lui   x3,  1", x"00001000", clk_tb, test_point);
      check_gpr("addi  x3,  x3,   -1451", x"00000A55", clk_tb, test_point);
      check_i2c_rx(7x"55", x"F0E7C381", 2, s_i2c_sda_tb, clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000004", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000005", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000006", clk_tb, test_point);
      -------------------------------------
      --         Read three bytes        --
      -------------------------------------
      check_gpr("lui   x3,  1", x"00001000", clk_tb, test_point);
      check_gpr("addi  x3,  x3,   -1195", x"00000B55", clk_tb, test_point);
      check_i2c_rx(7x"55", x"F0E7C381", 3, s_i2c_sda_tb, clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000007", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000008", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000009", clk_tb, test_point);
      -------------------------------------
      --         Read four bytes         --
      -------------------------------------
      check_gpr("lui   x3,  1", x"00001000", clk_tb, test_point);
      check_gpr("addi  x3,  x3,   -964", x"00000C3C", clk_tb, test_point);
      check_i2c_rx(7x"3C", x"F0E7C381", 4, s_i2c_sda_tb, clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"0000000A", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"0000000B", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"0000000C", clk_tb, test_point);
