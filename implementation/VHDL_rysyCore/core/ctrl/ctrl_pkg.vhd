library ieee;
  use ieee.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.math_real.all;
  
 package ctrl_pkg is
    -- constant C_NAME : std_logic_vector(N downto M) := "X";
    
   constant OP		               : std_logic_vector(4 downto 0) := "01100";
   constant STORE	               : std_logic_vector(4 downto 0) := "01000";
   constant JALR	               : std_logic_vector(4 downto 0) := "11001";
   constant	OP_IMM	            : std_logic_vector(4 downto 0) := "00100";
   constant LUI		            : std_logic_vector(4 downto 0) := "01101";
   constant JAL		            : std_logic_vector(4 downto 0) := "11011";
   constant BRANCH	            : std_logic_vector(4 downto 0) := "11000";
   constant LOAD                 : std_logic_vector(4 downto 0) := "00000";
   constant FUNC3_ADD_SUB	      : std_logic_vector(2 downto 0) := "000";
   constant FUNC3_SLT		      : std_logic_vector(2 downto 0) := "010";
   constant FUNC3_XOR		      : std_logic_vector(2 downto 0) := "100";
   constant FUNC3_SLL		      : std_logic_vector(2 downto 0) := "001";
   constant FUNC3_SR		         : std_logic_vector(2 downto 0) := "101";
   constant FUNC3_BRANCH_BEQ	   : std_logic_vector(2 downto 0) := "000";
   constant FUNC3_BRANCH_BGE 	   : std_logic_vector(2 downto 0) := "101";
   constant FUNC3_BRANCH_BLTU	   : std_logic_vector(2 downto 0) := "110";
   constant FUNC3_SH		         : std_logic_vector(2 downto 0) := "001";
   constant FUNC3_SBU		      : std_logic_vector(2 downto 0) := "100";
   constant FUNC3_SHU		      : std_logic_vector(2 downto 0) := "101";
   constant FUNC7_SR_SRL		   : std_logic_vector(6 downto 0) := "0000000";
   constant FUNC7_SR_SRA		   : std_logic_vector(6 downto 0) := "0100000";
   constant FUNC7_ADD_SUB_SUB	   : std_logic_vector(6 downto 0) := "0100000";
   constant FUNC7_ADD_SUB_ADD	   : std_logic_vector(6 downto 0) := "0000000";

 end;
 
 package body ctrl_pkg is
 
 end package body;
