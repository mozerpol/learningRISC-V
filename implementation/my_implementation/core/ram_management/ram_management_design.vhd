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
      i_load_inst_ctrl        : in std_logic;
      
      i_data_from_ram         : in std_logic_vector(31 downto 0);
      o_rd_data               : out std_logic_vector(31 downto 0);
      
      o_write_enable     : out  std_logic;                       -- we
      o_byte_enable      : out  std_logic_vector (3 downto 0);   -- be
      o_raddr            : out  integer range 0 to 63;
      o_waddr            : out  integer range 0 to 63;  
      o_data             : out  std_logic_vector(31 downto 0)    -- wdata
    
      -- o_ram_addr              : out std_logic_vector(7 downto 0);
      -- o_write_enable          : out std_logic;
      -- o_byte_number           : out std_logic_vector(3 downto 0);
      -- o_data                  : out std_logic_vector(31 downto 0)
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
         o_byte_enable        <= (others => '0');
         o_raddr            <= 0;
         o_waddr     <= 0;
         o_data     <= (others => '0');
         v_address_row     := (others => '0');
         v_address_column  := (others => '0');
      else
         v_address_row     := i_rs1_data(7 downto 0) + i_imm(7 downto 0);
         v_address_column  := v_address_row - (v_address_row(7 downto 2) & "00");
         case i_ram_management_ctrl is
            when C_SW   =>           
               o_write_enable       <= C_WRITE_ENABLE;
               o_byte_enable        <= "1111";
               o_waddr              <= to_integer(unsigned("00" & v_address_row(7 downto 2)));
               o_data               <= i_rs2_data;
            when C_SH   =>
               o_write_enable       <= C_WRITE_ENABLE;
               o_byte_enable        <= "0011" sll to_integer(unsigned(v_address_column(1 downto 0)));
               o_waddr              <= to_integer(unsigned("00" & v_address_row(7 downto 2)));
               o_data(to_integer(unsigned(v_address_column))*8+15 downto to_integer(unsigned(v_address_column))*8)   <= i_rs2_data(15 downto 0);
            when C_SB   =>
               o_write_enable       <= C_WRITE_ENABLE;
               o_byte_enable        <= "0001" sll to_integer(unsigned(v_address_column(1 downto 0)));
               o_waddr              <= to_integer(unsigned("00" & v_address_row(7 downto 2)));
               o_data(to_integer(unsigned(v_address_column))*8+7 downto to_integer(unsigned(v_address_column))*8)   <= i_rs2_data(7 downto 0);
            when C_LW =>
               if (i_load_inst_ctrl = '1') then
                o_write_enable       <= C_READ_ENABLE;
                o_byte_enable        <= "1111";
                o_raddr              <= to_integer(unsigned("00" & v_address_row(7 downto 2)));
               end if;
            when C_LH | C_LHU =>
               if (i_load_inst_ctrl = '1') then
                  o_write_enable       <= C_READ_ENABLE;
                  o_byte_enable        <= "0011" sll to_integer(unsigned(v_address_column(1 downto 0)));
                  o_raddr              <= to_integer(unsigned("00" & v_address_row(7 downto 2)));
               end if;
            when C_LB | C_LBU =>
               if (i_load_inst_ctrl = '1') then
                  o_write_enable       <= C_READ_ENABLE;
                  o_byte_enable        <= "0001" sll to_integer(unsigned(v_address_column(1 downto 0)));
                  o_raddr              <= to_integer(unsigned("00" & v_address_row(7 downto 2)));
               end if;
            when others =>
             o_write_enable    <= C_READ_ENABLE;
             o_byte_enable        <= (others => '0');
             o_raddr            <= 0;
             o_waddr     <= 0;
             o_data     <= (others => '0');
         end case;
      end if;
   end process p_ram_management;
   
   p_reg_file : process(all)
      variable v_address_row     : std_logic_vector(7 downto 0);
      variable v_address_column  : std_logic_vector(7 downto 0);
      variable v_byte_enable     : std_logic_vector (3 downto 0); 
   begin
      if (i_rst = '1') then
         o_rd_data         <= (others => '0');
         v_address_row     := (others => '0');
         v_address_column  := (others => '0');
         v_byte_enable     := (others => '0');
      else
         v_address_row     := i_rs1_data(7 downto 0) + i_imm(7 downto 0);
         v_address_column  := v_address_row - (v_address_row(7 downto 2) & "00");
         case i_ram_management_ctrl is
            when C_LW  =>
                o_rd_data <= i_data_from_ram;
            when C_LH  =>
             v_byte_enable     := "0011" sll to_integer(unsigned(v_address_column(1 downto 0)));
              if (v_byte_enable = "0011") then -- lh
              o_rd_data(7 downto 0)   <= i_data_from_ram(7 downto 0);
              o_rd_data(15 downto 8)  <= i_data_from_ram(15 downto 8);
              if (i_data_from_ram(15) = '1') then
                   o_rd_data(31 downto 16) <= 16x"ffff";
              else 
                   o_rd_data(31 downto 16) <= 16x"0000";
              end if;
             elsif (v_byte_enable = "0110") then
              o_rd_data(7 downto 0)   <= i_data_from_ram(15 downto 8);
              o_rd_data(15 downto 8)  <= i_data_from_ram(23 downto 16);
              if (i_data_from_ram(15) = '1') then
                   o_rd_data(31 downto 16) <= 16x"ffff";
              else 
                   o_rd_data(31 downto 16) <= 16x"0000";
              end if;
             elsif (v_byte_enable = "1100") then
              o_rd_data(7 downto 0)   <= i_data_from_ram(23 downto 16);
              o_rd_data(15 downto 8)  <= i_data_from_ram(31 downto 24);
              if (i_data_from_ram(15) = '1') then
                   o_rd_data(31 downto 16) <= 16x"ffff";
              else 
                   o_rd_data(31 downto 16) <= 16x"0000";
              end if;
             end if;
            when C_LHU =>
             v_byte_enable     := "0011" sll to_integer(unsigned(v_address_column(1 downto 0)));
              if (v_byte_enable = "0011") then -- lh
              o_rd_data(7 downto 0)   <= i_data_from_ram(7 downto 0);
              o_rd_data(15 downto 8)  <= i_data_from_ram(15 downto 8);
              o_rd_data(31 downto 16) <= 16x"0000";
             elsif (v_byte_enable = "0110") then
              o_rd_data(7 downto 0)   <= i_data_from_ram(15 downto 8);
              o_rd_data(15 downto 8)  <= i_data_from_ram(23 downto 16);
              o_rd_data(31 downto 16) <= 16x"0000";
             elsif (v_byte_enable = "1100") then
              o_rd_data(7 downto 0)   <= i_data_from_ram(23 downto 16);
              o_rd_data(15 downto 8)  <= i_data_from_ram(31 downto 24);
              o_rd_data(31 downto 16) <= 16x"0000";
             end if;
             
            when C_LB  =>
             v_byte_enable     := "0001" sll to_integer(unsigned(v_address_column(1 downto 0)));
             if (v_byte_enable = "0001") then -- lb
              o_rd_data(7 downto 0)   <= i_data_from_ram(7 downto 0);
              if (i_data_from_ram(7) = '1') then
                   o_rd_data(31 downto 8) <= 24x"ffffff";
              else 
                   o_rd_data(31 downto 8) <= 24x"000000";
              end if;
             elsif (v_byte_enable = "0010") then
              o_rd_data(7 downto 0)   <= i_data_from_ram(15 downto 8);
              if (i_data_from_ram(7) = '1') then
                   o_rd_data(31 downto 8) <= 24x"ffffff";
              else 
                   o_rd_data(31 downto 8) <= 24x"000000";
              end if;
             elsif (v_byte_enable = "0100") then
              o_rd_data(7 downto 0)   <= i_data_from_ram(23 downto 16);
              if (i_data_from_ram(7) = '1') then
                   o_rd_data(31 downto 8) <= 24x"ffffff";
              else
                   o_rd_data(31 downto 8) <= 24x"000000";
              end if;
             elsif (v_byte_enable = "1000") then
              o_rd_data(7 downto 0)   <= i_data_from_ram(31 downto 24); 
              if (i_data_from_ram(7) = '1') then
                   o_rd_data(31 downto 8) <= 24x"ffffff";
              else 
                   o_rd_data(31 downto 8) <= 24x"000000";
              end if;
             end if;
            when C_LBU =>
             v_byte_enable     := "0001" sll to_integer(unsigned(v_address_column(1 downto 0)));
             if (v_byte_enable = "0001") then -- lb
              o_rd_data(7 downto 0)   <= i_data_from_ram(7 downto 0);
              o_rd_data(31 downto 8) <= 24x"000000";
             elsif (v_byte_enable = "0010") then
              o_rd_data(7 downto 0)   <= i_data_from_ram(15 downto 8);
              o_rd_data(31 downto 8) <= 24x"000000";
             elsif (v_byte_enable = "0100") then
              o_rd_data(7 downto 0)   <= i_data_from_ram(23 downto 16);
              o_rd_data(31 downto 8) <= 24x"000000";
             elsif (v_byte_enable = "1000") then
              o_rd_data(7 downto 0)   <= i_data_from_ram(31 downto 24); 
              o_rd_data(31 downto 8) <= 24x"000000";
             end if;
            when others => NULL;
         end case;
      end if;
   end process p_reg_file;

end architecture rtl;
