library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
  use std.env.all;
library byte_enabled_simple_dual_port_ram_lib;
   use byte_enabled_simple_dual_port_ram_lib.all;
   use byte_enabled_simple_dual_port_ram_lib.byte_enabled_simple_dual_port_ram_pkg.all;

entity byte_enabled_simple_dual_port_ram_tb is
end byte_enabled_simple_dual_port_ram_tb;

architecture tb of byte_enabled_simple_dual_port_ram_tb is

   component byte_enabled_simple_dual_port_ram is
   generic (
      CODE        : string  := "regop.mem";
      ADDR_WIDTH  : integer := 8;
      BYTE_WIDTH  : integer := 8;
      BYTES       : integer := 4;
      WIDTH       : integer := BYTES*BYTE_WIDTH
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
   end component byte_enabled_simple_dual_port_ram;

   constant CODE        : string := "ram_content_hex.txt";
   constant ADDR_WIDTH  : integer := 8;
   constant BYTE_WIDTH  : integer := 8;
   constant BYTES       : integer := 4;
   constant WIDTH       : integer := BYTES*BYTE_WIDTH;
   signal clk_tb        : std_logic;
   signal raddr_tb      : std_logic_vector(ADDR_WIDTH-1 downto 0);
   signal waddr_tb      : std_logic_vector(ADDR_WIDTH-1 downto 0);
   signal be_tb         : std_logic_vector(BYTES-1 downto 0);
   signal wdata_tb      : std_logic_vector(WIDTH-1 downto 0);
   signal we_tb         : std_logic;
   signal q_tb          : std_logic_vector(WIDTH-1 downto 0);

begin
   inst_byte_enabled_simple_dual_port_ram : component byte_enabled_simple_dual_port_ram 
   generic map(
      CODE        => "ram_content_hex.txt",
      ADDR_WIDTH  => 8,
      BYTE_WIDTH  => 8,
      BYTES       => 4,
      WIDTH       => BYTES*BYTE_WIDTH
   )
   port map (
      clk      => clk_tb,
      raddr    => raddr_tb,
      waddr    => waddr_tb,
      be       => be_tb,
      wdata    => wdata_tb,
      we       => we_tb,
      q        => q_tb
   );

   p_tb : process
   begin

      we_tb <= '0';
      wait for 5 ns;
      
      for i in 0 to 5 loop
         raddr_tb <= std_logic_vector(to_unsigned(i, 8));
         wait for 10 ns;
      end loop;

      we_tb <= '1';
      
      be_tb <= "0001"; -- We'll modify last two octets
      wdata_tb    <= (others => '1');
      wait for 20 ns;

      for i in 0 to 5 loop
         waddr_tb <= std_logic_vector(to_unsigned(i, 8));
         wait for 10 ns;
         raddr_tb <= std_logic_vector(to_unsigned(i, 8));
         wait for 10 ns;
      end loop;

      be_tb <= "0100";
      for i in 0 to 5 loop
         waddr_tb <= std_logic_vector(to_unsigned(i, 8));
         wait for 10 ns;
         raddr_tb <= std_logic_vector(to_unsigned(i, 8));
         wait for 10 ns;
      end loop;

      be_tb <= "0101"; -- We'll modify last two octets
      wdata_tb(7 downto 0)    <= (others => '1');
      wdata_tb(15 downto 8)   <= (others => '0');
      wdata_tb(23 downto 16)  <= (others => '1');
      wdata_tb(31 downto 24)  <= (others => '0');
      wait for 20 ns;

      for i in 0 to 5 loop
         waddr_tb <= std_logic_vector(to_unsigned(i, 8));
         wait for 10 ns;
         raddr_tb <= std_logic_vector(to_unsigned(i, 8));
         wait for 10 ns;
      end loop;
   
      wait for 25 ns;
      stop(2); 
   end process p_tb;

   p_clock_gen : process
   begin
      clk_tb <= '0';
      wait for 5 ns;
      clk_tb <= '1';
      wait for 5 ns;
   end process p_clock_gen;

end architecture tb;
