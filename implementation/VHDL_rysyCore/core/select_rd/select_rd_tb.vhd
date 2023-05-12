library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
   use std.env.all;
library select_rd_lib;
   use select_rd_lib.select_rd_pkg.all;   
  
entity select_rd_tb is
end select_rd_tb;

architecture tb of select_rd_tb is

   component select_rd_design is
      port (
         signal rdata         : in std_logic_vector(REG_LEN-1 downto 0);
         signal sel_type      : in std_logic_vector(2 downto 0);
         signal sel_addr_old  : in std_logic_vector(1 downto 0);
         signal rd_mem        : out std_logic_vector(REG_LEN-1 downto 0)
   );
   end component select_rd_design;

   signal rdata_tb         : std_logic_vector(REG_LEN-1 downto 0);
   signal sel_type_tb      : std_logic_vector(2 downto 0);
   signal sel_addr_old_tb  : std_logic_vector(1 downto 0);
   signal rd_mem_tb        : std_logic_vector(REG_LEN-1 downto 0);
   type t_in_a is array(0 to 14) of std_logic_vector(REG_LEN-1 downto 0);
   signal in_a             : t_in_a;
   type t_sel_type_a is array(0 to 14) of std_logic_vector(2 downto 0);
   signal sel_type_a       : t_sel_type_a;
   type t_sel_addr_a is array(0 to 14) of std_logic_vector(1 downto 0);
   signal sel_addr_a       : t_sel_addr_a;
   type t_out_a is array(0 to 14) of std_logic_vector(REG_LEN-1 downto 0);
   signal out_a            : t_out_a;
   
begin
   inst_select_rd : component select_rd_design 
   port map (
      rdata          => rdata_tb,
      sel_type       => sel_type_tb,
      sel_addr_old   => sel_addr_old_tb,
      rd_mem         => rd_mem_tb
   );

   p_select_rd : process
   begin
    in_a(0) <= 32x"00ff0000";
    in_a(1) <= 32x"00ff0000";
    in_a(2) <= 32x"12345678";
    in_a(3) <= 32x"12345678";
    in_a(4) <= 32x"12345678";
    in_a(5) <= 32x"12345678";
    in_a(6) <= 32x"12345678";
    in_a(7) <= 32x"12345678";
    in_a(8) <= 32x"12345678";
    in_a(9) <= 32x"12345678";
    in_a(10) <= 32x"12345678";
    in_a(11) <= 32x"12345678";
    in_a(12) <= 32x"12345678";
    in_a(13) <= 32x"12345678";
    in_a(14) <= 32x"12345678";

    sel_type_a(0) <= SBU;
    sel_type_a(1) <= SB;
    sel_type_a(2) <= SHU;
    sel_type_a(3) <= SHU;
    sel_type_a(4) <= SBU;
    sel_type_a(5) <= SBU;
    sel_type_a(6) <= SBU;
    sel_type_a(7) <= SBU;
    sel_type_a(8) <= SW;
    sel_type_a(9) <= SH;
    sel_type_a(10) <= SH;
    sel_type_a(11) <= SB;
    sel_type_a(12) <= SB;
    sel_type_a(13) <= SB;
    sel_type_a(14) <= SB;

    sel_addr_a(0) <= 2b"10";
    sel_addr_a(1) <= 2b"10";
    sel_addr_a(2) <= 2b"10";
    sel_addr_a(3) <= 2b"00";
    sel_addr_a(4) <= 2b"11";
    sel_addr_a(5) <= 2b"10";
    sel_addr_a(6) <= 2b"01";
    sel_addr_a(7) <= 2b"00";
    sel_addr_a(8) <= 2b"00";
    sel_addr_a(9) <= 2b"10";
    sel_addr_a(10) <= 2b"00";
    sel_addr_a(11) <= 2b"11";
    sel_addr_a(12) <= 2b"10";
    sel_addr_a(13) <= 2b"01";
    sel_addr_a(14) <= 2b"00";

    out_a(0) <= 32x"000000ff";
    out_a(1) <= 32x"ffffffff";
    out_a(2) <= 32x"00001234";
    out_a(3) <= 32x"00005678";
    out_a(4) <= 32x"00000012";
    out_a(5) <= 32x"00000034";
    out_a(6) <= 32x"00000056";
    out_a(7) <= 32x"00000078";
    out_a(8) <= 32x"12345678";
    out_a(9) <= 32x"00001234";
    out_a(10) <= 32x"00005678";
    out_a(11) <= 32x"00000012";
    out_a(12) <= 32x"00000034";
    out_a(13) <= 32x"00000056";
    out_a(14) <= 32x"00000078";

    wait for 5 ns;
    
    for i in 0 to 14 loop
       rdata_tb         <= in_a(i);
       sel_type_tb      <= sel_type_a(i);
       sel_addr_old_tb  <= sel_addr_a(i);
       wait for 5 ns;
    end loop;
   
    wait for 25 ns;
    stop(2);

   end process p_select_rd;

end architecture tb;
