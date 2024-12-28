--------------------------------------------------------------------------------
-- File          : 7segment.vhdl
-- Author        : mozerpol
--------------------------------------------------------------------------------
-- Description   :
--------------------------------------------------------------------------------
-- License       : MIT 2022 mozerpol
--------------------------------------------------------------------------------


library ieee;
   use ieee.std_logic_1164.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;


entity 7segment is
   port (
      i_rst_n           : in std_logic;
      i_7segment_wdata  : in std_logic_vector(31 downto 0);
      i_7segment_we     : in std_logic
      o_7segment_1      : out std_logic_vector(7 downto 0);
      o_7segment_2      : out std_logic_vector(7 downto 0);
      o_7segment_3      : out std_logic_vector(7 downto 0);
      o_7segment_4      : out std_logic_vector(7 downto 0)
   );
end 7segment;


architecture rtl of 7segment is


begin


end rtl;
