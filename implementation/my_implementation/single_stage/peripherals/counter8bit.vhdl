library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;

-- TODO: Add one bit signal with data, I want to possibility of reseting counter
entity counter8 is
 port(
      i_clk             : in std_logic;
      i_cnt8_we         : in std_logic;
      i_cnt8_set_reset  : in std_logic;
      o_cnt8_q          : out integer range 0 to C_COUNTER_8BIT_VALUE - 1
   );
end entity counter8; -- TODO: change to counter8bit

architecture rtl of counter8 is

   signal s_ce_latch : std_logic;

begin

   -- TODO: make in one process
   process (i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_cnt8_we = '1' and i_cnt8_set_reset = '1') then
            s_ce_latch <= '1';
         elsif (i_cnt8_we = '1' and i_cnt8_set_reset = '0') then
            s_ce_latch <= '0';
         end if;
      end if;
   end process;

   process (i_clk)
      variable v_cnt : integer range 0 to C_COUNTER_8BIT_VALUE - 1;
   begin
      if (i_clk'event and i_clk = '1') then
         if (s_ce_latch = '1') then
            if (v_cnt = C_COUNTER_8BIT_VALUE - 1) then
               v_cnt := 0;
            else
               v_cnt := v_cnt + 1;
            end if;
         else
            v_cnt := 0;
         end if;
         o_cnt8_q <= v_cnt;
      end if;
   end process;

end architecture;
