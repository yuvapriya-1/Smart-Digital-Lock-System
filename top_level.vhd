library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    Port ( clk       : in  STD_LOGIC;
           master_rst: in  STD_LOGIC;
           row_pins  : in  STD_LOGIC_VECTOR (3 downto 0);
           col_pins  : out STD_LOGIC_VECTOR (3 downto 0);
           segments  : out STD_LOGIC_VECTOR (6 downto 0);
           alarm_led : out STD_LOGIC);
end top_level;

architecture Structural of top_level is
    signal w_key : std_logic_vector(3 downto 0);
    signal w_valid : std_logic;
    signal w_status : std_logic_vector(1 downto 0);
begin

    KP_DECODER: entity work.keypad_decoder 
        port map(clk => clk, rows => row_pins, cols => col_pins, key_out => w_key, key_pressed => w_valid);

    LOCK_FSM: entity work.digital_lock_fsm 
        port map(clk => clk, reset => master_rst, key_in => w_key, key_valid => w_valid, lock_status => w_status, alarm => alarm_led);

    DISPLAY: entity work.display_7seg 
        port map(status => w_status, seg_out => segments);

end Structural;
