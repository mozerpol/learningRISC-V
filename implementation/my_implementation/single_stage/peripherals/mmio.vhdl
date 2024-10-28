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
      i_write_enable : in std_logic;
      i_waddr        : in integer range 0 to C_RAM_LENGTH-1;
      i_raddr        : in integer range 0 to C_RAM_LENGTH-1;
      o_we_ram       : out std_logic;
      o_we_gpio      : out std_logic;
      o_we_cnt8bit   : out std_logic;
      o_data         : out std_logic_vector(31 downto 0);
      i_data_gpio    : in std_logic_vector(7 downto 0); -- TODO: Change names, 
      -- shuld be i_cnt8_data, i_ram_data,...
      i_data_counter8 : in integer range 0 to 255;--G_COUNTER_VALUE - 1;
      i_data_ram      : in std_logic_vector(31 downto 0)
      
);
end mmio;

architecture rtl of mmio is

begin
-- TODO: all peripherials should have the same input names, such as ce <- chip
-- enable, not ce and we. Additionaly only gpio_design has _design suffix.


-- TODO: Change all processes, can't work in process, because sensitiviti list,
-- it update only when i_raddr has changed
--   process (i_raddr)
  -- begin
    --  case (i_raddr) is
      --   when C_MMIO_ADDR_GPIO - 1 =>
        --    o_data <= 24x"000000" & i_data_gpio;
         --when C_MMIO_ADDR_CNT_8_BIT - 1 =>
           -- o_data <= std_logic_vector(to_unsigned(i_data_counter8, 32));
         --when others =>
           -- o_data <= i_data_ram;
      --end case;
   --end process;

    -- TODO: check below, it doesn't make any sense that I'm reading state
    -- during i_waddr...
    o_data <= 24x"000000" & i_data_gpio                          when 
                                   i_raddr = C_MMIO_ADDR_GPIO - 1      else
              std_logic_vector(to_unsigned(i_data_counter8, 32)) when 
                                   i_raddr = C_MMIO_ADDR_CNT_8_BIT - 1 else
                                   i_data_ram;
              

   process (i_write_enable, i_waddr)
   begin
      if (i_write_enable = '1') then
         case (i_waddr) is
            when C_MMIO_ADDR_CNT_8_BIT - 1 =>
               o_we_ram       <= '0';
               o_we_gpio      <= '0';
               o_we_cnt8bit   <= '1';
            when C_MMIO_ADDR_GPIO - 1 =>
               o_we_ram       <= '0';
               o_we_gpio      <= '1';
               o_we_cnt8bit   <= '0';
            when others =>
               o_we_ram       <= '1';
               o_we_gpio      <= '0';
               o_we_cnt8bit   <= '0';
         end case;
      else
         o_we_ram       <= '0';
         o_we_gpio      <= '0';
         o_we_cnt8bit   <= '0';
      end if;
   end process;

end rtl;
