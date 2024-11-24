library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity receiver_and_led is
  port (
    Clk         : in  std_logic;
    Rx       : in  std_logic;
    led         : out std_logic
    );
end receiver_and_led;

architecture Behavioral of receiver_and_led is

signal Data_valid : std_logic := '0';
signal Data : std_logic_vector (7 downto 0) := (others=>'0');

signal led_cnt_start : std_logic;
signal led_cnt : unsigned(31 downto 0);

component UART_Receiver
    port(
    Clk : in std_logic;
    Rx : in std_logic;
    Data_valid : out std_logic;
    Data : out std_logic_vector(7 downto 0)
    );
end component;

begin
receiver : UART_Receiver
    port map(
    Clk => Clk,
    Rx => Rx,
    Data_valid => Data_valid,
    Data => Data
    );

process(Clk) is
begin
    if rising_edge(Clk) then 
        
        if Data_valid = '1' and Data = x"61" then
            led_cnt_start <= '1';
        else
            led_cnt_start <= '0';
        end if;
        
        if led_cnt_start = '1' then
            led_cnt <= (others=>'0');
            led <= '0';
        elsif led_cnt < 2**26 then    
            led_cnt <= led_cnt + 1;
            led <= '1';
        else
            led_cnt <= led_cnt;
            led <= '0';
        end if;        
               
    end if;
end process;

end Behavioral;
