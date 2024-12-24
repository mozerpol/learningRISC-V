--------------------------------------------------------------------------------
-- File          : register_file_design.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Register file which contains 32 general purpose registers
-- (GPR). Depending on the i_reg_file_wr_ctrl (control_design.vhdl) signal, a
-- decision is made whether data can be written to the GPR. Depending on the
-- i_reg_file_inst_ctrl signal (control_design.vhdl), a decision is made from
-- where to save the data (ALU operation result, constant or program counter
-- value). Both signals (i_reg_file_wr_ctrl and i_reg_file_inst_ctrl) come from
-- the control (control_design.vhdl) module.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;


entity reg_file is
   port (
      i_clk                : in std_logic;
      i_rs1_addr           : in std_logic_vector(4 downto 0);
      i_rs2_addr           : in std_logic_vector(4 downto 0);
      i_rd_addr            : in std_logic_vector(4 downto 0);
      i_reg_file_inst_ctrl : in std_logic_vector(1 downto 0);
      i_rd_data            : in std_logic_vector(31 downto 0);
      i_alu_result         : in std_logic_vector(31 downto 0);
      i_pc_addr            : in std_logic_vector(31 downto 0);
      o_rs1_data           : out std_logic_vector(31 downto 0);
      o_rs2_data           : out std_logic_vector(31 downto 0)
   );
end entity reg_file;


architecture rtl of reg_file is


   signal gpr : t_gpr; -- general puprose register


begin


   -- Assigning appropriate data from GPR to the output.
   o_rs1_data <= (others => '0') when i_rs1_addr = "00000" else
                 gpr(to_integer(unsigned(i_rs1_addr)));
   o_rs2_data <= (others => '0') when i_rs2_addr = "00000" else
                 gpr(to_integer(unsigned(i_rs2_addr)));

   p_reg_file : process(i_clk)
   begin
      if (i_clk'event and i_clk = '1') then
         -- Save data from RAM in GPR
         if (i_reg_file_inst_ctrl = C_WRITE_RD_DATA) then
            gpr(to_integer(unsigned(i_rd_addr))) <= i_rd_data;
         -- Save data from ALU in GPR
         elsif (i_reg_file_inst_ctrl = C_WRITE_ALU_RESULT) then
            gpr(to_integer(unsigned(i_rd_addr))) <= i_alu_result;
         else
         -- Save program counter value in GPR
            -- elsif (i_reg_file_inst_ctrl = C_WRITE_PC_ADDR) then
            gpr(to_integer(unsigned(i_rd_addr))) <= 
                                    std_logic_vector(unsigned(i_pc_addr) + 4);
         end if;
      end if;
   end process p_reg_file;


end architecture rtl;
