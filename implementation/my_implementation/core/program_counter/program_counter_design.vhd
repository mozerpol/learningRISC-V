library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library program_counter_lib;
   use program_counter_lib.all;
   use program_counter_lib.program_counter_pkg.all;

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

begin

   p_program_counter : process(i_rst, i_clk)
   begin
      if (i_rst = '1') then
         o_pc_addr   <= (others => '0');
      elsif (i_clk'event and i_clk = '1') then
         case i_pc_ctrl is
            when C_INCREMENT_PC     => o_pc_addr <= o_pc_addr + 4;
            when C_DECREMENT_PC     => o_pc_addr <= o_pc_addr - 4;
            when C_LOAD_ALU_RESULT  => o_pc_addr <= i_alu_result;
            when C_NOP              => o_pc_addr <= o_pc_addr;
            when others             => o_pc_addr <= (others => '0');
         end case;
      end if;
   end process p_program_counter;

   p_instruction_address : process(all)
   begin
      if (i_rst = '1') then
         o_instruction_addr   <= (others => '0');
      else
         case i_inst_addr_ctrl is
            when C_INST_ADDR_PC     => o_instruction_addr <= o_pc_addr + 4;
            when C_INST_ADDR_ALU    => o_instruction_addr <= i_alu_result;
            when others             => o_instruction_addr <= (others => '0');
         end case;
      end if;
   end process p_instruction_address;

end architecture rtl;
