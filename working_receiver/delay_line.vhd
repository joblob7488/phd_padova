library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity delay_line is
    port ( 
    Clk : in std_logic;
    pulse : in std_logic;
    Baudrate_out : out std_logic
    );
end delay_line;

architecture Behavioral of delay_line is
type state_t is (idle, delaying, high);
signal state : state_t := idle;
signal count : unsigned(8 downto 0) := (others => '0');


begin
    process(Clk) is
    begin
        if rising_edge(Clk) then
            case state is
                when idle =>
                    Baudrate_out <= '0';
                    if pulse = '1' then
                        state <= delaying;
                    end if;
                when delaying =>
                    if count = "110110010" then
                        Baudrate_out <= '1';
                        count <= "000000000";
                        state <= high;
                    else
                        count <= count + 1;
                    end if;
                when high =>
                    Baudrate_out <= '0';
                    state <= idle;            
            end case; 
        end if;
    end process;

end Behavioral;