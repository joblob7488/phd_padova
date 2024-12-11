library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sample_gen_fsm is
    port ( 
    Clk : in std_logic;
    Rx : in std_logic;
    pulse : in std_logic;
    enable : out std_logic
    );
end sample_gen_fsm;



architecture Behavioral of sample_gen_fsm is

type state_t is (idle, start, lsb, bit1, bit2, bit3, bit4, bit5, bit6, bit7, stop);
signal state : state_t;

begin
process(Clk) is
begin
   if rising_edge(Clk) then
        case state is
            when idle => if Rx = '0' then
                    state <= start;
                    enable <= '1';
                    end if;                
            when start => if pulse = '1' then
                    state <= lsb;
                    end if;                
            when lsb => if pulse = '1' then
                    state <= bit1;
                    end if;                
            when bit1 => if pulse = '1' then
                    state <= bit2;
                    end if;              
            when bit2 =>if pulse = '1' then
                    state <= bit3;
                    end if;                
            when bit3 => if pulse = '1' then
                    state <= bit4;
                    end if;                
            when bit4 => if pulse = '1' then
                    state <= bit5;
                    end if;                
            when bit5 => if pulse = '1' then
                    state <= bit6;
                    end if;                
            when bit6 => if pulse = '1' then
                    state <= bit7;
                    end if;                
            when bit7 => if pulse = '1' then
                    state <= stop;
                    enable <= '0';
                    end if;                
            when stop =>
                    state <= idle;
        end case; 
   end if;
end process;
end Behavioral;
