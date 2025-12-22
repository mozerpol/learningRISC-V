      --------------------------------------------------------------------------
      --                                                                      --
      --           ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND           --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --        Prepare registers        --
      -------------------------------------
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   -1", x"ffffffff", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   -1", x"ffffffff", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   -1", x"ffffffff", clk_tb, test_point);
      check_gpr("addi  x5,  x0,   -2048", x"fffff800", clk_tb, test_point);
      check_gpr("addi  x6,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x7,  x0,   2046", x"000007fe", clk_tb, test_point);
      check_gpr("addi  x8,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x9,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x10, x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x11, x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x12, x0,   -511", x"fffffe01", clk_tb, test_point);
      check_gpr("addi  x13, x0,   0xff", x"000000ff", clk_tb, test_point);
      check_gpr("slli  x13, x13,  4", x"00000ff0", clk_tb, test_point);
      check_gpr("addi  x13, x13,  0xE", x"00000ffe", clk_tb, test_point);
      check_gpr("addi  x14, x0,   4", x"00000004", clk_tb, test_point);
      check_gpr("addi  x15, x0,   -1024", x"fffffc00", clk_tb, test_point);
      check_gpr("addi  x16, x0,   0x1", x"00000001", clk_tb, test_point);
      check_gpr("slli  x16, x16,  31", x"80000000", clk_tb, test_point);               
      check_gpr("addi  x17, x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x18, x0,   -2", x"fffffffe", clk_tb, test_point);
      check_gpr("addi  x19, x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x19, x19,  -256", x"ffffff00", clk_tb, test_point);          
      check_gpr("addi  x20, x0,   511", x"000001ff", clk_tb, test_point);
      check_gpr("addi  x21, x0,   4", x"00000004", clk_tb, test_point);
      check_gpr("slli  x21, x21,  20", x"00400000", clk_tb, test_point);
      check_gpr("addi  x21, x21,  -1", x"003fffff", clk_tb, test_point);
      check_gpr("addi  x22, x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("slli  x22, x22,  12", x"00001000", clk_tb, test_point);
      check_gpr("addi  x22, x22,  -1", x"00000fff", clk_tb, test_point);
      check_gpr("addi  x23, x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x24, x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("slli  x24, x24,  12", x"00001000", clk_tb, test_point);
      check_gpr("addi  x24, x24,  -1", x"00000fff", clk_tb, test_point);
      check_gpr("addi  x25, x0,   2", x"00000002", clk_tb, test_point);
      check_gpr("slli  x25, x25,  20", x"00200000", clk_tb, test_point);
      check_gpr("addi  x25, x25,  -1", x"001fffff", clk_tb, test_point);    
      check_gpr("addi  x26, x0,   0x7f", x"0000007f", clk_tb, test_point);
      check_gpr("addi  x27, x0,   2", x"00000002", clk_tb, test_point);
      check_gpr("slli  x27, x27,  20", x"00200000", clk_tb, test_point);
      check_gpr("addi  x27, x27,  -1", x"001fffff", clk_tb, test_point);
      check_gpr("addi  x28, x0,   -1", x"ffffffff", clk_tb, test_point);
      check_gpr("addi  x29, x0,   -1", x"ffffffff", clk_tb, test_point);
      check_gpr("addi  x30, x0,   -1", x"ffffffff", clk_tb, test_point);
      check_gpr("addi  x31, x0,   -1", x"ffffffff", clk_tb, test_point);
      -------------------------------------
      --               ADD               --
      -------------------------------------
      check_gpr("add   x30, x0,   x28", x"ffffffff", clk_tb, test_point);
      check_gpr("add   x31, x0,   x27", x"001fffff", clk_tb, test_point);
      check_gpr("add   x1,  x0,   x26", x"0000007f", clk_tb, test_point);
      check_gpr("add   x2,  x0,   x25", x"001fffff", clk_tb, test_point);
      check_gpr("add   x3,  x0,   x24", x"00000fff", clk_tb, test_point);
      check_gpr("add   x4,  x0,   x16", x"80000000", clk_tb, test_point);
      check_gpr("add   x5,  x0,   x0", x"00000000", clk_tb, test_point);
      check_gpr("add   x30, x5,   x30", x"ffffffff", clk_tb, test_point);
      check_gpr("add   x31, x30,  x5", x"ffffffff", clk_tb, test_point);
      check_gpr("add   x1,  x3,   x27", x"00200ffe", clk_tb, test_point);
      check_gpr("add   x2,  x2,   x28", x"001ffffe", clk_tb, test_point);
      check_gpr("add   x3,  x1,   x29", x"00200ffd", clk_tb, test_point);
      check_gpr("add   x4,  x31,  x26", x"0000007e", clk_tb, test_point);
      check_gpr("add   x5,  x30,  x25", x"001ffffe", clk_tb, test_point);
      check_gpr("add   x5,  x5,   x5", x"003ffffc", clk_tb, test_point);
      check_gpr("add   x5,  x5,   x5", x"007ffff8", clk_tb, test_point);
      -------------------------------------
      --               SUB               --
      -------------------------------------
      check_gpr("sub   x6,  x0,   x28", x"00000001", clk_tb, test_point);
      check_gpr("sub   x7,  x0,   x27", x"ffe00001", clk_tb, test_point);
      check_gpr("sub   x8,  x0,   x26", x"ffffff81", clk_tb, test_point);
      check_gpr("sub   x9,  x0,   x25", x"ffe00001", clk_tb, test_point);
      check_gpr("sub   x10, x0,   x24", x"fffff001", clk_tb, test_point);
      check_gpr("sub   x11, x0,   x16", x"80000000", clk_tb, test_point);
      check_gpr("sub   x12, x0,   x0", x"00000000", clk_tb, test_point);
      check_gpr("sub   x6,  x15,  x6", x"fffffbff", clk_tb, test_point);
      check_gpr("sub   x7,  x16,  x5", x"7f800008", clk_tb, test_point);
      check_gpr("sub   x8,  x13,  x28", x"00000fff", clk_tb, test_point);
      check_gpr("sub   x9,  x12,  x27", x"ffe00001", clk_tb, test_point);
      check_gpr("sub   x10, x10,  x26", x"ffffef82", clk_tb, test_point);
      check_gpr("sub   x11, x31,  x25", x"ffe00000", clk_tb, test_point);
      check_gpr("sub   x12, x30,  x24", x"fffff000", clk_tb, test_point);
      check_gpr("sub   x12, x12,  x12", x"00000000", clk_tb, test_point);
      check_gpr("sub   x12, x12,  x12", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               SLL               --
      -------------------------------------
      check_gpr("sll   x13, x28,  x0", x"ffffffff", clk_tb, test_point);
      check_gpr("sll   x14, x27,  x0", x"001fffff", clk_tb, test_point);
      check_gpr("sll   x15, x26,  x0", x"0000007f", clk_tb, test_point);
      check_gpr("sll   x16, x25,  x0", x"001fffff", clk_tb, test_point);
      check_gpr("sll   x17, x24,  x0", x"00000fff", clk_tb, test_point);
      check_gpr("sll   x18, x16,  x0", x"001fffff", clk_tb, test_point);
      check_gpr("sll   x19, x0,   x0", x"00000000", clk_tb, test_point);
      check_gpr("sll   x13, x15,  x6", x"80000000", clk_tb, test_point);
      check_gpr("sll   x14, x16,  x5", x"ff000000", clk_tb, test_point);
      check_gpr("sll   x15, x13,  x28", x"00000000", clk_tb, test_point);
      check_gpr("sll   x16, x12,  x27", x"00000000", clk_tb, test_point);
      check_gpr("sll   x17, x10,  x26", x"00000000", clk_tb, test_point);
      check_gpr("sll   x18, x31,  x25", x"80000000", clk_tb, test_point);
      check_gpr("sll   x19, x30,  x24", x"80000000", clk_tb, test_point);
      check_gpr("sll   x19, x19,  x19", x"80000000", clk_tb, test_point);
      check_gpr("sll   x19, x19,  x19", x"80000000", clk_tb, test_point);
      -------------------------------------
      --               SLT               --
      -------------------------------------
      check_gpr("slt   x20, x28,  x0", x"00000001", clk_tb, test_point);
      check_gpr("slt   x21, x27,  x0", x"00000000", clk_tb, test_point);
      check_gpr("slt   x22, x26,  x0", x"00000000", clk_tb, test_point);
      check_gpr("slt   x23, x25,  x0", x"00000000", clk_tb, test_point);
      check_gpr("slt   x24, x24,  x0", x"00000000", clk_tb, test_point);
      check_gpr("slt   x25, x16,  x0", x"00000000", clk_tb, test_point);
      check_gpr("slt   x26, x0,   x0", x"00000000", clk_tb, test_point);
      check_gpr("slt   x20, x15,  x6", x"00000000", clk_tb, test_point);
      check_gpr("slt   x21, x16,  x5", x"00000001", clk_tb, test_point);
      check_gpr("slt   x22, x13,  x28", x"00000001", clk_tb, test_point);
      check_gpr("slt   x23, x12,  x27", x"00000001", clk_tb, test_point);
      check_gpr("slt   x24, x10,  x26", x"00000001", clk_tb, test_point);
      check_gpr("slt   x25, x31,  x25", x"00000001", clk_tb, test_point);
      check_gpr("slt   x26, x30,  x24", x"00000001", clk_tb, test_point);
      check_gpr("slt   x20, x20,  x20", x"00000000", clk_tb, test_point);
      check_gpr("slt   x20, x20,  x20", x"00000000", clk_tb, test_point);
      -------------------------------------
      --              SLTU               --
      -------------------------------------
      check_gpr("sltu  x27, x1,   x0", x"00000000", clk_tb, test_point);
      check_gpr("sltu  x28, x2,   x0", x"00000000", clk_tb, test_point);
      check_gpr("sltu  x29, x3,   x0", x"00000000", clk_tb, test_point);
      check_gpr("sltu  x30, x4,   x0", x"00000000", clk_tb, test_point);
      check_gpr("sltu  x31, x5,   x0", x"00000000", clk_tb, test_point);
      check_gpr("sltu  x1,  x6,   x0", x"00000000", clk_tb, test_point);
      check_gpr("sltu  x2,  x0,   x0", x"00000000", clk_tb, test_point);
      check_gpr("sltu  x27, x1,   x6", x"00000001", clk_tb, test_point);
      check_gpr("sltu  x28, x2,   x5", x"00000001", clk_tb, test_point);
      check_gpr("sltu  x29, x3,   x28", x"00000000", clk_tb, test_point);
      check_gpr("sltu  x30, x4,   x27", x"00000000", clk_tb, test_point);
      check_gpr("sltu  x31, x5,   x26", x"00000000", clk_tb, test_point);
      check_gpr("sltu  x1,  x6,   x25", x"00000000", clk_tb, test_point);
      check_gpr("sltu  x2,  x7,   x24", x"00000000", clk_tb, test_point);
      check_gpr("sltu  x2,  x2,   x2", x"00000000", clk_tb, test_point);
      check_gpr("sltu  x2,  x2,   x2", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               XOR               --
      -------------------------------------
      check_gpr("xor   x3,  x10,  x11", x"001fef82", clk_tb, test_point);
      check_gpr("xor   x4,  x11,  x10", x"001fef82", clk_tb, test_point);
      check_gpr("xor   x5,  x14,  x8", x"ff000fff", clk_tb, test_point);
      check_gpr("xor   x6,  x7,   x14", x"80800008", clk_tb, test_point);
      check_gpr("xor   x7,  x5,   x8", x"ff000000", clk_tb, test_point);
      check_gpr("xor   x8,  x6,   x0", x"80800008", clk_tb, test_point);
      check_gpr("xor   x9,  x0,   x0", x"00000000", clk_tb, test_point);
      check_gpr("xor   x3,  x6,   x6", x"00000000", clk_tb, test_point);
      check_gpr("xor   x4,  x5,   x11", x"00e00fff", clk_tb, test_point);
      check_gpr("xor   x5,  x7,   x10", x"00ffef82", clk_tb, test_point);
      check_gpr("xor   x6,  x11,  x8", x"7f600008", clk_tb, test_point);
      check_gpr("xor   x7,  x14,  x14", x"00000000", clk_tb, test_point);
      check_gpr("xor   x8,  x10,  x13", x"7fffef82", clk_tb, test_point);
      check_gpr("xor   x9,  x5,   x3", x"00ffef82", clk_tb, test_point);
      check_gpr("xor   x9,  x9,   x9", x"00000000", clk_tb, test_point);
      check_gpr("xor   x9,  x9,   x9", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               SRL               --
      -------------------------------------
      check_gpr("srl   x10, x10,  x11", x"ffffef82", clk_tb, test_point);
      check_gpr("srl   x11, x11,  x10", x"3ff80000", clk_tb, test_point);
      check_gpr("srl   x12, x14,  x8", x"3fc00000", clk_tb, test_point);
      check_gpr("srl   x13, x7,   x14", x"00000000", clk_tb, test_point);
      check_gpr("srl   x14, x5,   x8", x"003ffbe0", clk_tb, test_point);
      check_gpr("srl   x15, x6,   x0", x"7f600008", clk_tb, test_point);
      check_gpr("srl   x16, x0,   x0", x"00000000", clk_tb, test_point);
      check_gpr("srl   x10, x10,  x6", x"00ffffef", clk_tb, test_point);
      check_gpr("srl   x11, x11,  x11", x"3ff80000", clk_tb, test_point);
      check_gpr("srl   x12, x2,   x10", x"00000000", clk_tb, test_point);
      check_gpr("srl   x13, x13,  x8", x"00000000", clk_tb, test_point);
      check_gpr("srl   x14, x14,  x14", x"003ffbe0", clk_tb, test_point);
      check_gpr("srl   x15, x15,  x13", x"7f600008", clk_tb, test_point);
      check_gpr("srl   x16, x16,  x3", x"00000000", clk_tb, test_point);
      check_gpr("srl   x16, x16,  x16", x"00000000", clk_tb, test_point);
      check_gpr("srl   x16, x16,  x16", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               SRA               --
      -------------------------------------
      check_gpr("sra   x17, x4,   x6", x"0000e00f", clk_tb, test_point);
      check_gpr("sra   x18, x6,   x4", x"00000000", clk_tb, test_point);
      check_gpr("sra   x19, x6,   x8", x"1fd80002", clk_tb, test_point);
      check_gpr("sra   x20, x7,   x9", x"00000000", clk_tb, test_point);
      check_gpr("sra   x21, x8,   x19", x"1ffffbe0", clk_tb, test_point);
      check_gpr("sra   x22, x9,   x5", x"00000000", clk_tb, test_point);
      check_gpr("sra   x23, x10,  x0", x"00ffffef", clk_tb, test_point);
      check_gpr("sra   x17, x6,   x5", x"1fd80002", clk_tb, test_point);
      check_gpr("sra   x18, x7,   x11", x"00000000", clk_tb, test_point);
      check_gpr("sra   x19, x8,   x10", x"0000ffff", clk_tb, test_point);
      check_gpr("sra   x20, x9,   x8", x"00000000", clk_tb, test_point);
      check_gpr("sra   x21, x14,  x14", x"003ffbe0", clk_tb, test_point);
      check_gpr("sra   x22, x15,  x13", x"7f600008", clk_tb, test_point);
      check_gpr("sra   x23, x16,  x3", x"00000000", clk_tb, test_point);
      check_gpr("sra   x23, x23,  x23", x"00000000", clk_tb, test_point);
      check_gpr("sra   x23, x23,  x23", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               OR                --
      -------------------------------------
      check_gpr("or    x24, x4,   x8", x"7fffefff", clk_tb, test_point);
      check_gpr("or    x25, x8,   x4", x"7fffefff", clk_tb, test_point);
      check_gpr("or    x26, x6,   x0", x"7f600008", clk_tb, test_point);
      check_gpr("or    x27, x7,   x10", x"00ffffef", clk_tb, test_point);
      check_gpr("or    x28, x8,   x19", x"7fffffff", clk_tb, test_point);
      check_gpr("or    x29, x10,  x5", x"00ffffef", clk_tb, test_point);
      check_gpr("or    x30, x11,  x0", x"3ff80000", clk_tb, test_point);
      check_gpr("or    x24, x6,   x5", x"7fffef8a", clk_tb, test_point);
      check_gpr("or    x25, x7,   x11", x"3ff80000", clk_tb, test_point);
      check_gpr("or    x26, x8,   x10", x"7fffffef", clk_tb, test_point);
      check_gpr("or    x27, x10,  x8", x"7fffffef", clk_tb, test_point);
      check_gpr("or    x28, x11,  x14", x"3ffffbe0", clk_tb, test_point);
      check_gpr("or    x29, x16,  x13", x"00000000", clk_tb, test_point);
      check_gpr("or    x30, x15,  x5", x"7fffef8a", clk_tb, test_point);
      check_gpr("or    x30, x30,  x30", x"7fffef8a", clk_tb, test_point);
      check_gpr("or    x30, x30,  x30", x"7fffef8a", clk_tb, test_point);
      -------------------------------------
      --               AND               --
      -------------------------------------
      check_gpr("and   x31, x4,   x6", x"00600008", clk_tb, test_point);
      check_gpr("and   x1,  x6,   x4", x"00600008", clk_tb, test_point);
      check_gpr("and   x2,  x6,   x8", x"7f600000", clk_tb, test_point);
      check_gpr("and   x3,  x10,  x9", x"00000000", clk_tb, test_point);
      check_gpr("and   x4,  x8,   x19", x"0000ef82", clk_tb, test_point);
      check_gpr("and   x5,  x11,  x5", x"00f80000", clk_tb, test_point);
      check_gpr("and   x31, x10,  x0", x"00000000", clk_tb, test_point);
      check_gpr("and   x1,  x6,   x5", x"00600000", clk_tb, test_point);
      check_gpr("and   x2,  x7,   x11", x"00000000", clk_tb, test_point);
      check_gpr("and   x3,  x8,   x10", x"00ffef82", clk_tb, test_point);
      check_gpr("and   x4,  x5,   x8", x"00f80000", clk_tb, test_point);
      check_gpr("and   x5,  x14,  x14", x"003ffbe0", clk_tb, test_point);
      check_gpr("and   x6,  x16,  x13", x"00000000", clk_tb, test_point);
      check_gpr("and   x7,  x15,  x4", x"00600000", clk_tb, test_point);
      check_gpr("and   x7,  x7,   x7", x"00600000", clk_tb, test_point);
      check_gpr("and   x7,  x7,   x7", x"00600000", clk_tb, test_point);
