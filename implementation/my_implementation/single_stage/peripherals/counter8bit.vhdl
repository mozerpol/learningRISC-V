library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;


entity counter8 is
   generic(
      G_COUNTER_VALUE : positive := 256
   ); port(
      i_clk          : in std_logic;
      i_rst          : in std_logic;
      i_addr         : in integer range 0 to C_RAM_LENGTH - 1;
      i_ce           : in std_logic;
      o_q_counter8   : out integer range 0 to G_COUNTER_VALUE - 1
   );
end entity counter8;

architecture rtl of counter8 is

   signal ce_latch : std_logic;

begin

   process (i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst = '1') then
            ce_latch <= '0';
         else
            if (i_addr = C_MMIO_ADDR_CNT_8_BIT - 1) then
               if (i_ce = '1') then
                  ce_latch <= '1';
               else
                  ce_latch <= '0';
               end if;
            end if;
         end if;
      end if;
   end process;

   process (i_clk)
      variable cnt : integer range 0 to G_COUNTER_VALUE - 1;
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst = '1') then
            cnt := 0;
         else
            if (ce_latch = '1') then
               if (cnt = G_COUNTER_VALUE - 1) then
                  cnt := 0;
               else
                  cnt := cnt + 1;
               end if;
            else
               cnt := 0;
            end if;
         end if;
         o_q_counter8 <= cnt;
      end if;
   end process;

end architecture;
