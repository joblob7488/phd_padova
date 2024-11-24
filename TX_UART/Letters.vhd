----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2024 17:11:31
-- Design Name: 
-- Module Name: Letters - Behavioral
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

entity Letters is
    Port (
    btn1 : in std_logic;
    letter : out std_logic_vector(7 downto 0)
     );
end Letters;

architecture Behavioral of Letters is

begin
process(btn1)
    begin
        if btn1 = '1' then
            letter <= "01100001" ;
        end if;
    end process;

end Behavioral;
