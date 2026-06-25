# Smart-Digital-Lock-System
A VHDL-based smart security lock system with a 4x4 matrix keypad interface and 7-segment display feedback.
# Smart Digital Lock System using VHDL

A hardware-level finite state machine realization of an embedded smart digital key-lock system engineered in VHDL for deployment on FPGA systems.

## Features
* **Matrix Keypad Interface**: Scanning matrix architecture processing digital hex character entries.
* **FSM Control Architecture**: Features structural operational processing states: `IDLE`, `ENTER_CODE`, `UNLOCKED`, and `ALARM_STATE`.
* **Security Lock-Out/Alert**: Exceeding 3 incorrect credential code trials invokes the Lockout Alarm State, rendering the device unresponsive until a Master Hardware Reset is issued.
* **Status Readout System**: Links status reports directly to a Multiplexed 7-Segment configuration segment.

## Pin Configuration Mapping Setup
* Preset Default Entry Code PIN: `1` -> `2` -> `3` -> `4`
* Exit State Lock Sequence Trigger Key: `#`
