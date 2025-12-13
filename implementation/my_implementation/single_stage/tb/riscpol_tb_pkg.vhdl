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
   
   -- The function extracts the GPR register from the passed instruction.
   function gpr_extraction_from_string(instruction : string) return integer;
      
   -- The function checks the contents of the GPR register from the given 
   -- instruction.
   procedure check_gpr(constant instruction    : in string;
                       constant desired_value  : in std_logic_vector(31 downto 0);
                       signal clk              : in std_logic;
                       signal test_point       : out integer);

   -- 
   procedure check_branch(constant instruction    : in string;
                          constant desired_value  : in std_logic;
                          signal clk              : in std_logic;
                          signal test_point       : out integer);

   --
   procedure check_ram(constant instruction          : in string;
                       constant desired_value        : in std_logic_vector(31 downto 0);
                       constant address              : in natural range 0 to C_RAM_LENGTH;
                       constant column               : in natural range 0 to 3;
                       signal clk                    : in std_logic;
                       signal test_point             : out integer);
                       
   -- 
   procedure check_gpio(constant instruction    : in string;
                        constant desired_value  : in std_logic_vector(C_NUMBER_OF_GPIO-1 downto 0);
                        signal clk              : in std_logic;
                        signal test_point       : out integer);
                    
   --     
   procedure check_cnt(constant instruction    : in string;
                       constant desired_value  : in integer range 0 to C_COUNTER1_VALUE - 1;
                       signal clk              : in std_logic;
                       signal test_point       : out integer);

   -- 
   procedure check_7segment(constant instruction         : in string;
                       constant desired_value_segment_1  : in std_logic_vector(6 downto 0);
                       constant desired_value_segment_2  : in std_logic_vector(6 downto 0);
                       constant desired_value_segment_3  : in std_logic_vector(6 downto 0);
                       constant desired_value_segment_4  : in std_logic_vector(6 downto 0);
                       signal clk                        : in std_logic;
                       signal test_point                 : out integer);
                       
end riscpol_tb_pkg;


