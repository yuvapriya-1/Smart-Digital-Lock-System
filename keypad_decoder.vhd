library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity keypad_decoder is
    Port ( clk     : in  STD_LOGIC;
           rows    : in  STD_LOGIC_VECTOR (3 downto 0);
           cols    : out STD_LOGIC_VECTOR (3 downto 0);
           key_out : out STD_LOGIC_VECTOR (3 downto 0);
           key_pressed : out STD_LOGIC);
end keypad_decoder;

architecture Behavioral of keypad_decoder is
    signal clk_div : unsigned(15 downto 0) := (others => '0');
    signal col_state : unsigned(1 downto 0) := "00";
begin
    -- Simple clock divider for scanning debouncing
    process(clk)
    begin
        if rising_edge(clk) then
            clk_div <= clk_div + 1;
        end if;
    end process;

    -- Scan columns
    process(clk_div(15))
    begin
        if rising_edge(clk_div(15)) then
            col_state <= col_state + 1;
        end if;
    end process;

    process(col_state, rows)
    begin
        cols <= "1111";
        key_out <= "0000";
        key_pressed <= '0';
        
        case col_state is
            when "00" => cols <= "1110"; -- Scan Col 0
                if rows(0) = '0' then key_out <= x"1"; key_pressed <= '1';
                elsif rows(1) = '0' then key_out <= x"4"; key_pressed <= '1';
                elsif rows(2) = '0' then key_out <= x"7"; key_pressed <= '1';
                elsif rows(3) = '0' then key_out <= x"A"; key_pressed <= '1'; end if;
            when "01" => cols <= "1101"; -- Scan Col 1
                if rows(0) = '0' then key_out <= x"2"; key_pressed <= '1';
                elsif rows(1) = '0' then key_out <= x"5"; key_pressed <= '1';
                elsif rows(2) = '0' then key_out <= x"8"; key_pressed <= '1';
                elsif rows(3) = '0' then key_out <= x"0"; key_pressed <= '1'; end if;
            when "10" => cols <= "1011"; -- Scan Col 2
                if rows(0) = '0' then key_out <= x"3"; key_pressed <= '1';
                elsif rows(1) = '0' then key_out <= x"6"; key_pressed <= '1';
                elsif rows(2) = '0' then key_out <= x"9"; key_pressed <= '1';
                elsif rows(3) = '0' then key_out <= x"B"; key_pressed <= '1'; end if;
            when others => cols <= "0111"; -- Scan Col 3
                if rows(0) = '0' then key_out <= x"C"; key_pressed <= '1';
                elsif rows(1) = '0' then key_out <= x"D"; key_pressed <= '1';
                elsif rows(2) = '0' then key_out <= x"E"; key_pressed <= '1';
                elsif rows(3) = '0' then key_out <= x"F"; key_pressed <= '1'; end if;
        end case;
    end process;
end Behavioral;
