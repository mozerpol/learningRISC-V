library ieee;
   use ieee.std_logic_1164.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;
   
package riscpol_tb_pkg is


   -----------------------------------------------------------------------------
   -- PROCEDURES DEDICATED TO TEST
   -----------------------------------------------------------------------------
   -- The procedure prints out information in simulator without additional text
   -- like time or iteration.
   procedure echo (arg : in string := "");
      
   -----------------------------------------------------
   ---- Check the value of general purpose register ----
   -----------------------------------------------------
   procedure check_gpr( constant instruction    : in string;
                        constant desired_value  : in std_logic_vector(31 downto 0);
                        signal clk              : in std_logic;
                        signal test_point       : out integer);

end riscpol_tb_pkg;


package body riscpol_tb_pkg is


   procedure echo (arg : in string := "") is
   begin
      std.textio.write(std.textio.output, arg & LF);
   end procedure echo;

   procedure check_gpr( constant instruction    : in string;
                        constant desired_value  : in std_logic_vector(31 downto 0);
                        signal clk              : in std_logic;
                        signal test_point       : out integer) is
      alias spy_gpr is <<signal .riscpol_tb.inst_riscpol.inst_core.inst_reg_file.gpr: t_gpr >>;
   begin
      if (spy_gpr(1) /= desired_value) then
         echo("ERROR GPR: " & instruction);
         echo("desired_value: " & to_string(desired_value));
         echo("gpr value: " & to_string(spy_gpr(1)));
         echo("Test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("");
      end if;
      wait until rising_edge(clk);
   end procedure;
   
end riscpol_tb_pkg;
