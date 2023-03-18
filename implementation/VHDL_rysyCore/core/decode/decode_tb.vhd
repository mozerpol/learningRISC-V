library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity decode_tb is
end decode_tb;

architecture tb of decode_tb is

   component decode is
   port (
      signal inst    : in std_logic_vector(31 downto 0);
      signal rd      : out std_logic_vector(4 downto 0);
      signal rs1     : out std_logic_vector(4 downto 0);
      signal rs2     : out std_logic_vector(4 downto 0);
      signal imm_I   : out std_logic_vector(31 downto 0);
      signal imm_S   : out std_logic_vector(31 downto 0);
      signal imm_B   : out std_logic_vector(31 downto 0);
      signal imm_U   : out std_logic_vector(31 downto 0);
      signal imm_J   : out std_logic_vector(31 downto 0);
      signal opcode  : out std_logic_vector(4 downto 0);
      signal func3   : out std_logic_vector(2 downto 0);
      signal func7   : out std_logic_vector(6 downto 0)
   );
   end component decode;

   signal inst_tb    : std_logic_vector(31 downto 0);
   signal rd_tb      : std_logic_vector(4 downto 0);
   signal rs1_tb     : std_logic_vector(4 downto 0);
   signal rs2_tb     : std_logic_vector(4 downto 0);
   signal imm_I_tb   : std_logic_vector(31 downto 0);
   signal imm_S_tb   : std_logic_vector(31 downto 0);
   signal imm_B_tb   : std_logic_vector(31 downto 0);
   signal imm_U_tb   : std_logic_vector(31 downto 0);
   signal imm_J_tb   : std_logic_vector(31 downto 0);
   signal opcode_tb  : std_logic_vector(4 downto 0);
   signal func3_tb   : std_logic_vector(2 downto 0);
   signal func7_tb   : std_logic_vector(6 downto 0); 
 
begin

   inst_decode : component decode 
   port map (
      inst     => inst_tb,
      rd       => rd_tb,
      rs1      => rs1_tb,
      rs2      => rs2_tb,
      imm_I    => imm_I_tb,
      imm_S    => imm_S_tb,
      imm_B    => imm_B_tb,
      imm_U    => imm_U_tb,
      imm_J    => imm_J_tb,
      opcode   => opcode_tb,
      func3    => func3_tb,
      func7    => func7_tb
   );

   decode_tb : process
   begin

      wait for 25 ns;
      stop(2); 
   end process decode_tb;

end architecture tb;
