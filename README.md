# Smart-Digital-Lock-System
A VHDL-based smart security lock system with a 4x4 matrix keypad interface and 7-segment display feedback.
# Smart Digital Lock System Using VHDL

An FPGA-ready digital security lock system implemented in VHDL.

## Features
* **4-Digit Keypad Access:** Decodes a 4x4 matrix keypad input.
* **FSM Control Logic:** Validates predefined serial code sequential logic (`1-2-3-4`).
* **Visual Status Output:** Utilizes a 7-segment display to indicate states: `L` (Locked), `U` (Unlocked), and `E` (Error).
* **Security Alarm:** Triggers a locked security state (`ST_ALARM_STATE`) if 3 consecutive incorrect entry attempts occur.
* **Master Reset:** High-priority physical button override to restore the default locked state.

## Implementation Details
1. `keypad_decoder.vhd`: Scans matrix columns and reads row pins.
2. `digital_lock_fsm.vhd`: Processes sequence transitions and validation metrics.
3. `display_7seg.vhd`: Outputs character glyphs depending on system states.
4. `top_level.vhd`: Connects sub-modules and maps signals to hardware pins.
