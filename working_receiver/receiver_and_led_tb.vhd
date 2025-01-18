library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity receiver_and_led_tb is
-- Testbench has no ports
end receiver_and_led_tb;

architecture Behavioral of receiver_and_led_tb is

    -- Component declaration for the Unit Under Test (UUT)
    component receiver_and_led
        port(
            Clk : in std_logic;
            Rx : in std_logic;
            led : out std_logic
        );
    end component;

    -- Signals to connect to UUT
    signal Clk : std_logic := '0';
    signal Rx : std_logic := '1'; -- Idle state for UART
    signal led : std_logic;

    -- Clock period
    constant clk_period : time := 10 ns;

    -- Stimulus data
    constant baudrate_cycles : integer := 868; -- Number of clock cycles for one baud rate
    signal data_stream : std_logic_vector(9 downto 0) := "0111110101"; -- Start bit + "10111110" + Stop bit

    -- Helper variables
    signal bit_index : integer := 0;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: receiver_and_led
        port map(
            Clk => Clk,
            Rx => Rx,
            led => led
        );

    -- Clock generation process
    Clk_process: process
    begin
        while true loop
            Clk <= '0';
            wait for clk_period / 2;
            Clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Rx signal generation process
    Rx_process: process
    begin
        -- Wait for a short delay before starting
        wait for 20 * clk_period;

        -- Transmit the data bits one at a time
        for i in 0 to 9 loop
            Rx <= data_stream(i);
            wait for baudrate_cycles * clk_period;
        end loop;

        -- Hold Rx high (idle) after transmission
        Rx <= '1';
        wait;

    end process;

    -- Simulation process
    Simulation_process: process
    begin
        -- Wait for the simulation to observe behavior
        wait for 5 ms;

        -- End simulation
        assert false report "Simulation Complete" severity note;
        wait;
    end process;

end Behavioral;
