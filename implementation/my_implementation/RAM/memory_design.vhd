library ieee;
   use ieee.std_logic_1164.all;
   use ieee.std_logic_unsigned.all;
   use ieee.numeric_std.all;
library memory_lib;
   use memory_lib.all;
   use memory_lib.memory_pkg.all;

entity memory is
generic (DEPTH      : integer := 64;
         NUM_BYTES  : integer :=  4;
         BYTE_WIDTH : integer :=  8
);
port (
    clk     : in  std_logic;
    raddr   : in  integer range 0 to DEPTH -1 ;     -- address width = 6
    waddr   : in  integer range 0 to DEPTH -1 ;  
    we      : in  std_logic; 
    wdata   : in  std_logic_vector((NUM_BYTES * BYTE_WIDTH -1) downto 0);   -- width = 32
    be      : in  std_logic_vector (NUM_BYTES-1 downto 0);   -- 4 bytes per word
    q       : out std_logic_vector((NUM_BYTES * BYTE_WIDTH -1) downto 0) 
    ); -- width = 32
end memory;

architecture rtl of memory is

    --  build up 2D array to hold the memory
    type word_t is array (0 to NUM_BYTES-1) of std_logic_vector(BYTE_WIDTH-1 downto 0);
    type ram_t is array (0 to DEPTH-1) of word_t;

    signal ram : ram_t;
    signal q_local : word_t;

    begin  -- Re-organize the read data from the RAM to match the output
        unpack: for i in 0 to NUM_BYTES-1 generate    
            q(BYTE_WIDTH*(i+1) - 1 downto BYTE_WIDTH*i) <= q_local(i);
    end generate unpack;
        
    -- port A
    process(clk)
    begin
        if(rising_edge(clk)) then 
            if(we = '1') then
                for I in (NUM_BYTES-1) downto 0 loop
                    if(be(I) = '1') then
                        ram(waddr)(I) <= wdata(((I+1)*BYTE_WIDTH-1) downto I*BYTE_WIDTH);
                    end if;
                 end loop;
            end if;
            -- q_local <= ram(raddr); -- otherwise data will be during rising edge
        end if;
        q_local <= ram(raddr);
    end process;  
end rtl;
