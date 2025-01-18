library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pulse_generator_tb is
-- Testbench has no ports
end pulse_generator_tb;

architecture Behavioral of pulse_generator_tb is
    -- Component declaration for the Unit Under Test (UUT)
    component pulse_generator is
        port (
            Clk : in std_logic;
            enable : in std_logic;
            pulse : out std_logic
        );
    end component;

    -- Signals to connect to UUT
    signal Clk : std_logic := '0';
    signal enable : std_logic := '0';
    signal pulse : std_logic;

    -- Clock period
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: pulse_generator port map (
        Clk => Clk,
        enable => enable,
        pulse => pulse
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

    -- Stimulus process
    Stimulus_process: process
    begin
        -- Initial delay with enable low
        wait for 20 * clk_period;

        -- Enable the pulse generator
        enable <= '1';

        -- Wait to observe the pulse after 868 clock cycles
        wait for 900 * clk_period;

        -- Disable the pulse generator
        enable <= '0';

        -- Wait to observe reset behavior
        wait for 50 * clk_period;

        -- Enable again for another cycle
        enable <= '1';
        wait for 900 * clk_period;

        -- End simulation
        wait;
    end process;
end Behavioral;