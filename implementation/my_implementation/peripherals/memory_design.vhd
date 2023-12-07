-- Quartus Prime VHDL Template
-- Simple Dual-Port RAM with different read/write addresses and single read/write clock
-- and with a control for writing single bytes into the memory word; byte enable

library ieee;
use ieee.std_logic_1164.all;
library work;
library main_lib;
   use main_lib.all;
   use main_lib.main_pkg.all;

entity byte_enabled_simple_dual_port_ram is

	generic (
	   ADDR_WIDTH  : natural := C_RAM_LENGTH;
		BYTE_WIDTH  : natural := 8;
	   BYTES       : natural := 4
   );

	port (
		we, clk  : in  std_logic;
		be       : in  std_logic_vector (BYTES - 1 downto 0);
		wdata    : in  std_logic_vector(BYTES*BYTE_WIDTH-1 downto 0);
		waddr    : in  integer range 0 to ADDR_WIDTH - 1;
		raddr    : in  integer range 0 to ADDR_WIDTH - 1;
		q        : out std_logic_vector(BYTES*BYTE_WIDTH-1 downto 0)
   );
end byte_enabled_simple_dual_port_ram;

architecture rtl of byte_enabled_simple_dual_port_ram is
   --  build up 2D array to hold the memory
   type word_t is array (0 to BYTES-1) of std_logic_vector(BYTE_WIDTH-1 downto 0);
	type ram_t is array (0 to ADDR_WIDTH - 1) of word_t;
	-- declare the RAM
	signal ram : ram_t;
	signal q_local : word_t;

begin  -- rtl
	-- Re-organize the read data from the RAM to match the output
	unpack: for i in 0 to BYTES - 1 generate
      q(BYTE_WIDTH*(i+1) - 1 downto BYTE_WIDTH*i) <= q_local(i);
	end generate unpack;

	process(clk)
	begin
	   if(clk'event and clk = '1') then
		   if(we = '1') then
			   -- edit this code if using other than four bytes per word
				if(be(0) = '1') then
				   ram(waddr)(0) <= wdata(7 downto 0);
				end if;
				if be(1) = '1' then
					ram(waddr)(1) <= wdata(15 downto 8);
				end if;
				if be(2) = '1' then
					ram(waddr)(2) <= wdata(23 downto 16);
				end if;
				if be(3) = '1' then
					ram(waddr)(3) <= wdata(31 downto 24);
				end if;
			end if;
			 q_local <= ram(raddr);
		end if;
		-- q_local <= ram(raddr);
	end process;

end rtl;
