library ieee;
    use ieee.std_logic_1164.all;
    use IEEE.std_logic_unsigned.all;
    use IEEE.math_real.all;

package instruction_memory_pkg is

   constant C_INSTRUCTIONS_NUMBER : integer := 17;
   type t_instructions  is array (0 to C_INSTRUCTIONS_NUMBER-1) of std_logic_vector(31 downto 0);
   type t_rom           is array (0 to C_INSTRUCTIONS_NUMBER*4-1) of std_logic_vector(7 downto 0);

   constant C_CODE : t_instructions := (
                              x"00200093", -- addi  x1, x0, 2      x1  =  x0  +  2     = 2
                              x"00a00213", -- addi  x4, x0, 10     x4  =  x0  +  10    = 10
                              x"001201b3", -- add   x3, x4, x1     x3  =  10  +  2     = 12
                              x"00322123", -- sw    x3, 2(x4)      RAM[2+10]           = 12 -- load 32 bits from gpr(rs2) to RAM(rs1+offset)
                              x"0001a103", -- lw    x2, 0(x3)      x2  =  RAM[0+12]    = 12 -- load 32 bits from RAM(rs1+offset) to gpr(rd)
                              x"00fff2b7", -- lui   x5, 0xFFF      x5                  = 00fff000
                              x"0ffff317", -- auipc x6, 0xffff     x6                  = 0ffff018
                              x"010003ef", -- jal   x7, 16         x7                  = 0x20
                              x"00000013", -- addi  x0, x0, 0      x0  =  x0  +  0     = 0  -- nop
                              x"000404e7", -- jalr  x9, x8, 0      x9                  = 0x28 / 40 dec -- PC + 4
                              x"ff618113", -- addi  x2, x3, -10    x2  =  12  -  10    = 2
                              x"02400467", -- jalr  x8, x0, 36     x8  =               = 0x30 / 48 dec -- PC +4
                              x"001080b3", -- add   x1, x1, x1     x1  =  2   +  2     = 4
                              x"00000013", -- addi  x0, x0, 0      x0  =  x0  +  0     = 0  -- nop
                              x"00000013", -- addi  x0, x0, 0      x0  =  x0  +  0     = 0  -- nop
                              x"00000000",
                              x"00000000"
                           );
end;

package body instruction_memory_pkg is

end package body;
