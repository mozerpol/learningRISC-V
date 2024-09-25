library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.numeric_std_unsigned.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;


entity counter8 is
   generic(
      G_COUNTER_VALUE : positive := 255
   ); port(
      i_clk          : in std_logic;
      i_rst          : in std_logic;
      i_addr         : in integer range 0 to C_RAM_LENGTH-1;
      i_ce           : in std_logic;
      o_q_counter8   : out std_logic_vector(7 downto 0)
);
end entity counter8;

architecture rtl of counter8 is

   signal counter : std_logic_vector(7 downto 0);
   type t_cnt_states is (idle, counting); -- TODO: Add reset state
   signal cnt_states : t_cnt_states;
   
begin

   o_q_counter8 <= counter;

   process (i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst = '1') then
            counter        <= (others => '0');
            cnt_states     <= idle;
         else
            if (i_addr = C_MMIO_ADDR_CNT_8_BIT-1) then
               if (i_ce = '1') then
                  cnt_states <= counting;
               else
                  cnt_states <= idle;
               end if;
            end if;

            case cnt_states is
               when idle =>
                  counter           <= counter;
               when counting =>
                  if (counter = G_COUNTER_VALUE) then
                     counter        <= (others => '0');
                  else
                     counter        <= counter + 1;
                  end if;  
               when others =>
                  counter <= (others => '0');
            end case;
         end if;
      end if;
   end process;

end architecture;
