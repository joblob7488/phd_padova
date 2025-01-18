----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2024 11:26:56
-- Design Name: 
-- Module Name: Baud_rate_generator - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Baud_rate_generator is
    Port ( 
    Clk : in std_logic;
    Baudrate : out std_logic
    );
end Baud_rate_generator;

architecture Behavioral of Baud_rate_generator is
signal count : unsigned (9 downto 0) :=(others=>'0');

begin
process(Clk)
begin
    if rising_edge(Clk) then
        if count = 868 then
            Baudrate <= '1';
            count <= "0000000000";
        else
            count <= count + 1;
            Baudrate <= '0';
        end if;
    end if;
end process;
end Behavioral;
