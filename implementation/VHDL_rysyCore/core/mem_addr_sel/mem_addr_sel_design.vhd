library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library rysy_pkg;
   use rysy_pkg.rysyPkg.all;
library mem_addr_sel_lib;
   use mem_addr_sel_lib.all;
   use mem_addr_sel_lib.mem_addr_sel_pkg.all;

entity mem_addr_sel is
   port (
      clk      : in std_logic;
      rst      : in std_logic;
      pc_sel   : in std_logic_vector(1 downto 0);
      mem_sel  : in std_logic;
      alu_out  : in std_logic_vector(REG_LEN-1 downto 0);
      pc       : out std_logic_vector(REG_LEN-1 downto 0);
      addr     : out std_logic_vector(REG_LEN-1 downto 0)
   );
end entity mem_addr_sel;

architecture rtl of mem_addr_sel is

begin
   
   p_pc_sel : process(clk, rst)
   begin
      if (rst = '1') then
         pc    <= (others => '0');
      elsif (clk'event and clk = '1') then
         case (pc_sel) is
            when PC_ALU => pc <= alu_out;
            when PC_P4  => pc <= pc + 4;
            when PC_M4  => pc <= pc - 4;
            when PC_OLD => pc <= pc;
            when others => pc <= pc;
         end case;
      end if;
   end process p_pc_sel;

   p_mem_sel : process (all)
   begin
      case (mem_sel) is
         when MEM_PC    => addr <= pc;
         when MEM_ALU   => addr <= alu_out;
         when others    => addr <= (others => '0');
      end case;
   end process p_mem_sel;

end architecture rtl;
