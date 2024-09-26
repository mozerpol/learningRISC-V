library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.numeric_std_unsigned.all;

entity counter8 is 
   generic(
      G_COUNTER_VALUE : positive := 255
   ); port(
      i_clk         : in std_logic;
      i_rst         : in std_logic;
      i_ce          : in std_logic;
      i_ov_counter8 : in std_logic;
      i_q_counter8  : out std_logic_vector(7 downto 0)
);
end entity counter8;

architecture rtl of counter8 is
begin

   process (i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         if (i_rst = '1') then
         else
         end if;
      end if;
   end process;

end architecture;
