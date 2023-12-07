library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library opcodes;
   use opcodes.opcodesPkg.all;

entity decoder is
   port (
      i_rst             : in std_logic;
      i_instruction     : in std_logic_vector(31 downto 0);
      o_rd_addr         : out std_logic_vector(4 downto 0);
      o_rs1_addr        : out std_logic_vector(4 downto 0);
      o_rs2_addr        : out std_logic_vector(4 downto 0);
      o_imm             : out std_logic_vector(31 downto 0);
      o_opcode          : out std_logic_vector(6 downto 0);
      o_func3           : out std_logic_vector(2 downto 0);
      o_func7           : out std_logic_vector(6 downto 0)
   );
end entity decoder;

architecture rtl of decoder is

begin

   p_decoder : process(all)
   begin
      if (i_rst) then
         o_rd_addr   <= (others => '0');
         o_rs1_addr  <= (others => '0');
         o_rs2_addr  <= (others => '0');
         o_imm       <= (others => '0');
         o_opcode    <= (others => '0');
         o_func3     <= (others => '0');
         o_func7     <= (others => '0');
      else
         case i_instruction(6 downto 0) is
            -- U-type
            when C_OPCODE_LUI    |
                 C_OPCODE_AUIPC  =>
               o_rd_addr   <= i_instruction(11 downto 7);
               o_rs1_addr  <= (others => '0');
               o_rs2_addr  <= (others => '0');
               o_imm       <= 12x"0" & i_instruction(31 downto 12);
               o_opcode    <= i_instruction(6 downto 0);
               o_func3     <= (others => '0');
               o_func7     <= (others => '0');
            -- J-type
            when C_OPCODE_JAL    =>
               if (i_instruction(31) = '1') then
                  o_imm(31 downto 20) <= (others => '1');
                  o_imm(19 downto 12) <= i_instruction(19 downto 12);
                  o_imm(11)           <= i_instruction(20);
                  o_imm(10 downto 1)  <= i_instruction(30 downto 21);
                  o_imm(0)            <= '0';
               else
                  o_imm(31 downto 20) <= (others => '0');
                  o_imm(19 downto 12) <= i_instruction(19 downto 12);
                  o_imm(11)           <= i_instruction(20);
                  o_imm(10 downto 1)  <= i_instruction(30 downto 21);
                  o_imm(0)            <= '0';
               end if;
               o_rd_addr   <= i_instruction(11 downto 7);
               o_rs1_addr  <= (others => '0');
               o_rs2_addr  <= (others => '0');
               o_opcode    <= i_instruction(6 downto 0);
               o_func3     <= (others => '0');
               o_func7     <= (others => '0');
            -- I-type
            when C_OPCODE_JALR   |
                 C_OPCODE_LOAD   |
                 C_OPCODE_OPIMM  =>
               if (i_instruction(31) = '1') then
                  o_imm(31 downto 11)  <= 21x"1fffff";
                  o_imm(10 downto 0)   <= i_instruction(30 downto 20);
               else
                  o_imm(31 downto 11)  <= (others => '0');
                  o_imm(10 downto 0)   <= i_instruction(30 downto 20);
               end if;
               o_rd_addr   <= i_instruction(11 downto 7);
               o_rs1_addr  <= i_instruction(19 downto 15);
               o_rs2_addr  <= (others => '0');
               o_opcode    <= i_instruction(6 downto 0);
               o_func3     <= i_instruction(14 downto 12);
               o_func7     <= i_instruction(31 downto 25);
            -- B-type
            when C_OPCODE_BRANCH  =>
               if (i_instruction(31) = '1') then
                  o_imm <= X"FFFF" & "1111" & i_instruction(7) & 
                           i_instruction(30 downto 25) & 
                           i_instruction(11 downto 8) & '0';
               else
                  o_imm <= X"0000" & "0000" & i_instruction(7) & 
                           i_instruction(30 downto 25) & 
                           i_instruction(11 downto 8) & '0';
               end if;
               o_rd_addr   <= (others => '0');
               o_rs1_addr  <= i_instruction(19 downto 15);
               o_rs2_addr  <= i_instruction(24 downto 20);
               o_opcode    <= i_instruction(6 downto 0);
               o_func3     <= i_instruction(14 downto 12);
               o_func7     <= (others => '0');
            -- S-type
            when C_OPCODE_STORE  =>
               if (i_instruction(31) = '1') then
                  o_imm(31 downto 11)  <= 21x"1fffff";
                  o_imm(10 downto 0)   <= i_instruction(30 downto 25) &
                                          i_instruction(11 downto 7);
               else
                  o_imm(31 downto 11)  <= (others => '0');
                  o_imm(10 downto 0)   <= i_instruction(30 downto 25) &
                                          i_instruction(11 downto 7);
               end if;
               o_rd_addr   <= (others => '0');
               o_rs1_addr  <= i_instruction(19 downto 15);
               o_rs2_addr  <= i_instruction(24 downto 20);
               o_opcode    <= i_instruction(6 downto 0);
               o_func3     <= i_instruction(14 downto 12);
               o_func7     <= (others => '0');
            -- R-type
            when C_OPCODE_OP  =>
               o_rd_addr   <= i_instruction(11 downto 7);
               o_rs1_addr  <= i_instruction(19 downto 15);
               o_rs2_addr  <= i_instruction(24 downto 20);
               o_imm       <= (others => '0');
               o_opcode    <= i_instruction(6 downto 0);
               o_func3     <= i_instruction(14 downto 12);
               o_func7     <= i_instruction(31 downto 25);
            when others          =>
               o_rd_addr   <= (others => '0');
               o_rs1_addr  <= (others => '0');
               o_rs2_addr  <= (others => '0');
               o_imm       <= (others => '0');
               o_opcode    <= (others => '0');
               o_func3     <= (others => '0');
               o_func7     <= (others => '0');
         end case;
      end if;
   end process p_decoder;

end architecture rtl;
