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
   -- 
   procedure check_uart_tx(constant instruction    : in string;
                           constant desired_value  : in std_logic_vector(31 downto 0);
                           signal clk              : in std_logic;
                           signal test_point       : out integer);
                           
                               
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
   
   
   -------------------------------------------
   ----    Simulate sending UART data     ----
   -- TODO: comment, sendint from which perspective
   -------------------------------------------
   procedure check_uart_tx(constant instruction    : in string;
                           constant desired_value  : in std_logic_vector(31 downto 0);
                           signal clk              : in std_logic;
                           signal test_point       : out integer) is
      constant C_WAIT_TIME    : time := 1_000_000_000.0/real(C_BAUD) * ns;
      alias spy_uart_tx is <<signal .riscpol_tb.inst_riscpol.o_uart_tx: std_logic >>;
      alias spy_uart_status is << signal .riscpol_tb.inst_riscpol.inst_uart.o_uart_status : std_logic_vector >>;
   begin
      wait for C_WAIT_TIME/2; -- Thanks to this delay, test will hit about half
      -- of the bit sent by UART
      -- Check start bit
      if (std_logic(spy_uart_tx) /= '0') then
         echo("ERROR UART: " & instruction);
         echo("Start bit does not match to the expected value.");
         echo("Test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("");
      end if;
      wait for C_WAIT_TIME;
      -- Check data bits
      for i in 0 to 7 loop
         if (desired_value(i) /= std_logic(spy_uart_tx)) then
            echo("ERROR UART: " & instruction);
            echo("The bit does not match to the expected value.");
            echo("Test_point: " & integer'image(test_point+1));
            test_point <= test_point + 1;
            echo("");
         end if;
         wait for C_WAIT_TIME;
      end loop;
      -- Check stop bit
      if (std_logic(spy_uart_tx) /= '1') then
         echo("ERROR UART: " & instruction);
         echo("Stop bit does not match to the expected value.");
         echo("Test_point: " & integer'image(test_point+1));
         test_point <= test_point + 1;
         echo("");
      end if;
      -- Wait until the end of UART data sending
      wait until spy_uart_status(0) = '0';
      wait until rising_edge(clk);
      wait until rising_edge(clk);
      wait until rising_edge(clk);
      wait until rising_edge(clk);
   end procedure;
   
   

   
   
end riscpol_tb_pkg;
