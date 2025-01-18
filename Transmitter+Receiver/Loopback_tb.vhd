----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.01.2025 09:55:07
-- Design Name: 
-- Module Name: Loopback_tb - Behavioral
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

entity Loopback_tb is
--  Port ( );
end Loopback_tb;

architecture Behavioral of Loopback_tb is

-- Signals to connect to the DUT (Device Under Test)
    signal clk         : std_logic := '0';
    signal TX          : std_logic;
    signal RX          : std_logic;
    signal data_valid  : std_logic;
    
    -- Clock period definition
    constant clk_period : time := 10 ns;
    constant baudrate : integer := 115200;
    constant baudrate_period : time := 1 sec / baudrate;
    constant data_to_send : std_logic_vector(7 downto 0) := "01101001";

begin
    DUT: entity work.Loopback
    port map (
        clk => clk,
        TX => TX,
        RX => RX       
    );
    
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
   end process;
   
   receive_process : process
   begin
        wait for 20 * clk_period;
        RX <= '1';
        wait for baudrate_period;
        RX <= '0';
        wait for baudrate_period;
        RX <= data_to_send(1);
        wait for baudrate_period;
        RX <= data_to_send(2);
        wait for baudrate_period;
        RX <= data_to_send(3);
        wait for baudrate_period;
        RX <= data_to_send(4);
        wait for baudrate_period;
        RX <= data_to_send(5);
        wait for baudrate_period;
        RX <= data_to_send(6);
        wait for baudrate_period;
        RX <= data_to_send(7);
        wait for baudrate_period; 
        RX <= '0';
        wait for baudrate_period; 
        wait for 20 * clk_period;
  end process; 
  
end Behavioral;
