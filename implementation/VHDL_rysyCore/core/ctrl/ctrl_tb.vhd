library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
   use ieee.std_logic_unsigned.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library std;
  use std.env.all;
library opcodes;
   use opcodes.opcodesPkg.all;


entity ctrl_tb is
end ctrl_tb;

architecture tb of ctrl_tb is

   component ctrl is
   port (
      clk      : in std_logic;
      rst      : in std_logic;
      opcode   : in std_logic_vector(4 downto 0);
      func3    : in std_logic_vector(2 downto 0);
      func7    : in std_logic_vector(6 downto 0);
      b        : in std_logic;
      reg_wr   : out std_logic;
      we       : out std_logic;
      imm_type : out std_logic_vector(2 downto 0);
      alu1_sel : out std_logic;
      alu2_sel : out std_logic;
      rd_sel   : out std_logic_vector(1 downto 0);
      pc_sel   : out std_logic_vector(1 downto 0);
      mem_sel  : out std_logic;
      cmp_op   : out std_logic_vector(2 downto 0);
      sel_type : out std_logic_vector(2 downto 0);
      inst_sel : out std_logic_vector(1 downto 0);
      alu_op   : out std_logic_vector(3 downto 0)
   );
   end component ctrl;

   signal clk_tb         : std_logic;
   signal rst_tb         : std_logic;
   signal opcode_tb      : std_logic_vector(4 downto 0);
   signal func3_tb       : std_logic_vector(2 downto 0);
   signal func7_tb       : std_logic_vector(6 downto 0);
   signal b_tb           : std_logic;
   signal reg_wr_tb      : std_logic;
   signal we_tb          : std_logic;
   signal imm_type_tb    : std_logic_vector(2 downto 0);
   signal alu1_sel_tb    : std_logic;
   signal alu2_sel_tb    : std_logic;
   signal rd_sel_tb      : std_logic_vector(1 downto 0);
   signal pc_sel_tb      : std_logic_vector(1 downto 0);
   signal mem_sel_tb     : std_logic;
   signal cmp_op_tb      : std_logic_vector(2 downto 0);
   signal sel_type_tb    : std_logic_vector(2 downto 0);
   signal inst_sel_tb    : std_logic_vector(1 downto 0);
   signal alu_op_tb      : std_logic_vector(3 downto 0);
 
