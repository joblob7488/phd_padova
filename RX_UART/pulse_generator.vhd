library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pulse_generator is
    port ( 
    Clk : in std_logic;
    enable : in std_logic;
    pulse : out std_logic
    );
end pulse_generator;

architecture Behavioral of pulse_generator is
signal count : unsigned (9 downto 0) :=(others=>'0');

begin
process(Clk)
begin
    if rising_edge(Clk) then
        if enable = '1' then
            if count = "1101100100" then
                pulse <= '1';
                count <= "0000000000";
            else
                count <= count + 1;
                pulse <= '0';
            end if;
        else
            count <= "0000000000";
        end if;
    end if;
end process;

end Behavioral;
