--------------------------------------------------------------------------------
-- File          : mozerpol_tb.vhd
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Test for the entire processor (mozerpol entity in 
-- mozerpol_design).
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library std;
   use std.env.all;

entity mozerpol_tb is
end mozerpol_tb;

architecture tb of mozerpol_tb is


   component mozerpol is
   port (
      i_rst       : in std_logic;
      i_clk       : in std_logic
   );
   end component mozerpol;

   signal rst_tb  : std_logic;
   signal clk_tb  : std_logic;

   type t_gpr  is array(0 to 31) of std_logic_vector(31 downto 0);


   signal test : std_logic;

begin

   inst_mozerpol : component mozerpol
   port map (
      i_rst       => rst_tb,
      i_clk       => clk_tb
   );

   p_clk : process
   begin
      clk_tb   <= '1';
      wait for 1 ns;
      clk_tb   <= '0';
      wait for 1 ns;
   end process;

   p_tb : process
      -- Read why is worknig iksde
      -- https://stackoverflow.com/questions/48347200/vhdl-2008-cant-drive-a-signal-with-an-alias-of-an-external-name
      alias spy_test is <<signal .mozerpol_tb.inst_mozerpol.inst_core.inst_reg_file.i_reg_file_inst_ctrl: std_logic_vector(1 downto 0) >>;
      alias spy_gpr is <<signal .mozerpol_tb.inst_mozerpol.inst_core.inst_reg_file.gpr: t_gpr >>;
   begin
      rst_tb   <= '1';
      wait for 20 ns;
      rst_tb   <= '0';

      test <= '1'; --spy_test(1);
      wait for 1 ns;
      report "=========REG_FILE_WR_CTRL=========: " & to_string(spy_test); -- std_logic'image(test);

      wait for 2 ns;
      report "===========GPR===========: " & to_string(spy_gpr(1));
      
      if (spy_test(1) = '1') then
         report "OK";
      else
         report "NIE OK";
      end if;

      wait for 2000 ns;
      stop(2);
   end process p_tb;

end architecture tb;
