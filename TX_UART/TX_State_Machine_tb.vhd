library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity TX_State_Machine_tb is
-- No ports for a testbench
end TX_State_Machine_tb;

architecture Behavioral of TX_State_Machine_tb is

    -- Signals to connect to the DUT (Device Under Test)
    signal Clk         : std_logic := '0';
    signal Busy        : std_logic;
    signal Data_valid  : std_logic := '0';
    signal Data        : std_logic_vector(7 downto 0) := (others => '0');
    signal Tx          : std_logic;
    signal Baudrate    : std_logic := '0';
    signal Rst         : std_logic := '0';

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the UART Transmitter State Machine (DUT)
    DUT: entity work.TX_State_Machine
    port map (
        Clk => Clk,
        Busy => Busy,
        Data_valid => Data_valid,
        Data => Data,
        Tx => Tx,
        Baudrate => Baudrate,
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
            wait for 8 * clk_period;  -- Baudrate signal stays high for 8 clock cycles
            Baudrate <= '1';
            wait for clk_period;      -- Baudrate signal stays low for 1 clock cycle
        end loop;
    end process;

    -- Test process
    stim_proc: process
    begin
        -- Reset the system
        Rst <= '1';
        wait for 2 * clk_period;
        Rst <= '0';
        
        -- Wait for idle state
        wait for 20 * clk_period;

        -- Apply first test vector
        Data <= "11010101";  -- 8-bit data to transmit
        Data_valid <= '1';    -- Assert Data_valid
        wait for clk_period;  -- Wait one clock cycle for the state machine to capture Data_valid
        Data_valid <= '0';    -- Deassert Data_valid after one clock cycle
        
        -- Wait for transmission to complete (80 clock periods for 1 byte transmission)
        wait for 80 * clk_period;

       
        -- Finish simulation
        wait;
    end process;

end Behavioral;


