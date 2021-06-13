module ctrl_tb;
  reg clk_tb = 1'b1;
  reg rst_tb;
  reg opcode_tb;
  reg [2:0] func3_tb;
  reg [6:0] func7_tb;
  reg b_tb;
  wire [2:0] imm_type_tb; // imm_mux.sv
  wire [1:0] inst_sel_tb; // inst_mgmt.sv
  wire reg_wr_tb;
  wire [3:0] alu_op_tb; // alu.sv
  wire [2:0] cmp_op_tb; // cmp.sv
  wire [1:0] pc_sel_tb; // mem_addr_sel.sv
  wire mem_sel_tb; // mem_addr_sel.sv
  wire [1:0] rd_sel_tb; // rd_mux.sv
  wire alu1_sel_tb; // alu1_mux.sv
  wire alu2_sel_tb; // alu2_mux.sv
  wire [2:0] sel_type_tb; // select_pkg.sv
  wire we_tb;

  ctrl dut(
    clk_tb,
    rst_tb,
    opcode_tb,
    func3_tb,
    func7_tb,
    b_tb,
    imm_type_tb,
    inst_sel_tb,
    reg_wr_tb,
    alu_op_tb,
    cmp_op_tb,
    pc_sel_tb,
    mem_sel_tb,
    rd_sel_tb,
    alu1_sel_tb,
    alu2_sel_tb,
    sel_type_tb,
    we_tb
  );

  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    #100 $finish;
  end

  always #5 clk_tb = ~clk_tb;

endmodule
