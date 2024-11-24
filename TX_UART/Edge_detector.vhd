----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2024 15:35:08
-- Design Name: 
-- Module Name: Edge_detector - Behavioral
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

entity Edge_detector is 
    Port (
    Btn2 : in std_logic;
    Clk : in std_logic;
    Data_valid : out std_logic
    );
end Edge_detector;

architecture Behavioral of Edge_detector is

signal prev_btn2, prev_btn2_2 : std_logic ;

begin
process(Clk) 
begin
    if rising_edge(Clk) then 
        prev_btn2 <= Btn2 ;
        prev_btn2_2 <= prev_btn2 ;
        
       if (prev_btn2 = '1') and (prev_btn2_2 = '0') then
            data_valid <= '1' ;
       else
            data_valid <= '0' ;
       end if;
   end if;
end process ; 

end Behavioral;
