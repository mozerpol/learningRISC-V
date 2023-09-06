library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
   use std.env.all;
library memory_lib;
   use memory_lib.all;
   use memory_lib.memory_pkg.all;

entity memory_tb is
end memory_tb;

architecture tb of memory_tb is

   component memory is
    generic (DEPTH      : integer := 64;
             NUM_BYTES  : integer :=  4;
             BYTE_WIDTH : integer :=  8
    );
    port (
    clk     : in  std_logic;
    raddr   : in  integer range 0 to DEPTH -1 ;     -- address width = 6
    waddr   : in  integer range 0 to DEPTH -1 ;  
    we      : in  std_logic; 
    wdata   : in  std_logic_vector((NUM_BYTES * BYTE_WIDTH -1) downto 0);   -- width = 32
    be      : in  std_logic_vector (NUM_BYTES-1 downto 0);   -- 4 bytes per word
    q       : out std_logic_vector((NUM_BYTES * BYTE_WIDTH -1) downto 0) -- width = 32
   );
   end component memory;

   constant DEPTH      : integer := 64;
   constant NUM_BYTES      : integer := 4;
   constant BYTE_WIDTH      : integer := 8;
   signal clk_tb        : std_logic;
   signal raddr_tb      : integer range 0 to DEPTH-1 ;
   signal waddr_tb      : integer range 0 to DEPTH-1 ;  
   signal we_tb         : std_logic;
   signal wdata_tb      : std_logic_vector((NUM_BYTES * BYTE_WIDTH -1) downto 0);   -- width = 32
   signal be_tb         : std_logic_vector (NUM_BYTES-1 downto 0);   -- 4 bytes per word
   signal q_tb          : std_logic_vector((NUM_BYTES * BYTE_WIDTH -1) downto 0); -- width = 32

begin

   inst_memory : component memory
   generic map(
       DEPTH => DEPTH,
       NUM_BYTES => NUM_BYTES,
       BYTE_WIDTH => BYTE_WIDTH
   )
   port map (
      clk   => clk_tb,
      raddr           => raddr_tb,
      waddr       => waddr_tb,
      we               => we_tb,
      wdata        => wdata_tb,
      be           => be_tb,
      q           => q_tb
   );

   p_clk : process
   begin
      clk_tb            <= '1';
      wait for 1 ns;
      clk_tb            <= '0';
      wait for 1 ns;
   end process p_clk;

   p_tb : process
   begin

      raddr_tb <= 0;
      waddr_tb <= 0;
      we_tb <= '0';
      wdata_tb <= (others => '0');
      be_tb <= (others => '0');
      wait for 5 ns;
      ----------------------
      ---- WRITE TO RAM ----
      ----------------------
      ---- SW instruction ----
      -- RAM[0]: 78 56 34 12
      we_tb <= '1';
      waddr_tb <= 0;
      be_tb <= "1111";
      wdata_tb <= 32x"12345678";
      wait for 5 ns;
      ---- SH instruction ----
      -- RAM[1]: 78 56 -- --
      waddr_tb <= 1;
      be_tb <= "0011";
      wdata_tb <= 32x"12345678";
      wait for 5 ns;
      ---- SB instruction ----
      -- RAM[2]: 78 -- -- --
      waddr_tb <= 2;
      be_tb <= "0001";
      wdata_tb <= 32x"12345678";
      wait for 5 ns;
      --- Check saving to different addresses ---
      ---- SW instruction ----
      -- RAM[3]: -- 56 -- --
      waddr_tb <= 3;
      be_tb <= "0010";
      wdata_tb <= 32x"12345678";
      wait for 5 ns;
      ---- SW instruction ----
      -- RAM[4]: -- -- 34 --
      waddr_tb <= 4;
      be_tb <= "0100";
      wdata_tb <= 32x"12345678";
      wait for 5 ns;
      ---- SH instruction ----
      -- RAM[5]: -- 56 34 --
      waddr_tb <= 5;
      be_tb <= "0110";
      wdata_tb <= 32x"12345678";
      wait for 5 ns;
      -----------------------
      ---- READ FROM RAM ----
      -----------------------
      ---- LW instruction ----
      we_tb <= '0';
      raddr_tb <= 0;
      be_tb <= "1111";
      wait for 5 ns;
      ---- LH instruction ----
      raddr_tb <= 1;
      be_tb <= "1100";
      wait for 5 ns;
      ---- LB instruction ----
      raddr_tb <= 2;
      be_tb <= "1000";
      wait for 5 ns;
      ---- LB instruction ----
      raddr_tb <= 3;
      be_tb <= "0100";

      wait for 25 ns;
      stop(2);
   end process p_tb;

end architecture tb;
