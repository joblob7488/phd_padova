library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UART_Receiver is
    port ( 
    Clk : in std_logic;
    Rx : in std_logic;
    Data_valid : out std_logic;
    Data : out std_logic_vector(7 downto 0)
    );
end UART_Receiver;

architecture Behavioral of UART_Receiver is
signal Baudrate_out : std_logic := '0';

component Sampler_generator
    port(
    Clk : in std_logic;
    Rx : in std_logic;
    Baudrate_out : out std_logic
    );    
end component;

component RX_State_Machine
    port (
    Rx : in std_logic;
    Clk : in std_logic;
    Baudrate_out : in std_logic;
    Data_valid : out std_logic;
    Data : out std_logic_vector(7 downto 0)
    );
end component;

begin
    sampler : Sampler_generator
        port map(
        Clk => Clk,
        Rx => Rx,
        Baudrate_out => Baudrate_out
        );    
    FSM : RX_State_Machine
        port map(
        Rx => Rx,
        Clk => Clk,
        Baudrate_out => Baudrate_out,
        Data_valid => Data_valid,
        Data => Data
        );

end Behavioral;