library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
   use std.env.all;
library select_wr_lib;
   use select_wr_lib.select_wr_pkg.all;   
  
entity select_wr_tb is
end select_wr_tb;

architecture tb of select_wr_tb is

   component select_wr_design is
      port (
         signal rs2_d      : in std_logic_vector(REG_LEN-1 downto 0);
         signal sel_type   : in std_logic_vector(2 downto 0);
         signal sel_addr   : in std_logic_vector(1 downto 0);
         signal be         : out std_logic_vector(3 downto 0);
         signal wdata      : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component select_wr_design;

   signal rs2_d_tb      : std_logic_vector(REG_LEN-1 downto 0);
   signal sel_type_tb   : std_logic_vector(2 downto 0);
   signal sel_addr_tb   : std_logic_vector(1 downto 0);
   signal be_tb         : std_logic_vector(3 downto 0);
   signal wdata_tb      : std_logic_vector(REG_LEN-1 downto 0);
   type t_in_a is array(0 to 6) of std_logic_vector(REG_LEN-1 downto 0);
   signal in_a          : t_in_a;
   type t_sel_type_a is array(0 to 6) of std_logic_vector(2 downto 0);
   signal sel_type_a    : t_sel_type_a;
   type t_sel_addr_a is array(0 to 6) of std_logic_vector(1 downto 0);
   signal sel_addr_a    : t_sel_addr_a;
   type t_out_a is array(0 to 6) of std_logic_vector(REG_LEN-1 downto 0);
   signal out_a         : t_out_a;
   type t_be_a is array(0 to 6) of std_logic_vector(3 downto 0);
   signal be_a          : t_be_a;

begin
   inst_select_wr : component select_wr_design 
   port map (
      rs2_d       => rs2_d_tb,
      sel_type    => sel_type_tb,
      sel_addr    => sel_addr_tb,
      be          => be_tb,
      wdata       => wdata_tb
   );

   p_select_wr : process
   begin

      in_a(0) <= 32x"12345678";
      in_a(1) <= 32x"12345678";
      in_a(2) <= 32x"12345678";
      in_a(3) <= 32x"12345678";
      in_a(4) <= 32x"12345678";
      in_a(5) <= 32x"12345678";
      in_a(6) <= 32x"12345678";

      sel_type_a(0) <= SW;
      sel_type_a(1) <= SH;
      sel_type_a(2) <= SH;
      sel_type_a(3) <= SB;
      sel_type_a(4) <= SB;
      sel_type_a(5) <= SB;
      sel_type_a(6) <= SB;

      sel_addr_a(0) <= 2b"00";
      sel_addr_a(1) <= 2b"10";
      sel_addr_a(2) <= 2b"00";
      sel_addr_a(3) <= 2b"11";
      sel_addr_a(4) <= 2b"10";
      sel_addr_a(5) <= 2b"01";
      sel_addr_a(6) <= 2b"00";

      out_a(0) <= 32x"12345678";
      out_a(1) <= 32x"56780000";
      out_a(2) <= 32x"00005678";
      out_a(3) <= 32x"78000000";
      out_a(4) <= 32x"00780000";
      out_a(5) <= 32x"00007800";
      out_a(6) <= 32x"00000078";

      be_a(0)  <= 4b"1111";
      be_a(1)  <= 4b"1100"; 
      be_a(2)  <= 4b"0011";
      be_a(3)  <= 4b"1000";
      be_a(4)  <= 4b"0100";
      be_a(5)  <= 4b"0010";
      be_a(6)  <= 4b"0001";

      wait for 5 ns;
      
      for i in 0 to 6 loop
         rs2_d_tb    <= in_a(i);
         sel_type_tb <= sel_type_a(i);
         sel_addr_tb <= sel_addr_a(i);
         wait for 5 ns;
      end loop;

      wait for 25 ns;
      stop(2);
   end process p_select_wr;

end architecture tb;
