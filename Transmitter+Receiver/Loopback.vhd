----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.01.2025 16:44:02
-- Design Name: 
-- Module Name: Loopback - Structural
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

entity Loopback is
    Port (
        clk : in std_logic;
        RX : in std_logic;
        TX : out std_logic
         );
end Loopback;

architecture Structural of Loopback is

signal data : std_logic_vector(7 downto 0);
signal data_valid   : std_logic;
signal busy         : std_logic;

component UART_Receiver is
    Port (
        RX :  in std_logic;
        data : out std_logic_vector(7 downto 0);
        data_valid : out std_logic;
        clk : in std_logic
    );
end component;

component UART_Transmitter is
    Port (
        TX : out std_logic;
        busy : out std_logic;
        data : in std_logic_vector(7 downto 0);
        data_valid : in std_logic;
        clk : in std_logic
    );
end component;
begin

Transmitter : UART_Transmitter
    port map (
        TX => TX,
        busy => busy,
        data_valid => data_valid,
        data => data,
        clk => clk
    );
    
Receiver : UART_Receiver
    port map (
        RX => RX,
        data => data,
        data_valid => data_valid,
        clk => clk
    );
    
end Structural;
