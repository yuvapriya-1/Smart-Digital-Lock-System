library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display_7seg is
    Port ( status  : in  STD_LOGIC_VECTOR (1 downto 0); -- 00: Locked, 01: Unlocked, 10: Error
           seg_out : out STD_LOGIC_VECTOR (6 downto 0));
end display_7seg;

architecture Behavioral of display_7seg is
begin
    process(status)
    begin
        case status is
            when "00" => seg_out <= "1110001"; -- 'L' for Locked (Active High example)
            when "01" => seg_out <= "1100011"; -- 'U' for Unlocked
            when "10" => seg_out <= "1001111"; -- 'E' for Error
            when others => seg_out <= "0000000";
        end case;
    end process;
end Behavioral;
