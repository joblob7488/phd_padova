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
    Clk : in std_logic;
    Busy : out std_logic;
    Btn2 : in std_logic; 
    Data : in std_logic_vector(7 downto 0);
    TX : out std_logic
    );
end UART_Transmitter;

architecture Structural of UART_Transmitter is

component TX_State_Machine
    Port (
    Clk : in std_logic;
    Busy : out std_logic;
    Data_valid : in std_logic; 
    Data : in std_logic_vector(7 downto 0);
    TX : out std_logic;
    Baudrate : in std_logic
    );
end component;

component Baud_rate_generator
    Port (
    Clk : in std_logic;
    Baudrate : out std_logic
    );
end component;

component Edge_detector 
    Port (
    Clk : in std_logic ; 
    Btn2 : in std_logic ;
    Data_valid : out std_logic
    );
end component;

signal Baudrate : std_logic := '0';
signal Data_valid : std_logic ;

begin
    FSM : TX_State_Machine 
        port map(
            Clk => Clk,
            Busy => Busy,
            Data_valid => Data_valid, 
            Data => Data,
            TX => TX,
            Baudrate => Baudrate
        );
       
     Counter : Baud_rate_generator
        port map(
            Clk => Clk,
            Baudrate => Baudrate
        );
     EdgeDetector : Edge_detector
        port map(
            Clk => Clk,
            Btn2 => Btn2,
            Data_valid => Data_valid
            );
            
end Structural;
