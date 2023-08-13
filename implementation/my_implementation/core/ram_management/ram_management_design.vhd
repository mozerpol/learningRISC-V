library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library ram_management_lib;
   use ram_management_lib.all;
   use ram_management_lib.ram_management_pkg.all;
library alu_lib;
   use alu_lib.alu_pkg.all;


entity ram_management is
   port (
      i_rst             : in std_logic;
      i_ram_management_ctrl     : in std_logic_vector(2 downto 0);
      i_alu_result      : in std_logic_vector(31 downto 0);
      i_rs1_data        : in std_logic_vector(31 downto 0);
      i_rs2_data        : in std_logic_vector(31 downto 0);
      i_imm             : in std_logic_vector(31 downto 0);
      o_ram_addr        : out std_logic_vector(7 downto 0);
      o_write_enable    : out std_logic;
      o_data            : out std_logic_vector(31 downto 0)
   );
end entity ram_management;

architecture rtl of ram_management is

begin

    --- CALCULATE HERE ADDRESS, SO I NEEED IMM VALUE AND RS1 VALUE AND THX TO
    --- THIS I CAN GET RID i_alu_result

   p_ram_management : process(all)
   begin
      if (i_rst = '1') then
         o_write_enable <= C_READ_ENABLE;
         o_ram_addr     <= (others => '0');
         o_data         <= (others => '0');
      else
         case i_ram_management_ctrl is
            when C_SW   =>
               o_ram_addr           <= i_rs1_data(7 downto 0) + i_imm(7 downto 0);
               o_data               <= i_rs2_data;
               o_write_enable       <= C_WRITE_ENABLE;
            when C_SH   =>
               o_write_enable      <= C_READ_ENABLE;
               o_ram_addr           <= i_alu_result(7 downto 0);
               o_data(15 downto 0)  <= i_rs2_data(15 downto 0);
            when C_SB   =>
               o_write_enable      <= C_READ_ENABLE;
               o_ram_addr           <= i_alu_result(7 downto 0);
               o_data(7 downto 0)   <= i_rs2_data(7 downto 0);
            when C_LW   =>
                o_write_enable      <= C_READ_ENABLE;
                o_ram_addr          <= i_rs1_data(7 downto 0) + i_imm(7 downto 0);
            when others =>
                o_write_enable      <= C_READ_ENABLE;
                o_ram_addr          <= (others => '0');
                o_data              <= (others => '0');
         end case;
      end if;
   end process p_ram_management;

end architecture rtl;
