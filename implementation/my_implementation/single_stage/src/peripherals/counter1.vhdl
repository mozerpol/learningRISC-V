library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;


entity counter1 is
   generic(
      G_COUNTER1_VALUE : positive := C_COUNTER1_VALUE - 1
   ); port(
      i_rst_n           : in std_logic;
      i_clk             : in std_logic;
      i_cnt1_we         : in std_logic;
      i_cnt1_set_reset  : in std_logic;
      o_cnt1_overflow   : out std_logic;
      o_cnt1_q          : out integer range 0 to C_COUNTER1_VALUE - 1
);
end entity counter1;


architecture rtl of counter1 is


   signal s_ce_latch : std_logic;


begin


   process (i_clk)
      variable v_cnt : integer range 0 to G_COUNTER1_VALUE;
   begin
      if (rising_edge(i_clk)) then
         if (i_rst_n = '0') then
            s_ce_latch        <= '0';
            v_cnt             := 0;
            o_cnt1_overflow   <= '0';
         else
            if (i_cnt1_we = '1' and i_cnt1_set_reset = '1') then
               s_ce_latch     <= '1';
            elsif (i_cnt1_we = '1' and i_cnt1_set_reset = '0') then
               s_ce_latch     <= '0';
            end if;

            if (s_ce_latch = '1') then
               if (v_cnt = G_COUNTER1_VALUE) then
                  v_cnt             := 0;
                  o_cnt1_overflow   <= '1';
               else
                  v_cnt             := v_cnt + 1;
                  o_cnt1_overflow   <= '0';
               end if;
            else
               v_cnt                := 0;
               o_cnt1_overflow      <= '0';
            end if;
         end if;
         o_cnt1_q    <= v_cnt;
      end if;
   end process;


end architecture;
