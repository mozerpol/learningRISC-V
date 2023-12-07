library ieee;
    use ieee.std_logic_1164.all;
    use IEEE.std_logic_unsigned.all;
    use IEEE.math_real.all;
library main_lib;
   use main_lib.main_pkg.all;
   
package rom is


   type t_rom  is array (0 to C_ROM_LENGTH-1) of std_logic_vector(31 downto 0);

   constant C_CODE : t_rom := (
    x"00100093",
    x"00200113",
    x"ffc00193",
    x"67830313",
    x"abcde3b7",
    x"0ff38393",
    x"00600023",
    x"006000a3",
    x"006080a3",
    x"006100a3",
    x"00610123",
    x"007184a3",
    x"fe728d23",
    x"00601423",
    x"00611423",
    x"fe721d23",
    x"00719923",
    others => x"00000000"
                              );
end;

package body rom is

end package body;
