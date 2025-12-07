library ieee;
   use ieee.std_logic_1164.all;
context ieee.ieee_std_context;
   use std.textio.all;
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
      
   function gpr_extraction_from_instruction (instruction : string) return integer;
      
   -----------------------------------------------------
   ---- Check the value of general purpose register ----
   -----------------------------------------------------
   procedure check_gpr( constant instruction    : in string;
                        constant gpr            : in natural range 0 to 31;
                        constant desired_value  : in std_logic_vector(31 downto 0);
                        signal clk              : in std_logic;
                        signal test_point       : out integer);

end riscpol_tb_pkg;


package body riscpol_tb_pkg is


   procedure echo (arg : in string := "") is
   begin
      std.textio.write(std.textio.output, arg & LF);
   end procedure echo;


   function gpr_extraction_from_instruction(instruction : string) return integer is
      variable extracted_gpr : natural range 0 to 31;
   begin
         for i in 1 to instruction'length loop -- TODO: replace for to while
            if (instruction(i) = 'x') then
               if (instruction(i + 2) = ',') then
                  extracted_gpr := integer'value(instruction(i+1 to i+1));
                  report "asdf i+1: " & integer'image(extracted_gpr);
                  return extracted_gpr;
               -- TODO: elsif if (instruction(i + 1) = ',') then
               -- TODO: else return error
               else
                  extracted_gpr := integer'value(instruction(i+1 to i+2));
                  report "asdf x+1 to i+2: " & integer'image(extracted_gpr);
                  return extracted_gpr;
               end if;
            end if;
         end loop;
   end function gpr_extraction_from_instruction;


   procedure check_gpr( constant instruction    : in string;
                        constant gpr            : in natural range 0 to 31;
                        constant desired_value  : in std_logic_vector(31 downto 0);
                        signal clk              : in std_logic;
                        signal test_point       : out integer) is
      alias spy_gpr is <<signal .riscpol_tb.inst_riscpol.inst_core.inst_reg_file.gpr: t_gpr >>;
      variable extracted_gpr : natural range 0 to 31;
   begin
      if (spy_gpr(gpr) /= desired_value) then
         extracted_gpr := gpr_extraction_from_instruction(instruction);
         
         test_point <= test_point + 1;
         echo("ERROR GPR[" & to_string(gpr) & "]: " & instruction);
         echo("desired_value: " & to_hstring(desired_value));
         echo("gpr value: " & to_hstring(spy_gpr(gpr)));
         echo("Test_point: " & integer'image(test_point+1));
         echo("");
         echo("");
      end if;
      wait until rising_edge(clk);
   end procedure;
   
end riscpol_tb_pkg;
