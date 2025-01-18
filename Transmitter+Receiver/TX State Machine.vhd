----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.11.2024 11:16:03
-- Design Name: 
-- Module Name: TX State Machine - Behavioral
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

entity TX_State_Machine is
Port (
    Clk : in std_logic;
    Busy : out std_logic;
    Data_valid : in std_logic; 
    Data : in std_logic_vector(7 downto 0);
    TX: out std_logic;
    Baudrate : in std_logic
    );     
end TX_State_Machine;

architecture Behavioral of TX_State_Machine is

type state_t is (idle, dv, start, TX0, TX1, TX2, TX3, TX4, TX5, TX6, TX7, stop);
signal State : state_t; 


begin
process(Clk) is
begin
    if rising_edge(Clk) then
            case State is
                when idle => if Data_valid = '1' then
                    State <= dv ;
                    Busy <= '0'; 
                    end if;
                when dv => if Baudrate = '1' then
                    State <= start ;
                    end if;
                when start => if Baudrate = '1' then
                    TX <= '0' ;
                    State <= TX0 ;
                    end if;
                when TX0 => if Baudrate = '1' then
                    TX <= Data(0) ;
                    State <= TX1 ;
                    end if;
                when TX1 => if Baudrate = '1' then
                    TX <= Data(1) ;
                    State <= TX2 ;
                    end if;
                when TX2 => if Baudrate = '1' then
                    TX <= Data(2) ;
                    State <= TX3 ;
                    end if;
                when TX3 => if Baudrate = '1' then
                    TX <= Data(3) ;
                    State <= TX4 ;
                    end if;
                when TX4 => if Baudrate = '1' then
                    TX <= Data(4) ;
                    State <= TX5 ;
                    end if;
                when TX5 => if Baudrate = '1' then
                    TX <= Data(5) ;
                    State <= TX6 ;
                    end if;
                when TX6 => if Baudrate = '1' then
                    TX <= Data(6) ;
                    State <= TX7 ;
                    end if;
                when TX7 => if Baudrate = '1' then
                    TX <= Data(7) ;
                    State <= stop ;
                    end if;
                when stop => if Baudrate = '1' then
                    TX <= '1' ;
                    State <= idle ;
                    end if;
                when others => State <= idle; 
        end case;
       end if;
       if State = idle then
           Busy <= '0' ;
       else Busy <= '1';
       end if;
 end process ;
 
end Behavioral;
