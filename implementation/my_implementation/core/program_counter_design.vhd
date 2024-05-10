--------------------------------------------------------------------------------
-- File          : programc_counter_design.vhd
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Manage program counter. The ports of this module are
-- connected to instruction_memory, register_file and mux1. The i_pc_ctrl and
-- i_inst_addr_ctrl signals come from the control_design module. These signals
-- control the value of the program counter and which instruction from the ROM
-- to read. Changing the value of the o_instruction_addr signal (which is
-- connected to the instruction_memory module) allows to select the instruction
-- to be read.
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;

entity program_counter is
   port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_alu_result         : in std_logic_vector(31 downto 0);
      i_pc_ctrl            : in std_logic_vector(1 downto 0);
      i_inst_addr_ctrl     : in std_logic;
      o_pc_addr            : out std_logic_vector(31 downto 0);
      o_instruction_addr   : out std_logic_vector(31 downto 0)
   );
end entity program_counter;

architecture rtl of program_counter is

signal pc_addr_buff : std_logic_vector(31 downto 0);

begin

   o_pc_addr <= pc_addr_buff;

   p_program_counter : process(i_rst, i_clk)
   begin
      if (i_rst = '1') then
         pc_addr_buff   <= (others => '0');
      elsif (i_clk'event and i_clk = '1') then
         case i_pc_ctrl is
            when C_INCREMENT_PC     => pc_addr_buff <= pc_addr_buff + 4;
            -- The instruction that decrements the PC value does not exist in
            -- RISC-V, so the line below can be commented
            -- when C_DECREMENT_PC     => pc_addr_buff <= pc_addr_buff - 4;
            when C_LOAD_ALU_RESULT  => pc_addr_buff <= i_alu_result;
            when C_NOP              => pc_addr_buff <= pc_addr_buff;
            when others             => pc_addr_buff <= (others => '0');
         end case;
      end if;
   end process p_program_counter;

   p_instruction_address : process(i_rst, i_inst_addr_ctrl, i_alu_result, pc_addr_buff)
   begin
      if (i_rst = '1') then
         o_instruction_addr   <= (others => '0');
      else -- TODO maybe uses if-else
         case i_inst_addr_ctrl is
            when C_INST_ADDR_PC     => o_instruction_addr <= pc_addr_buff + 4;
            when C_INST_ADDR_ALU    => o_instruction_addr <= i_alu_result;
            when others             => o_instruction_addr <= (others => '0');
         end case;
      end if;
   end process p_instruction_address;

end architecture rtl;
