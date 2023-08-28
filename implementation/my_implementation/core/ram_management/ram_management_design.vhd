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
      i_rst                   : in std_logic;
      i_ram_management_ctrl   : in std_logic_vector(2 downto 0);
      i_rs1_data              : in std_logic_vector(31 downto 0);
      i_rs2_data              : in std_logic_vector(31 downto 0);
      i_imm                   : in std_logic_vector(31 downto 0);
      o_ram_addr              : out std_logic_vector(7 downto 0);
      o_write_enable          : out std_logic;
      o_byte_number           : out std_logic_vector(3 downto 0);
      o_data                  : out std_logic_vector(31 downto 0)
   );
end entity ram_management;

-- LW / SW - address must be divisible by 4
-- LH / SH - address must be divisible by 2
-- LB / SB
   
architecture rtl of ram_management is

begin

   p_ram_management : process(all)
      variable v_address_row     : std_logic_vector(7 downto 0);
      variable v_address_column  : std_logic_vector(7 downto 0);
   begin
      if (i_rst = '1') then
         o_write_enable    <= C_READ_ENABLE;
         o_ram_addr        <= (others => '0');
         o_data            <= (others => '0');
         o_byte_number     <= (others => '0');
         v_address_row     := (others => '0');
         v_address_column  := (others => '0');
      else
         v_address_row     := i_rs1_data(7 downto 0) + i_imm(7 downto 0);
         v_address_column  := v_address_row - (v_address_row(7 downto 2) & "00");
         case i_ram_management_ctrl is
            when C_SW   =>
               o_write_enable       <= C_WRITE_ENABLE;
               o_ram_addr           <= v_address_row;
               o_data               <= i_rs2_data;
               o_byte_number        <= "1111";
            when C_SH   =>
               o_write_enable       <= C_WRITE_ENABLE;
               o_ram_addr           <= "00" & v_address_row(7 downto 2);
               if (v_address_column(1 downto 0) = "00") then
                  o_byte_number        <= "0011";
                  o_data               <= i_rs2_data;
               elsif (v_address_column(1 downto 0) = "01") then
                  o_byte_number        <= "0110";
                  o_data(23 downto 8)  <= i_rs2_data(15 downto 0);
               elsif (v_address_column(1 downto 0) = "10") then
                  o_byte_number        <= "1100";
                  o_data(31 downto 16) <= i_rs2_data(15 downto 0);
               end if;
            when C_SB   =>
               o_write_enable       <= C_WRITE_ENABLE;
               o_ram_addr           <= "00" & v_address_row(7 downto 2);
               if (v_address_column(1 downto 0) = "00") then
                  o_byte_number        <= "0001";
                  o_data               <= i_rs2_data;
               elsif (v_address_column(1 downto 0) = "01") then
                  o_byte_number        <= "0010";
                  o_data(15 downto 8)  <= i_rs2_data(7 downto 0);
               elsif (v_address_column(1 downto 0) = "10") then
                  o_byte_number        <= "0100";
                  o_data(23 downto 16) <= i_rs2_data(7 downto 0);
               elsif (v_address_column(1 downto 0) = "11") then
                  o_byte_number        <= "1000";
                  o_data(31 downto 24) <= i_rs2_data(7 downto 0);
               end if;
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
