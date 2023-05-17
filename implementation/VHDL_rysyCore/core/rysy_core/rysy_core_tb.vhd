library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity rysy_core_tb is
end rysy_core_tb;
  
architecture tb of rysy_core_tb is

   component rysy_core_design is
      port (
         clk      : in std_logic;
         rst      : in std_logic;
         rdata    : in std_logic_vector (REG_LEN-1 downto 0);
         wdata    : out std_logic_vector(REG_LEN-1 downto 0);
         addr     : out std_logic_vector(REG_LEN-1 downto 0);
         we       : out std_logic;
         be       : out std_logic_vector(3 downto 0)
      );
   end component rysy_core_design;

   signal clk_tb     : std_logic;
   signal rst_tb     : std_logic;
   signal rdata_tb   : std_logic_vector(REG_LEN-1 downto 0);
   signal wdata_tb   : std_logic_vector(REG_LEN-1 downto 0);
   signal addr_tb    : std_logic_vector(REG_LEN-1 downto 0);
   signal we_tb      : std_logic;
   signal be_tb      : std_logic_vector(3 downto 0);
   
begin
   inst_rysy_core : component rysy_core_design 
   port map (
      clk   => clk_tb,
      rst   => rst_tb,
      rdata => rdata_tb,
      wdata => wdata_tb,
      addr  => addr_tb,
      we    => we_tb,
      be    => be_tb
   );

   p_tb : process
   begin
   
      -- Default values
      rdata_tb  <= (others => '0');
      rst_tb    <= '0';
      
      wait for 10 ns;
      -- ....:::::rst_tb = 1;:::::....
      -- next_nop	   in	ctrl		   =	1
      -- load_phase	in	ctrl		   =	0
      -- inst_sel	   in	ctrl		   = 	01
      -- inst		   in	inst_mgmt	=	32'b10011
      -- pc_reg	   in	mem_addr_sel=	0
      rst_tb <= '1';
      wait for 20 ns;
      -- ....:::::rst_tb = 0;:::::....
      -- next_nop	   in	ctrl		   =	0
      -- load_phase	in	ctrl		   =	0
      -- inst_sel	   in	ctrl		   = 	10
      -- inst		   in	inst_mgmt	=	32'b10011
      -- pc_reg		in	mem_addr_sel=	100 (4 in dec, next clk will is 8...)
      rst_tb <= '0';
      wait for 20 ns;
      -- ....:::::rdata_tb = 32'b000000000101_00001_000_00010_0010011;:::::....
      -- This instruction means: addi x2, x1, 0x5
      -- inst 		in	inst_mgmt		=	rdata
      -- inst_sel	in	inst_mgmt		=	10 (INST_MEM)
      -- inst_sel	in	ctrl			   =	10 (INST_MEM)
      -- opcode	in	decode			=	00100 (4 in dec) (OP_IMM in opcodes)
      -- func3		in	decode			=	000
      -- rd			in	decode			=	00010
      -- rs1		in	decode			=	1
      -- rs2		in decode			=	101
      -- imm_type	in	ctrl/imm_mux	=	00100 (4 in dec)
      -- imm		in	imm_mux			=	101
      -- reg_wr	in	ctrl/reg_file	=	1
      wait until (clk_tb'event and clk_tb = '1');
      rdata_tb <= 32b"000000000101_00001_000_00010_0010011";
      wait for 20 ns;
      rst_tb <= '1';
      wait for 20 ns;
      rst_tb <= '0';
      wait for 20 ns;
      wait until (clk_tb'event and clk_tb = '1');
      rdata_tb <= 32b"10101010101_00000_111_00001_0010011"; -- andi x1, x0, 0b010101010101
      wait for 20 ns;
      wait until (clk_tb'event and clk_tb = '1');
      rdata_tb <= 32b"000000000101_00001_000_00010_0010011"; -- addi x2, x1, 0x5
      wait for 20 ns;
      wait until (clk_tb'event and clk_tb = '1');
      rdata_tb <= 32b"0000000_00010_00001_000_00011_0110011"; -- ADD x3, x1, x2
      wait for 20 ns;
      wait until (clk_tb'event and clk_tb = '1');
      rdata_tb <= 32b"0000000000100_00001_010_00010_0010011"; -- slti x2, x1, 4
      wait for 20 ns;
      wait until (clk_tb'event and clk_tb = '1');
      rdata_tb <= 32b"100000000000_00001_011_00010_0010011"; -- sltiu x2, x1, -2048
      wait for 20 ns;
      rst_tb <= '1';
      wait for 20 ns;
      rst_tb <= '0';
      wait for 20 ns; 
      wait until (clk_tb'event and clk_tb = '1');
      rdata_tb <= 32b"0000000_00010_00001_000_00011_0110011"; -- ADD x3, x1, x2
      wait for 20 ns; 
      wait until (clk_tb'event and clk_tb = '1');
      rdata_tb <= 32b"11111111111111111111_00101_0010111"; -- auipc x5, 0xfffff
      wait for 20 ns;
      wait until (clk_tb'event and clk_tb = '1');
      rdata_tb <= 32b"1111111_00001_00010_001_11001_1100011"; -- bne x2, x1, loop - loop is label
      wait for 20 ns;
      wait until (clk_tb'event and clk_tb = '1');
      rdata_tb <= 32b"11111111100111111111_00100_1101111"; -- jal x4, loop
      wait for 20 ns;
      rst_tb <= '1';
      wait for 20 ns;
      rst_tb <= '0';
      wait for 20 ns;
      wait until (clk_tb'event and clk_tb = '1');
      rdata_tb <= 32b"11111111111111111111_00001_0110111"; -- lui x1, 0xFFFFF
      wait for 20 ns;
      wait until (clk_tb'event and clk_tb = '1');
      rdata_tb <= 32b"010101010101_00000_110_00001_0010011"; -- ori x1, x0, 0b10101010101
      wait for 20 ns;
      rdata_tb <= 32b"0000000_00010_00001_000_00011_0110011"; -- ADD x3, x1, x2
      wait for 20 ns;
      wait until (clk_tb'event and clk_tb = '1');
      rdata_tb <= 32b"0000000000100_00001_010_00010_0010011"; -- slti x2, x1, 4
      wait for 20 ns;
      rdata_tb <= 32b"100000000000_00001_011_00010_0010011"; -- sltiu x2, x1, -2048
      wait for 20 ns;
      rdata_tb <= 32b"000000000101_00001_000_00010_0010011"; -- addi x2, x1, 0x5
      wait for 20 ns;
      rdata_tb <= 32b"010101010101_00000_111_00001_0010011"; -- andi x1, x0, 0b010101010101
      wait for 20 ns;
      rdata_tb <= 32b"000000000101_00001_000_00010_0010011"; -- addi x2, x1, 0x5
      wait for 20 ns;
      rdata_tb <= 32b"010101010101_00000_111_00001_0010011"; -- andi x1, x0, 0b010101010101
      wait for 20 ns;
      rdata_tb <= 32b"000000000101_00001_000_00010_0010011"; -- addi x2, x1, 0x5
      wait for 20 ns;
      rdata_tb <= 32b"010101010101_00000_111_00001_0010011"; -- andi x1, x0, 0b010101010101
      wait for 20 ns;
      rdata_tb <= 32b"000000000101_00001_000_00010_0010011"; -- addi x2, x1, 0x5
      wait for 20 ns; 
      rdata_tb <= 32b"11111111111111111111_00101_0010111"; -- auipc x5, 0xfffff
      wait for 20 ns;
      rdata_tb <= 32b"1111111_00001_00010_001_11001_1100011"; -- bne x2, x1, loop - loop is label

      wait for 25 ns;
      stop(2); 
   end process;
   
   p_clk : process
   begin
      clk_tb <= '0';
      wait for 5 ns;
      clk_tb <= '1';
      wait for 5 ns;
   end process p_clk;

end architecture tb;
