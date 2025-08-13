      ----------------------------------------------------------------
      --                                                            --
      --              BEQ, BNE, BLT, BGE, BLTU, BGEU                --
      --                                                            --
      ----------------------------------------------------------------
      check_gpr( instruction    => "addi  x1,  x0,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x2,  x0,   2",
                 gpr            => spy_gpr(2),
                 desired_value  => 32x"00000002",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x3,  x0,   -1",
                 gpr            => spy_gpr(3),
                 desired_value  => 32x"ffffffff",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x4,  x0,   ff",
                 gpr            => spy_gpr(4),
                 desired_value  => 32x"000000ff",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x5,  x0,   4",
                 gpr            => spy_gpr(5),
                 desired_value  => 32x"00000004",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x7,  x0,   -4",
                 gpr            => spy_gpr(7),
                 desired_value  => 32x"fffffffc",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x8,  x0,   -8",
                 gpr            => spy_gpr(8),
                 desired_value  => 32x"fffffff8",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x9,  x0,   0",
                 gpr            => spy_gpr(9),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      --------------
      --   BEQ    --
      --------------
      check_gpr( instruction    => "addi  x0,  x0,   0",
                 gpr            => spy_gpr(0),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      check_branch( instruction   => "beq   x3,  x4,   loop1",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x10, 0
      check_branch( instruction   => "beq   x0,  x9,   loop2",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x11, 0
      check_gpr( instruction    => "sub   x12, x11,  x10",
                 gpr            => spy_gpr(12),
                 desired_value  => 32x"00000024",
                 test_point     => set_test_point );
      check_branch( instruction   => "beq   x0,  x9,   loop4",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x13, 0
      check_gpr( instruction    => "sub  x14, x13, x11",
                 gpr            => spy_gpr(14),
                 desired_value  => 32x"ffffffe8",
                 test_point     => set_test_point );
      check_branch( instruction   => "beq   x5,  x7,   loop6",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x15, 0
      check_gpr( instruction    => "sub   x16, x15,  x13",
                 gpr            => spy_gpr(16),
                 desired_value  => 32x"0000000c",
                 test_point     => set_test_point );
      check_branch( instruction   => "beq   x9,  x0,   loop6",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x17, 0
      check_gpr( instruction    => "sub   x18, x17,  x15",
                 gpr            => spy_gpr(18),
                 desired_value  => 32x"00000018",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000002",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x1,  x0,   0",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      --------------
      --   BNE    --
      --------------
      wait until rising_edge(clk_tb); -- auipc x19, 0
      check_branch( instruction   => "bne   x3,  x4,   loop7",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x20, 0
      check_gpr( instruction    => "sub   x21, x20,  x19",
                 gpr            => spy_gpr(21),
                 desired_value  => 32x"00000024",
                 test_point     => set_test_point );
      check_branch( instruction   => "bne   x5,  x7,   loop8",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x22, 0
      check_gpr( instruction    => "sub   x23, x22,  x20",
                 gpr            => spy_gpr(23),
                 desired_value  => 32x"ffffffe4",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      check_branch( instruction   => "bne   x9,  x0,   loop9",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x24, 0
      check_gpr( instruction    => "sub   x25, x24,  x22",
                 gpr            => spy_gpr(25),
                 desired_value  => 32x"00000010",
                 test_point     => set_test_point );
      check_branch( instruction   => "bne   x7,  x8,   loop9",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x26, 0
      check_gpr( instruction    => "sub   x27, x26,  x24",
                 gpr            => spy_gpr(27),
                 desired_value  => 32x"00000018",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x1,  x0,   0",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      --------------
      --   BLT    --
      --------------
      wait until rising_edge(clk_tb); -- auipc x28, 0
      check_branch( instruction   => "blt   x3,  x4,   loop10",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x29, 0
      check_gpr( instruction    => "sub   x30, x29,  x28",
                 gpr            => spy_gpr(30),
                 desired_value  => 32x"0000001c",
                 test_point     => set_test_point );
      check_branch( instruction   => "blt   x4,  x3,   loop11",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      check_branch( instruction   => "blt   x9,  x0,   loop11",
                    branch_result => spy_branch_result,
                    desired_value => '0',
                    test_point    => set_test_point );
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000002",
                 test_point     => set_test_point );
      check_branch( instruction   => "blt   x8,  x7,   loop11",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x31, 0
      check_gpr( instruction    => "sub   x10, x31,  x28",
                 gpr            => spy_gpr(10),
                 desired_value  => 32x"00000008",
                 test_point     => set_test_point );
      check_branch( instruction   => "blt   x7,  x8,   loop12",
                    branch_result => spy_branch_result,
                    desired_value => '0',
                    test_point    => set_test_point );
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000003",
                 test_point     => set_test_point );
      check_branch( instruction   => "blt   x3,  x1,   loop12",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x11, 0
      check_gpr( instruction    => "sub   x12, x11,  x31",
                 gpr            => spy_gpr(12),
                 desired_value  => 32x"00000030",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x1,  x0,   0",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      --------------
      --   BGE    --
      --------------
      wait until rising_edge(clk_tb); -- auipc x13, 0
      check_branch( instruction   => "bge   x4,  x3,   loop13",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x14, 0
      check_gpr( instruction    => "sub   x15, x14,  x13",
                 gpr            => spy_gpr(15),
                 desired_value  => 32x"0000001c",
                 test_point     => set_test_point );
      check_branch( instruction   => "bge   x3,  x4,   loop14",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      check_branch( instruction   => "bge   x7,  x4,   loop14",
                    branch_result => spy_branch_result,
                    desired_value => '0',
                    test_point    => set_test_point );
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000002",
                 test_point     => set_test_point );
      check_branch( instruction   => "bge   x0,  x9,   loop14",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x16, 0
      check_gpr( instruction    => "sub   x17, x16,  x14",
                 gpr            => spy_gpr(17),
                 desired_value  => 32x"ffffffec",
                 test_point     => set_test_point );
      check_branch( instruction   => "bge   x8,  x7,   loop15",
                    branch_result => spy_branch_result,
                    desired_value => '0',
                    test_point    => set_test_point );
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000003",
                 test_point     => set_test_point );
      check_branch( instruction   => "bge   x1,  x3,   loop15",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x18, 0
      check_gpr( instruction    => "sub   x12, x18,  x17",
                 gpr            => spy_gpr(12),
                 desired_value  => 32x"00000030",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x1,  x0,   0",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      --------------
      --   BLTU   --
      --------------
      wait until rising_edge(clk_tb); -- auipc x20, 0
      check_branch( instruction   => "bltu  x8,  x7,   loop16",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x21, 0
      check_gpr( instruction    => "sub   x22, x21,  x20",
                 gpr            => spy_gpr(22),
                 desired_value  => 32x"00000024",
                 test_point     => set_test_point );
      check_branch( instruction   => "bltu  x8,  x7,   loop17",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x23, 0
      check_gpr( instruction    => "sub   x24, x23,  x21",
                 gpr            => spy_gpr(24),
                 desired_value  => 32x"ffffffe4",
                 test_point     => set_test_point );
      check_branch( instruction   => "bltu  x9,  x0,   loop18",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      check_branch( instruction   => "bltu  x3,  x4,   loop18",
                    branch_result => spy_branch_result,
                    desired_value => '0',
                    test_point    => set_test_point );
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000002",
                 test_point     => set_test_point );
      check_branch( instruction   => "bltu  x4,  x3,   loop18",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x25, 0
      check_gpr( instruction    => "sub   x26, x25,  x23",
                 gpr            => spy_gpr(26),
                 desired_value  => 32x"00000028",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x1,  x0,   0",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
      --------------
      --   BGEU   --
      --------------
      wait until rising_edge(clk_tb); -- auipc x27, 0
      check_branch( instruction   => "bgeu  x7,  x8,   loop19",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x30, 0
      check_gpr( instruction    => "sub   x31, x30,  x27",
                 gpr            => spy_gpr(31),
                 desired_value  => 32x"00000024",
                 test_point     => set_test_point );
      check_branch( instruction   => "bgeu  x7,  x8,   loop20",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x28, 0
      check_gpr( instruction    => "sub   x29, x28,  x27",
                 gpr            => spy_gpr(29),
                 desired_value  => 32x"00000008",
                 test_point     => set_test_point );
      check_branch( instruction   => "bgeu  x2,  x7,   loop21",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000001",
                 test_point     => set_test_point );
      check_branch( instruction   => "bgeu  x4,  x3,   loop21",
                    branch_result => spy_branch_result,
                    desired_value => '0',
                    test_point    => set_test_point );
      check_gpr( instruction    => "addi  x1,  x1,   1",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000002",
                 test_point     => set_test_point );
      check_branch( instruction   => "bgeu  x3,  x4,   loop21",
                    branch_result => spy_branch_result,
                    desired_value => '1',
                    test_point    => set_test_point );
      wait until rising_edge(clk_tb); -- auipc x10, 0
      check_gpr( instruction    => "sub   x11, x10,  x30",
                 gpr            => spy_gpr(11),
                 desired_value  => 32x"0000000c",
                 test_point     => set_test_point );
      check_gpr( instruction    => "addi  x1,  x0,   0",
                 gpr            => spy_gpr(1),
                 desired_value  => 32x"00000000",
                 test_point     => set_test_point );
