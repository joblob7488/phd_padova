----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2024 11:36:46
-- Design Name: 
-- Module Name: Baudrate_tb - Behavioral
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

entity Baudrate_tb is
--  Port ( );
end Baudrate_tb;

architecture Behavioral of Baudrate_tb is
signal Clk         : std_logic := '0';
signal Baudrate         : std_logic := '0';

constant clk_period : time := 10 ns;
begin
    DUT: entity work.Baud_rate_generator
        port map (
            Clk => clk,
            Baudrate => Baudrate
        );
        
    clk_process: process
        begin
            while true loop
                Clk <= '0';
                wait for clk_period / 2;
                Clk <= '1';
                wait for clk_period / 2;
            end loop;
        end process;
end Behavioral;
