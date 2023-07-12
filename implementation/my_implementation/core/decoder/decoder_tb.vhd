library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;
library decoder_lib;
   use decoder_lib.all;
   use decoder_lib.decoder_pkg.all;

entity decoder_tb is
end decoder_tb;

architecture tb of decoder_tb is

   component decoder is
   port (
      i_rst          : in std_logic;
      i_instruction  : in std_logic_vector(31 downto 0);
      o_rd_addr      : out std_logic_vector(4 downto 0);
      o_rs1_addr     : out std_logic_vector(4 downto 0);
      o_rs2_addr     : out std_logic_vector(4 downto 0);
      o_imm          : out std_logic_vector(31 downto 0);
      o_opcode       : out std_logic_vector(6 downto 0);
      o_func3        : out std_logic_vector(2 downto 0);
      o_func7        : out std_logic_vector(6 downto 0)
   );
   end component decoder;

   signal rst_tb           : std_logic;
   signal instruction_tb   : std_logic_vector(31 downto 0);
   signal rd_addr_tb       : std_logic_vector(4 downto 0);
   signal rs1_addr_tb      : std_logic_vector(4 downto 0);
   signal rs2_addr_tb      : std_logic_vector(4 downto 0);
   signal imm_tb           : std_logic_vector(31 downto 0);
   signal opcode_tb        : std_logic_vector(6 downto 0);
   signal func3_tb         : std_logic_vector(2 downto 0);
   signal func7_tb         : std_logic_vector(6 downto 0);

begin

   inst_decoder : component decoder
   port map (
      i_rst          => rst_tb,
      i_instruction  => instruction_tb,
      o_rd_addr      => rd_addr_tb,
      o_rs1_addr     => rs1_addr_tb,
      o_rs2_addr     => rs2_addr_tb,
      o_imm          => imm_tb,
      o_opcode       => opcode_tb,
      o_func3        => func3_tb,
      o_func7        => func7_tb
   );

   p_tb : process
   begin

      rst_tb <= '1';
      instruction_tb <= (others => '0');
      wait for 20 ns;
      rst_tb         <= '0';

      ---- R-type ----
      -- add x1, x2, x3
      -- Binary = 0000 0000 0011 0001 0000 0000 1011 0011
      -- Hexadecimal = 0x003100b3
      instruction_tb <= "00000000001100010000000010110011";
      wait for 5 ns;
      -- sub x1, x2, x3
      -- Binary = 0100 0000 0011 0001 0000 0000 1011 0011
      -- Hexadecimal = 0x403100b3
      instruction_tb <= "01000000001100010000000010110011";
      wait for 5 ns;
      ---- I-type ----
      -- 1. When instruction(31) = 0
      -- lb x5, 67(x2)
      -- Binary = 0000 0100 0011 0001 0000 0010 1000 0011
      -- Hexadecimal = 0x04310283
      instruction_tb <= "00000100001100010000001010000011";
      wait for 5 ns;
      -- 2. When instruction(31) = 1
      -- lb x12, -67(x1)
      -- Binary = 1111 1011 1101 0000 1000 0110 0000 0011
      -- Hexadecimal = 0xfbd08603
      instruction_tb <= "11111011110100001000011000000011"; 
      wait for 5 ns;
      -- 1. When instruction(31) = 0
      -- jalr x1, x2, 3
      -- Binary = 0000 0000 0011 0001 0000 0000 1110 0111
      -- Hexadecimal = 0x003100e7
      instruction_tb <= "00000000001100010000000011100111";
      wait for 5 ns;
      -- 2. When instruction(31) = 1
      -- jalr x1, x2, -1807
      -- Binary = 1000 1111 0001 0001 0000 0000 1110 0111
      -- Hexadecimal = 0x8f1100e7
      instruction_tb <= "10001111000100010000000011100111";
      wait for 5 ns;
      -- 1. When instruction(31) = 0
      -- addi x2, x1, 33
      -- Binary = 0000 0010 0001 0000 1000 0001 0001 0011
      -- Hexadecimal = 0x02108113
      instruction_tb <= "00000010000100001000000100010011";
      wait for 5 ns;
      -- When instruction(31) = 1
      -- addi x2, x1, -33
      -- Binary = 1111 1101 1111 0000 1000 0001 0001 0011
      -- Hexadecimal = 0xfdf08113
      instruction_tb <= "11111101111100001000000100010011";
      wait for 5 ns;
      ---- S-type ----
      -- sh x1, 200(x2)
      -- Binary = 0000 1100 0001 0001 0001 0100 0010 0011
      -- Hexadecimal = 0x0c111423
      instruction_tb <= "00001100000100010001010000100011";
      wait for 5 ns;
      ---- B-type ----
      -- Assembly = beq x1, x2, 666
      -- Binary = 0010 1000 0010 0000 1000 1101 0110 0011
      -- Hexadecimal = 0x28208d63
      instruction_tb <= "00101000001000001000110101100011";
      wait for 5 ns;
      -- Assembly = bne x1, x2, -102
      -- Binary = 1111 1000 0010 0000 1001 1101 1110 0011
      -- Hexadecimal = 0xf8209de3
      instruction_tb <= "11111000001000001001110111100011";
      wait for 5 ns;
      ---- U-type ----
      -- lui x1, -6
      -- Binary = 1111 1111 1111 1111 1010 0000 1011 0111
      -- Hexadecimal = 0xffffa0b7
      instruction_tb <= "11111111111111111010000010110111";
      wait for 5 ns;
      -- auipc x5, -3841
      -- Binary = 1111 1111 0000 1111 1111 0010 1001 0111
      -- Hexadecimal = 0xff0ff297
      instruction_tb <= "11111111000011111111001010010111";
      wait for 5 ns;
      ---- J-type ----
      -- 1. when instruction(31) = 1
      -- jal x2, -200
      -- Binary = 1111 0011 1001 1111 1111 0001 0110 1111
      -- Hexadecimal = 0xf39ff16f
      instruction_tb <= "11110011100111111111000101101111";
      wait for 5 ns;
      -- 2. when instruction(31) = 0
      -- jal x2, 200
      -- Binary = 0000 1100 1000 0000 0000 0001 0110 1111
      -- Hexadecimal = 0x0c80016f
      instruction_tb <= "00001100100000000000000101101111";
      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
