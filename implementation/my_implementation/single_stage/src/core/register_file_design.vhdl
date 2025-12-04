--------------------------------------------------------------------------------
-- File          : register_file_design.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Register file which contains 32 general purpose registers
-- (GPR). Depending on the i_reg_file_wr_ctrl (control_design.vhdl) signal, a
-- decision is made whether data can be written to the GPR. Depending on the
-- i_data_source_ctrl signal (control_design.vhdl), a decision is made from
-- where to save the data (ALU operation result, constant or program counter
-- value). Both signals (i_reg_file_wr_ctrl and i_data_source_ctrl) come from
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
      i_rst_n              : in std_logic;
      i_clk                : in std_logic;
      i_imm                : in std_logic_vector(31 downto 0);
      i_rs1_data           : in std_logic_vector(31 downto 0);
      i_rs1_addr           : in std_logic_vector(4 downto 0);
      i_rs2_addr           : in std_logic_vector(4 downto 0);
      i_rd_addr            : in std_logic_vector(4 downto 0);
      i_data_source_ctrl   : in std_logic_vector(1 downto 0);
      i_reg_file_inst_ctrl : in std_logic_vector(3 downto 0);
      i_alu_result         : in std_logic_vector(31 downto 0);
      i_pc_addr            : in std_logic_vector(31 downto 0);
      i_data_from_mmio     : in std_logic_vector(31 downto 0);
      o_rs1_data           : out std_logic_vector(31 downto 0);
      o_rs2_data           : out std_logic_vector(31 downto 0)
   );
end entity reg_file;


architecture rtl of reg_file is


   signal gpr : t_gpr; -- General Puprose Register
   signal s_data : std_logic_vector(31 downto 0);


begin


   -- Based on the instruction, modify the value that will be written to the
   -- register file.
   p_reg_file_management : process(i_rst_n, i_reg_file_inst_ctrl, i_data_from_mmio, i_imm, i_rs1_data)
      variable v_reg_file_address : std_logic_vector(1 downto 0);
   begin
      if (i_rst_n = '0') then
         s_data             <= (others => '0');
         v_reg_file_address := "00";
      else
         v_reg_file_address := std_logic_vector(unsigned(i_rs1_data(1 downto 0)) 
                                                 + unsigned(i_imm(1 downto 0)));
         case i_reg_file_inst_ctrl is
            when C_LW  =>
               s_data <= i_data_from_mmio;
            when C_LH  =>
               if (v_reg_file_address(1 downto 0) = "00") then
                  if (i_data_from_mmio(15) = '1') then
                     s_data(31 downto 16)  <= (others => '1');
                  else
                     s_data(31 downto 16)  <= (others => '0');
                  end if;
                  s_data(15 downto 0)  <= i_data_from_mmio(15 downto 0);
               elsif (v_reg_file_address(1 downto 0) = "10") then
                  if (i_data_from_mmio(31) = '1') then
                     s_data(31 downto 16)  <= (others => '1');
                  else
                     s_data(31 downto 16)  <= (others => '0');
                  end if;
                  s_data(15 downto 0)  <= i_data_from_mmio(31 downto 16);
               else
                  s_data               <= (others => '0');
               end if;
            when C_LHU =>
               s_data(31 downto 16) <= (others => '0');
               if (v_reg_file_address(1 downto 0) = "00") then
                  s_data(15 downto 0)  <= i_data_from_mmio(15 downto 0);
               elsif (v_reg_file_address(1 downto 0) = "10") then
                  s_data(15 downto 0)  <= i_data_from_mmio(31 downto 16);
               else
                  s_data(15 downto 0)  <= (others => '0');
               end if;
            when C_LB  =>
               if (v_reg_file_address(1 downto 0) = "00") then
                  if (i_data_from_mmio(7) = '1') then
                     s_data(31 downto 8)  <= (others => '1');
                  else
                     s_data(31 downto 8)  <= (others => '0');
                  end if;
                  s_data(7 downto 0)   <= i_data_from_mmio(7 downto 0);
               elsif (v_reg_file_address(1 downto 0) = "01") then
                  if (i_data_from_mmio(15) = '1') then
                     s_data(31 downto 8)  <= (others => '1');
                  else
                     s_data(31 downto 8)  <= (others => '0');
                  end if;
                  s_data(7 downto 0)   <= i_data_from_mmio(15 downto 8);
               elsif (v_reg_file_address(1 downto 0) = "10") then
                  if (i_data_from_mmio(23) = '1') then
                     s_data(31 downto 8)  <= (others => '1');
                  else
                     s_data(31 downto 8)  <= (others => '0');
                  end if;
                  s_data(7 downto 0)   <= i_data_from_mmio(23 downto 16);
               elsif (v_reg_file_address(1 downto 0) = "11") then
                  if (i_data_from_mmio(31) = '1') then
                     s_data(31 downto 8)  <= (others => '1');
                  else
                     s_data(31 downto 8)  <= (others => '0');
                  end if;
                  s_data(7 downto 0)   <= i_data_from_mmio(31 downto 24);
               else
                  s_data               <= (others => '0');
               end if;
            when C_LBU =>
               s_data(31 downto 8)  <= (others => '0');
               if (v_reg_file_address(1 downto 0) = "00") then
                  s_data(7 downto 0)   <= i_data_from_mmio(7 downto 0);
               elsif (v_reg_file_address(1 downto 0) = "01") then
                  s_data(7 downto 0)   <= i_data_from_mmio(15 downto 8);
               elsif (v_reg_file_address(1 downto 0) = "10") then
                  s_data(7 downto 0)   <= i_data_from_mmio(23 downto 16);
               elsif (v_reg_file_address(1 downto 0) = "11") then
                  s_data(7 downto 0)   <= i_data_from_mmio(31 downto 24);
               else
                  s_data(7 downto 0)   <= (others => '0');
               end if;
            when others => s_data   <= (others => '0');
         end case;
      end if;
   end process p_reg_file_management;
   

   -- Assigning appropriate data from GPR to the output.
   o_rs1_data <= (others => '0') when i_rs1_addr = "00000" else
                 gpr(to_integer(unsigned(i_rs1_addr)));
   o_rs2_data <= (others => '0') when i_rs2_addr = "00000" else
                 gpr(to_integer(unsigned(i_rs2_addr)));


   p_reg_file : process(i_clk)
   begin
      if (rising_edge(i_clk)) then
         -- Save data from RAM in GPR
         if (i_data_source_ctrl = C_WRITE_RD_DATA) then
            gpr(to_integer(unsigned(i_rd_addr))) <= s_data;
         -- Save data from ALU in GPR
         elsif (i_data_source_ctrl = C_WRITE_ALU_RESULT) then
            gpr(to_integer(unsigned(i_rd_addr))) <= i_alu_result;
         else
            -- Save program counter value in GPR
            -- elsif (i_data_source_ctrl = C_WRITE_PC_ADDR) then
            gpr(to_integer(unsigned(i_rd_addr))) <= 
                                    std_logic_vector(unsigned(i_pc_addr) + 4);
         end if;
      end if;
   end process p_reg_file;


end architecture rtl;
