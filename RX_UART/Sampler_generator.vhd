library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Sampler_generator is
    port(
    Clk : in std_logic;
    Rx : in std_logic;
    Baudrate_out : out std_logic
    );
end Sampler_generator;


architecture Behavioral of Sampler_generator is

component sample_gen_fsm
    port (
    Clk : in std_logic;
    Rx : in std_logic;
    pulse : in std_logic;
    enable : out std_logic    
    );
end component;

component pulse_generator
    port (
    Clk : in std_logic;
    enable : in std_logic;
    pulse : out std_logic
    );
end component;

component delay_line
    port (
    Clk : in std_logic;
    pulse : in std_logic;
    Baudrate_out : out std_logic
    );
end component;

signal pulse : std_logic := '0';
signal enable : std_logic := '0';

begin
    FSM : sample_gen_fsm
        port map (
            Clk => Clk,
            Rx => Rx,
            pulse => pulse,
            enable => enable
        );
    pgen : pulse_generator
        port map (
            Clk => Clk,
            enable => enable,
            pulse => pulse
        );
    delay : delay_line
        port map (
            Clk => Clk,
            pulse => pulse,
            Baudrate_out => Baudrate_out
        );
end Behavioral;