library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library reg_file_lib;
   use reg_file_lib.all;
   use reg_file_lib.reg_file_pkg.all;

entity reg_file is
   port (
      i_rst                : in std_logic;
      i_clk                : in std_logic;
      i_rs1_addr           : in std_logic_vector(4 downto 0);
      i_rs2_addr           : in std_logic_vector(4 downto 0);
      i_rd_addr            : in std_logic_vector(4 downto 0);
      i_reg_file_inst_ctrl : in std_logic_vector(1 downto 0);
      i_reg_file_wr_ctrl   : in std_logic;
      i_rd_data            : in std_logic_vector(31 downto 0);
      i_alu_result         : in std_logic_vector(31 downto 0);
      i_pc_addr            : in std_logic_vector(31 downto 0);
      i_load_instruction   : in std_logic_vector(2 downto 0);
      o_rs1_data           : out std_logic_vector(31 downto 0);
      o_rs2_data           : out std_logic_vector(31 downto 0)
   );
end entity reg_file;

architecture rtl of reg_file is

   type t_gpr is array(0 to 31) of std_logic_vector(31 downto 0);
   signal gpr : t_gpr; -- general puprose register

begin

   o_rs1_data <= (others => '0') when i_rs1_addr = 5b"00000" else
                 gpr(to_integer(unsigned(i_rs1_addr)));
   o_rs2_data <= (others => '0') when i_rs2_addr = 5b"00000" else
                 gpr(to_integer(unsigned(i_rs2_addr)));

   p_reg_file : process(all)
   begin
      if (i_rst = '1') then
         gpr <= (others => (others => '0'));
      elsif (i_clk'event and i_clk = '1') then
         if (i_reg_file_wr_ctrl = C_WRITE_ENABLE) then
            if (i_reg_file_inst_ctrl = C_WRITE_RD_DATA) then
            
                gpr(to_integer(unsigned(i_rd_addr))) <= i_rd_data;
            
           --    if (i_load_instruction = "000") then    -- LB
             --     if (i_rd_data(7) = '1') then
              --       gpr(to_integer(unsigned(i_rd_addr))) <= 24x"ffffff" & i_rd_data(7 downto 0);
             --     else 
             --        gpr(to_integer(unsigned(i_rd_addr))) <= 24x"000000" & i_rd_data(7 downto 0);
              --    end if;
             --  elsif (i_load_instruction = "001") then -- LH
             --     if (i_rd_data(15) = '1') then
             --        gpr(to_integer(unsigned(i_rd_addr))) <= 16x"ffff" & i_rd_data(15 downto 0);
             --     else 
             --        gpr(to_integer(unsigned(i_rd_addr))) <= 16x"0000" & i_rd_data(15 downto 0);
             --     end if; 
           --    elsif (i_load_instruction = "010") then -- LW
             --     gpr(to_integer(unsigned(i_rd_addr))) <= i_rd_data;                  
            --   elsif (i_load_instruction = "011") then -- LBU
            --      gpr(to_integer(unsigned(i_rd_addr))) <= 24x"000000" & i_rd_data(7 downto 0);
           --    elsif (i_load_instruction = "100") then -- LHU
            --      gpr(to_integer(unsigned(i_rd_addr))) <= 16x"0000" & i_rd_data(15 downto 0);
            --   end if;
            elsif (i_reg_file_inst_ctrl = C_WRITE_ALU_RESULT) then
               gpr(to_integer(unsigned(i_rd_addr))) <= i_alu_result;
            elsif (i_reg_file_inst_ctrl = C_WRITE_PC_ADDR) then
               gpr(to_integer(unsigned(i_rd_addr))) <= i_pc_addr + 4;
            end if;
         end if;
      end if;
   end process p_reg_file;

end architecture rtl;
