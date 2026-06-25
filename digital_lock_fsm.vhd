library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity digital_lock_fsm is
    Port ( clk          : in  STD_LOGIC;
           reset        : in  STD_LOGIC; -- Master Reset
           key_in       : in  STD_LOGIC_VECTOR (3 downto 0);
           key_valid    : in  STD_LOGIC;
           lock_status  : out STD_LOGIC_VECTOR (1 downto 0); -- 00=L, 01=U, 10=E
           alarm        : out STD_LOGIC);
end digital_lock_fsm;

architecture Behavioral of digital_lock_fsm is
    type state_type is (ST_LOCKED, ST_DIGIT1, ST_DIGIT2, ST_DIGIT3, ST_UNLOCKED, ST_ALARM_STATE);
    signal current_state, next_state : state_type := ST_LOCKED;
    signal wrong_attempts : unsigned(1 downto 0) := "00";
    signal key_pressed_prev : std_logic := '0';
begin

    process(clk, reset)
    begin
        if reset = '1' then
            current_state <= ST_LOCKED;
            wrong_attempts <= "00";
        elsif rising_edge(clk) then
            key_pressed_prev <= key_valid;
            
            -- Detect rising edge of key press
            if key_valid = '1' and key_pressed_prev = '0' then
                case current_state is
                    when ST_LOCKED =>
                        if key_in = x"1" then current_state <= ST_DIGIT1;
                        else wrong_attempts <= wrong_attempts + 1; end if;
                        
                    when ST_DIGIT1 =>
                        if key_in = x"2" then current_state <= ST_DIGIT2;
                        else current_state <= ST_LOCKED; wrong_attempts <= wrong_attempts + 1; end if;
                        
                    when ST_DIGIT2 =>
                        if key_in = x"3" then current_state <= ST_DIGIT3;
                        else current_state <= ST_LOCKED; wrong_attempts <= wrong_attempts + 1; end if;
                        
                    when ST_DIGIT3 =>
                        if key_in = x"4" then 
                            current_state <= ST_UNLOCKED;
                            wrong_attempts <= "00";
                        else 
                            current_state <= ST_LOCKED; 
                            wrong_attempts <= wrong_attempts + 1; 
                        end if;
                        
                    when ST_UNLOCKED =>
                        if key_in = x"C" then current_state <= ST_LOCKED; end if; -- 'C' to clear/relock
                        
                    when others => null;
                end case;
            end if;

            -- Trigger alarm if wrong attempts exceed 3
            if wrong_attempts >= "11" then
                current_state <= ST_ALARM_STATE;
            end if;
        end if;
    end process;

    -- Output Assignment
    process(current_state)
    begin
        alarm <= '0';
        lock_status <= "00";
        case current_state is
            when ST_LOCKED => lock_status <= "00";
            when ST_UNLOCKED => lock_status <= "01";
            when ST_ALARM_STATE => lock_status <= "10"; alarm <= '1';
            when others => lock_status <= "00";
        end case;
    end process;
end Behavioral;
