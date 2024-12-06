--------------------------------------------------------------------------------
-- File          : mmio.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   :
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------


library ieee;
   use ieee.std_logic_1164.all;
   use ieee.numeric_std.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;
library counter8bit_lib;
library ram_lib;


entity mmio is
   port (
      i_mmio_write_enable  : in std_logic;
      i_mmio_waddr         : in integer range 0 to C_RAM_LENGTH-1;
      i_mmio_raddr         : in integer range 0 to C_RAM_LENGTH-1;
      i_mmio_q_gpio        : in std_logic_vector(31 downto 0);
      i_mmio_q_cnt8        : in integer range 0 to C_COUNTER_8BIT_VALUE - 1;
      i_mmio_data_ram      : in std_logic_vector(31 downto 0);
      i_mmio_data_uart     : in std_logic_vector(31 downto 0);
      o_mmio_we_ram        : out std_logic;
      o_mmio_we_gpio       : out std_logic;
      o_mmio_re_gpio       : out std_logic;
      o_mmio_we_cnt8bit    : out std_logic;
      o_mmio_we_uart       : out std_logic;
      o_mmio_re_uart       : out std_logic;
      o_mmio_data          : out std_logic_vector(31 downto 0)
);
end mmio;


architecture rtl of mmio is


begin
   
   
   with i_mmio_raddr select o_mmio_data <=
      i_mmio_q_gpio                                    when C_MMIO_ADDR_GPIO - 1,
      std_logic_vector(to_unsigned(i_mmio_q_cnt8, 32)) when C_MMIO_ADDR_CNT_8_BIT - 1,
      i_mmio_data_uart                                 when C_MMIO_ADDR_UART - 1,
      i_mmio_data_ram                                  when others;

   o_mmio_re_gpio <= '1' when i_mmio_raddr = C_MMIO_ADDR_GPIO - 1 else '0';
   o_mmio_re_uart <= '1' when i_mmio_raddr = C_MMIO_ADDR_UART - 1 else '0';
   
   process (i_mmio_write_enable, i_mmio_waddr)
   begin
      if (i_mmio_write_enable = '1') then
         case (i_mmio_waddr) is
            when C_MMIO_ADDR_CNT_8_BIT - 1   =>
               o_mmio_we_ram       <= '0';
               o_mmio_we_gpio      <= '0';
               o_mmio_we_cnt8bit   <= '1';
               o_mmio_we_uart      <= '0';
            when C_MMIO_ADDR_GPIO - 1        =>
               o_mmio_we_ram       <= '0';
               o_mmio_we_gpio      <= '1';
               o_mmio_we_cnt8bit   <= '0';
               o_mmio_we_uart      <= '0';
            when C_MMIO_ADDR_UART - 1        =>
               o_mmio_we_ram       <= '0';
               o_mmio_we_gpio      <= '0';
               o_mmio_we_cnt8bit   <= '0';
               o_mmio_we_uart      <= '1';
            when others                      =>
               o_mmio_we_ram       <= '1';
               o_mmio_we_gpio      <= '0';
               o_mmio_we_cnt8bit   <= '0';
               o_mmio_we_uart      <= '0';
         end case;
      else
         o_mmio_we_ram       <= '0';
         o_mmio_we_gpio      <= '0';
         o_mmio_we_cnt8bit   <= '0';
         o_mmio_we_uart      <= '0';
      end if;
   end process;


end rtl;
