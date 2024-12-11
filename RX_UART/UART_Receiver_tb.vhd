library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UART_Receiver_tb is
end UART_Receiver_tb;

architecture Behavioral of UART_Receiver_tb is

    -- Component declaration for the unit under test (UUT)
    component UART_Receiver
        port (
            Clk : in std_logic;
            Rx : in std_logic;
            Data_valid : out std_logic;
            Data : out std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals for the testbench
    signal Clk : std_logic := '0';  -- Clock signal
    signal Rx : std_logic := '1';   -- UART input signal (idle high)
    signal Data_valid : std_logic;  -- Output signal indicating data validity
    signal Data : std_logic_vector(7 downto 0);  -- The received data

    -- Clock process for generating the clock signal
    constant Clk_period : time := 10 ns;  -- Clock period (100 MHz)
    constant Baudrate_period : time := 8680 ns; -- Baud rate period (868 clock cycles)

begin

    -- Generate clock signal
    clock: process
    begin
        while true loop
            Clk <= not Clk;
            wait for Clk_period / 2;
        end loop;
    end process;

    -- Instantiate the Unit Under Test (UUT)
    uut : UART_Receiver
        port map (
            Clk => Clk,
            Rx => Rx,
            Data_valid => Data_valid,
            Data => Data
        );

    -- Test stimulus process
    stimulus: process
    begin
        -- Wait for some time before starting the test
        wait for 20 * Clk_period;

        -- First UART frame transmission
        -- Start bit
        Rx <= '0';
        wait for Baudrate_period;

        -- Data bits (e.g., 10101010)
        Rx <= '1'; wait for Baudrate_period; -- Bit 0
        Rx <= '0'; wait for Baudrate_period; -- Bit 1
        Rx <= '1'; wait for Baudrate_period; -- Bit 2
        Rx <= '0'; wait for Baudrate_period; -- Bit 3
        Rx <= '1'; wait for Baudrate_period; -- Bit 4
        Rx <= '0'; wait for Baudrate_period; -- Bit 5
        Rx <= '1'; wait for Baudrate_period; -- Bit 6
        Rx <= '1'; wait for Baudrate_period; -- Bit 7

        -- Stop bit
        Rx <= '1';
        wait for Baudrate_period;

        -- Wait for some time between transmissions
        wait for 5 * Baudrate_period;

        -- Second UART frame transmission
        -- Start bit
        Rx <= '0';
        wait for Baudrate_period;

        -- Data bits (same as first frame for simplicity)
        Rx <= '1'; wait for Baudrate_period; -- Bit 0
        Rx <= '0'; wait for Baudrate_period; -- Bit 1
        Rx <= '1'; wait for Baudrate_period; -- Bit 2
        Rx <= '0'; wait for Baudrate_period; -- Bit 3
        Rx <= '1'; wait for Baudrate_period; -- Bit 4
        Rx <= '0'; wait for Baudrate_period; -- Bit 5
        Rx <= '1'; wait for Baudrate_period; -- Bit 6
        Rx <= '1'; wait for Baudrate_period; -- Bit 7

        -- Stop bit
        Rx <= '1';
        wait for Baudrate_period;

        -- Wait for a while to observe results
        wait for 20 * Baudrate_period;

        -- End simulation
        wait;
    end process;

end Behavioral;
