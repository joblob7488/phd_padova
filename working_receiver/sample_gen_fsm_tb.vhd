library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sample_gen_fsm_tb is
-- Testbench has no ports
end sample_gen_fsm_tb;

architecture Behavioral of sample_gen_fsm_tb is
    -- Component declaration for the Unit Under Test (UUT)
    component sample_gen_fsm is
        port (
            Clk : in std_logic;
            Rx : in std_logic;
            pulse : in std_logic;
            enable : out std_logic
        );
    end component;

    -- Signals to connect to UUT
    signal Clk : std_logic := '0';
    signal Rx : std_logic := '1';       -- Default idle line
    signal pulse : std_logic := '0';
    signal enable : std_logic;

    -- Clock period
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: sample_gen_fsm port map (
        Clk => Clk,
        Rx => Rx,
        pulse => pulse,
        enable => enable
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
        -- Step 1: Default idle state
        wait for 20 ns;

        -- Step 2: Simulate a start condition (Rx goes low)
        Rx <= '0';
        wait for clk_period; -- Wait for one clock cycle
        pulse <= '1';
        wait for clk_period;
        pulse <= '0';

        -- Step 3: Simulate transitions through the states
        wait for clk_period;
        for i in 0 to 9 loop
            pulse <= '1';
            wait for clk_period;
            pulse <= '0';
            wait for clk_period;
        end loop;

        -- Step 4: Return to idle state (Rx high)
        Rx <= '1';
        wait for 20 ns;

        -- End simulation
        wait;
    end process;
end Behavioral;