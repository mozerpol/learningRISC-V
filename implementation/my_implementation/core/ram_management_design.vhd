library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library control_lib;
   use control_lib.all;
   use control_lib.control_pkg.all;
library main_lib;
   use main_lib.all;
   use main_lib.main_pkg.all;

entity ram_management is
   port (
      i_rst                   : in std_logic;
      i_ram_management_ctrl   : in std_logic_vector(3 downto 0);
      i_rs1_data              : in std_logic_vector(31 downto 0);
      i_rs2_data              : in std_logic_vector(31 downto 0);
      i_imm                   : in std_logic_vector(31 downto 0);
      i_load_inst_ctrl        : in std_logic;
      i_data_from_ram         : in std_logic_vector(31 downto 0);
      o_rd_data               : out std_logic_vector(31 downto 0);
      o_write_enable          : out std_logic;
      o_byte_enable           : out std_logic_vector (3 downto 0);
      o_raddr                 : out integer range 0 to C_RAM_LENGTH-1;
      o_waddr                 : out integer range 0 to C_RAM_LENGTH-1;
      o_data                  : out std_logic_vector(31 downto 0)
   );
end entity ram_management;

-- LW / SW - address must be divisible by 4
-- LH / SH - address must be divisible by 2
-- LB / SB

architecture rtl of ram_management is

begin

   p_ram_management : process(all)
      -- 
      variable v_ram_address : std_logic_vector(31 downto 0);
   begin
      if (i_rst = '1') then
         o_write_enable    <= C_READ_ENABLE;
         o_byte_enable     <= (others => '0');
         o_raddr           <= 0;
         o_waddr           <= 0;
         o_data            <= (others => '0');
         v_ram_address     := (others => '0');
      else
         v_ram_address     := (i_rs1_data(31 downto 0) + i_imm(31 downto 0));
         case i_ram_management_ctrl is
            when C_SW   =>
               o_write_enable <= C_WRITE_ENABLE;
               o_byte_enable  <= "1111";
               o_waddr        <= to_integer(unsigned(v_ram_address(31 downto 2)));
               o_data         <= i_rs2_data;
            when C_SH   =>
               o_write_enable <= C_WRITE_ENABLE;
               o_waddr        <= to_integer(unsigned(v_ram_address(31 downto 2)));
               if (v_ram_address(1 downto 0) = "00") then
                  o_byte_enable        <= "0011";
                  o_data(15 downto 0)  <= i_rs2_data(15 downto 0);
               elsif (v_ram_address(1 downto 0) = "10") then
                  o_byte_enable        <= "1100";
                  o_data(31 downto 16) <= i_rs2_data(15 downto 0);
               end if;
            when C_SB   =>
               o_write_enable <= C_WRITE_ENABLE;
               o_waddr        <= to_integer(unsigned(v_ram_address(31 downto 2)));
               if (v_ram_address(1 downto 0) = "00") then
                  o_data(7 downto 0)   <= i_rs2_data(7 downto 0);
                  o_byte_enable        <= "0001";
               elsif (v_ram_address(1 downto 0) = "01") then
                  o_data(15 downto 8)  <= i_rs2_data(7 downto 0);
                  o_byte_enable        <= "0010";
               elsif (v_ram_address(1 downto 0) = "10") then
                  o_data(23 downto 16) <= i_rs2_data(7 downto 0);
                  o_byte_enable        <= "0100";
               elsif (v_ram_address(1 downto 0) = "11") then
                  o_data(31 downto 24) <= i_rs2_data(7 downto 0);
                  o_byte_enable        <= "1000";
               end if;
            when C_LW | C_LH | C_LHU | C_LB | C_LBU  =>
               o_write_enable <= C_READ_ENABLE;
               o_raddr        <= to_integer(unsigned(v_ram_address(31 downto 2)));
            when others =>
               o_write_enable <= C_READ_ENABLE;
               o_byte_enable  <= (others => '0');
               o_raddr        <= 0;
               o_waddr        <= 0;
               o_data         <= (others => '0');
         end case;
      end if;
   end process p_ram_management;

   p_reg_file : process(all)
      variable v_ram_address : std_logic_vector(31 downto 0);
   begin
      if (i_rst = '1') then
         o_rd_data         <= (others => '0');
         v_ram_address     := (others => '0');
      else
         v_ram_address     := i_rs1_data(31 downto 0) + i_imm(31 downto 0);
         case i_ram_management_ctrl is
            when C_LW  =>
               o_rd_data <= i_data_from_ram;
            when C_LH =>
               if (i_data_from_ram(15) = '1') then
                  o_rd_data(31 downto 16) <= 16x"ffff";
               else
                  o_rd_data(31 downto 16) <= 16x"0000";
               end if;
               if (v_ram_address(1 downto 0) = "00") then
                  o_rd_data(15 downto 00) <= i_data_from_ram(15 downto 0);
               elsif (v_ram_address(1 downto 0) = "10") then
                  o_rd_data(15 downto 00) <= i_data_from_ram(31 downto 16);
               end if;
            when C_LHU =>
               o_rd_data(31 downto 16) <= 16x"0000";
               if (v_ram_address(1 downto 0) = "00") then
                  o_rd_data(15 downto 00) <= i_data_from_ram(15 downto 0);
               elsif (v_ram_address(1 downto 0) = "10") then
                  o_rd_data(15 downto 00) <= i_data_from_ram(31 downto 16);
               end if;
            when C_LB =>
               if (i_data_from_ram(7) = '1') then
                  o_rd_data(31 downto 8)  <= 24x"ffffff";
               else
                  o_rd_data(31 downto 8)  <= 24x"000000";
               end if;
               if (v_ram_address(1 downto 0) = "00") then
                  o_rd_data(7 downto 0)   <= i_data_from_ram(7 downto 0);
               elsif (v_ram_address(1 downto 0) = "01") then
                  o_rd_data(7 downto 0)   <= i_data_from_ram(15 downto 8);
               elsif (v_ram_address(1 downto 0) = "10") then
                  o_rd_data(7 downto 0)   <= i_data_from_ram(23 downto 16);
               elsif (v_ram_address(1 downto 0) = "11") then
                  o_rd_data(7 downto 0)   <= i_data_from_ram(31 downto 24);
               end if;
            when C_LBU =>
               o_rd_data(31 downto 8)  <= 24x"000000";
               if (v_ram_address(1 downto 0) = "00") then
                  o_rd_data(7 downto 0)   <= i_data_from_ram(7 downto 0);
               elsif (v_ram_address(1 downto 0) = "01") then
                  o_rd_data(7 downto 0)   <= i_data_from_ram(15 downto 8);
               elsif (v_ram_address(1 downto 0) = "10") then
                  o_rd_data(7 downto 0)   <= i_data_from_ram(23 downto 16);
               elsif (v_ram_address(1 downto 0) = "11") then
                  o_rd_data(7 downto 0)   <= i_data_from_ram(31 downto 24);
               end if;
            when others => o_rd_data <= (others => '0');
         end case;
      end if;
   end process p_reg_file;

end architecture rtl;
