library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity imm_mux_tb is
end imm_mux_tb;

architecture tb of imm_mux_tb is

   component imm_mux is
   port (
      imm_type    : in std_logic_vector(2 downto 0);
      imm_J       : in std_logic_vector(REG_LEN-1 downto 0);
      imm_U       : in std_logic_vector(REG_LEN-1 downto 0);
      imm_B       : in std_logic_vector(REG_LEN-1 downto 0);
      imm_S       : in std_logic_vector(REG_LEN-1 downto 0);
      imm_I       : in std_logic_vector(REG_LEN-1 downto 0);
      imm         : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component imm_mux;

   signal imm_type_tb   : std_logic_vector(2 downto 0);
   signal imm_J_tb      : std_logic_vector(REG_LEN-1 downto 0);
   signal imm_U_tb      : std_logic_vector(REG_LEN-1 downto 0);
   signal imm_B_tb      : std_logic_vector(REG_LEN-1 downto 0);
   signal imm_S_tb      : std_logic_vector(REG_LEN-1 downto 0);
   signal imm_I_tb      : std_logic_vector(REG_LEN-1 downto 0); 
   signal imm_tb        : std_logic_vector(REG_LEN-1 downto 0);
   type t_val_for_imm   is array(0 to 4) of std_logic_vector(31 downto 0);
   signal val_for_imm   : t_val_for_imm;
 
begin

   inst_imm_mux : component imm_mux 
   port map (
      imm_type => imm_type_tb,
      imm_J    => imm_J_tb,
      imm_U    => imm_U_tb,
      imm_B    => imm_B_tb,
      imm_S    => imm_S_tb,
      imm_I    => imm_I_tb,
      imm      => imm_tb
   );

   imm_mux_tb : process
   begin
      imm_type_tb <= "000";
      imm_J_tb    <= 32d"10";
      wait for 10 ns;
      imm_J_tb    <= 32d"3";
      wait for 10 ns;
      imm_J_tb    <= 32d"4";
      wait for 10 ns;
      imm_J_tb    <= 32d"16";
      wait for 10 ns;
      
      imm_type_tb <= "100";
      imm_I_tb    <= 32d"10";
      wait for 10 ns;
      imm_I_tb    <= 32d"3";
      wait for 10 ns;
      imm_I_tb    <= 32d"4";
      wait for 10 ns;
      imm_I_tb    <= 32d"16";
      wait for 10 ns;

      imm_type_tb <= "001";
      imm_U_tb    <= 32d"10";
      wait for 10 ns;
      imm_U_tb    <= 32d"3";
      wait for 10 ns;
      imm_U_tb    <= 32d"4";
      wait for 10 ns;
      imm_U_tb    <= 32d"16";
      wait for 10 ns;

      imm_type_tb <= "010";
      imm_B_tb    <= 32d"10";
      wait for 10 ns;
      imm_B_tb    <= 32d"3";
      wait for 10 ns;
      imm_B_tb    <= 32d"4";
      wait for 10 ns;
      imm_B_tb    <= 32d"16";
      wait for 10 ns;

      imm_type_tb <= "011";
      imm_S_tb    <= 32d"10";
      wait for 10 ns;
      imm_S_tb    <= 32d"3";
      wait for 10 ns;
      imm_S_tb    <= 32d"4";
      wait for 10 ns;
      imm_S_tb    <= 32d"16";

      wait for 25 ns;
      stop(2); 
   end process imm_mux_tb;

end architecture tb;
