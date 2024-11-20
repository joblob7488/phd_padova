----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.11.2024 15:32:08
-- Design Name: 
-- Module Name: RX_State_Machine_tb - Behavioral
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

entity RX_State_Machine_tb is
--  Port ( );
end RX_State_Machine_tb;

architecture Behavioral of RX_State_Machine_tb is
    signal Clk         : std_logic := '0';
    signal Data_valid  : std_logic := '0';
    signal Data        : std_logic_vector(7 downto 0) := (others => '0');
    signal RX : std_logic := '0';
    signal Baudrate    : std_logic := '0';

    -- Clock period definition
    constant clk_period : time := 10 ns;
    constant RX_input : std_logic_vector(7 downto 0) := "11100101";
begin
-- Instantiate the UART Transmitter State Machine (DUT)
    DUT: entity work.RX_State_Machine
    port map (
        Clk => Clk,
        Data_valid => Data_valid,
        Data => Data,
        RX => RX,
        Baudrate => Baudrate
    );

    -- Clock generation process
    clk_process: process
    begin
        while true loop
            Clk <= '0';
            wait for clk_period / 2;
            Clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Baudrate simulation process
    baudrate_process: process
    begin
        while true loop
            Baudrate <= '0';
            wait for 7 * clk_period;  -- Baudrate signal stays high for 8 clock cycles
            Baudrate <= '1';
            wait for clk_period;      -- Baudrate signal stays low for 1 clock cycle
        end loop;
    end process;
    
    stim_proc: process
    begin
        -- Simulate data reception (start bit + 8 data bits + stop bit)
        
        RX <= '0'; -- Start bit
        wait for Clk_Period * 8;

        for i in 0 to 7 loop
            wait for 8*clk_period ; 
            RX <= RX_input(i);
        end loop;
        
        RX <= '1';
        wait for Clk_Period * 8;
        wait for Clk_Period * 10;
        
    end process;

end Behavioral;
