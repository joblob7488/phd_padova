----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.11.2024 11:46:49
-- Design Name: 
-- Module Name: UART_Transmitter - Behavioral
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

entity UART_Transmitter is
Port ( 
    clk : in std_logic;
    busy : out std_logic;
    data_valid : in std_logic; 
    data : in std_logic_vector(7 downto 0);
    TX : out std_logic
    );
end UART_Transmitter;

architecture Structural of UART_Transmitter is

signal Baudrate : std_logic := '0';

component TX_State_Machine
    Port (
    clk : in std_logic;
    busy : out std_logic;
    data_valid : in std_logic; 
    data : in std_logic_vector(7 downto 0);
    TX : out std_logic;
    baudrate : in std_logic
    );
end component;

component Baud_rate_generator
    Port (
    clk : in std_logic;
    baudrate : out std_logic
    );
end component;

begin
    FSM : TX_State_Machine 
        port map(
            clk => clk,
            busy => Busy,
            data_valid => data_valid, 
            data => data,
            TX => TX,
            baudrate => baudrate
        );
       
   Counter : Baud_rate_generator
        port map(
            clk => clk,
            baudrate => baudrate
        );
            
end Structural;
