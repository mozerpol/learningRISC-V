library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library decoder_lib;
   use decoder_lib.all;
   use decoder_lib.decoder_pkg.all;

entity decoder is
   port (
      i_rst          : in std_logic;
      i_instruction  : in std_logic_vector(31 downto 0);
      o_rd_data      : out std_logic_vector(4 downto 0);
      o_rs1_data     : out std_logic_vector(4 downto 0);
      o_rs2_data     : out std_logic_vector(4 downto 0);
      o_imm          : out std_logic_vector(31 downto 0);
      o_opcode       : out std_logic_vector(4 downto 0);
      o_func3        : out std_logic_vector(2 downto 0);
      o_func7        : out std_logic_vector(6 downto 0)
   );
end entity decoder;

architecture rtl of decoder is

begin

   p_decoder : process(all)
   begin
      if (i_rst) then
      else
         case i_instruction(6 downto 0) is
            -- R type
            when "0110011" =>
            -- I type
            when "0010011" || "0000011" =>
            -- S type
            when "0100011" =>
            -- SB type
            when "1100011" =>
            -- U type
            when "0010111" =>
            -- UJ type
            when "1101111" =>
            when others => NULL;
         end case;
      end if;
   end process p_decoder;

end architecture rtl;
