library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;

entity rd_mux_tb is
end rd_mux_tb;

architecture tb of rd_mux_tb is

   component rd_mux_design is
   port (
      signal imm        : in std_logic_vector(REG_LEN-1 downto 0);
      signal pc         : in std_logic_vector(REG_LEN-1 downto 0);
      signal alu_out    : in std_logic_vector(REG_LEN-1 downto 0);
      signal rd_mem     : in std_logic_vector(REG_LEN-1 downto 0);
      signal clk        : in std_logic;
      signal rd_sel     : in std_logic_vector(1 downto 0);
      signal rd_d       : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component rd_mux_design;

   signal imm_tb        : std_logic_vector(REG_LEN-1 downto 0);
   signal pc_tb         : std_logic_vector(REG_LEN-1 downto 0);
   signal alu_out_tb    : std_logic_vector(REG_LEN-1 downto 0);
   signal rd_mem_tb     : std_logic_vector(REG_LEN-1 downto 0);
   signal clk_tb        : std_logic;
   signal rd_sel_tb     : std_logic_vector(1 downto 0);
   signal rd_d_tb       : std_logic_vector(REG_LEN-1 downto 0);
   type t_machineWord   is array(0 to 4) of std_logic_vector(31 downto 0);
   signal machineWord   : t_machineWord;

begin
   inst_rd_mux : component rd_mux_design 
   port map (
      imm      => imm_tb,
      pc       => pc_tb,
      alu_out  => alu_out_tb,
      rd_mem   => rd_mem_tb,
      clk      => clk_tb,
      rd_sel   => rd_sel_tb,
      rd_d     => rd_d_tb
   );

   p_tb : process
   begin
      machineWord(0) <= 32d"10";
      machineWord(1) <= 32d"3";
      machineWord(2) <= 32d"4";
      machineWord(3) <= 32d"16";
      machineWord(4) <= 32d"5";

      for i in 0 to 4 loop
         rd_sel_tb <= std_logic_vector(to_unsigned(i,2));
         wait for 10 ns;
         for j in 0 to 4 loop
            case (i) is
               when 0 => imm_tb        <= machineWord(j);
               when 1 => pc_tb         <= machineWord(j);
               when 2 => alu_out_tb    <= machineWord(j);
               when 3 => rd_mem_tb     <= machineWord(j);
               when others => NULL;
            end case;
               wait for 10 ns;

         end loop;
      end loop;

      wait for 25 ns;
      stop(2); 
   end process p_tb;

   p_clk : process
   begin
      clk_tb <= '1';
      wait for 1 ns;
      clk_tb <= '0';
      wait for 1 ns;
   end process p_clk;

end architecture tb;
