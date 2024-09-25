library ieee;
   use ieee.std_logic_1164.all;

entity timer8 is port(
   clk : in std_logic
                     );
end entity timer8;

architecture rtl of timer8 is
begin

   process (clk)
   begin
      if (clk'event and clk = '1') then
      end if;
   end process;

end architecture;
