library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity delay_line_tb is
-- Testbench has no ports
end delay_line_tb;

architecture Behavioral of delay_line_tb is
    -- Component declaration for the Unit Under Test (UUT)
    component delay_line is
        port (
            Clk : in std_logic;
            pulse : in std_logic;
            Baudrate_out : out std_logic
        );
    end component;

    -- Signals to connect to UUT
    signal Clk : std_logic := '0';
    signal pulse : std_logic := '0';
    signal Baudrate_out : std_logic;

    -- Clock period
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: delay_line port map (
        Clk => Clk,
        pulse => pulse,
        Baudrate_out => Baudrate_out
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
        -- Initial delay in idle state
        wait for 20 * clk_period;

        -- Send a pulse signal (1 clock cycle)
        pulse <= '1';
        wait for clk_period;
        pulse <= '0';

        -- Wait to observe the delay process
        wait for 500 * clk_period;

        -- Send another pulse signal
        pulse <= '1';
        wait for clk_period;
        pulse <= '0';

        -- Wait to observe the behavior after the second pulse
        wait for 500 * clk_period;

        -- End simulation
        wait;
    end process;
end Behavioral;