--------------------------------------------------------------------------------
-- File          : riscpol_tb.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Test for the entire processor (riscpol entity in
-- riscpol_design). All instructions (in assembly language) from this test are
-- in the file tests/general.asm.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------


library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.numeric_std_unsigned.all;
library std;
   use std.env.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;
   use riscpol_lib.riscpol_tb_pkg.all;


entity riscpol_tb is
end riscpol_tb;


architecture tb of riscpol_tb is


   component riscpol is
   port (
      i_rst_n                 : in std_logic;
      i_clk                   : in std_logic;
      io_gpio                 : inout std_logic_vector(C_NUMBER_OF_GPIO - 1 downto 0);
      i_uart_rx               : in std_logic;
      o_uart_tx               : out std_logic;
      o_7segment_1            : out std_logic_vector(6 downto 0);
      o_7segment_2            : out std_logic_vector(6 downto 0);
      o_7segment_3            : out std_logic_vector(6 downto 0);
      o_7segment_4            : out std_logic_vector(6 downto 0);
      o_7segment_anodes       : out std_logic_vector(3 downto 0);
      i_spi_miso              : in std_logic;
      o_spi_mosi              : out std_logic;
      o_spi_ss_n              : out std_logic;
      o_spi_sclk              : out std_logic
   );
   end component riscpol;


   -----------------------------------------------------------------------------
   -- SIGNALS AND CONSTANTS
   -----------------------------------------------------------------------------
   signal rst_n_tb            : std_logic;
   signal clk_tb              : std_logic;
   signal uart_rx_tb          : std_logic;
   signal uart_tx_tb          : std_logic;
   signal gpio_tb             : std_logic_vector(C_NUMBER_OF_GPIO-1 downto 0);
   signal test_point          : integer := 0;
   signal s_7segment_1_tb     : std_logic_vector(6 downto 0);
   signal s_7segment_2_tb     : std_logic_vector(6 downto 0);
   signal s_7segment_3_tb     : std_logic_vector(6 downto 0);
   signal s_7segment_4_tb     : std_logic_vector(6 downto 0);
   signal s_7segment_anodes_tb: std_logic_vector(3 downto 0);
   signal s_spi_miso_tb       : std_logic;
   signal s_spi_mosi_tb       : std_logic;
   signal s_spi_ss_n_tb       : std_logic;
   signal s_spi_sclk_tb       : std_logic;


