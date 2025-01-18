----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2024 15:05:16
-- Design Name: 
-- Module Name: RX_State_Machine - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RX_State_Machine is
  Port (
        Rx : in std_logic;
        Clk : in std_logic;
        Baudrate_out : in std_logic;
        Data_valid : out std_logic;
        Data : out std_logic_vector(7 downto 0)
   );
end RX_State_Machine;

architecture Behavioral of RX_State_Machine is

type state_t is (idle, start, RX0, RX1, RX2, RX3, RX4, RX5, RX6, RX7, stop, dv);
signal State : state_t; 
begin
process(Clk) is
begin
    Data_valid <= '0' ;
    if rising_edge(Clk) then
        case State is
            when idle => if Baudrate_out = '1' then
                    State <= start ;
                    end if;
            when start => if Baudrate_out = '1' then 
                    State <= RX0 ;
                    end if;
            when RX0 => if Baudrate_out = '1' then 
                    State <= RX1 ;
                    Data(0) <= Rx ;
                    end if; 
            when RX1 => if Baudrate_out = '1' then 
                    State <= RX2 ;
                    Data(1) <= Rx ;
                    end if;
            when RX2 => if Baudrate_out = '1' then 
                    State <= RX3 ;
                    Data(2) <= Rx ;
                    end if;
            when RX3 => if Baudrate_out = '1' then 
                    State <= RX4 ;
                    Data(3) <= Rx ;
                    end if; 
            when RX4 => if Baudrate_out = '1' then 
                    State <= RX5 ;
                    Data(4) <= Rx ;
                    end if;
            when RX5 => if Baudrate_out = '1' then 
                    State <= RX6 ;
                    Data(5) <= Rx ;
                    end if;
            when RX6 => if Baudrate_out = '1' then 
                    State <= RX7 ;
                    Data(6) <= Rx ;
                    end if;
            when RX7 => if Baudrate_out = '1' then 
                    State <= stop ;
                    Data(7) <= Rx ;
                    Data_valid <= '1' ;
                    end if;
            when stop => if Baudrate_out = '1' then
                    State <= dv ;
                    end if; 
            when dv => if Baudrate_out = '1' then
                    State <= idle ; 
                    Data_valid <= '0' ;
                    end if;                          
       end case;
    end if; 
  end process; 
end Behavioral;
