library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top_level is
-- Testbenches do not have ports
end tb_top_level;

architecture Behavioral of tb_top_level is
    -- Signals to connect to the Device Under Test (DUT)
    signal clk        : std_logic := '0';
    signal master_rst : std_logic := '0';
    signal row_pins   : std_logic_vector(3 downto 0) := "1111";
    signal col_pins   : std_logic_vector(3 downto 0);
    signal segments   : std_logic_vector(6 downto 0);
    signal alarm_led  : std_logic;

    constant clk_period : time := 20 ns; -- 50 MHz simulation clock
begin

    -- Instantiate the Top Level Design
    DUT: entity work.top_level
        port map (
            clk        => clk,
            master_rst => master_rst,
            row_pins   => row_pins,
            col_pins   => col_pins,
            segments   => segments,
            alarm_led  => alarm_led
        );

    -- Clock Generation Process
    clk_process : process
    begin
        while true loop
            clk <= '0'; wait for clk_period/2;
            clk <= '1'; wait for clk_period/2;
        end loop;
    end process;

    -- Stimulus Process to simulate user actions
    stim_proc: process
    begin		
        -- Step 1: Apply System Reset
        master_rst <= '1';
        wait for 100 ns;
        master_rst <= '0';
        wait for 100 ns;

        -- Step 2: Simulate pressing correct password sequence: 1 -> 2 -> 3 -> 4
        
        -- Press Key '1'
        row_pins <= "1110"; wait for 2 ms; 
        row_pins <= "1111"; wait for 2 ms; -- Release
        
        -- Press Key '2'
        row_pins <= "1110"; wait for 2 ms;
        row_pins <= "1111"; wait for 2 ms; -- Release
        
        -- Press Key '3'
        row_pins <= "1110"; wait for 2 ms;
        row_pins <= "1111"; wait for 2 ms; -- Release
        
        -- Press Key '4'
        row_pins <= "1101"; wait for 2 ms;
        row_pins <= "1111"; wait for 2 ms; -- Release

        -- Wait to observe Unlocked state ('U')
        wait for 10 ms;

        wait;
    end process;

end Behavioral;
