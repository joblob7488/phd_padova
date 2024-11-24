library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sampler_generator_tb is
-- Testbench has no ports
end Sampler_generator_tb;

architecture Behavioral of Sampler_generator_tb is
    -- Component declaration for the Unit Under Test (UUT)
    component Sampler_generator is
        port (
            Clk : in std_logic;
            Rx : in std_logic;
            Baudrate_out : out std_logic
        );
    end component;

    -- Signals to connect to UUT
    signal Clk : std_logic := '0';
    signal Rx : std_logic := '1';       -- Default idle line
    signal Baudrate_out : std_logic;

    -- Clock period
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Sampler_generator port map (
        Clk => Clk,
        Rx => Rx,
        Baudrate_out => Baudrate_out
    );

    -- Clock generation
    Clk_process: process
    begin
        while true loop
            Clk <= '0';
            wait for clk_period / 2;
            Clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    Stimulus_process: process
    begin
        -- Initial state: `Rx` is idle (high)
        wait for 20 ns;

        -- Step 1: Simulate start condition by driving `Rx` low
        Rx <= '0';
        wait for 10 * clk_period; -- Simulate for 10 clock cycles

        -- Step 2: Return `Rx` to high (idle)
        Rx <= '1';
        wait for 10 * clk_period;

        -- Step 3: Repeat the start condition
        Rx <= '0';
        wait for 15 * clk_period;
        Rx <= '1';

        -- Observe output for additional cycles
        wait for 50 * clk_period;

        -- End simulation
        wait;
    end process;
end Behavioral;