package body riscpol_tb_pkg is


   procedure echo (arg : in string := "") is
   begin
      std.textio.write(std.textio.output, arg & LF);
   end procedure echo;


   function gpr_extraction_from_string(instruction : string) return integer is
      variable extracted_gpr : natural range 0 to 31;
   begin
      for i in 1 to instruction'length loop
         if (instruction(i) = 'x') then
            if (instruction(i + 2) = ',') then
               extracted_gpr := integer'value(instruction(i+1 to i+1));
               return extracted_gpr;
            elsif (instruction(i + 3) = ',') then
               extracted_gpr := integer'value(instruction(i+1 to i+2));
               return extracted_gpr;
            else
               report "ERROR in extracting GPR number from instruction" severity error;
            end if;
         end if;
      end loop;
   end function gpr_extraction_from_string;


   procedure check_gpr(constant instruction     : in string;
                       constant desired_value   : in std_logic_vector(31 downto 0);
                       signal clk               : in std_logic;
                       signal test_point        : out integer) is
      alias spy_gpr is <<signal .riscpol_tb.inst_riscpol.inst_core.inst_reg_file.gpr: t_gpr >>;
      variable extracted_gpr : natural range 0 to 31;
   begin
      extracted_gpr := gpr_extraction_from_string(instruction);
      if (spy_gpr(extracted_gpr) /= desired_value) then
         echo("ERROR GPR[" & to_string(extracted_gpr) & "]: " & instruction);
         echo("desired_value: " & to_hstring(desired_value));
         echo("GPR value: " & to_hstring(spy_gpr(extracted_gpr)));
         echo("Test_point: " & integer'image(test_point+1));         
         test_point <= test_point + 1;
         echo("");
      end if;
      wait until rising_edge(clk);
   end procedure;
   
   
   -----------------------------------------------------
   ----   Check the result of branch instruction    ----
   -----------------------------------------------------
   procedure check_branch(constant instruction      : in string;
                          constant desired_value    : in std_logic;
                          signal clk                : in std_logic;
                          signal test_point         : out integer) is
     alias spy_branch_result is <<signal .riscpol_tb.inst_riscpol.inst_core.inst_branch_instructions.o_branch_result: std_logic >>;
   begin
      if (desired_value /= spy_branch_result) then
         echo("ERROR BRANCH instruction: " & instruction);
         echo("desired_value: " & to_string(desired_value));
         echo("Result: " & to_string(spy_branch_result));
         echo("test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("");
      end if;
      wait until rising_edge(clk);
   end procedure;
   
   
   -----------------------------------------------------------------------------
   ---- Check the value of three bytes in RAM - used to verify SW instruction --
   -----------------------------------------------------------------------------
   procedure check_ram(constant instruction          : in string;
                       constant desired_value        : in std_logic_vector(31 downto 0);
                       constant address              : in natural range 0 to C_RAM_LENGTH;
                       constant column               : in natural range 0 to 3;
                       signal clk                    : in std_logic;
                       signal test_point             : out integer ) is
     alias spy_ram is <<signal .riscpol_tb.inst_riscpol.inst_ram.ram: ram_t >>;
   begin    
      if (instruction(1) = 's' and instruction(2) = 'w') then
        if (spy_ram(address)(0) /= desired_value(7 downto 0) or
            spy_ram(address)(1) /= desired_value(15 downto 8) or
            spy_ram(address)(2) /= desired_value(23 downto 16) or
            spy_ram(address)(3) /= desired_value(31 downto 24)) then
                echo("ERROR RAM: " & instruction);
                echo("desired_value: " & to_hstring(desired_value));
                echo("Memory content: " & to_hstring(spy_ram(address)(0) & 
                                                     spy_ram(address)(1) &
                                                     spy_ram(address)(2) &
                                                     spy_ram(address)(3)));
                echo("test_point: " & integer'image(test_point+1));
                test_point <= test_point + 1;
                echo("");
        end if;
      elsif (instruction(1) = 's' and instruction(2) = 'h') then
        if (spy_ram(address)(column) /= desired_value(7 downto 0) or
            spy_ram(address)(column+1) /= desired_value(15 downto 8)) then
                echo("ERROR RAM: " & instruction);
                echo("desired_value: " & to_hstring(desired_value(15 downto 0)));
                echo("Memory content: " & to_hstring(spy_ram(address)(column) &
                                                     spy_ram(address)(column+1)));
                echo("test_point: " & integer'image(test_point+1));
                test_point <= test_point + 1;
                echo("");
        end if;
      elsif (instruction(1) = 's' and instruction(2) = 'b') then
        if (spy_ram(address)(column) /= desired_value(7 downto 0)) then
                echo("ERROR RAM: " & instruction);
                echo("desired_value: " & to_hstring(desired_value(7 downto 0)));
                echo("Memory content: " & to_hstring(spy_ram(address)(column)));
                echo("test_point: " & integer'image(test_point+1));
                test_point <= test_point + 1;
                echo("");
        end if;
      end if;
      wait until rising_edge(clk);
   end procedure;
   
   
   ---------------------------------
   ---- Check the value of GPIO ----
   ---------------------------------
   procedure check_gpio(constant instruction    : in string;
                        constant desired_value  : in std_logic_vector(C_NUMBER_OF_GPIO-1 downto 0);
                        signal clk              : in std_logic;
                        signal test_point       : out integer) is
     alias spy_gpio is <<signal .riscpol_tb.inst_riscpol.io_gpio: std_logic_vector(C_NUMBER_OF_GPIO - 1 downto 0) >>;
   begin
      if (spy_gpio /= desired_value) then
         echo("ERROR GPIO: " & instruction);
         echo("desired_value: " & to_string(desired_value));
         echo("gpio_tb value: " & to_string(spy_gpio));
         echo("Test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("");
      end if;
      wait until rising_edge(clk);
   end procedure;
   
   
   ------------------------------------------
   ---- Check the value of counter1 bit  ----
   ------------------------------------------
   procedure check_cnt(constant instruction    : in string;
                       constant desired_value  : in integer range 0 to C_COUNTER1_VALUE - 1;
                       signal clk              : in std_logic;
                       signal test_point       : out integer) is
      alias spy_cnt1 is <<signal .riscpol_tb.inst_riscpol.inst_counter1.o_cnt1_q: integer range 0 to C_COUNTER1_VALUE - 1>>;
   begin
      if (spy_cnt1 /= desired_value) then
         echo("ERROR COUNTER: " & instruction);
         echo("desired_value:" & integer'image(desired_value));
         echo("Counter value:" & integer'image(spy_cnt1));
         echo("Test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("");
      end if;
      wait until rising_edge(clk);
   end procedure;
   
   
   ---------------------------------
   ---- Check the value of seven segment display ----
   ---------------------------------
   procedure check_7segment(constant instruction         : in string;
                       constant desired_value_segment_1  : in std_logic_vector(6 downto 0);
                       constant desired_value_segment_2  : in std_logic_vector(6 downto 0);
                       constant desired_value_segment_3  : in std_logic_vector(6 downto 0);
                       constant desired_value_segment_4  : in std_logic_vector(6 downto 0);
                       signal clk                        : in std_logic;
                       signal test_point                 : out integer) is
      alias spy_segment_1 is <<signal .riscpol_tb.inst_riscpol.o_7segment_1: std_logic_vector(6 downto 0) >>;
      alias spy_segment_2 is <<signal .riscpol_tb.inst_riscpol.o_7segment_2: std_logic_vector(6 downto 0) >>;
      alias spy_segment_3 is <<signal .riscpol_tb.inst_riscpol.o_7segment_3: std_logic_vector(6 downto 0) >>;
      alias spy_segment_4 is <<signal .riscpol_tb.inst_riscpol.o_7segment_4: std_logic_vector(6 downto 0) >>;
   begin
      if ((spy_segment_1 /= desired_value_segment_1) or
          (spy_segment_2 /= desired_value_segment_2) or
          (spy_segment_3 /= desired_value_segment_3) or
          (spy_segment_4 /= desired_value_segment_4)) then
         echo("ERROR 7-SEGMENT: " & instruction);
         echo("Test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("");
      end if;
      wait until rising_edge(clk);
   end procedure;
   
   
   
   
end riscpol_tb_pkg;
