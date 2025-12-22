      --------------------------------------------------------------------------
      --                                                                      --
      --                   BEQ, BNE, BLT, BGE, BLTU, BGEU                     --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --        Prepare registers        --
      -------------------------------------
      check_gpr("addi  x1,  x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   2", x"00000002", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   -1", x"ffffffff", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   ff", x"000000ff", clk_tb, test_point);
      check_gpr("addi  x5,  x0,   4", x"00000004", clk_tb, test_point);
      check_gpr("addi  x7,  x0,   -4", x"fffffffc", clk_tb, test_point);
      check_gpr("addi  x8,  x0,   -8", x"fffffff8", clk_tb, test_point);
      check_gpr("addi  x9,  x0,   0", x"00000000", clk_tb, test_point);      
      -------------------------------------
      --               BEQ               --
      -------------------------------------
      check_gpr("addi  x0,  x0,   0", x"00000000", clk_tb, test_point);
      check_branch("beq   x3,  x4,   loop1", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x10, 0
      check_branch("beq   x0,  x9,   loop2", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x11, 0
      check_gpr("sub   x12, x11,  x10", x"00000024", clk_tb, test_point);
      check_branch("beq   x0,  x9,   loop4", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x13, 0
      check_gpr("sub  x14, x13, x11", x"ffffffe8", clk_tb, test_point);
      check_branch("beq   x5,  x7,   loop6", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x15, 0
      check_gpr("sub   x16, x15,  x13", x"0000000c", clk_tb, test_point);
      check_branch("beq   x9,  x0,   loop6", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x17, 0
      check_gpr("sub   x18, x17,  x15", x"00000018", clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000002", clk_tb, test_point);
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               BNE               --
      -------------------------------------
      wait until rising_edge(clk_tb); -- auipc x19, 0
      check_branch("bne   x3,  x4,   loop7", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x20, 0
      check_gpr("sub   x21, x20,  x19", x"00000024", clk_tb, test_point);
      check_branch("bne   x5,  x7,   loop8", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x22, 0
      check_gpr("sub   x23, x22,  x20", x"ffffffe4", clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000001", clk_tb, test_point);
      check_branch("bne   x9,  x0,   loop9", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x24, 0
      check_gpr("sub   x25, x24,  x22", x"00000010", clk_tb, test_point);
      check_branch("bne   x7,  x8,   loop9", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x26, 0
      check_gpr("sub   x27, x26,  x24", x"00000018", clk_tb, test_point);
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               BLT               --
      -------------------------------------
      wait until rising_edge(clk_tb); -- auipc x28, 0
      check_branch("blt   x3,  x4,   loop10", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x29, 0
      check_gpr("sub   x30, x29,  x28", x"0000001c", clk_tb, test_point);
      check_branch("blt   x4,  x3,   loop11", '1', clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000001", clk_tb, test_point);
      check_branch("blt   x9,  x0,   loop11", '0', clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000002", clk_tb, test_point);
      check_branch("blt   x8,  x7,   loop11", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x31, 0
      check_gpr("sub   x10, x31,  x28", x"00000008", clk_tb, test_point);
      check_branch("blt   x7,  x8,   loop12", '0', clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000003", clk_tb, test_point);
      check_branch("blt   x3,  x1,   loop12", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x11, 0
      check_gpr("sub   x12, x11,  x31", x"00000030", clk_tb, test_point);
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               BGE               --
      -------------------------------------
      wait until rising_edge(clk_tb); -- auipc x13, 0
      check_branch("bge   x4,  x3,   loop13", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x14, 0
      check_gpr("sub   x15, x14,  x13", x"0000001c", clk_tb, test_point);
      check_branch("bge   x3,  x4,   loop14", '1', clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000001", clk_tb, test_point);
      check_branch("bge   x7,  x4,   loop14", '0', clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000002", clk_tb, test_point);
      check_branch("bge   x0,  x9,   loop14", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x16, 0
      check_gpr("sub   x17, x16,  x14", x"ffffffec", clk_tb, test_point);
      check_branch("bge   x8,  x7,   loop15", '0', clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000003", clk_tb, test_point);
      check_branch("bge   x1,  x3,   loop15", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x18, 0
      check_gpr("sub   x12, x18,  x17", x"00000030", clk_tb, test_point);
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --              BLTU               --
      -------------------------------------
      wait until rising_edge(clk_tb); -- auipc x20, 0
      check_branch("bltu  x8,  x7,   loop16", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x21, 0
      check_gpr("sub   x22, x21,  x20", x"00000024", clk_tb, test_point);
      check_branch("bltu  x8,  x7,   loop17", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x23, 0
      check_gpr("sub   x24, x23,  x21", x"ffffffe4", clk_tb, test_point);
      check_branch("bltu  x9,  x0,   loop18", '1', clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000001", clk_tb, test_point);
      check_branch("bltu  x3,  x4,   loop18", '0', clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000002", clk_tb, test_point);
      check_branch("bltu  x4,  x3,   loop18", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x25, 0
      check_gpr("sub   x26, x25,  x23", x"00000028", clk_tb, test_point);
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --              BGEU               --
      -------------------------------------
      wait until rising_edge(clk_tb); -- auipc x27, 0
      check_branch("bgeu  x7,  x8,   loop19", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x30, 0
      check_gpr("sub   x31, x30,  x27", x"00000024", clk_tb, test_point);
      check_branch("bgeu  x7,  x8,   loop20", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x28, 0
      check_gpr("sub   x29, x28,  x27", x"00000008", clk_tb, test_point);
      check_branch("bgeu  x2,  x7,   loop21", '1', clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000001", clk_tb, test_point);
      check_branch("bgeu  x4,  x3,   loop21", '0', clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000002", clk_tb, test_point);
      check_branch("bgeu  x3,  x4,   loop21", '1', clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x10, 0
      check_gpr("sub   x11, x10,  x30", x"0000000c", clk_tb, test_point);
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
