--------------------------------------------------------------------------------
-- File          : programc_counter_design.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Program counter. The ports of this module are connected to
-- instruction memory (instruction_memory_design.vhdl), register file
-- (register_file_design.vhdl) and mux1 (alu_mux_1_design.vhdl). The i_pc_ctrl
-- and i_inst_addr_ctrl signals come from the control (control_design.vhdl)
--  module. These signals control the value of the program counter and which
-- instruction from the ROM (rom.vhdl) to read. Changing the value of the
-- o_instruction_addr signal (which is connected to the instruction_memory
-- module) allows to select the instruction to be read.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;

entity program_counter is
   port (
      i_rst_n              : in std_logic;
      i_clk                : in std_logic;
      i_alu_result         : in std_logic_vector(31 downto 0);
      i_pc_ctrl            : in std_logic_vector(1 downto 0);
      i_inst_addr_ctrl     : in std_logic;
      o_pc_addr            : out std_logic_vector(31 downto 0)
   );
end entity program_counter;

architecture rtl of program_counter is

signal pc_addr_buff : std_logic_vector(31 downto 0);

begin

   o_pc_addr <= pc_addr_buff;

   p_program_counter : process(i_rst_n, i_clk)
   variable flag : std_logic;
   begin
      if (i_rst_n = '0') then
         pc_addr_buff   <= (others => '0');
         flag := '0';
      elsif (i_clk'event and i_clk = '1') then
      if (flag = '0') then
      flag := '1';
      pc_addr_buff <= pc_addr_buff;
      else
         case i_pc_ctrl is
            when C_INCREMENT_PC     => pc_addr_buff <=
                                   std_logic_vector(unsigned(pc_addr_buff) + 4);
            -- The instruction that decrements the PC value does not exist in
            -- RISC-V, so the line below can be commented:
            -- when C_DECREMENT_PC     => pc_addr_buff <= pc_addr_buff - 4;
            when C_LOAD_ALU_RESULT  => pc_addr_buff <= i_alu_result;
            when C_NOP              => pc_addr_buff <= pc_addr_buff;
            when others             => pc_addr_buff <= (others => '0');
         end case;
        end if;
      end if;
   end process p_program_counter;


end architecture rtl;
