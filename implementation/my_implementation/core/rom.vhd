library ieee;
    use ieee.std_logic_1164.all;
    use IEEE.std_logic_unsigned.all;
library main_lib;
   use main_lib.main_pkg.all;

package rom is


   type t_rom  is array (0 to C_ROM_LENGTH-1) of std_logic_vector(31 downto 0);

   constant C_CODE : t_rom := (
x"123450b7",
x"67808093",
x"00104863",
x"fff03193",
x"00000217",
x"00c002ef",
x"00000117",
x"fe0008e3",
x"0021c333",
x"0060f3b3",
x"0003a433",
x"0012b4b3",
x"40300533",
x"4013d593",
x"00102223",
x"00101023",
x"0e900fa3",
x"0ea00fa3",
x"00001603",
x"00500683",
x"00000717",
    others => x"00000000"
                              );
end;

package body rom is

end package body;
