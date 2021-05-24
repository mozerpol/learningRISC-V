`timescale 100ns / 10ns

module R_type(
  input wire [31:0] instruction,
  output wire [6:0]func7,
  output wire [4:0]rs2,
  output wire [4:0]rs1,
  output wire [2:0]func3,
  output wire [4:0]rd,
  output opcode,
  output wire [1:0]low_op
);

  assign func7 = instruction[31:24];
  
endmodule 




/*
zrobic tak, ze mam jeden input i outputy w zaleznosci od tego z czego sklada sie ten typ.
Wewnatrz modulu zrobic tak, ze np. dla R-type bity 0:6 to bedzie opcode i pozniej tego opcode wyrzucic na
output.
Ej kurwa to jest madre. Jak spojrzymy na format instrukcji, to wiekszosc pol dla instrukcji ma dokladnie ta sama pozycje. Czyli musimy znalezc roznice, a bedzie to imm_I, imm_S, imm_B, imm_U, imm_J.
*/