begin


   inst_riscpol : component riscpol
   port map (
      i_rst_n           => rst_n_tb,
      i_clk             => clk_tb,
      io_gpio           => gpio_tb,
      i_uart_rx         => uart_rx_tb,
      o_uart_tx         => uart_tx_tb,
      o_7segment_1      => s_7segment_1_tb,
      o_7segment_2      => s_7segment_2_tb,
      o_7segment_3      => s_7segment_3_tb,
      o_7segment_4      => s_7segment_4_tb,
      o_7segment_anodes => s_7segment_anodes_tb,
      i_spi_miso        => s_spi_miso_tb,
      o_spi_mosi        => s_spi_mosi_tb,
      o_spi_ss_n        => s_spi_ss_n_tb,
      o_spi_sclk        => s_spi_sclk_tb
   );


   p_clk : process
   begin
      clk_tb   <= '1';
      wait for C_CLK_PERIOD/2;
      clk_tb   <= '0';
      wait for C_CLK_PERIOD/2;
      -- TODO: add procedure
   end process;


   p_tb : process
   begin

      rst_n_tb       <= '0';
      gpio_tb        <= (others => 'Z');
      uart_rx_tb     <= '1';
      s_spi_miso_tb  <= 'Z';
      wait for C_CLK_PERIOD*20;
      rst_n_tb       <= '1';
      -- After the reset, three delays are required for the simulation purposes.
      -- The first delay is to "detec" the nearest rising edge of the clock.
      -- The second delay is to execute the instruction, but its result is not
      -- yet visible from the simulator.
      -- Thanks to the third delay, the result of execution of the instruction
      -- can be checked.
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
      wait until rising_edge(clk_tb);
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
      --------------------------------------------------------------------------
      --                                                                      --
      --                              LUI, AUIPC                              --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --              AUIPC              --
      -------------------------------------
      wait until rising_edge(clk_tb); -- auipc x8,  0
      wait until rising_edge(clk_tb); -- auipc x9,  0
      check_gpr("sub   x10, x9,   x8", x"00000004", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x11, 0
      wait until rising_edge(clk_tb); -- auipc x12, 1048575
      check_gpr("sub   x13, x12,  x11", x"fffff004", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x14, 0
      wait until rising_edge(clk_tb); -- auipc x15, 2048
      check_gpr("sub   x16, x15, x14", x"00800004", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x17, 0
      wait until rising_edge(clk_tb); -- auipc x18, 1
      check_gpr("sub   x19, x18, x17", x"00001004", clk_tb, test_point);
      -------------------------------------
      --               LUI               --
      -------------------------------------
      check_gpr("lui   x16, 0", x"00000000", clk_tb, test_point);
      check_gpr("lui   x17, 1048575", x"fffff000", clk_tb, test_point);
      check_gpr("lui   x18, 524287", x"7ffff000", clk_tb, test_point);
      check_gpr("lui   x19, 1024", x"00400000", clk_tb, test_point);
      check_gpr("lui   x20, 512", x"00200000", clk_tb, test_point);
      check_gpr("lui   x20, 512", x"00200000", clk_tb, test_point);
      check_gpr("lui   x21, 1", x"00001000", clk_tb, test_point);
      check_gpr("lui   x21, 3", x"00003000", clk_tb, test_point);
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
      --------------------------------------------------------------------------
      --                                                                      --
      --                               JAL, JALR                              --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --        Prepare registers        --
      -------------------------------------
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x12,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x13,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x14,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x16,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x17,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x18,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x19,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x20,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x21,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x22,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x23,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x24,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x25,  x0,   0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               JAL               --
      -------------------------------------
      wait until rising_edge(clk_tb); -- auipc x12, 0
      wait until rising_edge(clk_tb); -- jal   x13, loop22
      check_gpr("addi  x1,  x1,   1", x"00000001", clk_tb, test_point);
      check_gpr("sub   x14, x13,  x12", x"00000008", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- jal   x14, loop23
      check_gpr("addi  x1,  x1,   1", x"00000002", clk_tb, test_point);
      check_gpr("addi  x1,  x1,   1", x"00000003", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- jal   x16, loop24
      check_gpr("addi  x1,  x1,   1", x"00000004", clk_tb, test_point);
      check_gpr("sub   x17, x16,  x14", x"fffffff4", clk_tb, test_point);
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --               JALR              --
      -------------------------------------
      wait until rising_edge(clk_tb); -- auipc x18, 0
      wait until rising_edge(clk_tb); -- jalr  x19, x18,  8
      check_gpr("sub   x20, x19,  x18", x"00000008", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- jalr  x20, x18,  32
      wait until rising_edge(clk_tb); -- auipc x21, 0
      check_gpr("sub   x21, x21,  x20", x"00000010", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x21,  0
      wait until rising_edge(clk_tb); -- jalr  x22, x21,  -24
      check_gpr("addi  x1,  x1,   1", x"00000001", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x23,  0
      check_gpr("sub   x24, x22,  x21", x"00000008", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- jalr  x24, x23,  28
      check_gpr("addi  x1,  x1,   1", x"00000002", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- auipc x25,  0
      check_gpr("sub   x25, x25,  x24", x"00000014", clk_tb, test_point);
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
      --------------------------------------------------------------------------
      --                                                                      --
      --                              LB, LH, LW                              --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --         Prepare registers       --
      -------------------------------------
      check_gpr("addi  x1,  x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   2", x"00000002", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x7,  x0,   -1024", x"fffffc00", clk_tb, test_point);
      check_gpr("lui   x8,  0xE", x"0000e000", clk_tb, test_point);
      check_gpr("addi  x8,  x8,   0xF1", x"0000e0f1", clk_tb, test_point);
      -------------------------------------
      --          Prepare memory         --
      -------------------------------------
      check_ram("sw   x7,  0(x0)", x"fffffc00", 0, 0, clk_tb, test_point);
      check_ram("sw   x7,  2(x2)", x"fffffc00", 0, 0, clk_tb, test_point);
      check_ram("sh    x8,  10(x0)", x"0000e0f1", 2, 2, clk_tb, test_point);
      -------------------------------------
      --                LB               --
      -------------------------------------
      check_gpr("lb    x3,  0(x1)", x"fffffffc", clk_tb, test_point);
      check_gpr("lb    x4,  0(x2)", x"ffffffff", clk_tb, test_point);
      check_gpr("lb    x5,  11(x0)", x"ffffffe0", clk_tb, test_point);
      check_gpr("lb    x7,  -1(x2)", x"fffffffc", clk_tb, test_point);
      check_gpr("lb    x8,  -2(x2)", x"00000000", clk_tb, test_point);
      check_gpr("lb    x12, 4(x3)", x"00000000", clk_tb, test_point);
      check_gpr("lb    x13, 15(x3)", x"ffffffe0", clk_tb, test_point);
      -------------------------------------
      --                LH               --
      -------------------------------------
      check_gpr("lh    x14, 0(x2)", x"ffffffff", clk_tb, test_point);
      check_gpr("lh    x15, 10(x0)", x"ffffe0f1", clk_tb, test_point);
      check_gpr("lh    x17, 4(x3)", x"fffffc00", clk_tb, test_point);
      -------------------------------------
      --                LW               --
      -------------------------------------
      check_gpr("lw    x18, 2(x2)", x"fffffc00", clk_tb, test_point);
      check_gpr("lw    x21, 4(x3)", x"fffffc00", clk_tb, test_point);
      -------------------------------------
      --               LBU               --
      -------------------------------------
      check_gpr("addi  x1,  x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("lbu   x2,  1(x0)", x"000000fc", clk_tb, test_point);
      check_gpr("lbu   x3,  1(x1)", x"000000ff", clk_tb, test_point);
      -------------------------------------
      --               LHU               --
      -------------------------------------
      check_gpr("lhu   x4,  4(x0)", x"0000fc00", clk_tb, test_point);
      check_gpr("lhu   x5,  1(x1)", x"0000ffff", clk_tb, test_point);
      --------------------------------------------------------------------------
      --                                                                      --
      --                              GPIO output                             --
      --                                                                      --
      --------------------------------------------------------------------------
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   15", x"0000000f", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   10", x"0000000a", clk_tb, test_point);
      -- loop27:
      check_gpr("addi  x1,  x1,   1", x"00000001", clk_tb, test_point);
      check_gpio("sb    x1,  255(x0)", b"00000001", clk_tb, test_point);
      for i in 0 to 13 loop
         -- loop26:
         for i in 1 to 20 loop
            -- wait for execute loop26
            -- addi  x3,  x3,   1
            -- bne   x3,  x4,   loop26
            wait until rising_edge(clk_tb);
         end loop;
         check_gpr("addi  x3,  x0,   0", x"00000000", clk_tb, test_point);
         check_branch("bne   x1,  x2,   loop27", '0', clk_tb, test_point);
         -- addi  x1,  x1,   1     # Increment x1
         wait until rising_edge(clk_tb);
         -- sb    x1,  255(x0)     # Assign the value of x1 to GPIO
         wait until rising_edge(clk_tb);
      end loop;
      -- The last iteration where GPIO = 00001111. This is here (outside the
      -- loop27) because the return value of the instruction bne x1, x2, loop27
      --  is 1, not 0 as inside the loop.
      for i in 1 to 20 loop
         -- wait for execute loop26
         -- addi  x3,  x3,   1
         -- bne   x3,  x4,   loop26
         wait until rising_edge(clk_tb);
      end loop;
      check_gpr("addi  x3,  x0,   0", x"00000000", clk_tb, test_point);
      check_branch("bne   x1,  x2,   loop27", '1', clk_tb, test_point);
      check_gpr("addi  x1,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0", x"00000000", clk_tb, test_point);
      --------------------------------------------------------------------------
      --                                                                      --
      --                              GPIO input                              --
      --                                                                      --
      --------------------------------------------------------------------------
      gpio_tb        <= 8b"00001101"; -- Simulate GPIO input
      wait until rising_edge(clk_tb); -- nop instruction
      wait until rising_edge(clk_tb); -- nop instruction
      wait until rising_edge(clk_tb); -- nop instruction
      wait until rising_edge(clk_tb); -- nop instruction
      wait until rising_edge(clk_tb); -- nop instruction
      -- Check if value 0000000D has been loaded into register x1
      check_gpr("lw    x1,  255(x0)", x"0000000D", clk_tb, test_point);
      gpio_tb        <= (others => 'Z');
      --------------------------------------------------------------------------
      --                                                                      --
      --                            COUNTER 8-BIT                             --
      --                                                                      --
      --------------------------------------------------------------------------
      check_gpr("addi  x1,  x0,   0x2", x"00000002", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   0x212", x"00000212", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0x1", x"00000001", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   0x0", x"00000000", clk_tb, test_point);
      wait until rising_edge(clk_tb); -- Have to wait one additional clock cycle
      -- the counter value will be readable (stabilized).
      check_cnt("sb    x3,  251(x0)", 1, clk_tb, test_point);
      check_cnt("sb    x0,  251(x0)", 0, clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_cnt("sb    x3,  251(x0)", 1, clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_cnt("sb    x0,  251(x0)", 0, clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_cnt("sb    x3,  251(x0)", 1, clk_tb, test_point);
      check_gpr("addi  x4,  x4,   0x1", x"00000001", clk_tb, test_point);
      for i in 0 to 1056 loop
         -- A loop while the timer is counting.
         -- bne x4, x2, -4   fe221ee3
         -- addi x4, x4, 1   00120213
         wait until rising_edge(clk_tb);
      end loop;
      check_gpr("addi  x4,  x0,   0x0", x"00000212", clk_tb, test_point);
      check_cnt("sb    x0,  251(x0)", 37, clk_tb, test_point);
      check_gpr("addi  x4,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_cnt("sb    x3,  251(x0)", 0, clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x0,  x0,   0x0", x"00000000", clk_tb, test_point);
      check_gpr("lw    x5,  251(x0)", x"00000003", clk_tb, test_point);
      check_cnt("sb    x0,  251(x0)", 5, clk_tb, test_point);
      --------------------------------------------------------------------------
      --                                                                      --
      --                        SEVEN SEGMENT DISPLAY                         --
      --                                                                      --
      --------------------------------------------------------------------------
      check_gpr("addi  x1,  x0,   1", x"00000001", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   8", x"00000008", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   9", x"00000009", clk_tb, test_point);
      -------------------------------------
      --         SEVEN SEGMENT 1         --
      -------------------------------------
      check_7segment("sw    x0,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x1,  247(x0)", b"0000110", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x2,  247(x0)", b"1111111", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x3,  247(x0)", b"1101111", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      -------------------------------------
      --         SEVEN SEGMENT 2         --
      -------------------------------------
      check_gpr("slli  x1,  x1,   8", x"00000100", clk_tb, test_point);
      check_gpr("slli  x2,  x2,   8", x"00000800", clk_tb, test_point);
      check_gpr("slli  x3,  x3,   8", x"00000900", clk_tb, test_point);
      check_7segment("sw    x0,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x1,  247(x0)", b"0111111", b"0000110", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x2,  247(x0)", b"0111111", b"1111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x3,  247(x0)", b"0111111", b"1101111", b"0111111",
                      b"0111111", clk_tb, test_point);
      -------------------------------------
      --         SEVEN SEGMENT 3         --
      -------------------------------------
      check_gpr("slli  x1,  x1,   8", x"00010000", clk_tb, test_point);
      check_gpr("slli  x2,  x2,   8", x"00080000", clk_tb, test_point);
      check_gpr("slli  x3,  x3,   8", x"00090000", clk_tb, test_point);
      check_7segment("sw    x0,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x1,  247(x0)", b"0111111", b"0111111", b"0000110",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x2,  247(x0)", b"0111111", b"0111111", b"1111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x3,  247(x0)", b"0111111", b"0111111", b"1101111",
                      b"0111111", clk_tb, test_point);
      -------------------------------------
      --         SEVEN SEGMENT 4         --
      -------------------------------------
      check_gpr("slli  x1,  x1,   8", x"01000000", clk_tb, test_point);
      check_gpr("slli  x2,  x2,   8", x"08000000", clk_tb, test_point);
      check_gpr("slli  x3,  x3,   8", x"09000000", clk_tb, test_point);
      check_7segment("sw    x0,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"0111111", clk_tb, test_point);
      check_7segment("sw    x1,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"0000110", clk_tb, test_point);
      check_7segment("sw    x2,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"1111111", clk_tb, test_point);
      check_7segment("sw    x3,  247(x0)", b"0111111", b"0111111", b"0111111",
                      b"1101111", clk_tb, test_point);
      --------------------------------------------------------------------------
      --                                                                      --
      --                                 UART                                 --
      --                                                                      --
      --------------------------------------------------------------------------
      -------------------------------------
      --             UART TX             --
      -------------------------------------
      check_gpr("addi  x3,  x0,   0x44", x"00000044", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   0xD", x"0000000d", clk_tb, test_point);                 
      check_uart_tx("sw    x3,  243(x0)", x"00000044", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0", x"00000000", clk_tb, test_point);
      check_uart_tx("sw    x4,  243(x0)", x"0000000d", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   0", x"00000000", clk_tb, test_point);
      -------------------------------------
      --             UART RX             --
      -------------------------------------
      check_gpr("addi  x1,  x0,   0xAB", x"000000ab", clk_tb, test_point);
      check_gpr("addi  x2,  x0,   0x12", x"00000012", clk_tb, test_point);
      check_gpr("addi  x3,  x0,   0xCD", x"000000CD", clk_tb, test_point);
      check_gpr("addi  x4,  x0,   0x99", x"00000099", clk_tb, test_point);
      check_gpr("addi  x5,  x0,   0", x"00000000", clk_tb, test_point);
      check_uart_rx(x"ABEEEEEE", 4, uart_rx_tb, clk_tb, test_point);
      check_uart_rx(x"00120000", 3, uart_rx_tb, clk_tb, test_point);
      check_uart_rx(x"0000CDEF", 2, uart_rx_tb, clk_tb, test_point);
      check_uart_rx(x"00000099", 1, uart_rx_tb, clk_tb, test_point);
      check_gpr("addi  x2,  x0,   0", x"00000000", clk_tb, test_point);
      check_gpr("addi  x2,  x2,   1", x"00000001", clk_tb, test_point);
      check_gpr("addi  x2,  x2,   1", x"00000002", clk_tb, test_point);
      check_gpr("addi  x2,  x2,   1", x"00000003", clk_tb, test_point);
      --------------------------------------------------------------------------
      --                                                                      --
      --                    Check behaviour after reset                       --
      --      The first instruction from rom.vhdl is always loaded during     --
      --      the reset.                                                      --
      --                                                                      --
      --------------------------------------------------------------------------
      wait for 1 us;
      rst_n_tb   <= '0';
      wait for C_CLK_PERIOD*20+C_CLK_PERIOD/2;
      rst_n_tb   <= '1';
      -- After the reset, three delays are required for the simulation purposes.
      -- The first delay is to "detec" the nearest rising edge of the clock.
      -- The second delay is to execute the instruction, but its result is not
      -- yet visible from the simulator.
      -- Thanks to the third delay, the result of execution of the instruction
      -- can be checked.

      -- wait until rising_edge(clk_tb);
      -- wait until rising_edge(clk_tb);
      -- wait until rising_edge(clk_tb);
      -- check_gpr( instruction    => "addi  x1,  x0,   -2048",
      --            gpr            => spy_gpr(1),
      --            desired_value  => 32x"fffff800",
      --            test_point     => test_point);
      -- check_gpr( instruction    => "addi  x2,  x0,   -511",
      --            gpr            => spy_gpr(2),
      --            desired_value  => 32x"fffffe01",
      --            test_point     => test_point);
      -- check_gpr( instruction    => "addi  x3,  x0,   -2",
      --            gpr            => spy_gpr(3),
      --            desired_value  => 32x"fffffffe",
      --            test_point     => test_point);
      -- check_gpr( instruction    => "addi  x4,  x0,   0",
      --            gpr            => spy_gpr(4),
      --            desired_value  => 32x"00000000",
      --            test_point     => test_point);
      echo("======================================");
      echo("Total errors: " & integer'image(test_point));
      echo("======================================");
      wait for 1 us;
      stop(0);
   end process p_tb;


end architecture tb;
