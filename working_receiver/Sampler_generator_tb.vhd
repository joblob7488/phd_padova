library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Sampler_generator_tb is
end Sampler_generator_tb;

architecture Behavioral of Sampler_generator_tb is
    -- Component Declaration
    component Sampler_generator
        port(
            Clk : in std_logic;
            Rx : in std_logic;
            Baudrate_out : out std_logic
        );
    end component;

    -- Signals
    signal Clk : std_logic := '0';
    signal Rx : std_logic := '1';
    signal Baudrate_out : std_logic;

    -- Clock period constant
    constant CLK_PERIOD : time := 10 ns; -- 100 MHz clock
    constant RX_BIT_PERIOD : integer := 868; -- Cycles for baudrate
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Sampler_generator
        port map(
            Clk => Clk,
            Rx => Rx,
            Baudrate_out => Baudrate_out
        );

    -- Clock Generation
    clk_process : process
    begin
        while true loop
            Clk <= '0';
            wait for CLK_PERIOD / 2;
            Clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
    end process;

    -- Rx Signal Generation
    rx_process : process
    begin
        -- Idle state (Rx high)
        wait for 20 * CLK_PERIOD;

        -- Start bit (Rx low)
        Rx <= '0';
        wait for RX_BIT_PERIOD * CLK_PERIOD;

        -- Transmit 8 data bits (example pattern: 10101101)
        for i in 0 to 7 loop
            if i = 0 or i = 2 or i = 4 or i = 7 then
                Rx <= '1'; -- Bits: 10101101
            else
                Rx <= '0';
            end if;
            wait for RX_BIT_PERIOD * CLK_PERIOD;
        end loop;

        -- Stop bit (Rx high)
        Rx <= '1';
        wait for RX_BIT_PERIOD * CLK_PERIOD;

        -- End simulation
        wait;
    end process;

    -- Monitor Outputs
    monitor_process : process
    begin
        while true loop
            wait on Clk;
            report "Time: " & time'image(now) &
                   " Baudrate_out: " & std_logic'image(Baudrate_out) &
                   " Rx: " & std_logic'image(Rx);
        end loop;
    end process;
end Behavioral;
