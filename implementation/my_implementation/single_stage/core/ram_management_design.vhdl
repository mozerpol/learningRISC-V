--------------------------------------------------------------------------------
-- File          : ram_management_design.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : This module is responsible for writing and reading the
-- appropriate data in RAM (peripherials/ram.vhdl) and writing the read data from
-- RAM to the register file, based on the i_ram_management_ctrl signal from the
-- control module (control_design.vhdl).
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


entity ram_management is
   port (
      i_rst_n                 : in std_logic;
      i_ram_management_ctrl   : in std_logic_vector(3 downto 0);
      i_rs1_data              : in std_logic_vector(31 downto 0);
      i_rs2_data              : in std_logic_vector(31 downto 0);
      i_imm                   : in std_logic_vector(31 downto 0);
      o_write_enable          : out std_logic;
      o_byte_enable           : out std_logic_vector (3 downto 0);
      o_raddr                 : out integer range 0 to C_RAM_LENGTH-1;
      o_waddr                 : out integer range 0 to C_RAM_LENGTH-1;
      o_data                  : out std_logic_vector(31 downto 0)
   );
end entity ram_management;


-- RAM addressing rules:
-- LW / SW - address must be divisible by 4
-- LH / SH - address must be divisible by 2
-- LB / SB

architecture rtl of ram_management is


begin


   p_ram_management : process(i_rst_n, i_rs2_data, i_rs1_data, i_imm, i_ram_management_ctrl)
      variable v_ram_address : std_logic_vector(31 downto 0);
   begin
      if (i_rst_n = '0') then
         o_write_enable    <= C_READ_ENABLE;
         o_byte_enable     <= (others => '0');
         o_raddr           <= 0;
         o_waddr           <= 0;
         o_data            <= (others => '0');
         v_ram_address     := (others => '0');
      else
         v_ram_address     := std_logic_vector(unsigned(i_rs1_data) + unsigned(i_imm));
         o_waddr           <= to_integer(unsigned(v_ram_address(7 downto 2)));
         case i_ram_management_ctrl is
            when C_SW   =>
               o_write_enable <= C_WRITE_ENABLE;
               o_byte_enable  <= "1111";
               o_data         <= i_rs2_data;
            when C_SH   =>
               o_write_enable       <= C_WRITE_ENABLE;
               if (v_ram_address(1 downto 0) = "00") then
                  o_byte_enable        <= "0011";
                  o_data(15 downto 0)  <= i_rs2_data(15 downto 0);
                  o_data(31 downto 16) <= (others => '0');
               elsif (v_ram_address(1 downto 0) = "10") then
                  o_byte_enable        <= "1100";
                  o_data(15 downto 0)  <= (others => '0');
                  o_data(31 downto 16) <= i_rs2_data(15 downto 0);
               else
                  o_byte_enable        <= "0000";
                  o_data               <= (others => '0');
               end if;
            when C_SB   =>
               o_write_enable       <= C_WRITE_ENABLE;
               if (v_ram_address(1 downto 0) = "00") then
                  o_data(7 downto 0)   <= i_rs2_data(7 downto 0);
                  o_data(15 downto 8)  <= (others => '0');
                  o_data(23 downto 16) <= (others => '0');
                  o_data(31 downto 24) <= (others => '0');
                  o_byte_enable        <= "0001";
               elsif (v_ram_address(1 downto 0) = "01") then
                  o_data(7 downto 0)   <= (others => '0');
                  o_data(15 downto 8)  <= i_rs2_data(7 downto 0);
                  o_data(23 downto 16) <= (others => '0');
                  o_data(31 downto 24) <= (others => '0');
                  o_byte_enable        <= "0010";
               elsif (v_ram_address(1 downto 0) = "10") then
                  o_data(7 downto 0)   <= (others => '0');
                  o_data(15 downto 8)  <= (others => '0');
                  o_data(23 downto 16) <= i_rs2_data(7 downto 0);
                  o_data(31 downto 24) <= (others => '0');
                  o_byte_enable        <= "0100";
               elsif (v_ram_address(1 downto 0) = "11") then
                  o_data(7 downto 0)   <= (others => '0');
                  o_data(15 downto 8)  <= (others => '0');
                  o_data(23 downto 16) <=  (others => '0');
                  o_data(31 downto 24) <= i_rs2_data(7 downto 0);
                  o_byte_enable        <= "1000";
               else
                  o_data               <= (others => '0');
                  o_byte_enable        <= "0000";
               end if;
            when C_LB | C_LH | C_LW | C_LBU | C_LHU =>
               o_data         <= (others => '0');
               o_write_enable <= C_READ_ENABLE;
               o_byte_enable  <= (others => '0');
               o_waddr        <= 0;
               o_raddr        <= to_integer(unsigned(v_ram_address(7 downto 2)));
            when others =>
               o_write_enable <= C_READ_ENABLE;
               o_byte_enable  <= "0000";
               o_data         <= (others => '0');
               o_waddr        <= 0;
               o_raddr        <= 0;
         end case;
      end if;
   end process p_ram_management;


end architecture rtl;
