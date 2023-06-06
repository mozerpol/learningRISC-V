library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_textio.all;
   use std.textio.all;
library byte_enabled_simple_dual_port_ram_lib;
   use byte_enabled_simple_dual_port_ram_lib.all;
   use byte_enabled_simple_dual_port_ram_lib.byte_enabled_simple_dual_port_ram_pkg.all;


entity byte_enabled_simple_dual_port_ram is
   generic (
      CODE        : string  := "ram_content_hex.txt";
      ADDR_WIDTH  : integer := 8;
      BYTE_WIDTH  : integer := 8;
      BYTES       : integer := 4;
      WIDTH       : integer := 32 -- BYTES*BYTE_WIDTH
   );
   port (
      clk   : in std_logic;
      raddr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
      waddr : in std_logic_vector(ADDR_WIDTH-1 downto 0);
      be    : in std_logic_vector(BYTES-1 downto 0);
      wdata : in std_logic_vector(WIDTH-1 downto 0);
      we    : in std_logic;
      q     : out std_logic_vector(WIDTH-1 downto 0)
   );
end entity byte_enabled_simple_dual_port_ram;

architecture rtl of byte_enabled_simple_dual_port_ram is

   
   type t_ram is array (WORDS-1 downto 0) of 
      std_logic_vector((ADDR_WIDTH*BYTES)-1 downto 0);
   signal ram : t_ram; -- := init_ram_hex;
   
   impure function init_ram_hex return t_ram is
      file text_file       : text open read_mode is CODE;
      variable text_line   : line;
      variable temp_bv     : bit_vector(WIDTH-1 downto 0);
      variable ram_content : t_ram;
   begin
   -------- CHANGE TO TOTAL NUMBER OF LINES IN FOR LOOP !!!!! --------
      for i in 0 to 0 loop
         readline(text_file, text_line);
         hread(text_line, temp_bv);
         ram_content(i) := to_stdlogicvector(temp_bv);
      end loop;
      return ram_content;
   end function;
   

begin

   p_main : process (clk)
    variable v_init_ram : std_logic := '1';
   begin
      if (v_init_ram = '1') then
         v_init_ram  := '0';
         ram         <= init_ram_hex;
      else
         if (clk'event and clk = '1') then
             if (we = '1') then
                 ram(to_integer(unsigned(waddr)))(7 downto 0)    <= 
                                                            wdata(7 downto 0);
                 ram(to_integer(unsigned(waddr)))(15 downto 8)   <= 
                                                            wdata(15 downto 8);
                 ram(to_integer(unsigned(waddr)))(23 downto 16)  <= 
                                                            wdata(23 downto 16);
                 ram(to_integer(unsigned(waddr)))(31 downto 24)  <=
                                                            wdata(31 downto 24);
             end if;
             q <= ram(to_integer(unsigned(raddr)));
         end if;
     end if;
   end process p_main;

end architecture rtl;
