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
      i_clk       : in std_logic;
      i_rst       : in std_logic;
      i_cnt8_addr : in integer range 0 to C_RAM_LENGTH - 1;
      i_cnt8_we   : in std_logic; -- change to i_we
      o_cnt8_q    : out integer range 0 to G_COUNTER_VALUE - 1 -- change to o_cnt8_q
   );
end entity counter8;

architecture rtl of counter8 is
-- TODO: all peripherials should have the same input names, such as ce <- chip
-- enable, not ce and we. Additionaly only gpio_design has _design suffix.
   signal s_ce_latch : std_logic;

begin

   process (i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst = '1') then
            s_ce_latch <= '0';
         else
            if (i_cnt8_addr = C_MMIO_ADDR_CNT_8_BIT - 1) then
               if (i_cnt8_we = '1') then
                  s_ce_latch <= '1';
               else
                  s_ce_latch <= '0';
               end if;
            end if;
         end if;
      end if;
   end process;

   process (i_clk)
      variable v_cnt : integer range 0 to G_COUNTER_VALUE - 1;
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst = '1') then
            v_cnt := 0;
         else
            if (s_ce_latch = '1') then
               if (v_cnt = G_COUNTER_VALUE - 1) then
                  v_cnt := 0;
               else
                  v_cnt := v_cnt + 1;
               end if;
            else
               v_cnt := 0;
            end if;
         end if;
         o_cnt8_q <= v_cnt;
      end if;
   end process;

end architecture;
