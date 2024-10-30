--------------------------------------------------------------------------------
-- File          : ram.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   : Quartus Prime VHDL Template
-- Simple Dual-Port RAM with different read/write addresses and single read/write
-- clock and with a control for writing single bytes into the memory word;
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------

library ieee;
   use ieee.std_logic_1164.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;

entity byte_enabled_simple_dual_port_ram is

   generic (
      ADDR_WIDTH  : natural := C_RAM_LENGTH;
      BYTE_WIDTH  : natural := 8;
      BYTES       : natural := 4
   );
   port (
      i_clk       : in  std_logic;
      i_ram_we    : in  std_logic;
      i_ram_be    : in  std_logic_vector (BYTES - 1 downto 0);
      i_ram_wdata : in  std_logic_vector(BYTES*BYTE_WIDTH-1 downto 0);
      i_ram_waddr : in  integer range 0 to ADDR_WIDTH - 1;
      i_ram_raddr : in  integer range 0 to ADDR_WIDTH - 1;
      o_ram_data  : out std_logic_vector(BYTES*BYTE_WIDTH-1 downto 0)
   );
end byte_enabled_simple_dual_port_ram;

architecture rtl of byte_enabled_simple_dual_port_ram is

   -- declare the RAM
   signal ram     : ram_t;
   signal q_local : word_t;

begin  -- rtl

   -- Re-organize the read data from the RAM to match the output
   unpack: for i in 0 to BYTES - 1 generate
      o_ram_data(BYTE_WIDTH*(i+1) - 1 downto BYTE_WIDTH*i) <= q_local(i);
   end generate unpack;

   -- For pipelined implementation, comment out the following line
   q_local <= ram(i_ram_raddr);

   process(i_clk)
   begin
      if(i_clk'event and i_clk = '1') then
         if(i_ram_we = '1') then
            if(i_ram_be(0) = '1') then
               ram(i_ram_waddr)(0) <= i_ram_wdata(7 downto 0);
            end if;
            if i_ram_be(1) = '1' then
               ram(i_ram_waddr)(1) <= i_ram_wdata(15 downto 8);
            end if;
            if i_ram_be(2) = '1' then
               ram(i_ram_waddr)(2) <= i_ram_wdata(23 downto 16);
            end if;
            if i_ram_be(3) = '1' then
               ram(i_ram_waddr)(3) <= i_ram_wdata(31 downto 24);
            end if;
         end if;
         -- In case of single cycle implementation, comment out line i_ram_below
         -- q_local <= ram(i_ram_raddr);
      end if;
	end process;

end rtl;