begin

   inst_ctrl : component ctrl 
   port map (
      clk      => clk_tb,
      rst      => rst_tb,
      opcode   => opcode_tb,
      func3    => func3_tb,
      func7    => func7_tb,
      b        => b_tb,
      reg_wr   => reg_wr_tb,
      we       => we_tb,
      imm_type => imm_type_tb,
      alu1_sel => alu1_sel_tb,
      alu2_sel => alu2_sel_tb,
      rd_sel   => rd_sel_tb,
      pc_sel   => pc_sel_tb,
      mem_sel  => mem_sel_tb,
      cmp_op   => cmp_op_tb,
      sel_type => sel_type_tb,
      inst_sel => inst_sel_tb,
      alu_op   => alu_op_tb
   );

   ctrl_tb : process
   begin

    --'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    --		              Test for imm_mux
    --,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb <= LUI;      -- imm_type should return IMM_U 3'b001
    wait for 5 ns;
    opcode_tb <= OP_IMM; 	-- imm_type should return IMM_I 3'b100
    wait for 5 ns;
    opcode_tb <= STORE; 	-- imm_type should return IMM_S 3'b011
    wait for 5 ns;

    --'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    --                     Test for alu1_nux
    --,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb <= JAL;   -- alu1_sel should return 1
    wait for 5 ns;
    opcode_tb <= LOAD;	-- alu1_sel should return 0
    wait for 5 ns;

    --'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    --		Test for alu2_mux
    --		We have only one case when alu2_sel return 0, it's
    --		for opcode_tb = `OP
    --,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb <= OP;       -- alu2_sel should return 0
    wait for 5 ns;
    opcode_tb <= 5b"10101";	-- default value, alu2_sel should return 1
    wait for 5 ns;
    opcode_tb <= OP_IMM;	-- alu2_sel should return 1
    wait for 5 ns;
    opcode_tb <= OP;	      -- alu2_sel should return 0
    wait for 5 ns;

    --'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    --		Test for rd_mux
    --,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb <= OP_IMM;   -- rd_sel should return 2'b10
    wait for 5 ns;
    opcode_tb <= JAL;		-- rd_sel should return 2'b01
    wait for 5 ns;
    opcode_tb <= LOAD;		-- rd_sel should return 2'b11
    wait for 5 ns;

    --'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    --		Test for reg_wr from reg_file module
    --		Also this module consists "load_phase", which control
    --		order of execution of instructions (by modify value of program
    --		counter and inst_mgm module).
    --,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb <= STORE;    -- reg_wr should return 0
    wait for 5 ns;
    opcode_tb <= OP_IMM;	-- reg_wr should return 1
    wait for 5 ns;
    opcode_tb <= STORE;		-- reg_wr should return 0
    wait for 5 ns;
    opcode_tb <= LOAD;		-- reg_wr should return an
    wait for 5 ns;
    -- unknown logic value (load_phase)
    opcode_tb <= OP_IMM;	-- reg_wr should return 1
    wait for 5 ns;

    --'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    --		Test for mem_addr_sel pc_sel part
    --,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb <= JALR;   -- pc_sel should return 0, JALR opcode = 5'b11001
    wait for 5 ns;
    opcode_tb <= BRANCH; -- BRANCH opcode = 5'b11000
    b_tb	  <=	'0';			 -- pc_sel should return 01
    wait for 5 ns;
    b_tb	  <=	'1';			 -- pc_sel should return 0
    wait for 5 ns;
    opcode_tb <= LOAD;
    wait for 5 ns;

    rst_tb 	  <= '1';   -- load_phase = 0, pc_sel should return 10,
    wait for 10 ns;     -- delay set at 10, because load_phase needs two clock 
                        -- cycles to change their state
    rst_tb 	  <= '0';	-- load_phase = 1, pc_sel should return 01
    wait for 10 ns;

    --'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    --		Test for cmp
    --,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    func3_tb <= FUNC3_BRANCH_BLTU;  -- cmp_op should return 3'b100
    wait for 5 ns;
    func3_tb <= FUNC3_BRANCH_BGE; 	-- cmp_op should return 3'b011
    wait for 5 ns;
    func3_tb <= FUNC3_BRANCH_BEQ; 	-- cmp_op should return 3'b000
    wait for 5 ns;

    --'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    --		Test for mem_addr_sel mem_sel part
    --,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb <= STORE;		-- mem_sel should return 01
    wait for 5 ns;
    rst_tb 	  <= '0';
    opcode_tb <= LOAD;		-- mem_sel should return 0, load_phase = 1
    wait for 10 ns;
    rst_tb 	  <= '1';
    opcode_tb <= LOAD;		-- mem_sel should return 01, load_phase = 0
    wait for 10 ns;
    opcode_tb <= 5b"11011";  -- mem_sel should return default value, it means
    wait for 5 ns;
    -- mem_sel should return 0, load_phase = 0

    --'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    --		Test for eleventh always_comb, which control select_pkg
    --,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    func3_tb <= FUNC3_SHU;    -- sel_type should return 100
    wait for 5 ns;
    func3_tb <= FUNC3_SBU;	   -- sel_type should return 011
    wait for 5 ns;
    func3_tb <= FUNC3_SH;	   -- sel_type should return 01
    wait for 5 ns;

    --'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    --		Test for inst_mgm
    --,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    opcode_tb <= STORE;    -- inst_sel should return 01, next_nop = 1
    wait for 10 ns;
    rst_tb 	  <= '0';
    opcode_tb <= BRANCH;
    b_tb 	  <= '0';			-- inst_sel should return 10, next_nop = 0
    wait for 10 ns;
    opcode_tb <= LOAD;		
    rst_tb 	  <= '0';		-- inst_sel at the beginning should return 
    wait for 50 ns;
    -- 0 and in the next rising clk edge should change their state on 1. The
    -- same situation is with inst_sel. At the beginning it should return 0,
    -- but in the next rising clk edge should return 1. The guity for this 
    -- situation is "load_phase = ~load_phase;" line.
    rst_tb 	  <= '1';      -- inst_sel should return 01, next_nop = 1
    wait for 20 ns;

    --'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    --		Test control ALU
    --  
    --	always_comb hierarchy:
    --	
    --	opcode:
    --		1. OP_IMM or OP
    --			1.1. func3
    --				1.1.1. ADD or SUB - func3 is the same
    --					1.1.1.1. func7 == 0100000 -> SUB
    --					1.1.1.2  else -> ADD
    --				1.1.2. SLT
    --					.
    --					.		Only one difference: func3
    --					.
    --				1.1.6. SLL 
    --				1.1.7. SR func3
    --					1.1.7.1 func7 = 0100000 -> SRL
    --					1.1.7.2 func7 = 0000000 -> SRA
    --		2. opcode = LOAD -> alu_op = ADD
    --		3. opcode = STORE -> alu_op = ADD
    --					.
    --					.
    --					.
    --		5. opcode = JALR -> alu_op = ADD
    --
    --,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,

    -- 1. OP
    opcode_tb <= OP;    -- but can be also OP_IMM
    wait for 5 ns;
    -- 1.1 func3
    -- 1.1.1 func3 for ADD or SUB
    func3_tb <= FUNC3_ADD_SUB;
    -- 1.1.1.1 func7 == 0100000 -> SUB
    func7_tb <= FUNC7_ADD_SUB_SUB;	   -- alu_op should return 1
    wait for 5 ns;
    -- 1.1.1.2 func7 == 0000000 -> ADD
    func7_tb <= FUNC7_ADD_SUB_ADD;	   -- alu_op should return 0
    wait for 5 ns;
    -- 1.1.2. SLT
    func3_tb <= FUNC3_SLT;             -- alu_op should return 1000
    wait for 5 ns;
    -- 1.1.3. XOR
    func3_tb <= FUNC3_XOR;             -- alu_op should return 0010
    wait for 5 ns;
    -- 1.1.4. SLL
    func3_tb <= FUNC3_SLL;             -- alu_op should return 0101
    wait for 5 ns;
    -- 1.1.7. SR
    func3_tb <= FUNC3_SR;
    wait for 5 ns;
    -- 1.1.7.2 func7 = 0000000 -> SRL
    func7_tb <= FUNC7_SR_SRL; 		   -- alu_op should return 0110
    wait for 5 ns;
    -- 1.1.7.1 func7 = 0100000 -> SRA
    func7_tb <= FUNC7_SR_SRA; 		   -- alu_op should return 0111
    wait for 5 ns;
    -- 2. opcode = STORE -> alu_op = ADD (4'b0000)
    opcode_tb <= STORE;	   	         -- alu_op should return 0
    wait for 5 ns;
    -- 3. opcode = JALR -> alu_op = ADD	(4'b0000)
    opcode_tb <= JALR; 	   	         -- alu_op should return 0
   
    wait for 25 ns;
    stop(2); 
   end process ctrl_tb;

   p_clk_tb : process
   begin
      clk_tb <= '1';
      wait for 1 ns;
      clk_tb <= '0';
      wait for 1 ns;
   end process p_clk_tb;

end architecture tb;
