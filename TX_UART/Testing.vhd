----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2024 17:19:33
-- Design Name: 
-- Module Name: Testing - Structural
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

entity Testing is
    Port ( 
    Clk : in std_logic;
    Busy : out std_logic;
    Btn1 : in std_logic;
    TX : out std_logic;
    Btn2: in std_logic
    );
end Testing;

architecture Structural of Testing is
component UART_Transmitter
    Port (
    Clk : in std_logic;
    Busy : out std_logic;
    Btn2 : in std_logic; 
    Data : in std_logic_vector(7 downto 0);
    TX : out std_logic
    );
end component;

component Letters
    Port (
    Btn1 : in std_logic; 
    Letter : out std_logic_vector(7 downto 0)
    );
end component;

signal Data : std_logic_vector(7 downto 0);
begin
    UART : UART_Transmitter 
        port map(
            Clk => Clk,
            Busy => Busy,
            Btn2 => Btn2, 
            Data => Data,
            TX => TX
        );
       
     L : Letters
        port map(
            Btn1 => Btn1, 
            Letter => Data
        );

end Structural;
