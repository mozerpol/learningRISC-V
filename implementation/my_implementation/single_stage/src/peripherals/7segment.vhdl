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
   use ieee.numeric_std.all;
library riscpol_lib;
   use riscpol_lib.all;
   use riscpol_lib.riscpol_pkg.all;


entity seven_segment is
   port (
      i_rst_n           : in std_logic;
      i_clk             : in std_logic;
      i_7segment_wdata  : in std_logic_vector(31 downto 0);
      i_7segment_we     : in std_logic;
      o_7segment_1      : out std_logic_vector(6 downto 0);
      o_7segment_2      : out std_logic_vector(6 downto 0);
      o_7segment_3      : out std_logic_vector(6 downto 0);
      o_7segment_4      : out std_logic_vector(6 downto 0);
      o_7segment_anodes : out std_logic_vector(3 downto 0)
   );
end seven_segment;


architecture rtl of seven_segment is


-- bit position:       7  6 5 4 3 2 1 0
-- display position:  dot g f e d c b a

--    __a__
--   |     |
--  f|     |b
--   |  g  |
--    -----
--   |     |
--  e|     |c        
--   |  d  |         
--    -----                 
 
 
   -- 7-segment encoding for digits 0-9
   function to_7seg(
      digit : std_logic_vector(7 downto 0)
   ) return std_logic_vector is
   begin
      case to_integer(unsigned(digit)) is
         when 0 => return "0111111"; -- 0 turn on: fedcba
         when 1 => return "0000110"; -- 1 turn on: bc
         when 2 => return "1011011"; -- 2 turn on: gedba
         when 3 => return "1001111"; -- 3
         when 4 => return "1100110"; -- 4
         when 5 => return "1101101"; -- 5
         when 6 => return "1111101"; -- 6
         when 7 => return "0000111"; -- 7
         when 8 => return "1111111"; -- 8
         when 9 => return "1101111"; -- 9
         when others => return "0000000";
      end case;
   end function;


   signal s_7segment_1 : std_logic_vector(7 downto 0);
   signal s_7segment_2 : std_logic_vector(7 downto 0);
   signal s_7segment_3 : std_logic_vector(7 downto 0);
   signal s_7segment_4 : std_logic_vector(7 downto 0);


begin


   o_7segment_anodes <= (others => '1'); -- Turn on all 7seg displays

   s_7segment_1 <= i_7segment_wdata(7 downto 0); -- units
   s_7segment_2 <= i_7segment_wdata(15 downto 8); -- tens
   s_7segment_3 <= i_7segment_wdata(23 downto 16); -- hundreds
   s_7segment_4 <= i_7segment_wdata(31 downto 24); -- thousands


   process (i_clk)
   begin
      if (rising_edge(i_clk)) then
         if (i_7segment_we = '1') then
            o_7segment_1 <= to_7seg(s_7segment_1);
            o_7segment_2 <= to_7seg(s_7segment_2);
            o_7segment_3 <= to_7seg(s_7segment_3);
            o_7segment_4 <= to_7seg(s_7segment_4);
         end if;
      end if;
   end process;


end rtl;
