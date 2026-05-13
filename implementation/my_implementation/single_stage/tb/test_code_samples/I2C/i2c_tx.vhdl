      --------------------------------------------------------------------------
      --                                                                      --
      --                                  I2C                                 --
      --                                                                      --
      --------------------------------------------------------------------------
      check_gpr("lui   x1,  0xF0E7C", x"F0E7C000", clk_tb, test_point);
      check_gpr("addi  x1,  x1,   0x381", x"F0E7C381", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --          Send one byte          --
      -------------------------------------
      check_i2c_tx(7x"55", x"F0E7C381", 1, '0', s_i2c_sda_tb, clk_tb, test_point);
      check_gpr("addi  x4,  x0,   0x1", x"00000001", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000002", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000003", clk_tb, test_point);
      -------------------------------------
      --          Send two bytes         --
      -------------------------------------
      check_gpr("addi  x3,  x0,   0x278", x"00000278", clk_tb, test_point);
      check_i2c_tx(7x"78", x"F0E7C381", 2, '0', s_i2c_sda_tb, clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000004", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000005", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000006", clk_tb, test_point);
      -------------------------------------
      --         Send three bytes        --
      -------------------------------------
      check_gpr("addi  x3,  x0,   0x30F", x"0000030F", clk_tb, test_point);
      check_i2c_tx(7x"0F", x"F0E7C381", 3, '0', s_i2c_sda_tb, clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000007", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000008", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000009", clk_tb, test_point);
      -------------------------------------
      --         Send four bytes         --
      -------------------------------------
      check_gpr("addi  x3,  x0,   0x47F", x"0000047F", clk_tb, test_point);
      check_i2c_tx(7x"7F", x"F0E7C381", 4, '0', s_i2c_sda_tb, clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"0000000a", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"0000000b", clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"0000000c", clk_tb, test_point);
